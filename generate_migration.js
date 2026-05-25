const dados = require('./repo/dados.json');
const fs = require('fs');

const esc = s => String(s).replace(/'/g, "''");

let sql = `-- CM Finanças - Migration para Supabase
-- Rodar no Supabase SQL Editor

-- Tabelas
drop table if exists itens cascade;
drop table if exists fixos cascade;
drop table if exists meses cascade;
drop table if exists cores cascade;

create table cores (
  categoria text primary key,
  cor text not null
);

create table meses (
  mes text primary key,
  label text not null,
  total int not null default 0,
  fix int not null default 0,
  varr int not null default 0,
  carla_pagou int not null default 0,
  carla_deve int not null default 0,
  matheus_pagou int not null default 0,
  matheus_deve int not null default 0,
  saldo_carla int not null default 0,
  cartao_matheus int not null default 0,
  cartao_carla int not null default 0
);

create table fixos (
  id serial primary key,
  mes text references meses(mes) on delete cascade,
  nome text not null,
  pagante text not null,
  valor int not null
);

create table itens (
  id serial primary key,
  mes text references meses(mes) on delete cascade,
  categoria text references cores(categoria),
  nome text not null,
  pagante text not null,
  valor int not null
);

-- RLS: leitura pública (app família)
alter table cores enable row level security;
alter table meses enable row level security;
alter table fixos enable row level security;
alter table itens enable row level security;

create policy "leitura publica" on cores for select using (true);
create policy "leitura publica" on meses for select using (true);
create policy "leitura publica" on fixos for select using (true);
create policy "leitura publica" on itens for select using (true);

create policy "escrita publica" on cores for all using (true);
create policy "escrita publica" on meses for all using (true);
create policy "escrita publica" on fixos for all using (true);
create policy "escrita publica" on itens for all using (true);

-- Dados: cores
`;

for (const [cat, cor] of Object.entries(dados.cores)) {
  sql += `insert into cores (categoria, cor) values ('${esc(cat)}', '${esc(cor)}');\n`;
}

sql += '\n-- Dados: meses\n';
for (const mes of dados.meses) {
  const d = dados.dados[mes];
  sql += `insert into meses (mes, label, total, fix, varr, carla_pagou, carla_deve, matheus_pagou, matheus_deve, saldo_carla, cartao_matheus, cartao_carla) values ('${mes}', '${esc(d.label)}', ${d.total}, ${d.fix}, ${d.varr}, ${d.carlaPagou}, ${d.carlaDeve}, ${d.matheusPagou}, ${d.matheusDeve}, ${d.saldoCarla}, ${d.cartaoSplit.matheus}, ${d.cartaoSplit.carla});\n`;
}

sql += '\n-- Dados: fixos\n';
for (const mes of dados.meses) {
  for (const f of dados.dados[mes].fixos) {
    sql += `insert into fixos (mes, nome, pagante, valor) values ('${mes}', '${esc(f.n)}', '${esc(f.p)}', ${f.v});\n`;
  }
}

sql += '\n-- Dados: itens\n';
for (const mes of dados.meses) {
  for (const cat of dados.dados[mes].cats) {
    for (const item of cat.itens) {
      sql += `insert into itens (mes, categoria, nome, pagante, valor) values ('${mes}', '${esc(cat.n)}', '${esc(item.n)}', '${esc(item.p)}', ${item.v});\n`;
    }
  }
}

fs.writeFileSync('/home/user/contas-familia/migration.sql', sql);
console.log('migration.sql gerado com sucesso!');
console.log('Linhas:', sql.split('\n').length);
