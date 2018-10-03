----------------------------------------------------------------------------------
-- Company: FTEC
-- Engineer: Allan Ribeiro
-- 
-- Create Date: 24.09.2018 21:38:21
-- Design Name: 
-- Module Name: morse_decoder - Behavioral
-- Project Name: Trabalho codigo morse
-- Target Devices: Nuscei
-- Tool Versions: Good question
-- Description: 
-- A badass morse decodificator, hope this give a good note since I will use this project
-- in my Nvidia`s interview :D
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Morse_tb is
--  Port ( );
end Morse_tb;

architecture Behavioral of Morse_tb is
    component Morse is
        Port ( clock   : in STD_LOGIC;
               reset   : in STD_LOGIC;
               entrada : in STD_LOGIC;
               saida   : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    signal clock   : STD_LOGIC;
    signal reset   : STD_LOGIC;
    signal entrada : STD_LOGIC;
    signal saida   : STD_LOGIC_VECTOR (7 downto 0);

    constant clk_period : time := 20 ns;

begin

    uut: Morse PORT MAP (
        clock => clock,
        entrada => entrada,
        reset => reset,
        saida => saida
    );    

    clock_process : process
    begin
        clock <= '0';
        wait for clk_period/2;
        clock <= '1';
        wait for clk_period/2;
    end process;


    -- Processo de geracao de estimulos
    stim_proc: process
    begin
     
        reset <= '1';
 
        wait for clk_period*3;
 
        reset <= '0';
        
        -- B
        entrada <= '1';
        wait for clk_period*2;
        entrada <= '0';
        wait for clk_period*6;
        
        -- NC
        entrada <= '1';
        wait for clk_period;
        entrada <= '0';
        wait for clk_period;
        
        -- A
        entrada <= '1';
        wait for clk_period*2;
        entrada <= '0';
        wait for clk_period*2;

        -- NC
        entrada <= '1';
        wait for clk_period;
        entrada <= '0';
        wait for clk_period;
        
        -- T
        entrada <= '0';
        wait for clk_period*2;

        -- NC
        entrada <= '1';
        wait for clk_period;
        entrada <= '0';
        wait for clk_period;
        
        -- I
        entrada <= '1';
        wait for clk_period*4;

        -- NC
        entrada <= '1';
        wait for clk_period;
        entrada <= '0';
        wait for clk_period;
        
        -- M
        entrada <= '0';
        wait for clk_period*4;

        -- NC
        entrada <= '1';
        wait for clk_period;
        entrada <= '0';
        wait for clk_period;
        
        -- A
        entrada <= '1';
        wait for clk_period*2;
        entrada <= '0';
        wait for clk_period*2;

        -- NC
        entrada <= '1';
        wait for clk_period;
        entrada <= '0';
        wait for clk_period;

        -- H
        entrada <= '0';
        wait for clk_period*8;

        -- NC
        entrada <= '1';
        wait for clk_period;
        entrada <= '0';
        wait for clk_period;

        -- NP
        entrada <= '0';
        wait for clk_period;
        entrada <= '1';
        wait for clk_period;

        -- L
        entrada <= '1';
        wait for clk_period*4;

        -- O
        entrada <= '1';
        wait for clk_period*2;
        entrada <= '0';
        wait for clk_period*2;
        entrada <= '1';
        wait for clk_period*4;

        -- K
        entrada <= '0';
        wait for clk_period*2;
        entrada <= '1';
        wait for clk_period*2;
        entrada <= '0';
        wait for clk_period*2;
        
        -- O
        entrada <= '0';
        wait for clk_period*6;

        -- NC
        entrada <= '1';
        wait for clk_period;
        entrada <= '0';
        wait for clk_period;

        -- NP
        entrada <= '0';
        wait for clk_period;
        entrada <= '1';
        wait for clk_period;


    end process;

end Behavioral;
