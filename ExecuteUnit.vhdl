library ieee;
use IEEE.NUMERIC_STD.ALL;
--use ieee.std_logic_arith.all;
use ieee.std_logic_1164.all;

entity ExecuteUnit is
	port(
		ROBInstruction: in std_logic_vector(110 downto 0);
		ROBEntryNo: in std_logic_vector(7 downto 0);
		ALUResult: out std_logic_vector(31 downto 0);
		isLSInstruction: out std_logic;
		isLoad: out std_logic;
		CompareBits: out std_logic_vector(1 downto 0);
		validCompareBits: out std_logic;
		outROBEntryNo: out std_logic_vector(7 downto 0);
		clk: in std_logic
	);
end entity ExecuteUnit;

architecture ALU of ExecuteUnit is
	signal opcode: std_logic_vector(4 downto 0);
	signal temp	 :std_logic_vector(63 downto 0);
	signal op1, op2: std_logic_vector(31 downto 0);
	begin
		opcode <= ROBInstruction(4 downto 0);
		op1 <= ROBInstruction(37 downto 6);
		op2 <= ROBInstruction(70 downto 39);
		outROBEntryNo <= ROBEntryNo;
		process(opcode, op1, op2, clk)
			variable tempInt: integer := 0;
			begin
				if (clk='1') then
					--! Initilizing signals
					ALUResult <= x"00000000";
					validCompareBits <= '0';
					isLSInstruction <= '0';
					isLoad <= '0';

			case opcode is
				when "00000" =>
					ALUResult <= std_logic_vector(to_signed((to_integer(signed(op1)) + to_integer(signed(op2))),32));
				when "00001" =>
					ALUResult <= std_logic_vector(to_signed((to_integer(signed(op1)) + to_integer(signed(not op2))+ 1),32));
				when "00010" =>
					ALUResult <= std_logic_vector(to_signed((to_integer(signed(op1)) * to_integer(signed(op2))),32));
				when "00011" =>
					ALUResult <= std_logic_vector(to_signed((to_integer(signed(op1)) / to_integer(signed(op2))),32));
				when "00100" =>
					ALUResult <= std_logic_vector(to_signed((to_integer(signed(op1)) mod to_integer(signed(op2))),32));
				when "00101" =>
					validCompareBits <= '1';
					CompareBits <= b"00";
					if (op1=op2) then
						CompareBits <= b"01";
					elsif (to_integer(signed(op1)) > to_integer(signed(op2))) then
						CompareBits <= b"10";
					end if;
				when "00110" =>
					ALUResult <= (op1 and op2);
				when "00111" =>
					ALUResult <= (op1 or op2);
				when "01000" =>
					ALUResult <= (not op1);
				when "01001" =>
					ALUResult <= (op1);
				when "01010" =>
					ALUResult <= (op1); -- >> to_integer(signed(op2)));
				when "01011" =>
					ALUResult <= (op1); -- << to_integer(signed(op2)));
--				when "01100" =>
--					--! ASR
				when "01101" =>
					isLSInstruction <= '1';
					isLoad <= '1';
					ALUResult <= std_logic_vector(to_signed((to_integer(signed(op1)) + to_integer(signed(op2))),32));
				when "01110" =>
					isLSInstruction <= '1';
					ALUResult <= std_logic_vector(to_signed((to_integer(signed(op1)) + to_integer(signed(op2))),32));
--				--! TODO: branch instructions over here ALUResult <=
				when others =>
					ALUResult <= std_logic_vector(to_signed((to_integer(signed(op1)) + to_integer(signed(op2))),32));
			end case;
		end if;
		end process;
end architecture ALU;
