
with Tetris_Graphics;       use Tetris_Graphics;
with Tetris_Engine;         use Tetris_Engine;
package Data_Structure is
   
   procedure Generate_Block(W : in Integer; Block : in out Block_Type; R : in Integer := 0);
   
   function Random return Integer;
   
   end Data_Structure;
