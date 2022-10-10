# BÀI 4. KỸ THUẬT NHÁNH CẬN

## 4.1. BÀI TOÁN TỐI ƯU

Một trong những bài toán đặt ra trong thực tế là việc tìm ra một nghiệm thoả mãn một số điều kiện nào đó, và nghiệm đó là tốt nhất theo một chỉ tiêu cụ thể, nghiên cứu lời giải các lớp bài toán tối ưu thuộc về lĩnh vực quy hoạch toán học. Tuy nhiên cũng cần phải nói rằng trong nhiều trường hợp chúng ta chưa thể xây dựng một thuật toán nào thực sự hữu hiệu để giải bài toán, mà cho tới nay việc tìm nghiệm của chúng vẫn phải dựa trên mô hình liệt kê toàn bộ các cấu hình có thể và đánh giá, tìm ra cấu hình tốt nhất. Việc liệt kê cấu hình có thể cài đặt bằng các phương pháp liệt kê: Sinh tuần tự và tìm kiếm quay lui. Dưới đây ta sẽ tìm hiểu phương pháp liệt kê bằng thuật toán quay lui để tìm nghiệm của bài toán tối ưu.

## 4.2. SỰ BÙNG NỔ TỔ HỢP

Mô hình thuật toán quay lui là tìm kiếm trên 1 cây phân cấp. Nếu giả thiết rằng ứng với mỗi nút tương ứng với một giá trị được chọn cho x[i] sẽ ứng với chỉ 2 nút tương ứng với 2 giá trị mà x[i+1] có thể nhận thì cây n cấp sẽ có tới 2 n nút lá, con số này lớn hơn rất nhiều lần so với dữ liệu đầu vào n. Chính vì vậy mà nếu như ta có thao tác thừa trong việc chọn x[i] thì sẽ phải trả giá rất lớn về chi phí thực thi thuật toán bởi quá trình tìm kiếm lòng vòng vô nghĩa trong các bước chọn kế tiếp x[i+1], x[i+2], … Khi đó, một vấn đề đặt ra là trong quá trình liệt kê lời giải ta cần tận dụng những thông tin đã tìm được để loại bỏ sớm những phương án chắc chắn không phải tối ưu. Kỹ thuật đó gọi là kỹ thuật đánh giá nhánh cận trong tiến trình quay lui.

## 4.3. MÔ HÌNH KỸ THUẬT NHÁNH CẬN

Dựa trên mô hình thuật toán quay lui, ta xây dựng mô hình sau:

```pascal
procedure Init;
begin
    〈Khởi tạo một cấu hình bất kỳ BESTCONFIG〉;
end;

{Thủ tục này thử chọn cho x[i] tất cả các giá trị nó có thể nhận}
procedure Try(i: Integer);
begin
    for 〈Mọi giá trị V có thể gán cho x[i]〉 do
        begin
            〈Thử cho x[i] := V〉;
            if 〈Việc thử trên vẫn còn hi vọng tìm ra cấu hình tốt hơn BESTCONFIG〉 then
                if 〈x[i] là phần tử cuối cùng trong cấu hình〉 then
                    〈Cập nhật BESTCONFIG〉
                else
                    begin
                        〈Ghi nhận việc thử x[i] = V nếu cần〉;
                        Try(i + 1); {Gọi đệ quy, chọn tiếp x[i+1]}
                        〈Bỏ ghi nhận việc thử cho x[i] = V (nếu cần)〉;
                    end;
        end;
end;

begin
    Init;
    Try(1);
    〈Thông báo cấu hình tối ưu BESTCONFIG〉;
end.
```

Kỹ thuật nhánh cận thêm vào cho thuật toán quay lui khả năng đánh giá theo từng bước, nếu tại bước thứ i, giá trị thử gán cho x[i] không có hi vọng tìm thấy cấu hình tốt hơn cấu hình BESTCONFIG thì thử giá trị khác ngay mà không cần phải gọi đệ quy tìm tiếp hay ghi nhận kết quả làm gì. Nghiệm của bài toán sẽ được làm tốt dần, bởi khi tìm ra một cấu hình mới (tốt hơn BESTCONFIG - tất nhiên), ta không in kết quả ngay mà sẽ cập nhật BESTCONFIG bằng cấu hình mới vừa tìm được.

