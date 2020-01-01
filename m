Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0289312E0E3
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jan 2020 23:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgAAWqn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jan 2020 17:46:43 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40564 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbgAAWqg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jan 2020 17:46:36 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so37744142wrn.7;
        Wed, 01 Jan 2020 14:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+giR89WDjZU7dYJgn+VeERWM0MCUeGo4U5OGWtnpSHY=;
        b=HcNO/0Dus47RfAYdDwVWc+xNcxffaIXyZc0qawWBum9Tvlju7ZdvWtJO+xmmbRYnf3
         VZM1BBFknkj2dCS3X/PNHI0Dh0bn/4t3FIGP+xqFZtneQwV5u5Z/fFLP/0c/g0iJUDJJ
         FrHjJMYV0x9/jZVP7FL4Roupf7LviilKWQt9oZP0f+1YG3i7sqJyjMxa8RWIf5zy5yu/
         wsDh4xXkTeYSS7HFjGbhngEWYK9tST7nAAlopuPh2G0LTHuXYqxDdx/ZY1uYdqmMFIYX
         lGGiiWKsPwWnmhAlogu/1ODgJTFAAHlY1U9C+MESXg3owIX30Lm1FqLlE4VVNyyW9V9a
         RnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+giR89WDjZU7dYJgn+VeERWM0MCUeGo4U5OGWtnpSHY=;
        b=fYguGAIFsZSBICdMS2Ug35c1ArTFH6ahbJihPC15CkwRKI5hxiz0DakyV1Z6xd3t0x
         llL8oPMW+zOlW3IYRCKManY/XaJkw0Gap71QtevaxqMRF+zLD+DbdlZ4F0Apq4JWKOGX
         heirJW6/HfGBP4Dd2wJI4z24CdSOZ4h4bykOkPjDNL36sZTEuv/E3waKT873TH/HRw5+
         UTwCHAID6TEGT32zm5w55X08uJ8B1xRn+iKStH46KSU5Wbr32noF7u6VD0p7055j89az
         ez64w3gXORomqjx8MjdyXgT9xS10+xiMY3PVyYRbFHo2shnAfdcmdvTNZxf6Dq7+Kgqc
         BTyA==
X-Gm-Message-State: APjAAAWft4FYJY/vJ73Tm1BrGjbKY6drQouv8PxmqahuMzWomr2VgQfK
        WcRaOGOQuAk3Go4YnwF32H4=
X-Google-Smtp-Source: APXvYqy8Hj2CdTKm8VIldyNL9lpKTrZpAFzd1CsGxkdx6C7PHnHTylEJy2tuN8ol4wcSL1oV/Ml04g==
X-Received: by 2002:a5d:51cc:: with SMTP id n12mr80782539wrv.177.1577918794594;
        Wed, 01 Jan 2020 14:46:34 -0800 (PST)
Received: from localhost.localdomain ([46.216.160.87])
        by smtp.gmail.com with ESMTPSA id j12sm57716173wrw.54.2020.01.01.14.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 14:46:33 -0800 (PST)
Received: from jek by localhost.localdomain with local (Exim 4.93)
        (envelope-from <jekhor@gmail.com>)
        id 1imml6-00039p-5B; Thu, 02 Jan 2020 01:46:32 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH 1/3] power: supply: bq25890_charger: Add support of BQ25892 and BQ25896 chips
Date:   Thu,  2 Jan 2020 01:46:25 +0300
Message-Id: <20200101224627.12093-1-jekhor@gmail.com>
X-Mailer: git-send-email 2.25.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Support BQ25892 and BQ25896 chips by this driver. They shared one chip
ID 0, so distinquish them by device revisions (2 for 25896 and 1 for
25892).

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
---
 drivers/power/supply/bq25890_charger.c | 97 ++++++++++++++++++++------
 1 file changed, 76 insertions(+), 21 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 9d1ec8d677de..a3dcd4eb1287 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -25,12 +25,20 @@
 #define BQ25895_ID			7
 #define BQ25896_ID			0
 
