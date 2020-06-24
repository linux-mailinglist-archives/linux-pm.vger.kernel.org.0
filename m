Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2006520781B
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 17:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404702AbgFXP5B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 11:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404689AbgFXP47 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2020 11:56:59 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58577C061573;
        Wed, 24 Jun 2020 08:56:59 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o8so2802509wmh.4;
        Wed, 24 Jun 2020 08:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=80gOEq+4vV68l5JEUAv0IDzq9mGAutACW4LOSgtaLPE=;
        b=eH6hc4poZm7L6v5VJ0fVumcBsBD8Tt3pbds/zBBgOnJfxMTONIf+yYAVXUKr3gIP3E
         mqUkzVt0eR0RcXXUBwvdVa2LWF5khvHPj9yQsdph9rpglv4JRI4X/QWwoyjMu57ZO+vW
         wz5qPk5RxyE2uU1D0DTmUC4ZouPNIWdIbb66WfESoftOmh14dEBmZwC9RkIe6zxbfEL6
         /Tv93ffIhM/VWsugWpKxSn7pI1u6j4WEhR0V3A7WaY5jjkBlCMgJsHhkAWb/xn2J9wV4
         OoIt+fiWU96Qr/+h8q+xno9RbIG44ly/Yxy2JKz1YhnY/9dYeoM1aM4Nk8cRxt2I66ZO
         AfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=80gOEq+4vV68l5JEUAv0IDzq9mGAutACW4LOSgtaLPE=;
        b=TKV+3I0bacZbKWflH5U97hiVXEkCLzDywDBMBNidDdHJT/6jawUiPKECCUBtF3SeZA
         O/999wHwvW7g4LE6dKXlaLcLboGBq+CoJpE4WRpORUsqGKkqH4NLuhfKOApM4SPfBtQb
         Nc8ge0QZ3lHbDj01QG/zrZkd8EKsGeGczJzu/CO1yHd4AlsUbfCMoyckAFdMMfbhJV2u
         eadej0z9MEKI2H668ItylMIOOb2ozOIl4mcNLNiY5u25Eif7N3ITzeClXiXcNtJhrdIb
         qmPC8sImIHO4T560HZfymuDFkoI7JmVKZf0GD3622xp7pTI6v/OsyJhs3L+i5uJZO8iW
         gYhw==
X-Gm-Message-State: AOAM530jUi2dO7CI3RtbLJanjr30E43dnfN5GqWr1vceRPb7mwEArJb9
        GBCiwEtnDO7hjqitl4F7LQE=
X-Google-Smtp-Source: ABdhPJxCfskuYRltzYNe2//1NHtG31NFZV1t1uvd2ex00hBZGgqntk8JN6kx5pgt4tLBzAqp1eMPIA==
X-Received: by 2002:a1c:dfd6:: with SMTP id w205mr11889185wmg.118.1593014218050;
        Wed, 24 Jun 2020 08:56:58 -0700 (PDT)
Received: from localhost ([213.191.183.145])
        by smtp.gmail.com with ESMTPSA id x5sm8926774wmg.2.2020.06.24.08.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 08:56:57 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Bakker <xc-racer2@live.ca>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH v3 5/6] power: supply: max17040: Support setting rcomp
Date:   Wed, 24 Jun 2020 18:56:32 +0300
Message-Id: <20200624155633.3557401-6-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200624155633.3557401-1-iskren.chernev@gmail.com>
References: <20200624155633.3557401-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Maxim ModelGauge family supports fine-tuning by setting
a compensation value (named rcomp in the docs). The value is affected by
battery chemistry and ambient temperature.

Add support for reading maxim,rcomp from DT and configuring the device
with the supplied value. Temperature adjustment is not implemented, because
there is no provision for receiving the ambient temperature.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 drivers/power/supply/max17040_battery.c | 40 +++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index a6ecd84194e51..54393f411211e 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -30,9 +30,11 @@
 
 #define MAX17040_DELAY		1000
 #define MAX17040_BATTERY_FULL	95
+#define MAX17040_RCOMP_DEFAULT  0x9700
 
 #define MAX17040_ATHD_MASK		0x3f
 #define MAX17040_ATHD_DEFAULT_POWER_UP	4
