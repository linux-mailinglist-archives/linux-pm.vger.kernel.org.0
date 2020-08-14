Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F53244AD4
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 15:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgHNNmR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Aug 2020 09:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbgHNNmM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Aug 2020 09:42:12 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D09BC061384;
        Fri, 14 Aug 2020 06:42:11 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id t10so9965325ejs.8;
        Fri, 14 Aug 2020 06:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5h+RCIRVJpQHfbahCZeVcIadWa9PrkkZS82RzJ9FbQs=;
        b=Mib0AldJ7qsLE5e88f0cpzE2Rf1+uWt6LtZgvjAQNZmZuXZ1YVwKfD+BzqUV7n1caE
         JdtHzzIK94gulTCui7Np5JBpf962ZLQKUSgxIZSlNYVR5iuGAGlYLA9hv+07bTFWqtQK
         84QQUu6B1HO64SgkqY53qJdSxEYxwabgs3Luh0bQa2gCYInUgBA85yEQQ0YeVzjatUoB
         ArBB5NQ12Gw9Wmp9Gnj+RYnLBHStNs3iN02SgoGAXp5RZdTlESduOzt+uxFve7r2jGF4
         zRhxNylAMfiJepbuq7cGzjEor3UNxOnkYA9VOZXf2y1LEsewnSXWAD8sPZp5J5MC/u90
         xYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5h+RCIRVJpQHfbahCZeVcIadWa9PrkkZS82RzJ9FbQs=;
        b=oixcQD9bZwD6latVmfbXdepBl68Jx7nQTGlEimYmDSxwBdvjIm5ul1eNlON7LqjGO/
         GMttqOJWZ+nOSOkwAHEz71QCFtYERsahUKQYBzvIw98GWXJ6E3lee7ZZi+H3F3Q02r9K
         1gU2OqZhnI0jyonD+FUlkI8rjAxR8nJNVd8rsb3yo0ZS7C6ojM6fp6qxfxBJrc2Fwkn0
         j94KN7BFK1C8IqiUVOk2cHN3i+0l/ii3HYzOji739OeQTKnGKICKRLMmHO5C5Yu+UwXj
         UdyomHTEhVh5ghqE6w9N65SGpsPXa1Yvhbx0PesSbBJDg9RHof7mP2qQACQLYTPRDJ0P
         GMjQ==
X-Gm-Message-State: AOAM533Gj7hrRhPG7xhUU4BB+DJwpwamDdBRxgjaUkFRkumRFXDd9jwa
        q6wQIiMmOaY1LOcRz0p81mE=
X-Google-Smtp-Source: ABdhPJz78nZAwLSIYCaf8ulAm9IC0gKR/R4HmxfmWNPCtx8/ln1kSlQQSgu2wGrkyAJog8XHfPeaOw==
X-Received: by 2002:a17:906:ae12:: with SMTP id le18mr2492237ejb.38.1597412530124;
        Fri, 14 Aug 2020 06:42:10 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-0-192-118.retail.telecomitalia.it. [87.0.192.118])
        by smtp.googlemail.com with ESMTPSA id s2sm6767118ejd.17.2020.08.14.06.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 06:42:09 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v6 2/8] drivers: thermal: tsens: Add VER_0 tsens version
Date:   Fri, 14 Aug 2020 15:41:16 +0200
Message-Id: <20200814134123.14566-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814134123.14566-1-ansuelsmth@gmail.com>
References: <20200814134123.14566-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VER_0 is used to describe device based on tsens version before v0.1.
These device are devices based on msm8960 for example apq8064 or
ipq806x.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens.c | 122 +++++++++++++++++++++++++++++++----
 drivers/thermal/qcom/tsens.h |   7 +-
 2 files changed, 114 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 9fe9a2b26705..965c4799918a 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -516,6 +516,15 @@ static irqreturn_t tsens_irq_thread(int irq, void *data)
 			dev_dbg(priv->dev, "[%u] %s: no violation:  %d\n",
 				hw_id, __func__, temp);
 		}