+enum bq25890_chip_version {
+	BQ25890,
+	BQ25892,
+	BQ25895,
+	BQ25896,
+};
+
 enum bq25890_fields {
 	F_EN_HIZ, F_EN_ILIM, F_IILIM,				     /* Reg00 */
 	F_BHOT, F_BCOLD, F_VINDPM_OFS,				     /* Reg01 */
 	F_CONV_START, F_CONV_RATE, F_BOOSTF, F_ICO_EN,
 	F_HVDCP_EN, F_MAXC_EN, F_FORCE_DPM, F_AUTO_DPDM_EN,	     /* Reg02 */
-	F_BAT_LOAD_EN, F_WD_RST, F_OTG_CFG, F_CHG_CFG, F_SYSVMIN,    /* Reg03 */
+	F_BAT_LOAD_EN, F_WD_RST, F_OTG_CFG, F_CHG_CFG, F_SYSVMIN,
+	F_MIN_VBAT_SEL,						     /* Reg03 */
 	F_PUMPX_EN, F_ICHG,					     /* Reg04 */
 	F_IPRECHG, F_ITERM,					     /* Reg05 */
 	F_VREG, F_BATLOWV, F_VRECHG,				     /* Reg06 */
@@ -39,8 +47,9 @@ enum bq25890_fields {
 	F_BATCMP, F_VCLAMP, F_TREG,				     /* Reg08 */
 	F_FORCE_ICO, F_TMR2X_EN, F_BATFET_DIS, F_JEITA_VSET,
 	F_BATFET_DLY, F_BATFET_RST_EN, F_PUMPX_UP, F_PUMPX_DN,	     /* Reg09 */
-	F_BOOSTV, F_BOOSTI,					     /* Reg0A */
-	F_VBUS_STAT, F_CHG_STAT, F_PG_STAT, F_SDP_STAT, F_VSYS_STAT, /* Reg0B */
+	F_BOOSTV, F_PFM_OTG_DIS, F_BOOSTI,			     /* Reg0A */
+	F_VBUS_STAT, F_CHG_STAT, F_PG_STAT, F_SDP_STAT, F_0B_RSVD,
+	F_VSYS_STAT,						     /* Reg0B */
 	F_WD_FAULT, F_BOOST_FAULT, F_CHG_FAULT, F_BAT_FAULT,
 	F_NTC_FAULT,						     /* Reg0C */
 	F_FORCE_VINDPM, F_VINDPM,				     /* Reg0D */
@@ -91,7 +100,7 @@ struct bq25890_device {
 	struct regmap *rmap;
 	struct regmap_field *rmap_fields[F_MAX_FIELDS];
 
-	int chip_id;
+	enum bq25890_chip_version chip_version;
 	struct bq25890_init_data init_data;
 	struct bq25890_state state;
 
@@ -111,8 +120,7 @@ static const struct regmap_access_table bq25890_writeable_regs = {
 static const struct regmap_range bq25890_volatile_reg_ranges[] = {
 	regmap_reg_range(0x00, 0x00),
 	regmap_reg_range(0x09, 0x09),
-	regmap_reg_range(0x0b, 0x0c),
-	regmap_reg_range(0x0e, 0x14),
+	regmap_reg_range(0x0b, 0x14),
 };
 
 static const struct regmap_access_table bq25890_volatile_regs = {
@@ -155,7 +163,7 @@ static const struct reg_field bq25890_reg_fields[] = {
 	[F_OTG_CFG]		= REG_FIELD(0x03, 5, 5),
 	[F_CHG_CFG]		= REG_FIELD(0x03, 4, 4),
 	[F_SYSVMIN]		= REG_FIELD(0x03, 1, 3),
-	/* MIN_VBAT_SEL on BQ25896 */
+	[F_MIN_VBAT_SEL]	= REG_FIELD(0x03, 0, 0), // BQ25896 only
 	/* REG04 */
 	[F_PUMPX_EN]		= REG_FIELD(0x04, 7, 7),
 	[F_ICHG]		= REG_FIELD(0x04, 0, 6),
@@ -188,8 +196,8 @@ static const struct reg_field bq25890_reg_fields[] = {
 	[F_PUMPX_DN]		= REG_FIELD(0x09, 0, 0),
 	/* REG0A */
 	[F_BOOSTV]		= REG_FIELD(0x0A, 4, 7),
-	/* PFM_OTG_DIS 3 on BQ25896 */
 	[F_BOOSTI]		= REG_FIELD(0x0A, 0, 2), // reserved on BQ25895
+	[F_PFM_OTG_DIS]		= REG_FIELD(0x0A, 3, 3), // BQ25896 only
 	/* REG0B */
 	[F_VBUS_STAT]		= REG_FIELD(0x0B, 5, 7),
 	[F_CHG_STAT]		= REG_FIELD(0x0B, 3, 4),
@@ -275,6 +283,7 @@ static const union {
 	struct bq25890_lookup lt;
 } bq25890_tables[] = {
 	/* range tables */
+	/* TODO: BQ25896 has max ICHG 3008 mA */
 	[TBL_ICHG] =	{ .rt = {0,	  5056000, 64000} },	 /* uA */
 	[TBL_ITERM] =	{ .rt = {64000,   1024000, 64000} },	 /* uA */
 	[TBL_VREG] =	{ .rt = {3840000, 4608000, 16000} },	 /* uV */
@@ -391,11 +400,13 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 		break;
 
 	case POWER_SUPPLY_PROP_MODEL_NAME:
-		if (bq->chip_id == BQ25890_ID)
+		if (bq->chip_version == BQ25890)
 			val->strval = "BQ25890";
-		else if (bq->chip_id == BQ25895_ID)
+		else if (bq->chip_version == BQ25892)
+			val->strval = "BQ25892";
+		else if (bq->chip_version == BQ25895)
 			val->strval = "BQ25895";
-		else if (bq->chip_id == BQ25896_ID)
+		else if (bq->chip_version == BQ25896)
 			val->strval = "BQ25896";
 		else
 			val->strval = "UNKNOWN";
@@ -741,6 +752,56 @@ static int bq25890_usb_notifier(struct notifier_block *nb, unsigned long val,
 	return NOTIFY_OK;
 }
 
+static int bq25890_get_chip_version(struct bq25890_device *bq)
+{
+	int id, rev;
+
+	id = bq25890_field_read(bq, F_PN);
+	if (id < 0) {
+		dev_err(bq->dev, "Cannot read chip ID.\n");
+		return id;
+	}
+
+	rev = bq25890_field_read(bq, F_DEV_REV);
+	if (rev < 0) {
+		dev_err(bq->dev, "Cannot read chip revision.\n");
+		return id;
+	}
+
+	switch (id) {
+	case BQ25890_ID:
+		bq->chip_version = BQ25890;
+		break;
+
+	/* BQ25892 and BQ25896 share same ID 0 */
+	case BQ25896_ID:
+		switch (rev) {
+		case 0:
+			bq->chip_version = BQ25896;
+			break;
+		case 1:
+			bq->chip_version = BQ25892;
+			break;
+		default:
+			dev_err(bq->dev,
+				"Unknown device revision %d, assume BQ25892\n",
+				rev);
+			bq->chip_version = BQ25892;
+		}
+		break;
+
+	case BQ25895_ID:
+		bq->chip_version = BQ25895;
+		break;
+
+	default:
+		dev_err(bq->dev, "Unknown chip ID %d\n", id);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 static int bq25890_irq_probe(struct bq25890_device *bq)
 {
 	struct gpio_desc *irq;
@@ -859,16 +920,10 @@ static int bq25890_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, bq);
 
-	bq->chip_id = bq25890_field_read(bq, F_PN);
-	if (bq->chip_id < 0) {
-		dev_err(dev, "Cannot read chip ID.\n");
-		return bq->chip_id;
-	}
-
-	if ((bq->chip_id != BQ25890_ID) && (bq->chip_id != BQ25895_ID)
-			&& (bq->chip_id != BQ25896_ID)) {
-		dev_err(dev, "Chip with ID=%d, not supported!\n", bq->chip_id);
-		return -ENODEV;
+	ret = bq25890_get_chip_version(bq);
+	if (ret) {
+		dev_err(dev, "Cannot read chip ID or unknown chip.\n");
+		return ret;
 	}
 
 	if (!dev->platform_data) {
-- 
2.25.0.rc0

