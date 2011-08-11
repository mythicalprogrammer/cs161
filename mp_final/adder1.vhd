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
-- Create Date:    10:52:05 10/05/2007 
-- Design Name: 
-- Module Name:    adder1 - dataflow 
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

entity adder1 is
port (
	A, B, Cin : in std_logic;
	S, Cout	 : out std_logic);
end adder1;

architecture dataflow of adder1 is
	signal S1, C1, C2 : std_logic;
begin
	S1 <= A xor B;
	S  <= S1 xor Cin;
	C1 <= S1 and Cin;
	C2 <= A and B;
	Cout <= C1 or C2;
end dataflow;

