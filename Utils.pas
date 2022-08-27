unit Utils;

interface

uses
  System.Classes;

function IsBinaryStream(const Stream: TStream): Boolean;

implementation

function IsBinaryStream(const Stream: TStream): Boolean;
const
  BufferSize = 50;
  BinaryPercent = 10;
var
  Buffer : array[0..BufferSize] of AnsiChar;
  I: Integer;
  BinaryCount : Integer;
begin
  Result := False;
  FillChar(Buffer, BufferSize+1, #32);
  // Read the first characters of the file and if enough of them
  // are not text characters, then consider the file to be binary
  Stream.Read(Buffer, BufferSize+1);
  BinaryCount := 0;
  for I := 0 to BufferSize do
    if not (Buffer[I] in [#9, #13, #10, #32..#127]) then
      Inc(BinaryCount);

  Result := BinaryCount > BufferSize * BinaryPercent div 100;
  Stream.Position := 0;
  //If Result Then
  //  MainTrace.Send('BinaryFile:', FileName);
end;

end.
