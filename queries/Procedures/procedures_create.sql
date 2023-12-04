-- 1. 배달해요 게시글 작성
-- post -> delivery -> delivery_details 순으로 데이터 자동 입력
DROP PROCEDURE IF EXISTS createDeliveryPost;
DELIMITER //
CREATE PROCEDURE createDeliveryPost(IN member_nickname VARCHAR(20), apartment_name VARCHAR(20), title VARCHAR(50), 
content VARCHAR(3000), category VARCHAR(20), store VARCHAR(30), 
delivery_date DATETIME, delivery_place VARCHAR(30), max_participants INT)
BEGIN
	DECLARE post_id_param BIGINT;
    DECLARE	delivery_id_param BIGINT;
    DECLARE member_id_param BIGINT;
    DECLARE apartment_id_param BIGINT;
    DECLARE member_apartment_id_param BIGINT;

    -- 글쓴이 닉네임으로 member_id 찾아서 member_id_param에 저장
    SELECT member_id INTO member_id_param
    FROM members WHERE nickname = member_nickname;

    -- 아파트 이름으로 apartment_id 찾아서 apartment_id_param에 저장
    SELECT apartment_id INTO apartment_id_param
    FROM apartment WHERE name = apartment_name;

    -- 닉네임으로 글쓴이가 거주하는 apartment_id 찾아서 member_apartment_id_param에 저장
    SELECT apartment_id INTO member_apartment_id_param
    FROM members WHERE nickname = member_nickname;

    -- 글쓴이의 아파트ID와 게시판의 아파트ID가 같으면 게시글 작성
    IF apartment_id_param = member_apartment_id_param THEN
        -- 게시글 작성 (카테고리 선택)
	    INSERT INTO post(member_id, apartment_id, title, content, category) VALUES(member_id_param, apartment_id_param, title, content, category);
        
        -- 가장 최근에 성공한 INSERT문의 PK를 가져옴
        SET post_id_param = LAST_INSERT_ID(); 
        
        -- 배달해요 테이블에 데이터 입력 
        INSERT INTO delivery(post_id, store, delivery_date, delivery_place, max_participants) VALUES(post_id_param, store, delivery_date, delivery_place, max_participants);
        SET delivery_id_param = LAST_INSERT_ID();
        
        -- 배달해요 상세 테이블에 데이터 입력
        INSERT INTO delivery_details(delivery_id, member_id) VALUES(delivery_id_param, member_id_param);
    ELSE SELECT '동일 아파트 게시판에만 글 작성이 가능합니다.' AS ERROR;
    END IF;
END //
DELIMITER //;

CALL createDeliveryPost('bellwin', '자이', '치킨 드실 분 구해요', 'BHC에서 시킵니다.', '배달해요', 'BHC', '2023-12-03 18:00:00', '1동 2호', 2);
-- 거주하지 않은 아파트에 글 작성 시도 시 에러
CALL createDeliveryPost('john', '푸르지오', '족발 드실 분 구해요', '장충동 왕족발에서 시킵니다.', '배달해요', '장충동 왕족발', '2023-12-04 18:00:00', '2동 3호', 2);

