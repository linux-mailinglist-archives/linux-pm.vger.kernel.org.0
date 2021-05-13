Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB1037F119
	for <lists+linux-pm@lfdr.de>; Thu, 13 May 2021 04:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhEMCEX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 May 2021 22:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhEMCEW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 May 2021 22:04:22 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9E0C06174A
        for <linux-pm@vger.kernel.org>; Wed, 12 May 2021 19:03:12 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id y32so19843711pga.11
        for <linux-pm@vger.kernel.org>; Wed, 12 May 2021 19:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M8+hyB9GIQlDvwFh8SMyfBAJZeOaDTR/9FUQ/mylJJs=;
        b=f39FR++dOsOQrNnYM2XB47tSfDSGT7c4kQguzQxBLMevXY6aUxoF8AsaEvZ7is2c4G
         k+5vGMB+wiNqVHrjHGmep+UbjHBBvKz0geQQf8V7+aOPCFeUiZJhN0D+85rJyrt6AWrd
         OjH/0B5jd3+JHc1B2m1gncUt3lGYY2Wmfin2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M8+hyB9GIQlDvwFh8SMyfBAJZeOaDTR/9FUQ/mylJJs=;
        b=dhIdwbgIJWZ7C4Cfmfrhk+Z6VlMKEVfDb6JeReA6cMAtBiJK/jPi/1RuhtC3oh4iD4
         Pd5qAl83sqHudvPu1yHl/IBvgpGsk4ptl/siha1l9RuKVooG0tm5xBlMfAXj0iz95rsd
         OECr1ZG8yzPT+g5E7nWOfr1D5XE8Ih4cqq7NnEG8fLyLcB1mLAiyqFOsQaTTF17f3cwU
         Jn7Zzhix1ki3NY+0kXjYULe6uZjJuTb3vPYSQS3Y7cF+LnGYKE9921Kd/2LdH87vl+fZ
         D8cAffOJzEU3ZxycyRNzLjKtxOPSNjs40y66U+sAj/BTlDj+nX0zHI3GR/fqo8XNYKuo
         9XCw==
X-Gm-Message-State: AOAM533l4LWUmsUPs6WXXIQlE2EHgwwK7OA6vcn0zmsc/GsOaktsQ65N
        3pFwYxb7zrT7k93sbtcd7P3ClUvTrIB9jWPl
X-Google-Smtp-Source: ABdhPJyjnVZNGRhQu3IXGOsixW7SYeqsO810nlQSLg8S/eW/Y9RWs/NJAi1oW0UFqs838HypFmY72A==
X-Received: by 2002:a17:90a:aa12:: with SMTP id k18mr1813632pjq.232.1620871391989;
        Wed, 12 May 2021 19:03:11 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:b:89f7:4c87:b447:da22])
        by smtp.gmail.com with ESMTPSA id d22sm5490495pjr.2.2021.05.12.19.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 19:03:11 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Cc:     Hsinyi Wang <hsinyi@chromium.org>, Ikjoon Jang <ikjn@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2] power: supply: sbs-battery: cache constant string properties
Date:   Thu, 13 May 2021 10:03:08 +0800
Message-Id: <20210513020308.4011440-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
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
Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>

---
Resend v2: Adds Tested-by, escape from v1 mail thread.

Changes in v2:
- change function name of sbs_get_battery_string_property()
  to sbs_get_constant_string()
- use cached string properties
- use cached technology value in sbs_get_chemistry()

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
2.31.1.607.g51e8a6a459-goog

