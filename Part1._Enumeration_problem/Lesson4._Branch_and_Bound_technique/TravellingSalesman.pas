program TravellingSalesman;

const
    InputFile = 'TOURISM.INP';
    OutputFile = 'TOURISM.OUT';
    max = 20;
    maxC = 20 * 100 + 1;{+∞}
var
    C: array[1..max, 1..max] of Integer; {Ma trận chi phí}
    X, BestWay: array[1..max + 1] of Integer; {X để thử các khả năng, BestWay để ghi nhận nghiệm}
    T: array[1..max + 1] of Integer; {T[i] để lưu chi phí đi từ X[1] đến X[i]}
    Free: array[1..max] of Boolean; {Free để đánh dấu, Free[i]= True nếu chưa đi qua tp i}
    m, n: Integer;
    MinSpending: Integer; {Chi phí hành trình tối ưu}

procedure Enter;
var
    i, j, k: Integer;
    f: Text;
begin
    Assign(f, InputFile); Reset(f);
    ReadLn(f, n, m);
    for i := 1 to n do {Khởi tạo bảng chi phí ban đầu}
        for j := 1 to n do
            if i = j then C[i, j] := 0 else C[i, j] := maxC;
    for k := 1 to m do
        begin
            ReadLn(f, i, j, C[i, j]);
            C[j, i] := C[i, j]; {Chi phí như nhau trên 2 chiều}
        end;
    Close(f);
end;

procedure Init; {Khởi tạo}
begin
    FillChar(Free, n, True);
    Free[1] := False; {Các thành phố là chưa đi qua ngoại trừ thành phố 1}
    X[1] := 1; {Xuất phát từ thành phố 1}
    T[1] := 0; {Chi phí tại thành phố xuất phát là 0}
    MinSpending := maxC;
end;

procedure Try(i: Integer); {Thử các cách chọn xi}
var
    j: Integer;
begin
    for j := 2 to n do {Thử các thành phố từ 2 đến n}
        if Free[j] then {Nếu gặp thành phố chưa đi qua}
            begin
                X[i] := j; {Thử đi}
                T[i] := T[i - 1] + C[x[i - 1], j]; {Chi phí := Chi phí bước trước + chi phí đường đi trực tiếp}
                if T[i] < MinSpending then {Hiển nhiên nếu có điều này thì C[x[i - 1], j] < +∞ rồi}
                    if i < n then {Nếu chưa đến được x[n]}
                        begin
                            Free[j] := False; {Đánh dấu thành phố vừa thử}
                            Try(i + 1); {Tìm các khả năng chọn x[i+1]}
                            Free[j] := True; {Bỏ đánh dấu}
                        end
                    else
                        if T[n] + C[x[n], 1] < MinSpending then {Từ x[n] quay lại 1 vẫn tốn chi phí ít hơn trước}
                            begin {Cập nhật BestConfig}
                                BestWay := X;
                                MinSpending := T[n] + C[x[n], 1];
                            end;
            end;
end;

procedure PrintResult;
var
    i: Integer;
    f: Text;
begin
    Assign(f, OutputFile); Rewrite(f);
    if MinSpending = maxC then WriteLn(f, 'NO SOLUTION')
    else
        for i := 1 to n do Write(f, BestWay[i], '->');
    WriteLn(f, 1);
    WriteLn(f, 'Cost: ', MinSpending);
    Close(f);
end;

begin
    Enter;
    Init;
    Try(2);
    PrintResult;
end.