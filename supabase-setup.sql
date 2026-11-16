-- Cole tudo isto no SQL Editor do Supabase e clique em Run.
create table if not exists public.dados (
  user_id uuid primary key default auth.uid() references auth.users(id) on delete cascade,
  json jsonb not null,
  ts bigint not null default 0,
  updated_at timestamptz not null default now()
);

alter table public.dados enable row level security;

create policy "ler os proprios dados" on public.dados
  for select to authenticated using (user_id = auth.uid());

create policy "inserir os proprios dados" on public.dados
  for insert to authenticated with check (user_id = auth.uid());

create policy "atualizar os proprios dados" on public.dados
  for update to authenticated using (user_id = auth.uid()) with check (user_id = auth.uid());
