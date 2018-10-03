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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity morse_decoder is
    port (
            clock : in std_logic;
            reset : in std_logic;
            entrada : in std_logic;
            saida : out std_logic_vector(7 downto 0) -- valor ASCII em Hex
        );    
end morse_decoder;

architecture Behavioral of morse_decoder is
--type GRUPOS is (GrupoUm, GrupoDois, GrupoTres, GrupoQuatro, NC, NP, Zero); -- Grupos em relacao aos tipos de letra
--signal current_state, next_state: GRUPOS; --Proximo estado recebe um do grupos
signal counter_up: integer;
signal Um: std_logic;
signal Dois: std_logic;

signal current_state   : std_logic_vector(7 downto 0);
signal next_state      : std_logic_vector(7 downto 0);

signal NP            : std_logic;
signal NC            : std_logic;
signal GrupoUm       : std_logic;
signal GrupoDois     : std_logic;
signal GrupoTres     : std_logic;
signal GrupoQuatro   : std_logic;


--Recebe as entradas de dois em dois
begin
Counter_process: process(clock, reset)
begin
    if(reset='1') then
        current_state <= "000000000";
        counter_up <= 0; 
    elsif (rising_edge(clock)) then
       current_state <= next_state + "1"; 
       counter_up <= counter_up + 1;
 end if; 
end process;

NP          <= '1' when current_state = "000000010";
NC          <= '1' when current_state = "000000001";
GrupoUm     <= '1' when current_state = "000000000";
GrupoDois   <= '1' when current_state = "000000000";
GrupoTres   <= '1' when current_state = "000000000";
GrupoQuatro <= '1' when current_state = "000000000"; 

Output_process: process(NC, current_state)
begin
        if NP = '1' then
            saida <= x"20";
        end if;
 -- GrupoUm -> E, T
        if GrupoUm = '1' then
            if(entrada = "000000000") then
                saida <= x"45";
            elsif (entrada = b"11") then
                saida <= x"54";
            end if;
        end if;    
-- GrupoDois -> A, I, M, N
        if GrupoDois = '1' then
            if(entrada = b"00110000") then
                saida <= x"41";
            elsif (entrada = b"00000000") then
                saida <= x"49";
            elsif (entrada = b"11110000") then
                saida <= x"4D";
            elsif (entrada = b"11000000") then
                saida <= x"4E";
            end if;
        end if;    
-- GrupoTres -> D, G, K, O, R, S, U, W
        if GrupoTres = '1' then
            if(entrada = b"11000000") then
                saida <= x"44";
            elsif (entrada = b"11110000") then
                saida <= x"47";
            elsif (entrada = b"11001100") then
                saida <= x"4B";
            elsif (entrada = b"11111100") then
                saida <= x"4F";
            elsif (entrada = b"00110000") then
                saida <= x"52";
            elsif (entrada = b"00000000") then
                saida <= x"53";
            elsif (entrada = b"00001100") then
                saida <= x"55";
            elsif (entrada = b"00111100") then
                saida <= x"57";
            end if;
        end if;            
-- GrupoQuatro -> B, C, F, H, J, L, P, Q, V, X, Y, Z
    if GrupoQuatro = '1' then
        if(entrada=b"11000000") then
            saida <= x"42";
        elsif (entrada=b"11001100") then
            saida <= x"43";
        elsif (entrada=b"00001100") then
            saida <= x"46";
        elsif (entrada=b"00000000") then
            saida <= x"48";
        elsif (entrada=b"00111111") then
            saida <= x"4A";
        elsif (entrada=b"00110000") then
            saida <= x"4C";
        elsif entrada = "00111100" then
            saida <= x"50";
        elsif (entrada=b"11110011") then
            saida <= x"51";
        elsif (entrada=b"00000011") then
            saida <= x"56";
        elsif (entrada=b"11000011") then
            saida <= x"58";
        elsif (entrada=b"11001111") then
            saida <= x"59";
        elsif (entrada=b"11110000") then
            saida <= x"5A";
        end if;
    end if;   
    end process;
end Behavioral;
