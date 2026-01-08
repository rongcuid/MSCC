package RISCV.Registers is
   subtype Register_Word is Integer;
   type General_Purpose_Registers is array (1 .. 31) of Register_Word;
   type Register_File is record
      GPR : General_Purpose_Registers;
   end record;
end RISCV.Registers;
