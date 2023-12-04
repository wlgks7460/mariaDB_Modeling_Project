-- 1. 모든 아파트 주민들이 작성한 게시글 조회
DROP PROCEDURE IF EXISTS viewAllPosts;
DELIMITER //
CREATE PROCEDURE viewAllPosts()
BEGIN
    select m.nickname, a.name as '아파트 이름', p.title, p.content, p.category, p.created_at
    from members m 
    inner join post p on m.member_id = p.member_id 
    inner join apartment a on m.apartment_id = a.apartment_id
    order by p.created_at desc;
END //
DELIMITER //;

CALL viewAllPosts();


-- 2. 배달해요 특정 게시글의 참여 중인 인원 조회
DROP PROCEDURE IF EXISTS viewMembersInDeliveryDetailsByDeliveryId;
DELIMITER //
CREATE PROCEDURE viewMembersInDeliveryDetailsByDeliveryId (IN delivery_id BIGINT)
BEGIN
    SELECT m.nickname FROM delivery_details dd 
    INNER JOIN delivery d ON dd.delivery_id = d.delivery_id 
    INNER JOIN members m ON m.member_id = dd.member_id
    WHERE d.delivery_id = delivery_id;
END //
DELIMITER //;

CALL viewMembersInDeliveryDetailsByDeliveryId(2);

-- 3. 채팅방이 개설된 배달해요 게시글 중, 채팅방에 참여한 사람들의 닉네임 조회
DROP PROCEDURE IF EXISTS viewMembersNicknameInDeliveryChatRoomByDeliveryId;
DELIMITER //
CREATE PROCEDURE viewMembersNicknameInDeliveryChatRoomByDeliveryId ()
BEGIN
    SELECT m.nickname, cr.chat_room_id FROM delivery_details dd 
    INNER JOIN chat_room cr ON dd.chat_room_id = cr.chat_room_id
    INNER JOIN delivery d ON dd.delivery_id = d.delivery_id
    INNER JOIN post p ON p.post_id = d.post_id
    INNER JOIN members m ON p.member_id = m.member_id
    WHERE dd.confirmation_status = 'Y';
END //
DELIMITER //;

CALL viewMembersNicknameInDeliveryChatRoomByDeliveryId();