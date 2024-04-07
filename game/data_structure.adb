with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
with Ada.Text_Io;         use Ada.Text_Io;
with Ada.Numerics.Discrete_Random;

with TJa.Window.Graphic;    use TJa.Window.Graphic;
with TJa.Window.Elementary; use TJa.Window.Elementary;
with TJa.Window.Text;       use TJa.Window.Text;
with TJa.Keyboard;          use TJa.Keyboard;
with TJa.Calendar;          use Tja.Calendar;

with Tetris_Graphics;       use Tetris_Graphics;
with Tetris_Engine;         use Tetris_Engine;

package body Data_Structure is
   
    subtype Rand_Interval is
     Integer range 1 .. 7;
   
   package My_Random_Handling is
      new Ada.Numerics.Discrete_Random(Rand_Interval);
   use My_Random_Handling;
   
   function Random return Integer is
      G: My_Random_Handling.Generator;
      N: Integer;
   begin
      My_Random_Handling.Reset(G);
      N := Random(G);
      return N;
   end Random;
   
   procedure Generate_Block(W : in Integer; Block: in out Block_Type;  R: in Integer := 0) is
      
      
   begin
      for U in 1..4 loop
	 for I in 1..4 loop
	    Block(U,I).Value := False;
	 end loop;
      end loop;
      
     if W = 1 then --I-block  ----  
    -----------------------------
    if R = 0 or R = 180 then 
       for I in 1..4 loop
	  Block(I,2).Value := true;
	  Block(I,2).colour := Bright_Cyan;
       End loop;

    elsif R = 90 or R = 270 then
      for I in 1..4 loop
	 Block(2,I).Value := true;
	 Block(2,I).colour := Bright_Cyan;
       End loop;   
    end if;
    ----------------------------- 
       
    elsif W = 2 then -- J-block  -
                                 ---

    -----------------------------
    if R = 0 then
       Block(2,1).Value := True;
       Block(2,1).colour := Bright_Blue;
       for I in 1..3 loop
	  Block(3,I).Value := true;
	  Block(3,I).colour := Bright_Blue;
       end loop;
    elsif R = 90 then
       Block(3,2).Value := True;
        Block(3,2).colour := Bright_Blue;
       for I in 1..3 loop
	  Block(I,3).Value := true;
	  Block(I,3).colour := Bright_Blue;
       end loop;
    elsif R = 180 then
       Block(3,3).Value := True;
       Block(3,3).colour := Bright_Blue;
       for I in 1..3 loop
	  Block(2,I).Value := true;
	  Block(2,I).colour := Bright_Blue;
       end loop;
    elsif R = 270 then
       Block(1,3).Value := True;
       Block(1,3).colour := Bright_Blue;
       for I in 1..3 loop
	  Block(I,2).Value := true;
	  Block(I,2).colour := Bright_Blue;
       end loop;
       end if;
     -------------------------------
          
    elsif W = 3 then --L-block     -
                                 ---

     -----------------------------
    if R = 0 then
       Block(2,3).Value := True;
       Block(2,3).colour := Light_Grey;
       for I in 1..3 loop
	  Block(3,I).Value := true;
	  Block(3,i).colour := Light_Grey;
       end loop;
    elsif R = 90 then
       Block(1,2).Value := True;
        Block(1,2).colour := Light_Grey;
       for I in 1..3 loop
	  Block(I,3).Value := true;
	   Block(I,3).colour := Light_Grey;
       end loop;
    elsif R = 180 then
       Block(3,1).Value := True;
        Block(3,1).colour := Light_Grey;
       for I in 1..3 loop
	  Block(2,I).Value := true;
	   Block(2,I).colour := Light_Grey;
       end loop;
    elsif R = 270 then
       Block(3,3).Value := True;
        Block(3,3).colour := Light_Grey;
       for I in 1..3 loop
	  Block(I,2).Value := true;
	   Block(I,2).colour := Light_Grey;
       end loop;
       end if;
     -------------------------------
       
       
    elsif W = 4 then --O-Block  --
		                --
    
       for I in 2..3 loop
	  Block(I,1).Value := true;
	  Block(I,1).colour := Bright_Yellow;
	  Block(I,2).Value := true;
	  Block(I,2).colour := Bright_Yellow;
       end loop;
      
	  
    elsif W = 5 then --S-Block   --
 		                --  ---------------------------
    if R = 0 or R = 180 then  
       Block(2,2).Value := true;
       Block(2,2).colour := Bright_Green;
       Block(2,3).Value := true;
       Block(2,3).colour := Bright_Green;
	 Block(3,1).Value := true;
       Block(3,1).colour := Bright_Green;
	 Block(3,2).Value := true;
       Block(3,2).colour := Bright_Green;
    elsif R = 90 or R = 270 then
	 Block(1,2).Value := true;
	 Block(1,2).colour := Bright_Green;
	   Block(2,2).Value := true;
	 Block(2,2).colour := Bright_Green;
	   Block(2,3).Value := true;
	 Block(3,2).colour := Bright_Green;
	   Block(3,3).Value := true;  
	 Block(3,3).colour := Bright_Green;
    end if;
    --------------------------   
    
    elsif W = 6 then --T-Block   -
	                        ---

     ---------------------------
     if R = 0 then
	Block(1,2).Value := true;
	Block(1,2).colour := Bright_Magenta;
     for I in 1..3 loop
	Block(2,I).Value := true;
	Block(2,I).colour := Bright_Magenta;
     end loop;
     elsif R = 90 then
	Block(2,1).Value := true;
	Block(2,1).colour := Bright_Magenta;
     for I in 1..3 loop
	Block(I,2).Value := true;
	Block(I,2).colour := Bright_Magenta;
     end loop;
     elsif R = 180 then
	Block(2,2).Value := true;
	Block(2,2).colour := Bright_Magenta;
     for I in 1..3 loop
	Block(1,I).Value := true;
	Block(1,I).colour := Bright_Magenta;
     end loop;
     elsif R = 270 then
	Block(2,3).Value := true;
	Block(2,3).colour := Bright_Magenta;
     for I in 1..3 loop
	Block(I,2).Value := true;
	Block(I,2).colour := Bright_Magenta;
     end loop;
     end if;
     ------------------------	  
	  	  
    elsif W = 7 then --Z_block  --
		                 --  
    ------------------------------  
    if R = 0 or R =  180 then  
       Block(2,1).Value := True;
       Block(2,1).colour := Red;
       Block(2,2).Value := true;
       Block(2,2).colour := Red;
       Block(3,2).Value := true;
       Block(3,2).colour := Red;
       Block(3,3).Value := true;
       Block(3,3).colour := Red;
    elsif R = 90 or R = 270 then
       Block(1,3).Value := true;
       Block(1,3).colour := Red;
       Block(2,2).Value := true;
       Block(2,2).colour := Red;
       Block(2,3).Value := true;
       Block(2,3).colour := Red;
       Block(3,2).Value := true;  
       Block(3,2).colour := Red;
      end if;
    ----------------------------
    end if;
      
    
    end Generate_Block;
   
   
   
   end;
