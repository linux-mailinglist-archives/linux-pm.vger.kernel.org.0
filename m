Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAD636D113
	for <lists+linux-pm@lfdr.de>; Wed, 28 Apr 2021 06:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhD1EIz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Apr 2021 00:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhD1EIz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Apr 2021 00:08:55 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B20AC06175F
        for <linux-pm@vger.kernel.org>; Tue, 27 Apr 2021 21:08:11 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 10so294689pfl.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Apr 2021 21:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=49Tw5cUJuX6oeFz3PRwhMmj9KjPAeUSyIE1t+N81mMw=;
        b=mezUmNSD/qK2Y7plx/lic4P4bFXVROSkMcyEz603lJAYpVY+GHgCiZiaExnV0yLT2t
         KkVe+AkOJO7UAjvckTN9mg+kGPYDVAL3QvWnK4P7lqE2L1GCQnikA4p/VXNYY78ysh1R
         Ake87yCYofQOsJvSNuGwk+RAwneOl8ZJcwUvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=49Tw5cUJuX6oeFz3PRwhMmj9KjPAeUSyIE1t+N81mMw=;
        b=WxtD1HUcvfdaNEju8e9jXUt6eUUV+0Fc494Y9oRej32P3sClyv5TrKvx9+ywriZgU3
         2BllqqKQ1ttF8JWzpi4pzPHgazISw9RSbEKyEM+LKzgsgv8Q8BmjGZvK5Z9sX7KwFIzJ
         L3ctyXu5yGWL/dDnE+8PMJ3NYnMvaKjzJP9sV583z8q+WHZ1BmQ1FXlneyb3BCKXFe/E
         ZJnJrMGFzUuBa03YBpAHXObXWOUSgISKnAvO/kUbaEghnvtgkxC/FNa3v0zEPxIqL9c4
         ATvdkXsRNYp50a77MtBoB4eG+3H8OuCc+1B4CNZa++TvMhAJvAdRGxNoMbaqDug/3Nty
         M1UA==
X-Gm-Message-State: AOAM530jjtRdWAcdsAe8A0rX5mGRKxcwtV4977Uly7HGmDOyJ7r6VGld
        vQJeaHiqkA7b3nMptcdsbi3q1QEG8W7jrY7u
X-Google-Smtp-Source: ABdhPJwsPXokv0v7xVnwkd4bBIwSyXspCw2a8jEgXWEBmznSz6rNWnrSxWbDyroy2mAe1pwaPpNsyw==
X-Received: by 2002:a62:8f4a:0:b029:241:fc67:d425 with SMTP id n71-20020a628f4a0000b0290241fc67d425mr27207113pfd.21.1619582890582;
        Tue, 27 Apr 2021 21:08:10 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:b:4cea:d9a4:e0be:d3f6])
        by smtp.gmail.com with ESMTPSA id f1sm3456803pjt.50.2021.04.27.21.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 21:08:10 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Cc:     Hsinyi Wang <hsinyi@chromium.org>, Ikjoon Jang <ikjn@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] power: supply: sbs-battery: cache constant string properties
Date:   Wed, 28 Apr 2021 12:08:02 +0800
Message-Id: <20210428040802.3266187-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210427093754.3000087-1-ikjn@chromium.org>
References: <20210427093754.3000087-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently sbs-battery supports three string properties -
manufacturer, model_name, and chemistry. Buffers for those
properties are currently defined as global variables.

This patch moves those global variables into struct sbs_info
and cache/reuse them as they are all constant values.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>

---

Changes in v2:
- change function name of sbs_get_battery_string_property()
  to sbs_get_constant_string()
