with Ada.Integer_Text_Io, Ada.Text_Io;
use Ada.Integer_Text_Io, Ada.Text_Io;


with TJa.Window.Graphic; use TJa.Window.Graphic;
with TJa.Window.Elementary; use TJa.Window.Elementary;
with TJa.Window.Text; use TJa.Window.Text;
with TJa.Keyboard; use TJa.Keyboard;

package body Tetris_Graphics is
   
   
   procedure Print_Board(X, Y : in Integer; Board : in Board_Type) is
    
  begin
     
     GoTo_XY(X, Y);
     
     
     for I in 1..20 loop
	for U in 1..10 loop
	   if Board(U, I).Value = False then
	      Set_Background_Colour(White);
	      Set_Foreground_Colour(Black);
	      Put(Blended_Raster, Times => 2);
	   else
	      Set_Foreground_Colour(Board(U,I).Colour);
	      Put(Blended_Raster, Times => 2);
	   end if;
	   end loop;
	GoTo_XY(X, Y + I);
	
     end loop;
     
     GoTo_XY(X-2, Y-1);
     
     Set_Foreground_Colour(Blue);
     Put(Blended_Raster, Times => 2*12);
     
    for U in 0..20 loop
	GoTo_XY(X-2, Y+U);
	Put(Blended_Raster, 2);
	GoTo_XY(X+20, Y+U);
	Put(Blended_Raster, 2);
     end loop;
     
     Goto_XY(X-2, Y+20);
    Put(Blended_Raster, 2*12);
     
     
     
     
  end Print_Board;
  
  procedure Clear_Behind(X, Y : in Integer; Block : in Block_Type) is
     Tmp_X : Integer := X;
  begin
     
     GoTo_XY(X,Y);
     
    
     for U in 1..4 loop --Y
	for I in 1..4 loop --X
	   if Block(I,U).Value = True then
	      Set_Foreground_Colour(Black);
	      
	      Put(Blended_Raster, Times => 2);
	   else
	      GoTo_XY(X+I*2,Y- 1+U);
	   end if;
	   
	end loop;
	GoTo_XY(X, Y+U);
     end loop;
     
 
     
  end Clear_Behind;
  
  procedure Draw_Falling_Piece(X, Y : in Integer; Block : in Block_type) is
     
  begin
     
     GoTo_XY(X,Y);
     
     for U in 1..4 loop --Y
	for I in 1..4 loop --X
	   if Block(I,U).Value = True then
	      Set_Foreground_Colour(Block(I,U).Colour);
	      Put(Blended_Raster, Times => 2);
	   else
	     GoTo_XY(X+I*2,Y- 1+U);
	   end if;
	   
	end loop;
	GoTo_XY(X, Y+U);
     end loop;
     
     end Draw_Falling_Piece;
     
   
   end Tetris_Graphics;
