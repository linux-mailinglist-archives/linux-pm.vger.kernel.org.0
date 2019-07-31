Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64A6C7BDEC
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 12:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387705AbfGaKBB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 06:01:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40405 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387692AbfGaKBB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 06:01:01 -0400
Received: by mail-pl1-f194.google.com with SMTP id a93so30212267pla.7
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2019 03:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=lzudkxND7QXBPzukVZ8caM1zSAxHaq1C/uuuYUCx2po=;
        b=JYv4Dfa5hcngN9DoTOGV4efGVdwLlRNapWP8kKxPLBBoo8QqvDyDZqRLCkSwKS1E+I
         NOX/xhTUok4OWxNDBqrXEDfiTWFgfk2d38fMFffnafAiCMyUQD0o800ed1YjDeoL7HT9
         ZTG/w8M9Whi8WhgceM0vjdQ7K/iN5cfK8LxHF7iNXjB0Z3tnrhb2SFGsfEEi6aS4HSY2
         wi38XC1RfJl7qJ+C0L3S6BCvibvLQ2CgLYoHC8JNNQwmp47MAY3X8JLS3A+p5MuWlKcB
         6Efxk2uOLoWwHEtebA++1wAID8Y+ffRS3dD+hpdxRHr50yUsa2aqEOijbNN/QhwB+vSO
         8zfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=lzudkxND7QXBPzukVZ8caM1zSAxHaq1C/uuuYUCx2po=;
        b=lZXpYZUgNwF210p0yPw1asSsD9b7feF08MqqbiJDD8dnnmGfOPdnnTJKKSCuj/LqUS
         6zQbZO6rsXX8EWoEVxsl1jPWCvMhdmx51RUQRecnAa0oE+aD0rRODnlPC6DLJxQdSpDV
         lYGxYMQP8zkaUdltiWM6PxWxbFOR9Lgs0O1d1P8ycl66/eEkHtkuYyeW/xnA9mCHUHln
         L1xR1YBn2To3rtATw6UUrYgEpeTyuzNiVf3BDW6Q38jr3RGivc76/0iqqFxBstjcKKZn
         qbnVFS1qWtuLOsmh9UV0KTaBn6MN/VsbQPL6c5XeeYZfjzBOQxgyGOoJ0uTNQbdfrCy2
         yLIw==
X-Gm-Message-State: APjAAAWbL6cRM0rGzWD+ZQ5TCGHZX5y/nv83HbWJMkM40K8JfpIBCuFv
        k4iP/Mw+xhnEmqcfrtiVBN0e0w==
X-Google-Smtp-Source: APXvYqyR0e1/G2szSnTUlBQRznNPz+DXSU8mTfqTNHVZx5Nio2FgWQ4Gqlinf5EjrfrfMnJCKcFi9g==
X-Received: by 2002:a17:902:2de4:: with SMTP id p91mr88832811plb.28.1564567260751;
        Wed, 31 Jul 2019 03:01:00 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id m6sm68611352pfb.151.2019.07.31.03.00.58
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Jul 2019 03:01:00 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, vincent.guittot@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] power: supply: sc27xx: Optimize the battery capacity calibration
Date:   Wed, 31 Jul 2019 18:00:26 +0800
Message-Id: <6d4155a2d95a67546c27b49ba4cd1ab2898cb570.1564566425.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1564566425.git.baolin.wang@linaro.org>
References: <cover.1564566425.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1564566425.git.baolin.wang@linaro.org>
References: <cover.1564566425.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yuanjiang Yu <yuanjiang.yu@unisoc.com>

This patch factors out the capacity calibration into one single function
to calibrate the battery capacity, and adding more abnormal cases to
calibrate the capacity when the OCV value is not matchable with current
capacity.

Moreover we also allow to calibrate the capacity when charger magager
tries to get current capacity to make sure we give a correct capacity
for userspace.

Signed-off-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/sc27xx_fuel_gauge.c |  127 ++++++++++++++++++++++--------
 1 file changed, 92 insertions(+), 35 deletions(-)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index ab3afa1..f670131 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -109,6 +109,8 @@ struct sc27xx_fgu_data {
 };
 
 static int sc27xx_fgu_cap_to_clbcnt(struct sc27xx_fgu_data *data, int capacity);
+static void sc27xx_fgu_capacity_calibration(struct sc27xx_fgu_data *data,
+					    int cap, int int_mode);
 
 static const char * const sc27xx_charger_supply_name[] = {
 	"sc2731_charger",
@@ -389,6 +391,9 @@ static int sc27xx_fgu_get_capacity(struct sc27xx_fgu_data *data, int *cap)
 	delta_cap = DIV_ROUND_CLOSEST(temp * 100, data->total_cap);
 	*cap = delta_cap + data->init_cap;
 
+	/* Calibrate the battery capacity in a normal range. */
+	sc27xx_fgu_capacity_calibration(data, *cap, false);
+
 	return 0;
 }
 
