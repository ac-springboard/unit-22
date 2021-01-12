\c craiglist

INSERT INTO categories (name)
VALUES ('cat1'),
       ('cat 2'),
       ('cat 3')
;

INSERT INTO regions (name)
VALUES ('reg 1'),
       ('reg 2'),
       ('reg 3')
;

INSERT INTO locations (name, regions_id)
VALUES ('loc 1', 1),
       ('loc 2', 2),
       ('loc 3', 2);
;

INSERT INTO users (name)
VALUES ('user 1'),
       ('user 2'),
       ('user 3'),
       ('user 4')
;

insert into posts (title, text, locations_id, categories_id, users_id )
values
( 'title 1 1 1', 'text 1 1 1', 1, 1, 1),
( 'title 1 1 2', 'text 1 1 2', 1, 1, 2),
( 'title 1 1 3', 'text 1 1 3', 1, 1, 3),
( 'title 2 2 2', 'text 2 2 2', 2, 2, 2),
( 'title 2 1 1', 'text 2 1 1', 2, 1, 1),
( 'title 3 3 3', 'text 3 3 3', 3, 3, 3)
;
