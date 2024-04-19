// GoBank - where you put your registers

// Create new bank
// Add/move/delete/edit symbol

package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
)

type RegMap struct {
	name     string    // Name of register bank
	version  int       // Version tag
	size     int       // Address space Number of bits in address vector   sections Section    // List of sections
	errorCnt int       // Current number of error duing output
	sections []Section // List of sections
}

type Section struct {
	sid         int      // Section ID
	name        string   // Section name
	description string   // Section description
	parent      *Section // Allow section in sections
	offset      int      // Offset within RegMap
	size        int      // Section size
	symbols     []Symbol // Array of symbols. Double linked!!!
}

type Symbol struct {
	syid             int    // Symbol ID
	name             string // Symbol name
	section          string //
	address          int    // Address in given section
	size             int    // Number of bits in symbol
	pos              int    // Pointer to lsb in symbol
	reset            int    // Reset value
	readonly         bool   // Symbol is read only
	shortDescription string // Short description
	description      string // Long description
}

func check(e error) {
	if e != nil {
		panic(e)
	}
}

// Load register from compact file format or database

func main() {

	sys_cfg := []Symbol{
		{0, "enable_stuf", 			"sys_cfg", 0, 1, 0, 0, 		false, "Enable stuf", "Long"},
		{1, "enable_other", 		"sys_cfg", 0, 1, 1, 1, 		false, "Enable other stuf", "Long"},
		{2, "monitor_flag", 		"sys_cfg", 0, 1, 2, 0, 		true,  "Monitor internal flag", "Long"}, //Read only
		{3, "pwm_duty",			 	"sys_cfg", 1, 8, 0, 0x85, 	false, "Counter value for pwm", "Long"}, 
		{4, "debug_led", 			"sys_cfg", 2, 6, 0, 0x51, 	false, "Debug led signals", "Debug led signals"},
		{5, "spare_0",	 			"sys_cfg", 3, 8, 0, 0x11, 	false, "Spare_reg0", "Debug led signals"},
		{6, "spare_1",	 			"sys_cfg", 4, 8, 0, 0x22, 	false, "Spare_reg1", "Debug led signals"},
		{7, "spare_2", 				"sys_cfg", 5, 8, 0, 0x33, 	false, "Spare_reg2", "Debug led signals"},
	  

	}

	//syid, name, 					section, address, size, pos, reset, readonly, shortDescription, longDescription 		 make the rest of the 3 registers for adress 0, and offseet the rest
	

	amp_cfg := []Symbol{
		{0, "status", 				"amp_cfg",  0, 8, 0, 0, 	true,  "amp status ", "Long"},
		{1, "amp_init",				"amp_cfg",  1, 1, 0, 0, 	false, "send cfg to amp", "Long"},
		{8, "bootmem0",		 		"amp_cfg",  8, 8, 0, 0x40,  false, "boot mem0", "Long"},
		{9, "bootmem1", 			"amp_cfg",  9, 8, 0, 0x48,	false, "boot mem1", "Long"},
		{10, "bootmem2",	 		"amp_cfg", 10, 8, 0, 0x35,  false, "boot mem2", "Long"},
		{11, "bootmem3", 			"amp_cfg", 11, 8, 0, 0x08,	false, "boot mem3", "Long"},
		{12, "bootmem4",	 		"amp_cfg", 12, 8, 0, 0xff,  false, "boot mem4", "Long"},
		{13, "bootmem5", 			"amp_cfg", 13, 8, 0, 0xff, 	false, "boot mem5", "Long"},
		{14, "bootmem6",	 		"amp_cfg", 14, 8, 0, 0xff,  false, "boot mem6", "Long"},
		{15, "bootmem7", 			"amp_cfg", 15, 8, 0, 0xff, 	false, "boot mem7", "Long"},
	}

    sec := []Section{
		//SID, Name, description, parent, offset, size, symbols

		{0, "sys_cfg", "System configuration", 				nil, 0x00, 0x10, sys_cfg},	
		{1, "amp_cfg", "Amp config and monitor sec", 	    nil, 0x10, 0x10, amp_cfg},	
	}

	// create a array of array of symbols
	regmap := RegMap{"toi2s", 0x000001, 8, 0, sec}

	writeHDLIncludeStructFile(regmap)

	writeHDLHeader(regmap)
	writeHDLIncludes(regmap)
	writeHDLInterface(regmap)
	writeHDLRegister(regmap)
	writeHDLReadout(regmap)
	writeHDLAssign(regmap)

	writeRegFile(regmap)
	writeJSONFile(regmap)
}

