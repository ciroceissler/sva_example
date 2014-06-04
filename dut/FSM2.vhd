----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:06:07 05/29/2014 
-- Design Name: 
-- Module Name:    FSM2 - Behavioral 
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

entity FSM2 is
    Port (
      reset : in std_logic;
      clk : in std_logic;
      start: in std_logic;
      data_in : in std_logic_vector(3 downto 0);
      AVAIL : out std_logic;
      DONE : out std_logic;
      flag : out std_logic_vector(1 downto 0));
end FSM2;

architecture Behavioral of FSM2 is

type tipoestado is (s0, s1, s2, s3, s4, s5, s6);

signal estado : tipoestado;


begin


  process(reset, clk)
  variable regd : std_logic_vector(3 downto 0);
  variable cont : std_logic_vector(6 downto 0);
  begin
     if reset = '1' then
       estado <= s0;
       AVAIL <= '1'; done <= '0';  flag <= "00"; regd := "0000"; cont := "0000000";
    elsif (clk'event and clk='1') then
        CASE estado IS
    WHEN s0 =>
       AVAIL <= '1'; done <= '0';  flag <= "00"; regd := "0000"; cont := "0000000"; if start='0'then estado 
<= s0; else estado <= s1; end if;
     WHEN s1 =>
  AVAIL <= '0'; done <= '0';  flag <= "00"; regd := data_in; cont := cont+1; 
         if (regd = "1011" and cont <= "1100100") then estado <= s2; 
		   elsif cont="1100100" then estado <= s4; 
         else estado <= s1; 
			end if;
      WHEN s2 => -- achou um valor em <=100
       AVAIL <= '0'; done <= '1';  flag <= "01"; estado <= s0;
      WHEN s3 =>
       AVAIL <= '0'; done <= '1';  flag <= "01"; estado <= s0;
      WHEN s4 => -- nao achou valor ate 100 dados
       AVAIL <= '0'; done <= '1';  flag <= "00"; estado <= s5;
      WHEN s5 =>
       AVAIL <= '0'; done <= '1';  flag <= "00";  estado <= s0;
		 WHEN others =>
       AVAIL <= '1'; done <= '0';  flag <= "00";  estado <= s0;
end CASE;
end if;
end process;



end Behavioral;
