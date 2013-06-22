
/* Drop Views */

DROP VIEW RECIPE_MATERIAL_QUANTITIES;



/* Drop Triggers */

DROP TRIGGER TRI_COOK_LOGS_COOK_LOG_ID;
DROP TRIGGER TRI_MEAL_NUT_AMOUNTS_MEAL_ID;
DROP TRIGGER TRI_NUTRIENTS_NUTRIENT_ID;
DROP TRIGGER TRI_RECIPES_RECIPE_ID;
DROP TRIGGER TRI_USERS_USER_ID;
DROP TRIGGER TRI_WEEKLY_NUT_AMOUNTS_WEEK_ID;



/* Drop Tables */

DROP TABLE COOK_LOGS;
DROP TABLE FAVORITE_RECIPES;
DROP TABLE RECIPE_MATERIALS;
DROP TABLE MATERIALS;
DROP TABLE MEAL_NUT_AMOUNTS;
DROP TABLE NUTRIENTS;
DROP TABLE RECIPE_NUT_AMOUNTS;
DROP TABLE STEPS;
DROP TABLE RECIPES;
DROP TABLE USER_STATS;
DROP TABLE WEEKLY_NUT_AMOUNTS;
DROP TABLE USERS;



/* Drop Sequences */

DROP SEQUENCE SEQ_COOK_LOGS_COOK_LOG_ID;
DROP SEQUENCE SEQ_MEAL_NUT_AMOUNTS_MEAL_ID;
DROP SEQUENCE SEQ_NUTRIENTS_NUTRIENT_ID;
DROP SEQUENCE SEQ_RECIPES_RECIPE_ID;
DROP SEQUENCE SEQ_USERS_USER_ID;
DROP SEQUENCE SEQ_WEEKLY_NUT_AMOUNTS_WEEK_ID;




/* Create Sequences */

CREATE SEQUENCE SEQ_COOK_LOGS_COOK_LOG_ID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_MEAL_NUT_AMOUNTS_MEAL_ID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_NUTRIENTS_NUTRIENT_ID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_RECIPES_RECIPE_ID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_USERS_USER_ID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_WEEKLY_NUT_AMOUNTS_WEEK_ID INCREMENT BY 1 START WITH 1;



/* Create Tables */

CREATE TABLE COOK_LOGS
(
	COOK_LOG_ID NUMBER(10) NOT NULL,
	USER_ID NUMBER(10) NOT NULL,
	RECIPE_ID NUMBER(10) NOT NULL,
	COOKED_AT DATE DEFAULT SYSDATE,
	PRIMARY KEY (COOK_LOG_ID)
);


CREATE TABLE FAVORITE_RECIPES
(
	USER_ID NUMBER(10) NOT NULL,
	RECIPE_ID NUMBER(10) NOT NULL,
	CREATED_AT DATE DEFAULT SYSDATE,
	PRIMARY KEY (USER_ID, RECIPE_ID)
);


CREATE TABLE MATERIALS
(
	MATERIAL_NAME NVARCHAR2(32) DEFAULT '' NOT NULL,
	GRAM_PER_QUANTITY NUMBER(5) NOT NULL,
	PREFIX NVARCHAR2(8) DEFAULT '' NOT NULL,
	POSTFIX NVARCHAR2(8) DEFAULT '' NOT NULL,
	NUTRIENT_ID NUMBER(10) NOT NULL,
	PRIMARY KEY (MATERIAL_NAME, PREFIX, POSTFIX)
);


CREATE TABLE MEAL_NUT_AMOUNTS
(
	MEAL_ID NUMBER(10) NOT NULL,
	USER_ID NUMBER(10) NOT NULL,
	RECIPE_ID NUMBER(10) NOT NULL,
	MEAL_AT DATE DEFAULT SYSDATE,
	TOTAL_BALANCE NUMBER(3,1) NOT NULL,
	MILK NUMBER(4) NOT NULL,
	EGG NUMBER(4) NOT NULL,
	MEAT NUMBER(4) NOT NULL,
	BEAN NUMBER(4) NOT NULL,
	VEGETABLE NUMBER(4) NOT NULL,
	POTATO NUMBER(4) NOT NULL,
	FRUIT NUMBER(4) NOT NULL,
	MINERAL NUMBER(4) NOT NULL,
	CROP NUMBER(4) NOT NULL,
	FAT NUMBER(4) NOT NULL,
	SUGUAR NUMBER(4) NOT NULL,
	UPDATED_AT DATE DEFAULT SYSDATE,
	PRIMARY KEY (MEAL_ID)
);


