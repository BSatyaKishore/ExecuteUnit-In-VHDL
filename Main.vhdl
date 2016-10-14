Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Main is
end entity Main;

architecture MainArch of Main is
	component ExecuteUnit is
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
        end component ExecuteUnit;

        signal ROBInstruction: std_logic_vector(110 downto 0) := b"000000000000000000000000000000000000000000000000000000000000000000000101100000000000000000000000000000101100101";
        signal ROBEntryNo: std_logic_vector(7 downto 0) := b"00000010";
        signal ALUResult: std_logic_vector(31 downto 0);
        signal isLSInstruction: std_logic;
        signal isLoad: std_logic;
        signal CompareBits: std_logic_vector(1 downto 0);
        signal validCompareBits: std_logic;
        signal outROBEntryNo: std_logic_vector(7 downto 0);
	signal clk: std_logic := '0';
begin
	Main : ExecuteUnit port map(ROBInstruction, ROBEntryNo, ALUResult, isLSInstruction, isLoad, CompareBits, validCompareBits, outROBEntryNo,clk);
	clk <= '0' after 9 ns when clk='1' else not clk after 1 ns;
end MainArch;
