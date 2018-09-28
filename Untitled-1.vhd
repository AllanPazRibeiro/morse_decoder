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
  Port ( 
        clock: in std_logic; --- Sinal de clock
        reset: in std_logic; -- Reset
        sequence_in: in std_logic_vector; -- Sequencia de binario 
        print_out: out std_logic_vector  -- Output da sequencia do detector binario
  );
end morse_decoder;

architecture Behavioral of morse_decoder is
type GRUPOS is (GrupoUm, GrupoDois, GrupoTres, GrupoQuatro, NC, NP, NOTWORD); -- Grupos em relacao aos tipos de letra
signal next_state: GRUPOS; --Proximo estado recebe um do grupos
signal current_state: std_logic_vector(7 downto 0); -- Variavel de contador

--Recebe as entradas de dois em dois
begin
Counter_process: process(clock, reset)
begin 
 if (rising_edge(clock)) then
    if(reset='1')
         current_state <= x"0";
    else
        current_state <= current_state + x"1";
    end if;
 end if;
end process;

-- Decodifica e exibe na tela as palavras/ letras
Output_process: process(current_state)
begin 
 case current_state is
 when NOTWORD =>
    print_out <= x"20";
 -- GrupoUm -> E, T
 when GrupoUm =>
    if(sequence_in= b"00") then
        print_out <= x"45";
    elsif (sequence_in= b"11") then
        print_out <= x"54";
    end if;
-- GrupoDois -> A, I, M, N
when GrupoDois =>
    if(sequence_in=b"0011") then
        print_out <= x"41";
    elsif (sequence_in=b"0000") then
        print_out <= x"49";
    elsif (sequence_in=b"1111") then
        print_out <= x"4D";
    elsif (sequence_in=b"1100") then
        print_out <= x"4E";
    end if;
-- GrupoTres -> D, G, K, O, R, S, U, W
when GrupoTres =>
    if(sequence_in=b"110000") then
        print_out <= x"44";
    elsif (sequence_in=b"111100") then
        print_out <= x"47";
    elsif (sequence_in=b"110011") then
        print_out <= x"4B";
    elsif (sequence_in=b"111111") then
        print_out <= x"4F";
    elsif (sequence_in=b"001100") then
        print_out <= x"52";
    elsif (sequence_in=b"000000") then
        print_out <= x"53";
    elsif (sequence_in=b"000011") then
        print_out <= x"55";
    elsif (sequence_in=b"001111") then
        print_out <= x"57";
    end if;
-- GrupoQuatro -> B, C, F, H, J, L, P, Q, V, X, Y, Z
when GrupoQuatro =>
    if(sequence_in=b"11000000") then
        print_out <= x"42";
    elsif (sequence_in=b"11001100") then
        print_out <= x"43";
    elsif (sequence_in=b"00001100") then
        print_out <= x"46";
    elsif (sequence_in=b"00000000") then
        print_out <= x"48";
    elsif (sequence_in=b"00111111") then
        print_out <= x"4A";
    elsif (sequence_in=b"00110000") then
        print_out <= x"4C";
    elsif (sequence_in=b"00111100") then
        print_out <= x"50";
    elsif (sequence_in=b"11110011") then
        print_out <= x"51";
    elsif (sequence_in=b"00000011") then
        print_out <= x"56";
    elsif (sequence_in=b"11000011") then
        print_out <= x"58";
    elsif (sequence_in=b"11001111") then
        print_out <= x"59";
    elsif (sequence_in=b"11110000") then
        print_out <= x"5A";
    end if;
 end case;
end process;
end Behavioral;
