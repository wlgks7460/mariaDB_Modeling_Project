-- 1. 아파트 등록 
INSERT INTO Apartment(name) VALUES('자이');
INSERT INTO Apartment(name) VALUES('푸르지오');
INSERT INTO Apartment(name) VALUES('아이파크');
INSERT INTO Apartment(name) VALUES('벽산');
INSERT INTO Apartment(name) VALUES('E편한세상');

-- 2. 회원가입
-- USER
INSERT INTO Members(apartment_id, email, password, nickname, phone_number, id_card)  VALUES(1,'bellwin@naver.com', 'bellwin1234', 'bellwin', '010-1234-1234', '사진1');
INSERT INTO Members(apartment_id, email, password, nickname, phone_number, id_card)  VALUES(1,'john@naver.com', 'john1234', 'john', '010-8795-7895', '사진2');
INSERT INTO Members(apartment_id, email, password, nickname, phone_number, id_card)  VALUES(1,'keigan@naver.com', 'keigan1234', 'keigan', '010-1744-4145', '사진3');
INSERT INTO Members(apartment_id, email, password, nickname, phone_number, id_card)  VALUES(1,'natalie@naver.com', 'natalie1234', 'natalie', '010-4666-4555', '사진4');
INSERT INTO Members(apartment_id, email, password, nickname, phone_number, id_card)  VALUES(2,'catrina@naver.com',  'catrina1234', 'catrina', '010-1999-2995', '사진5');  
INSERT INTO Members(apartment_id, email, password, nickname, phone_number, id_card)  VALUES(2,'joseph@naver.com',  'joseph1234', 'joseph', '010-1111-1111', '사진6'); 
INSERT INTO Members(apartment_id, email, password, nickname, phone_number, id_card)  VALUES(2,'jack@naver.com',  'jack1234', 'jack', '010-2222-2222', '사진7'); 
INSERT INTO Members(apartment_id, email, password, nickname, phone_number, id_card)  VALUES(3,'trevor@naver.com',  'trevor1234', 'trevor', '010-3333-3333', '사진8');  
INSERT INTO Members(apartment_id, email, password, nickname, phone_number, id_card)  VALUES(3,'andrew@naver.com',  'andrew1234', 'andrew', '010-4444-4444', '사진9'); 
INSERT INTO Members(apartment_id, email, password, nickname, phone_number, id_card)  VALUES(3,'callie@naver.com',  'callie1234', 'callie', '010-5555-5555', '사진10'); 
INSERT INTO Members(apartment_id, email, password, nickname, phone_number, id_card)  VALUES(3,'grace@naver.com',  'grace1234', 'grace', '010-6666-6666', '사진11'); 
INSERT INTO Members(apartment_id, email, password, nickname, phone_number, id_card)  VALUES(4,'lauren@naver.com',  'lauren1234', 'lauren', '010-7777-7777', '사진12');  
INSERT INTO Members(apartment_id, email, password, nickname, phone_number, id_card)  VALUES(4,'eddie@naver.com',  'eddie1234', 'eddie', '010-8888-8888', '사진13'); 
INSERT INTO Members(apartment_id, email, password, nickname, phone_number, id_card)  VALUES(4,'sean@naver.com',  'sean1234', 'sean', '010-9999-9999', '사진14'); 
INSERT INTO Members(apartment_id, email, password, nickname, phone_number, id_card)  VALUES(5,'issac@naver.com',  'issac1234', 'issac', '010-1234-4567', '사진15'); 
INSERT INTO Members(apartment_id, email, password, nickname, phone_number, id_card)  VALUES(5,'james@naver.com',  'james1234', 'james', '010-2345-6789', '사진16'); 
INSERT INTO Members(apartment_id, email, password, nickname, phone_number, id_card)  VALUES(5,'sharon@naver.com',  'sharon1234', 'sharon', '010-3456-7890', '사진17'); 

