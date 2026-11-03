-- Schema INFERIDO a partir dos nodes do Supabase dos workflows (colunas lidas/gravadas).
-- Revise tipos e índices antes de usar em produção.
-- Os identificadores têm maiúsculas (ex.: "remoteJid"), por isso precisam das aspas.

create table if not exists chats_new (
  id            bigint generated always as identity primary key,
  created_at    timestamptz not null default now(),
  "remoteJid"   text not null,                 -- telefone do contato (JID do WhatsApp)
  cliente       text not null,                 -- derivado do nome da instância
  responsavel   text not null,
  name          text,
  status        text not null default 'I.A',   -- 'I.A' (agente responde) | 'HUMANO' (pausado)
  transferido   boolean not null default false,
  "crmID"       text default 'Lead',           -- 'Lead' | 'Qualificado'
  resumo        text,                          -- resumo da conversa enviado ao atendente
  pausado_em    timestamptz,                   -- usado para reativar a IA após 3h
  status_pedido text not null default 'sem',   -- 'sem' | 'em_producao' | 'pronto' | 'entregue'
  "chatID"      text,
  "senderLid"   text,
  "sourceId"    text,
  "sourceUrl"   text,
  "ctwaClid"    text,
  unique ("remoteJid", cliente, responsavel)
);

create table if not exists followup (
  id                bigint generated always as identity primary key,
  created_at        timestamptz not null default now(),
  "remoteID"        text not null,
  cliente           text not null,
  responsavel       text not null,
  name              text,
  encerrado         boolean not null default false,
  "ultimaAtividade" timestamptz,
  "ultimaMensagem"  text,
  "senderLid"       text,
  unique ("remoteID", cliente, responsavel)
);

-- Memória do agente (o node "Postgres Chat Memory" também cria esta tabela sozinho).
create table if not exists n8n_chat_histories (
  id         serial primary key,
  session_id varchar(255) not null,
  message    jsonb not null
);

-- O n8n acessa com a service key (ignora RLS). Ative RLS para bloquear o acesso via anon key.
alter table chats_new enable row level security;
alter table followup  enable row level security;
