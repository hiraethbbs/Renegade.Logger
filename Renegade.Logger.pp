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
{ The Renegade logger class }
{
  This takes a HandlerInterface object to create the method of
  writing logs. Inspiration was taken from the php psr/3 LoggerInterface.
  @link https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-3-logger-interface.md
}
unit Renegade.Logger;

interface

uses
  Classes,
  SysUtils,
  FPJson,
  Logger.HandlerInterface,
  Logger.LoggerInterface,
  Logger.AbstractLogger;


type
  RTLogger = class(AbstractLogger, LoggerInterface)
  public
    constructor Create(Handler: LoggingHandlerInterface);
    procedure Log(LogLevel: LogLevels; Message: UTF8String;
      Context: array of const); override;
  end;

implementation

constructor RTLogger.Create(Handler: LoggingHandlerInterface);
begin
  LoggingHandler := Handler;
end;

procedure RTLogger.Log(LogLevel: LogLevels; Message: UTF8String;
  Context: array of const);
var
  JsonObject, JsonObjectContext: TJsonObject;
  JsonArray: TJsonArray;
  Formatted: UTF8String;
begin

  if Length(Context) <> 0 then
  begin
    try
      JsonObjectContext := TJsonObject.Create(Context);
      JsonObject := TJsonObject.Create();
      JsonArray := TJsonArray.Create();
      JsonArray.Add(JsonObjectContext);
      JsonObject.Add('Context', JsonObjectContext);
      JsonObject.CompressedJSON := True;
    except
      On e: Exception do
      begin
        FreeAndNil(self);
      end;
    end;
  end;
  LoggingHandler.Open('renegade');
  if Length(Context) <> 0 then
  begin
    Formatted := Format('[%s] %s [%s]', [ConvertLogErrorToString(LogLevel),
      Message, JsonObject.AsJSON]);
    LoggingHandler.Write(Formatted);
  end
  else
  begin
    Formatted := Format('[%s] %s', [ConvertLogErrorToString(LogLevel), Message]);

    LoggingHandler.Write(Formatted);
  end;
  LoggingHandler.Close();
end;

end.
