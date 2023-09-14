"""
LABORATÓRIO 1 - OAC
GRUPO - 1
KALEW SILVA PIVETA
OBJETIVO GERAL : gerar um código objeto montado em Hexadecimal em arquivo de texto ASCII.
"""

def ler_arquivo(nome_arquivo):
    with open(nome_arquivo, 'r') as arquivo:
        conteudo = arquivo.read()
    return conteudo

def processar_codigo(conteudo):
    linhas = conteudo.split('\n')
    for linha in linhas:
        print(linha)

def gerar_mif(area, dados):
    conteudo_mif = f'''DEPTH = {len(dados)};
WIDTH = 32;
ADDRESS_RADIX = HEX;
DATA_RADIX = HEX;
CONTENT BEGIN\n'''
    
    for endereco, valor in enumerate(dados):
        conteudo_mif += f'    {endereco:08X} : {valor:08X};\n'
    
    conteudo_mif += 'END;'
    
    with open(f'meu_example_{area}.mif', 'w') as arquivo_mif:
        arquivo_mif.write(conteudo_mif)



registradores = {
    '$zero': 0,
    '$t0': 0,
    # ... outros registradores ...
    '$fp': 0
}

# Exemplo de uso
registradores['$t0'] = 10

#gerar_mif('data', dados)
#gerar_mif('text', instrucoes)

#################################----------------------------------#################################
#################################----------------------------------#################################
#################################----------------------------------#################################
#################################----------------------------------#################################

if __name__== "__main__":
    #leitura_arquivo = "./arquivos-exemplos/" + input("Digite o nome do arquivo a ser lido com sua devida extensão (.asm): ")
    leitura_arquivo = "./arquivos-exemplos/example_saida.asm"
    print(len(ler_arquivo(leitura_arquivo)))
    