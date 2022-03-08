with Ada.Text_IO; use Ada.Text_IO;
with Interfaces; use Interfaces;
with Ada.Real_Time; use Ada.Real_Time;
procedure Example is
   function Squares(Ctr, Key : Unsigned_64) return Unsigned_32 is
      X, Y, Z : Unsigned_64;
   begin
      Y := Ctr * Key;
      X := Ctr * Key;
      Z := Y + Key;
      X := X * X + Y; X := Shift_Right(X,32) or Shift_Left(X,32);
      X := X * X + Z; X := Shift_Right(X,32) or Shift_Left(X,32);
      return Unsigned_32(Shift_Right(X * X + Y, 32));
   end Squares;

   two32 : constant Long_Long_Integer := 2**32;
   two32_Float : constant Long_Long_Float := Long_Long_Float(two32);
   billion : constant Long_Long_Integer := 1_000_000_000;
   K : constant Unsigned_64 := 16#548c9decbce65297#;
   -- I : Unsigned_64;
   N : constant Unsigned_64 := Unsigned_64(billion);
   SUM : Long_Long_Float := 0.0;
   Start_Time, Finish_Time : Time;
begin
   Start_Time := Clock;
   for I in 1..N loop
      SUM := SUM + Long_Long_Float(Squares(I, K))/two32_Float;
   end loop;
   Finish_Time := Clock;
   Put_Line("Generation of a " & billion'Image & " random numbers according to Bernard Wydinski at http://squaresrng.wixsite.com/rand");
   Put_line ("Average = " & Long_Long_Float(SUM/Long_Long_Float(N))'Image
             & " Execution Time : " & Duration'Image (To_duration(Finish_Time - Start_Time)) & " sec" & " with last Random = " & Long_Long_Float(Long_Long_Float(Squares(N, K))/Long_Long_Float(two32))'Image);
end Example;
