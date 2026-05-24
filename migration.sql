-- CM Finanças - Migration para Supabase
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
insert into cores (categoria, cor) values ('Utilidades Casa', '#1a2f6b');
insert into cores (categoria, cor) values ('Mercado', '#c9a84c');
insert into cores (categoria, cor) values ('Restaurante/Bar', '#888888');
insert into cores (categoria, cor) values ('Transporte', '#534AB7');
insert into cores (categoria, cor) values ('Viagem', '#5856D6');
insert into cores (categoria, cor) values ('Saude', '#ff3b30');
insert into cores (categoria, cor) values ('Eventos/Jantares', '#BA7517');
insert into cores (categoria, cor) values ('Presentes', '#D4537E');
insert into cores (categoria, cor) values ('Roupas/Acessorios', '#FF9500');
insert into cores (categoria, cor) values ('Assinaturas', '#34C759');
insert into cores (categoria, cor) values ('Outros', '#aaaaaa');

-- Dados: meses
insert into meses (mes, label, total, fix, varr, carla_pagou, carla_deve, matheus_pagou, matheus_deve, saldo_carla, cartao_matheus, cartao_carla) values ('jan', 'Jan/26', 112415, 16542, 95873, 33054, 54553, 79361, 57862, -21499, 4630, 4630);
insert into meses (mes, label, total, fix, varr, carla_pagou, carla_deve, matheus_pagou, matheus_deve, saldo_carla, cartao_matheus, cartao_carla) values ('fev', 'Fev/26', 34696, 17193, 17503, 10659, 15629, 24035, 19067, -4970, 10300, 0);
insert into meses (mes, label, total, fix, varr, carla_pagou, carla_deve, matheus_pagou, matheus_deve, saldo_carla, cartao_matheus, cartao_carla) values ('mar', 'Mar/26', 31818, 17483, 14335, 10017, 14161, 21799, 17657, -4144, 8107, 0);
insert into meses (mes, label, total, fix, varr, carla_pagou, carla_deve, matheus_pagou, matheus_deve, saldo_carla, cartao_matheus, cartao_carla) values ('abr', 'Abr/26', 49606, 17302, 32304, 23127, 23073, 26477, 26533, 54, 11997, 0);

-- Dados: fixos
insert into fixos (mes, nome, pagante, valor) values ('jan', 'Financiamento', 'Matheus', 13704);
insert into fixos (mes, nome, pagante, valor) values ('jan', 'Condomínio', 'Carla', 1606);
insert into fixos (mes, nome, pagante, valor) values ('jan', 'Internet', 'Carla', 150);
insert into fixos (mes, nome, pagante, valor) values ('jan', 'Energia', 'Carla', 229);
insert into fixos (mes, nome, pagante, valor) values ('jan', 'Gás', 'Carla', 63);
insert into fixos (mes, nome, pagante, valor) values ('jan', 'Faxineira', 'Carla', 600);
insert into fixos (mes, nome, pagante, valor) values ('jan', 'Seguro carro', 'Carla', 190);
insert into fixos (mes, nome, pagante, valor) values ('fev', 'Financiamento', 'Matheus', 13704);
insert into fixos (mes, nome, pagante, valor) values ('fev', 'Condomínio', 'Carla', 1606);
insert into fixos (mes, nome, pagante, valor) values ('fev', 'IPTU', 'Carla', 612);
insert into fixos (mes, nome, pagante, valor) values ('fev', 'Internet', 'Carla', 150);
insert into fixos (mes, nome, pagante, valor) values ('fev', 'Energia', 'Carla', 159);
insert into fixos (mes, nome, pagante, valor) values ('fev', 'Gás', 'Carla', 172);
insert into fixos (mes, nome, pagante, valor) values ('fev', 'Faxineira', 'Carla', 600);
insert into fixos (mes, nome, pagante, valor) values ('fev', 'Seguro carro', 'Carla', 190);
insert into fixos (mes, nome, pagante, valor) values ('mar', 'Financiamento', 'Matheus', 13692);
insert into fixos (mes, nome, pagante, valor) values ('mar', 'Condomínio', 'Carla', 1606);
insert into fixos (mes, nome, pagante, valor) values ('mar', 'IPTU', 'Carla', 612);
insert into fixos (mes, nome, pagante, valor) values ('mar', 'Internet', 'Carla', 150);
insert into fixos (mes, nome, pagante, valor) values ('mar', 'Energia', 'Carla', 524);
insert into fixos (mes, nome, pagante, valor) values ('mar', 'Gás', 'Carla', 109);
insert into fixos (mes, nome, pagante, valor) values ('mar', 'Faxineira', 'Carla', 600);
insert into fixos (mes, nome, pagante, valor) values ('mar', 'Seguro carro', 'Carla', 190);
insert into fixos (mes, nome, pagante, valor) values ('abr', 'Financiamento', 'Matheus', 13690);
insert into fixos (mes, nome, pagante, valor) values ('abr', 'Condomínio', 'Carla', 1606);
insert into fixos (mes, nome, pagante, valor) values ('abr', 'IPTU', 'Carla', 612);
insert into fixos (mes, nome, pagante, valor) values ('abr', 'Internet', 'Carla', 150);
insert into fixos (mes, nome, pagante, valor) values ('abr', 'Energia', 'Carla', 315);
insert into fixos (mes, nome, pagante, valor) values ('abr', 'Gás', 'Carla', 139);
insert into fixos (mes, nome, pagante, valor) values ('abr', 'Faxineira', 'Carla', 600);
insert into fixos (mes, nome, pagante, valor) values ('abr', 'Seguro carro', 'Carla', 190);