func writeJSONFile(r RegMap) {
	fNameStruct := fmt.Sprintf("reg_file_%s.json", r.name)
	f, err := os.Create(fNameStruct)
	check(err)
	defer f.Close()
	w := bufio.NewWriter(f)
	fmt.Fprintf(w, "// Register database generic build system\n")
	fmt.Fprintf(w, "{\n")
	fmt.Fprintf(w, "  \"registers\": [\n")
	for nsec, sec := range r.sections {
		for ns, s := range sec.symbols {
			fmt.Fprintf(w, "    {\n")
			fmt.Fprintf(w, "      \"symbol\"      : \"%s.%s\",\n", sec.name, s.name)
			fmt.Fprintf(w, "      \"address\"     : \"0x%02x\",\n", sec.offset+s.address)
			fmt.Fprintf(w, "      \"pos\"         : \"%d\",\n", s.pos)
			fmt.Fprintf(w, "      \"size\"        : \"%d\",\n", s.size)
			fmt.Fprintf(w, "      \"reset\"       : \"%d\",\n", s.reset)
			ro := 0
			if s.readonly {
				ro = 1
			}
			fmt.Fprintf(w, "      \"readonly\"    : \"%d\",\n", ro)
			fmt.Fprintf(w, "      \"description\" : \"%s\"\n", s.shortDescription)
			if (ns == len(sec.symbols)-1) && (nsec == len(r.sections)-1) {
				fmt.Fprintf(w, "    }\n")
			} else {
				fmt.Fprintf(w, "    },\n")
			}
		}
	}
	fmt.Fprintf(w, "  ]\n")
	fmt.Fprintf(w, "}\n")
	w.Flush()
}

func writeRegFile(r RegMap) {
	fNameStruct := fmt.Sprintf("reg_file_%s", r.name)
	f, err := os.Create(fNameStruct)
	check(err)
	defer f.Close()
	w := bufio.NewWriter(f)
	f.WriteString("// Register database generic build system\n")
	for _, sec := range r.sections {
		for _, s := range sec.symbols {
			fmt.Fprintf(w, "%s.%s 0x%02x %d %d %d %s\n", sec.name, s.name, sec.offset+s.address, s.pos, s.size, s.reset, s.shortDescription)
		}
	}
	w.Flush()
}

// If emply add a dummy signal or ignor

func writeHDLIncludeStructFile(r RegMap) {
	fNameStruct := fmt.Sprintf("rb_%s_struct.svh", r.name)
	f, err := os.Create(fNameStruct)
	check(err)
	defer f.Close()
	//fmt.Printf("//1.2\n")
	w := bufio.NewWriter(f)
	f.WriteString("\n// Interface structures for registerbank symbol access\n\n")
	fmt.Fprintf(w, "\n//`ifndef _%s_\n", r.name)
	fmt.Fprintf(w, "//  `define _%s_\n", r.name)
	fmt.Fprintf(w, "\npackage %s_pkg;", r.name)
	for _ , sec := range r.sections {
		//fmt.Printf("//1.2 - %d\n", index)
		fmt.Fprintf(w, "// Wire interface for %s\n", sec.name)
		fmt.Fprintf(w, "typedef struct packed {\n")
		//fmt.Fprintf(w,"  logic dummy;\n")
 		for i := 0; i < (8 * sec.size); i++ { //HAR FJERNET DET HER-----------------------------------------------
			//for i := 0; i < (8 * (1 << sec.size)); i++ {
			//fmt.Printf("//1.2 - %d - %d \n", index, i)

			for _, s := range sec.symbols { //fhernet j
				//fmt.Printf("//1.2.3 - %d - %d - %d \n", index, i, j)

				if (s.address == i/8) && (s.pos == i%8) {
					fmt.Fprintf(w, "  logic ")
					var bitRange string
					if s.size == 1 {
						bitRange = "     "
					} else {
						bitRange = fmt.Sprintf("[%d:%d]", s.size-1, 0)
					}
					n := 30 - len(s.name)
					fmt.Fprintf(w, "%s %s; %*s // %s\n", bitRange, s.name, n, "", s.shortDescription)

				}
			}
		}
		fmt.Fprintf(w, "} rb_%s_wire_t;\n\n", sec.name)
	}
	fmt.Fprintf(w, "\nendpackage\n")
	fmt.Fprintf(w, "\n//`endif\n")

	w.Flush()
}