-- 2. 공구해요 게시글 작성
-- post -> group_purchase -> group_purchase_details 순으로 데이터 자동 입력
DROP PROCEDURE IF EXISTS createGroupPurchasePost;
DELIMITER //
CREATE PROCEDURE createGroupPurchasePost(IN member_nickname VARCHAR(20), apartment_name VARCHAR(20), title VARCHAR(50), 
content VARCHAR(3000), category VARCHAR(20), purchase_url VARCHAR(5000), max_participants INT)
BEGIN
	DECLARE post_id_param BIGINT;
    DECLARE	group_purchase_id_param BIGINT;
    DECLARE member_id_param BIGINT;
    DECLARE apartment_id_param BIGINT;
    DECLARE member_apartment_id_param BIGINT;

    -- 글쓴이 닉네임으로 member_id 찾아서 member_id_param에 저장
    SELECT member_id INTO member_id_param
    FROM members WHERE nickname = member_nickname;

    -- 아파트 이름으로 apartment_id 찾아서 apartment_id_param에 저장
    SELECT apartment_id INTO apartment_id_param
    FROM apartment WHERE name = apartment_name;

    -- 닉네임으로 글쓴이가 거주하는 apartment_id 찾아서 member_apartment_id_param에 저장
    SELECT apartment_id INTO member_apartment_id_param
    FROM members WHERE nickname = member_nickname;

    -- 글쓴이의 아파트ID와 게시판의 아파트ID가 같으면 게시글 작성
    IF apartment_id_param = member_apartment_id_param THEN
        -- 게시글 작성 (카테고리 선택)
        INSERT INTO post(member_id, apartment_id, title, content, category) VALUES(member_id_param, apartment_id_param, title, content, category);
    
        -- 가장 최근에 성공한 INSERT문의 PK를 가져옴
        SET post_id_param = LAST_INSERT_ID(); 
        
        -- 공구해요 테이블에 데이터 입력 
        INSERT INTO group_purchase(post_id, purchase_url, max_participants) VALUES(post_id_param, purchase_url, max_participants);
        SET group_purchase_id_param = LAST_INSERT_ID();
        
        -- 공구해요 상세 테이블에 데이터 입력
        INSERT INTO group_purchase_details(group_purchase_id, member_id) VALUES(group_purchase_id_param, member_id_param);
    ELSE SELECT '동일 아파트 게시판에만 글 작성이 가능합니다.' AS ERROR;
    END IF;
END //
DELIMITER //;

CALL createGroupPurchasePost('bellwin', '자이', '공동 구매 하실 분 구해요', '저는 옷 살거에요', '공구해요', 'www.coupang.com', 3);
-- 거주하지 않은 아파트에 글 작성 시도 시 에러
CALL createGroupPurchasePost('john', '푸르지오', '공동 구매 하실 2분 구해요', '저는 바지 살거에요', '공구해요', 'www.naver.com', 3);

-- 3. 일반 게시글 작성 (나눔해요, 조심해요, 자유게시판)
-- post -> (share OR becare OR freeboard) -> 데이터 자동 입력 (채팅방 개설 X)
DROP PROCEDURE IF EXISTS createGeneralPost;
DELIMITER //
CREATE PROCEDURE createGeneralPost(IN member_nickname VARCHAR(20), apartment_name VARCHAR(20), title VARCHAR(50), 
content VARCHAR(3000), category VARCHAR(20))
BEGIN
	DECLARE post_id_param BIGINT;
    DECLARE	category_param VARCHAR(20);
    DECLARE member_id_param BIGINT;
    DECLARE apartment_id_param BIGINT;
    DECLARE member_apartment_id_param BIGINT;

    -- 글쓴이 닉네임으로 member_id 찾아서 member_id_param에 저장
    SELECT member_id INTO member_id_param
    FROM members WHERE nickname = member_nickname;

    -- 아파트 이름으로 apartment_id 찾아서 apartment_id_param에 저장
    SELECT apartment_id INTO apartment_id_param
    FROM apartment WHERE name = apartment_name;

    -- 닉네임으로 글쓴이가 거주하는 apartment_id 찾아서 member_apartment_id_param에 저장
    SELECT apartment_id INTO member_apartment_id_param
    FROM members WHERE nickname = member_nickname;

    -- 글쓴이의 아파트ID와 게시판의 아파트ID가 같으면 게시글 작성
    IF apartment_id_param = member_apartment_id_param THEN

        -- 게시글 작성 (카테고리 선택)
        INSERT INTO post(member_id, apartment_id, title, content, category) VALUES(member_id_param, apartment_id_param, title, content, category);
        
        -- 가장 최근에 성공한 INSERT문의 PK를 가져옴
        SET post_id_param = LAST_INSERT_ID(); 

        -- 입력된 post의 category를 category_param에 저장
        SELECT category INTO category_param
        FROM post WHERE post_id = post_id_param;

        -- 게시판 카테고리(post.category)에 따른 특정 게시글(나눔 or 조심 or 자유게시판)에 데이터 입력
        CASE category_param
            WHEN '나눔해요' THEN INSERT INTO share(post_id) VALUES(post_id_param);
            WHEN '조심해요' THEN INSERT INTO becare(post_id) VALUES(post_id_param);
            WHEN '자유게시판' THEN INSERT INTO freeboard(post_id) VALUES(post_id_param);
        END CASE;
    ELSE SELECT '동일 아파트 게시판에만 글 작성이 가능합니다.' AS ERROR;
    END IF;