CREATE TABLE NUTRIENTS
(
	NUTRIENT_ID NUMBER(10) NOT NULL,
	NUTRIENT_NAME NVARCHAR2(16) NOT NULL,
	NUTRIENT_COLOR NVARCHAR2(128) NOT NULL,
	DAILY_REQUIRED_AMOUNT NUMBER(4) NOT NULL,
	PRIMARY KEY (NUTRIENT_ID)
);


CREATE TABLE RECIPES
(
	RECIPE_ID NUMBER(10) NOT NULL,
	RECIPE_NAME NVARCHAR2(64) NOT NULL,
	DESCRIPTION NVARCHAR2(512),
	IMAGE_URL VARCHAR2(512),
	ESTIMATED_TIME NUMBER(3) NOT NULL,
	IS_DELETED NUMBER(1) DEFAULT 0 NOT NULL,
	PRIMARY KEY (RECIPE_ID)
);


CREATE TABLE RECIPE_MATERIALS
(
	RECIPE_ID NUMBER(10) NOT NULL,
	MATERIAL_NAME NVARCHAR2(32) NOT NULL,
	PREFIX NVARCHAR2(8) NOT NULL,
	POSTFIX NVARCHAR2(8) NOT NULL,
	QUANTITY NUMBER(5,1) NOT NULL
);


CREATE TABLE RECIPE_NUT_AMOUNTS
(
	RECIPE_ID NUMBER(10) NOT NULL,
	TOTAL_BALANCE NUMBER(3,1) NOT NULL,
	MILK NUMBER(4) NOT NULL,
	EGG NUMBER(4) NOT NULL,
	MEAT NUMBER(4) NOT NULL,
	BEAN NUMBER(4) NOT NULL,
	VEGETABLE NUMBER(4) NOT NULL,
	POTATO NUMBER(4) NOT NULL,
	FRUIT NUMBER(4) NOT NULL,
	MINERAL NUMBER(4) NOT NULL,
	CROP NUMBER(4) NOT NULL,
	FAT NUMBER(4) NOT NULL,
	SUGUAR NUMBER(4) NOT NULL
);


CREATE TABLE STEPS
(
	RECIPE_ID NUMBER(10) NOT NULL,
	STEP NUMBER(2) DEFAULT 1 NOT NULL,
	DESCRIPTION NVARCHAR2(512) NOT NULL,
	PRIMARY KEY (RECIPE_ID, STEP)
);


CREATE TABLE USERS
(
	USER_ID NUMBER(10) NOT NULL,
	USER_NAME NVARCHAR2(32) NOT NULL,
	EMAIL VARCHAR2(128) NOT NULL UNIQUE,
	AUTH_TOKEN VARCHAR2(150) NOT NULL UNIQUE,
	EMAIL_TOKEN VARCHAR2(16) NOT NULL UNIQUE,
	MALE NUMBER(1) DEFAULT 0 NOT NULL,
	HEIGHT NUMBER(3),
	WEIGHT NUMBER(3),
	AGE NUMBER(3,0),
	CREATED_AT DATE DEFAULT SYSDATE,
	DELETED_AT DATE,
	IS_DELETED NUMBER(1) DEFAULT 0 NOT NULL,
	IS_CONFIRMED NUMBER(1) DEFAULT 0 NOT NULL,
	IS_AVAILABLE NUMBER(1) DEFAULT 0 NOT NULL,
	PRIMARY KEY (USER_ID)
);


CREATE TABLE USER_STATS
(
	USER_ID NUMBER(10) NOT NULL,
	NUTRIENTS_BALANCE NUMBER(3,1) DEFAULT 0 NOT NULL,
	TOTAL_COOKED NUMBER(5) DEFAULT 0 NOT NULL,
	CONSECUTIVELY_COOKED NUMBER(5) DEFAULT 0 NOT NULL,
	MAX_CONSECUTIVELY_COOKED NUMBER(5) DEFAULT 0 NOT NULL,
	UPDATED_AT DATE DEFAULT SYSDATE,
	PRIMARY KEY (USER_ID)
);