## 4.4. BÀI TOÁN NGƯỜI DU LỊCH

### 4.4.1. Bài toán

Cho n thành phố đánh số từ 1 đến n và m tuyến đường giao thông hai chiều giữa chúng, mạng lưới giao thông này được cho bởi bảng C cấp nxn, ở đây C[i, j] = C[j, i] = Chi phí đi đoạn đường trực tiếp từ thành phố i đến thành phố j. Giả thiết rằng C[i, i] = 0 với ∀i, C[i, j] = +∞ nếu không có đường trực tiếp từ thành phố i đến thành phố j.

Một người du lịch xuất phát từ thành phố 1, muốn đi thăm tất cả các thành phố còn lại mỗi thành phố đúng 1 lần và cuối cùng quay lại thành phố 1. Hãy chỉ ra cho người đó hành trình với chi phí ít nhất. Bài toán đó gọi là bài toán người du lịch hay bài toán hành trình của một thương gia (Traveling Salesman)

### 4.4.2. Cách giải

Hành trình cần tìm có dạng x[1..n + 1] trong đó x[1] = x[n + 1] = 1 ở đây giữa x[i] và x[i+1]: hai thành phố liên tiếp trong hành trình phải có đường đi trực tiếp (C[i, j] ≠ +∞) và ngoại trừ thành phố 1, không thành phố nào được lặp lại hai lần. Có nghĩa là dãy x[1..n] lập thành 1 hoán vị của (1, 2, …, n).

Duyệt quay lui: x[2] có thể chọn một trong các thành phố mà x[1] có đường đi tới (trực tiếp), với mỗi cách thử chọn x[2] như vậy thì x[3] có thể chọn một trong các thành phố mà x[2] có đường đi tới (ngoài x[1]). Tổng quát: x[i] có thể chọn 1 trong các thành phố chưa đi qua mà từ x[i-1] có đường đi trực tiếp tới (1 ≤ i ≤ n).

Nhánh cận: Khởi tạo cấu hình BestConfig có chi phí = +∞. Với mỗi bước thử chọn x[i] xem chi phí đường đi cho tới lúc đó có < Chi phí của cấu hình BestConfig?, nếu không nhỏ hơn thì thử giá trị khác ngay bởi có đi tiếp cũng chỉ tốn thêm. Khi thử được một giá trị x[n] ta kiểm tra xem x[n] có đường đi trực tiếp về 1 không ? Nếu có đánh giá chi phí đi từ thành phố 1 đến thành phố x[n] cộng với chi phí từ x[n] đi trực tiếp về 1, nếu nhỏ hơn chi phí của đường đi BestConfig thì cập nhật lại BestConfig bằng cách đi mới.

Sau thủ tục tìm kiếm quay lui mà chi phí của BestConfig vẫn bằng +∞ thì có nghĩa là nó không tìm thấy một hành trình nào thoả mãn điều kiện đề bài để cập nhật BestConfig, bài toán không có lời giải, còn nếu chi phí của BestConfig < +∞ thì in ra cấu hình BestConfig - đó là hành trình ít tốn kém nhất tìm được.

***Input:*** file văn bản TOURISM.INP

- Dòng 1: Chứa số thành phố n (1 ≤ n ≤ 20) và số tuyến đường m trong mạng lưới giao thông
- m dòng tiếp theo, mỗi dòng ghi số hiệu hai thành phố có đường đi trực tiếp và chi phí đi trên quãng đường đó (chi phí này là số nguyên dương ≤ 100)

***Output:*** file văn bản TOURISM.OUT, ghi hành trình tìm được.

![TOURISM](/Part1._Enumeration_problem/Lesson4._Branch_and_Bound_technique/Tourism.png)
