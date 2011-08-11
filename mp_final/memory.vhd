library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity memory is
	port ( 	
		clock	   : 	in std_logic;
		rst		: 	in std_logic;
		Mre		:	in std_logic;
		Mwe		:	in std_logic;
		address	:	in std_logic_vector(7 downto 0);
		data_in	:	in std_logic_vector(31 downto 0);
		data_out:	out std_logic_vector(31 downto 0)
	);
end memory;

architecture Behavioral of memory is	

  type ram_type is array (0 to 255) of 
        		std_logic_vector(31 downto 0);
  signal tmp_ram: ram_type;

begin

	write: process(clock, rst)
	begin
		if rst='1' then		
			tmp_ram <= (						
						-- sum of numbers in MEM[100] to MEM[199] and put the result in MEM[200]
						-- takes ~20 us to add
                0 => "0000000" & x"0" & "0" & x"0" & "0" & x"0" & "00000100010",        --sub 0 0 0
                1 => "0000000" & x"0" & "0" & x"0" & "0" & x"1" & "00000100000",        --add 1 0 0
                2 => "0010000" & x"0" & "0" & x"2" & x"0190",   --addi 2 0 400
                3 => "1000110" & x"2" & "0" & x"3" & x"018c",   --lw 3 396 2
                4 => "0000000" & x"1" & "0" & x"3" & "0" & x"1" & "00000100000",        --add 1 1 3
                5 => "0010000" & x"2" & "0" & x"2" & x"fffc",   --addi 2 2 -4
                6 => "0001000" & x"0" & "0" & x"2" & x"0001",   --beq 2 0 4
                7 => "00001000" & x"000003",    --j 12
                8 => "1010110" & x"0" & "0" & x"1" & x"0320",   --sw 1 800 0
                9 => "00000000000000000001000101100100",        --halt

						-- random
--                100 => conv_std_logic_vector(-18433,32),
--                101 => conv_std_logic_vector(-881,32),
--                102 => conv_std_logic_vector(13016,32),
--                103 => conv_std_logic_vector(21434,32),
--                104 => conv_std_logic_vector(10857,32),
--                105 => conv_std_logic_vector(25206,32),
--                106 => conv_std_logic_vector(7187,32),
--                107 => conv_std_logic_vector(29534,32),
--                108 => conv_std_logic_vector(-7922,32),
--                109 => conv_std_logic_vector(4675,32),
--                110 => conv_std_logic_vector(-28316,32),
--                111 => conv_std_logic_vector(-16299,32),
--                112 => conv_std_logic_vector(-23151,32),
--                113 => conv_std_logic_vector(-4273,32),
--                114 => conv_std_logic_vector(-16499,32),
--                115 => conv_std_logic_vector(-18608,32),
--                116 => conv_std_logic_vector(-4742,32),
--                117 => conv_std_logic_vector(21239,32),
--                118 => conv_std_logic_vector(18614,32),
--                119 => conv_std_logic_vector(8656,32),
--                120 => conv_std_logic_vector(1772,32),
--                121 => conv_std_logic_vector(2652,32),
--                122 => conv_std_logic_vector(-9819,32),
--                123 => conv_std_logic_vector(24432,32),
--                124 => conv_std_logic_vector(-11109,32),
--                125 => conv_std_logic_vector(2397,32),
--                126 => conv_std_logic_vector(14282,32),
--                127 => conv_std_logic_vector(9458,32),
--                128 => conv_std_logic_vector(-8357,32),
--                129 => conv_std_logic_vector(1015,32),
--                130 => conv_std_logic_vector(-4265,32),
--                131 => conv_std_logic_vector(24813,32),
--                132 => conv_std_logic_vector(14035,32),
--                133 => conv_std_logic_vector(-16893,32),
--                134 => conv_std_logic_vector(-2957,32),
--                135 => conv_std_logic_vector(-18115,32),
--                136 => conv_std_logic_vector(-15521,32),
--                137 => conv_std_logic_vector(-16972,32),
--                138 => conv_std_logic_vector(-10489,32),
--                139 => conv_std_logic_vector(6658,32),
--                140 => conv_std_logic_vector(24275,32),
--                141 => conv_std_logic_vector(5180,32),
--                142 => conv_std_logic_vector(13167,32),
--                143 => conv_std_logic_vector(-1116,32),
--                144 => conv_std_logic_vector(-20851,32),
--                145 => conv_std_logic_vector(-15652,32),
--                146 => conv_std_logic_vector(19593,32),
--                147 => conv_std_logic_vector(-28645,32),
--                148 => conv_std_logic_vector(16122,32),
--                149 => conv_std_logic_vector(4162,32),
--                150 => conv_std_logic_vector(4491,32),
--                151 => conv_std_logic_vector(-9848,32),
--                152 => conv_std_logic_vector(28844,32),
--                153 => conv_std_logic_vector(-27318,32),
--                154 => conv_std_logic_vector(12527,32),
--                155 => conv_std_logic_vector(15784,32),
--                156 => conv_std_logic_vector(5693,32),
--                157 => conv_std_logic_vector(15611,32),
--                158 => conv_std_logic_vector(-19569,32),
--                159 => conv_std_logic_vector(23427,32),
--                160 => conv_std_logic_vector(13130,32),
--                161 => conv_std_logic_vector(22935,32),
--                162 => conv_std_logic_vector(2558,32),
--                163 => conv_std_logic_vector(-27746,32),
--                164 => conv_std_logic_vector(-21928,32),
--                165 => conv_std_logic_vector(22874,32),
--                166 => conv_std_logic_vector(20327,32),
--                167 => conv_std_logic_vector(-13155,32),
--                168 => conv_std_logic_vector(8472,32),
--                169 => conv_std_logic_vector(-1857,32),
--                170 => conv_std_logic_vector(9482,32),
--                171 => conv_std_logic_vector(4093,32),
--                172 => conv_std_logic_vector(21323,32),
--                173 => conv_std_logic_vector(29495,32),
--                174 => conv_std_logic_vector(-29333,32),
--                175 => conv_std_logic_vector(-13659,32),
--                176 => conv_std_logic_vector(17415,32),
--                177 => conv_std_logic_vector(-2611,32),
--                178 => conv_std_logic_vector(4931,32),
--                179 => conv_std_logic_vector(-16149,32),
--                180 => conv_std_logic_vector(7131,32),
--                181 => conv_std_logic_vector(-2778,32),
--                182 => conv_std_logic_vector(19669,32),
--                183 => conv_std_logic_vector(-1472,32),
--                184 => conv_std_logic_vector(-28740,32),
--                185 => conv_std_logic_vector(698,32),
--                186 => conv_std_logic_vector(-2908,32),
--                187 => conv_std_logic_vector(-24025,32),
--                188 => conv_std_logic_vector(-5607,32),
--                189 => conv_std_logic_vector(-14652,32),
--                190 => conv_std_logic_vector(9042,32),
--                191 => conv_std_logic_vector(-22184,32),
--                192 => conv_std_logic_vector(10138,32),
--                193 => conv_std_logic_vector(-3412,32),
--                194 => conv_std_logic_vector(-16663,32),
--                195 => conv_std_logic_vector(2624,32),
--                196 => conv_std_logic_vector(-9193,32),
--                197 => conv_std_logic_vector(-21262,32),
--                198 => conv_std_logic_vector(-20562,32),
--                199 => conv_std_logic_vector(-13238,32),

							-- reversed order
                100 => conv_std_logic_vector(50,32),
                101 => conv_std_logic_vector(49,32),
                102 => conv_std_logic_vector(48,32),
                103 => conv_std_logic_vector(47,32),
                104 => conv_std_logic_vector(46,32),
                105 => conv_std_logic_vector(45,32),
                106 => conv_std_logic_vector(44,32),
                107 => conv_std_logic_vector(43,32),
                108 => conv_std_logic_vector(42,32),
                109 => conv_std_logic_vector(41,32),
                110 => conv_std_logic_vector(40,32),
                111 => conv_std_logic_vector(39,32),
                112 => conv_std_logic_vector(38,32),
                113 => conv_std_logic_vector(37,32),
                114 => conv_std_logic_vector(36,32),
                115 => conv_std_logic_vector(35,32),
                116 => conv_std_logic_vector(34,32),
                117 => conv_std_logic_vector(33,32),
                118 => conv_std_logic_vector(32,32),
                119 => conv_std_logic_vector(31,32),
                120 => conv_std_logic_vector(30,32),
                121 => conv_std_logic_vector(29,32),
                122 => conv_std_logic_vector(28,32),
                123 => conv_std_logic_vector(27,32),
                124 => conv_std_logic_vector(26,32),
                125 => conv_std_logic_vector(25,32),
                126 => conv_std_logic_vector(24,32),
                127 => conv_std_logic_vector(23,32),
                128 => conv_std_logic_vector(22,32),
                129 => conv_std_logic_vector(21,32),
                130 => conv_std_logic_vector(20,32),
                131 => conv_std_logic_vector(19,32),
                132 => conv_std_logic_vector(18,32),
                133 => conv_std_logic_vector(17,32),
                134 => conv_std_logic_vector(16,32),
                135 => conv_std_logic_vector(15,32),
                136 => conv_std_logic_vector(14,32),
                137 => conv_std_logic_vector(13,32),
                138 => conv_std_logic_vector(12,32),
                139 => conv_std_logic_vector(11,32),
                140 => conv_std_logic_vector(10,32),
                141 => conv_std_logic_vector(9,32),
                142 => conv_std_logic_vector(8,32),
                143 => conv_std_logic_vector(7,32),
                144 => conv_std_logic_vector(6,32),
                145 => conv_std_logic_vector(5,32),
                146 => conv_std_logic_vector(4,32),
                147 => conv_std_logic_vector(3,32),
                148 => conv_std_logic_vector(2,32),
                149 => conv_std_logic_vector(1,32),
                150 => conv_std_logic_vector(0,32),
                151 => conv_std_logic_vector(-1,32),
                152 => conv_std_logic_vector(-2,32),
                153 => conv_std_logic_vector(-3,32),
                154 => conv_std_logic_vector(-4,32),
                155 => conv_std_logic_vector(-5,32),
                156 => conv_std_logic_vector(-6,32),
                157 => conv_std_logic_vector(-7,32),
                158 => conv_std_logic_vector(-8,32),
                159 => conv_std_logic_vector(-9,32),
                160 => conv_std_logic_vector(-10,32),
                161 => conv_std_logic_vector(-11,32),
                162 => conv_std_logic_vector(-12,32),
                163 => conv_std_logic_vector(-13,32),
                164 => conv_std_logic_vector(-14,32),
                165 => conv_std_logic_vector(-15,32),
                166 => conv_std_logic_vector(-16,32),
                167 => conv_std_logic_vector(-17,32),
                168 => conv_std_logic_vector(-18,32),
                169 => conv_std_logic_vector(-19,32),
                170 => conv_std_logic_vector(-20,32),
                171 => conv_std_logic_vector(-21,32),
                172 => conv_std_logic_vector(-22,32),
                173 => conv_std_logic_vector(-23,32),
                174 => conv_std_logic_vector(-24,32),
                175 => conv_std_logic_vector(-25,32),
                176 => conv_std_logic_vector(-26,32),
                177 => conv_std_logic_vector(-27,32),
                178 => conv_std_logic_vector(-28,32),
                179 => conv_std_logic_vector(-29,32),
                180 => conv_std_logic_vector(-30,32),
                181 => conv_std_logic_vector(-31,32),
                182 => conv_std_logic_vector(-32,32),
                183 => conv_std_logic_vector(-33,32),
                184 => conv_std_logic_vector(-34,32),
                185 => conv_std_logic_vector(-35,32),
                186 => conv_std_logic_vector(-36,32),
                187 => conv_std_logic_vector(-37,32),
                188 => conv_std_logic_vector(-38,32),
                189 => conv_std_logic_vector(-39,32),
                190 => conv_std_logic_vector(-40,32),
                191 => conv_std_logic_vector(-41,32),
                192 => conv_std_logic_vector(-42,32),
                193 => conv_std_logic_vector(-43,32),
                194 => conv_std_logic_vector(-44,32),
                195 => conv_std_logic_vector(-45,32),
                196 => conv_std_logic_vector(-46,32),
                197 => conv_std_logic_vector(-47,32),
                198 => conv_std_logic_vector(-48,32),
                199 => conv_std_logic_vector(-49,32),

					others => "00000000000000000000000000000000");
		else
			if (clock'event and clock = '1') then
				if (Mwe ='1' and Mre = '0') then
					tmp_ram(conv_integer(address)) <= data_in;
				end if;
			end if;
		end if;
	end process;

   read: process(rst, Mre, Mwe, address)
	begin
		if rst='1' then
			data_out <= (others => '0');
		elsif (Mre ='1' and Mwe ='0') then								 
			data_out <= tmp_ram(conv_integer(address));
		end if;
	end process;

end Behavioral;

