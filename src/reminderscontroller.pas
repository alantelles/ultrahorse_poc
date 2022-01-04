unit RemindersController;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Horse,
  ARCLass, UltraGenInterfaceClass;

procedure Index(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
procedure Show(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
procedure NewNote(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
procedure SaveNewNote(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);

implementation

uses ViewProcessor;

procedure Index(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
var
  ViewOutput: string;
  Adapter: TUltraAdapter;
begin
  Adapter := TUltraAdapter.Create('$fromHorse');
  Adapter.AddMember('route', '');

  ViewOutput := ViewProcessor.render(Adapter);
  Res.Send(ViewOutput);
end;

procedure Show(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
var
  ViewOutput: string;
  Adapter: TUltraAdapter;
begin
  Adapter := TUltraAdapter.Create('$fromHorse');
  Adapter.AddMember('route', 'note');
  Adapter.AddMember('title', 'My reminder by horse');
  Adapter.AddMember('content', 'This is my first reminder coming by horse');
  ViewOutput := ViewProcessor.render(Adapter);
  Res.Send(ViewOutput);
end;

procedure NewNote(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
var
  ViewOutput: string;
  Adapter: TUltraAdapter;
begin
  Adapter := TUltraAdapter.Create('$fromHorse');
  Adapter.AddMember('route', 'newNote');
  ViewOutput := ViewProcessor.render(Adapter);
  Res.Send(ViewOutput);
end;

procedure SaveNewNote(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
var
  Content: string;
  Title: string;
begin
  Req.ContentFields.TryGetValue('content', Content);
  Req.ContentFields.TryGetValue('title', Title);
  Res.RawWebResponse.SetCustomHeader('location', 'http://localhost:9000/note');
  Res.Status(303);
end;



end.

