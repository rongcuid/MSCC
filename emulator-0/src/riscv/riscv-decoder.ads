with Interfaces; use Interfaces;

package RISCV.Decoder is
   type Opcode_Field is range 0 .. 2**7 - 1;
   type Register_Field is range 0 .. 31;
   type Func3_Field is range 0 .. 7;
   type Func7_Field is range 0 .. 2**7 - 1;
   type Imm11_Field is range 0 .. 2**11 - 1;
   type R_Type is record
      Opcode : Opcode_Field;
      R_D    : Register_Field;
      Func_3 : Func3_Field;
      R_S1   : Register_Field;
      R_S2   : Register_Field;
      Func_7 : Func7_Field;
   end record
   with Size => 32;
   for R_Type use
     record
       Opcode at 0 range 0 .. 6;
       R_D at 0 range 7 .. 11;
       Func_3 at 0 range 12 .. 14;
       R_S1 at 0 range 15 .. 19;
       R_S2 at 0 range 20 .. 24;
       Func_7 at 0 range 25 .. 31;
     end record;

   type I_Type is record
      Opcode   : Opcode_Field;
      R_D      : Register_Field;
      Func_3   : Func3_Field;
      R_S1     : Register_Field;
      Imm_11_0 : Imm11_Field;
   end record
   with Size => 32;
   for I_Type use
     record
       Opcode at 0 range 0 .. 6;
       R_D at 0 range 7 .. 11;
       Func_3 at 0 range 12 .. 14;
       R_S1 at 0 range 15 .. 19;
       Imm_11_0 at 0 range 20 .. 31;
     end record;

   type S_Type is record
      Opcode   : Integer;
      Imm_4_0  : Integer;
      Func_3   : Integer;
      R_S1     : Integer;
      R_S2     : Integer;
      Imm_11_5 : Integer;
   end record;

   type B_Type is record
      Opcode   : Integer;
      Imm_11   : Integer;
      Imm_4_1  : Integer;
      Func_3   : Integer;
      R_S1     : Integer;
      R_S2     : Integer;
      Imm_10_5 : Integer;
      Imm_12   : Integer;
   end record;

   type U_Type is record
      Opcode    : Integer;
      R_D       : Integer;
      Imm_31_12 : Integer;
   end record;

   type J_Type is record
      Opcode    : Integer;
      R_D       : Integer;
      Imm_19_12 : Integer;
      Imm_11    : Integer;
      Imm_10_1  : Integer;
      Imm_20    : Integer;
   end record;

   type Instruction_Encoding is (Word, R, I);
   type Instruction_View (Encoding : Instruction_Encoding := Word) is record
      case Encoding is
         when Word =>
            W : Unsigned_32;

         when R =>
            R : R_Type;

         when I =>
            I : I_Type;
      end case;
   end record
   with Unchecked_Union, Size => 32;
end RISCV.Decoder;