--ADMIN
INSERT INTO Members(apartment_id, email, password, nickname, phone_number, id_card, role)  VALUES(1,'admin1@naver.com', 'admin11234', 'admin1', '010-1222-2114', '사진18', 'ADMIN');
INSERT INTO Members(apartment_id, email, password, nickname, phone_number, id_card, role)  VALUES(2,'admin2@naver.com', 'admin21234', 'admin2', '010-4567-8901', '사진19', 'ADMIN');
INSERT INTO Members(apartment_id, email, password, nickname, phone_number, id_card, role)  VALUES(3,'admin3@naver.com', 'admin31234', 'admin3', '010-1357-9135', '사진20', 'ADMIN');
INSERT INTO Members(apartment_id, email, password, nickname, phone_number, id_card, role)  VALUES(4,'admin4@naver.com', 'admin41234', 'admin4', '010-7913-5791', '사진21', 'ADMIN');
INSERT INTO Members(apartment_id, email, password, nickname, phone_number, id_card, role)  VALUES(5,'admin5@naver.com', 'admin51234', 'admin5', '010-7914-5792', '사진22', 'ADMIN');

-- 3. 배달해요 (채팅방 개설)
    CALL createDeliveryPost('bellwin', '자이', '치킨 드실 분 구해요', 'BHC에서 시킵니다.', '배달해요', 'BHC', '2023-12-03 18:00:00', '1동 2호', 2);
    -- 거주하지 않은 아파트에 글 작성 시도 시 에러
    CALL createDeliveryPost('john', '푸르지오', '족발 드실 분 구해요', '장충동 왕족발에서 시킵니다.', '배달해요', '장충동 왕족발', '2023-12-04 18:00:00', '2동 3호', 2);

-- 4. 공구해요 (채팅방 개설)
    CALL createGroupPurchasePost('bellwin', '자이', '공동 구매 하실 분 구해요', '저는 옷 살거에요', '공구해요', 'www.coupang.com', 3);
    -- 거주하지 않은 아파트에 글 작성 시도 시 에러
    CALL createGroupPurchasePost('john', '푸르지오', '공동 구매 하실 2분 구해요', '저는 바지 살거에요', '공구해요', 'www.naver.com', 3);


-- 5. 일반 게시글 작성 (나눔해요, 조심해요, 자유게시판 - 채팅방 개설 X)
    CALL createGeneralPost('bellwin', '자이', '아 심심해', '나랑 운동할 사람?', '자유게시판');
    CALL createGeneralPost('catrina', '푸르지오', '옷 나눔해요!', '안 입는 패딩 나눔합니당', '나눔해요');
    -- 거주하지 않은 아파트에 글 작성 시도 시 에러
    CALL createGeneralPost('natalie', '푸르지오', '밤에 그만좀 떠들어요', '시끄러워서 잠을 못자겠어요', '조심해요');

-- 6. 공지사항

    INSERT INTO Notice( member_id, title, content) VALUES( 6 ,'first notice', 'hello');
    INSERT INTO Notice( member_id, title, content) VALUES( 6 ,'second notice', 'notice ….');

-- 7. 댓글 작성, 댓글 좋아요
    INSERT INTO comment(comment_id,member_id,post_id, content) VALUES(1,1,1,'good');
    INSERT INTO Comment_Like(comment_like_id, comment_id, member_id, is_click) VALUES(1,1,2,'Y');
    UPDATE Comment SET likes_count = likes_count+1  where comment_id =1;

    INSERT INTO Comment(comment_id,member_id,post_id, parent_id, content) VALUES(2,2,1,1,'very good');
    INSERT INTO Comment_Like(comment_like_id, comment_id, member_id, is_click) VALUES(2,2,1,'Y');
    UPDATE Comment SET likes_count = likes_count+1  where comment_id =2;

-- 8. 게시글 좋아요.
    INSERT INTO PostLike(post_like_id,member_id,post_id,is_click) VALUES(1,1,1,'Y');
    UPDATE Post SET likes = likes+1  where post_id =1;

-- 9. 채팅 
    INSERT INTO Chat_Room(chat_room_id) VALUES(2);
    UPDATE Delivery_Details SET chat_room_id = '2' WHERE delivery_id =1;
    INSERT INTO Delivery_Message (delivery_details_id, content) VALUES(1, 'HI');
    INSERT INTO Delivery_Message (delivery_details_id, content) VALUES(2, 'HI');

