Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0F6F66C4
	for <lists+linux-pm@lfdr.de>; Sun, 10 Nov 2019 04:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfKJDP5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Nov 2019 22:15:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:35260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727302AbfKJClN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 9 Nov 2019 21:41:13 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E907821850;
        Sun, 10 Nov 2019 02:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353672;
        bh=6rLXOOpyhENEwIWRMZg72JBdXNe4tH+Hrc/ZYftRZBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dyQecCYNxowagmHGSDkEKKm5wLO5zKsLbOsrwoa/W/kZ3DdChFH4f3fqiKtW8XGlO
         y+Gn0F14abKhdyGyUiBh5EzhEzYUOQBSEjy/FF6rgICqWAaCv4FWN1XHlXJYOJ2D6z
         AFVbGT7ct2MiE6E6bHU7IuZfqCXoI967PuHZMrtE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 038/191] power: supply: twl4030_charger: disable eoc interrupt on linear charge
Date:   Sat,  9 Nov 2019 21:37:40 -0500
Message-Id: <20191110024013.29782-38-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Andreas Kemnade <andreas@kemnade.info>

[ Upstream commit 079cdff3d0a09c5da10ae1be35def7a116776328 ]

This avoids getting woken up from suspend after power interruptions
when the bci wrongly thinks the battery is full just because
of input current going low because of low input power

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/twl4030_charger.c | 27 +++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index adcaa0a10a6f4..0e202d4273fb6 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -440,6 +440,7 @@ static void twl4030_current_worker(struct work_struct *data)
 static int twl4030_charger_enable_usb(struct twl4030_bci *bci, bool enable)
 {
 	int ret;
+	u32 reg;
 
 	if (bci->usb_mode == CHARGE_OFF)
 		enable = false;
@@ -453,14 +454,38 @@ static int twl4030_charger_enable_usb(struct twl4030_bci *bci, bool enable)
 			bci->usb_enabled = 1;
 		}
 
-		if (bci->usb_mode == CHARGE_AUTO)
+		if (bci->usb_mode == CHARGE_AUTO) {
+			/* Enable interrupts now. */
+			reg = ~(u32)(TWL4030_ICHGLOW | TWL4030_ICHGEOC |
+					TWL4030_TBATOR2 | TWL4030_TBATOR1 |
+					TWL4030_BATSTS);
+			ret = twl_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, reg,
+				       TWL4030_INTERRUPTS_BCIIMR1A);
+			if (ret < 0) {
+				dev_err(bci->dev,
+					"failed to unmask interrupts: %d\n",
+					ret);
+				return ret;
+			}
 			/* forcing the field BCIAUTOUSB (BOOT_BCI[1]) to 1 */
 			ret = twl4030_clear_set_boot_bci(0, TWL4030_BCIAUTOUSB);
+		}
 
 		/* forcing USBFASTMCHG(BCIMFSTS4[2]) to 1 */
 		ret = twl4030_clear_set(TWL_MODULE_MAIN_CHARGE, 0,
 			TWL4030_USBFASTMCHG, TWL4030_BCIMFSTS4);
 		if (bci->usb_mode == CHARGE_LINEAR) {
+			/* Enable interrupts now. */
+			reg = ~(u32)(TWL4030_ICHGLOW | TWL4030_TBATOR2 |
+					TWL4030_TBATOR1 | TWL4030_BATSTS);
+			ret = twl_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, reg,
+				       TWL4030_INTERRUPTS_BCIIMR1A);
+			if (ret < 0) {
+				dev_err(bci->dev,
+					"failed to unmask interrupts: %d\n",
+					ret);
+				return ret;
+			}
 			twl4030_clear_set_boot_bci(TWL4030_BCIAUTOAC|TWL4030_CVENAC, 0);
 			/* Watch dog key: WOVF acknowledge */
 			ret = twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE, 0x33,
-- 
2.20.1

