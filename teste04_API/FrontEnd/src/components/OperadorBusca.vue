<template>
  <div class="container">
    <h1>Busca de Operadoras ANS</h1>
    
    <div class="search-bar">
      <input 
        type="text" 
        v-model="searchTerm" 
        placeholder="Digite um termo de busca"
      />
      <button @click="buscar">Buscar</button>
    </div>
    
    <div v-if="carregando" class="loading">Carregando...</div>
    
    <div v-if="erro" class="error">{{ erro }}</div>
    
    <div v-if="resultados.length > 0">
      <h3>Resultados:</h3>
      <ul class="result-list">
        <li v-for="item in resultados" :key="item.Registro_ANS" class="result-item">
          <strong>{{ item.Nome_Fantasia || item.Razao_Social }}</strong><br>
          CNPJ: {{ item.CNPJ }} | Registro ANS: {{ item.Registro_ANS }}
        </li>
      </ul>
    </div>
    
    <div v-else-if="buscaRealizada">
      Nenhum resultado encontrado.
    </div>
  </div>
</template>

<script>
export default {
  name: "OperadoraBusca",
  data() {
    return {
      searchTerm: "",
      resultados: [],
      carregando: false,
      erro: "",
      buscaRealizada: false
    };
  },
  methods: {
    async buscar() {
      if (!this.searchTerm) return;

      this.carregando = true;
      this.erro = "";
      this.buscaRealizada = true;

      try {
        const resposta = await fetch(`http://localhost:5000/busca?termo=${this.searchTerm}`);
        let dados = await resposta.json();

        this.resultados = dados
        
      } catch (e) {
        this.erro = "Erro na busca";
        console.log(e);
        this.resultados = [];
      } finally {
        this.carregando = false;
      }
    }
  }
};
</script>

<style scoped>
.container {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
}

.search-bar {
  margin-bottom: 20px;
}

.search-bar input {
  padding: 8px;
  width: 300px;
  margin-right: 10px;
}

.search-bar button {
  padding: 8px 15px;
}

.loading {
  font-weight: bold;
  color: blue;
}

.error {
  color: red;
}

.result-list {
  list-style: none;
  padding: 0;
}

.result-item {
  margin-bottom: 15px;
  border-bottom: 1px solid #eee;
  padding-bottom: 10px;
}
</style>