- use cached string properties
- use cached technology integer value in sbs_get_chemistry()

 drivers/power/supply/sbs-battery.c | 140 +++++++++++++++++------------
 1 file changed, 82 insertions(+), 58 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 4bf92831cb06..414de9bc47bf 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -188,6 +188,14 @@ static const enum power_supply_property sbs_properties[] = {
 /* Supports special manufacturer commands from TI BQ20Z65 and BQ20Z75 IC. */
 #define SBS_FLAGS_TI_BQ20ZX5		BIT(0)
 
+static const enum power_supply_property string_properties[] = {
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+};
+
+#define NR_STRING_BUFFERS	ARRAY_SIZE(string_properties)
+
 struct sbs_info {
 	struct i2c_client		*client;
 	struct power_supply		*power_supply;
@@ -201,11 +209,22 @@ struct sbs_info {
 	struct delayed_work		work;
 	struct mutex			mode_lock;
 	u32				flags;
+	int				technology;
+	char				strings[NR_STRING_BUFFERS][I2C_SMBUS_BLOCK_MAX + 1];
 };
 
-static char model_name[I2C_SMBUS_BLOCK_MAX + 1];
-static char manufacturer[I2C_SMBUS_BLOCK_MAX + 1];
-static char chemistry[I2C_SMBUS_BLOCK_MAX + 1];
+static char *sbs_get_string_buf(struct sbs_info *chip,
+				enum power_supply_property psp)
+{
+	int i = 0;
+
+	for (i = 0; i < NR_STRING_BUFFERS; i++)
+		if (string_properties[i] == psp)
+			return chip->strings[i];
+
+	return ERR_PTR(-EINVAL);
+}
+
 static bool force_load;
 
 static int sbs_read_word_data(struct i2c_client *client, u8 address);
@@ -639,17 +658,45 @@ static int sbs_get_battery_property(struct i2c_client *client,
 	return 0;
 }
 
-static int sbs_get_battery_string_property(struct i2c_client *client,
-	int reg_offset, enum power_supply_property psp, char *val)
+static int sbs_get_property_index(struct i2c_client *client,
+	enum power_supply_property psp)
 {
-	s32 ret;
+	int count;
+
+	for (count = 0; count < ARRAY_SIZE(sbs_data); count++)
+		if (psp == sbs_data[count].psp)
+			return count;
 
-	ret = sbs_read_string_data(client, sbs_data[reg_offset].addr, val);
+	dev_warn(&client->dev,
+		"%s: Invalid Property - %d\n", __func__, psp);
 
-	if (ret < 0)
-		return ret;
+	return -EINVAL;
+}
 
-	return 0;
+static const char *sbs_get_constant_string(struct sbs_info *chip,
+			enum power_supply_property psp)
+{
+	int ret;
+	char *buf;
+	u8 addr;
+
+	buf = sbs_get_string_buf(chip, psp);
+	if (IS_ERR(buf))
+		return buf;
+
+	if (!buf[0]) {
+		ret = sbs_get_property_index(chip->client, psp);
+		if (ret < 0)
+			return ERR_PTR(ret);
+
+		addr = sbs_data[ret].addr;
+
+		ret = sbs_read_string_data(chip->client, addr, buf);
+		if (ret < 0)
+			return ERR_PTR(ret);
+	}
+
+	return buf;
 }
 
 static void  sbs_unit_adjustment(struct i2c_client *client,
@@ -772,48 +819,34 @@ static int sbs_get_battery_serial_number(struct i2c_client *client,
 	return 0;
 }
 
-static int sbs_get_property_index(struct i2c_client *client,
-	enum power_supply_property psp)
-{
-	int count;
-	for (count = 0; count < ARRAY_SIZE(sbs_data); count++)
-		if (psp == sbs_data[count].psp)
-			return count;
-
-	dev_warn(&client->dev,
-		"%s: Invalid Property - %d\n", __func__, psp);
-
-	return -EINVAL;
-}
-
-static int sbs_get_chemistry(struct i2c_client *client,
+static int sbs_get_chemistry(struct sbs_info *chip,
 		union power_supply_propval *val)
 {
-	enum power_supply_property psp = POWER_SUPPLY_PROP_TECHNOLOGY;
-	int ret;
+	const char *chemistry;
 
-	ret = sbs_get_property_index(client, psp);
-	if (ret < 0)
-		return ret;
+	if (chip->technology >= POWER_SUPPLY_TECHNOLOGY_UNKNOWN)
+		return chip->technology;
 
-	ret = sbs_get_battery_string_property(client, ret, psp,
-					      chemistry);
-	if (ret < 0)
-		return ret;
+	chemistry = sbs_get_constant_string(chip, POWER_SUPPLY_PROP_TECHNOLOGY);
+
+	if (IS_ERR(chemistry))
+		return PTR_ERR(chemistry);
 
 	if (!strncasecmp(chemistry, "LION", 4))
-		val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
+		chip->technology = POWER_SUPPLY_TECHNOLOGY_LION;
 	else if (!strncasecmp(chemistry, "LiP", 3))
-		val->intval = POWER_SUPPLY_TECHNOLOGY_LIPO;
+		chip->technology = POWER_SUPPLY_TECHNOLOGY_LIPO;
 	else if (!strncasecmp(chemistry, "NiCd", 4))
-		val->intval = POWER_SUPPLY_TECHNOLOGY_NiCd;
+		chip->technology = POWER_SUPPLY_TECHNOLOGY_NiCd;
 	else if (!strncasecmp(chemistry, "NiMH", 4))
-		val->intval = POWER_SUPPLY_TECHNOLOGY_NiMH;
+		chip->technology = POWER_SUPPLY_TECHNOLOGY_NiMH;
 	else
-		val->intval = POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
+		chip->technology = POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
 
-	if (val->intval == POWER_SUPPLY_TECHNOLOGY_UNKNOWN)
-		dev_warn(&client->dev, "Unknown chemistry: %s\n", chemistry);
+	if (chip->technology == POWER_SUPPLY_TECHNOLOGY_UNKNOWN)
+		dev_warn(&chip->client->dev, "Unknown chemistry: %s\n", chemistry);
+
+	val->intval = chip->technology;
 
 	return 0;
 }
@@ -857,6 +890,7 @@ static int sbs_get_property(struct power_supply *psy,
 	int ret = 0;
 	struct sbs_info *chip = power_supply_get_drvdata(psy);
 	struct i2c_client *client = chip->client;
+	const char *str;
 
 	if (chip->gpio_detect) {
 		ret = gpiod_get_value_cansleep(chip->gpio_detect);
@@ -882,7 +916,7 @@ static int sbs_get_property(struct power_supply *psy,
 		break;
 
 	case POWER_SUPPLY_PROP_TECHNOLOGY:
-		ret = sbs_get_chemistry(client, val);
+		ret = sbs_get_chemistry(chip, val);
 		if (ret < 0)
 			break;
 
@@ -934,23 +968,12 @@ static int sbs_get_property(struct power_supply *psy,
 		break;
 
 	case POWER_SUPPLY_PROP_MODEL_NAME:
-		ret = sbs_get_property_index(client, psp);
-		if (ret < 0)
-			break;
-
-		ret = sbs_get_battery_string_property(client, ret, psp,
-						      model_name);
-		val->strval = model_name;
-		break;
-
 	case POWER_SUPPLY_PROP_MANUFACTURER:
-		ret = sbs_get_property_index(client, psp);
-		if (ret < 0)
-			break;
-
-		ret = sbs_get_battery_string_property(client, ret, psp,
-						      manufacturer);
-		val->strval = manufacturer;
+		str = sbs_get_constant_string(chip, psp);
+		if (IS_ERR(str))
+			ret = PTR_ERR(str);
+		else
+			val->strval = str;
 		break;
 
 	case POWER_SUPPLY_PROP_MANUFACTURE_YEAR:
@@ -1097,6 +1120,7 @@ static int sbs_probe(struct i2c_client *client)
 	psy_cfg.of_node = client->dev.of_node;
 	psy_cfg.drv_data = chip;
 	chip->last_state = POWER_SUPPLY_STATUS_UNKNOWN;
+	chip->technology = -1;
 	mutex_init(&chip->mode_lock);
 
 	/* use pdata if available, fall back to DT properties,
-- 
2.31.1.498.g6c1eba8ee3d-goog

