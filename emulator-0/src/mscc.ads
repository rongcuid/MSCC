-- The top level API.

package MSCC is
   procedure Hello
   with Export => True, Convention => C, External_Name => "MSCC_Hello";
end MSCC;
