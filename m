Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF861165BA
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 04:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfLID5d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Dec 2019 22:57:33 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41179 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfLID5c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 8 Dec 2019 22:57:32 -0500
Received: by mail-pg1-f194.google.com with SMTP id x8so6419523pgk.8;
        Sun, 08 Dec 2019 19:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=4HDNu++S9qVPoxkV4CPwjrOYl/qB6CAWEdk7e3/cozE=;
        b=sqcMknGsspTBQziNyBMJMVe6M2sd44GR6m5Np1BfjWnjkWLi6GSpN0wT031lsH2esi
         fT2BBZbgASIS8GIYDC/9Wdvldq7pYqUWMnet3xJ9RA2cInPw8mcIibEaPXGWfBxBRhN/
         TvHqdkgSyr+VWmUAefKBT0/lq+bFhSfJFlFRdhCJymD7BPRgjKCO1zwJZI1YhSBX3UOB
         7bkYgUOlmY8b82OBb0RUtses0Oi8VI/amY8kM5lKbsnSxdfvFduNOpDImei3+9LxwxKG
         PjEbSIbE+l9jW/KSjI9yDu59zgywEXeYbVGYm0ZKLtg45qMWZPaJs+6Pw4VpMU3iVLlv
         VbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=4HDNu++S9qVPoxkV4CPwjrOYl/qB6CAWEdk7e3/cozE=;
        b=k9vad3GoWZFoophZ9Djo2svRixeC/lwxI65FOXJIn9Nh8Zb4zyQYmwLnYzJkN+TxaD
         WJD6VXZRcmg4u0XLQlSOu0PsGw5qR/zW5wu2l+WNb3DV/0FH6cvIYJHd2GB8lTgRn2Yi
         bLBL+9Xwlj4SFTIRaiNGv/GmuJLN1n6RZM/ByFXhSrDv+aSsQBjy7FHA73gjSb/iLTb+
         lH0fnuSsWe3xmkgCtB4U5VdxwgZM7Vq4QCTQw31J/k4OpflZxvqbrlRxaQS/H2CW94nC
         N1AlZ4pFoOypuI2MkkSGzdcWjGxDHFAZKgdJ3UhbS43vunfhLTP7ojfdK3Wog9DHHJpO
         FDbg==
X-Gm-Message-State: APjAAAVi3XriRf5ytycIKc11WKY3Q10cf8YFPRSdr8H2zUtfd5/z5Q43
        rcR7vp5NWIeZQZuALYjCq4uE3p1+zmM=
X-Google-Smtp-Source: APXvYqzXnP92wBKh9BZKaI8aJgmxF/EhErmpuCiKjkGGK0JSl7eQu1UiMNW64/R0p2YzvLmNZtiBgQ==
X-Received: by 2002:a63:115c:: with SMTP id 28mr16448493pgr.6.1575863852166;
        Sun, 08 Dec 2019 19:57:32 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id b129sm24606111pfb.147.2019.12.08.19.57.28
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Dec 2019 19:57:31 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com, orsonzhai@gmail.com
Subject: [PATCH v3 5/5] power: supply: sc27xx: Calibrate the resistance of coulomb counter
Date:   Mon,  9 Dec 2019 11:56:25 +0800
Message-Id: <b45e604462cd20e9b06fceff3d698c9c4a53a1d4.1575863274.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1575863274.git.baolin.wang7@gmail.com>
References: <cover.1575863274.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1575863274.git.baolin.wang7@gmail.com>
References: <cover.1575863274.git.baolin.wang7@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Baolin Wang <baolin.wang@linaro.org>

There are some deviations between the real resistance and the ideal
resistance of coulomb counter, which will affect the accuracy of
the coulomb counter, thus calibrate the real resistance of coulomb
counter to improve the accuracy.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/power/supply/sc27xx_fuel_gauge.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index 221b6fb..951d5d1 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -62,6 +62,8 @@
 
 #define SC27XX_FGU_CUR_BASIC_ADC	8192
 #define SC27XX_FGU_SAMPLE_HZ		2
+/* micro Ohms */
+#define SC27XX_FGU_IDEAL_RESISTANCE	20000
 
 /*
  * struct sc27xx_fgu_data: describe the FGU device
@@ -84,6 +86,7 @@
  * @resist_table_len: the resistance table length
  * @cur_1000ma_adc: ADC value corresponding to 1000 mA
  * @vol_1000mv_adc: ADC value corresponding to 1000 mV
+ * @calib_resist: the real resistance of coulomb counter chip in mOhm
  * @cap_table: capacity table with corresponding ocv
  * @resist_table: resistance percent table with corresponding temperature
  */
@@ -108,6 +111,7 @@ struct sc27xx_fgu_data {
 	int resist_table_len;
 	int cur_1000ma_adc;
 	int vol_1000mv_adc;
+	int calib_resist;
 	struct power_supply_battery_ocv_table *cap_table;
 	struct power_supply_resistance_temp_table *resist_table;
 };
@@ -900,7 +904,9 @@ static int sc27xx_fgu_calibration(struct sc27xx_fgu_data *data)
 	 */
 	cal_4200mv = (calib_data & 0x1ff) + 6963 - 4096 - 256;
 	data->vol_1000mv_adc = DIV_ROUND_CLOSEST(cal_4200mv * 10, 42);
-	data->cur_1000ma_adc = data->vol_1000mv_adc * 4;
+	data->cur_1000ma_adc =
+		DIV_ROUND_CLOSEST(data->vol_1000mv_adc * 4 * data->calib_resist,
+				  SC27XX_FGU_IDEAL_RESISTANCE);
 
 	kfree(buf);
 	return 0;
@@ -1079,6 +1085,15 @@ static int sc27xx_fgu_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = device_property_read_u32(&pdev->dev,
+				       "sprd,calib-resistance-micro-ohms",
+				       &data->calib_resist);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"failed to get fgu calibration resistance\n");
+		return ret;
+	}
+
 	data->channel = devm_iio_channel_get(dev, "bat-temp");
 	if (IS_ERR(data->channel)) {
 		dev_err(dev, "failed to get IIO channel\n");
-- 
1.7.9.5