func writeHDLHeader(r RegMap) {
	fmt.Printf("// Register bank \n")
	fmt.Printf("// Auto generated code from %s version %d \n", r.name, r.version)
	fmt.Printf("// Written by Jørgen Kragh Jakobsen, All right reserved \n")
	fmt.Printf("//-----------------------------------------------------------------------------\n")
}

func writeHDLIncludes(r RegMap) {
	fmt.Printf("//`include \"rb_%s_struct.svh\"\n", r.name)
	fmt.Printf("import %s_pkg::*;\n", r.name)
	fmt.Printf("\n")
}

func writeHDLInterface(r RegMap) {
	fmt.Printf("module rb_%s\n", r.name)
	fmt.Printf("#(parameter ADR_BITS = %d\n", r.size)
	fmt.Printf(" )\n")
	fmt.Printf("(\n")
	fmt.Printf("	input  logic				clk,\n")
	fmt.Printf("	input  logic				resetb,\n")
	fmt.Printf("	input  logic [ADR_BITS-1:0]		address,\n")
	fmt.Printf("	input  logic [7:0]			data_write_in,\n")
	fmt.Printf("	output logic [7:0] 			data_read_out,\n")
	fmt.Printf("	input  logic 				reg_en,\n")
	fmt.Printf("	input  logic 				write_en,\n")
	fmt.Printf("//---------------------------------------------\n")
	var c = ','
	for i, sec := range r.sections {
		if i == len(r.sections)-1 {
			c = ' '
		}
		n := 20 - len(sec.name)
		fmt.Printf("	inout rb_%s_wire_t %*s%s%c\n", sec.name, n, "", sec.name, c)
	}
	fmt.Printf(");\n")
}

func getWriteSymbols(r RegMap, add int) (string, int, error) {
	var writeAddressStr string = ""
	var n = 0
	var sn = 0
	//	var symbolWriteStr string = ""
	//	var commentWriteStr string = ""
	for _, sec := range r.sections {
		if (add >= sec.offset) && (add < (sec.offset + sec.size)) { // We have the relevant section
			//fmt.Printf("\nFound add in section %s \n", sec.name)

			for _, s := range sec.symbols {
				//fmt.Printf("symbol:%s %d \n", s.name, s.address)
				if (s.address+sec.offset == add) && (!s.readonly) {
					ln := 40 - (len(sec.name) + len(s.name))
					if n == 0 {
						sn = 0
					} else {
						sn = 14
					}
					writeAddressStr = fmt.Sprintf("%s%*sreg__%s__%s%*s   <=   data_write_in[%d:%d];  // %s\n",
						writeAddressStr, sn, "", sec.name, s.name, ln, "", (s.pos+s.size)-1, s.pos, s.shortDescription)
					n++
				}
			}
		}
	}
	return writeAddressStr, n, nil
}

func writeHDLRegister(r RegMap) {
	fmt.Printf("//------------------------------------------------Write to registers and reset-\n")
	fmt.Printf("// Create registers\n")
	for _, sec := range r.sections {
		fmt.Printf("\n    // --- Section: %s  Offset: 0x%04x  Size: %d\n", sec.name, sec.offset, sec.size)
		for _, s := range sec.symbols {
			if !s.readonly {
				rangeStr := ""
				//fmt.Printf("symbol:%s %d \n", s.name, s.address)
				n := 40 - (len(sec.name) + len(s.name))
				if s.size > 1 {
					rangeStr = fmt.Sprintf("[%d:0]", s.size-1)
				}
				fmt.Printf("reg %s%*s reg__%s__%s;      %*s//%s\n", rangeStr, 6-len(rangeStr), "", sec.name, s.name,
					n, "", s.shortDescription)
			}
		}
	}

	fmt.Printf("\n")
	fmt.Printf("always_ff @(posedge clk)\n")
	fmt.Printf("begin\n")
	fmt.Printf("  if (resetb == 0)\n")
	fmt.Printf("  begin\n")
	// Per symbol
	for _, sec := range r.sections {
		//if (add >= sec.offset) && (add < (sec.offset + sec.size)) { // We have the relevant section
		fmt.Printf("\n    // --- Section: %s  Offset: 0x%04x  Size: %d\n", sec.name, sec.offset, sec.size)
		for _, s := range sec.symbols {
			if !s.readonly {
				//fmt.Printf("symbol:%s %d \n", s.name, s.address)
				n := 40 - (len(sec.name) + len(s.name))
				fmt.Printf("    reg__%s__%s%*s       <=  %d'b%08b;   //%s\n", sec.name, s.name, n, "", s.size, s.reset, s.shortDescription)
			}
		}
	}

	fmt.Printf("  end\n")
	fmt.Printf("  else\n")
	fmt.Printf("  begin\n")
	fmt.Printf("    if (write_en)\n")
	fmt.Printf("    begin\n")
	fmt.Printf("      case (address)\n")
	var beginTag string = ""
	for add := 0; add < int(math.Pow(float64(2), float64(r.size))); add++ {
		writeCaseProcess, n, _ := getWriteSymbols(r, add)
		if writeCaseProcess != "" {
			if n > 1 {
				beginTag = "begin"
			} else {
				beginTag = writeCaseProcess
			}
			fmt.Printf("        %03d : %s \n", add, beginTag)
			if n > 1 {
				fmt.Printf("              %s", writeCaseProcess)
				fmt.Printf("              end\n")
			}
		}
	}
	//fmt.Printf("        default :\n")
	fmt.Printf("      endcase \n")
	fmt.Printf("    end\n")
	fmt.Printf("  end\n")
	fmt.Printf("end\n")
}

