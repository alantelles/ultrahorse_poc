unit ViewProcessor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
  UltraGenInterfaceClass, ARClass, ASTCLass;

const ULTRA_HOME = 'ultragen/build';

function render(Adapter: TUltraAdapter): string;

implementation

function render(Adapter: TUltraAdapter): string;
var
  PreludeLines: TStringList;
begin
  PreludeLines := TStringList.Create;
  PreludeLines.Add('addModulePath(["'+ULTRA_HOME + '", "modules"].path())');
  PreludeLines.Add('include @Core');
  Result := TUltraInterface.InterpretScript('views/index.ultra', PreludeLines, Adapter);
end;

end.

