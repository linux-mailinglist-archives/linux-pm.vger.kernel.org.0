Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBFD243EE5
	for <lists+linux-pm@lfdr.de>; Thu, 13 Aug 2020 20:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgHMSeL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 14:34:11 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:20511 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbgHMSeL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 14:34:11 -0400
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 Aug 2020 11:34:10 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg04-sd.qualcomm.com with ESMTP; 13 Aug 2020 11:34:10 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 025401813; Thu, 13 Aug 2020 11:34:09 -0700 (PDT)
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [PATCH v1 1/1] power: supply: add wireless power_supply_type
Date:   Thu, 13 Aug 2020 11:34:08 -0700
Message-Id: <1597343648-11136-1-git-send-email-gurus@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Subbaraman Narayanamurthy <subbaram@codeaurora.org>

Currently, power_supply framework supports only Battery, UPS,
Mains and USB power_supply_type. Add wireless power_supply_type
so that the drivers which supports wireless can register a power
supply class device with POWER_SUPPLY_TYPE_WIRELESS.

Signed-off-by: Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
---
 Documentation/ABI/testing/sysfs-class-power | 2 +-
 drivers/power/supply/power_supply_sysfs.c   | 1 +
 include/linux/power_supply.h                | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 40213c7..651599f 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -34,7 +34,7 @@ Description:
 		Describes the main type of the supply.
 
 		Access: Read
-		Valid values: "Battery", "UPS", "Mains", "USB"
+		Valid values: "Battery", "UPS", "Mains", "USB", "Wireless"
 
 ===== Battery Properties =====
 
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 3d38308..a616b9d 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -56,6 +56,7 @@ static const char * const POWER_SUPPLY_TYPE_TEXT[] = {
 	[POWER_SUPPLY_TYPE_USB_PD]		= "USB_PD",
 	[POWER_SUPPLY_TYPE_USB_PD_DRP]		= "USB_PD_DRP",
 	[POWER_SUPPLY_TYPE_APPLE_BRICK_ID]	= "BrickID",
+	[POWER_SUPPLY_TYPE_WIRELESS]		= "Wireless",
 };
 
 static const char * const POWER_SUPPLY_USB_TYPE_TEXT[] = {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 97cc4b8..ef03299 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -186,6 +186,7 @@ enum power_supply_type {
 	POWER_SUPPLY_TYPE_USB_PD,		/* Power Delivery Port */
 	POWER_SUPPLY_TYPE_USB_PD_DRP,		/* PD Dual Role Port */
 	POWER_SUPPLY_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
+	POWER_SUPPLY_TYPE_WIRELESS,		/* Wireless */
 };
 
 enum power_supply_usb_type {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

