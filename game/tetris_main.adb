with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Text_IO;           use Ada.Text_IO;


with TJa.Window.Graphic;    use TJa.Window.Graphic;
with TJa.Window.Elementary; use TJa.Window.Elementary;
with TJa.Window.Text;       use TJa.Window.Text;
with TJa.Keyboard;          use TJa.Keyboard;
with TJa.Calendar;          use Tja.Calendar;



with Ada.Sequential_IO;


----------Våra Paket------------
with Tetris_Graphics; use Tetris_Graphics;

with Tetris_Engine; use Tetris_Engine;

with Data_Structure; use Data_Structure;

with Tetris_Start_Screen; use Tetris_Start_Screen;

procedure Tetris_Main is
   
   

   
   package Seq_IO is new Ada.Sequential_IO(Score_Board_Type);
   use Seq_IO;
   
   
   Score_Board : Score_Board_Type;
   Score_File  : Seq_IO.FILE_TYPE;
   
   
   
   ---Ändrar brädets position i x-led---
   X_Start : constant Integer := 38 * 2;
   Y_Start : constant Integer := 5;
   
   ---Ändrar startposition av block--
   Spawn_Pos : constant Integer := X_Start + 8;
   
   
   
   Current_X : Integer := Spawn_Pos; 
   Current_Y : Integer := Y_Start;
   
   Next_Block : Integer := Random; -- Håller koll på nästa block
   First_Block : Integer := Random; -- Genererar första blocket
   ----------------------------Test Region-----------------------------------
   
   
   
   Block : Block_Type; -- Vårt mainblock.
   
   
   --------------------------------------------------------------------------
   
   Background_colour : Colour_Type := Black;
   Board : Board_Type := New_Board;
   Key   : Key_Type;
   Available : Boolean;
   Finish : Boolean;
   Time_Loop : Boolean := True;
   Initial_Clock : Time_Type := Get_Time(Clock);
   Time_Delay : Time_Interval_Type;
   Random_Number : Integer := Random;
   Rotation : Integer := 0;
   Multiplier : Integer := 0;
   Score : Integer := 0;
   Speed : Integer := 0;
   Next_Rotation : Block_Type;
   Next_Block_Piece : Block_Type;
   
   procedure Update_Score(Multiplier, Score : in out Integer; Speed : in Integer) is
      
   begin
      
      if Multiplier = 1 then
	 if Speed = 1 then
	    Score := Score + 100;
	 elsif Speed = 2 then
	    Score := Score + 150;
	 elsif Speed = 3 then
	    Score := Score + 700;
	 elsif Speed = 4 then
	    Score := Score + 1000;
	 end if;
      elsif Multiplier = 2 then
	 if Speed = 1 then
	    Score := Score + 300;
	 elsif Speed = 2 then
	    Score := Score + 350;
	 elsif Speed = 3 then
	    Score := Score + 800;
	 elsif Speed = 4 then
	    Score := Score + 1200;
	 end if;

      elsif Multiplier = 3 then
	 if Speed = 1 then
	    Score := Score + 500;
	 elsif Speed = 2 then
	    Score := Score + 550;
	 elsif Speed = 3 then
	    Score := Score + 1000;
	 elsif Speed = 4 then
	    Score := Score + 1500;
	 end if;
      elsif Multiplier = 4 then
	 if Speed = 1 then
	    Score := Score + 800;
	 elsif Speed = 2 then
	    Score := Score + 850;
	 elsif Speed = 3 then
	    Score := Score + 1200;
	 elsif Speed = 4 then
	    Score := Score + 2000;
	 end if;
     
      elsif Multiplier = 5 then
	 Score := Score + 1;
      elsif Multiplier = 6 then
	 Score := Score + 2;
      end if;
     
	 
	 Set_Foreground_Colour(Black);
	 GoTo_XY(X_Start+24, Y_Start+3);
	 Put("Score:");
	 Put(Score, 10);
	
      
      Multiplier := 0;
      
   end Update_Score;
   
    function Solve(R : in integer) return Integer is
      
   begin
      if R + 90 = 360 then
	 return 0;
      else
	 return R + 90;
	 end if;
   end Solve;
   
   function Detect(Block1 : in BLock_Type; Board : in Board_Type) return Boolean is
      True_X : Integer := (Current_X - X_Start)/2 + 1;
      True_Y : Integer := (Current_Y-Y_Start) + 1;
      Counter : Integer := 0;
   begin
      
      for I in 1..4 loop
	 for U in 1..4 loop
	    if Block1(U,I).Value = True then
	       if True_X+U-1 < 10 and True_X+U-1 > 1 and True_Y+I-1 > 1 and True_Y+I-1 < 20  Then
		  if Board(True_X+U-1,True_Y+I-1).Value = True then
		  return False;
		  end if;
	       end if;
	    end if;	 end loop;
      end loop;
      
   
	 
	 return True;
      
      

      
      end Detect;
   
  
   
