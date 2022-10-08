program n_Queens;

const
    InputFile = 'QUEENS.INP';
    OutputFile = 'QUEENS.OUT';
    max = 12;
var
    n: Integer;
    x: array[1..max] of Integer;
    a: array[1..max] of Boolean;
    b: array[2..2 * max] of Boolean;
    c: array[1 - max..max - 1] of Boolean;
    f: Text;

procedure Init;
begin
    Assign(f, InputFile); Reset(f);
    ReadLn(f, n);
    Close(f);
    FillChar(a, SizeOf(a), True); {Mọi cột đều tự do}
    FillChar(b, SizeOf(b), True); {Mọi đường chéo Đông Bắc - Tây Nam đều tự do}
    FillChar(c, SizeOf(c), True); {Mọi đường chéo Đông Nam - Tây Bắc đều tự do}
end;

procedure PrintResult;
var
    i: Integer;
begin
    for i := 1 to n do Write(f, '(', i, ', ', x[i], '); ');
    WriteLn(f);
end;

procedure Try(i: Integer); {Thử các cách đặt quân hậu thứ i vào hàng i}
var
    j: Integer;
begin
    for j := 1 to n do
    if a[j] and b[i + j] and c[i - j] then {Chỉ xét những cột j mà ô (i, j) chưa bị khống chế}
        begin
            x[i] := j; {Thử đặt quân hậu i vào cột j}
            if i = n then PrintResult
            else
                begin
                    a[j] := False; b[i + j] := False; c[i - j] := False; {Đánh dấu}
                    Try(i + 1); {Tìm các cách đặt quân hậu thứ i + 1}
                    a[j] := True; b[i + j] := True; c[i - j] := True; {Bỏ đánh dấu}
                end;
        end;
end;

begin
    Init;
    Assign(f, OutputFile); Rewrite(f);
    Try(1);
    Close(f);
end.