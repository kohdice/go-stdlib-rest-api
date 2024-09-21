CREATE DATABASE main_db
WITH ENCODING 'UTF8';

\c main_db

-- Table: pokemon_mst (外部キーで参照されるテーブルを先に作成)
DROP TABLE IF EXISTS pokemon_mst;
CREATE TABLE pokemon_mst (
    id SERIAL PRIMARY KEY,
    national_pokedex_number INT NOT NULL,
    pokemon_name VARCHAR(12) NOT NULL,
    is_legendary BOOLEAN NOT NULL,
    is_mythical BOOLEAN NOT NULL,
    created_by VARCHAR(36) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(36) NOT NULL,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- コメントの追加
COMMENT ON COLUMN pokemon_mst.national_pokedex_number IS 'National Pokédex Number';
COMMENT ON COLUMN pokemon_mst.pokemon_name IS 'Name';
COMMENT ON COLUMN pokemon_mst.is_legendary IS 'Legendary or Not';
COMMENT ON COLUMN pokemon_mst.is_mythical IS 'Mythical or Not';
COMMENT ON COLUMN pokemon_mst.created_by IS 'Creator';
COMMENT ON COLUMN pokemon_mst.created_at IS 'Creation DateTime';
COMMENT ON COLUMN pokemon_mst.updated_by IS 'Updater';
COMMENT ON COLUMN pokemon_mst.updated_at IS 'Update DateTime';

-- Table: type_mst (外部キーで参照されるテーブル)
DROP TABLE IF EXISTS type_mst;
CREATE TABLE type_mst (
    id SERIAL PRIMARY KEY,
    type_name VARCHAR(12) NOT NULL,
    created_by VARCHAR(36) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(36) NOT NULL,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- コメントの追加
COMMENT ON COLUMN type_mst.type_name IS 'Type';
COMMENT ON COLUMN type_mst.created_by IS 'Creator';
COMMENT ON COLUMN type_mst.created_at IS 'Creation DateTime';
COMMENT ON COLUMN type_mst.updated_by IS 'Updater';
COMMENT ON COLUMN type_mst.updated_at IS 'Update DateTime';

-- Table: ability_mst
DROP TABLE IF EXISTS ability_mst;
CREATE TABLE ability_mst (
    id SERIAL PRIMARY KEY,
    ability_name VARCHAR(12) NOT NULL,
    created_by VARCHAR(36) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(36) NOT NULL,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- コメントの追加
COMMENT ON COLUMN ability_mst.ability_name IS 'Ability';
COMMENT ON COLUMN ability_mst.created_by IS 'Creator';
COMMENT ON COLUMN ability_mst.created_at IS 'Creation DateTime';
COMMENT ON COLUMN ability_mst.updated_by IS 'Updater';
COMMENT ON COLUMN ability_mst.updated_at IS 'Update DateTime';

-- Table: pokemon_abilities (外部キーが先に作成されたテーブルを参照)
DROP TABLE IF EXISTS pokemon_abilities;
CREATE TABLE pokemon_abilities (
    pokemon_id INT NOT NULL,
    ability_id INT NOT NULL,
    slot SMALLINT NOT NULL,
    is_hidden BOOLEAN NOT NULL,
    created_by VARCHAR(36) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(36) NOT NULL,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (pokemon_id, ability_id),
    CONSTRAINT pokemon_abilities_FK_1 FOREIGN KEY (ability_id) REFERENCES ability_mst (id) ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT pokemon_abilities_FK_2 FOREIGN KEY (pokemon_id) REFERENCES pokemon_mst (id) ON UPDATE NO ACTION ON DELETE NO ACTION
);

-- コメントの追加
COMMENT ON COLUMN pokemon_abilities.pokemon_id IS 'Pokemon ID';
COMMENT ON COLUMN pokemon_abilities.ability_id IS 'Ability ID';
COMMENT ON COLUMN pokemon_abilities.slot IS 'Slot of Ability';
COMMENT ON COLUMN pokemon_abilities.is_hidden IS 'Hidden Ability or Not';
COMMENT ON COLUMN pokemon_abilities.created_by IS 'Creator';
COMMENT ON COLUMN pokemon_abilities.created_at IS 'Creation DateTime';
COMMENT ON COLUMN pokemon_abilities.updated_by IS 'Updater';
COMMENT ON COLUMN pokemon_abilities.updated_at IS 'Update DateTime';

CREATE INDEX pokemon_abilities_FK_1_idx ON pokemon_abilities (ability_id);

-- Table: pokemon_status (外部キーが先に作成されたテーブルを参照)
DROP TABLE IF EXISTS pokemon_status;
CREATE TABLE pokemon_status (
    id SERIAL PRIMARY KEY,
    pokemon_id INT NOT NULL,
    hp SMALLINT NOT NULL,
    attack SMALLINT NOT NULL,
    defense SMALLINT NOT NULL,
    special_attack SMALLINT NOT NULL,
    special_defense SMALLINT NOT NULL,
    speed SMALLINT NOT NULL,
    base_total SMALLINT NOT NULL,
    created_by VARCHAR(36) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(36) NOT NULL,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pokemon_status_FK_1 FOREIGN KEY (pokemon_id) REFERENCES pokemon_mst (id) ON UPDATE NO ACTION ON DELETE NO ACTION
);

-- コメントの追加
COMMENT ON COLUMN pokemon_status.pokemon_id IS 'Pokemon ID';
COMMENT ON COLUMN pokemon_status.hp IS 'HP';
COMMENT ON COLUMN pokemon_status.attack IS 'Attack';
COMMENT ON COLUMN pokemon_status.defense IS 'Defense';
COMMENT ON COLUMN pokemon_status.special_attack IS 'Special Attack';
COMMENT ON COLUMN pokemon_status.special_defense IS 'Special Defense';
COMMENT ON COLUMN pokemon_status.speed IS 'Speed';
COMMENT ON COLUMN pokemon_status.base_total IS 'Base Total';
COMMENT ON COLUMN pokemon_status.created_by IS 'Creator';
COMMENT ON COLUMN pokemon_status.created_at IS 'Creation DateTime';
COMMENT ON COLUMN pokemon_status.updated_by IS 'Updater';
COMMENT ON COLUMN pokemon_status.updated_at IS 'Update DateTime';

CREATE INDEX pokemon_status_FK_1_idx ON pokemon_status (pokemon_id);

-- Table: pokemon_types (外部キーが先に作成されたテーブルを参照)
DROP TABLE IF EXISTS pokemon_types;
CREATE TABLE pokemon_types (
    pokemon_id INT NOT NULL,
    type_id INT NOT NULL,
    slot SMALLINT NOT NULL,
    created_by VARCHAR(36) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(36) NOT NULL,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (pokemon_id, type_id),
    CONSTRAINT pokemon_types_FK_1 FOREIGN KEY (pokemon_id) REFERENCES pokemon_mst (id) ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT pokemon_types_FK_2 FOREIGN KEY (type_id) REFERENCES type_mst (id) ON UPDATE NO ACTION ON DELETE NO ACTION
);

-- コメントの追加
COMMENT ON COLUMN pokemon_types.pokemon_id IS 'Pokemon ID';
COMMENT ON COLUMN pokemon_types.type_id IS 'Type ID';
COMMENT ON COLUMN pokemon_types.slot IS 'Slot of Type';
COMMENT ON COLUMN pokemon_types.created_by IS 'Creator';
COMMENT ON COLUMN pokemon_types.created_at IS 'Creation DateTime';
COMMENT ON COLUMN pokemon_types.updated_by IS 'Updater';
COMMENT ON COLUMN pokemon_types.updated_at IS 'Update DateTime';

CREATE INDEX pokemon_types_FK_1_idx ON pokemon_types (type_id);
