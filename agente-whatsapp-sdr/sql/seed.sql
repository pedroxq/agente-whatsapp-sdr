-- Dados 100% FICTÍCIOS para testes locais.
insert into chats_new ("remoteJid", cliente, responsavel, name, status, transferido, "crmID", status_pedido)
values
  ('5511999990001@s.whatsapp.net', 'demo', 'demo', 'Cliente Exemplo A', 'I.A',    false, 'Lead',        'sem'),
  ('5511999990002@s.whatsapp.net', 'demo', 'demo', 'Cliente Exemplo B', 'HUMANO', true,  'Qualificado', 'em_producao'),
  ('5511999990003@s.whatsapp.net', 'demo', 'demo', 'Cliente Exemplo C', 'I.A',    false, 'Lead',        'pronto')
on conflict do nothing;

insert into followup ("remoteID", cliente, responsavel, name, encerrado)
values
  ('5511999990001@s.whatsapp.net', 'demo', 'demo', 'Cliente Exemplo A', false),
  ('5511999990002@s.whatsapp.net', 'demo', 'demo', 'Cliente Exemplo B', true),
  ('5511999990003@s.whatsapp.net', 'demo', 'demo', 'Cliente Exemplo C', false)
on conflict do nothing;