-- Dados: itens
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Utilidades Casa', 'móveis mix cotia', 'Matheus', 30000);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Utilidades Casa', 'ar condicionado', 'Matheus', 8661);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Utilidades Casa', 'cama', 'Carla', 7275);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Utilidades Casa', 'móveis planejados Thi (1/7)', 'Carla', 6280);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Utilidades Casa', 'televisão sala', 'Matheus', 4723);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Utilidades Casa', 'máquina de lavar', 'Matheus', 3093);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Utilidades Casa', 'lava louças', 'Matheus', 2715);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Utilidades Casa', 'televisão quarto', 'Matheus', 2529);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Utilidades Casa', 'forno', 'Matheus', 2500);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Utilidades Casa', 'cooktop', 'Matheus', 2400);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Utilidades Casa', 'cervejeira', 'Carla', 2208);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Utilidades Casa', 'roupa cama king', 'Carla', 875);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Utilidades Casa', 'ML - talheres sobremesa', 'Cartão Conjunto', 866);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Utilidades Casa', 'travesseiro visita', 'Carla', 375);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Utilidades Casa', 'microondas', 'Matheus', 365);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Utilidades Casa', 'utensílios cozinha', 'Carla', 363);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Utilidades Casa', 'panela (1/6)', 'Cartão Conjunto', 275);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Utilidades Casa', 'roupa cama casal 2', 'Carla', 275);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Utilidades Casa', 'ML - roteador (1/5)', 'Cartão Conjunto', 258);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Utilidades Casa', 'orquídea', 'Carla', 182);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Utilidades Casa', 'ML - ímã suporte papel toalha', 'Cartão Conjunto', 166);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Utilidades Casa', 'ML - cabide + orquídea', 'Carla', 152);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Utilidades Casa', 'ML - potes + talher silicone', 'Cartão Conjunto', 141);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Utilidades Casa', 'ML - coqueteleira', 'Cartão Conjunto', 112);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Utilidades Casa', 'aspirador pó', 'Carla', 100);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Utilidades Casa', 'cobertor + tapete', 'Carla', 97);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Utilidades Casa', 'roupa cama casal (1/12)', 'Carla', 96);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Utilidades Casa', 'ML - lixeira fogão + closet', 'Cartão Conjunto', 58);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Utilidades Casa', 'ML - potinho mel', 'Matheus', 30);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Presentes', 'presente bel', 'Carla', 4899);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Presentes', 'presente rafa - lego', 'Cartão Conjunto', 380);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Eventos/Jantares', 'emporium são paulo', 'Cartão Conjunto', 1253);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Eventos/Jantares', 'emporium são paulo', 'Cartão Conjunto', 409);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Eventos/Jantares', 'ingresso luz sé (c e m)', 'Carla', 400);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Eventos/Jantares', 'ML - comida jantar', 'Matheus', 292);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Eventos/Jantares', 'clube da ostra', 'Matheus', 192);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Eventos/Jantares', 'ML - comida jantar', 'Matheus', 183);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Eventos/Jantares', 'emporium são paulo', 'Cartão Conjunto', 176);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Eventos/Jantares', 'emporium são paulo', 'Cartão Conjunto', 149);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Eventos/Jantares', 'padaria jules', 'Cartão Conjunto', 102);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Eventos/Jantares', 'swift', 'Cartão Conjunto', 69);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Eventos/Jantares', 'padaria jules', 'Cartão Conjunto', 61);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Transporte', 'passagem BH janeiro', 'Matheus', 1040);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Transporte', 'passagem BH agosto', 'Matheus', 729);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Transporte', 'passagem BH gol (1/4)', 'Cartão Conjunto', 615);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Transporte', 'passagem BH abril', 'Matheus', 535);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Transporte', 'uber 99', 'Matheus', 53);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Transporte', 'estacionamento', 'Carla', 35);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Transporte', 'uber', 'Carla', 33);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Transporte', 'estacionamento', 'Matheus', 30);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Transporte', 'uber', 'Carla', 25);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Transporte', 'estacionamento', 'Carla', 22);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Transporte', 'uber 99', 'Carla', 18);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Transporte', 'uber 99', 'Carla', 16);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Transporte', 'uber', 'Carla', 16);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Transporte', 'estacionamento rua', 'Carla', 15);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Transporte', 'estacionamento rua', 'Carla', 7);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Transporte', 'estacionamento', 'Carla', 7);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Transporte', 'estacionamento rua', 'Carla', 7);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Transporte', 'estacionamento', 'Carla', 5);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Restaurante/Bar', 'bar arcos sé', 'Cartão Conjunto', 666);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Restaurante/Bar', 'restaurante francês moema', 'Cartão Conjunto', 344);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Restaurante/Bar', 'almoço feijoada moema', 'Cartão Conjunto', 305);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Restaurante/Bar', 'bar bh', 'Carla', 251);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Restaurante/Bar', 'bar bh', 'Carla', 197);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Restaurante/Bar', 'bar bh', 'Carla', 149);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Mercado', 'mercado sams', 'Cartão Conjunto', 324);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Mercado', 'ML - mercado', 'Cartão Conjunto', 271);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Mercado', 'emporium são paulo', 'Cartão Conjunto', 265);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Mercado', 'emporium são paulo', 'Matheus', 156);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Mercado', 'açougue', 'Cartão Conjunto', 148);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Mercado', 'emporium são paulo', 'Cartão Conjunto', 125);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Mercado', 'sacolão BH', 'Carla', 103);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Mercado', 'açougue', 'Matheus', 69);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Mercado', 'mercado KOA - bala', 'Cartão Conjunto', 65);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Mercado', 'isqueiro', 'Cartão Conjunto', 45);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Mercado', 'álcool 90', 'Cartão Conjunto', 42);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Mercado', 'ovos', 'Cartão Conjunto', 37);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Mercado', 'mercado dia', 'Cartão Conjunto', 13);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Mercado', 'oxxo', 'Cartão Conjunto', 6);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Outros', 'conta tio Dovigo (casamento + pessoais) (1/10)', 'Cartão Conjunto', 957);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Outros', 'conta luz (particular Carla)', 'Cartão Conjunto', 229);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Outros', 'tim (particular Carla)', 'Cartão Conjunto', 150);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Saude', 'raia', 'Matheus', 216);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Saude', 'raia', 'Carla', 206);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Saude', 'consulta Marcelo', 'Carla', 160);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Saude', 'raia', 'Cartão Conjunto', 135);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Saude', 'exame Marcelo', 'Carla', 90);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Saude', 'drogasil', 'Cartão Conjunto', 33);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Saude', 'panvel', 'Carla', 19);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Saude', 'pavel', 'Cartão Conjunto', 10);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Viagem', 'qatar', 'Matheus', 516);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Roupas/Acessorios', 'roupa Matheus ano novo + shorts', 'Carla', 408);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Assinaturas', 'meli+ e assinatura', 'Carla', 127);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Assinaturas', 'assinatura globo+', 'Carla', 55);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Assinaturas', 'assinatura HBO', 'Carla', 15);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Assinaturas', 'assinatura netflix', 'Carla', 13);
insert into itens (mes, categoria, nome, pagante, valor) values ('jan', 'Assinaturas', 'assinatura prime', 'Carla', 10);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Utilidades Casa', 'móveis planejados Thi (2/7)', 'Carla', 6280);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Utilidades Casa', 'tábua corte, assadeiras, alicate, leiteira, conector', 'Cartão Conjunto', 604);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Utilidades Casa', 'pillow', 'Carla', 459);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Utilidades Casa', 'panela (2/6)', 'Cartão Conjunto', 275);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Utilidades Casa', 'ML - roteador (2/5)', 'Cartão Conjunto', 258);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Utilidades Casa', 'manteigueira', 'Cartão Conjunto', 250);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Utilidades Casa', 'lâmpadas', 'Cartão Conjunto', 115);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Utilidades Casa', 'roupa cama casal (2/12)', 'Carla', 96);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Utilidades Casa', 'pilão ralador cutelo', 'Cartão Conjunto', 86);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Utilidades Casa', 'plástico cobrir sofá', 'Cartão Conjunto', 71);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Utilidades Casa', 'plástico cobrir sofá', 'Cartão Conjunto', 71);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Utilidades Casa', 'tábua corte, assadeiras, alicate, leiteira, conector (1/5)', 'Cartão Conjunto', 33);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Utilidades Casa', 'pano de prato', 'Matheus', 31);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Utilidades Casa', 'pilão ralador cutelo (1/5)', 'Cartão Conjunto', 28);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Utilidades Casa', 'velcro fechar sofá', 'Cartão Conjunto', 28);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Mercado', 'emporio são paulo', 'Cartão Conjunto', 861);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Mercado', 'trella (1/2)', 'Cartão Conjunto', 176);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Mercado', 'suco proteico', 'Cartão Conjunto', 172);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Mercado', 'swift', 'Cartão Conjunto', 131);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Mercado', 'bem bh', 'Cartão Conjunto', 116);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Mercado', 'emporio são paulo', 'Cartão Conjunto', 115);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Mercado', 'mercado bh', 'Cartão Conjunto', 113);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Mercado', 'espasso sabores mogi', 'Cartão Conjunto', 79);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Mercado', 'emporio são paulo', 'Cartão Conjunto', 71);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Mercado', 'ovos', 'Cartão Conjunto', 70);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Mercado', 'mercado japonês koa', 'Cartão Conjunto', 48);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Mercado', 'bem bh', 'Cartão Conjunto', 25);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Mercado', 'bem bh', 'Cartão Conjunto', 22);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Mercado', 'emporio são paulo', 'Cartão Conjunto', 17);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Saude', 'creatina', 'Cartão Conjunto', 691);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Saude', 'vitamina d', 'Cartão Conjunto', 331);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Saude', 'essential - suplemento (1/6)', 'Cartão Conjunto', 187);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Saude', 'creme dermatite', 'Carla', 132);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Saude', 'panvel', 'Cartão Conjunto', 75);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Saude', 'drogasil', 'Cartão Conjunto', 57);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Saude', 'panvel', 'Cartão Conjunto', 29);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Restaurante/Bar', 'restaurante', 'Cartão Conjunto', 961);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Restaurante/Bar', 'passeio holambra - comida/bebida', 'Cartão Conjunto', 135);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Restaurante/Bar', 'café mug amigas mar', 'Cartão Conjunto', 72);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Restaurante/Bar', 'passeio holambra - comida/bebida', 'Cartão Conjunto', 60);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Restaurante/Bar', 'passeio holambra - comida/bebida', 'Cartão Conjunto', 40);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Restaurante/Bar', 'passeio holambra - comida/bebida', 'Cartão Conjunto', 30);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Transporte', 'passagem BH gol (2/4)', 'Cartão Conjunto', 615);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Transporte', 'passagem BH dezembro (1/4)', 'Cartão Conjunto', 189);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Transporte', 'uber', 'Cartão Conjunto', 157);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Transporte', 'uber', 'Cartão Conjunto', 95);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Transporte', 'posto', 'Cartão Conjunto', 66);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Transporte', 'uber', 'Cartão Conjunto', 31);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Transporte', 'uber', 'Cartão Conjunto', 29);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Transporte', 'taxi aeroporto volta casa', 'Carla', 25);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Transporte', 'estacionamento', 'Cartão Conjunto', 22);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Transporte', 'uber', 'Cartão Conjunto', 19);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Transporte', 'uber', 'Cartão Conjunto', 19);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Transporte', 'estacionamento rua', 'Cartão Conjunto', 14);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Transporte', 'estacionamento rua', 'Cartão Conjunto', 7);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Outros', 'conta tio Dovigo (casamento + pessoais) (2/10)', 'Cartão Conjunto', 957);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Outros', 'cabelo Matheus sil', 'Cartão Conjunto', 180);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Outros', 'conta tim', 'Cartão Conjunto', 149);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Outros', 'revista lógica', 'Cartão Conjunto', 21);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Outros', 'conta tim (reembolso)', 'Carla', -150);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Presentes', 'presente ana paula - track field', 'Carla', 380);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Presentes', 'presente teteia', 'Cartão Conjunto', 298);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Presentes', 'bolo aniversário ana paula', 'Carla', 122);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Eventos/Jantares', 'churrasco paulinho', 'Cartão Conjunto', 558);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Eventos/Jantares', 'churrasco paulinho carvão', 'Cartão Conjunto', 172);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Eventos/Jantares', 'cerveja churras carnaval paulinho', 'Carla', 136);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Eventos/Jantares', 'padaria jules', 'Cartão Conjunto', 71);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Eventos/Jantares', 'churrasco paulinho (reembolso)', 'Carla', -310);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Viagem', 'passeio holambra - entrada', 'Cartão Conjunto', 72);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Viagem', 'passeio holambra - extras', 'Cartão Conjunto', 30);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Viagem', 'passeio holambra - entrada', 'Cartão Conjunto', 18);
insert into itens (mes, categoria, nome, pagante, valor) values ('fev', 'Viagem', 'passeio holambra - extras', 'Cartão Conjunto', 10);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Utilidades Casa', 'móveis planejados Thi (3/7)', 'Carla', 6280);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Utilidades Casa', 'panela (3/6)', 'Cartão Conjunto', 275);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Utilidades Casa', 'ML - roteador (3/5)', 'Cartão Conjunto', 258);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Utilidades Casa', 'jogos party games (1/2)', 'Cartão Conjunto', 205);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Utilidades Casa', 'pendente quarto (1/6)', 'Cartão Conjunto', 163);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Utilidades Casa', 'cheirinho casa (1/3)', 'Cartão Conjunto', 103);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Utilidades Casa', 'roupa cama casal (3/12)', 'Carla', 96);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Utilidades Casa', 'tábua corte, assadeiras, alicate, leiteira, conector (2/5)', 'Cartão Conjunto', 33);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Utilidades Casa', 'pilão ralador cutelo (2/5)', 'Cartão Conjunto', 28);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Mercado', 'mercado são paulo', 'Cartão Conjunto', 311);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Mercado', 'mercado são paulo', 'Cartão Conjunto', 272);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Mercado', 'açougue', 'Cartão Conjunto', 203);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Mercado', 'loja queijo mineiro', 'Cartão Conjunto', 189);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Mercado', 'mercado são paulo', 'Cartão Conjunto', 181);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Mercado', 'feira comida gostosa - mission chocolate', 'Cartão Conjunto', 180);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Mercado', 'trella (2/2)', 'Cartão Conjunto', 176);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Mercado', 'feira comida gostosa - queijos', 'Cartão Conjunto', 150);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Mercado', 'feira comida gostosa - pasta', 'Cartão Conjunto', 138);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Mercado', 'mercado são paulo', 'Cartão Conjunto', 121);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Mercado', 'armazén queijo mineiro', 'Cartão Conjunto', 76);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Mercado', 'mercado são paulo', 'Cartão Conjunto', 67);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Mercado', 'feira comida gostosa - queijos', 'Cartão Conjunto', 56);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Mercado', 'ovo', 'Cartão Conjunto', 27);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Mercado', 'supermercado oxxo', 'Cartão Conjunto', 5);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Mercado', 'padaria julies', 'Cartão Conjunto', 5);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Restaurante/Bar', 'tordezilhas', 'Cartão Conjunto', 440);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Restaurante/Bar', 'giro bar', 'Cartão Conjunto', 283);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Restaurante/Bar', 'pilha vinagre álcool filtro café', 'Cartão Conjunto', 236);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Restaurante/Bar', 'pizza delicinha', 'Cartão Conjunto', 219);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Restaurante/Bar', 'bienal', 'Cartão Conjunto', 112);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Restaurante/Bar', 'feira comida gostosa - cerveja', 'Cartão Conjunto', 101);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Restaurante/Bar', 'lanche geremias', 'Cartão Conjunto', 90);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Restaurante/Bar', 'padaria frente tordezilhas', 'Cartão Conjunto', 78);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Restaurante/Bar', 'feira comida gostosa - lena', 'Cartão Conjunto', 75);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Restaurante/Bar', 'feira comida gostosa - lena', 'Cartão Conjunto', 70);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Restaurante/Bar', 'feira comida gostosa - cerveja', 'Cartão Conjunto', 51);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Restaurante/Bar', 'feira comida gostosa - comida', 'Cartão Conjunto', 42);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Restaurante/Bar', 'feira comida gostosa - lena', 'Cartão Conjunto', 40);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Restaurante/Bar', 'feira comida gostosa - cerveja', 'Cartão Conjunto', 33);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Restaurante/Bar', 'água', 'Cartão Conjunto', 28);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Restaurante/Bar', 'feira comida gostosa - cerveja', 'Cartão Conjunto', 25);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Restaurante/Bar', 'feira comida gostosa - sorvete', 'Cartão Conjunto', 25);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Restaurante/Bar', 'feira comida gostosa - cerveja', 'Cartão Conjunto', 21);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Restaurante/Bar', 'feira comida gostosa - cerveja', 'Cartão Conjunto', 20);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Restaurante/Bar', 'café', 'Cartão Conjunto', 8);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Restaurante/Bar', 'feira comida gostosa - água', 'Cartão Conjunto', 8);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Restaurante/Bar', 'feira comida gostosa - água', 'Cartão Conjunto', 7);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Outros', 'conta tio Dovigo (casamento + pessoais) (3/10)', 'Cartão Conjunto', 957);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Outros', 'sil carla', 'Cartão Conjunto', 330);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Outros', 'conta tim', 'Cartão Conjunto', 149);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Outros', 'bluetooth carro', 'Cartão Conjunto', 120);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Outros', 'elástico exercício', 'Cartão Conjunto', 35);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Outros', 'conta tim (reembolso)', 'Carla', -150);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Transporte', 'passagem BH gol (3/4)', 'Cartão Conjunto', 615);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Transporte', 'passagem BH dezembro (2/4)', 'Cartão Conjunto', 189);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Transporte', 'estacionamento', 'Cartão Conjunto', 40);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Transporte', 'uber', 'Cartão Conjunto', 14);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Transporte', 'uber', 'Cartão Conjunto', 10);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Saude', 'essential - suplemento (2/6)', 'Cartão Conjunto', 187);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Saude', 'farmácia panvel', 'Cartão Conjunto', 23);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Eventos/Jantares', 'torneio laço bizerro', 'Cartão Conjunto', 93);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Eventos/Jantares', 'torneio laço bizerro', 'Cartão Conjunto', 44);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Eventos/Jantares', 'torneio laço bizerro', 'Cartão Conjunto', 35);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Eventos/Jantares', 'recanto tio silmar comida', 'Cartão Conjunto', 18);
insert into itens (mes, categoria, nome, pagante, valor) values ('mar', 'Eventos/Jantares', 'recanto tio silmar comida', 'Cartão Conjunto', 16);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Utilidades Casa', 'móveis planejados Thi (4/7)', 'Carla', 6280);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Utilidades Casa', 'lustre mesa jantar', 'Carla', 6000);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Utilidades Casa', 'vidro + espelhos 50%', 'Carla', 2111);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Utilidades Casa', 'reinstalação ar', 'Matheus', 790);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Utilidades Casa', 'prateleira temperos (1/3)', 'Cartão Conjunto', 777);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Utilidades Casa', 'câmera casa', 'Cartão Conjunto', 716);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Utilidades Casa', 'planta canto café', 'Carla', 430);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Utilidades Casa', 'impermeabilização pedra sala', 'Carla', 400);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Utilidades Casa', 'cortina (1/12)', 'Cartão Conjunto', 362);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Utilidades Casa', 'prateleira', 'Cartão Conjunto', 293);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Utilidades Casa', 'panela (4/6)', 'Cartão Conjunto', 275);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Utilidades Casa', 'película 30%', 'Carla', 266);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Utilidades Casa', 'ML - roteador (4/5)', 'Cartão Conjunto', 258);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Utilidades Casa', 'jogos party games (2/2)', 'Cartão Conjunto', 205);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Utilidades Casa', 'pendente quarto (2/6)', 'Cartão Conjunto', 163);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Utilidades Casa', 'termômetro adega', 'Cartão Conjunto', 136);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Utilidades Casa', 'cheirinho casa (2/3)', 'Cartão Conjunto', 103);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Utilidades Casa', 'roupa cama casal (4/12)', 'Carla', 96);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Utilidades Casa', 'T e adaptador', 'Cartão Conjunto', 79);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Utilidades Casa', 'adaptador', 'Cartão Conjunto', 47);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Utilidades Casa', 'tábua corte, assadeiras, alicate, leiteira, conector (3/5)', 'Cartão Conjunto', 33);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Utilidades Casa', 'fio instalação móveis', 'Cartão Conjunto', 29);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Utilidades Casa', 'pilão ralador cutelo (3/5)', 'Cartão Conjunto', 28);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Utilidades Casa', 'prateleira copinhos - devolvi', 'Cartão Conjunto', -876);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Viagem', 'viagem uruguai', 'Cartão Conjunto', 1870);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Viagem', 'viagem santo antonio pinhal - jonny', 'Carla', 1760);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Viagem', 'viagem santo antonio pinhal - vinícola reserva', 'Carla', 590);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Viagem', 'viagem santo ant pinhal', 'Cartão Conjunto', 353);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Viagem', 'viagem santo antonio pinhal - vinícola adicional', 'Carla', 226);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Viagem', 'viagem santo ant pinhal', 'Cartão Conjunto', 165);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Viagem', 'viagem santo ant pinhal', 'Cartão Conjunto', 121);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Viagem', 'retirada painel madeira - lixo', 'Carla', 80);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Viagem', 'viagem santo ant pinhal', 'Cartão Conjunto', 73);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Viagem', 'viagem santo ant pinhal', 'Cartão Conjunto', 71);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Viagem', 'viagem santo ant pinhal', 'Cartão Conjunto', 68);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Viagem', 'viagem santo ant pinhal', 'Cartão Conjunto', 56);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Viagem', 'viagem santo ant pinhal', 'Cartão Conjunto', 52);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Viagem', 'viagem santo ant pinhal', 'Cartão Conjunto', 48);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Viagem', 'viagem santo ant pinhal', 'Cartão Conjunto', 46);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Viagem', 'viagem santo ant pinhal', 'Cartão Conjunto', 36);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Viagem', 'viagem santo ant pinhal', 'Cartão Conjunto', 35);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Viagem', 'viagem santo ant pinhal', 'Cartão Conjunto', 32);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Viagem', 'viagem santo ant pinhal', 'Cartão Conjunto', 25);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Viagem', 'viagem santo ant pinhal', 'Cartão Conjunto', 22);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Viagem', 'viagem santo ant pinhal', 'Cartão Conjunto', 21);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Mercado', 'grão de café', 'Cartão Conjunto', 417);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Mercado', 'mercado', 'Cartão Conjunto', 363);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Mercado', 'mercado', 'Cartão Conjunto', 346);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Mercado', 'shampoo', 'Cartão Conjunto', 340);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Mercado', 'mercado mogi', 'Cartão Conjunto', 244);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Mercado', 'mercado mogi', 'Cartão Conjunto', 163);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Mercado', 'mercado mogi', 'Cartão Conjunto', 157);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Mercado', 'mercado', 'Cartão Conjunto', 138);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Mercado', 'mercado japonês', 'Cartão Conjunto', 75);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Mercado', 'mercado japonês', 'Cartão Conjunto', 64);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Mercado', 'mercado mogi', 'Cartão Conjunto', 56);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Mercado', 'mercado ovo', 'Cartão Conjunto', 54);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Mercado', 'mercado mogi', 'Cartão Conjunto', 53);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Mercado', 'mercado nórdico', 'Cartão Conjunto', 49);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Outros', 'revisão carro', 'Carla', 1426);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Outros', 'conta tio Dovigo (casamento + pessoais) (4/10)', 'Cartão Conjunto', 957);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Outros', 'conta tim', 'Cartão Conjunto', 149);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Outros', 'elástico exercício', 'Cartão Conjunto', 33);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Outros', 'conta tim (reembolso)', 'Carla', -150);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Transporte', 'passagem BH gol (4/4)', 'Cartão Conjunto', 615);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Transporte', 'passagem BH dezembro (3/4)', 'Cartão Conjunto', 189);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Transporte', 'gasolina', 'Cartão Conjunto', 150);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Transporte', 'estacionamento', 'Cartão Conjunto', 70);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Transporte', 'uber', 'Cartão Conjunto', 48);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Transporte', 'uber', 'Cartão Conjunto', 32);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Transporte', 'estacionamento', 'Cartão Conjunto', 30);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Transporte', 'uber', 'Cartão Conjunto', 21);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Transporte', 'uber', 'Cartão Conjunto', 11);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Transporte', 'uber', 'Cartão Conjunto', 5);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Restaurante/Bar', 'mission chocolate', 'Cartão Conjunto', 623);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Restaurante/Bar', 'boteco moema', 'Cartão Conjunto', 185);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Restaurante/Bar', 'café com je e gustavo', 'Cartão Conjunto', 75);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Saude', 'vitamina', 'Cartão Conjunto', 318);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Saude', 'essential - suplemento (3/6)', 'Cartão Conjunto', 187);
insert into itens (mes, categoria, nome, pagante, valor) values ('abr', 'Saude', 'farmácia', 'Cartão Conjunto', 60);