+#define MAX17040_CFG_RCOMP_MASK		0xff00
 
 enum chip_id {
 	ID_MAX17040,
@@ -52,6 +54,7 @@ struct chip_data {
 	u16 vcell_mul;
 	u16 vcell_div;
 	u8  has_low_soc_alert;
+	u8  rcomp_bytes;
 };
 
 static struct chip_data max17040_family[] = {
@@ -61,6 +64,7 @@ static struct chip_data max17040_family[] = {
 		.vcell_mul = 1250,
 		.vcell_div = 1,
 		.has_low_soc_alert = 0,
+		.rcomp_bytes = 2,
 	},
 	[ID_MAX17041] = {
 		.reset_val = 0x0054,
@@ -68,6 +72,7 @@ static struct chip_data max17040_family[] = {
 		.vcell_mul = 2500,
 		.vcell_div = 1,
 		.has_low_soc_alert = 0,
+		.rcomp_bytes = 2,
 	},
 	[ID_MAX17043] = {
 		.reset_val = 0x0054,
@@ -75,6 +80,7 @@ static struct chip_data max17040_family[] = {
 		.vcell_mul = 1250,
 		.vcell_div = 1,
 		.has_low_soc_alert = 1,
+		.rcomp_bytes = 1,
 	},
 	[ID_MAX17044] = {
 		.reset_val = 0x0054,
@@ -82,6 +88,7 @@ static struct chip_data max17040_family[] = {
 		.vcell_mul = 2500,
 		.vcell_div = 1,
 		.has_low_soc_alert = 1,
+		.rcomp_bytes = 1,
 	},
 	[ID_MAX17048] = {
 		.reset_val = 0x5400,
@@ -89,6 +96,7 @@ static struct chip_data max17040_family[] = {
 		.vcell_mul = 625,
 		.vcell_div = 8,
 		.has_low_soc_alert = 1,
+		.rcomp_bytes = 1,
 	},
 	[ID_MAX17049] = {
 		.reset_val = 0x5400,
@@ -96,6 +104,7 @@ static struct chip_data max17040_family[] = {
 		.vcell_mul = 625,
 		.vcell_div = 4,
 		.has_low_soc_alert = 1,
+		.rcomp_bytes = 1,
 	},
 	[ID_MAX17058] = {
 		.reset_val = 0x5400,
@@ -103,6 +112,7 @@ static struct chip_data max17040_family[] = {
 		.vcell_mul = 625,
 		.vcell_div = 8,
 		.has_low_soc_alert = 1,
+		.rcomp_bytes = 1,
 	},
 	[ID_MAX17059] = {
 		.reset_val = 0x5400,
@@ -110,6 +120,7 @@ static struct chip_data max17040_family[] = {
 		.vcell_mul = 625,
 		.vcell_div = 4,
 		.has_low_soc_alert = 1,
+		.rcomp_bytes = 1,
 	},
 };
 
@@ -129,6 +140,8 @@ struct max17040_chip {
 	u32 low_soc_alert;
 	/* some devices return twice the capacity */
 	bool quirk_double_soc;
+	/* higher 8 bits for 17043+, 16 bits for 17040,41 */
+	u16 rcomp;
 };
 
 static int max17040_reset(struct max17040_chip *chip)
@@ -143,6 +156,14 @@ static int max17040_set_low_soc_alert(struct max17040_chip *chip, u32 level)
 			MAX17040_ATHD_MASK, level);
 }
 
+static int max17040_set_rcomp(struct max17040_chip *chip, u16 rcomp)
+{
+	u16 mask = chip->data.rcomp_bytes == 2 ?
+		0xffff : MAX17040_CFG_RCOMP_MASK;
+
+	return regmap_update_bits(chip->regmap, MAX17040_CONFIG, mask, rcomp);
+}
+
 static int max17040_raw_vcell_to_uvolts(struct max17040_chip *chip, u16 vcell)
 {
 	struct chip_data *d = &chip->data;
@@ -206,6 +227,10 @@ static int max17040_get_status(struct max17040_chip *chip)
 static int max17040_get_of_data(struct max17040_chip *chip)
 {
 	struct device *dev = &chip->client->dev;
+	struct chip_data *data = &max17040_family[
+		(enum chip_id) of_device_get_match_data(dev)];
+	int rcomp_len;
+	u8 rcomp[2];
 
 	chip->low_soc_alert = MAX17040_ATHD_DEFAULT_POWER_UP;
 	device_property_read_u32(dev,
@@ -219,6 +244,19 @@ static int max17040_get_of_data(struct max17040_chip *chip)
 	chip->quirk_double_soc = device_property_read_bool(dev,
 							   "maxim,double-soc");
 
+	rcomp_len = device_property_count_u8(dev, "maxim,rcomp");
+	chip->rcomp = MAX17040_RCOMP_DEFAULT;
+	if (rcomp_len == data->rcomp_bytes) {
+		device_property_read_u8_array(dev, "maxim,rcomp",
+					      rcomp, rcomp_len);
+		chip->rcomp = rcomp_len == 2 ?
+			rcomp[0] << 8 | rcomp[1] :
+			rcomp[0] << 8;
+	} else if (rcomp_len > 0) {
+		dev_err(dev, "maxim,rcomp has incorrect length\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -385,6 +423,8 @@ static int max17040_probe(struct i2c_client *client,
 	if (chip_id == ID_MAX17040 || chip_id == ID_MAX17041)
 		max17040_reset(chip);
 
+	max17040_set_rcomp(chip, chip->rcomp);
+
 	/* check interrupt */
 	if (client->irq && chip->data.has_low_soc_alert) {
 		ret = max17040_set_low_soc_alert(chip, chip->low_soc_alert);
-- 
2.27.0