+
+		if (tsens_version(priv) < VER_0_1) {
+			/* Constraint: There is only 1 interrupt control register for all
+			 * 11 temperature sensor. So monitoring more than 1 sensor based
+			 * on interrupts will yield inconsistent result. To overcome this
+			 * issue we will monitor only sensor 0 which is the master sensor.
+			 */
+			break;
+		}
 	}
 
 	return IRQ_HANDLED;
@@ -531,6 +540,13 @@ static int tsens_set_trips(void *_sensor, int low, int high)
 	int high_val, low_val, cl_high, cl_low;
 	u32 hw_id = s->hw_id;
 
+	if (tsens_version(priv) < VER_0_1) {
+		/* Pre v0.1 IP had a single register for each type of interrupt
+		 * and thresholds
+		 */
+		hw_id = 0;
+	}
+
 	dev_dbg(dev, "[%u] %s: proposed thresholds: (%d:%d)\n",
 		hw_id, __func__, low, high);
 
@@ -584,18 +600,21 @@ int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
 	u32 valid;
 	int ret;
 
-	ret = regmap_field_read(priv->rf[valid_idx], &valid);
-	if (ret)
-		return ret;
-	while (!valid) {
-		/* Valid bit is 0 for 6 AHB clock cycles.
-		 * At 19.2MHz, 1 AHB clock is ~60ns.
-		 * We should enter this loop very, very rarely.
-		 */
-		ndelay(400);
+	/* VER_0 doesn't have VALID bit */
+	if (tsens_version(priv) >= VER_0_1) {
 		ret = regmap_field_read(priv->rf[valid_idx], &valid);
 		if (ret)
 			return ret;
+		while (!valid) {
+			/* Valid bit is 0 for 6 AHB clock cycles.
+			 * At 19.2MHz, 1 AHB clock is ~60ns.
+			 * We should enter this loop very, very rarely.
+			 */
+			ndelay(400);
+			ret = regmap_field_read(priv->rf[valid_idx], &valid);
+			if (ret)
+				return ret;
+		}
 	}
 
 	/* Valid bit is set, OK to read the temperature */
@@ -763,6 +782,10 @@ int __init init_common(struct tsens_priv *priv)
 		goto err_put_device;
 	}
 
