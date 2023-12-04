-- PK 설정
-- 1 Members(member_id) auto, primary
ALTER TABLE Members MODIFY member_id BIGINT AUTO_INCREMENT PRIMARY KEY;

-- 2 Apartment(apartment_id) auto, primary
ALTER TABLE Apartment MODIFY apartment_id BIGINT AUTO_INCREMENT PRIMARY KEY;

-- 3 Post(post_id) auto, primary
ALTER TABLE Post MODIFY post_id BIGINT AUTO_INCREMENT PRIMARY KEY;

-- 4 Comment(comment_id) auto, primary
ALTER TABLE Comment MODIFY comment_id BIGINT AUTO_INCREMENT PRIMARY KEY;

-- 5 PostLike(post_like_id) auto, primary
ALTER TABLE PostLike MODIFY post_like_id BIGINT AUTO_INCREMENT PRIMARY KEY;

-- 6 PostImage(post_image_id) auto, primary
ALTER TABLE PostImage MODIFY post_image_id BIGINT AUTO_INCREMENT PRIMARY KEY;

-- 7
ALTER TABLE Comment_Like MODIFY comment_like_id BIGINT AUTO_INCREMENT PRIMARY KEY;

-- 8 Delivery_Details(delivery_details_id) auto, primary
ALTER TABLE Delivery_Details MODIFY delivery_details_id BIGINT AUTO_INCREMENT PRIMARY KEY;

-- 9 Delivery(delivery_id) auto, primary
ALTER TABLE Delivery MODIFY delivery_id BIGINT AUTO_INCREMENT PRIMARY KEY;

-- 10 Chat_Room(chat_room_id) auto, primary
ALTER TABLE Chat_Room MODIFY chat_room_id BIGINT AUTO_INCREMENT PRIMARY KEY;

-- 11 Message(message_id) auto, primary
ALTER TABLE delivery_message MODIFY delivery_message_id BIGINT AUTO_INCREMENT PRIMARY KEY;

-- 12 Group_Purchase(group_purchase_id) auto, primary
ALTER TABLE Group_Purchase MODIFY group_purchase_id BIGINT AUTO_INCREMENT PRIMARY KEY;

-- 13 Freeboard(freeboard_id) auto, primary
ALTER TABLE Freeboard MODIFY freeboard_id BIGINT AUTO_INCREMENT PRIMARY KEY;

-- 14 Freeboard(freeboard_id) auto, primary
ALTER TABLE BeCare MODIFY be_care_id BIGINT AUTO_INCREMENT PRIMARY KEY;

-- 15 sharing(share_id) auto, primary
ALTER TABLE Share MODIFY share_id BIGINT AUTO_INCREMENT PRIMARY KEY;

-- 16 Group_Purchase_Details(group_purchase_details_id) auto, primary
ALTER TABLE Group_Purchase_Details MODIFY group_purchase_details_id BIGINT AUTO_INCREMENT PRIMARY KEY;

-- 17 Notice(notice_id) auto, primary
ALTER TABLE Notice MODIFY notice_id BIGINT AUTO_INCREMENT PRIMARY KEY;

-- 18 Group_Purchase_Message(Group_Purchase_Message_id) auto, primary
ALTER TABLE Group_Purchase_Message MODIFY group_purchase_message_id BIGINT AUTO_INCREMENT PRIMARY KEY;


-- FK 설정
ALTER TABLE Members ADD CONSTRAINT FK_Apartment_TO_Members_1 FOREIGN KEY (
 apartment_id  
)
REFERENCES Apartment (
 apartment_id
) on delete cascade;

ALTER TABLE Post ADD CONSTRAINT FK_Members_TO_Post_1 FOREIGN KEY (
 member_id
)
REFERENCES Members (
 member_id
);

ALTER TABLE Post ADD CONSTRAINT FK_Apartment_TO_Post_1 FOREIGN KEY (
	apartment_id
)
REFERENCES Apartment (
	apartment_id
) on delete cascade;

ALTER TABLE PostLike ADD CONSTRAINT FK_Members_TO_PostLike_1 FOREIGN KEY (
 member_id
)
REFERENCES Members (
 member_id
)on delete cascade;

ALTER TABLE PostLike ADD CONSTRAINT FK_Post_TO_PostLike_1 FOREIGN KEY (
 post_id
)
REFERENCES Post (
 post_id
)on delete cascade;

