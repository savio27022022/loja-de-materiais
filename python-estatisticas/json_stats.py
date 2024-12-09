# Gerador de estatísticas para fonte de dados em formato JSON
from argparse import ArgumentParser
from pathlib import Path
from typing import List
import json

# Estrutura para armazenar uma estatística
class Estatistica:
    # Nome do atributo a ser analizado
    nome: str
    # Valor que um dado armazena
    valor: any
    # Conta as vezes que um dado se repete
    contador: int
    def __init__(self,nome="?",valor="?",contador=1):
        self.nome = nome
        self.valor = valor
        self.contador = 1

# Estrutura que armazena um resultado de geração de estatística
class Resultado_Estatistica:
    maximos_valores: List[Estatistica] | None
    frequencias_valores: List[Estatistica] | None
    def __init__(self,nome_tabela="?",maximos_valores=None,frequencias_valores=None):
        self.maximos_valores = maximos_valores
        self.frequencias_valores = frequencias_valores
        self.nome_tabela = nome_tabela

# Função para gerar estatísticas a partir da fonte JSON
# e retornar um objeto chamado resultado
def gerar_estatisticas(arquivo_json: Path):
    # 1. Criando Listas de estruturas que armazenam estatisticas
    #
    # Armazena os valores máximos encontrados (apenas os numéricos)
    maximos_valores: List[Estatistica] = []
    # Armazena os valores mais repetidos
    frequencias_valores: List[Estatistica] = []
    # Listar os 'nomes' de Estatistica já existentes
    # em maximos_valores e frequencias_valores
    nomes_maximos_valores: List[str] = []
    nomes_frequencias_valores: List[str] = []
    
    # 2. Lendo o conteúdo da fonte de dados JSON
    #
    # A lista abaixo armazena o conteudo JSON carregado de um arquivo
    lista_itens: list[dict] = []
    with open(arquivo_json, "r") as j:
        lista_itens = json.load(j)
    
    # 3. Atualizar estatísticas de maiores valores
    #
    # Para cada item
    for a in lista_itens:
        # Para cada nome de chave
        for b in a.keys():
            # Se não for um valor numérico, continuamos
            if isinstance(a[b], str):
                continue
            # Senão
            else:
                # Se o nome de chave 'b' já existir
                # como um nome de estatistica em nomes_maximos_valores
                if b in nomes_maximos_valores:
                    for c in maximos_valores:
                        if c.nome == b and a[b] > c.valor:
                            c.valor = a[b]
                            break
                # Senão
                else:
                    # Adiciona o nome de chave à lista nomes_maximos_valores
                    nomes_maximos_valores.append(b)
                    # Criar uma estatistica do zero
                    estatistica = Estatistica(nome=b,valor=a[b])
                    # Adiciona a estatistica criado à lista maximos_valores
                    maximos_valores.append(estatistica)

    # 4. Atualizar estatísticas de valores mais repetidos
    #
    # Para cada item
    for a in lista_itens:
        # Para cada nome de chave
        for b in a.keys():
            # Se a combinação entre nome de chave
            # e seu valor já existir atualizamos a frequência
            if f"{b} - {a[b]}" in nomes_frequencias_valores:
                # Buscamos pela entrada correspondente
                for c in frequencias_valores:
                    if c.nome == f"{b} - {a[b]}":
                        if a[b] == c.valor:
                            # Atualizamos o contador
                            c.contador += 1
                            break
            # Senão
            else:
                # Adiciona o nome à lista nomes_frequencias_valores
                # O nome neste caso é a composição do nome da chave
                # com o seu valor
                nomes_frequencias_valores.append(f"{b} - {a[b]}")
                # Criar uma estatistica do zero
                estatistica = Estatistica(nome=f"{b} - {a[b]}",valor=a[b])
                # Adiciona a estatistica criado à lista frequencias_valores
                frequencias_valores.append(estatistica)
    frequencias_valores_v2: Resultado_Estatistica = frequencias_valores
    for i in range(0, len(frequencias_valores)):
        frequencias_valores_v2[i].nome = frequencias_valores[i].nome.split(" - ")[0]
    
    frequencias_valores_v2 = sorted(frequencias_valores_v2, key=lambda x: x.contador, reverse=True)
    lista_nomes_v2: List[str] = []
    
    frequencias_valores_v3: List[Estatistica] = []    

    for item in frequencias_valores_v2:
        if item.nome not in lista_nomes_v2:
            lista_nomes_v2.append(item.nome)
            frequencias_valores_v3.append(item) 

        
    resultado = Resultado_Estatistica(maximos_valores=maximos_valores, frequencias_valores=frequencias_valores_v3)
    return resultado

# Mostrar o resultado na saída do terminal
def printar_resultado(resultado: Resultado_Estatistica):
    print("[Resultados]")
    print(" ")    
    print("1. Valores máximos:")
    print(" ")
    for i in range(0, len(resultado.maximos_valores)):
        print(f" atributo: {resultado.maximos_valores[i].nome}")
        print(f" valor: {resultado.maximos_valores[i].valor}")
        print(" ")
    print(" ")
    print("2. Valores mais repetidos (Modas):")
    print(" ")
    for i in range(0, len(resultado.frequencias_valores)):
        print(f" atributo: {resultado.frequencias_valores[i].nome}")
        print(f" valor: {resultado.frequencias_valores[i].valor}")
        print(f" frequencia: {resultado.frequencias_valores[i].contador}")
        print(" ")

if __name__ == "__main__":
    # Criando um processador de argumentos de linha de comando
    parser = ArgumentParser(description="Argumentos da linha de comando")
    # Criando argumento para receber o path do arquivo JSON
    parser.add_argument("--path",type=str,help="Path para um arquivo JSON")
    args = parser.parse_args()
    path_inserido = Path(args.path)
    # Se o path inserido existir e for um arquivo
    if path_inserido.exists() and path_inserido.is_file():
        # Se for um arquivo JSON
        if path_inserido.suffix.lower() == ".json":
            print(" ")
            print(f"Gerando estastísticas para {path_inserido}")
            print(" ")
            resultado = gerar_estatisticas(path_inserido)
            printar_resultado(resultado)
            print(" ")
# Fim
