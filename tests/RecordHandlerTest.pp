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
{ Program to test the Logger.RecordHandler class }
Program RecordHandlerTest;

Uses
    Classes,
    SysUtils,
    Renegade.Logger,
    Logger.RecordHandler,
    Logger.LoggerInterface;

const
  Message = 'This is a log message';
  CurrentClass = 'RecordHandler';
var
  Handler : RecordHandler;
  Logger : RTLogger;
  Context : array [1..4] of ansistring = (CurrentClass, 'True', 'Testing', 'True');
begin

  Handler := RecordHandler.Create;
  Logger := RTLogger.Create(Handler);
  Logger.Emergency(Message, [Context[1], Context[2], Context[3], Context[4]]);
  Logger.Alert(Message, [Context[1], Context[2], Context[3], Context[4]]);
  Logger.Critical(Message, [Context[1], Context[2], Context[3], Context[4]]);
  Logger.Error(Message, [Context[1], Context[2], Context[3], Context[4]]);
  Logger.Warning(Message, [Context[1], Context[2], Context[3], Context[4]]);
  Logger.Notice(Message, [Context[1], Context[2], Context[3], Context[4]]);
  Logger.Info(Message, [Context[1], Context[2], Context[3], Context[4]]);
  Logger.Debug(Message, [Context[1], Context[2], Context[3], Context[4]]);

  Logger.Log(LOG_EMERG, Message, [Context[1], Context[2], Context[3], Context[4]]);
  Logger.Log(LOG_ALERT, Message, [Context[1], Context[2], Context[3], Context[4]]);
  Logger.Log(LOG_CRIT, Message, [Context[1], Context[2], Context[3], Context[4]]);
  Logger.Log(LOG_ERR, Message, [Context[1], Context[2], Context[3], Context[4]]);
  Logger.Log(LOG_WARNING, Message, [Context[1], Context[2], Context[3], Context[4]]);
  Logger.Log(LOG_NOTICE, Message, [Context[1], Context[2], Context[3], Context[4]]);
  Logger.Log(LOG_INFO, Message, [Context[1], Context[2], Context[3], Context[4]]);
  Logger.Log(LOG_DEBUG, Message, [Context[1], Context[2], Context[3], Context[4]]);

  Logger.LOG(LOG_UNKNOWN, Message, [Context[1], Context[2], Context[3], Context[4]]);
  RenameFile('renegade.log', CurrentClass + 'Test.log');
end.

