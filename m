Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E96E0EC8E0
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 20:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfKATHj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 15:07:39 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:32878 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfKATHj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 15:07:39 -0400
Received: by mail-qk1-f193.google.com with SMTP id 71so11723515qkl.0
        for <linux-pm@vger.kernel.org>; Fri, 01 Nov 2019 12:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iZh3Z5MTmDVm4Ss7I93O+qDHyHAj+taMzuDCG4Cft3k=;
        b=jT+HZSjDBJzjsce+o2X7JiXpj5ujTH7NPxnQ1gBacbgBWnc7ECq6sBwKI/zrOeg8q6
         BAvPcV3oghEm2WJoDGtPjqVOtW9VJSbMWmzlcU2195pOasUciRENoVXjocTCl+4Ot4Lw
         Z7H6X6pCMNu8KUFz5nY0LsoDlMrp9Qv25i94NNXrPgt7aJZS/YLZYlBs17VHa8flW9xV
         uK3jMWxr+UttnN+I9c9yKglEAOKH54T9cti71fuxLLrTDCBZuCs8VQ1t1w8AjTdpi5VC
         TVX5X5wu4hWXjeY2xxCXGKNwgFmsKNCTrOEzD+Ghb67T9/Yf6PVi+3HlDIv4DlfSP57y
         DIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iZh3Z5MTmDVm4Ss7I93O+qDHyHAj+taMzuDCG4Cft3k=;
        b=NIK2WzqM6GTfE1+NNpcDwgUZYLxrdXU46O0ymld3AYk3LamX9/L7H+dN04gHIZkr3E
         iFraqBA6/sEcK6/6f4wkzFY9xBk4gg74mGd/6emMbX7p62fhQsFXofWCEKlzpEmMq9P/
         V46zHXzc9O6x4BF1Y0MDbYXpd24aZoUruUlNdYH4GpjSd8zWTkrrQNRzCwB9DeXklzFp
         Ah6Ojrli9hGGZKc2yfknIRE1CFW3MlW7TjOt7/9D2I3I5ZGIKIHfxiFSEHu2qeZuuF7A
         ZBn3mdzMPvZvQmsT0yIDFkmWGnBiz0Y1kDoPlkhBthjrZvNcBVU2tbuMOKk30UzW60YV
         Y3bg==
X-Gm-Message-State: APjAAAXIJT8vkb5i59h+WYjnEw2p7UhedbXUwAONvbXCS3fs2SXNZkr4
        zqZrQnY4HPHB9ubV1EoWX/U=
X-Google-Smtp-Source: APXvYqx3HmFbix6HjEcFQEbKWUHdF/SJlXjVYiD5tNntpxcVXOfsMZvSXcKDIBtktALStesjnCR78A==
X-Received: by 2002:a37:9083:: with SMTP id s125mr10337379qkd.192.1572635258335;
        Fri, 01 Nov 2019 12:07:38 -0700 (PDT)
Received: from jfddesk.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.gmail.com with ESMTPSA id d139sm5105905qkb.36.2019.11.01.12.07.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Nov 2019 12:07:37 -0700 (PDT)
From:   Jean-Francois Dagenais <jeff.dagenais@gmail.com>
To:     sre@kernel.org, linux-pm@vger.kernel.org
Cc:     Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Subject: [PATCH 6/7] power: supply: sbs-battery: add ability to disable charger broadcasts
Date:   Fri,  1 Nov 2019 15:07:04 -0400
Message-Id: <20191101190705.13393-6-jeff.dagenais@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101190705.13393-1-jeff.dagenais@gmail.com>
References: <20191101190705.13393-1-jeff.dagenais@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In certain designs, it is possible to add a battery on a populated i2c
bus without an sbs compliant charger. In that case, the battery will
un-necessarily and sometimes un-desirably master the bus trying to write
info in the charger.

It is observed in many occasion that these battery "broadcasts" are even
corrupting other ongoing master to slave communication. I.e. the
multi-master support in the battery is inadequate.

