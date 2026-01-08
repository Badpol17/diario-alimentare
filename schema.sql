create extension if not exists "pgcrypto";

create table foods (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  kcal_per_100g numeric not null,
  protein_g numeric not null,
  carbs_total_g numeric not null,
  carbs_complex_g numeric not null,
  fat_g numeric not null,
  contains_dairy boolean not null default false,
  check (carbs_complex_g <= carbs_total_g)
);

create table meals (
  id uuid primary key default gen_random_uuid(),
  date date not null,
  meal_type text not null,
  target_kcal integer not null,
  unique (date, meal_type),
  check (target_kcal in (1100, 1300, 1500))
);

create table meal_items (
  id uuid primary key default gen_random_uuid(),
  meal_id uuid not null references meals(id) on delete cascade,
  food_id uuid not null references foods(id),
  quantity_g numeric not null
);

create table weights (
  id uuid primary key default gen_random_uuid(),
  date date not null,
  weight_kg numeric not null
);

create index on meals (date);
create index on meal_items (meal_id);
create index on weights (date);
