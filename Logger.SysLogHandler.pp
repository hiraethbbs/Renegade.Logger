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
{$linklib c}
{$codepage utf8}
{$h+}
{
 Unix System Log Handler.
 The constructor takes one of the defined Logging Facilities.
}
unit Logger.SysLogHandler;

interface

uses
  Classes,
  SysUtils,
  Logger.HandlerInterface;

const
  // log the pid with each message
  LOG_PID = $01;
  // Write directly to system console if there is an error
  // while sending to system logger.
  LOG_CONS = $02;
  // The converse of LOG_NDELAY; opening of the connection is delayed until
  // syslog() is called. (This is the default, and need not be specified.)
  LOG_ODELAY = $04;
  // Open the connection immediately (normally, the connection is opened when
  // the first message is logged).
  LOG_NDELAY = $08;
  // Don't wait for child processes that may have been created while logging
  // the message. (The GNU C library does not create a child process, so this
  // option has no effect on Linux.)
  LOG_NOWAIT = $10;
  // log to stderr as well
  LOG_PERROR = $20;

  { Logging Facilities }
  LOG_KERN = 0 shl 3;  // kernel messages
  LOG_USER = 1 shl 3;  // random user-level messages
  LOG_MAIL = 2 shl 3;  // mail system
  LOG_DAEMON = 3 shl 3;  // system daemons
  LOG_AUTH = 4 shl 3;  // security/authorization messages
  LOG_SYSLOG = 5 shl 3;  // messages generated internally by syslogd
  LOG_LPR = 6 shl 3;  // line printer subsystem
  LOG_NEWS = 7 shl 3;  // network news subsystem
  LOG_UUCP = 8 shl 3;  // UUCP subsystem
  LOG_CRON = 9 shl 3;  // clock daemon
  LOG_AUTHPRIV = 10 shl 3; // security/authorization messages (private)

var
  UnixFacility: longint;

type
  SysLogHandler = class(TObject, LoggingHandlerInterface)
  private
    FUnixFacility: longint;
    procedure SetFacility(const UnixFacility: longint);
  public
    constructor Create(const LoggingFacility: longint);
    function Open(Identifier: UTF8String): boolean;
    function Close(): boolean;
    function Write(const LogData: UTF8String): boolean;
  published
    property UnixFacility: longint read FUnixFacility write SetFacility;
  end;
  EPlatformNotSupported = class(Exception) end;

procedure closelog; cdecl; external;
procedure openlog(__ident: PChar; __option: longint; __facilit: longint);
  cdecl; external;
function setlogmask(__mask: longint): longint; cdecl; external;
procedure syslog(__pri: longint; __fmt: PChar; args: array of const); cdecl; external;

implementation

constructor SysLogHandler.Create(const LoggingFacility: longint);
begin
  {$IFDEF WIN}
     Raise EPlatformNotSupported.Create ('SysLogHandler is not supported under Windows.') at
     get_caller_addr(get_frame),
     get_caller_frame(get_frame);
  {$ENDIF WIN}
  FUnixFacility := LoggingFacility;
end;

procedure SysLogHandler.SetFacility(const UnixFacility: longint);
begin
  {$IFDEF WIN}
     Raise EPlatformNotSupported.Create ('SysLogHandler is not supported under Windows.') at
     get_caller_addr(get_frame),
     get_caller_frame(get_frame);
  {$ENDIF WIN}
  FUnixFacility := UnixFacility;
end;

function SysLogHandler.Open(Identifier: UTF8String): boolean;
var
  SysLogIdentifier: PAnsiChar;
begin
  SysLogIdentifier := PAnsiChar(Identifier);
  openlog(SysLogIdentifier, LOG_PID xor LOG_CONS xor LOG_NDELAY, FUnixFacility);
  Result := True;
end;

function SysLogHandler.Close(): boolean;
begin
  closelog;
  Result := True;
end;

function SysLogHandler.Write(const LogData: UTF8String): boolean;
var
  SysLogData: PAnsiChar;
begin
  SysLogData := PAnsiChar(LogData);
  syslog(FUnixFacility, SysLogData, []);
  Result := True;
end;

end.
