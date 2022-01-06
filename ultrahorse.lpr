program ultrahorse;

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
  THorse.Get('/note/:id', @RemindersController.Show);
  THorse.Get('/new', @RemindersController.NewNote);
  THorse.Get('/edit/:id', @RemindersController.EditNote);
  THorse.Post('/new', @RemindersController.SaveNewNote);
  THorse.Post('/delete/:id', @RemindersController.DeleteNote);
  THorse.Post('/edit/:id', @RemindersController.UpdateNote);

  THorse.Listen(9000);
end.