func getReadSymbols(r RegMap, add int) (string, int, error) {
	var readAddressStr string = ""
	var n = 0
	var sn = 0
	for _, sec := range r.sections {
		if (add >= sec.offset) && (add < (sec.offset + sec.size)) { // We have the relevant section
			for _, s := range sec.symbols {
				//fmt.Printf("//symbol:%s %d \n", s.name, s.address)
				if s.address+sec.offset == add {
					sourceStr := ""
					if n == 0 {
						sn = 0
					} else {
						sn = 14
					}
					if s.readonly {
						sourceStr = fmt.Sprintf("%s.%s", sec.name, s.name)
					} else {
						sourceStr = fmt.Sprintf("reg__%s__%s", sec.name, s.name)
					}
					ln := 40 - len(sourceStr)
					readAddressStr = fmt.Sprintf("%s%*sdata_read_out[%d:%d]  <=  %s;%*s // %s\n",
						readAddressStr, sn, "",
						(s.pos+s.size)-1, s.pos, sourceStr, ln, "", s.shortDescription)
					n++
				}
			}
		}
	}
	return readAddressStr, n, nil
}

func writeHDLReadout(r RegMap) {
	fmt.Printf("//---------------------------------------------\n")
	fmt.Printf("always @(posedge clk )\n")
	fmt.Printf("begin\n")
	fmt.Printf("  if (resetb == 0)\n")
	fmt.Printf("    data_read_out <= 8'b00000000;\n")
	fmt.Printf("  else\n")
	fmt.Printf("  begin\n")
	fmt.Printf("    data_read_out <= 8'b00000000;\n")
	fmt.Printf("    case (address)\n")
	var beginTag string = ""
	for add := 0; add < int(math.Pow(float64(2), float64(r.size))); add++ {
		readCaseProcess, n, _ := getReadSymbols(r, add)
		//fmt.Printf("%d : -%d-%s-\n",add,n,readCaseProcess)
		if readCaseProcess != "" {
			if n > 1 {
				beginTag = "begin"
			} else {
				beginTag = readCaseProcess
			}
			fmt.Printf("        %03d : %s \n", add, beginTag)
			if n > 1 {
				fmt.Printf("              %s", readCaseProcess)
				fmt.Printf("              end\n")
			}
		}
	}
	fmt.Printf("      default : data_read_out <= 8'b00000000;\n")
	fmt.Printf("    endcase\n")
	fmt.Printf("  end\n")
	fmt.Printf("end\n")

}

func writeHDLAssign(r RegMap) {
	fmt.Printf("//-------------------------------------Assign symbols to structs\n")
	for _, sec := range r.sections {
		for _, s := range sec.symbols {
			if !s.readonly {
				// Find max length to fit all cases
				n := 40 - (len(sec.name) + len(s.name))
				fmt.Printf("assign %s.%s%*s= reg__%s__%s ;\n", sec.name, s.name, n, "", sec.name, s.name)
			}
		}
	}
	fmt.Printf("endmodule\n")
}
