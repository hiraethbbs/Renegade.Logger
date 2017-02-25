{*******************************************************}
{                                                       }
{   Renegade BBS                                        }
{                                                       }
{   Copyright (c) 1990-2013 The Renegade Dev Team       }
{   Copyleft  (ↄ) 2016-2017 Renegade BBS                }
{                                                       }
{   This file is part of Renegade BBS                   }
{                                                       }
{   Renegade is free software: you can redistribute it  }
{   and/or modify it under the terms of the GNU General }
{   Public License as published by the Free Software    }
{   Foundation, either version 3 of the License, or     }
{   (at your option) any later version.                 }
{                                                       }
{   Renegade is distributed in the hope that it will be }
{   useful, but WITHOUT ANY WARRANTY; without even the  }
{   implied warranty of MERCHANTABILITY or FITNESS FOR  }
{   A PARTICULAR PURPOSE.  See the GNU General Public   }
{   License for more details.                           }
{                                                       }
{   You should have received a copy of the GNU General  }
{   Public License along with Renegade.  If not, see    }
{   <http://www.gnu.org/licenses/>.                     }
{                                                       }
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
Unit Logger.LoggerTrait;

interface

uses
    Classes,
    SysUtils,
    Math,
    Logger.LoggerInterface,
    Logger.HandlerInterface,
    Logger.SysLogHandler;

Type LoggerTrait = class(TObject, LoggerInterface)
  Private
    FLoggingHandler : LoggingHandlerInterface;
    procedure SetHandler( LoggingHandler : LoggingHandlerInterface );
  Public
    constructor Create(LoggingHandler : LoggingHandlerInterface);
    destructor Destroy; override;
    procedure Emergency(Message : UTF8String; Context : array of const);
    procedure Alert(Message : UTF8String; Context : array of const);
    procedure Critical(Message : UTF8String; Context : array of const);
    procedure Error(Message : UTF8String; Context : array of const);
    procedure Warning(Message : UTF8String; Context : array of const);
    procedure Notice(Message : UTF8String; Context : array of const);
    procedure Info(Message : UTF8String; Context : array of const);
    procedure Debug(Message : UTF8String; Context : array of const);
    function ConvertLogErrorToString(LogLevel : LogLevels) : AnsiString;
    procedure Log(LogLevel : LogLevels; Message :UTF8String; Context : array of const);virtual;
  Published
    property LoggingHandler : LoggingHandlerInterface read FLoggingHandler write SetHandler;
end;


implementation
function LoggerTrait.ConvertLogErrorToString(LogLevel : LogLevels) : AnsiString;
begin
 Case LogLevel of
      LOG_EMERG   : Result := 'Emergency';
      LOG_ALERT   : Result := 'Alert';
      LOG_CRIT    : Result := 'Critical';
      LOG_ERR     : Result := 'Error';
      LOG_WARNING : Result := 'Warning';
      LOG_NOTICE  : Result := 'Notice';
      LOG_INFO    : Result := 'Info';
      LOG_DEBUG   : Result := 'Debug';
 end;
end;

procedure LoggerTrait.SetHandler( LoggingHandler : LoggingHandlerInterface );
begin
  FLoggingHandler := LoggingHandler;
end;

constructor LoggerTrait.Create(LoggingHandler :LoggingHandlerInterface);
begin
     FLoggingHandler := LoggingHandler;
end;

destructor LoggerTrait.Destroy;
begin
  inherited Destroy;
end;
procedure LoggerTrait.Emergency(Message : UTF8String; Context : array of const);
begin
     Log(LOG_EMERG, Message, Context);
end;

procedure LoggerTrait.Alert(Message : UTF8String; Context : array of const);
begin
     Log(LOG_ALERT, Message, Context);
end;
procedure LoggerTrait.Critical(Message : UTF8String; Context : array of const);
begin
     Log(LOG_CRIT, Message, Context);
end;
procedure LoggerTrait.Error(Message : UTF8String; Context : array of const);
begin
     Log(LOG_ERR, Message, Context);
end;
procedure LoggerTrait.Warning(Message : UTF8String; Context : array of const);
begin
     Log(LOG_WARNING, Message, Context);
end;

procedure LoggerTrait.Notice(Message : UTF8String; Context : array of const);
begin
     Log(LOG_NOTICE, Message, Context);
end;

procedure LoggerTrait.Info(Message : UTF8String; Context : array of const);
begin
     Log(LOG_INFO, Message, Context);
end;

procedure LoggerTrait.Debug(Message : UTF8String; Context : array of const);
begin
     Log(LOG_DEBUG, Message, Context);
end;
procedure LoggerTrait.Log(LogLevel : LogLevels; Message :UTF8String; Context : array of const);
begin

     raise Exception.Create(
           Format(#10#13'  You need override the LoggerInterface.Log method in your class.'#10#13 +
           '  Implemented class was %s.%s.'#10#13,
           [self.UnitName, self.ClassName])) at
           get_caller_addr(get_frame),
           get_caller_frame(get_frame);
end;
end.
