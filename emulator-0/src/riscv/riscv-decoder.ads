with Interfaces; use Interfaces;
with System;

package RISCV.Decoder is
   type Opcode_Field is mod 2**7;
   subtype Register_Field is Natural range 0 .. 31;
   type Func_3_Field is mod 2**3;
   type Func_7_Field is mod 2**7;
   type Imm_11_0_Field is mod 2**12;
   type Imm_4_0_Field is mod 2**5;
   type Imm_11_5_Field is mod 2**7;
   type Imm_11_Field is mod 2**1;
   type Imm_4_1_Field is mod 2**4;
   type Imm_10_5_Field is mod 2**6;
   type Imm_12_Field is mod 2**1;
   type Imm_31_12_Field is mod 2**20;
   type Imm_19_12_Field is mod 2**8;
   type Imm_10_1_Field is mod 2**10;
   type Imm_20_Field is mod 2**1;

   type R_Type is record
      Opcode : Opcode_Field;
      R_D    : Register_Field;
      Func_3 : Func_3_Field;
      R_S1   : Register_Field;
      R_S2   : Register_Field;
      Func_7 : Func_7_Field;
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
   for R_Type'Bit_Order use System.Low_Order_First;

   type I_Type is record
      Opcode   : Opcode_Field;
      R_D      : Register_Field;
      Func_3   : Func_3_Field;
      R_S1     : Register_Field;
      Imm_11_0 : Imm_11_0_Field;
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
   for I_Type'Bit_Order use System.Low_Order_First;

   type S_Type is record
      Opcode   : Opcode_Field;
      Imm_4_0  : Imm_4_0_Field;
      Func_3   : Func_3_Field;
      R_S1     : Register_Field;
      R_S2     : Register_Field;
      Imm_11_5 : Imm_11_5_Field;
   end record
   with Size => 32;
   for S_Type use
     record
       Opcode at 0 range 0 .. 6;
       Imm_4_0 at 0 range 7 .. 11;
       Func_3 at 0 range 12 .. 14;
       R_S1 at 0 range 15 .. 19;
       R_S2 at 0 range 20 .. 24;
       Imm_11_5 at 0 range 25 .. 31;
     end record;
   for S_Type'Bit_Order use System.Low_Order_First;

   type B_Type is record
      Opcode   : Opcode_Field;
      Imm_11   : Imm_11_Field;
      Imm_4_1  : Imm_4_1_Field;
      Func_3   : Func_3_Field;
      R_S1     : Register_Field;
      R_S2     : Register_Field;
      Imm_10_5 : Imm_10_5_Field;
      Imm_12   : Imm_12_Field;
   end record
   with Size => 32;
   for B_Type use
     record
       Opcode at 0 range 0 .. 6;
       Imm_11 at 0 range 7 .. 7;
       Imm_4_1 at 0 range 8 .. 11;
       Func_3 at 0 range 12 .. 14;
       R_S1 at 0 range 15 .. 19;
       R_S2 at 0 range 20 .. 24;
       Imm_10_5 at 0 range 25 .. 30;
       Imm_12 at 0 range 31 .. 31;
     end record;
   for B_Type'Bit_Order use System.Low_Order_First;

   type U_Type is record
      Opcode    : Opcode_Field;
      R_D       : Register_Field;
      Imm_31_12 : Imm_31_12_Field;
   end record
   with Size => 32;
   for U_Type use
     record
       Opcode at 0 range 0 .. 6;
       R_D at 0 range 7 .. 11;
       Imm_31_12 at 0 range 12 .. 31;
     end record;
   for U_Type'Bit_Order use System.Low_Order_First;

   type J_Type is record
      Opcode    : Opcode_Field;
      R_D       : Register_Field;
      Imm_19_12 : Imm_19_12_Field;
      Imm_11    : Imm_11_Field;
      Imm_10_1  : Imm_10_1_Field;
      Imm_20    : Imm_20_Field;
   end record
   with Size => 32;
   for J_Type use
     record
       Opcode at 0 range 0 .. 6;
       R_D at 0 range 7 .. 11;
       Imm_19_12 at 0 range 12 .. 19;
       Imm_11 at 0 range 20 .. 20;
       Imm_10_1 at 0 range 21 .. 30;
       Imm_20 at 0 range 31 .. 31;
     end record;
   for J_Type'Bit_Order use System.Low_Order_First;

   type Instruction_Encoding is (Word, R, I, S, B, U, J);
   type Instruction_View (Encoding : Instruction_Encoding := Word) is record
      case Encoding is
         when Word =>
            W : Unsigned_32;

         when R =>
            R : R_Type;

         when I =>
            I : I_Type;

         when S =>
            S : S_Type;

         when B =>
            B : B_Type;

         when U =>
            U : U_Type;

         when J =>
            J : J_Type;
      end case;
   end record
   with Unchecked_Union, Size => 32;
end RISCV.Decoder;
