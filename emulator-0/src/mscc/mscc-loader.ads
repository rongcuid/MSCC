-- This package handles loading executables up to memory.
with MSCC.Memory; use MSCC.Memory;

package MSCC.Loader is
   -- stub
   function Load_Intel_Hex (Hex : String) return Mapped_Memory;
end MSCC.Loader;
