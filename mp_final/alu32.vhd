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
-- Create Date:    13:47:16 10/14/2007 
-- Design Name: 
-- Module Name:    alu32 - Behavioral 
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

entity alu32 is
    Port ( A_alu32, B_alu32 : in  STD_LOGIC_VECTOR(31 downto 0);
           Sel_alu32 : in  STD_LOGIC_VECTOR(2 downto 0);
           S_alu32 : out  STD_LOGIC_VECTOR(31 downto 0);
           Zero_alu32, OF_alu32 : out  STD_LOGIC);
end alu32;

architecture Behavioral of alu32 is

	component alu1 is
	port(
		A_alu1, B_alu1 : in  STD_LOGIC;
      Cin_alu1 : in  STD_LOGIC;
      Sel_alu1 : in  STD_LOGIC_VECTOR(2 downto 0);
      S_alu1 : out  STD_LOGIC;
      Cout_alu1 : out  STD_LOGIC);
	end component;
	
	signal s0 : std_logic;
	signal sv, cv, ltv : std_logic_vector(31 downto 0);

begin

	alu1_0 : alu1 port map(A_alu32(0), B_alu32(0), s0, Sel_alu32, sv(0), cv(0));
	alu1_1 : alu1 port map(A_alu32(1), B_alu32(1), cv(0), Sel_alu32, sv(1), cv(1));	alu1_2 : alu1 port map(A_alu32(2), B_alu32(2), cv(1), Sel_alu32, sv(2), cv(2));	alu1_3 : alu1 port map(A_alu32(3), B_alu32(3), cv(2), Sel_alu32, sv(3), cv(3));	alu1_4 : alu1 port map(A_alu32(4), B_alu32(4), cv(3), Sel_alu32, sv(4), cv(4));	alu1_5 : alu1 port map(A_alu32(5), B_alu32(5), cv(4), Sel_alu32, sv(5), cv(5));	alu1_6 : alu1 port map(A_alu32(6), B_alu32(6), cv(5), Sel_alu32, sv(6), cv(6));	alu1_7 : alu1 port map(A_alu32(7), B_alu32(7), cv(6), Sel_alu32, sv(7), cv(7));	alu1_8 : alu1 port map(A_alu32(8), B_alu32(8), cv(7), Sel_alu32, sv(8), cv(8));	alu1_9 : alu1 port map(A_alu32(9), B_alu32(9), cv(8), Sel_alu32, sv(9), cv(9));
	alu1_10 : alu1 port map(A_alu32(10), B_alu32(10), cv(9), Sel_alu32, sv(10), cv(10));
	alu1_11 : alu1 port map(A_alu32(11), B_alu32(11), cv(10), Sel_alu32, sv(11), cv(11));
	alu1_12 : alu1 port map(A_alu32(12), B_alu32(12), cv(11), Sel_alu32, sv(12), cv(12));
	alu1_13 : alu1 port map(A_alu32(13), B_alu32(13), cv(12), Sel_alu32, sv(13), cv(13));
	alu1_14 : alu1 port map(A_alu32(14), B_alu32(14), cv(13), Sel_alu32, sv(14), cv(14));
	alu1_15 : alu1 port map(A_alu32(15), B_alu32(15), cv(14), Sel_alu32, sv(15), cv(15));
	alu1_16 : alu1 port map(A_alu32(16), B_alu32(16), cv(15), Sel_alu32, sv(16), cv(16));
	alu1_17 : alu1 port map(A_alu32(17), B_alu32(17), cv(16), Sel_alu32, sv(17), cv(17));
	alu1_18 : alu1 port map(A_alu32(18), B_alu32(18), cv(17), Sel_alu32, sv(18), cv(18));
	alu1_19 : alu1 port map(A_alu32(19), B_alu32(19), cv(18), Sel_alu32, sv(19), cv(19));
	alu1_20 : alu1 port map(A_alu32(20), B_alu32(20), cv(19), Sel_alu32, sv(20), cv(20));
	alu1_21 : alu1 port map(A_alu32(21), B_alu32(21), cv(20), Sel_alu32, sv(21), cv(21));
	alu1_22 : alu1 port map(A_alu32(22), B_alu32(22), cv(21), Sel_alu32, sv(22), cv(22));
	alu1_23 : alu1 port map(A_alu32(23), B_alu32(23), cv(22), Sel_alu32, sv(23), cv(23));
	alu1_24 : alu1 port map(A_alu32(24), B_alu32(24), cv(23), Sel_alu32, sv(24), cv(24));
	alu1_25 : alu1 port map(A_alu32(25), B_alu32(25), cv(24), Sel_alu32, sv(25), cv(25));
	alu1_26 : alu1 port map(A_alu32(26), B_alu32(26), cv(25), Sel_alu32, sv(26), cv(26));
	alu1_27 : alu1 port map(A_alu32(27), B_alu32(27), cv(26), Sel_alu32, sv(27), cv(27));
	alu1_28 : alu1 port map(A_alu32(28), B_alu32(28), cv(27), Sel_alu32, sv(28), cv(28));
	alu1_29 : alu1 port map(A_alu32(29), B_alu32(29), cv(28), Sel_alu32, sv(29), cv(29));
	alu1_30 : alu1 port map(A_alu32(30), B_alu32(31), cv(29), Sel_alu32, sv(30), cv(30));
	alu1_31 : alu1 port map(A_alu32(31), B_alu32(31), cv(30), Sel_alu32, sv(31), cv(31));

	with Sel_alu32(0) select
		s0 <= '1' when '1',
				'0' when others;

	Zero_alu32 <= not(sv(0) or sv(1) or sv(2) or sv(3) or sv(4) or sv(5) or sv(6) or sv(7) or sv(8) or sv(9)
						or sv(10) or sv(11) or sv(12) or sv(13) or sv(14) or sv(15) or sv(16) or sv(17) or sv(18) or sv(19)
						or sv(20) or sv(21) or sv(22) or sv(23) or sv(24) or sv(25) or sv(26) or sv(27) or sv(28) or sv(29)
						or sv(30) or sv(31));

	with sv(31) select
		ltv <= "00000000000000000000000000000001" when '1',
				 "00000000000000000000000000000000" when others;
				 
	with Sel_alu32 select
		S_alu32 <= sv when "000",
					  sv when "001",
					  sv when "010",
					  sv when "011",
					  sv when "100",
					  ltv when "101",
					  "00000000000000000000000000000000" when others;	OF_alu32 <= cv(30) xor cv(31);
		

end Behavioral;

