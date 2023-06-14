unit HGM.LineStorage;

interface

uses
  System.Classes, System.SysUtils;

type
  TLineItem = class(TCollectionItem)
  private
    FLines: TStrings;
    FName: string;
    procedure SetLines(const Value: TStrings);
    procedure SetName(const Value: string);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Lines: TStrings read FLines write SetLines;
    property Name: string read FName write SetName;
  end;

  TLineItems = class(TCollection)
  public
    function GetById(const Index: Integer): string;
    function GetByName(const Name: string): string;
  end;

  TLineStorage = class(TComponent)
  private
    FItems: TLineItems;
    procedure SetItems(const Value: TLineItems);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetById(const Index: Integer): string;
    function GetByName(const Name: string): string;
  published
    property Items: TLineItems read FItems write SetItems;
  end;

implementation

uses
  System.Generics.Collections;

{ TLineItem }

constructor TLineItem.Create(Collection: TCollection);
begin
  inherited;
  FLines := TStringList.Create;
end;

destructor TLineItem.Destroy;
begin
  FLines.Free;
  inherited;
end;

function TLineItem.GetDisplayName: string;
begin
  if FName.IsEmpty then
    Result := inherited
  else
    Result := FName;
end;

procedure TLineItem.SetLines(const Value: TStrings);
begin
  FLines.Assign(Value);
end;

procedure TLineItem.SetName(const Value: string);
begin
  FName := Value;
end;

{ TLineStorage }

constructor TLineStorage.Create(AOwner: TComponent);
begin
  inherited;
  FItems := TLineItems.Create(TLineItem);
end;

destructor TLineStorage.Destroy;
begin
  FItems.Free;
  inherited;
end;

function TLineStorage.GetById(const Index: Integer): string;
begin
  Result := FItems.GetById(Index);
end;

function TLineStorage.GetByName(const Name: string): string;
begin
  Result := FItems.GetByName(Name);
end;

procedure TLineStorage.SetItems(const Value: TLineItems);
begin
  FItems.Assign(Value);
end;

{ TLineItems }

function TLineItems.GetById(const Index: Integer): string;
begin
  Result := TLineItem(Items[Index]).Lines.Text;
end;

function TLineItems.GetByName(const Name: string): string;
begin
  for var Item in Self do
    if TLineItem(Item).Name = Name then
      Exit(TLineItem(Item).Lines.Text);
  ErrorArgumentOutOfRange;
end;

end.

