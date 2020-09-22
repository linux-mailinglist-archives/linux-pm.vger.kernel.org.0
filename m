Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A052274145
	for <lists+linux-pm@lfdr.de>; Tue, 22 Sep 2020 13:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgIVLrm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Sep 2020 07:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgIVLnr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2020 07:43:47 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD17CC0613D4;
        Tue, 22 Sep 2020 04:43:37 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q9so2995815wmj.2;
        Tue, 22 Sep 2020 04:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cpuUSD6KttTTfIHYtSt4rdy8AyWkjJ1Dhlp/ln9/l64=;
        b=glQmQ+ZGpKW3uC7+ICa+TW90LtAE7rM/MdXE1KRmaQXZzzXy4fTv0lSu1C8FE3LP4Z
         7NwnWwFpOT50pR8AvPZ8JC/PVjKp2VgfuXaBBxqCqGN9DRTESCAJtkiIzM2sOfB/juKm
         a4PcBEIUkfIDv6dxuBdJaUelwx4qGzHytiC4Wg1wykHsyLNsUdioA3Dk68TvcHTBx7MU
         slpovtibr7moJ5YShp84W7iVfqf6e7lS026pN9/ii8BhrhIQMNAMzJ9vj35LjLLzz0Pg
         ZVGtHI9TmZuxvN3zbrMd105yr6LYBq7IVfInEP8q16aJb1PzvPB8lCN59uHetvUDaiI0
         dHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cpuUSD6KttTTfIHYtSt4rdy8AyWkjJ1Dhlp/ln9/l64=;
        b=cwjqdQaGDbIVA3NXkPA7Q0tuVmjY02supzqon6S19Tf/Bn16mFmpcfjwUwpSS1/HyI
         pXQoTV/xYdNGciuTZgyIaWZ73xOuuk4KvVupNsuU7TICfHAvbbHO2A9YxKQfG5DkGp9u
         dQckrBo4wFcvjK8Qg3EwrW+nUg4qi8/oyDn6R2UJ6OVVNWCCUBzNxDrdSDKkKRpEpRn3
         NZSO0JAmPPzI5CzPBhKYDxIGzPwY040NtoCqzC+cDhNdV2aSWlHwnlElcjfdA1G1K7vZ
         JyenocUXsfuQd9aQfsgYaStFr+QQO4+qKKgxqhsHY72OdAX0d2gOwXz26tqq5GYsQZoX
         4L7Q==
X-Gm-Message-State: AOAM530g8aOZy7LLtTSxNQrQoPUr0Mk9ZEqur7NqEM0p18sbI9k7HK67
        75oRpj21d+6FjY3BX+yIL3o=
X-Google-Smtp-Source: ABdhPJy0VOr/ET6wDlyCbmx7HovYusYcVB2qJanSRQ6AzGmT2j1EVVfAhrp7J3QYjDq3mgz4jA6xVg==
X-Received: by 2002:a7b:c192:: with SMTP id y18mr571089wmi.108.1600775016556;
        Tue, 22 Sep 2020 04:43:36 -0700 (PDT)
Received: from localhost (178-169-161-196.razgrad.ddns.bulsat.com. [178.169.161.196])
        by smtp.gmail.com with ESMTPSA id y5sm4301708wmg.21.2020.09.22.04.43.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 04:43:35 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Bakker <xc-racer2@live.ca>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH v5 6/7] power: supply: max17040: Support setting rcomp
Date:   Tue, 22 Sep 2020 14:42:36 +0300
Message-Id: <20200922114237.1803628-7-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922114237.1803628-1-iskren.chernev@gmail.com>
References: <20200922114237.1803628-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Maxim ModelGauge family supports fine-tuning by setting
a compensation value (named rcomp in the docs). The value is affected by
battery chemistry and ambient temperature.

Add support for reading maxim,rcomp from DT and configuring the device
with the supplied value. Temperature adjustment is not implemented at
the moment, because there is no provision for receiving the ambient
temperature at the moment.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
Tested-by: Jonathan Bakker <xc-racer2@live.ca>
---
 drivers/power/supply/max17040_battery.c | 40 +++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 4bcec86d92098..ae39ca5c6753e 100644
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
 
 	chip->quirk_double_soc = device_property_read_bool(dev,
 							   "maxim,double-soc");
@@ -221,6 +246,19 @@ static int max17040_get_of_data(struct max17040_chip *chip)
 		return -EINVAL;
 	}
 
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
 
@@ -430,6 +468,8 @@ static int max17040_probe(struct i2c_client *client,
 	if (chip_id == ID_MAX17040 || chip_id == ID_MAX17041)
 		max17040_reset(chip);
 
+	max17040_set_rcomp(chip, chip->rcomp);
+
 	/* check interrupt */
 	if (client->irq && chip->data.has_low_soc_alert) {
 		ret = max17040_set_low_soc_alert(chip, chip->low_soc_alert);
-- 
2.28.0

