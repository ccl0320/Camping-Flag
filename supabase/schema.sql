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
