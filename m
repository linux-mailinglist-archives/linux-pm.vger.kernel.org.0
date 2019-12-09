Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7931165B2
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 04:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfLID5Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Dec 2019 22:57:25 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33781 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfLID5Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 8 Dec 2019 22:57:25 -0500
Received: by mail-pj1-f66.google.com with SMTP id r67so5276640pjb.0;
        Sun, 08 Dec 2019 19:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=k5+zjDRRhhqO491xHEoAU6VTv+EQua9/0+Lq9coQ6dc=;
        b=KdP+ABq+8Z0LzLBnD+4dkYtV2EJBlYa8pgmDg/uSP/ZirM8CJ42r80GcUUEZoNdI0J
         AOtZE7OZRrXNuwK8D9lIRYRdXzRd6EhQqIWo5+nVBn3Ng8JTskFKXgMoNvSTot7zo3WS
         OBpcerZohcb/bIoo6Qd0qGFBsFc9c91y4Sq+5UJKF6xpA4VfdeGsf51c2wcXwPcxxxzZ
         czBV0GOUn4pXO7qEaP7IVohJ+Si/K6kKvo9shgKKuXpAa534WJrXPHSZt0Wugsp8eOJ6
         3P5fn9Rd80VJpQTUFHcZcO5H6XQzDjnHk/9OkkVlfTFLYDWTHJxOIWVa4kPhaRk6G+9A
         batw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=k5+zjDRRhhqO491xHEoAU6VTv+EQua9/0+Lq9coQ6dc=;
        b=bdSwwvfdSDSl3GLIIkJbs8VwFg3y8UGI9iLgvSmxd53YEvvTNYoJr+S1AlE/Nisp1V
         CGIHHihZlDYlHiFbWrO2NHPS0FBlXMQ/7cnW0AyLboOOo9YLT9X70mUalTojxPQvHDWb
         QS4uu/4Herb/tBcVSI5a5eh0vcvGcrSe937ztTTXptyvatgnu5rfT3cUB1NlvEt+FEUW
         zOUa+TbAOlEBuk6wGOOAtPJpe5DbFP8lqjOgFFEIC3K55iMpcG6/JU2WndkkVFq3A6F5
         dO6QOy9Mr/HAF2oLNxgH0vx0Md72j9/4BkTtw6e9Oeexw329kkFIH+iPcwOd1UNrdipT
         h+iQ==
X-Gm-Message-State: APjAAAUTc9n+adPcZSfnyqU2X5OoPtlkwbgqy/XYZy8hxI8latv5g1gh
        UkpviqHCD46YSnWiKI4OUcE=
X-Google-Smtp-Source: APXvYqy45e7awVfFtJobgsw1VBWiM2A5JEwtoJXxqxUqW+5OOGTknwQFtVNxOCQd47FfCaEUjo1Kzg==
X-Received: by 2002:a17:902:12c:: with SMTP id 41mr27181156plb.224.1575863844491;
        Sun, 08 Dec 2019 19:57:24 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id b129sm24606111pfb.147.2019.12.08.19.57.21
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Dec 2019 19:57:24 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com, orsonzhai@gmail.com
Subject: [PATCH v3 3/5] power: supply: sc27xx: Optimize the battery resistance with measuring temperature
Date:   Mon,  9 Dec 2019 11:56:23 +0800
Message-Id: <2c3b89e093dad0cfe8e8dadcc09a0a466f5c5409.1575863274.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1575863274.git.baolin.wang7@gmail.com>
References: <cover.1575863274.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1575863274.git.baolin.wang7@gmail.com>
References: <cover.1575863274.git.baolin.wang7@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yuanjiang Yu <yuanjiang.yu@unisoc.com>

Optimize the battery internal resistance in a certain temerature to
get a accurate battery internal resistance.

Signed-off-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/power/supply/sc27xx_fuel_gauge.c |   32 ++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index bc8f5bd..221b6fb 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -81,9 +81,11 @@
  * @max_volt: the maximum constant input voltage in millivolt
  * @min_volt: the minimum drained battery voltage in microvolt
  * @table_len: the capacity table length
+ * @resist_table_len: the resistance table length
  * @cur_1000ma_adc: ADC value corresponding to 1000 mA
  * @vol_1000mv_adc: ADC value corresponding to 1000 mV
  * @cap_table: capacity table with corresponding ocv
+ * @resist_table: resistance percent table with corresponding temperature
  */
 struct sc27xx_fgu_data {
 	struct regmap *regmap;
@@ -103,15 +105,18 @@ struct sc27xx_fgu_data {
 	int max_volt;
 	int min_volt;
 	int table_len;
+	int resist_table_len;
 	int cur_1000ma_adc;
 	int vol_1000mv_adc;
 	struct power_supply_battery_ocv_table *cap_table;
+	struct power_supply_resistance_temp_table *resist_table;
 };
 
 static int sc27xx_fgu_cap_to_clbcnt(struct sc27xx_fgu_data *data, int capacity);
 static void sc27xx_fgu_capacity_calibration(struct sc27xx_fgu_data *data,
 					    int cap, bool int_mode);
 static void sc27xx_fgu_adjust_cap(struct sc27xx_fgu_data *data, int cap);
+static int sc27xx_fgu_get_temp(struct sc27xx_fgu_data *data, int *temp);
 
 static const char * const sc27xx_charger_supply_name[] = {
 	"sc2731_charger",
@@ -434,7 +439,7 @@ static int sc27xx_fgu_get_current(struct sc27xx_fgu_data *data, int *val)
 
 static int sc27xx_fgu_get_vbat_ocv(struct sc27xx_fgu_data *data, int *val)
 {
-	int vol, cur, ret;
+	int vol, cur, ret, temp, resistance;
 
 	ret = sc27xx_fgu_get_vbat_vol(data, &vol);
 	if (ret)
@@ -444,8 +449,19 @@ static int sc27xx_fgu_get_vbat_ocv(struct sc27xx_fgu_data *data, int *val)
 	if (ret)
 		return ret;
 
+	resistance = data->internal_resist;
+	if (data->resist_table_len > 0) {
+		ret = sc27xx_fgu_get_temp(data, &temp);
+		if (ret)
+			return ret;
+
+		resistance = power_supply_temp2resist_simple(data->resist_table,
+						data->resist_table_len, temp);
+		resistance = data->internal_resist * resistance / 100;
+	}
+
 	/* Return the battery OCV in micro volts. */
-	*val = vol * 1000 - cur * data->internal_resist;
+	*val = vol * 1000 - cur * resistance;
 
 	return 0;
 }
@@ -929,6 +945,18 @@ static int sc27xx_fgu_hw_init(struct sc27xx_fgu_data *data)
 	if (!data->alarm_cap)
 		data->alarm_cap += 1;
 
+	data->resist_table_len = info.resist_table_size;
+	if (data->resist_table_len > 0) {
+		data->resist_table = devm_kmemdup(data->dev, info.resist_table,
+						  data->resist_table_len *
+						  sizeof(struct power_supply_resistance_temp_table),
+						  GFP_KERNEL);
+		if (!data->resist_table) {
+			power_supply_put_battery_info(data->battery, &info);
+			return -ENOMEM;
+		}
+	}
+
 	power_supply_put_battery_info(data->battery, &info);
 
 	ret = sc27xx_fgu_calibration(data);
-- 
1.7.9.5