CREATE TABLE WEEKLY_NUT_AMOUNTS
(
	WEEK_ID NUMBER(10) NOT NULL,
	USER_ID NUMBER(10) NOT NULL,
	FIRST_DATE DATE DEFAULT SYSDATE,
	TOTAL_BALANCE NUMBER(3,1) NOT NULL,
	MILK NUMBER(4) NOT NULL,
	EGG NUMBER(4) NOT NULL,
	MEAT NUMBER(4) NOT NULL,
	BEAN NUMBER(4) NOT NULL,
	VEGETABLE NUMBER(4) NOT NULL,
	POTATO NUMBER(4) NOT NULL,
	FRUIT NUMBER(4) NOT NULL,
	MINERAL NUMBER(4) NOT NULL,
	CROP NUMBER(4) NOT NULL,
	FAT NUMBER(4) NOT NULL,
	SUGUAR NUMBER(4) NOT NULL,
	UPDATED_AT DATE DEFAULT SYSDATE,
	PRIMARY KEY (WEEK_ID)
);



/* Create Foreign Keys */

ALTER TABLE RECIPE_MATERIALS
	ADD FOREIGN KEY (MATERIAL_NAME, PREFIX, POSTFIX)
	REFERENCES MATERIALS (MATERIAL_NAME, PREFIX, POSTFIX)
;


ALTER TABLE MATERIALS
	ADD FOREIGN KEY (NUTRIENT_ID)
	REFERENCES NUTRIENTS (NUTRIENT_ID)
;


ALTER TABLE COOK_LOGS
	ADD FOREIGN KEY (RECIPE_ID)
	REFERENCES RECIPES (RECIPE_ID)
;


ALTER TABLE FAVORITE_RECIPES
	ADD FOREIGN KEY (RECIPE_ID)
	REFERENCES RECIPES (RECIPE_ID)
;


ALTER TABLE MEAL_NUT_AMOUNTS
	ADD FOREIGN KEY (RECIPE_ID)
	REFERENCES RECIPES (RECIPE_ID)
;


ALTER TABLE RECIPE_MATERIALS
	ADD FOREIGN KEY (RECIPE_ID)
	REFERENCES RECIPES (RECIPE_ID)
;


ALTER TABLE RECIPE_NUT_AMOUNTS
	ADD FOREIGN KEY (RECIPE_ID)
	REFERENCES RECIPES (RECIPE_ID)
;


ALTER TABLE STEPS
	ADD FOREIGN KEY (RECIPE_ID)
	REFERENCES RECIPES (RECIPE_ID)
;


ALTER TABLE COOK_LOGS
	ADD FOREIGN KEY (USER_ID)
	REFERENCES USERS (USER_ID)
;


ALTER TABLE FAVORITE_RECIPES
	ADD FOREIGN KEY (USER_ID)
	REFERENCES USERS (USER_ID)
;


ALTER TABLE MEAL_NUT_AMOUNTS
	ADD FOREIGN KEY (USER_ID)
	REFERENCES USERS (USER_ID)
;


ALTER TABLE USER_STATS
	ADD FOREIGN KEY (USER_ID)
	REFERENCES USERS (USER_ID)
;


ALTER TABLE WEEKLY_NUT_AMOUNTS
	ADD FOREIGN KEY (USER_ID)
	REFERENCES USERS (USER_ID)
;



/* Create Triggers */

CREATE TRIGGER TRI_COOK_LOGS_COOK_LOG_ID BEFORE INSERT ON COOK_LOGS
FOR EACH ROW
BEGIN
	SELECT SEQ_COOK_LOGS_COOK_LOG_ID.NEXTVAL
	INTO :NEW.COOK_LOG_ID
	FROM DUAL;
END;
/
CREATE TRIGGER TRI_MEAL_NUT_AMOUNTS_MEAL_ID BEFORE INSERT ON MEAL_NUT_AMOUNTS
FOR EACH ROW
BEGIN
	SELECT SEQ_MEAL_NUT_AMOUNTS_MEAL_ID.NEXTVAL
	INTO :NEW.MEAL_ID
	FROM DUAL;
END;
/
CREATE TRIGGER TRI_NUTRIENTS_NUTRIENT_ID BEFORE INSERT ON NUTRIENTS
FOR EACH ROW
BEGIN
	SELECT SEQ_NUTRIENTS_NUTRIENT_ID.NEXTVAL
	INTO :NEW.NUTRIENT_ID
	FROM DUAL;