ALTER TABLE Comment ADD CONSTRAINT FK_Members_TO_Comment_1 FOREIGN KEY (
 member_id
)
REFERENCES Members (
 member_id
);

ALTER TABLE Comment ADD CONSTRAINT FK_Post_TO_Comment_1 FOREIGN KEY (
 post_id
)
REFERENCES Post (
 post_id
)on delete cascade;

ALTER TABLE Comment ADD CONSTRAINT FK_Comment_TO_Comment_1 FOREIGN KEY (
 parent_id
)
REFERENCES Comment (
 comment_id
);

ALTER TABLE PostImage ADD CONSTRAINT FK_Post_TO_PostImage_1 FOREIGN KEY (
 post_id
)
REFERENCES Post (
 post_id
)on delete cascade;


ALTER TABLE Delivery_Details ADD CONSTRAINT FK_Delivery_TO_Delivery_Details_1 FOREIGN KEY (
 delivery_id
)
REFERENCES Delivery (
 delivery_id
) ON DELETE CASCADE;

ALTER TABLE Delivery_Details ADD CONSTRAINT FK_Chat_Room_TO_Delivery_Details_1 FOREIGN KEY (
 chat_room_id
)
REFERENCES Chat_Room (
 chat_room_id
);

ALTER TABLE Delivery_Details ADD CONSTRAINT FK_Members_TO_Delivery_Details_1 FOREIGN KEY (
 member_id
)
REFERENCES Members (
 member_id
);

ALTER TABLE Comment_Like ADD CONSTRAINT FK_Comment_TO_Comment_Like_1 FOREIGN KEY (
   comment_id
)
REFERENCES Comment (
   comment_id
)on delete cascade;

ALTER TABLE Comment_Like ADD CONSTRAINT FK_Members_TO_Comment_Like_1 FOREIGN KEY (
   member_id
)
REFERENCES Members (
   member_id
)on delete cascade;

ALTER TABLE Delivery ADD CONSTRAINT FK_Post_TO_Delivery_1 FOREIGN KEY (
 post_id
)
REFERENCES Post (
 post_id
)on delete cascade;

ALTER TABLE Delivery_Message ADD CONSTRAINT FK_Delivery_Details_TO_Delivery_Message_1 FOREIGN KEY (
 delivery_details_id
)
REFERENCES Delivery_Details (
 delivery_details_id
);

ALTER TABLE Group_Purchase ADD CONSTRAINT FK_Post_TO_Group_Purchase_1 FOREIGN KEY (
 post_id
)
REFERENCES Post (
 post_id
)on delete cascade;

ALTER TABLE Freeboard ADD CONSTRAINT FK_Post_TO_Freeboard_1 FOREIGN KEY (
 post_id
)
REFERENCES Post (
 post_id
)on delete cascade;

ALTER TABLE BeCare ADD CONSTRAINT FK_Post_TO_BeCare_1 FOREIGN KEY (
 post_id
)
REFERENCES Post (
 post_id
)on delete cascade;

ALTER TABLE Share ADD CONSTRAINT FK_Post_TO_Share_1 FOREIGN KEY (
 post_id
)
REFERENCES Post (
 post_id
)on delete cascade;

ALTER TABLE Group_Purchase_Details ADD CONSTRAINT FK_Group_Purchase_TO_Group_Purchase_Details_1 FOREIGN KEY (
 group_purchase_id
)
REFERENCES Group_Purchase (
 group_purchase_id
) ON DELETE CASCADE;

ALTER TABLE Group_Purchase_Details ADD CONSTRAINT FK_Chat_Room_TO_Group_Purchase_Details_1 FOREIGN KEY (
 chat_room_id
)
REFERENCES Chat_Room (
 chat_room_id
);

ALTER TABLE Group_Purchase_Details ADD CONSTRAINT FK_Members_TO_Group_Purchase_Details_1 FOREIGN KEY (
 member_id
)
REFERENCES Members (
 member_id
);

ALTER TABLE Notice ADD CONSTRAINT FK_Members_TO_Notice_1 FOREIGN KEY (
 member_id
)
REFERENCES Members (
 member_id
);

ALTER TABLE Group_Purchase_Message ADD CONSTRAINT FK_Group_Purchase_Details_TO_Group_Purchase_Message_1 FOREIGN KEY 
(
   group_purchase_details_id
)
REFERENCES group_purchase_details (
   group_purchase_details_id
);