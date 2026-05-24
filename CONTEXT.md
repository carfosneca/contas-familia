# CM Finanças

PWA financeiro do casal Carla Zorzetto Fonseca e Matheus Soares Feres Veloso de Mello. Hospedado em GitHub Pages.

**Repo:** https://github.com/carfosneca/contas-familia
**URL pública:** https://carfosneca.github.io/contas-familia/
**Stack:** HTML + JS vanilla + JSON (sem build, sem framework).
**Arquivos no repo:** `index.html`, `dados.json`, `manifest.json`, `sw.js`, `icon-192.png`, `icon-512.png`.

Carla acessa principalmente pelo celular. Matheus também consulta.

Projeto em 3 partes:
- **Parte 1 (ATUAL):** Contas do casal — controle de gastos conjuntos.
- **Parte 2 (futura):** Gastos individuais de cada um.
- **Parte 3 (futura):** Renda, poupança, investimentos, aposentadoria.

---

## Regras financeiras

### Fixos — proporção 40% Carla / 60% Matheus

- Financiamento imóvel → Matheus paga (~R$ 13.700/mês)
- Condomínio → Carla (~R$ 1.606/mês)
- IPTU → Carla (~R$ 612/mês, jan a nov)
- Internet → Carla (~R$ 150/mês)
- Energia, Gás → Carla (variam)
- Faxineira → Carla (~R$ 600/mês)
- Seguro carro → Carla (~R$ 190/mês)

### Variável — proporção 50% Carla / 50% Matheus

Categorias: `Utilidades Casa`, `Mercado`, `Restaurante/Bar`, `Transporte`, `Viagem`, `Saude`, `Eventos/Jantares`, `Presentes`, `Roupas/Acessorios`, `Assinaturas`, `Outros`.

### Cartão conjunto

Cartões da Carla (final 2379 e 2975) que caem na fatura do Matheus (Itaú Personnalité 6208). Por padrão Matheus paga 100% da fatura, mas às vezes Carla paga parte direto. O `dados.json` tem campo `cartaoSplit` por mês registrando o split real: `{"matheus": X, "carla": Y}`.

### Regra importante

**Dados só a partir de jan/26.** Ignorar qualquer histórico anterior.

---

## Estrutura do `dados.json`

```json
{
  "meses": ["jan","fev","mar","abr"],
  "cores": { "Utilidades Casa": "#1a2f6b", "Mercado": "#c9a84c", "...": "..." },
  "dados": {
    "jan": {
      "label": "Jan/26",
      "total": 112415,
      "fix": 16542,
      "varr": 95873,
      "carlaPagou": 33054,
      "carlaDeve": 54553,
      "matheusPagou": 79361,
      "matheusDeve": 57862,
      "saldoCarla": -21499,
      "cartaoSplit": {"matheus": 4630, "carla": 4630},
      "fixos": [
        {"n":"Financiamento","p":"Matheus","v":13704}
      ],
      "cats": [
        {
          "n":"Utilidades Casa",
          "v":85000,
          "c":"#1a2f6b",
          "itens":[
            {"n":"móveis mix cotia","p":"Matheus","v":30000}
          ]
        }
      ]
    }
  }
}
```

### Convenções

- Categorias ordenadas por valor desc dentro de cada mês.
- Itens dentro de cada categoria ordenados por valor desc.
- Parcelas são **expandidas** no JSON (cada mês mostra a parcela daquele mês, não o valor total).
- Pagantes válidos nos itens: `"Carla"`, `"Matheus"`, `"Cartão Conjunto"`.

### Cálculos

- `carlaDeve = round(fix*0.4 + varr*0.5)`
- `matheusDeve = round(fix*0.6 + varr*0.5)`
- `saldoCarla = carlaPagou - carlaDeve` (negativo = Carla deve a Matheus)
- `carlaPagou` = soma dos itens onde `p == "Carla"` + soma dos fixos da Carla + `cartaoSplit.carla`
- `matheusPagou` = soma dos itens onde `p == "Matheus"` + soma dos fixos do Matheus + `cartaoSplit.matheus`
- Itens com `p == "Cartão Conjunto"` **não** contam direto pra carlaPagou/matheusPagou; quem entra é o `cartaoSplit` mensal.

---

## Telas do app (já implementadas no `index.html`)

1. **Gastos** — seletor de mês, total, toggle Fixo/Variável, lista. Toque numa categoria → modal com todos os itens ordenados por valor desc.
2. **Histórico** — barras empilhadas por mês (fixo azul, variável dourado) + tabela de % por categoria mês a mês.
3. **Acerto** — lista de meses com status (Quitado ✓ verde / Incorporado → cinza / Pendente ⏳ dourado). Modal de detalhe por mês. Registro de quitação salvo em `localStorage` (chave `cmf_quitacoes_v1`).

---

## Fluxo mensal

Todo mês a Carla manda:
1. **Fatura PDF** do Itaú Personnalité do Matheus (cartão conjunto).
2. **Template de gastos avulsos** com:
   - Fixos do mês (valores atualizados de Condomínio, IPTU, Energia, etc).
   - Extras avulsos pagos direto pela Carla ou pelo Matheus (fora da fatura).

### O que você (Claude Code) deve fazer:

1. Ler a fatura PDF e extrair os lançamentos.
2. Categorizar cada lançamento conforme as categorias do projeto.
3. **Perguntar o split do cartão conjunto:**
   - Total da fatura: R$ X
   - Quanto Matheus pagou? (default: total da fatura)
   - Quanto Carla pagou? (default: 0)
4. Adicionar o novo mês no `dados.json`:
   - Inserir lançamentos do mês (incluindo extras do template).
   - **Distribuir parcelas** automaticamente nos meses subsequentes.
   - Atualizar `meses[]` adicionando o novo mês.
   - Registrar `cartaoSplit` do mês.
   - Recalcular agregados (`total`, `fix`, `varr`, `carlaPagou`, `matheusPagou`, `carlaDeve`, `matheusDeve`, `saldoCarla`).
5. **Mostrar diff** do que mudou pra revisão antes de commitar.
6. Commit + push após aprovação.

---

## Regras importantes

- **Nunca commitar sem mostrar diff antes.** Sempre revisar com a Carla.
- **Validar números antes de salvar:** total = fix + varr; soma das categorias = varr; soma carlaPagou + matheusPagou = total.
- `index.html` quase nunca muda. Atualizações mensais mexem **só no `dados.json`**.
- Se precisar mudar lógica do app, **propor a mudança antes** de implementar.
- Cartão conjunto: sempre perguntar o split do mês, mesmo se for o default (Matheus 100%).
- Categorias e itens sempre ordenados por valor desc.
- Manter valores em reais inteiros (sem centavos) no JSON.

---

## Primeira tarefa nessa migração

1. Clonar o repo: `git clone https://github.com/carfosneca/contas-familia`
2. Listar os arquivos atuais e verificar estado do repo.
3. Substituir `index.html` e adicionar `dados.json` (versões geradas no chat web do Claude, que estão nessa mesma pasta).
4. Mostrar diff e aguardar aprovação antes do commit/push.