Thankfully, the CHARGER_MODE bit allows designers to disable that SBS
battery behaviour.

This needs to be done once when the battery is first seen on the bus.

Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
---
 drivers/power/supply/sbs-battery.c | 39 +++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 46c89dd05f46..fb116ab7752d 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -51,6 +51,7 @@ enum sbs_capacity_mode {
 	CAPACITY_MODE_AMPS = 0,
 	CAPACITY_MODE_WATTS = BATTERY_MODE_CAPACITY_MASK
 };
+#define BATTERY_MODE_CHARGER_MASK	(1<<14)
 
 /* manufacturer access defines */
 #define MANUFACTURER_ACCESS_STATUS	0x0006
@@ -157,6 +158,7 @@ struct sbs_info {
 	bool				is_present;
 	struct gpio_desc		*gpio_detect;
 	bool				enable_detection;
+	bool				charger_broadcasts;
 	int				last_state;
 	int				poll_time;
 	u32				i2c_retry_count;
@@ -596,6 +598,34 @@ static int sbs_get_property_index(struct i2c_client *client,
 	return -EINVAL;
 }
 
+static void sbs_disable_charger_broadcasts(struct sbs_info *chip)
+{
+	int val = sbs_read_word_data(chip->client, BATTERY_MODE_OFFSET);
+	if (val < 0)
+		goto exit;
+
+	val |= BATTERY_MODE_CHARGER_MASK;
+
+	val = sbs_write_word_data(chip->client, BATTERY_MODE_OFFSET, val);
+
+exit:
+	if (val < 0)
+		dev_err(&chip->client->dev,
+			"Failed to disable charger broadcasting: %d\n", val);
+	else
+		dev_dbg(&chip->client->dev, "%s\n", __func__);
+}
+
+static void sbs_set_is_present(struct sbs_info *chip, bool is_present)
+{
+	dev_dbg(&chip->client->dev, "%s %d\n", __func__, is_present);
+
+	if (!chip->is_present && is_present && !chip->charger_broadcasts)
+		sbs_disable_charger_broadcasts(chip);
+
+	chip->is_present = is_present;
+}
+
 static int sbs_get_property(struct power_supply *psy,
 	enum power_supply_property psp,
 	union power_supply_propval *val)
@@ -610,7 +640,7 @@ static int sbs_get_property(struct power_supply *psy,
 			return ret;
 		if (psp == POWER_SUPPLY_PROP_PRESENT) {
 			val->intval = ret;
-			chip->is_present = val->intval;
+			sbs_set_is_present(chip, val->intval);
 			return 0;
 		}
 		if (ret == 0)
@@ -706,7 +736,7 @@ static int sbs_get_property(struct power_supply *psy,
 
 	if (!chip->gpio_detect &&
 		chip->is_present != (ret >= 0)) {
-		chip->is_present = (ret >= 0);
+		sbs_set_is_present(chip, ret >= 0);
 		power_supply_changed(chip->power_supply);
 	}
 
@@ -737,7 +767,7 @@ static void sbs_supply_changed(struct sbs_info *chip)
 	ret = gpiod_get_value_cansleep(chip->gpio_detect);
 	if (ret < 0)
 		return;
-	chip->is_present = ret;
+	sbs_set_is_present(chip, ret);
 	power_supply_changed(battery);
 }
 
@@ -862,6 +892,9 @@ static int sbs_probe(struct i2c_client *client,
 	force_load = of_property_read_bool(client->dev.of_node,
 					   "sbs,force-load");
 
+	chip->charger_broadcasts = !of_property_read_bool(client->dev.of_node,
+					"sbs,disable-charger-broadcasts");
+
 	chip->gpio_detect = devm_gpiod_get_optional(&client->dev,
 			"sbs,battery-detect", GPIOD_IN);
 	if (IS_ERR(chip->gpio_detect)) {
-- 
2.23.0

