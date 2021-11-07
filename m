Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99EA744759B
	for <lists+linux-pm@lfdr.de>; Sun,  7 Nov 2021 21:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbhKGUXB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Nov 2021 15:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhKGUXB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Nov 2021 15:23:01 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D237C061570;
        Sun,  7 Nov 2021 12:20:17 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 13so7500750ljj.11;
        Sun, 07 Nov 2021 12:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1TUEBF7J1pmP1s04A7SQCK63MaBeS7pHTSwdINbY9n4=;
        b=izoBO20Lysk1wf0HRbAaGths4R0eV/nyfNdroh73nPlhnZLepwAjZlDYPxWTrNg3rE
         DCytIYyG6tVBR0TRpoluipEfGB205SawqgWSCkynON2RGy2JEJbNNeCddMNhM67bLerF
         KwGCLCnf9/bzWXkGfdncfR+L/7rWwN0dA7C0B44jvqoHVTEVg1J45RF3DJyYMXoz127q
         N65iQkXetKQ7nXiw8pYA3CLPj1mJgX/8F/r2m7hb7vZXOPtuQEAqJ9zJg32e4M+uhfHD
         gIzy9QkYw1lIkQZ0oldspiLS8kK2Axd3aKN0tAiciuZMAZEG3uWIqD6sATPrmI+e4Zat
         ZS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1TUEBF7J1pmP1s04A7SQCK63MaBeS7pHTSwdINbY9n4=;
        b=6QtSTctedv5TG7bXGj3wKj3tPnxzc8S/eq/y31RKkx0IMSf1iG/3yS6ZKBPlkDDjxu
         aYhoa7FPSufNG/OBSNnGWsp2jthoykkA3c0pnOaQmPhFfZUQLb6WuqsLUN3zfCc3ALCY
         mqE4CpyasfjzvNNqYwHFHX774bRQxwLDmNHOymsZdjMxh45OUVpcwutEV3Ga1D4vqyXl
         pT2Uo70kg/ndBbWe4iCV1lXj1iNCMYhNg6cvMm+jkmK09vrCYwKp4pwHpoXPMo8+zAe0
         kUaoG/AG586qOHwDj8u+gVHafAfD7GMKITs23zSE2JkHAd21YoeXIV10jPH0cANfn4ai
         ZZcA==
X-Gm-Message-State: AOAM533Qsm1oIzfIWSScUcddZs+RNBF+btA+7IEZkXCKYWZjsSJd680h
        +i6PEkQNaBoxUNcCR7BV1NE=
X-Google-Smtp-Source: ABdhPJy9Ss+wzqKA5nnM92lPVH9bCuR/x4jwIQ/OyqTmBBVgU2RzOiI7hOTVaajuk4pfcYwxRuhyWQ==
X-Received: by 2002:a2e:9594:: with SMTP id w20mr17460826ljh.142.1636316415382;
        Sun, 07 Nov 2021 12:20:15 -0800 (PST)
Received: from localhost.localdomain ([37.45.143.17])
        by smtp.gmail.com with ESMTPSA id bp7sm1376564lfb.176.2021.11.07.12.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 12:20:15 -0800 (PST)
Received: from jek by localhost.localdomain with local (Exim 4.95)
        (envelope-from <jekhor@gmail.com>)
        id 1mjoeE-000ECm-DE;
        Sun, 07 Nov 2021 23:20:14 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH 1/4] bq25890_charger: Rename IILIM field to IINLIM
Date:   Sun,  7 Nov 2021 23:19:58 +0300
Message-Id: <20211107202001.54579-1-jekhor@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rename the Input Current Limit field in the REG00 from IILIM to IINLIM
accordingly with the bq2589x datasheet. This is just cosmetical change
to reduce confusion.

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
---
 drivers/power/supply/bq25890_charger.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 34ec186a2e9a..34467bfb9537 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -40,7 +40,7 @@ static const char *const bq25890_chip_name[] = {
 };
 
 enum bq25890_fields {
-	F_EN_HIZ, F_EN_ILIM, F_IILIM,				     /* Reg00 */
+	F_EN_HIZ, F_EN_ILIM, F_IINLIM,				     /* Reg00 */
 	F_BHOT, F_BCOLD, F_VINDPM_OFS,				     /* Reg01 */
 	F_CONV_START, F_CONV_RATE, F_BOOSTF, F_ICO_EN,
 	F_HVDCP_EN, F_MAXC_EN, F_FORCE_DPM, F_AUTO_DPDM_EN,	     /* Reg02 */
@@ -153,7 +153,7 @@ static const struct reg_field bq25890_reg_fields[] = {
 	/* REG00 */
 	[F_EN_HIZ]		= REG_FIELD(0x00, 7, 7),
 	[F_EN_ILIM]		= REG_FIELD(0x00, 6, 6),
-	[F_IILIM]		= REG_FIELD(0x00, 0, 5),
+	[F_IINLIM]		= REG_FIELD(0x00, 0, 5),
 	/* REG01 */
 	[F_BHOT]		= REG_FIELD(0x01, 6, 7),
 	[F_BCOLD]		= REG_FIELD(0x01, 5, 5),
@@ -256,7 +256,7 @@ enum bq25890_table_ids {
 	/* range tables */
 	TBL_ICHG,
 	TBL_ITERM,
-	TBL_IILIM,
+	TBL_IINLIM,
 	TBL_VREG,
 	TBL_BOOSTV,
 	TBL_SYSVMIN,
@@ -299,7 +299,7 @@ static const union {
 	/* TODO: BQ25896 has max ICHG 3008 mA */
 	[TBL_ICHG] =	{ .rt = {0,	  5056000, 64000} },	 /* uA */
 	[TBL_ITERM] =	{ .rt = {64000,   1024000, 64000} },	 /* uA */
-	[TBL_IILIM] =   { .rt = {100000,  3250000, 50000} },	 /* uA */
+	[TBL_IINLIM] =  { .rt = {100000,  3250000, 50000} },	 /* uA */
 	[TBL_VREG] =	{ .rt = {3840000, 4608000, 16000} },	 /* uV */
 	[TBL_BOOSTV] =	{ .rt = {4550000, 5510000, 64000} },	 /* uV */
 	[TBL_SYSVMIN] = { .rt = {3000000, 3700000, 100000} },	 /* uV */
@@ -503,11 +503,11 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 		break;
 
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
-		ret = bq25890_field_read(bq, F_IILIM);
+		ret = bq25890_field_read(bq, F_IINLIM);
 		if (ret < 0)
 			return ret;
 
-		val->intval = bq25890_find_val(ret, TBL_IILIM);
+		val->intval = bq25890_find_val(ret, TBL_IINLIM);
 		break;
 
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-- 
2.33.1

