Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 938FF23FF7
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2019 20:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfETSHe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 May 2019 14:07:34 -0400
Received: from node.akkea.ca ([192.155.83.177]:58454 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727342AbfETSH2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 May 2019 14:07:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 6E2134E2051;
        Mon, 20 May 2019 18:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1558375647; bh=m8cdXZ8FfH0krHWZKQDnrPe9eKnA6LedLfVz+I5dPck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=NZ/lQ9Z66p9K4I4tS3uinE/saUc49yrO98R6dyqM5rV96jllHwQHTYoireeyc2RNV
         GptpgSic9UD9Ub2mb+AIFzYe6CS0/e6qMQ9eMkwp7+fNLlxsfsn80ND3CB7zYNYeD9
         Ib6WZCmDeAdJvGcN4poaxVCn5eGlTHCvVMhvuyL8=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SVYSlngOg6vY; Mon, 20 May 2019 18:07:27 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 988094E204D;
        Mon, 20 May 2019 18:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1558375646; bh=m8cdXZ8FfH0krHWZKQDnrPe9eKnA6LedLfVz+I5dPck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fPG2NCT1oq+LRMus8ji9WZO99Lj8z7KD+b3CONi+8CFpARsAp1b1cat+ri3vRq2yW
         LXm4XrhTkBo2dr20mvYdETSKmlQVvSY4aVCnw2gGILNvhzJ+3rvZzZib4ebjE+9dJ+
         OaQzHdMh8zhNMw7hgPb+Er4REQ6Hb5SQKRjuP9b0=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus.ainslie@puri.sm
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Kuzmenko <eric.kuzmenko@puri.sm>,
        Angus Ainslie <angus@akkea.ca>
Subject: [PATCH 1/2] power: supply: bq25890: Add support for setting bq25890 and bq25896's VINDPM
Date:   Mon, 20 May 2019 11:07:11 -0700
Message-Id: <20190520180712.32405-2-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190520180712.32405-1-angus@akkea.ca>
References: <20190520180712.32405-1-angus@akkea.ca>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Eric Kuzmenko <eric.kuzmenko@puri.sm>

The bq25890 has low voltage protection on VIN. Allow the register
to be set from the device tree.

Signed-off-by: Eric Kuzmenko <eric.kuzmenko@puri.sm>
Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 drivers/power/supply/bq25890_charger.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 66991e6f75d9..34fc89776994 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -75,6 +75,8 @@ struct bq25890_init_data {
 	u8 boosti;	/* boost current limit		*/
 	u8 boostf;	/* boost frequency		*/
 	u8 ilim_en;	/* enable ILIM pin		*/
+	u8 force_vindpm;/* force vinmin threshold	*/
+	u8 vindpm;	/* vinmin threshold		*/
 	u8 treg;	/* thermal regulation threshold */
 };
 
@@ -250,6 +252,7 @@ enum bq25890_table_ids {
 	TBL_VREG,
 	TBL_BOOSTV,
 	TBL_SYSVMIN,
+	TBL_VINDPM,
 
 	/* lookup tables */
 	TBL_TREG,
@@ -289,6 +292,7 @@ static const union {
 	[TBL_VREG] =	{ .rt = {3840000, 4608000, 16000} },	 /* uV */
 	[TBL_BOOSTV] =	{ .rt = {4550000, 5510000, 64000} },	 /* uV */
 	[TBL_SYSVMIN] = { .rt = {3000000, 3700000, 100000} },	 /* uV */
+	[TBL_VINDPM] =	{ .rt = {2600000, 15300000, 100000} },	 /* uV */
 
 	/* lookup tables */
 	[TBL_TREG] =	{ .lt = {bq25890_treg_tbl, BQ25890_TREG_TBL_SIZE} },
@@ -621,6 +625,8 @@ static int bq25890_hw_init(struct bq25890_device *bq)
 		{F_BOOSTI,	 bq->init_data.boosti},
 		{F_BOOSTF,	 bq->init_data.boostf},
 		{F_EN_ILIM,	 bq->init_data.ilim_en},
+		{F_FORCE_VINDPM, bq->init_data.force_vindpm},
+		{F_VINDPM,	 bq->init_data.vindpm},
 		{F_TREG,	 bq->init_data.treg}
 	};
 
@@ -783,11 +789,14 @@ static int bq25890_fw_read_u32_props(struct bq25890_device *bq)
 		{"ti,boost-max-current", false, TBL_BOOSTI, &init->boosti},
 
 		/* optional properties */
-		{"ti,thermal-regulation-threshold", true, TBL_TREG, &init->treg}
+		{"ti,thermal-regulation-threshold",
+			true, TBL_TREG, &init->treg},
+		{"ti,vinmin-threshold", true, TBL_VINDPM, &init->vindpm}
 	};
 
 	/* initialize data for optional properties */
 	init->treg = 3; /* 120 degrees Celsius */
+	init->vindpm = 0x12; /* 4.4V */
 
 	for (i = 0; i < ARRAY_SIZE(props); i++) {
 		ret = device_property_read_u32(bq->dev, props[i].name,
@@ -820,6 +829,8 @@ static int bq25890_fw_probe(struct bq25890_device *bq)
 
 	init->ilim_en = device_property_read_bool(bq->dev, "ti,use-ilim-pin");
 	init->boostf = device_property_read_bool(bq->dev, "ti,boost-low-freq");
+	init->force_vindpm =
+		device_property_read_bool(bq->dev, "ti,use-vinmin-threshold");
 
 	return 0;
 }
-- 
2.17.1

