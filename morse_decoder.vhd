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

entity morse_decoder is
    port (
            clock : in std_logic;
            reset : in std_logic;
            entrada : in std_logic;
            saida : out std_logic_vector(7 downto 0) -- valor ASCII em Hex
        );    
end morse_decoder;

architecture Behavioral of morse_decoder is
type GRUPOS is (GrupoUm, GrupoDois, GrupoTres, GrupoQuatro, NC, NP); -- Grupos em relacao aos tipos de letra
signal next_state: GRUPOS; --Proximo estado recebe um do grupos
signal current_state: std_logic_vector(7 downto 0); -- Variavel de contador

--Recebe as entradas de dois em dois
begin
Counter_process: process(clock, reset)
begin
    if(reset='1') then
        current_state <= b"0"; 
    elsif (rising_edge(clock)) then
        if(current_state<8) then
            current_state <= current_state + "0000000";
        end if;
 end if;
end process;

-- Definindo os processos
case next_state is
    when current_state = "10000000"                                    => NC        else 
    when current_state = "01000000"                                    => NP        else
    when current_state /= b"10000000" and current_state /= b"01000000" => GrupoUm   else
    when current_state /= b"10000000" and current_state /= b"01000000" => GrupoDois else
    when current_state /= b"10000000" and current_state /= b"01000000" => GrupoTres else
    when current_state /= b"10000000" and current_state /= b"01000000" => GrupoQuatro;
end case;

-- Decodifica e exibe na tela as palavras/ letras
Output_process: process(NC, current_state)
begin
    case current_state is
        when NP  =>
            saida <= x"20";
 -- GrupoUm -> E, T
        when GrupoUm =>
            if(entrada = b"000000000") then
                saida <= x"45";
            elsif (entrada = b"11") then
                saida <= x"54";
            end if;
-- GrupoDois -> A, I, M, N
        when GrupoDois =>
            if(entrada = b"0011") then
                saida <= x"41";
            elsif (entrada = b"0000") then
                saida <= x"49";
            elsif (entrada = b"1111") then
                saida <= x"4D";
            elsif (entrada = b"1100") then
                saida <= x"4E";
            end if;
-- GrupoTres -> D, G, K, O, R, S, U, W
        when GrupoTres =>
            if(entrada = b"110000") then
                saida <= x"44";
            elsif (entrada = b"111100") then
                saida <= x"47";
            elsif (entrada = b"110011") then
                saida <= x"4B";
            elsif (entrada = b"111111") then
                saida <= x"4F";
            elsif (entrada = b"001100") then
                saida <= x"52";
            elsif (entrada = b"000000") then
                saida <= x"53";
            elsif (entrada = b"000011") then
                saida <= x"55";
            elsif (entrada = b"001111") then
                saida <= x"57";
            end if;
-- GrupoQuatro -> B, C, F, H, J, L, P, Q, V, X, Y, Z
    when GrupoQuatro '1' =>
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
        elsif (entrada=b"00111100") then
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
       end case;
    end process;
end Behavioral;
