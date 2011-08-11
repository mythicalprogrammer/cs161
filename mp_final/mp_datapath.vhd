----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:08:14 11/08/2007 
-- Design Name: 
-- Module Name:    mp_datapath - Behavioral 
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

entity mp_datapath is
    Port (
			-- output control
			  PCWriteCond : in  STD_LOGIC;
           PCWrite : in  STD_LOGIC;
           IorD : in  STD_LOGIC;
           MemRead : in  STD_LOGIC;
           MemWrite : in  STD_LOGIC;
           MemtoReg : in  STD_LOGIC;
           IRWrite : in  STD_LOGIC;
           PCSource : in  STD_LOGIC_VECTOR (1 downto 0);
           ALUSrcB : in  STD_LOGIC_VECTOR (1 downto 0);
           ALUSrcA : in  STD_LOGIC;
           RegWrite : in  STD_LOGIC;
           RegDst : in  STD_LOGIC;
           Op : out  STD_LOGIC_VECTOR (5 downto 0);
			  rst : in STD_LOGIC;
			  clk : in STD_LOGIC;
			  
			  -- alu control
			  ALUctr_o : out STD_LOGIC_VECTOR (2 downto 0);
				);
end mp_datapath;

architecture Behavioral of mp_datapath is

component memory is
	port ( 	
		clock	   : 	in std_logic;
		rst		: 	in std_logic;
		Mre		:	in std_logic;
		Mwe		:	in std_logic;
		address	:	in std_logic_vector(7 downto 0);
		data_in	:	in std_logic_vector(31 downto 0);
		data_out:	out std_logic_vector(31 downto 0)
	);
end component;

component reg_file is
	port ( 	
	clock	: 	in std_logic; 	
		rst	: 	in std_logic;
		RFwe	: 	in std_logic;
		RFr1e	: 	in std_logic;
		RFr2e	: 	in std_logic;	
		RFwa	: 	in std_logic_vector(3 downto 0);  
		RFr1a	: 	in std_logic_vector(3 downto 0);
		RFr2a	: 	in std_logic_vector(3 downto 0);
		RFw	: 	in std_logic_vector(31 downto 0);
		RFr1	: 	out std_logic_vector(31 downto 0);
		RFr2	:	out std_logic_vector(31 downto 0)
	);
end component;

component alu32 is
    Port ( A_alu32, B_alu32 : in  STD_LOGIC_VECTOR(31 downto 0);
           Sel_alu32 : in  STD_LOGIC_VECTOR(2 downto 0);
           S_alu32 : out  STD_LOGIC_VECTOR(31 downto 0);
           Zero_alu32, OF_alu32 : out  STD_LOGIC);
end component;


--mux (s1 = and gate signal)
signal s0,s1,s2,s3,s4, : std_logic ;
signal s5,s6 : std_logic_vector(1 downto 0);

--
signal pc_enable : std_logic;
signal pc_o_new : std_logic_vector(31 downto 0);
signal pc_o_reg : std_logic_vector(31 downto 0);
signal memData_0 : std_logic_vector(31 downto 0); 
signal inst_25_21, inst_20_16 : std_logic_vector(4 downto 0);
signal inst_15_0 : std_logic_vector(15 downto 0);
signal inst_15_11 : std_logic_vector(4 downto 0);
signal combine1 : std_logic_vector(15 downto 0);
signal combine2 : std_logic_vector(25 downto 0);
signal sign_ex : std_logic_vector(31 downto 0);
signal shift_1 : std_logic_vector(31 downto 0);
signal shift_2 : std_logic_vector(27 downto 0);
signal regA_0, regB_0 A_o, B_o : std_logic_vector(31 downto 0);
signal alu_o, aluout_o : std_logic_vector(31 downto 0);
signal zero_o : std_logic;
signal ALUctr_o : std_logic_vector(2 downto 0);
signal mdr_o : std_logic_vector(31 downto 0); 
signal ir_reg : std_logic_vector(31 downto 0); 
signal ir_new : std_logic_vector(31 downto 0); 

--- WTF MDR_O SIGNAL??????

begin

