with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
with Ada.Text_Io;         use Ada.Text_Io;

with TJa.Window.Graphic;    use TJa.Window.Graphic;
with TJa.Window.Elementary; use TJa.Window.Elementary;
with TJa.Window.Text;       use TJa.Window.Text;
with TJa.Keyboard;          use TJa.Keyboard;
with TJa.Calendar;          use Tja.Calendar;

with Tetris_Graphics;       use Tetris_Graphics;
with Data_Structure;        use Data_Structure;

package body Tetris_Engine is
   
   
   function New_Board return Board_Type is
      Board : Board_Type;
   begin
      
      for I in 1..10 loop
	 for J in 1..20 loop
	    
	    Board(I,J).Value := False;
	    Board(I,J).Colour := Black;
	    
	 end loop;	 
      end loop;
            
      return Board;
   end New_Board;
   
   procedure Move_Board(Y: in Integer; Board : in out Board_Type) is
      
   begin
      
      if Y /= 1 then
	 for I in reverse 2..Y loop
	    
	    for X in 1..10 loop
	       Board(X,I).Value := Board(X, I-1).Value;
	       Board(X,I).Colour := Board(X, I-1).Colour;
	    end loop;
	    
	 end loop;
	 
      end if;

   end Move_Board;
   
  
   
   procedure Delete_Row(X_Start, Y_Start : in Integer; Board : in out Board_Type; Multiplier : out integer) is
      Counter : Integer := 0;
      Highest_Y : Integer := 0;
      Tmp_Board : Board_Type := Board;
   begin
      
      Multiplier := 0;
      
      for Y in 1..20 loop
	 for X in 1..10 loop
	    
	    if Board(X,Y).Value = True then
	       Counter := Counter +1;
	    end if;
	    
	 end loop;
	 
	 if Counter = 10 then
	    for I in 1..10 loop
	       Tmp_Board(I, Y).Value := False;
	       Board(I, Y).Value := False;
	    end loop;

	    Move_Board(Y, Board);
	    
	    Multiplier := Multiplier + 1;
	    Counter := 0;
	 else
	    Counter := 0;
	 end if;
      end loop;
           
      if Multiplier /= 0 then
	 Print_Board(X_Start, Y_Start, Tmp_Board);
	 delay 0.2;
	 Print_Board(X_Start, Y_Start, Board);
      end if;
      
   end Delete_Row;
   
   
      function Detect_Collision(X_Start, Y_Start, X, Y : in Integer; 
				Block : in Block_Type;
			        Board : in Board_Type    ) return Boolean is
	 
	 True_X : Integer := (X - X_Start)/2 + 1;
	 True_Y : Integer := (Y-Y_Start) + 1;
      
      begin
	 
	 if Y-Y_Start < 0 then
	    return False;
	    end if;
      
	 for U in 1..4 loop
	    for I in 1..4 loop
	       if Block(U,I).Value = True then		  
		  if True_X + U -1 < 1 or True_X+U-1 > 10 or True_Y + I -1 > 20 then
		     return True;
		  elsif Board(True_X+U-1,True_Y+I-1).Value = True then
		     return True;
		  end if;
	       end if;
	    end loop;
	 end loop;
           return False;
      
      end Detect_Collision;
   
   
   
   procedure Move_Down(X, Y : in out Integer; X_Start, Y_Start : in Integer; Board : in Board_Type; Block : in Block_Type) is
      ---Skicka in i underpogram
      Background_Colour : Color_Type := Black;
      
   begin
      
      Y := Y + 1;
      Clear_Behind(X, Y-1, Block);
      Draw_Falling_Piece(X, Y, Block);
      
   end Move_Down;
   
   function Check_Game_Over(X, Y, X_Start, Y_Start : in Integer; Board : in Board_Type; Block : in Block_Type) return Boolean is
      
      True_X : Integer := (X - X_Start)/2 + 1;
      True_Y : Integer := (Y-Y_Start) + 1;
      
   begin
      
      
      if Y = Y_Start and Detect_Collision(X_Start, Y_Start, X, Y +1, Block, Board) = True Then
	 return True;
      else	 
	 return False;
      end if;
	 
   end Check_Game_Over;
   
   procedure After_Lock_Block(X,Y: in out INTEGER; X_Start, Y_Start, Pos : in Integer; Board : in out Board_Type; Block : in Block_Type) is
      True_X : Integer := (X - X_Start)/2 + 1;
      True_Y : Integer := (Y-Y_Start) + 1;
	
	
   begin
      
      for U in 1..4 loop
	 for I in 1..4 loop	       
	    if Block(U,I).Value = True then		  
	       Board(True_X + U - 1, True_Y + I - 1).Value := True;
	       Board(True_X + U - 1, True_Y + I - 1).Colour := Block(U,I).Colour;
	    end if;	    
	 end loop;
      end loop;
      
      X := Pos;
      Y := Y_Start;
      
   end After_Lock_Block;
   
   function Lock_Block2(X,Y: in Integer; X_Start, Y_Start: in Integer; Block : in Block_Type; Board : in Board_Type) return Boolean is
      
   begin
      
      if Detect_Collision(X_Start, Y_Start, X, Y +1, Block, Board) = True then
	 return True;
      else
	 return False;
      end if;
      
      end Lock_Block2;
   
   procedure Lock_Block(X, Y : in out Integer; X_Start, Y_Start, Pos : in Integer; Board : in out Board_Type; Block : in out Block_Type; Next_Block, First_Block : in out Integer; R : in out Integer) is
      
      True_X : Integer := (X - X_Start)/2 + 1;
      True_Y : Integer := (Y-Y_Start) + 1;
      Next_Block_Piece : Block_Type;
      
   begin
      
      if Detect_Collision(X_Start, Y_Start, X, Y +1, Block, Board) = True then
	 for U in 1..4 loop
	    for I in 1..4 loop	       
	       if Block(U,I).Value = True then		  
		  Board(True_X + U - 1, True_Y + I - 1).Value := True;
		  Board(True_X + U - 1, True_Y + I - 1).Colour := Block(U,I).Colour;
	       end if;
	       
	    end loop;
	 end loop;
	 

	 
	 X := Pos;
	 Y := Y_Start;
	 
	 
	 
	 --Delete_Row(X_Start, Y_Start, Board, multiplier);
	 
	 
	 Clear_Behind(50, 30, Next_Block_Piece);

	 
	 Generate_Block(Next_Block, Block);
	 First_Block := Next_Block;
	 Next_Block := Random;
	 
	 Generate_Block(Next_Block, Next_Block_Piece);
	 Draw_Falling_Piece(50, 30, Next_Block_Piece);
	 R := 0;
	 
      end if;
      
    
      
     
   end Lock_Block;
   
   
   
   procedure Bubble_Sort (A : in out Score_Board_Type) is
      Temp : Integer;
   begin
      for I in reverse A'Range loop
	 for J in A'First .. I loop
	    if A(I) < A(J) then
	       Temp := A(J);
	       A(J) := A(I);
	       A(I) := Temp;
	    end if;
	 end loop;
      end loop;
   end Bubble_Sort;
   
   
   procedure New_Score_And_Sort(Score_Board : in out Score_Board_Type; Score : in Integer) is
   begin
      
      Bubble_Sort(Score_Board);
      
      
      for I in reverse 1..5 loop
	 if Score > Score_Board(I) then
	    
	    for U in 1..I loop 
	       if U-1 > 0 then
		  Score_Board(U-1) := Score_Board(U);
	       end if;
	    end loop;
	    
	    Score_Board(I) := Score; 
	    
	    exit;
	 end if;
      end loop;
      
      
   end New_Score_And_Sort;
   
   
   
    
   
   end Tetris_Engine;
