-- 露營足跡 · Supabase schema
-- 在 Supabase Dashboard → SQL Editor 貼上執行一次即可

create table if not exists public.camping_state (
  id          text primary key default 'main',
  owner       uuid not null default auth.uid() references auth.users(id) on delete cascade,
  data        jsonb not null,
  updated_at  timestamptz not null default now()
);

alter table public.camping_state enable row level security;

-- 任何人都能讀（GitHub Pages 訪客可以看到地圖）
-- 若想完全私密，把 using (true) 改成 using (owner = auth.uid())
drop policy if exists "public read" on public.camping_state;
create policy "public read" on public.camping_state
  for select using (true);

-- 只有登入的擁有者能新增 / 修改
drop policy if exists "owner insert" on public.camping_state;
create policy "owner insert" on public.camping_state
  for insert to authenticated with check (owner = auth.uid());

drop policy if exists "owner update" on public.camping_state;
create policy "owner update" on public.camping_state
  for update to authenticated using (owner = auth.uid()) with check (owner = auth.uid());

-- 實際部署（English-Island 專案）：因該專案還有其他玩家帳號，
-- 不開放 insert；資料列由管理者以 Jerry 的帳號建立後，只允許擁有者 update。

-- ============================================================
-- v2：多使用者（每人一筆紀錄）
-- ============================================================
create table if not exists public.camping_logs (
  user_id uuid primary key default auth.uid() references auth.users(id) on delete cascade,
  display_name text not null default '' check (char_length(display_name) <= 40),
  is_public boolean not null default false,
  data jsonb not null default '{"version":1,"sites":[],"trips":[]}'::jsonb check (octet_length(data::text) < 2000000),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
alter table public.camping_logs enable row level security;
create policy "logs read own or public" on public.camping_logs for select using (is_public or user_id = (select auth.uid()));
create policy "logs insert own" on public.camping_logs for insert to authenticated with check (user_id = (select auth.uid()));
create policy "logs update own" on public.camping_logs for update to authenticated using (user_id = (select auth.uid())) with check (user_id = (select auth.uid()));
create policy "logs delete own" on public.camping_logs for delete to authenticated using (user_id = (select auth.uid()));
grant select on public.camping_logs to anon;
grant select, insert, update, delete on public.camping_logs to authenticated;
