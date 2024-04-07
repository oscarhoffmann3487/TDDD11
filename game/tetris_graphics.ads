with Tja.Window.Text; use Tja.Window.Text;
with Tetris_Engine; use Tetris_Engine;


package Tetris_Graphics is
  
   procedure Print_Board(X, Y: in Integer; Board : in Board_Type);
   procedure Clear_Behind(X, Y : in Integer; Block : in Block_type);
   
   procedure Draw_Falling_Piece(X, Y : in Integer; Block : in Block_type);
  
  end Tetris_Graphics;
