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
Unit Logger.FileHandler;

interface

Uses
  Classes,
  SysUtils,
  Logger.HandlerInterface,
  Logger.StreamHandler;

Type FileHandler = class(StreamHandler, LoggingHandlerInterface)
    Public
      constructor Create( const FileName: UTF8String);
      function Open(Identifier: UTF8String): boolean;
      function Close(): boolean;
      function Write(const LogData: UTF8String): boolean;
end;

implementation

constructor FileHandler.Create( const FileName: UTF8String);
begin
  inherited Create(FileName);
end;

function FileHandler.Open(Identifier: UTF8String): boolean;
begin
   Result := inherited Open(Identifier);
end;

function FileHandler.Close() : boolean;
begin
   Result := inherited Close;
end;

function FileHandler.Write(const LogData: UTF8String): boolean;
begin
    Result := inherited Write(LogData);
end;

End.

