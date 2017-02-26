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
{$h+}
{$codepage utf8}
{$packrecords c}
{ namespace Renegade.Logger }
{
  Program to read data we wrote to renegade.log
  using Logger.RecordHandler.
}
program LoggerRecordRead;

uses
  SysUtils,
  Classes;

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
var
  LogRecord: TLogRecord;
  FileRecord: file of TLogRecord;
  i: byte;
begin
  if FileExists('renegade.log') then
  begin
    AssignFile(FileRecord, 'renegade.log');

    Reset(FileRecord);

    if IOResult <> 0 then
    begin
      Writeln('Error in opening file.');
      exit;
    end
    else
    begin
      for i := 0 to FileSize(FileRecord) - 1 do
      begin
        Seek(FileRecord, i);
        Read(FileRecord, LogRecord);
        with LogRecord do
        begin
          Writeln('Message ID     : ', i);
          Writeln('Process ID     : ', Process);
          Writeln('Message        : ', Message);
          Writeln('Log Level      : ', Level);
          Writeln('Level String   : ', LevelString);
          Writeln('Datetime       : ', DateTimeToStr(LogDateTime));
          Writeln('Log Identifier : ', Identifier);
          Writeln('Log Context    : ', Context, #10#13);
        end;
      end;
    end;
    Close(FileRecord);
  end
  else
  begin
    Writeln('File doesn''t exist');
    exit;
  end;
end.
