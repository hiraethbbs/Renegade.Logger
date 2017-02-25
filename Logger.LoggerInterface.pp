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
{$interfaces corba}
{$codepage utf8}
{$h+}
{ namespace Renegade.Logger }
unit Logger.LoggerInterface;

interface

uses
  Classes,
  Logger.HandlerInterface;

type
  LogLevels = (
    LOG_EMERG,
    LOG_ALERT,
    LOG_CRIT,
    LOG_ERR,
    LOG_WARNING,
    LOG_NOTICE,
    LOG_INFO,
    LOG_DEBUG);

const
  LOG_PRIMASK = $07; // Internal Unix Use;

type
  LoggerInterface = interface
    ['{3220524c-fae0-11e6-8b70-9c5c8e742ab6}']
    procedure SetHandler(Handler: LoggingHandlerInterface);
    procedure Emergency(Message: UTF8String; Context: array of const);
    procedure Alert(Message: UTF8String; Context: array of const);
    procedure Critical(Message: UTF8String; Context: array of const);
    procedure Error(Message: UTF8String; Context: array of const);
    procedure Warning(Message: UTF8String; Context: array of const);
    procedure Notice(Message: UTF8String; Context: array of const);
    procedure Info(Message: UTF8String; Context: array of const);
    procedure Debug(Message: UTF8String; Context: array of const);
    procedure Log(LogLevel: LogLevels; Message: UTF8String;
      Context: array of const);
    property LoggingHandler: LoggingHandlerInterface write SetHandler;
  end;

implementation

end.
