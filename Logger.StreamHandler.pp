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
{ namespace Renegade.Logger }
{ StreamHandler Logger Class }
{
  This class should take any TStream decendant and use it to
  write log messages.
}
unit Logger.StreamHandler;

interface

uses
  Classes,
  SysUtils,
  Logger.HandlerInterface;

type
  StreamHandler = class(TObject, LoggingHandlerInterface)
  private
    HandlerStream: TStream;
    StreamIdentifier: UTF8String;
  public
    constructor Create(const Stream: TStream); overload;
    constructor Create(const FileName: UTF8String); overload;
    destructor Destroy; override;
    function Open(Identifier: UTF8String): boolean;
    function Close(): boolean;
    function Write(const LogData: UTF8String): boolean;
  published
  end;

implementation

constructor StreamHandler.Create(const Stream: TStream); overload;
begin
  inherited Create;
  HandlerStream := Stream;
end;

constructor StreamHandler.Create(const FileName: UTF8String); overload;
begin
  inherited Create;
  try
    if FileExists(FileName) then
    begin
      HandlerStream := TFileStream.Create(FileName, fmOpenWrite);
    end
    else
    begin
      HandlerStream := TFileStream.Create(FileName, fmCreate);
    end;
  except
    on e: Exception do
    begin
      Destroy;
      HandlerStream.Free;
    end;
  end;
end;

destructor StreamHandler.Destroy;
begin
  inherited Destroy;
end;

function StreamHandler.Open(Identifier: UTF8String): boolean;
begin
  StreamIdentifier := Identifier;
  Result := True;
end;

function StreamHandler.Close(): boolean;
begin
  // Nothing do be done here.
  Result := True;
end;

function StreamHandler.Write(const LogData: UTF8String): boolean;
var
  LogMessage: UTF8String;
  WrittenBytes: longint;
begin
  LogMessage := Format('%S[%D] %S'#10#13, [StreamIdentifier, GetProcessId(), LogData]);
  HandlerStream.Seek(0, soEnd);
  WrittenBytes := HandlerStream.Write(LogMessage[1], Length(LogMessage));
  Result := (WrittenBytes > 0);
end;

end.
