Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE870390FF9
	for <lists+linux-pm@lfdr.de>; Wed, 26 May 2021 07:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhEZF05 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 May 2021 01:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbhEZF04 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 May 2021 01:26:56 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0278AC061756
        for <linux-pm@vger.kernel.org>; Tue, 25 May 2021 22:25:26 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id m8-20020a17090a4148b029015fc5d36343so249287pjg.1
        for <linux-pm@vger.kernel.org>; Tue, 25 May 2021 22:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eJFW00mb9mYnDtYc4HI2my6FoItfhdCpMtXGXBpZoHs=;
        b=V/aIL+TREgFCQD39BopzXhgQ6qhWMDa773A1PY1wj854VHKWc+0f21KH8+p8HjA7wL
         Oz0GfzsZJ2BOXY9kTUiWrHqi5vVzQIBr/o8HIV3nczKQCsxKmsET+dzX193/lYj5ivBF
         S6M01fK5GBANRBX5r+VvQdHeYyXB83qhyHsWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eJFW00mb9mYnDtYc4HI2my6FoItfhdCpMtXGXBpZoHs=;
        b=oOT8Ivav2s9Sr2lxct0JkqTGAf4mgqJvG15OLgDRMKrwcH14WI7CehFp1QqaIg78Rx
         VnN1xq69/x/9MimAqmi6BVm462op30wQWg3ZApHezjB/dWG6MmGGd8XDXIJayIrpCfIt
         J3IDF0Mfqsi73MoNHhNpKPYe+tjGpjeTWZyqhQ7TyvYj/pL7w9QUzdc1eV4feVy4/45U
         XuZOejyr+Dt2IEjH/DCnsEMK2y/lCdhGjXAaGRXzFJyfrujcVuryb89gwwsAnRKqIXWg
         Fv/qg4PIJKY5yk7u/L9WMbZd92cijhvHwdalLXPGWO0NolxNBFBiMn8F1D/kZo+iiy8V
         Za2w==
X-Gm-Message-State: AOAM530ewDGkW4NT2r0dufeyGgyQxgqwrIUxm4sFNY0Jk71Zn6Knlxs4
        1lgSKrA7TCw7OYblUkXvJ0mTvAhcE8F4yg==
X-Google-Smtp-Source: ABdhPJwy6PaNMbTTH+YiVmRtph3q/8QuqbZFoF9AS2EW6r0UiZ3S44xLXz6ExsmUuSuhYQU5K6x5ZA==
X-Received: by 2002:a17:902:ee8b:b029:ef:ab33:b835 with SMTP id a11-20020a170902ee8bb02900efab33b835mr33927346pld.27.1622006725092;
        Tue, 25 May 2021 22:25:25 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:b:37d6:8e9f:c791:4d9])
        by smtp.gmail.com with ESMTPSA id z5sm14667681pfa.172.2021.05.25.22.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 22:25:24 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Cc:     Hsinyi Wang <hsinyi@chromium.org>, Ikjoon Jang <ikjn@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] power: supply: sbs-battery: cache constant string properties
Date:   Wed, 26 May 2021 13:25:20 +0800
Message-Id: <20210526132509.v3.1.I446881dabe094fff375847593be87ec2624f587f@changeid>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
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

Changes in v3:
- Invalidate cached properties upon update_presence(!present)
- Fix a bug in reading chemistry

Changes in v2:
- change function name of sbs_get_battery_string_property()
  to sbs_get_constant_string()
- use cached string properties
- use cached technology value in sbs_get_chemistry()

 drivers/power/supply/sbs-battery.c | 153 ++++++++++++++++++-----------
 1 file changed, 95 insertions(+), 58 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index b6a538ebb378..56eaef8c32fc 100644
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
@@ -201,11 +209,32 @@ struct sbs_info {
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
+static void sbs_invalidate_cached_props(struct sbs_info *chip)
+{
+	int i = 0;
+
+	chip->technology = -1;
+
+	for (i = 0; i < NR_STRING_BUFFERS; i++)
+		if (chip->strings[i][0] = 0;
+}
+
 static bool force_load;
 
 static int sbs_read_word_data(struct i2c_client *client, u8 address);
@@ -243,6 +272,7 @@ static int sbs_update_presence(struct sbs_info *chip, bool is_present)
 		chip->is_present = false;
 		/* Disable PEC when no device is present */
 		client->flags &= ~I2C_CLIENT_PEC;
+		sbs_invalidate_cached_props(chip);
 		return 0;
 	}
 
@@ -639,17 +669,45 @@ static int sbs_get_battery_property(struct i2c_client *client,
 	return 0;
 }
 
-static int sbs_get_battery_string_property(struct i2c_client *client,
-	int reg_offset, enum power_supply_property psp, char *val)
+static int sbs_get_property_index(struct i2c_client *client,
+	enum power_supply_property psp)
 {
-	s32 ret;
+	int count;
 
-	ret = sbs_read_string_data(client, sbs_data[reg_offset].addr, val);
+	for (count = 0; count < ARRAY_SIZE(sbs_data); count++)
+		if (psp == sbs_data[count].psp)
+			return count;
 
-	if (ret < 0)
-		return ret;
+	dev_warn(&client->dev,
+		"%s: Invalid Property - %d\n", __func__, psp);
 
-	return 0;
+	return -EINVAL;
+}
+
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
@@ -772,48 +830,36 @@ static int sbs_get_battery_serial_number(struct i2c_client *client,
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
+	if (chip->technology != -1) {
+		val->intval = chip->technology;
+		return 0;
+	}
 
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
+
+	if (chip->technology == POWER_SUPPLY_TECHNOLOGY_UNKNOWN)
+		dev_warn(&chip->client->dev, "Unknown chemistry: %s\n", chemistry);
 
-	if (val->intval == POWER_SUPPLY_TECHNOLOGY_UNKNOWN)
-		dev_warn(&client->dev, "Unknown chemistry: %s\n", chemistry);
+	val->intval = chip->technology;
 
 	return 0;
 }
@@ -857,6 +903,7 @@ static int sbs_get_property(struct power_supply *psy,
 	int ret = 0;
 	struct sbs_info *chip = power_supply_get_drvdata(psy);
 	struct i2c_client *client = chip->client;
+	const char *str;
 
 	if (chip->gpio_detect) {
 		ret = gpiod_get_value_cansleep(chip->gpio_detect);
@@ -882,7 +929,7 @@ static int sbs_get_property(struct power_supply *psy,
 		break;
 
 	case POWER_SUPPLY_PROP_TECHNOLOGY:
-		ret = sbs_get_chemistry(client, val);
+		ret = sbs_get_chemistry(chip, val);
 		if (ret < 0)
 			break;
 
@@ -934,23 +981,12 @@ static int sbs_get_property(struct power_supply *psy,
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
@@ -1097,6 +1133,7 @@ static int sbs_probe(struct i2c_client *client)
 	psy_cfg.of_node = client->dev.of_node;
 	psy_cfg.drv_data = chip;
 	chip->last_state = POWER_SUPPLY_STATUS_UNKNOWN;
+	sbs_invalidate_cached_props(chip);
 	mutex_init(&chip->mode_lock);
 
 	/* use pdata if available, fall back to DT properties,
-- 
2.31.1.818.g46aad6cb9e-goog