+	/* VER_0 have only tm_map */
+	if (!priv->srot_map)
+		priv->srot_map = priv->tm_map;
+
 	if (tsens_version(priv) > VER_0_1) {
 		for (i = VER_MAJOR; i <= VER_STEP; i++) {
 			priv->rf[i] = devm_regmap_field_alloc(dev, priv->srot_map,
@@ -781,6 +804,10 @@ int __init init_common(struct tsens_priv *priv)
 		ret = PTR_ERR(priv->rf[TSENS_EN]);
 		goto err_put_device;
 	}
+	/* in VER_0 TSENS need to be explicitly enabled */
+	if (tsens_version(priv) == VER_0)
+		regmap_field_write(priv->rf[TSENS_EN], 1);
+
 	ret = regmap_field_read(priv->rf[TSENS_EN], &enabled);
 	if (ret)
 		goto err_put_device;
@@ -803,6 +830,61 @@ int __init init_common(struct tsens_priv *priv)
 		goto err_put_device;
 	}
 
+	priv->rf[TSENS_EN] = devm_regmap_field_alloc(dev, priv->tm_map,
+						     priv->fields[TSENS_EN]);
+	if (IS_ERR(priv->rf[TSENS_EN])) {
+		ret = PTR_ERR(priv->rf[TSENS_EN]);
+		goto err_put_device;
+	}
+
+	priv->rf[TSENS_SW_RST] = devm_regmap_field_alloc(
+		dev, priv->tm_map, priv->fields[TSENS_EN]);
+	if (IS_ERR(priv->rf[TSENS_EN])) {
+		ret = PTR_ERR(priv->rf[TSENS_EN]);
+		goto err_put_device;
+	}
+
+	priv->rf[LOW_INT_CLEAR_0] = devm_regmap_field_alloc(
+		dev, priv->tm_map, priv->fields[LOW_INT_CLEAR_0]);
+	if (IS_ERR(priv->rf[LOW_INT_CLEAR_0])) {
+		ret = PTR_ERR(priv->rf[LOW_INT_CLEAR_0]);
+		goto err_put_device;
+	}
+
+	priv->rf[UP_INT_CLEAR_0] = devm_regmap_field_alloc(
+		dev, priv->tm_map, priv->fields[UP_INT_CLEAR_0]);
+	if (IS_ERR(priv->rf[UP_INT_CLEAR_0])) {
+		ret = PTR_ERR(priv->rf[UP_INT_CLEAR_0]);
+		goto err_put_device;
+	}
+
+	/* VER_0 require to set MIN and MAX THRESH */
+	if (tsens_version(priv) < VER_0_1) {
+		priv->rf[MIN_THRESH_0] = devm_regmap_field_alloc(
+			dev, priv->tm_map, priv->fields[MIN_THRESH_0]);
+		if (IS_ERR(priv->rf[MIN_THRESH_0])) {
+			ret = PTR_ERR(priv->rf[MIN_THRESH_0]);
+			goto err_put_device;
+		}
+
+		priv->rf[MAX_THRESH_0] = devm_regmap_field_alloc(
+			dev, priv->tm_map, priv->fields[MAX_THRESH_0]);
+		if (IS_ERR(priv->rf[MAX_THRESH_0])) {
+			ret = PTR_ERR(priv->rf[MAX_THRESH_0]);
+			goto err_put_device;
+		}
+
+		regmap_field_write(priv->rf[MIN_THRESH_0], 0);
+		regmap_field_write(priv->rf[MAX_THRESH_0], 120000);
+	}
+
+	priv->rf[TRDY] =
+		devm_regmap_field_alloc(dev, priv->tm_map, priv->fields[TRDY]);
+	if (IS_ERR(priv->rf[TRDY])) {
+		ret = PTR_ERR(priv->rf[TRDY]);
+		goto err_put_device;
+	}
+
 	/* This loop might need changes if enum regfield_ids is reordered */
 	for (j = LAST_TEMP_0; j <= UP_THRESH_15; j += 16) {
 		for (i = 0; i < priv->feat->max_sensors; i++) {
@@ -856,7 +938,11 @@ int __init init_common(struct tsens_priv *priv)
 	}
 
 	spin_lock_init(&priv->ul_lock);
-	tsens_enable_irq(priv);
+
+	/* VER_0 interrupt doesn't need to be enabled */
+	if (tsens_version(priv) >= VER_0_1)
+		tsens_enable_irq(priv);
+
 	tsens_debug_init(op);
 
 err_put_device:
@@ -952,10 +1038,18 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
 		if (irq == -ENXIO)
 			ret = 0;
 	} else {
-		ret = devm_request_threaded_irq(&pdev->dev, irq,
-						NULL, thread_fn,
-						IRQF_ONESHOT,
-						dev_name(&pdev->dev), priv);
+		/* VER_0 interrupt is TRIGGER_RISING, VER_0_1 and up is ONESHOT */
+		if (tsens_version(priv) > VER_0)
+			ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+							thread_fn, IRQF_ONESHOT,
+							dev_name(&pdev->dev),
+							priv);
+		else
+			ret = devm_request_threaded_irq(&pdev->dev, irq,
+							thread_fn, NULL,
+							IRQF_TRIGGER_RISING,
+							dev_name(&pdev->dev),
+							priv);
 		if (ret)
 			dev_err(&pdev->dev, "%s: failed to get irq\n",
 				__func__);
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 59d01162c66a..f1120791737c 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -25,7 +25,8 @@ struct tsens_priv;
 
 /* IP version numbers in ascending order */
 enum tsens_ver {
-	VER_0_1 = 0,
+	VER_0 = 0,
+	VER_0_1,
 	VER_1_X,
 	VER_2_X,
 };
@@ -441,6 +442,10 @@ enum regfield_ids {
 	CRIT_THRESH_14,
 	CRIT_THRESH_15,
 
+	/* VER_0 MIN MAX THRESH */
+	MIN_THRESH_0,
+	MAX_THRESH_0,
+
 	/* WATCHDOG */
 	WDOG_BARK_STATUS,
 	WDOG_BARK_CLEAR,
-- 
2.27.0