@@ -661,50 +666,62 @@ static int sc27xx_fgu_property_is_writeable(struct power_supply *psy,
 
 static void sc27xx_fgu_adjust_cap(struct sc27xx_fgu_data *data, int cap)
 {
+	int ret;
+
 	data->init_cap = cap;
-	data->init_clbcnt = sc27xx_fgu_cap_to_clbcnt(data, data->init_cap);
+	ret = sc27xx_fgu_get_clbcnt(data, &data->init_clbcnt);
+	if (ret)
+		dev_err(data->dev, "failed to get init coulomb counter\n");
 }
 
-static irqreturn_t sc27xx_fgu_interrupt(int irq, void *dev_id)
+static void sc27xx_fgu_capacity_calibration(struct sc27xx_fgu_data *data,
+					    int cap, int int_mode)
 {
-	struct sc27xx_fgu_data *data = dev_id;
-	int ret, cap, ocv, adc;
-	u32 status;
-
-	mutex_lock(&data->lock);
+	int ret, ocv, chg_sts, adc;
 
-	ret = regmap_read(data->regmap, data->base + SC27XX_FGU_INT_STS,
-			  &status);
-	if (ret)
-		goto out;
+	ret = sc27xx_fgu_get_vbat_ocv(data, &ocv);
+	if (ret) {
+		dev_err(data->dev, "get battery ocv error.\n");
+		return;
+	}
 
-	ret = regmap_update_bits(data->regmap, data->base + SC27XX_FGU_INT_CLR,
-				 status, status);
-	if (ret)
-		goto out;
+	ret = sc27xx_fgu_get_status(data, &chg_sts);
+	if (ret) {
+		dev_err(data->dev, "get charger status error.\n");
+		return;
+	}
 
 	/*
-	 * When low overload voltage interrupt happens, we should calibrate the
-	 * battery capacity in lower voltage stage.
+	 * If we are in charging mode, then we do not need to calibrate the
+	 * lower capacity.
 	 */
-	if (!(status & SC27XX_FGU_LOW_OVERLOAD_INT))
-		goto out;
+	if (chg_sts == POWER_SUPPLY_STATUS_CHARGING)
+		return;
 
-	ret = sc27xx_fgu_get_capacity(data, &cap);
-	if (ret)
-		goto out;
-
-	ret = sc27xx_fgu_get_vbat_ocv(data, &ocv);
-	if (ret)
-		goto out;
-
-	/*
-	 * If current OCV value is less than the minimum OCV value in OCV table,
-	 * which means now battery capacity is 0%, and we should adjust the
-	 * inititial capacity to 0.
-	 */
-	if (ocv <= data->cap_table[data->table_len - 1].ocv) {
+	if ((ocv > data->cap_table[0].ocv && cap < 100) || cap > 100) {
+		/*
+		 * If current OCV value is larger than the max OCV value in
+		 * OCV table, or the current capacity is larger than 100,
+		 * we should force the inititial capacity to 100.
+		 */
+		sc27xx_fgu_adjust_cap(data, 100);
+	} else if (ocv <= data->cap_table[data->table_len - 1].ocv) {
+		/*
+		 * If current OCV value is leass than the minimum OCV value in
+		 * OCV table, we should force the inititial capacity to 0.
+		 */
 		sc27xx_fgu_adjust_cap(data, 0);
+	} else if ((ocv > data->cap_table[data->table_len - 1].ocv && cap <= 0) ||
+		   (ocv > data->min_volt && cap <= data->alarm_cap)) {
+		/*
+		 * If current OCV value is not matchable with current capacity,
+		 * we should re-calculate current capacity by looking up the
+		 * OCV table.
+		 */
+		int cur_cap = power_supply_ocv2cap_simple(data->cap_table,
+							  data->table_len, ocv);
+
+		sc27xx_fgu_adjust_cap(data, cur_cap);
 	} else if (ocv <= data->min_volt) {
 		/*
 		 * If current OCV value is less than the low alarm voltage, but
@@ -713,7 +730,7 @@ static irqreturn_t sc27xx_fgu_interrupt(int irq, void *dev_id)
 		 */
 		if (cap > data->alarm_cap) {
 			sc27xx_fgu_adjust_cap(data, data->alarm_cap);
-		} else if (cap <= 0) {
+		} else {
 			int cur_cap;
 
 			/*
@@ -728,15 +745,55 @@ static irqreturn_t sc27xx_fgu_interrupt(int irq, void *dev_id)
 			sc27xx_fgu_adjust_cap(data, cur_cap);
 		}
 
+		if (!int_mode)
+			return;
+
 		/*
 		 * After adjusting the battery capacity, we should set the
 		 * lowest alarm voltage instead.
 		 */
 		data->min_volt = data->cap_table[data->table_len - 1].ocv;
+		data->alarm_cap = power_supply_ocv2cap_simple(data->cap_table,
+							      data->table_len,
+							      data->min_volt);
+
 		adc = sc27xx_fgu_voltage_to_adc(data, data->min_volt / 1000);
-		regmap_update_bits(data->regmap, data->base + SC27XX_FGU_LOW_OVERLOAD,
+		regmap_update_bits(data->regmap,
+				   data->base + SC27XX_FGU_LOW_OVERLOAD,
 				   SC27XX_FGU_LOW_OVERLOAD_MASK, adc);
 	}
+}
+
+static irqreturn_t sc27xx_fgu_interrupt(int irq, void *dev_id)
+{
+	struct sc27xx_fgu_data *data = dev_id;
+	int ret, cap;
+	u32 status;
+
+	mutex_lock(&data->lock);
+
+	ret = regmap_read(data->regmap, data->base + SC27XX_FGU_INT_STS,
+			  &status);
+	if (ret)
+		goto out;
+
+	ret = regmap_update_bits(data->regmap, data->base + SC27XX_FGU_INT_CLR,
+				 status, status);
+	if (ret)
+		goto out;
+
+	/*
+	 * When low overload voltage interrupt happens, we should calibrate the
+	 * battery capacity in lower voltage stage.
+	 */
+	if (!(status & SC27XX_FGU_LOW_OVERLOAD_INT))
+		goto out;
+
+	ret = sc27xx_fgu_get_capacity(data, &cap);
+	if (ret)
+		goto out;
+
+	sc27xx_fgu_capacity_calibration(data, cap, true);
 
 out:
 	mutex_unlock(&data->lock);
-- 
1.7.9.5

