program test_horse;

{$mode objfpc}{$H+}

uses

  cthreads,

  Classes,
  { you can add units after this }
  Horse,

  RemindersController
  ;


begin
  THorse.Get('/', @RemindersController.Index);
  THorse.Get('/note', @RemindersController.Show);
  THorse.Get('/new', @RemindersController.NewNote);
  THorse.Listen(9000);
end.

