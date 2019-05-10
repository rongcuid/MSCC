package mscc.core

import spinal.core._

class TopLevel extends Component {
  val io = new Bundle {
    val mem_ready = in Bool
    val mem_instr = out Bool
    val mem_valid = out Bool

    val mem_addr = out UInt(32 bits)
    val mem_wdata = out UInt(32 bits)
    val mem_wstrb = out Bits(4 bits)
    val mem_rdata = in UInt(32 bits)

    val irq = in Bits(32 bits)
  }
}

//Generate the MSCCTopLevel's Verilog
object TopLevelVerilog {
  def main(args: Array[String]) {
    SpinalVerilog(new TopLevel)
  }
}

//Generate the MSCCTopLevel's VHDL
object TopLevelVhdl {
  def main(args: Array[String]) {
    SpinalVhdl(new TopLevel)
  }
}

