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
unit Logger.HandlerInterface;

interface

uses
  Classes;

type
  LoggingHandlerInterface = interface
    ['{C6E95830-5B13-4A51-BC03-757A3A1C779F}']

    { This method is called to do anything special to
      open the log, an example would be making a
      connection to a database or opening a file. }
    function Open(Identifier: UTF8String): boolean;

    { This method is called to do any closing of the log,
      an example would be closing a database or a file. }
    function Close(): boolean;

    { This method is called to write log data,
      and example would be inserting database records
      or writing a line to a file. }
    function Write(const LogData: UTF8String): boolean;
  end;

implementation

end.
