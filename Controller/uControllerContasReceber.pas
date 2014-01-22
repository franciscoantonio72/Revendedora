unit uControllerContasReceber;

interface

uses uClassContasReceber, uDaoContasReceber, SysUtils, Generics.Collections;

type
   TControllerContasReceber = class
   public
     procedure Incluir( proContasReceber : TList<TContasReceber> );
   end;

implementation


{ TControllerContasReceber }

procedure TControllerContasReceber.Incluir(proContasReceber: TList<TContasReceber>);
var loDaoContasReceber : TDaoContasReceber;
begin
   loDaoContasReceber := TDaoContasReceber.Create;
   try
      loDaoContasReceber.Incluir( proContasReceber );
   finally
      FreeAndNil( loDaoContasReceber );
   end;
end;

end.