----------------------------------------------
-- Load load:		process(clk, rst)
			begin
				if(rst = '1') then
					A_reg 		<= (others => '0'); -- 32 bit
					B_reg 		<= (others => '0'); -- 32 bit
					IR_reg 		<= (others => '0'); -- 32 bit
					PC_reg 		<= (others => '0'); -- 8 bit
					ALUout_reg 	<= (others => '0'); -- 32 bit
					MDR_reg		<= (others => '0'); -- 32 bit
				elsif(clk'event and clk = '1') then
					if(ld_A = '1') then
						A_reg <= A_new;
					end if;
					if(ld_B = '1') then
						B_reg <= B_new;
					end if;
					if(ld_IR = '1') then
						IR_reg <= IR_new;
					end if;
					if(ld_PC = '1') then
						PC_reg <= PC_new;
					end if;
					if(ld_ALUout = '1') then
						ALUout_reg <= ALUout_new;
					end if;
					if(ld_MDR = '1') then
						MDR_reg <= MDR_new;
					end if;
				end if;
			end process; ----------------------------------------------
-- PC enable bit AND_gate:	S0 <= PCWriteCond and zero_s;
OR_gate:		PCC_enable <= S0 or PCWrite;

----------------------------------------------
-- PC value

PC_component:	process(S5,PCC_enable)
					begin
						if(PCC_enable = 1) then
							PCC_value <= S5;
						end if;
					end process;

PC_value:		with IorD select
						PC_new <= ALUout_reg(9 downto 2) when '1',
						PC_new <= PCC_value(9 downto 2) when others;
				
----------------------------------------------
-- Memory

our_memory :	memory port map(
						clock	   => clk,
						rst		=> rst,
						Mre		=> MemRead,
						Mwe		=> MemWrite,
						address	=> PC_reg,
						data_in	=> B_reg,
						data_out => MDR_new -- Memory Data Register
					);

----------------------------------------------
-- Instruction Register out_IR:	process(IRWrite, MemData_s)
			begin
				if(IRWrite = '1') then
					inst_31_26 <= MemData_s(31 downto 26);
					inst_25_21 <= MemData_s(25 downto 21);
					inst_20_16 <= MemData_s(20 downto 16);
					inst_15_0  <= MemData_s(15 downto 0);
				end if;
			end process;

----------------------------------------------
-- Write Register (Registers)

mux_S1:	with RegDst select
				S1 <= inst_15_0(15 downto 11) when '1',
				S1 <= inst_20_16 when others;	

----------------------------------------------
-- Write Data (Registers)

mux_S2:	with MemtoReg select
				S2 <= MDR_reg when '1',
				S2 <= ALUout_reg when others;	

----------------------------------------------
-- Registers

out_reg_file : reg_file port map(
						clock	=> clk, 	
						rst	=> rst,
						RFwe	=> RegWrite,
						RFr1e	=> '1', --Ld_reg1 should always be one
						RFr2e	=> '1', --same as above for reg2
						RFwa	=> S1(3 downto 0),  
						RFr1a	=> inst_25_21(3 downto 0),
						RFr2a	=> inst_20_16(3 downto 0),
						RFw	=> S2,
						RFr1	=> A_new, -- A register
						RFr2	=> B_new  -- B register
					);
					
----------------------------------------------
-- ALU input

-- First input
mux_S3:	with ALUSrcA select
				S3 <= A_reg when '1',
				S3 <= PCC_value when others;	

-- Second input
mux_S4:	with ALUSrcB select
				S4 <= B_reg when "00",
				S4 <= X"00000004" when "01",
				S4 <= sign_ex_s when "10",
				S4 <= shift_32bit_s when others;
				
-- Sign Extend

my_sign_ex: sign_ex_s 	<= inst_15_0(15) & inst_15_0(15) & inst_15_0(15) & inst_15_0(15) & 
									inst_15_0(15) & inst_15_0(15) & inst_15_0(15) & inst_15_0(15) & 
									inst_15_0(15) & inst_15_0(15) & inst_15_0(15) & inst_15_0(15) & 
									inst_15_0(15) & inst_15_0(15) & inst_15_0(15) & inst_15_0(15) &
									inst_15_0;

-- Shift Left 2 (32 bit output)

my_shift_32bit: shift_32bit_s <= sign_ex_s(29 downto 0) & "00"; ----------------------------------------------
-- ALU (32 bit)

the_alu32: alu32 port map(
									A_alu32 		=> S3,
									B_alu32 		=> S4,
									Sel_alu32 	=> ALUcontrol_s,
									S_alu32 		=> ALUout_new,
									Zero_alu32	=> zero_s,
									OF_alu32 	=> OF_temp_s
								  );

----------------------------------------------
-- PC Component Value

mux_S5:	with PCSource select
				s6 <= alu_o when "00",
				s6 <= aluout_reg when "01",
				s6 <= pcc_reg & shift_2  when "10",
				s6 <= s6 when others;


--NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN





				
mux_s6:	with PCSource select
				s6 <= pcc_reg & shift_2  when "10",
				s6 <= aluout_reg when "01",
				s6 <= alu_o when "00",
				s6 <= s6 when others;
								
my_shift2: shift_2 <=	inst_25_0(25) & inst_25_0(25) & inst_25_0;

						
end Behavioral;
