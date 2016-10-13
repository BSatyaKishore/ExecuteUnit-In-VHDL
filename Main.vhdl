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
                CompareBits: out std_logic_vector(2 downto 0);
                validCompareBits: out std_logic;
                outROBEntryNo: out std_logic_vector;
        );
        end component ExecuteUnit;

        signal ROBInstruction: std_logic_vector(110 downto 0) := b"00000000000000000000000000000000000000000000000000000000000000000000101100000000000000000000000000000101100000";
        signal ROBEntryNo: std_logic_vector(7 downto 0) := b"00000010";
        signal ALUResult: std_logic_vector(31 downto 0);
        isLSInstruction: std_logic;
        isLoad: std_logic;
        CompareBits: std_logic_vector(2 downto 0);
        validCompareBits: std_logic;
        outROBEntryNo: std_logic_vector;
begin
	Main : ExecuteUnit port map(ROBInstruction, ROBEntryNo, ALUResult, isLSInstruction, isLoad, CompareBits, validCompareBits, outROBEntryNo);
end MainArch;

