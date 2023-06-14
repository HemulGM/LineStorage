unit HGM.LineStorage.Reg;

interface

uses
  HGM.LineStorage;

procedure Register;

implementation

uses
  System.Classes;

procedure Register;
begin
  RegisterComponents('HGM Tools', [TLineStorage]);
end;

end.

