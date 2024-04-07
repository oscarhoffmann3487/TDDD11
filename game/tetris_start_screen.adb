with Ada.Integer_Text_Io, Ada.Text_Io;
use Ada.Integer_Text_Io, Ada.Text_Io;

with TJa.Window.Graphic;    use TJa.Window.Graphic;
with TJa.Window.Elementary; use TJa.Window.Elementary;
with TJa.Window.Text;       use TJa.Window.Text;
with TJa.Keyboard;          use TJa.Keyboard;
with TJa.Calendar;          use Tja.Calendar;


package body Tetris_Start_Screen is
   
       procedure Print_Score(X, Y : in Integer; Score_Board : in Score_Board_Type) is
	Counter : Integer := 1;
     begin
	
	
       Set_Background_Colour(White);
       Set_Foreground_Colour(Black);	
       
	Goto_XY(X+50,Y+20);
	Put("  Highscores:        ");
	for I in reverse 1..5 loop
	   Goto_XY(X+50, Y + 20 + I);
	   Put("                     ");
	    Goto_XY(X+50, Y + 20 + I);
	   Put(I);
	   Put(". ");
	   
	   
	   Put(Score_Board(Counter ), 1);
	   Counter := Counter + 1;
	 
	   
	   
   end loop;
	
	
     end Print_Score;
     
   procedure Options_Menu(Counter, X_Start, Y_Start, Background_Length, Background_height : in Integer; Option_Boolean : in out Boolean) is 
   begin
    ----------------------------------  
   Set_Background_Colour(White);
   Set_Foreground_Colour(Dark_grey);
   
   if Counter = 1 then
   Set_Background_Colour(Dark_grey);
   Set_Foreground_Colour(White);
   end if;
   
   Goto_XY(X_Start+(Background_Length/2)-6, Y_Start+Background_Height/2-3);
   if Option_Boolean = True then
   Put("   EASY    ");
   else  
   Put("   PLAY    ");
   end if;
  -------------------------- 
   Set_Background_Colour(White);
   Set_Foreground_Colour(Dark_grey);
   
   if Counter = 2 then 
   Set_Background_Colour(Dark_grey);
   Set_Foreground_Colour(White);
   end if;
   
   Goto_XY(X_Start+(Background_Length/2)-6, Y_Start+Background_Height/2);
   if Option_Boolean = True then
   Put("  MEDIUM   ");
   else 
   Put(" HIGHSCORE ");
   end if;
   ------------------------------------
   Set_Background_Colour(White);
   Set_Foreground_Colour(Dark_grey);
   
   if Counter = 3 then
   Set_Background_Colour(Dark_grey);
   Set_Foreground_Colour(White);
   end if;
   
   Goto_XY(X_Start+(Background_Length/2)-6, Y_Start+Background_Height/2+3);
   if Option_Boolean = True then
   Put("   HARD    ");
   else 
   Put("  OPTIONS  ");
   end if;
   ----------------------------------
   Set_Background_Colour(White);
   Set_Foreground_Colour(Dark_grey);
   
   if Counter = 4 then
   Set_Background_Colour(Dark_grey);
   Set_Foreground_Colour(White);  
   end if;
   
   Goto_XY(X_Start+(Background_Length/2)-6, Y_Start+Background_Height/2+6);
   if Option_Boolean = True then
      Put("  EXTREME  ");
   else 
   Put("   EXIT    "); 
   end if;

   Set_Background_Colour(White);
   Set_Foreground_Colour(Dark_grey);  
   end Options_Menu;
   
   
   
   procedure Start_Screen(X_Start, Y_Start : in Integer; Finish : in out Boolean; Speed : in out Integer; Score_Board : in Score_Board_Type) is
   
   Key : Key_Type; 
   Option_Boolean : Boolean;
   Tetris_Start_X : Integer;
   Tetris_Start_Y : Integer;
   Background_Length : constant Integer := 74;
   Background_Height : constant Integer := 40;
   Width : constant Integer := 2;    
   Counter : Integer := 1;
   begin
   Clear_Window;
   Set_Background_Colour(White);
   Tetris_Start_X := X_Start+10;
   Tetris_Start_Y := Y_Start+6;
   --------------------------------puttar bakgrunden
   Set_foreground_colour(blue);
   Goto_XY(X_Start, Y_Start);
   for I in 1 .. Background_Height loop
      for J in 1 .. Background_Length loop
	 Put(Blended_Raster,1);
      end loop;
      Goto_XY(X_Start, Y_Start + I);
   end loop;
   Cursor_Invisible;
   
   Set_Background_Colour(Dark_grey);
   Set_Foreground_Colour(white); 
   Goto_XY(X_Start+11,Y_Start+Background_Height-1);
   Put(" Use arrow keys to navigate, press enter to select. ");
    Goto_XY(X_Start,Y_Start+Background_height);
   Put(" Created by Emil Imhagen, Erik Hjalmarsson, Julia Jaksic & Oscar Hoffmann ");
   
   -----------------------------------puttar den gråa rutan kring tetris
   Set_Background_Colour(blue);
   Set_Foreground_Colour(dark_Grey);
   Goto_XY(Tetris_Start_X-2, Tetris_Start_Y-1);
   for I in 1..9 loop
      for J in 1..60 loop
	 Put(Blended_Raster,1);
      end loop;
      Goto_XY(Tetris_Start_X-2,Tetris_Start_Y-1+I);
      end loop;
   
   ----------------------------- T
   Goto_XY(Tetris_Start_X, Tetris_Start_Y);
   Set_foreground_colour(Red);
   Put(Blended_Raster, Times => Width*5);
   for I in 1 .. 6 loop  
   Goto_XY(Tetris_Start_X+4, Tetris_Start_Y+I);   
   Put(Blended_Raster, Times => width);
   end loop;
   ----------------------------------   
      
   Tetris_Start_X := Tetris_Start_X + 12;
      
      ----------------------------- E
   Goto_XY(Tetris_Start_X, Tetris_Start_Y);
   Set_Background_Colour(Red);
   Set_Foreground_Colour(Light_grey);
   Put(Blended_Raster, Times => Width*4);
   Goto_XY(Tetris_Start_X, Tetris_Start_Y+3);
   Put(Blended_Raster, Times => Width*4);
   Goto_XY(Tetris_Start_X, Tetris_Start_Y+6);
   Put(Blended_Raster, Times => Width*4);
   
   for I in 1 .. 6 loop  
   Goto_XY(Tetris_Start_X, Tetris_Start_Y+I);   
   Put(Blended_Raster, Times => width);
   end loop;
   ---------------------------------- 
   Set_Background_Colour(white);
   Tetris_Start_X := Tetris_Start_X + 10;
     
   ----------------------------- T
   Goto_XY(Tetris_Start_X, Tetris_Start_Y);
   Set_Foreground_Colour(Bright_Yellow);
   Put(Blended_Raster, Times => Width*5);
   for I in 1 .. 6 loop  
   Goto_XY(Tetris_Start_X+4, Tetris_Start_Y+I);   
   Put(Blended_Raster, Times => width);
   end loop;
   ---------------------------------- 
   
   Tetris_Start_X := Tetris_Start_X + 12;
   
   -------------------------------------- R
   Goto_XY(Tetris_Start_X, Tetris_Start_Y);
   Set_Foreground_Colour(green);
   Put(Blended_Raster, Times => 7);
   Goto_XY(Tetris_Start_X, Tetris_Start_Y+3);
   Put(Blended_Raster, Times => 7);

   for I in 1..2 loop
   Goto_XY(Tetris_Start_X+6, Tetris_Start_Y+I);   
   Put(Blended_Raster, Times => Width);
   end loop;
   
   for J in 1 .. 6 loop  
   Goto_XY(Tetris_Start_X, Tetris_Start_Y+J);   
   Put(Blended_Raster, Times => width);
   end loop;
   
   Goto_XY(Tetris_Start_X+2, Tetris_Start_Y+4);    
   Put(Blended_Raster, Times => 3); 
   
   Goto_XY(Tetris_Start_X+3, Tetris_Start_Y+5);    
   Put(Blended_Raster, Times => 3); 
   
   Goto_XY(Tetris_Start_X+5, Tetris_Start_Y+6);    
   Put(Blended_Raster, Times => 3); 
   
   -------------------------------- 
   
   Tetris_Start_X := Tetris_Start_X + 10;
   
   ------------------------------------ I
   Goto_XY(Tetris_Start_X, Tetris_Start_Y);
   Set_Foreground_Colour(Bright_blue);
   for I in 1 .. 7 loop  
   Goto_XY(Tetris_Start_X, Tetris_Start_Y-1+I);   
   Put(Blended_Raster, Times => width);
   end loop;
   ----------------------------------
   
   --------------------------------------- S
   Tetris_Start_X := Tetris_Start_X + 4;
   Set_Foreground_Colour(magenta);
   
   Goto_XY(Tetris_Start_X+1, Tetris_Start_Y);
   Put(Blended_Raster, Times => 6);
   
   Goto_XY(Tetris_Start_X+1, Tetris_Start_Y+3);
   Put(Blended_Raster, Times => 6);
   
   Goto_XY(Tetris_Start_X+1, Tetris_Start_Y+6);
   Put(Blended_Raster, Times => 6);
   
   Goto_XY(Tetris_Start_X, Tetris_Start_Y+1);
   Put(Blended_Raster, Times => Width);
   Goto_XY(Tetris_Start_X, Tetris_Start_Y+2);
   Put(Blended_Raster, Times => width);
   
   Goto_XY(Tetris_Start_X+6, Tetris_Start_Y+4);
   Put(Blended_Raster, Times => Width);
   Goto_XY(Tetris_Start_X+6, Tetris_Start_Y+5);
   Put(Blended_Raster, Times => Width);
   
   Goto_XY(Tetris_Start_X+6, Tetris_Start_Y+1);
   Put(Blended_Raster, Times => Width);
   
   Goto_XY(Tetris_Start_X, Tetris_Start_Y+5);
   Put(Blended_Raster, Times => 2);
   ------------------------------------------  
   Option_Boolean := False;
   loop
   
   Options_Menu(Counter, X_Start, Y_Start, Background_Length, Background_Height, Option_Boolean);
      
   Get_Immediate(Key);
  
   if Is_Up_Arrow(Key) then
   if Counter = 1 then 
      Counter := 4;
   else Counter := Counter -1;
   end if;
      
   elsif Is_Down_arrow(Key) then
      Counter := Counter + 1;
      if Counter = 5 then
	 Counter := 1;
      end if;
-----------------------------------   
   elsif Is_Return(Key) then 
 -------------------------------     
      if Counter = 1 then 
	  if Option_Boolean = True then
	     Speed := 1;
	   Option_Boolean := false;
	  else
	     exit;
       end if;
 -----------------------------
      elsif Counter = 2 then
	  if Option_Boolean = True then
	     Speed := 2;
	    Option_Boolean := False;
	  else
	 Print_Score(X_start, Y_Start, Score_Board);
	  end if;
 ------------------------------------ 
      elsif Counter = 3 then
	 
	 if Option_Boolean = True then
	    Speed := 3;
	  Option_Boolean := False;
	  else
        Option_Boolean := True;
	 end if;
	 
----------------------------------	 
      elsif Counter = 4 then
       if Option_Boolean = True then
	    Speed := 4;
	  Option_Boolean := False;
       else
         Finish := True; 
	  exit; 
	   end if;
	
      end if;
   end if;
    
  end loop;
   Goto_XY(X_Start,Y_Start+Background_height);

end Start_Screen;
end;
