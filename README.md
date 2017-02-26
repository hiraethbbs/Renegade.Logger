# Renegade Logger Class

Logger class for Free Pascal

## Usage

```pascal
uses
  Renegade.Logger,
  { Implement Logger.LoggingHandlerInterface 
  (Logger.HandlerInterface unit)
   to create your own. }
  Logger.SysLogHandler,
  // or Logger.StreamHandler,
  //... other units;

var
  LogHandler : SysLogHandler;
  Log : RTLogger;
begin
  LogHandler := SysLogHandler.Create(LOG_DAEMON);
  Log := RTLogger.Create(LogHandler); 
  { Context is an array of consts
    It gets turned into json object in the log.
    It should be in the format ['Key', 'Value', 'Otherkey', 'Value']
    Put any context to your log messages here.
    e.g. ['UserID', User.getId(), 'Menu', Menu.getName()] }  
  Log.Info('Testing', ['Context', 'LogContext']); 
  Log.Debug('Debug Log', []);
  Log.Log(LOG_NOTICE, 'Notice Log', []);
  {
      Other Shortcuts
      Log.Emergency
      Log.Alert
      Log.Critical
      Log.Error
      Log.Warning
      Log.Notice

  } 
  Log.Free;
  LogHandler.Free;
end.
```