END;
/
CREATE TRIGGER TRI_RECIPES_RECIPE_ID BEFORE INSERT ON RECIPES
FOR EACH ROW
BEGIN
	SELECT SEQ_RECIPES_RECIPE_ID.NEXTVAL
	INTO :NEW.RECIPE_ID
	FROM DUAL;
END;
/
CREATE TRIGGER TRI_USERS_USER_ID BEFORE INSERT ON USERS
FOR EACH ROW
BEGIN
	SELECT SEQ_USERS_USER_ID.NEXTVAL
	INTO :NEW.USER_ID
	FROM DUAL;
END;
/
CREATE TRIGGER TRI_WEEKLY_NUT_AMOUNTS_WEEK_ID BEFORE INSERT ON WEEKLY_NUT_AMOUNTS
FOR EACH ROW
BEGIN
	SELECT SEQ_WEEKLY_NUT_AMOUNTS_WEEK_ID.NEXTVAL
	INTO :NEW.WEEK_ID
	FROM DUAL;
END;
/


/* Create Views */

CREATE VIEW RECIPE_MATERIAL_QUANTITIES AS SELECT R.RECIPE_ID AS RECIPE_ID, R.QUANTITY AS QUANTITY, M.MATERIAL_NAME AS MATERIAL_NAME, M.GRAM_PER_QUANTITY AS GRAM_PER_QUANTITY, M.PREFIX AS PREFIX, M.POSTFIX AS POSTFIX, M.NUTRIENT_ID AS NUTRIENT_ID  FROM RECIPE_MATERIALS R INNER JOIN MATERIALS M ON (R.MATERIAL_NAME = M.MATERIAL_NAME AND R.PREFIX = M.PREFIX AND R.POSTFIX = M.POSTFIX);



/* Comments */

