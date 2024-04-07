with TJa.Window.Text; use TJa.Window.Text;

package Tetris_Engine is
   
   Score : Integer;
   
   type Score_Board_Type is
     array(1..5) of Integer;
   
   type Box_Type is
      record
	 Value : Boolean;
	 Colour : Colour_Type;
      end record;
   
   type Block_type is
     array(1..4,1..4) of Box_Type;
   
   type Board_Type is
     array(1..10, 1..20) of Box_Type;
   
   function New_Board return Board_Type;
   
   function Detect_Collision(X_Start, Y_Start, X, Y : in Integer; Block : in Block_Type; Board : in Board_Type) return Boolean;
   
   procedure Delete_Row(X_Start, Y_Start : in Integer; Board : in out Board_Type; Multiplier : out integer);
   -----------------------------
   
   function Lock_Block2(X,Y: in Integer; X_Start, Y_Start: in Integer; Block : in Block_Type; Board : in Board_Type) return Boolean;
   
   procedure After_Lock_Block(X,Y: in out INTEGER; X_Start, Y_Start, Pos : in Integer; Board : in out Board_Type; Block : in Block_type);
   
   
   
   
   
   procedure Move_Down(X, Y : in out Integer; X_Start, Y_Start : in Integer; Board : in Board_Type; Block : in Block_Type);
   
   procedure Lock_Block(X, Y : in out Integer; X_Start, Y_Start, Pos : in Integer; Board : in out Board_Type; Block : in out Block_Type; Next_Block, First_Block : in out Integer; R : in out integer);

   function Check_Game_Over(X, Y, X_Start, Y_Start : in Integer; Board : in Board_Type ; Block : in Block_Type) return Boolean;
   
   
   --Score handling
   procedure Bubble_Sort (A : in out Score_Board_Type);
   procedure New_Score_And_Sort(Score_Board : in out Score_Board_Type; Score : in Integer);
   
   
   end Tetris_Engine;
