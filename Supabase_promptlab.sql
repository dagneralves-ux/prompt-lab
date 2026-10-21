-- Prompt Lab · sincronização (rode UMA vez no SQL Editor do Supabase)
-- Pode ser o mesmo projeto do DS Gestão: cria só uma tabela nova.
create table if not exists public.promptlab_dados (
  user_id       uuid primary key default auth.uid() references auth.users(id) on delete cascade,
  dados         jsonb not null,
  atualizado_em timestamptz not null default now()
);
alter table public.promptlab_dados enable row level security;
drop policy if exists "promptlab_dados_dono" on public.promptlab_dados;
create policy "promptlab_dados_dono" on public.promptlab_dados
  for all to authenticated
  using (user_id = auth.uid())
  with check (user_id = auth.uid());