COMMENT ON TABLE COOK_LOGS IS '料理ログテーブル';
COMMENT ON COLUMN COOK_LOGS.COOK_LOG_ID IS '調理ログID';
COMMENT ON COLUMN COOK_LOGS.USER_ID IS 'ユーザーID';
COMMENT ON COLUMN COOK_LOGS.RECIPE_ID IS 'レシピID';
COMMENT ON COLUMN COOK_LOGS.COOKED_AT IS '調理時刻';
COMMENT ON TABLE FAVORITE_RECIPES IS 'お気に入りレシピテーブル';
COMMENT ON COLUMN FAVORITE_RECIPES.USER_ID IS 'ユーザーID';
COMMENT ON COLUMN FAVORITE_RECIPES.RECIPE_ID IS 'レシピID';
COMMENT ON COLUMN FAVORITE_RECIPES.CREATED_AT IS '追加時刻';
COMMENT ON TABLE MATERIALS IS '素材テーブル';
COMMENT ON COLUMN MATERIALS.MATERIAL_NAME IS '素材名';
COMMENT ON COLUMN MATERIALS.GRAM_PER_QUANTITY IS '単位あたりグラム数';
COMMENT ON COLUMN MATERIALS.PREFIX IS '接頭辞';
COMMENT ON COLUMN MATERIALS.POSTFIX IS '接尾辞';
COMMENT ON COLUMN MATERIALS.NUTRIENT_ID IS '栄養素ID';
COMMENT ON TABLE MEAL_NUT_AMOUNTS IS '食事別栄養素履歴テーブル';
COMMENT ON COLUMN MEAL_NUT_AMOUNTS.MEAL_ID IS '食事毎摂取栄養素テーブル';
COMMENT ON COLUMN MEAL_NUT_AMOUNTS.USER_ID IS 'ユーザーID';
COMMENT ON COLUMN MEAL_NUT_AMOUNTS.RECIPE_ID IS 'レシピID';
COMMENT ON COLUMN MEAL_NUT_AMOUNTS.MEAL_AT IS '食事時刻';
COMMENT ON COLUMN MEAL_NUT_AMOUNTS.TOTAL_BALANCE IS 'total_balance';
COMMENT ON COLUMN MEAL_NUT_AMOUNTS.MILK IS '乳製品総量';
COMMENT ON COLUMN MEAL_NUT_AMOUNTS.EGG IS '卵総量';
COMMENT ON COLUMN MEAL_NUT_AMOUNTS.MEAT IS '魚・肉類総量';
COMMENT ON COLUMN MEAL_NUT_AMOUNTS.BEAN IS '豆類総量';
COMMENT ON COLUMN MEAL_NUT_AMOUNTS.VEGETABLE IS '野菜総量';
COMMENT ON COLUMN MEAL_NUT_AMOUNTS.POTATO IS 'イモ類総量';
COMMENT ON COLUMN MEAL_NUT_AMOUNTS.FRUIT IS '果物総量';
COMMENT ON COLUMN MEAL_NUT_AMOUNTS.MINERAL IS '海藻・きのこ類総量';
COMMENT ON COLUMN MEAL_NUT_AMOUNTS.CROP IS '穀物総量';
COMMENT ON COLUMN MEAL_NUT_AMOUNTS.FAT IS '油脂総量';
COMMENT ON COLUMN MEAL_NUT_AMOUNTS.SUGUAR IS '砂糖総量';
COMMENT ON COLUMN MEAL_NUT_AMOUNTS.UPDATED_AT IS '最終変更日時';
COMMENT ON TABLE NUTRIENTS IS '栄養素テーブル';
COMMENT ON COLUMN NUTRIENTS.NUTRIENT_ID IS '栄養素ID';
COMMENT ON COLUMN NUTRIENTS.NUTRIENT_NAME IS '栄養素種別';
COMMENT ON COLUMN NUTRIENTS.NUTRIENT_COLOR IS '三色食品群種別';
COMMENT ON COLUMN NUTRIENTS.DAILY_REQUIRED_AMOUNT IS '摂取目安量';
COMMENT ON TABLE RECIPES IS 'レシピテーブル';
COMMENT ON COLUMN RECIPES.RECIPE_ID IS 'レシピID';
COMMENT ON COLUMN RECIPES.RECIPE_NAME IS 'レシピ名';
COMMENT ON COLUMN RECIPES.DESCRIPTION IS 'コメント';
COMMENT ON COLUMN RECIPES.IMAGE_URL IS 'image_url';
COMMENT ON COLUMN RECIPES.ESTIMATED_TIME IS '調理時間目安';
COMMENT ON COLUMN RECIPES.IS_DELETED IS '削除フラグ';
COMMENT ON TABLE RECIPE_MATERIALS IS 'レシピ素材テーブル';
COMMENT ON COLUMN RECIPE_MATERIALS.RECIPE_ID IS 'レシピID';
COMMENT ON COLUMN RECIPE_MATERIALS.MATERIAL_NAME IS '素材名';
COMMENT ON COLUMN RECIPE_MATERIALS.PREFIX IS '接頭辞';
COMMENT ON COLUMN RECIPE_MATERIALS.POSTFIX IS '接尾辞';
COMMENT ON COLUMN RECIPE_MATERIALS.QUANTITY IS '量';
COMMENT ON TABLE RECIPE_NUT_AMOUNTS IS 'レシピ構成栄養素';
COMMENT ON COLUMN RECIPE_NUT_AMOUNTS.RECIPE_ID IS 'レシピID';
COMMENT ON COLUMN RECIPE_NUT_AMOUNTS.TOTAL_BALANCE IS 'total_balance';
COMMENT ON COLUMN RECIPE_NUT_AMOUNTS.MILK IS '乳製品総量';
COMMENT ON COLUMN RECIPE_NUT_AMOUNTS.EGG IS '卵総量';
COMMENT ON COLUMN RECIPE_NUT_AMOUNTS.MEAT IS '魚・肉類総量';
COMMENT ON COLUMN RECIPE_NUT_AMOUNTS.BEAN IS '豆類総量';
COMMENT ON COLUMN RECIPE_NUT_AMOUNTS.VEGETABLE IS '野菜総量';
COMMENT ON COLUMN RECIPE_NUT_AMOUNTS.POTATO IS 'イモ類総量';
COMMENT ON COLUMN RECIPE_NUT_AMOUNTS.FRUIT IS '果物総量';
COMMENT ON COLUMN RECIPE_NUT_AMOUNTS.MINERAL IS '海藻・きのこ類総量';
COMMENT ON COLUMN RECIPE_NUT_AMOUNTS.CROP IS '穀物総量';
COMMENT ON COLUMN RECIPE_NUT_AMOUNTS.FAT IS '油脂総量';
COMMENT ON COLUMN RECIPE_NUT_AMOUNTS.SUGUAR IS '砂糖総量';
COMMENT ON TABLE STEPS IS '調理手順テーブル';
COMMENT ON COLUMN STEPS.RECIPE_ID IS 'レシピID';
COMMENT ON COLUMN STEPS.STEP IS '手順番号';
COMMENT ON COLUMN STEPS.DESCRIPTION IS '内容';
COMMENT ON TABLE USERS IS 'ユーザーテーブル';
COMMENT ON COLUMN USERS.USER_ID IS 'ユーザーID';
COMMENT ON COLUMN USERS.USER_NAME IS 'user_name';
COMMENT ON COLUMN USERS.EMAIL IS 'メールアドレス';
COMMENT ON COLUMN USERS.AUTH_TOKEN IS '認証トークン';
COMMENT ON COLUMN USERS.EMAIL_TOKEN IS 'メールアドレス認証トークン';
COMMENT ON COLUMN USERS.MALE IS '性別';
COMMENT ON COLUMN USERS.HEIGHT IS '身長';
COMMENT ON COLUMN USERS.WEIGHT IS '体重';
COMMENT ON COLUMN USERS.AGE IS '年齢';
COMMENT ON COLUMN USERS.CREATED_AT IS '登録日時';
COMMENT ON COLUMN USERS.DELETED_AT IS '削除日時';
COMMENT ON COLUMN USERS.IS_DELETED IS '削除フラグ';
COMMENT ON COLUMN USERS.IS_CONFIRMED IS 'メールアドレス確認可否';
COMMENT ON COLUMN USERS.IS_AVAILABLE IS '有効アカウント';
COMMENT ON TABLE USER_STATS IS 'ユーザー統計情報';
COMMENT ON COLUMN USER_STATS.USER_ID IS 'ユーザーID';
COMMENT ON COLUMN USER_STATS.NUTRIENTS_BALANCE IS '栄養バランス達成度';
COMMENT ON COLUMN USER_STATS.TOTAL_COOKED IS '自炊合計回数';
COMMENT ON COLUMN USER_STATS.CONSECUTIVELY_COOKED IS '連続自炊日数';
COMMENT ON COLUMN USER_STATS.MAX_CONSECUTIVELY_COOKED IS '最長連続自炊日数';
COMMENT ON COLUMN USER_STATS.UPDATED_AT IS '最終更新時刻';
COMMENT ON TABLE WEEKLY_NUT_AMOUNTS IS '栄養素別合計テーブル';
COMMENT ON COLUMN WEEKLY_NUT_AMOUNTS.WEEK_ID IS '週間摂取栄養素ID';
COMMENT ON COLUMN WEEKLY_NUT_AMOUNTS.USER_ID IS 'ユーザーID';
COMMENT ON COLUMN WEEKLY_NUT_AMOUNTS.FIRST_DATE IS '開始日';
COMMENT ON COLUMN WEEKLY_NUT_AMOUNTS.TOTAL_BALANCE IS '栄養バランス';
COMMENT ON COLUMN WEEKLY_NUT_AMOUNTS.MILK IS '乳製品総量';
COMMENT ON COLUMN WEEKLY_NUT_AMOUNTS.EGG IS '卵総量';
COMMENT ON COLUMN WEEKLY_NUT_AMOUNTS.MEAT IS '魚・肉類総量';
COMMENT ON COLUMN WEEKLY_NUT_AMOUNTS.BEAN IS '大豆製品総量';
COMMENT ON COLUMN WEEKLY_NUT_AMOUNTS.VEGETABLE IS '野菜総量';
COMMENT ON COLUMN WEEKLY_NUT_AMOUNTS.POTATO IS 'イモ類総量';
COMMENT ON COLUMN WEEKLY_NUT_AMOUNTS.FRUIT IS '果物総量';
COMMENT ON COLUMN WEEKLY_NUT_AMOUNTS.MINERAL IS '海藻・きのこ類総量';
COMMENT ON COLUMN WEEKLY_NUT_AMOUNTS.CROP IS '穀物総量';
COMMENT ON COLUMN WEEKLY_NUT_AMOUNTS.FAT IS '油脂総量';
COMMENT ON COLUMN WEEKLY_NUT_AMOUNTS.SUGUAR IS '砂糖総量';
COMMENT ON COLUMN WEEKLY_NUT_AMOUNTS.UPDATED_AT IS '最終変更日時';