END //
DELIMITER //;

CALL createGeneralPost('bellwin', '자이', '아 심심해', '나랑 운동할 사람?', '자유게시판');
CALL createGeneralPost('catrina', '푸르지오', '옷 나눔해요!', '안 입는 패딩 나눔합니당', '나눔해요');
-- 거주하지 않은 아파트에 글 작성 시도 시 에러
CALL createGeneralPost('natalie', '푸르지오', '밤에 그만좀 떠들어요', '시끄러워서 잠을 못자겠어요', '조심해요');

-- 4. 배달해요 특정 게시글에 참여하기 버튼 누르기
DROP PROCEDURE IF EXISTS participateInDeliveryPostByNicknameAndDeliveryId;
DELIMITER //
CREATE PROCEDURE participateInDeliveryPostByNicknameAndDeliveryId(IN nickname VARCHAR(20), delivery_id BIGINT)
BEGIN
    DECLARE member_id_param BIGINT;
    DECLARE max_participants_param INT;
    DECLARE current_participants_param INT UNSIGNED;
    
    -- 입력한 닉네임에 해당하는 member_id를 member_id_param에 넣기
    SELECT member_id INTO member_id_param
    FROM members m WHERE m.nickname = nickname;

    -- 최대 모집 인원 찾기
    SELECT max_participants INTO max_participants_param
    FROM delivery WHERE delivery_id = delivery_id;

    -- 현재 참여 중인 인원 수 조회
    SELECT current_participants INTO current_participants_param
    FROM delivery WHERE delivery_id = delivery_id;

    IF current_participants_param < max_participants_param THEN
        -- delivery_details에 참여하기 클릭한 유저 정보 넣기
        INSERT INTO delivery_details(delivery_id, member_id) VALUES (delivery_id, member_id_param);

        -- delivery의 현재 참여자 수(current_participants) 1 증가
        UPDATE delivery set current_participants = current_participants + 1 where delivery_id = delivery_id;
    ELSE SELECT '최대 모집 인원을 초과할 수 없습니다.' AS ERROR;
    END IF;
END //
DELIMITER //;

-- delivery_details에 이미 있는 회원 입력 시 오류
CALL participateInDeliveryPostByNicknameAndDeliveryId('keigan', 2);
CALL participateInDeliveryPostByNicknameAndDeliveryId('natalie', 2);
-- 최대 모집 인원 초과 시 에러
CALL participateInDeliveryPostByNicknameAndDeliveryId('john', 2);


-- 5. 배달해요 특정 게시글의 모집 인원이 가득 찼을 때 채팅방 개설
DROP PROCEDURE IF EXISTS createDeliveryChatRoomIfFull;
DELIMITER //
CREATE PROCEDURE createDeliveryChatRoomIfFull(IN delivery_id BIGINT)
BEGIN
    DECLARE chat_room_id_param BIGINT;
    DECLARE max_participants_param INT;
    DECLARE current_participants_param INT UNSIGNED;
  
    -- 최대 모집 인원 찾기
    SELECT max_participants INTO max_participants_param
    FROM delivery WHERE delivery_id = delivery_id;

    -- 현재 참여 중인 인원 수 조회
    SELECT current_participants INTO current_participants_param
    FROM delivery WHERE delivery_id = delivery_id;

    -- 그룹 구매 참여자 수가 모집 인원과 동일하면 채팅방 생성
    IF current_participants_param = max_participants_param THEN
        -- 채팅방 생성
        INSERT INTO chat_room() VALUES ();
        SET chat_room_id_param = LAST_INSERT_ID();

        -- delivery_details의 채팅방 식별 번호 업데이트 
        UPDATE delivery_details SET chat_room_id = chat_room_id_param
        WHERE delivery_id = delivery_id;

        -- 배달해요 모집 및 확정 상태 변경
        UPDATE delivery SET status = '모집 완료' WHERE delivery_id = delivery_id;
        UPDATE delivery_details SET confirmation_status = 'Y' WHERE delivery_id = delivery_id;
    END IF;
END //
DELIMITER //;

CALL createDeliveryChatRoomIfFull(2);
