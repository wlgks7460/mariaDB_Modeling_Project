CREATE DATABASE apartment_service;
use apartment_service;

-- 1. Members 테이블 생성
CREATE TABLE Members (
    member_id BIGINT NOT NULL,
    apartment_id BIGINT NOT NULL,
    email VARCHAR(50) NOT NULL unique,
    password VARCHAR(20) NOT NULL,
    nickname VARCHAR(20) NOT NULL unique,
    phone_number VARCHAR(20) NOT NULL unique,
    id_card VARCHAR(1000) NOT NULL,
    role ENUM('USER', 'ADMIN') NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    modified_at DATETIME NULL,
    is_deleted ENUM('Y','N' ) default 'N'
);

-- 2. 댓글 좋아요 테이블 생성
CREATE TABLE Comment_Like (
   comment_like_id BIGINT NOT NULL,
   comment_id BIGINT NOT NULL,
   member_id BIGINT NOT NULL,
   created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
   modified_at DATETIME NULL,
   is_click ENUM('Y','N') default('N')
);

-- 3. 아파트 테이블 생성
CREATE TABLE Apartment (
    apartment_id BIGINT NOT NULL,
    name VARCHAR(20) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    modified_at DATETIME NULL,
    is_deleted ENUM('Y','N') default 'N'
);

-- 4. 게시글 테이블 생성
CREATE TABLE Post (
    post_id BIGINT NOT NULL,
    apartment_id BIGINT NOT NULL,
    member_id BIGINT NOT NULL,
    title VARCHAR(50) NOT NULL,
    content VARCHAR(3000) NOT NULL,
    category ENUM('자유게시판', '배달해요', '공구해요', '조심해요', '나눔해요') DEFAULT '자유게시판',
    views INT UNSIGNED DEFAULT 0,
    likes INT UNSIGNED DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    modified_at DATETIME NULL,
    is_deleted ENUM('Y','N') default 'N',
    deleted_at DATETIME NULL
);

-- 5. 게시글 좋아요 테이블 생성
CREATE TABLE PostLike (
    post_like_id BIGINT NOT NULL,
    member_id BIGINT NOT NULL,
    post_id BIGINT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    modified_at DATETIME NULL,
    is_click ENUM('Y','N') default 'N'
);

-- 6. 댓글 테이블 생성
CREATE TABLE Comment (
    comment_id BIGINT NOT NULL,
    member_id BIGINT NOT NULL,
    post_id BIGINT NOT NULL,
    parent_id BIGINT NULL,
    content VARCHAR(300) NOT NULL,
    likes_count int unsigned default 0, 
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    modified_at DATETIME NULL,
    is_deleted ENUM('Y','N') default 'N'
);

-- 7. 게시글 이미지 테이블 생성
CREATE TABLE PostImage (
    post_image_id BIGINT NOT NULL,
    post_id BIGINT NOT NULL,
    path VARCHAR(500) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    modified_at DATETIME NOT NULL,
    is_deleted ENUM('Y','N') default 'N'
);

-- 8. 배달해요 상세 테이블 생성
CREATE TABLE Delivery_Details (
    delivery_details_id BIGINT NOT NULL,
    delivery_id BIGINT NOT NULL,
    chat_room_id BIGINT NULL,
    member_id BIGINT NOT NULL UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    modified_at DATETIME NULL,
    confirmation_status ENUM('Y','N') DEFAULT 'N',
    is_deleted ENUM('Y','N') DEFAULT 'N'
);

-- 9. 배달해요 테이블 생성
CREATE TABLE Delivery (
    delivery_id BIGINT NOT NULL,
    post_id BIGINT NOT NULL,
    store VARCHAR(30) NOT NULL,
    delivery_date DATETIME NOT NULL,
    delivery_place VARCHAR(30) NOT NULL,
    max_participants INT NOT NULL,
    current_participants INT UNSIGNED DEFAULT 1,
    status ENUM('모집 중', '모집 완료') DEFAULT '모집 중'
);

-- 10. 채팅방 테이블 생성
CREATE TABLE Chat_Room (
    chat_room_id BIGINT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    modified_at DATETIME NULL
);

-- 11. 배달해요 메시지 테이블 생성
CREATE TABLE Delivery_Message (
    delivery_message_id BIGINT NOT NULL,
    delivery_details_id BIGINT NOT NULL,
    content VARCHAR(500) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    is_deleted ENUM('Y','N') default 'N'
);

-- 12. 공구해요 테이블 생성
CREATE TABLE Group_Purchase (
    group_purchase_id BIGINT NOT NULL,
    post_id BIGINT NOT NULL,
    purchase_url VARCHAR(5000) NOT NULL,
    max_participants INT NOT NULL,
    current_participants INT UNSIGNED DEFAULT 1,
    status ENUM('모집 중', '모집 완료') default '모집 중'
);

-- 13. 자유게시판 테이블 생성
CREATE TABLE Freeboard (
    freeboard_id BIGINT NOT NULL,
    post_id BIGINT NOT NULL
);

-- 14. 조심해요 테이블 생성
CREATE TABLE BeCare (
    be_care_id BIGINT NOT NULL,
    post_id BIGINT NOT NULL
);

-- 15. 나눔해요 테이블 생성
CREATE TABLE Share (
    share_id BIGINT NOT NULL,
    post_id BIGINT NOT NULL
);

-- 16. 공구해요 상세 테이블 생성
CREATE TABLE Group_Purchase_Details (
    group_purchase_details_id BIGINT NOT NULL,
    group_purchase_id BIGINT NOT NULL,
    chat_room_id BIGINT NULL,
    member_id BIGINT NOT NULL UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    modified_at DATETIME NULL,
    confirmation_status ENUM('Y', 'N') default('N'),
    is_deleted ENUM('Y','N') default ('N')
);

-- 17. 공지사항 테이블 생성
CREATE TABLE Notice (
    notice_id BIGINT NOT NULL,
    member_id BIGINT NOT NULL,
    title VARCHAR(50) NOT NULL,
    content VARCHAR(3000) NOT NULL,
    views INT UNSIGNED DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    modified_at DATETIME NULL,
    is_deleted ENUM('Y','N') DEFAULT 'N',
    deleted_at DATETIME NULL
);

-- 18. 공구해요 메시지 테이블 생성
CREATE TABLE Group_Purchase_Message (
    group_purchase_message_id BIGINT NOT NULL,
    group_purchase_details_id BIGINT NOT NULL,
    content VARCHAR(500) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    is_deleted ENUM('Y','N') default 'N'
);