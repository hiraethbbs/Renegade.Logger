{*******************************************************}

{   Renegade BBS                                        }

{   Copyright (c) 1990-2013 The Renegade Dev Team       }
{   Copyleft  (ↄ) 2016-2017 Renegade BBS                }

{   This file is part of Renegade BBS                   }

{   Renegade is free software: you can redistribute it  }
{   and/or modify it under the terms of the GNU General }
{   Public License as published by the Free Software    }
{   Foundation, either version 3 of the License, or     }
{   (at your option) any later version.                 }

{   Renegade is distributed in the hope that it will be }
{   useful, but WITHOUT ANY WARRANTY; without even the  }
{   implied warranty of MERCHANTABILITY or FITNESS FOR  }
{   A PARTICULAR PURPOSE.  See the GNU General Public   }
{   License for more details.                           }

{   You should have received a copy of the GNU General  }
{   Public License along with Renegade.  If not, see    }
{   <http://www.gnu.org/licenses/>.                     }

{*******************************************************}
{   _______                                  __         }
{  |   _   .-----.-----.-----.-----.---.-.--|  .-----.  }
{  |.  l   |  -__|     |  -__|  _  |  _  |  _  |  -__|  }
{  |.  _   |_____|__|__|_____|___  |___._|_____|_____|  }
{  |:  |   |                 |_____|                    }
{  |::.|:. |                                            }
{  `--- ---'                                            }
{*******************************************************}
{$mode objfpc}
{$codepage utf8}
{$h+}
{$packrecords c}
{ namespace Renegade.Logger }
{ Record Log Handler }
{ This handler just write messages to a pascal record file. }
unit Logger.RecordHandler;

interface

uses
  Classes,
  SysUtils,
  StrUtils,
  DateUtils,
  Logger.HandlerInterface;

type
  TLogRecord = record
    Level: byte;
    Process: longint;
    Identifier: string[255];
    LevelString: string[10];
    Message: string[255];
    Context: string[255];
    LogDateTime: TDateTime;
  end;

  RecordHandler = class(TObject, LoggingHandlerInterface)
  private
    LogIdentifier: UTF8String;
    LogRecord: TLogRecord;
    LogRecordFile: file of TLogRecord;
    function ConvertLogStringToError(LogString: ansistring): byte;
  public
    constructor Create;
    destructor Destroy;
    function Open(Identifier: UTF8String): boolean;
    function Close: boolean;
    function Write(const LogData: UTF8String): boolean;
  end;

implementation

constructor RecordHandler.Create;
begin
  inherited Create;
end;

destructor RecordHandler.Destroy;
begin
  inherited Destroy;
end;

function RecordHandler.Open(Identifier: UTF8String): boolean;
begin
  LogIdentifier := Identifier;
  AssignFile(LogRecordFile, LogIdentifier + '.log');

  {$I-}
  if FileExists(LogIdentifier + '.log') then
  begin
    Reset(LogRecordFile);
  end
  else
  begin
    ReWrite(LogRecordFile);
  end;
  {$I+}
  Seek(LogRecordFile, FileSize(LogRecordFile));
  if IOResult <> 0 then
  begin
    Result := True;
  end
  else
  begin
    Result := False;
  end;

end;

function RecordHandler.Close: boolean;
begin
  System.Close(LogRecordFile);
  Result := True;
end;

function RecordHandler.ConvertLogStringToError(LogString: ansistring): byte;
begin
  case lowerCase(LogString) of
    'emergency': Result := 0;
    'alert': Result := 1;
    'critical': Result := 2;
    'error': Result := 3;
    'warning': Result := 4;
    'notice': Result := 5;
    'info': Result := 6;
    'debug': Result := 7;
    else
      Result := 8;
  end;
end;

function RecordHandler.Write(const LogData: UTF8String): boolean;
var
  LogMessage, LogContext: UTF8String;
  LogLevelString: ansistring;
  Delims: TSysCharSet = ['[', ']'];
  DateTime: TDateTime;
begin

  LogLevelString := ExtractWord(1, LogData, Delims);
  LogContext := ExtractWord(3, LogData, Delims);
  LogMessage := Format('[%S] %S[%D] %S', [DateTimeToStr(Now), LogIdentifier, GetProcessId(), LogData]);
  with LogRecord do
  begin
    Level := ConvertLogStringToError(LogLevelString);
    Identifier := LogIdentifier;
    Process := GetProcessId();
    LevelString := LogLevelString;
    Message := LogMessage;
    Context := LogContext;
    LogDateTime := Now;
  end;
  System.Write(LogRecordFile, LogRecord);
  Result := True;
end;

end.
