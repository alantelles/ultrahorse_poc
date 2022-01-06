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
procedure DeleteNote(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
procedure EditNote(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
procedure UpdateNote(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);

implementation

uses ViewProcessor, remindersService;

procedure UpdateNote(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
var
  NoteId: string;
  Content: string;
  Title: string;
begin
  Req.Params.TryGetValue('id', NoteId);
  Req.ContentFields.TryGetValue('content', Content);
  Req.ContentFields.TryGetValue('title', Title);
  RemindersService.Update(NoteId, Title, Content);
  Res.RawWebResponse.SetCustomHeader('location', 'http://localhost:9000/note/' + noteId);
  Res.Status(303);
end;

procedure EditNote(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
var
  NoteId: string;
  ViewOutput: string;
  Adapter: TUltraAdapter;
begin
  Req.Params.TryGetValue('id', NoteId);
  Adapter := TUltraAdapter.Create('$fromHorse');
  Adapter.AddMember('route', 'edit');
  Adapter.AddMember('data', RemindersService.Show(NoteId));
  ViewOutput := ViewProcessor.render(Adapter);
  Res.Send(ViewOutput);
end;

procedure DeleteNote(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
var
  NoteId: string;
begin
  Req.Params.TryGetValue('id', NoteId);
  RemindersService.Delete(NoteId);
  Res.RawWebResponse.SetCustomHeader('location', 'http://localhost:9000');
  Res.Status(303);
end;

procedure Index(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
var
  ViewOutput: string;
  Adapter: TUltraAdapter;
begin
  Adapter := TUltraAdapter.Create('$fromHorse');
  Adapter.AddMember('route', '');
  Adapter.AddMember('data', RemindersService.findAll);
  ViewOutput := ViewProcessor.render(Adapter);
  Res.Send(ViewOutput);
end;

procedure Show(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
var
  ViewOutput: string;
  Adapter: TUltraAdapter;
  NoteId: string;
begin
  Req.Params.TryGetValue('id', NoteId);
  Adapter := TUltraAdapter.Create('$fromHorse');
  Adapter.AddMember('route', 'note');
  Adapter.AddMember('data', RemindersService.Show(NoteId));
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
  InsertedId: integer;
begin
  Req.ContentFields.TryGetValue('content', Content);
  Req.ContentFields.TryGetValue('title', Title);
  InsertedId := RemindersService.Save(Title, Content);
  Res.RawWebResponse.SetCustomHeader('location', 'http://localhost:9000/note/' + IntToStr(InsertedId));
  Res.Status(303);
end;



end.

