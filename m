Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3BB1EB02C
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 13:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfJaMXu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 08:23:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35545 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfJaMXu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2019 08:23:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id d13so4286915pfq.2
        for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2019 05:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ipn4aXAOp87D2v3r9KdhlrkAx9KnL+jbYVkv6tX05Nc=;
        b=Ts249/egnrhzEnpXd834uI2TsYDQGJUwwxIXs5mn5C+Q4KZiVMKkCBPTYzys4nYqgq
         xziLKywtITszSHspc6rib/y5uXeygD6cYUVj4k1TGPpDyI5VdC9JdZJ0SbRlx/uFMx4q
         yqlRwdLtYMNEnlDwSS1VfDuyr4zuEb8mmG8e7h0Wgw5lIlEcPX19EbMBKah2Bq53HI1v
         SpMA7AHFE02wNG4vvt+SB6TCGEo6ZUQT37b+DgdXeKv5sdSTpFjzx8+yEGB0RRSTa6IY
         6+iwybqUmbH21IGe8G0TCqltT5PMjVbhBcYLhiGWYPZzW7Azs4ZcZ3XPJF+bWTIIKHEo
         FRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ipn4aXAOp87D2v3r9KdhlrkAx9KnL+jbYVkv6tX05Nc=;
        b=sHlwnawKC83+L1iLHMXO2i0+c5wAzdXvwvmJT5/eHg1wkPeT/uz0jdz8g+zWz4hUtl
         czdlNmxaKtdayzwfJ93BkB23sDMVEB72zMDysp7XxVkAdSszRwvkBNePDi/MNmqoMGgQ
         JUhLkiVMx4CS7MM0sby4c39OJmMDZrfYOQ7blDQzn42bFyFR0juA9XOc0n4+IV9C/TpK
         V6tJlw6wcISB7Bb8UZ3+BtVWutkcVoN6Tj8c/d00SkaceIiqIIyvjcBnoJvXibKm7kK4
         +ElQgIWQVxoETFhwCL/3j8G4E35FShhcadpicRmoV/cGBLL9R3C4XOJdSbqndmzTwCYI
         fZ8Q==
X-Gm-Message-State: APjAAAVqQxSTlKa+SUnvzFIC9nSD8y7Xiu5zKTwOGfJYtUhKywo8NWAm
        8MPdFgwEfpW5coiu8NphcDk/fA==
X-Google-Smtp-Source: APXvYqzHkz+hq1Ad589b9IlHVZAbwK6zRa2McYPDf0VLn5AKIPV++LFv6ETIZcgRQ1ibWBfKh0zBGA==
X-Received: by 2002:a17:90a:8816:: with SMTP id s22mr2159357pjn.31.1572524628486;
        Thu, 31 Oct 2019 05:23:48 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j25sm2983077pfi.113.2019.10.31.05.23.44
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Oct 2019 05:23:47 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com, orsonzhai@gmail.com
Subject: [PATCH v2 3/5] power: supply: sc27xx: Optimize the battery resistance with measuring temperature
Date:   Thu, 31 Oct 2019 20:22:42 +0800
Message-Id: <3dbd343189aa027c00148a5d8365661aa8b4c7ff.1572523415.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1572523415.git.baolin.wang@linaro.org>
References: <cover.1572523415.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1572523415.git.baolin.wang@linaro.org>
References: <cover.1572523415.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yuanjiang Yu <yuanjiang.yu@unisoc.com>

Optimize the battery internal resistance in a certain temerature to
get a accurate battery internal resistance.

Signed-off-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
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

