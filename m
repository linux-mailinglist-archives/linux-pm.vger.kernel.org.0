Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7DB760551
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2019 13:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbfGELi3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jul 2019 07:38:29 -0400
Received: from node.akkea.ca ([192.155.83.177]:41794 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728741AbfGELi3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Jul 2019 07:38:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 2131E4E2051;
        Fri,  5 Jul 2019 11:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1562326708; bh=18P+AMytcx3lv76RTtEolvqR25huJYtRlXkpaF9f5yE=;
        h=From:To:Cc:Subject:Date;
        b=mfJTkIGivYuAi4DCALqY13+hqDe09cDBGciyJM5EwsH+Ha/iNCKEXUAOwO9FAUjzM
         cLaRPELssKRLCF+LyPFzeDWOl3ALnaXYkmmXxKxPxtwPVh9cpJCvy+mBs4B2ULabj1
         TCmIwW+Jvj6bCxv/esdptNJMXrl4H1tlQ/AVsaNU=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 68gWECsqC91D; Fri,  5 Jul 2019 11:38:27 +0000 (UTC)
Received: from media.hitronhub.home (S0106ac202e1e3ee3.cg.shawcable.net [96.51.227.121])
        by node.akkea.ca (Postfix) with ESMTPSA id 7A70A4E204E;
        Fri,  5 Jul 2019 11:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1562326707; bh=18P+AMytcx3lv76RTtEolvqR25huJYtRlXkpaF9f5yE=;
        h=From:To:Cc:Subject:Date;
        b=GQ/H+cQREUeTwBG7+qcyZMDRjUAVUI9784QoRD/mDpJuss9+bmJqLcMwveXscH9WL
         2pTQcWnuMiDW+JjPkkKqXABLoqcpkDuZZPzKk7oFG+IXTVd4iBVXNKox68i5ObGyT2
         h1J4frsHlDpoyCGRBZt70Gbhyp6lwxESagY4BPAY=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus.ainslie@puri.sm
Cc:     krzk@kernel.org, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH] power: supply: bq25890_charger: Add the BQ25895 part
Date:   Fri,  5 Jul 2019 05:37:51 -0600
Message-Id: <20190705113751.18116-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The BQ25895 is almost identical to the BQ25890.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 drivers/power/supply/bq25890_charger.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index d333f2b321b9..9d1ec8d677de 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -22,6 +22,7 @@
 #define BQ25890_IRQ_PIN			"bq25890_irq"
 
 #define BQ25890_ID			3
+#define BQ25895_ID			7
 #define BQ25896_ID			0
 
 enum bq25890_fields {
@@ -171,7 +172,7 @@ static const struct reg_field bq25890_reg_fields[] = {
 	[F_WD]			= REG_FIELD(0x07, 4, 5),
 	[F_TMR_EN]		= REG_FIELD(0x07, 3, 3),
 	[F_CHG_TMR]		= REG_FIELD(0x07, 1, 2),
-	[F_JEITA_ISET]		= REG_FIELD(0x07, 0, 0),
+	[F_JEITA_ISET]		= REG_FIELD(0x07, 0, 0), // reserved on BQ25895
 	/* REG08 */
 	[F_BATCMP]		= REG_FIELD(0x08, 5, 7),
 	[F_VCLAMP]		= REG_FIELD(0x08, 2, 4),
@@ -180,7 +181,7 @@ static const struct reg_field bq25890_reg_fields[] = {
 	[F_FORCE_ICO]		= REG_FIELD(0x09, 7, 7),
 	[F_TMR2X_EN]		= REG_FIELD(0x09, 6, 6),
 	[F_BATFET_DIS]		= REG_FIELD(0x09, 5, 5),
-	[F_JEITA_VSET]		= REG_FIELD(0x09, 4, 4),
+	[F_JEITA_VSET]		= REG_FIELD(0x09, 4, 4), // reserved on BQ25895
 	[F_BATFET_DLY]		= REG_FIELD(0x09, 3, 3),
 	[F_BATFET_RST_EN]	= REG_FIELD(0x09, 2, 2),
 	[F_PUMPX_UP]		= REG_FIELD(0x09, 1, 1),
@@ -188,7 +189,7 @@ static const struct reg_field bq25890_reg_fields[] = {
 	/* REG0A */
 	[F_BOOSTV]		= REG_FIELD(0x0A, 4, 7),
 	/* PFM_OTG_DIS 3 on BQ25896 */
-	[F_BOOSTI]		= REG_FIELD(0x0A, 0, 2),
+	[F_BOOSTI]		= REG_FIELD(0x0A, 0, 2), // reserved on BQ25895
 	/* REG0B */
 	[F_VBUS_STAT]		= REG_FIELD(0x0B, 5, 7),
 	[F_CHG_STAT]		= REG_FIELD(0x0B, 3, 4),
@@ -392,6 +393,8 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		if (bq->chip_id == BQ25890_ID)
 			val->strval = "BQ25890";
+		else if (bq->chip_id == BQ25895_ID)
+			val->strval = "BQ25895";
 		else if (bq->chip_id == BQ25896_ID)
 			val->strval = "BQ25896";
 		else
@@ -862,7 +865,8 @@ static int bq25890_probe(struct i2c_client *client,
 		return bq->chip_id;
 	}
 
-	if ((bq->chip_id != BQ25890_ID) && (bq->chip_id != BQ25896_ID)) {
+	if ((bq->chip_id != BQ25890_ID) && (bq->chip_id != BQ25895_ID)
+			&& (bq->chip_id != BQ25896_ID)) {
 		dev_err(dev, "Chip with ID=%d, not supported!\n", bq->chip_id);
 		return -ENODEV;
 	}
-- 
2.17.1

