-- Cuaderno Barcelona 2027 · esquema de Supabase
-- Ejecuta este archivo entero en Supabase → SQL Editor → New query → Run.

create table if not exists public.logs (
  user_id    uuid not null default auth.uid() references auth.users(id) on delete cascade,
  key        text not null,               -- fecha planificada + índice de sesión, p. ej. 2026-10-14-30
  data       jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now(),
  primary key (user_id, key)
);

create table if not exists public.settings (
  user_id    uuid primary key default auth.uid() references auth.users(id) on delete cascade,
  data       jsonb not null default '{}'::jsonb,   -- ritmos, sesiones movidas
  updated_at timestamptz not null default now()
);

create table if not exists public.body (
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  date    date not null,
  weight  numeric,
  waist   numeric,
  primary key (user_id, date)
);

-- Cada persona solo ve y cambia sus propias filas
alter table public.logs     enable row level security;
alter table public.settings enable row level security;
alter table public.body     enable row level security;

drop policy if exists "logs propios"     on public.logs;
drop policy if exists "ajustes propios"  on public.settings;
drop policy if exists "fisico propio"    on public.body;

create policy "logs propios"    on public.logs     for all to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "ajustes propios" on public.settings for all to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "fisico propio"   on public.body     for all to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- Sincronización en vivo entre ordenador y móvil
do $$
begin
  begin alter publication supabase_realtime add table public.logs;     exception when duplicate_object then null; end;
  begin alter publication supabase_realtime add table public.settings; exception when duplicate_object then null; end;
  begin alter publication supabase_realtime add table public.body;     exception when duplicate_object then null; end;
end $$;