begin

   Finish := False;

   loop
   Open(Score_File, In_File, "Highscore.txt");
   Read(Score_File, Score_Board);
   Close(Score_File); 
   Start_Screen(X_Start-20, Y_Start-2, Finish, Speed, Score_Board); 
   Score := 0;
  if Speed = 1 then
   Time_Delay := To_Time_Interval_Type("00:00:00.60");
   elsif Speed = 2 then
   Time_Delay := To_Time_Interval_Type("00:00:00.40");
   elsif Speed = 3 then
   Time_Delay := To_Time_Interval_Type("00:00:00.20");  
   elsif Speed = 4 then 
   Time_Delay := To_Time_Interval_Type("00:00:00.10");
   else 
   Time_Delay := To_Time_Interval_Type("00:00:00.40");
   end if;
   
  
	 
   if Finish = True then
   exit;
   elsif Finish = False then
  
   Set_Buffer_Mode(Off);
   Set_Echo_Mode(Off);
   Cursor_Invisible;
  
  
   Clear_Window;
   delay 0.2;
 
   for I in 1..20 loop -- tömmer så att man kan spela igen utan att starta om spelet
      for U in 1..10 loop
	 Board(U, I).Value := False;
      end loop;
   end loop;
   
   Print_Board(X_Start, Y_Start, Board);
   Set_Foreground_Colour(Black);
   Goto_XY(X_Start+23, Y_Start+17);
   Put("-Use arrows to rotate block");
   Goto_XY(X_Start+23, Y_Start+18);
   Put("-Press spacebar to drop block");
   Goto_XY(X_Start+23, Y_Start+19);
   Put("-Press esc to navigate to menu");
   Goto_XY(X_Start+23, Y_Start+20);
   Put("-Press ""p"" to pause game");
   
   Generate_Block(First_Block, Block);
   Draw_Falling_Piece(Current_X, Current_Y, Block);
   
   Next_Rotation := Block;
   Generate_Block(First_Block, Next_Rotation, Solve(Rotation));
   delay 0.1;
  
   ---------------------------- Main game loop------------
   loop
        
      
      
      Goto_XY(4, 4);
      Update_Score(Multiplier, Score, Speed);
   ----------------------Sköter auto-movement-----------------------------
      if Initial_Clock + Time_Delay < Get_Time(Clock) then
   	 Time_Loop := True;
   	 Initial_Clock := Get_Time(Clock);
	 
	 if Lock_Block2(Current_X, Current_Y, X_Start, Y_Start, Block, Board) then
	    After_Lock_Block(Current_X, Current_Y, X_Start, Y_Start, Spawn_Pos, Board, Block);
	    Delete_Row(X_Start, Y_Start, Board, multiplier);
	    

     Generate_Block(Next_Block, Block);
	    Clear_Behind(50, 30, Next_Block_Piece);

	    
	 --   Generate_Block(Next_Block, Block);
	    First_Block := Next_Block;
	    Next_Block := Random;
	    
	    Generate_Block(Next_Block, Next_Block_Piece);
	    Draw_Falling_Piece(50, 30, Next_Block_Piece);
	    Rotation := 0;
	    
	    

	    if Check_Game_Over(Current_X, Current_Y, X_Start, Y_Start, Board, Block) = True then
	       Draw_Falling_Piece(Current_X, Current_Y, Block);
	        Goto_XY(X_Start+5, Y_Start+22);
		   Set_Foreground_Colour(Black); 
               
		   Put("Game Over!");
        delay 2.0;
	       exit;
	    end if;
	    Next_Rotation := Block;
	    Generate_Block(First_Block, Next_Rotation, Solve(Rotation));
	    end if;
	 	 
      end if;
      
      if Time_Loop = True then	 
      	 Move_Down(Current_X, Current_Y, X_Start, Y_Start, Board, Block);
      	 Time_Loop := False;
	 
	 
      end if;
      Set_Foreground_Colour(Black);
      Get_Immediate(Key, Available);
      
      exit when Is_Esc(Key);
      if Is_Character(Key) and then To_Character(Key) = 'p' then
	 Goto_XY(X_Start+5, Y_Start+22);
	 Put("Game paused");
	 Get_Immediate(Key);
	 Goto_XY(X_Start+5, Y_Start+22);
	 Put("           ");
	    end if;
      
      ----------------Check for movement------------------
      
      
      --Implementera rotation när upp-pilen trycks-------------
	if Is_Up_Arrow(Key) then
	   

	   
	   if First_Block = 1 and ((Current_X - X_Start)/2 + 1) = 8 then
	      Clear_Behind(Current_X, Current_Y, Block);
	      Current_X := Current_X - 2;

		 
	      elsif First_Block = 1 and ((Current_X - X_Start)/2 + 1) = 9 then
		 Clear_Behind(Current_X, Current_Y, Block);
		 Current_X := Current_X - 4;

		 
	      elsif First_Block = 6 and ((Current_X - X_Start)/2 + 1) = 9 then
		 Clear_Behind(Current_X, Current_Y, Block);
		 Current_X := Current_X - 2;

		 
	   elsif First_Block = 1 and (Current_Y - Y_Start + 1) = 19 then
	      Clear_Behind(Current_X, Current_Y, Block);
	      Current_Y := Current_Y - 2;

	      
	   elsif First_Block = 6 and (Current_Y - Y_Start + 1) = 19 then
	      Clear_Behind(Current_X, Current_Y, Block);
	      Current_Y := Current_Y - 2;

		 
	      end if;
	   

	   
	   
	   if Detect(Next_Rotation, Board) = true then
	      
	      Clear_Behind(Current_X, Current_Y, Block);

	   
	   if First_Block /= 4 then
	   
	      if Current_X = X_Start - 2 then
		 Current_X := Current_X + 2;
	      
	      end if;
	   
	   end if;
	      
	      
	      Rotation := Rotation + 90;
	      if Rotation = 360 then
		 Rotation := 0;
	      end if;
	      Clear_Behind(Current_X, Current_Y, Block);
	      Generate_Block(First_Block, Block, Rotation);
	      Draw_Falling_Piece(Current_X, Current_Y, Block);
	      Next_Rotation := Block;
	      Generate_Block(First_Block, Next_Rotation, Solve(Rotation));
	   end if;
	   
	
      
	
	elsif Is_Down_Arrow(Key) 
	  and Detect_Collision(X_Start, Y_Start, Current_X, Current_Y +1, Block, Board) = false then	 
	   Current_Y := Current_Y + 1;
	   Multiplier := 5;
	   Update_Score(Multiplier, Score, speed);
	    Clear_Behind(Current_X, Current_Y - 1, Block);
	    Draw_Falling_Piece(Current_X, Current_Y, Block);	   
	elsif Is_Left_Arrow(Key) 
	  and Detect_Collision(X_Start, Y_Start, Current_X-2, Current_Y, Block, Board) = false Then
	   Current_X := Current_X - 2;
	   Clear_Behind(Current_X + 2, Current_Y, Block);
	   Draw_Falling_Piece(Current_X, Current_Y, Block);   
	elsif Is_Right_Arrow(Key) 
	and Detect_Collision(X_Start, Y_Start, Current_X+2, Current_Y, Block, Board) = False then
	   Current_X := Current_X + 2;
	   Clear_Behind(Current_X - 2, Current_Y, Block);
	   Draw_Falling_Piece(Current_X, Current_Y, Block);	   
	   
	elsif Is_Character(Key) and then To_Character(Key) = ' ' then
	     while Detect_Collision(X_Start, Y_Start, Current_X, Current_Y+1, Block, Board) = false loop
		
		Move_Down(Current_X, Current_Y, X_Start, Y_Start, Board, Block);
		Multiplier := 6;
		Update_Score(Multiplier, Score, speed);
	     end loop;
	     
	   
	    
	     if Lock_Block2(Current_X, Current_Y, X_Start, Y_Start, Block, Board) then
		After_Lock_Block(Current_X, Current_Y, X_Start, Y_Start, Spawn_Pos, Board, Block);
		Delete_Row(X_Start, Y_Start, Board, Multiplier);
		
		

		Clear_Behind(50, 30, Next_Block_Piece);

		
		Generate_Block(Next_Block, Block);
		First_Block := Next_Block;
		Next_Block := Random;
		Next_Rotation := Block;
		Generate_Block(First_Block, Next_Rotation, Solve(Rotation));
		Generate_Block(Next_Block, Next_Block_Piece);
		Draw_Falling_Piece(50, 30, Next_Block_Piece);
		Rotation := 0;
		
		
		

		if Check_Game_Over(Current_X, Current_Y, X_Start, Y_Start, Board, Block) = True then
		   Draw_Falling_Piece(Current_X, Current_Y, Block);
		   Goto_XY(X_Start+5, Y_Start+22);
		   Set_Foreground_Colour(Black);
		   Put("Game Over!"); 
		   delay 2.0;
		  
		 exit; 
		end if;
		
		
	     end if;
	     
	end if;

      

	
      
      
   end loop;
   -------------------------------------------------------
   end if;
  
    -- Stoppar in den aktuella poängen och sorterar den till rätt plats
   
   Bubble_Sort(Score_Board);
   New_Score_And_Sort(Score_Board, Score);
   
   
   
   
   -- Sparar highscore-listan i textfilen
    Open(Score_File, Out_File, "Highscore.txt");
    Write(Score_File, Score_Board);
    Close(Score_File);
    end loop;
    
   
   Set_Buffer_Mode(On);
   Set_Echo_Mode(On);
   Cursor_Visible;
   
      
   
end Tetris_Main;
