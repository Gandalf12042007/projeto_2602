import mysql.connector
from mysql.connector import Error
from getpass import getpass
import sys

class SistemaEstoque:
    def __init__(self):
        self.conexao = None
        self.usuario_atual = None
        
    def conectar(self):
        print("chegou no banco de dados")
        try:
            self.conexao = mysql.connector.connect(
                host='localhost',
                user='root',
                password='',
                port=3306,
                
                database='super_shock_solutions_database'
            )
            print("chegou no fim da conexp")
            return True
        except Error as e:
            print(f"Erro ao conectar: {e}")
            return False

    def login(self):
        print("\n--- Sistema de Estoque ---")
        email = input("Email: ")
        senha = getpass("Senha: ")

        try:
            cursor = self.conexao.cursor(dictionary=True)
            cursor.execute("""
                SELECT f.*, c.nome_cargo 
                FROM funcionarios f
                JOIN cargos c ON f.id_cargo = c.id_cargo
                WHERE email = %s AND senha = %s
            """, (email, senha))
            
            usuario = cursor.fetchone()
            if usuario:
                self.usuario_atual = usuario
                print(f"\nBem-vindo, {usuario['nome_funcionario']} ({usuario['nome_cargo']})!")
                return True
            else:
                print("\nCredenciais inválidas!")
                return False
        except Error as e:
            print(f"Erro no login: {e}")
            return False

    def menu_principal(self):
        print("chegou aqui")
        while True:
            print("\n=== MENU PRINCIPAL ===")
            if self.usuario_atual['nome_cargo'] == 'administrator':
                print("1. Gerenciar Itens")
                print("2. Gerenciar Funcionários")
                print("3. Aprovar Transações")
                print("4. Relatórios")
                print("5. Sair")
            elif self.usuario_atual['nome_cargo'] == 'gerente':
                print("1. Aprovar Transações")
                print("2. Gerar Relatórios")
                print("3. Visualizar Itens")
                print("4. Sair")
            else:
                print("1. Registrar Movimentação")
                print("2. Visualizar Itens")
                print("3. Sair")

            opcao = input("Escolha uma opção: ")

            if self.usuario_atual['nome_cargo'] == 'administrator':
                self.menu_admin(opcao)
            elif self.usuario_atual['nome_cargo'] == 'gerente':
                self.menu_gerente(opcao)
            else:
                self.menu_operador(opcao)

    def menu_admin(self, opcao):
        if opcao == '1':
            self.gerenciar_itens()
        elif opcao == '2':
            self.gerenciar_funcionarios()
        elif opcao == '3':
            self.aprovar_transacoes()
        elif opcao == '4':
            self.gerar_relatorios()
        elif opcao == '5':
            sys.exit()
        else:
            print("Opção inválida!")

    def menu_gerente(self, opcao):
        if opcao == '1':
            self.aprovar_transacoes()
        elif opcao == '2':
            self.gerar_relatorios()
        elif opcao == '3':
            self.visualizar_itens()
        elif opcao == '4':
            sys.exit()
        else:
            print("Opção inválida!")

    def menu_operador(self, opcao):
        if opcao == '1':
            self.registrar_movimentacao()
        elif opcao == '2':
            self.visualizar_itens()
        elif opcao == '3':
            sys.exit()
        else:
            print("Opção inválida!")

    def visualizar_itens(self):
        try:
            cursor = self.conexao.cursor(dictionary=True)
            cursor.execute("SELECT * FROM itens")
            itens = cursor.fetchall()
            
            print("\n--- Lista de Itens ---")
            for item in itens:
                print(f"ID: {item['id_item']} | {item['nome_item']} | Estoque: {item['quantidade_item']}")
        except Error as e:
            print(f"Erro ao visualizar itens: {e}")

    def registrar_movimentacao(self):
        if self.usuario_atual['nome_cargo'] != 'operador':
            print("Acesso negado!")
            return

        print("\n--- Nova Movimentação ---")
        id_item = input("ID do Item: ")
        quantidade = input("Quantidade: ")
        tipo = input("Tipo (entrada/saida): ")

        try:
            cursor = self.conexao.cursor()
            cursor.execute("""
                INSERT INTO transacao (
                    id_item, quantidade_transacionada, data_transacao,
                    id_funcionario, id_local_origem, tipo_transacao
                ) VALUES (%s, %s, NOW(), %s, %s, %s)
            """, (id_item, quantidade, self.usuario_atual['id_funcionario'], 
                 self.usuario_atual['id_local'], tipo))
            
            self.conexao.commit()
            print("Movimentação registrada com sucesso! Aguardando aprovação.")
        except Error as e:
            print(f"Erro ao registrar movimentação: {e}")

    def aprovar_transacoes(self):
        if self.usuario_atual['nome_cargo'] not in ['administrator', 'gerente']:
            print("Acesso negado!")
            return

        try:
            cursor = self.conexao.cursor(dictionary=True)
            cursor.execute("""
                SELECT * FROM transacao 
                WHERE id_transacao NOT IN (
                    SELECT id_transacao FROM logs_auditoria
                )
            """)
            pendentes = cursor.fetchall()

            print("\n--- Transações Pendentes ---")
            for trans in pendentes:
                print(f"ID: {trans['id_transacao']} | Item: {trans['id_item']} | Qtd: {trans['quantidade_transacionada']}")

            id_trans = input("ID da transação para aprovar (ou 0 para cancelar): ")
            if id_trans == '0':
                return

            cursor.execute("""
                INSERT INTO logs_auditoria (
                    id_transacao, id_local_origem, data_registro,
                    status_transacao, id_funcionario_autorizador
                ) VALUES (%s, %s, NOW(), 'completo', %s)
            """, (id_trans, self.usuario_atual['id_local'], self.usuario_atual['id_funcionario']))
            
            self.conexao.commit()
            print("Transação aprovada com sucesso!")
        except Error as e:
            print(f"Erro ao aprovar transação: {e}")

    def gerenciar_funcionarios(self):
        print("\nOpção em construção...")

    def gerenciar_itens(self):
        print("\nOpção em construção...")

    def gerar_relatorios(self):
        print("\nOpção em construção...")

if __name__ == "__main__":
    sistema = SistemaEstoque()
    if sistema.conectar():
        if sistema.login():
            sistema.menu_principal()

