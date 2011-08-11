-- Nguyen Do
-- ndo
-- 860734448

-- Quoc Anh Doan
-- qdoan	
-- 860759993

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:32:32 10/14/2007 
-- Design Name: 
-- Module Name:    alu1 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu1 is
    Port ( A_alu1, B_alu1 : in  STD_LOGIC;
           Cin_alu1 : in  STD_LOGIC;
           Sel_alu1 : in  STD_LOGIC_VECTOR(2 downto 0);
           S_alu1 : out  STD_LOGIC;
           Cout_alu1 : out  STD_LOGIC);
end alu1;

architecture Behavioral of alu1 is

	component adder1 is
	port(
		A, B, Cin : in std_logic;
		S, Cout	 : out std_logic);
	end component;
	
	signal s0, s1, s2, s3, s4 : std_logic;
	
begin

	adder : adder1 port map(A_alu1, s4, Cin_alu1, s0, Cout_alu1);
	s1 <= A_alu1 and B_alu1;
	s2 <= A_alu1 or B_alu1;
	s3 <= not(s2);
	
	-- s4
	-- need to use only 1 bit from the Sel_alu1
	with Sel_alu1(0) select
		s4 <= B_alu1 when '0',
				not(B_alu1) when '1',
				'0' when others;
	
	-- S_alu1
	with Sel_alu1 select
		S_alu1 <= s0 when "000",
					 s0 when "001",
					 s1 when "010",
					 s2 when "011",
					 s3 when "100",
					 s0 when "101",
					 '0' when others;

end Behavioral;

