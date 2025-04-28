const palavras = ["o seu negócio", "a sua inovação", "o seu futuro"];
let indiceAtual = 0;

function alternarPalavras() {
    const elemento = document.getElementById("palavra-alternada");
    elemento.textContent = palavras[indiceAtual];
    indiceAtual = (indiceAtual + 1) % palavras.length;
}

setInterval(alternarPalavras, 2000);


    function irParaPagina() {
        window.location.href = './pages/solucoes.html' // Redireciona para a página solucoes.html
    }

    // Função para adicionar um efeito de animação ao botão
    document.querySelector('.btn-saiba-mais').addEventListener('mouseover', function() {
        this.style.backgroundColor = '#FF8C00' // Altera a cor de fundo ao passar o mouse
    });

    document.querySelector('.btn-saiba-mais').addEventListener('mouseout', function() {
        this.style.backgroundColor = 'var(--cor-secundaria)' // Restaura a cor de fundo original
    });
