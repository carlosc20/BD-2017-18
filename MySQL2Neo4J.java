import org.neo4j.driver.v1.exceptions.Neo4jException;

import java.sql.*;
import java.util.*;
import java.sql.Date;

public class MySQL2Neo4J {
    private Connection mysql;
    private Connection neo4j;

    public static void main(String[] args) {
        try {
            String password = "";
            MySQL2Neo4J db = new MySQL2Neo4J()
                    .mysqlConnect("jdbc:mysql://127.0.0.1:3306/mydb?useSSL=false", "root", password)
                    .neo4jConnect("jdbc:neo4j:bolt://localhost:7687", "neo4j", password);
            db.neo4jQuery("MATCH (n) DETACH DELETE n"); //Apaga a base de dados neo4j
            /* Funcionario */
            {
                // Nome das colunas em MySQL do funcionário e o seu tipo em Neo4J
                HashMap<String, String> col = new HashMap<>();
                col.put("numero", "INTEGER");
                col.put("nome", "STRING");
                // col.put("data_de_nascimento", "DATE");
                // col.put("genero", "STRING");
                // col.put("data_criacao", "DATETIME");
                col.put("empregado", "BOOLEAN");
                // col.put("salario", "FLOAT");
                // Transforma a tabela num Nodo em Neo4J, recebe o nome da tabela e o map com o nome das colunas
                db.tableToNode("Funcionario", col);
            }
            /* Funcao_funcionario */
            {
                // Vai buscar a Funcao de cada funcionario
                ResultSet res = db.mysqlQuery("SELECT * FROM Funcao_funcionario INNER JOIN Funcao ON Funcao_funcionario.funcao = Funcao.id");
                HashMap<Integer, List<String>> funcoes = new HashMap<>();
                // Adiciona a cada funcionario a lista das suas funções
                while (res.next()) {
                    List<String> list = funcoes.getOrDefault(res.getInt("Funcao_funcionario.numero"), new ArrayList<>());
                    list.add("'"+res.getString("Funcao.designacao")+"'");
                    funcoes.putIfAbsent(res.getInt("Funcao_funcionario.numero"), list);
                }
                // Atualiza a cada funcionário a propriedade funcao com o array da designação da funçao que realiza
                for (Map.Entry<Integer, List<String>> entry : funcoes.entrySet()) {
                    int id = entry.getKey();
                    List<String> f = entry.getValue();
                    db.neo4jQuery("MATCH (a:Funcionario {numero: " + id + "}) SET a.funcao = " + Arrays.toString(f.toArray()));
                }
            }
            /* Horario */
            {
                // Colunas das tabelas
                HashMap<String, String> col = new HashMap<>();
                col.put("id", "INTEGER");
                col.put("data_inicio", "DATE");
                col.put("data_fim", "DATE");
                col.put("hora_inicio", "TIME");
                col.put("hora_fim", "TIME");
                // Cria os nodos a partir da tabela horario
                db.tableToNode("Horario", col);
            }
            /* Horario_funcionario */
            {
                // A relação não tem propriedades
                HashMap<String, String> horario_funcionario = new HashMap<>();
                // identifica o nodo de origem
                HashMap<String, String> horario_funcionarioFrom = new HashMap<>();
                horario_funcionarioFrom.put("id_funcionario", "INTEGER");
                // identifica o nodo de destino
                HashMap<String, String> horario_funcionarioTo = new HashMap<>();
                horario_funcionarioTo.put("id_horario", "INTEGER");
                // Converte as colunas id_funcionario em numero e id_horario em id
                HashMap<String, String> horario_funcionarioDic = new HashMap<>();
                horario_funcionarioDic.put("id_funcionario", "numero");
                horario_funcionarioDic.put("id_horario", "id");
                // Cria a relação com base na tabela Horario_funcionario
                db.table2relationship("Horario_funcionario",
                        horario_funcionarioFrom,
                        horario_funcionarioTo,
                        horario_funcionario,
                        horario_funcionarioDic,
                        "TEM",
                        "Funcionario",
                        "Horario");
            }
            /* Dias_da_semana */
            {
                // Retorna todos os valores de Dias_da_semana
                ResultSet res = db.mysqlQuery("SELECT * FROM Dias_da_semana");
                HashMap<Integer, List<Integer>> dias_da_semana = new HashMap<>();
                // Adiciona a cada horario os seus dias da semana
                while (res.next()) {
                    List<Integer> list = dias_da_semana.getOrDefault(res.getInt("id"), new ArrayList<>(7));
                    list.add(res.getInt("dia"));
                    dias_da_semana.putIfAbsent(res.getInt("id"), list);
                }
                // Atualiza cada horario com os seus dias_da_semana
                for (Map.Entry<Integer, List<Integer>> entry : dias_da_semana.entrySet()) {
                    int id = entry.getKey();
                    List<Integer> dias = entry.getValue();
                    db.neo4jQuery("MATCH (a:Horario {id: " + id + "}) SET a.dias_da_semana = " + Arrays.toString(dias.toArray()));
                }
            }
            /* Servico_ao_cliente */
            {
                // Colunas da tabela Servico
                HashMap<String, String> col = new HashMap<>();
                col.put("id", "INTEGER");
                col.put("Estado.designacao", "STRING");
                col.put("data_de_inicio", "DATETIME");
                col.put("duracao", "TIME");
                col.put("Tipo.designacao", "STRING"); // tipo
                // col.put("observacao", "STRING");
                col.put("limite_clientes", "INTEGER");
                // Junta o servico ao servico ao cliente para obter todas as informações sobre o servico_ao_cliente
                // Junta também o estado
                LinkedHashMap<String, String> joins = new LinkedHashMap<>();
                joins.put("Servico_ao_cliente", "Servico.id = Servico_ao_cliente.id");
                joins.put("Estado", "Servico.estado = Estado.id");
                joins.put("Tipo","Servico_ao_cliente.tipo = Tipo.id"); // tipo
                // Converte a cluna Estado.designacao em propriedade estado
                HashMap<String, String> dic = new HashMap<>();
                dic.put("Estado.designacao", "estado");
                dic.put("Tipo.designacao", "tipo"); // tipo
                // Cria uma tabela com base nas tabelas Servico, Servico_ao_cliente e Estado em nodos cujas labels são
                // Servico e Servico_ao_cliente
                db.tableToNode("Servico", col, "Servico:Servico_ao_cliente", dic, joins);
            }
            /* Manutencao */
            {
                // o mesmo que o Servico_ao_Cliente mas com a tabela da Manutencao
                HashMap<String, String> col = new HashMap<>();
                col.put("id", "INTEGER");
                col.put("Estado.designacao", "STRING");
                col.put("data_de_inicio", "DATETIME");
                col.put("duracao", "TIME");
                // col.put("observacao", "STRING");
                // col.put("despesas", "FLOAT");
                // col.put("fatura", "INTEGER");
                LinkedHashMap<String, String> joins = new LinkedHashMap<>();
                joins.put("Manutencao", "Servico.id = Manutencao.id");
                joins.put("Estado", "Servico.estado = Estado.id");
                HashMap<String, String> dic = new HashMap<>();
                dic.put("Estado.designacao", "estado");
                db.tableToNode("Servico", col, "Servico:Manutencao", dic, joins);
            }
            /* Servico_funcionario */
            {
                HashMap<String, String> fromCol = new HashMap<>();
                fromCol.put("id_funcionario", "INTEGER");
                HashMap<String, String> toCol = new HashMap<>();
                toCol.put("id_servico", "INTEGER");
                HashMap<String, String> relCol = new HashMap<>();
                // relCol.put("Funcao.designacao", "designacao");
                LinkedHashMap<String, String> join = new LinkedHashMap<>();
                // join.put("Funcao", "Servico_funcionario.funcao = Funcao.id");
                HashMap<String, String> colDic = new HashMap<>();
                colDic.put("id_servico", "id");
                colDic.put("id_funcionario", "numero");
                // colDic.put("Funcao.designacao", "funcao");
                db.table2relationship("Servico_funcionario", fromCol, toCol, relCol, colDic, "PARTICIPA_EM", "Funcionario", "Servico", join);
            }
            /* Tipo */
            /*
            {
                HashMap<String, String> col = new HashMap<>();
                col.put("id", "INTEGER");
                col.put("designacao", "STRING");
                col.put("preco", "FLOAT");
                col.put("desconto", "FLOAT");
                db.tableToNode("Tipo", col);
            }
            */
            /* Servico_ao_cliente -> Tipo */
            /*
            {
                ResultSet res = db.mysqlQuery("SELECT id, tipo FROM Servico_ao_cliente");
                while (res.next()) {
                    HashMap<String, String> prop = new HashMap<>();
                    HashMap<String, String> from = new HashMap<>();
                    from.put("id", Integer.toString(res.getInt("id")));
                    HashMap<String, String> to = new HashMap<>();
                    to.put("id", Integer.toString(res.getInt("tipo")));
                    String query = db.createRelationshipNeo4J("DO", prop, "Servico", from, "Tipo", to);
                    db.neo4jQuery(query);
                }
            }
            */
            /* Cliente */
            {
                HashMap<String, String> col = new HashMap<>();
                col.put("id", "INTEGER");
                col.put("nome", "STRING");
                col.put("data_nascimento", "DATE");
                // col.put("genero", "STRING");
                // col.put("data_criacao", "DATETIME");
                col.put("brevete", "BOOLEAN");
                col.put("formacao_paraquedismo", "BOOLEAN");
                col.put("numero_de_telefone", "STRING");
                col.put("morada", "STRING");
                db.tableToNode("Cliente", col);
            }
            /* Socio */
            {
                ResultSet res = db.mysqlQuery("SELECT id_cliente, numero_socio FROM Socio");
                while (res.next()){
                    int id = res.getInt("id_cliente");
                    int numSocio = res.getInt("numero_socio");
                    db.neo4jQuery("MATCH (a:Cliente {id: " + id + "}) SET a:Socio, a.numero_socio = " + numSocio);
                }
            }
            /* Quotas */
            {
                ResultSet res = db.mysqlQuery("SELECT * FROM Quotas");
                HashMap<Integer, List<Integer>> quotas = new HashMap<>();
                while (res.next()) {
                    List<Integer> list = quotas.getOrDefault(res.getInt("id"), new ArrayList<>());
                    list.add(res.getInt("ano"));
                    quotas.putIfAbsent(res.getInt("id"), list);
                }
                for (Map.Entry<Integer, List<Integer>> entry : quotas.entrySet()) {
                    int id = entry.getKey();
                    List<Integer> anos = entry.getValue();
                    db.neo4jQuery("MATCH (a:Socio {numero_socio: " + id + "}) SET a.quotas = " + Arrays.toString(anos.toArray()));
                }
            }
            /* Cliente_servico */
            {
                HashMap<String, String> fromCol = new HashMap<>();
                fromCol.put("id_cliente", "INTEGER");
                HashMap<String, String> toCol = new HashMap<>();
                toCol.put("id_servico", "INTEGER");
                HashMap<String, String> relCol = new HashMap<>();
                // relCol.put("pagamento", "FLOAT");
                // relCol.put("presenca", "BOOLEAN");
                HashMap<String, String> dic = new HashMap<>();
                dic.put("id_cliente", "id");
                dic.put("id_servico", "id");
                db.table2relationship("Cliente_servico", fromCol, toCol, relCol, dic, "PARTICIPA_EM", "Cliente", "Servico");
            }
            /* Aviao */
            {
                HashMap<String, String> col = new HashMap<>();
                col.put("marcas_da_aeronave", "STRING");
                col.put("Lugar_local.designacao", "STRING");
                col.put("proprietario", "STRING");
                // col.put("modelo", "STRING");
                col.put("numero_max_passageiros", "INTEGER");
                col.put("disponivel", "BOOLEAN");
                col.put("data_proxima_revisao", "DATE");
                col.put("Tipo.designacao", "STRING"); // tipo
                HashMap<String, String> dic = new HashMap<>();
                dic.put("Lugar_local.designacao", "lugar_local");
                dic.put("Tipo.designacao", "tipo"); // tipo
                LinkedHashMap<String, String> join = new LinkedHashMap<>();
                join.put("Lugar_local", "Aviao.lugar_local = Lugar_local.id");
                join.put("Tipo", "Aviao.tipo = Tipo.id"); // tipo
                db.tableToNode("Aviao", col, "Aviao", dic, join);
            }
            /* Tipo -> Aviao */
            /*
            {
                ResultSet res = db.mysqlQuery("SELECT marcas_da_aeronave, tipo FROM Aviao");
                while (res.next()){
                    HashMap<String, String> prop = new HashMap<>();
                    HashMap<String, String> from = new HashMap<>();
                    from.put("marcas_da_aeronave", "'" + res.getString("marcas_da_aeronave") + "'");
                    HashMap<String, String> to = new HashMap<>();
                    to.put("id", Integer.toString(res.getInt("tipo")));
                    db.createRelationshipNeo4J("USADO_PARA", prop, "Aviao", from, "Tipo", to);
                }
            }
            */
            /* Remover id do tipo */
            /*
            {
                db.neo4jQuery("MATCH (a:Tipo) REMOVE a.id");
            }
            */
            /* Manutencao -> Aviao */
            {
                ResultSet res = db.mysqlQuery("SELECT id, marcas_da_aeronave FROM Manutencao");
                while (res.next()){
                    HashMap<String, String> prop = new HashMap<>();
                    HashMap<String, String> from = new HashMap<>();
                    from.put("id", Integer.toString(res.getInt("id")));
                    HashMap<String, String> to = new HashMap<>();
                    to.put("marcas_da_aeronave", "'" + res.getString("marcas_da_aeronave") + "'");
                    String query = db.createRelationshipNeo4J("MANTEM", prop, "Manutencao", from, "Aviao", to);
                    db.neo4jQuery(query);
                }
            }
            /* Ciclo */
            {
                HashMap<String, String> fromCol = new HashMap<>();
                fromCol.put("id_servico", "INTEGER");
                HashMap<String, String> toCol = new HashMap<>();
                toCol.put("marcas_da_aeronave", "STRING");
                HashMap<String, String> relCol = new HashMap<>();
                relCol.put("hora_partida_prevista", "DATETIME");
                relCol.put("hora_chegada_prevista", "DATETIME");
                //relCol.put("hora_chegada", "DATETIME");
                HashMap<String, String> dic = new HashMap<>();
                dic.put("id_servico", "id");
                db.table2relationship("Ciclo", fromCol, toCol, relCol, dic, "Ciclo", "Servico_ao_cliente", "Aviao");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public MySQL2Neo4J() {
        mysql = null;
        neo4j = null;
    }

    public MySQL2Neo4J mysqlConnect(String url, String user, String password) throws Exception {
        Class.forName("com.mysql.jdbc.Driver");
        mysql = DriverManager.getConnection(url, user, password);
        return this;
    }

    public MySQL2Neo4J neo4jConnect(String url, String user, String password) throws Exception {
        Class.forName("org.neo4j.jdbc.Driver");
        neo4j = DriverManager.getConnection(url, user, password);
        return this;
    }

    public void close() throws Exception {
        if(mysql != null) {
            mysql.close();
            mysql = null;
        }
        if(neo4j != null) {
            neo4j.close();
            neo4j = null;
        }
    }

    /**
     * Retorna todas as rows de uma tabela
     * @param table Nome da tabela
     * @return Conjunto de todas as rows da tabela
     * @throws Exception
     */
    private ResultSet getAllRows(String table) throws Exception {
        Statement st = mysql.createStatement();
        String query = "SELECT * FROM " + table;
        //System.out.println(query);
        return st.executeQuery(query);
    }

    /**
     * Retorna o valor em String da coluna recebida
     * Os valores BOOLEAN, INTEGER e FLOAT são convertidos para string
     * Aos valores STRING são acrescentados pelicas
     * @param res Linha atual do ResultSet
     * @param colName Nome da coluna que se pretende obter o valor
     * @param colType Tipo da coluna, pode ser BOOLEAN, INTEGER, FLOAT ou STRING
     * @return Valor em String da coluna recebida
     * @throws Exception
     */
    private String getValue(ResultSet res, String colName, String colType) throws Exception {
        String str = null;
        switch (colType){
            case "BOOLEAN":
                str = Boolean.toString(res.getBoolean(colName));
                break;
            case "INTEGER":
                str = Integer.toString(res.getInt(colName));
                break;
            case "STRING":
                str = "'" + res.getString(colName) + "'";
                break;
            case "FLOAT":
                str = Float.toString(res.getFloat(colName));
                break;
            case "DATE":
                str = "date('" + res.getDate(colName).toString() + "')";
                break;
            case "TIME":
                str = "time('" + res.getTime(colName).toString() + "')";
                break;
            case "DATETIME":
                str = "datetime('" + res.getTimestamp(colName).toString().replace(' ','T') + "')";
                break;
            default:
                str = "'" + res.getString(colName) + "'";
                break;
        }
        if(res.wasNull()){
            return null;
        } else {
            return str;
        }
    }

    /**
     * Cria uma String com a query da criação de um nodo com uma determinada label e propriedades
     * @param label Nome da label do nodo
     * @param properties Map que relaciona as propriedades e o seu valor
     * @return
     */
    private String createNodeNeo4J(String label, Map<String, String> properties) {
        return "CREATE (n:" + label + " " + propertiesToString(properties) + ")";
    }

    /**
     * Gera texto de neo4j por exemplo: se receber um map {<"id", 1>, <"nome": "Maria"} retorna a serguinte expressão
     * {id: 1, nome: Maria}
     * pode ser usado para indicar o nodo ou a relação em concreto
     * @param properties map com as propriedades
     * @return
     */
    private String propertiesToString(Map<String, String> properties) {
        if(properties == null || properties.size() == 0) {
            return "";
        }
        StringBuilder sb = new StringBuilder("{");
        boolean first = true;
        for(Map.Entry<String, String> value:properties.entrySet()) {
            if(first){
                first = false;
            } else {
                sb.append(", ");
            }
            sb.append(value.getKey()).append(": ").append(value.getValue());
        }
        sb.append("}");
        return sb.toString();
    }

    /**
     * Cria o texto de uma query em Neo4J
     * @param label label da relação
     * @param properties propriedades da relação, a chave é o nome da propriedade e o value é o valor da propriedade
     * @param fromLabel label do nodo de origem, se tiver varios labels podem ser separados por :
     * @param fromProperties propriedades do nodo de origem, a chave é o nome da propriedade e o value é o valor da propriedade
     * @param toLabel label do nodo de destino, se tiver varios labels podem ser separados por :
     * @param toProperties propriedades do nodo de destino, a chave é o nome da propriedade e o value é o valor da propriedade
     * @return texto da query a ser executada no Neo4J
     */
    private String createRelationshipNeo4J(String label,
                                           Map<String, String> properties,
                                           String fromLabel,
                                           Map<String, String> fromProperties,
                                           String toLabel,
                                           Map<String, String> toProperties) {
        String str = "MATCH (a:" + fromLabel + " " + propertiesToString(fromProperties) + "), ";
        str += "(b:" + toLabel + " " + propertiesToString(toProperties) + ")";
        str += " CREATE (a)-[r:" + label + propertiesToString(properties) + "]->(b)";
        return str;
    }

    private Map<String, String> propertiesOfColumns(ResultSet res,
                                    Map<String, String> columnsType,
                                    Map<String, String> columnsToProperties) throws Exception {
        HashMap<String, String> properties = new HashMap<>(columnsType.size());
        for(Map.Entry<String, String> entry:columnsType.entrySet()){
            String colName = entry.getKey();
            String colType = entry.getValue();
            String value = getValue(res, colName, colType);
            if(value != null) {
                properties.put(columnsToProperties.getOrDefault(colName, colName), value);
            }
        }
        return properties;
    }

    /**
     * Gera os nodos a partir de uma tabela MySQL
     * @param table Nome da tabela MySQL
     * @param columnsType Map que liga o nome das colunas da tabela MySQL com o tipo dos dados em Neo4J
     * @param label Label dos nodos a serem criados
     * @param columnsToProperties Map que transforma o nome das colunas em propriedades dos nodos.
     * @throws Exception
     */
    public MySQL2Neo4J tableToNode(String table,
                                  Map<String, String> columnsType,
                                  String label,
                                  Map<String,String> columnsToProperties,
                                  LinkedHashMap<String, String> tablesToJoin) throws Exception {
        if(label == null){
            label = table;
        }
        if(columnsToProperties == null){
            columnsToProperties = new HashMap<>(0);
        }
        if(tablesToJoin != null){
            table = joinTables(table, tablesToJoin);
        }
        ResultSet res = getAllRows(table);
        while (res.next()) {
            Map<String, String> properties = propertiesOfColumns(res, columnsType, columnsToProperties);
            String query = createNodeNeo4J(label, properties);
            neo4j.createStatement().executeQuery(query);
            //System.out.println(query); //Para testes
        }
        return this;
    }

    public MySQL2Neo4J tableToNode(String table, Map<String, String> columnsType, String label, Map<String,String> columnsToProperties) throws Exception {
        return tableToNode(table, columnsType, label, columnsToProperties, null);
    }

    public MySQL2Neo4J tableToNode(String table, Map<String, String> columnsType, String label) throws Exception {
        return tableToNode(table, columnsType, label, null, null);
    }

    public MySQL2Neo4J tableToNode(String table, Map<String, String> columnsType) throws Exception {
        return tableToNode(table, columnsType, null, null, null);
    }

    /**
     * Gera as relações a partir de uma tabela MySQL
     * @param table Nome da tabela MySQL
     * @param fromNodeColumnsType Map que liga o nome das colunas da primary key do MySQL com o tipo dos dados em Neo4J
     * @param toNodeColumnsType Map que liga o nome das colunas da primary key do MySQL com o tipo dos dados em Neo4J
     * @param relationshipColumnsType Map que liga o nome das colunas dos dados da relação do MySQL com  tipo dos dados em Neo4J
     * @param columnsToProperties Map que transforma o nome das colunas em nome das propriedades dos nodos.
     * @param label Nome da relação
     * @param fromLabel Label do nodo de origem
     * @param toLabel Label do nodo de destino
     * @param tablesToJoin Map onde a key é o nome da tabela e o value é a condição de junção
     * @throws Exception
     */
    public MySQL2Neo4J table2relationship(String table,
                                          HashMap<String, String> fromNodeColumnsType,
                                          HashMap<String, String> toNodeColumnsType,
                                          Map<String, String> relationshipColumnsType,
                                          Map<String, String> columnsToProperties,
                                          String label,
                                          String fromLabel,
                                          String toLabel,
                                          LinkedHashMap<String, String> tablesToJoin) throws Exception {
        if(tablesToJoin != null){
            table = joinTables(table, tablesToJoin);
        }
        ResultSet res = getAllRows(table);
        while (res.next()) {
            Map<String, String> fromProperties = propertiesOfColumns(res, fromNodeColumnsType, columnsToProperties);
            Map<String, String> toProperties = propertiesOfColumns(res, toNodeColumnsType, columnsToProperties);
            Map<String, String> properties = propertiesOfColumns(res, relationshipColumnsType, columnsToProperties);
            String query = createRelationshipNeo4J(label, properties, fromLabel, fromProperties, toLabel, toProperties);
            neo4j.createStatement().executeQuery(query);
            //System.out.println(query); //Para testes
        }
        return this;
    }

    public MySQL2Neo4J table2relationship(String table,
                                          HashMap<String, String> fromNodeColumnsType,
                                          HashMap<String, String> toNodeColumnsType,
                                          Map<String, String> relationshipColumnsType,
                                          Map<String, String> columnsToProperties,
                                          String label,
                                          String fromLabel,
                                          String toLabel) throws Exception {
        return table2relationship(table, fromNodeColumnsType, toNodeColumnsType, relationshipColumnsType, columnsToProperties, label, fromLabel, toLabel, null);
    }

    public MySQL2Neo4J foreignKeyToRelationship(String table,
                                                Map<String, String> fromColumnsFKType,
                                                Map<String, String> toColumnsFKType,
                                                Map<String, String> columnsType,
                                                String label,
                                                String fromLabel,
                                                String toLabel,
                                                Map<String, String> columnsToProperties) throws Exception {
        ResultSet res = getAllRows(table);
        while (res.next()){
            Map<String, String> fromProperties = propertiesOfColumns(res, fromColumnsFKType, columnsToProperties);
            Map<String, String> toProperties = propertiesOfColumns(res, toColumnsFKType, columnsToProperties);
            Map<String, String> properties = propertiesOfColumns(res, columnsType, columnsToProperties);
            String query = createRelationshipNeo4J(label, properties, fromLabel, fromProperties, toLabel, toProperties);
            neo4jQuery(query);
            //System.out.println(query); //Para testes
        }
        return this;
    }

    /**
     * @param table nome da tabela MySQL
     * @param tablesToJoin Map onde a chave é o nome da tabela e o value a codição de junção
     * @return String com a tabela correspondente
     */
    private static String joinTables(String table, LinkedHashMap<String, String> tablesToJoin){
        StringBuilder sb = new StringBuilder(table);
        for (Map.Entry<String, String> entry:tablesToJoin.entrySet()){
            String tableName = entry.getKey();
            String join = entry.getValue();
            if(tableName.substring(0,1).equals("<")) {
                sb.append(" LEFT JOIN ").append(tableName.substring(1));
            } else if(tableName.substring(0,1).equals(">")) {
                sb.append(" RIGHT JOIN ").append(tableName.substring(1));
            } else {
                sb.append(" INNER JOIN ").append(tableName);
            }
            if(join != null){
                sb.append(" ON ").append(join);
            }
        }
        //System.out.println(sb.toString());
        return sb.toString();
    }

    /**
     * Executa uma query MySQL
     * @param query string a ser executada
     * @return Resultado da query
     * @throws SQLException
     */
    public ResultSet mysqlQuery(String query) throws SQLException {
        //System.out.println(query); //Para testar
        return mysql.createStatement().executeQuery(query);
    }

    /**
     * Executa uma query Neo4J
     * @param query string a ser executada
     * @return Resultado da query
     * @throws SQLException
     */
    public ResultSet neo4jQuery(String query) throws SQLException {
        // System.out.println(query); // Para testar
        return neo4j.createStatement().executeQuery(query);
    }
}
