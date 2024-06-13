DROP TABLE IF EXISTS order_details;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS sends;
DROP TABLE IF EXISTS send_type;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS items;

/**********************************/
/* テーブル名: 商品 */
/**********************************/
CREATE TABLE items(
		id          SERIAL       NOT NULL,
		name        VARCHAR(255) NOT NULL,
		price       INTEGER      NOT NULL,
		description VARCHAR(255),
		created_on  DATE         NOT NULL DEFAULT current_date,
		updated_on  DATE         NOT NULL DEFAULT current_date
);

/**********************************/
/* テーブル名: 利用者 */
/**********************************/
CREATE TABLE users(
		id          SERIAL       NOT NULL,
		name        VARCHAR(255) NOT NULL,
		email       VARCHAR(255) NOT NULL,
		password    VARCHAR(255) NOT NULL,
		signup_on   DATE         NOT NULL DEFAULT current_date,
		updated_on  DATE         NOT NULL DEFAULT current_date,
		canceled_on DATE                  DEFAULT null
);

/**********************************/
/* テーブル名: 送付先種別 */
/**********************************/
CREATE TABLE send_type(
		id   SERIAL      NOT NULL,
		name VARCHAR(10) NOT NULL
);

/**********************************/
/* テーブル名: 送付先 */
/**********************************/
CREATE TABLE sends(
		id         SERIAL       NOT NULL,
		user_id    INTEGER      NOT NULL,
		send_to    VARCHAR(255) NOT NULL,
		zipcode    CHAR(8)      NOT NULL,
		prefecture INTEGER,
		address    VARCHAR(255) NOT NULL,
		phone      CHAR(14)     NOT NULL,
		type       INTEGER      NOT NULL,
		created_on DATE         NOT NULL DEFAULT current_date,
		updated_on DATE         NOT NULL DEFAULT current_date
);

/**********************************/
/* テーブル名: 注文 */
/**********************************/
CREATE TABLE orders(
		id           SERIAL    NOT NULL,
		order_number INTEGER   NOT NULL,
		user_id      INTEGER   NOT NULL,
		total_price  INTEGER   NOT NULL,
		ordered_on   TIMESTAMP NOT NULL DEFAULT current_timestamp
);

/**********************************/
/* テーブル名: 注文明細 */
/**********************************/
CREATE TABLE order_details(
		id           SERIAL  NOT NULL,
		order_number INTEGER NOT NULL,
		item_id      INTEGER NOT NULL,
		quantity     INTEGER NOT NULL,
		description  VARCHAR(255)
);


ALTER TABLE items ADD CONSTRAINT IDX_items_PK PRIMARY KEY (id);

ALTER TABLE users ADD CONSTRAINT IDX_users_PK PRIMARY KEY (id);

ALTER TABLE send_type ADD CONSTRAINT IDX_send_type_PK PRIMARY KEY (id);

ALTER TABLE sends ADD CONSTRAINT IDX_sends_PK PRIMARY KEY (id);
ALTER TABLE sends ADD CONSTRAINT IDX_sends_FK FOREIGN KEY (id) REFERENCES users (id);

ALTER TABLE orders ADD CONSTRAINT IDX_orders_PK PRIMARY KEY (id);
ALTER TABLE orders ADD CONSTRAINT IDX_orders_FK FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE orders ADD CONSTRAINT IDX_orders_UQ UNIQUE (order_number);

ALTER TABLE order_details ADD CONSTRAINT IDX_order_details_PK PRIMARY KEY (id);
ALTER TABLE order_details ADD CONSTRAINT IDX_order_details_FK0 FOREIGN KEY (id) REFERENCES orders (id);
ALTER TABLE order_details ADD CONSTRAINT IDX_order_details_FK1 FOREIGN KEY (item_id) REFERENCES items (id);
CREATE INDEX IDX_order_details_order_FK ON order_details (order_number);
CREATE INDEX IDX_order_details_item_FK ON order_details (item_id);

