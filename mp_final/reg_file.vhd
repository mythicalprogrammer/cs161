library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg_file is
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
end reg_file;

architecture Behavioral of reg_file is		

  type rf_type is array (0 to 15) of 
        std_logic_vector(31 downto 0);
  signal tmp_rf: rf_type;

begin

  write: process(clock, rst, RFwa, RFwe, RFw)
  begin
    if rst='1' then				-- high active
        tmp_rf <= (tmp_rf'range => (others => '0'));
    else
	if (clock'event and clock = '1') then
	  if RFwe='1' then
	    tmp_rf(conv_integer(RFwa)) <= RFw;
	  end if;
	end if;
    end if;
  end process;						   
	
  read1: process(rst, RFr1e, RFr1a, tmp_rf)
  begin
    if rst='1' then
	RFr1 <= (others => '0');
    elsif RFr1e='1' then								 
	    RFr1 <= tmp_rf(conv_integer(RFr1a));
    end if;
  end process;
	
  read2: process(rst, RFr2e, RFr2a, tmp_rf)
  begin
    if rst='1' then
	RFr2<= (others => '0');
    elsif RFr2e='1' then								 
	    RFr2 <= tmp_rf(conv_integer(RFr2a));
    end if;
  end process;

end Behavioral;

