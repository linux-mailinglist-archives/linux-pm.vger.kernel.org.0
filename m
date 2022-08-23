Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FACE59E716
	for <lists+linux-pm@lfdr.de>; Tue, 23 Aug 2022 18:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239409AbiHWQWm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Aug 2022 12:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244586AbiHWQWZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2022 12:22:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235B810BE1A
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2022 05:43:12 -0700 (PDT)
Date:   Tue, 23 Aug 2022 12:43:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661258590;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pWAj3thRD8e2KgX2x+NCc8IZJOzLS/a5DuCxoYWdWZ0=;
        b=eSj1l3xmJKqEunFJqMywtCSXMJ7z4u+miIBvOQcqn7FpdY3qzNbSVwNftjnOKvCjwfDvI3
        4DIL9M3+HQH+vyotEXOdzzyI0TaNGSOYeGpEMe1Laiw3Gw4d4fQyPEYunCvD/M75VgRiWr
        k36rcNUuR1VU6DW2+XQLBG1WDQrNm7G+OKpzhMX7JKmkY9CM7oId57xFYDyhrM/z1BGFJn
        YPhr7LaGbeDIelYjMrwjYm/o6nSi69QNkDwlh3/V9mYAQYGehMtBpzlTQD29tZVmFfXVFA
        d+l8U4E5cofZytYBZzxiS2sXokKX7qO5GvmiQutPxXUKUpBGCffgqopctEX6Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661258590;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pWAj3thRD8e2KgX2x+NCc8IZJOzLS/a5DuCxoYWdWZ0=;
        b=aepAsq7ttFBezBdHWBYMPGrwwmwEfFavP9E/ew2LvH5s8zpX2fk0+kkClz3Khao14I1uol
        Dbh9cc/tTC/0tuAg==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/broadcom: Switch to new of API
Cc:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220804224349.1926752-11-daniel.lezcano@linexp.org>
References: <20220804224349.1926752-11-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Message-ID: <166125858956.401.4944948186126701949.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     944441d878b0aebd87ec404fe86c322186da458d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//944441d878b0aebd87ec404fe86c322186da458d
Author:        Daniel Lezcano <daniel.lezcano@linexp.org>
AuthorDate:    Fri, 05 Aug 2022 00:43:26 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 17 Aug 2022 14:09:38 +02:00

thermal/drivers/broadcom: Switch to new of API

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach. The ops are no longer device
tree specific and are the generic ones provided by the core code.

Convert the ops to the thermal_zone_device_ops format and use the new
API to register the thermal zone with these generic ops.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Tested-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Link: https://lore.kernel.org/r/20220804224349.1926752-11-daniel.lezcano@linexp.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/broadcom/bcm2711_thermal.c | 14 +++---
 drivers/thermal/broadcom/bcm2835_thermal.c | 14 +++---
 drivers/thermal/broadcom/brcmstb_thermal.c | 20 ++++----
 drivers/thermal/broadcom/ns-thermal.c      | 50 ++++++++-------------
 drivers/thermal/broadcom/sr-thermal.c      | 16 +++----
 5 files changed, 53 insertions(+), 61 deletions(-)

diff --git a/drivers/thermal/broadcom/bcm2711_thermal.c b/drivers/thermal/broadcom/bcm2711_thermal.c
index e9bef5c..1f8651d 100644
--- a/drivers/thermal/broadcom/bcm2711_thermal.c
+++ b/drivers/thermal/broadcom/bcm2711_thermal.c
@@ -31,11 +31,11 @@ struct bcm2711_thermal_priv {
 	struct thermal_zone_device *thermal;
 };
 
-static int bcm2711_get_temp(void *data, int *temp)
+static int bcm2711_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct bcm2711_thermal_priv *priv = data;
-	int slope = thermal_zone_get_slope(priv->thermal);
-	int offset = thermal_zone_get_offset(priv->thermal);
+	struct bcm2711_thermal_priv *priv = tz->devdata;
+	int slope = thermal_zone_get_slope(tz);
+	int offset = thermal_zone_get_offset(tz);
 	u32 val;
 	int ret;
 
@@ -54,7 +54,7 @@ static int bcm2711_get_temp(void *data, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops bcm2711_thermal_of_ops = {
+static const struct thermal_zone_device_ops bcm2711_thermal_of_ops = {
 	.get_temp	= bcm2711_get_temp,
 };
 
@@ -88,8 +88,8 @@ static int bcm2711_thermal_probe(struct platform_device *pdev)
 	}
 	priv->regmap = regmap;
 
-	thermal = devm_thermal_zone_of_sensor_register(dev, 0, priv,
-						       &bcm2711_thermal_of_ops);
+	thermal = devm_thermal_of_zone_register(dev, 0, priv,
+						&bcm2711_thermal_of_ops);
 	if (IS_ERR(thermal)) {
 		ret = PTR_ERR(thermal);
 		dev_err(dev, "could not register sensor: %d\n", ret);
diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index c8e4344..2c67841 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -88,9 +88,9 @@ static int bcm2835_thermal_temp2adc(int temp, int offset, int slope)
 	return temp;
 }
 
-static int bcm2835_thermal_get_temp(void *d, int *temp)
+static int bcm2835_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct bcm2835_thermal_data *data = d;
+	struct bcm2835_thermal_data *data = tz->devdata;
 	u32 val = readl(data->regs + BCM2835_TS_TSENSSTAT);
 
 	if (!(val & BCM2835_TS_TSENSSTAT_VALID))
@@ -135,7 +135,7 @@ static void bcm2835_thermal_debugfs(struct platform_device *pdev)
 	debugfs_create_regset32("regset", 0444, data->debugfsdir, regset);
 }
 
-static const struct thermal_zone_of_device_ops bcm2835_thermal_ops = {
+static const struct thermal_zone_device_ops bcm2835_thermal_ops = {
 	.get_temp = bcm2835_thermal_get_temp,
 };
 
@@ -206,8 +206,8 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 			 data->clk, rate);
 
 	/* register of thermal sensor and get info from DT */
-	tz = thermal_zone_of_sensor_register(&pdev->dev, 0, data,
-					     &bcm2835_thermal_ops);
+	tz = devm_thermal_of_zone_register(&pdev->dev, 0, data,
+					   &bcm2835_thermal_ops);
 	if (IS_ERR(tz)) {
 		err = PTR_ERR(tz);
 		dev_err(&pdev->dev,
@@ -277,7 +277,7 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 
 	return 0;
 err_tz:
-	thermal_zone_of_sensor_unregister(&pdev->dev, tz);
+	thermal_of_zone_unregister(tz);
 err_clk:
 	clk_disable_unprepare(data->clk);
 
@@ -290,7 +290,7 @@ static int bcm2835_thermal_remove(struct platform_device *pdev)
 	struct thermal_zone_device *tz = data->tz;
 
 	debugfs_remove_recursive(data->debugfsdir);
-	thermal_zone_of_sensor_unregister(&pdev->dev, tz);
+	thermal_of_zone_unregister(tz);
 	clk_disable_unprepare(data->clk);
 
 	return 0;
diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 0cedb8b..c79c6cf 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -105,7 +105,7 @@ static struct avs_tmon_trip avs_tmon_trips[] = {
 struct brcmstb_thermal_params {
 	unsigned int offset;
 	unsigned int mult;
-	const struct thermal_zone_of_device_ops *of_ops;
+	const struct thermal_zone_device_ops *of_ops;
 };
 
 struct brcmstb_thermal_priv {
@@ -150,9 +150,9 @@ static inline u32 avs_tmon_temp_to_code(struct brcmstb_thermal_priv *priv,
 		return (u32)((offset - temp) / mult);
 }
 
-static int brcmstb_get_temp(void *data, int *temp)
+static int brcmstb_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct brcmstb_thermal_priv *priv = data;
+	struct brcmstb_thermal_priv *priv = tz->devdata;
 	u32 val;
 	long t;
 
@@ -260,9 +260,9 @@ static irqreturn_t brcmstb_tmon_irq_thread(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int brcmstb_set_trips(void *data, int low, int high)
+static int brcmstb_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
-	struct brcmstb_thermal_priv *priv = data;
+	struct brcmstb_thermal_priv *priv = tz->devdata;
 
 	dev_dbg(priv->dev, "set trips %d <--> %d\n", low, high);
 
@@ -288,7 +288,7 @@ static int brcmstb_set_trips(void *data, int low, int high)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops brcmstb_16nm_of_ops = {
+static const struct thermal_zone_device_ops brcmstb_16nm_of_ops = {
 	.get_temp	= brcmstb_get_temp,
 };
 
@@ -298,7 +298,7 @@ static const struct brcmstb_thermal_params brcmstb_16nm_params = {
 	.of_ops	= &brcmstb_16nm_of_ops,
 };
 
-static const struct thermal_zone_of_device_ops brcmstb_28nm_of_ops = {
+static const struct thermal_zone_device_ops brcmstb_28nm_of_ops = {
 	.get_temp	= brcmstb_get_temp,
 	.set_trips	= brcmstb_set_trips,
 };
@@ -318,7 +318,7 @@ MODULE_DEVICE_TABLE(of, brcmstb_thermal_id_table);
 
 static int brcmstb_thermal_probe(struct platform_device *pdev)
 {
-	const struct thermal_zone_of_device_ops *of_ops;
+	const struct thermal_zone_device_ops *of_ops;
 	struct thermal_zone_device *thermal;
 	struct brcmstb_thermal_priv *priv;
 	struct resource *res;
@@ -341,8 +341,8 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, priv);
 	of_ops = priv->temp_params->of_ops;
 
-	thermal = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, priv,
-						       of_ops);
+	thermal = devm_thermal_of_zone_register(&pdev->dev, 0, priv,
+						of_ops);
 	if (IS_ERR(thermal)) {
 		ret = PTR_ERR(thermal);
 		dev_err(&pdev->dev, "could not register sensor: %d\n", ret);
diff --git a/drivers/thermal/broadcom/ns-thermal.c b/drivers/thermal/broadcom/ns-thermal.c
index c9468ba..07a8a3f 100644
--- a/drivers/thermal/broadcom/ns-thermal.c
+++ b/drivers/thermal/broadcom/ns-thermal.c
@@ -14,19 +14,14 @@
 #define PVTMON_CONTROL0_SEL_TEST_MODE			0x0000000e
 #define PVTMON_STATUS					0x08
 
-struct ns_thermal {
-	struct thermal_zone_device *tz;
-	void __iomem *pvtmon;
-};
-
-static int ns_thermal_get_temp(void *data, int *temp)
+static int ns_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct ns_thermal *ns_thermal = data;
-	int offset = thermal_zone_get_offset(ns_thermal->tz);
-	int slope = thermal_zone_get_slope(ns_thermal->tz);
+	void __iomem *pvtmon = tz->devdata;
+	int offset = thermal_zone_get_offset(tz);
+	int slope = thermal_zone_get_slope(tz);
 	u32 val;
 
-	val = readl(ns_thermal->pvtmon + PVTMON_CONTROL0);
+	val = readl(pvtmon + PVTMON_CONTROL0);
 	if ((val & PVTMON_CONTROL0_SEL_MASK) != PVTMON_CONTROL0_SEL_TEMP_MONITOR) {
 		/* Clear current mode selection */
 		val &= ~PVTMON_CONTROL0_SEL_MASK;
@@ -34,50 +29,47 @@ static int ns_thermal_get_temp(void *data, int *temp)
 		/* Set temp monitor mode (it's the default actually) */
 		val |= PVTMON_CONTROL0_SEL_TEMP_MONITOR;
 
-		writel(val, ns_thermal->pvtmon + PVTMON_CONTROL0);
+		writel(val, pvtmon + PVTMON_CONTROL0);
 	}
 
-	val = readl(ns_thermal->pvtmon + PVTMON_STATUS);
+	val = readl(pvtmon + PVTMON_STATUS);
 	*temp = slope * val + offset;
 
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops ns_thermal_ops = {
+static const struct thermal_zone_device_ops ns_thermal_ops = {
 	.get_temp = ns_thermal_get_temp,
 };
 
 static int ns_thermal_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct ns_thermal *ns_thermal;
-
-	ns_thermal = devm_kzalloc(dev, sizeof(*ns_thermal), GFP_KERNEL);
-	if (!ns_thermal)
-		return -ENOMEM;
+	struct thermal_zone_device *tz;
+	void __iomem *pvtmon;
 
-	ns_thermal->pvtmon = of_iomap(dev_of_node(dev), 0);
-	if (WARN_ON(!ns_thermal->pvtmon))
+	pvtmon = of_iomap(dev_of_node(dev), 0);
+	if (WARN_ON(!pvtmon))
 		return -ENOENT;
 
-	ns_thermal->tz = devm_thermal_zone_of_sensor_register(dev, 0,
-							      ns_thermal,
-							      &ns_thermal_ops);
-	if (IS_ERR(ns_thermal->tz)) {
-		iounmap(ns_thermal->pvtmon);
-		return PTR_ERR(ns_thermal->tz);
+	tz = devm_thermal_of_zone_register(dev, 0,
+					   pvtmon,
+					   &ns_thermal_ops);
+	if (IS_ERR(tz)) {
+		iounmap(pvtmon);
+		return PTR_ERR(tz);
 	}
 
-	platform_set_drvdata(pdev, ns_thermal);
+	platform_set_drvdata(pdev, pvtmon);
 
 	return 0;
 }
 
 static int ns_thermal_remove(struct platform_device *pdev)
 {
-	struct ns_thermal *ns_thermal = platform_get_drvdata(pdev);
+	void __iomem *pvtmon = platform_get_drvdata(pdev);
 
-	iounmap(ns_thermal->pvtmon);
+	iounmap(pvtmon);
 
 	return 0;
 }
diff --git a/drivers/thermal/broadcom/sr-thermal.c b/drivers/thermal/broadcom/sr-thermal.c
index 85ab9ed..2b93502 100644
--- a/drivers/thermal/broadcom/sr-thermal.c
+++ b/drivers/thermal/broadcom/sr-thermal.c
@@ -19,7 +19,6 @@
 #define SR_TMON_MAX_LIST        6
 
 struct sr_tmon {
-	struct thermal_zone_device *tz;
 	unsigned int crit_temp;
 	unsigned int tmon_id;
 	struct sr_thermal *priv;
@@ -31,9 +30,9 @@ struct sr_thermal {
 	struct sr_tmon tmon[SR_TMON_MAX_LIST];
 };
 
-static int sr_get_temp(void *data, int *temp)
+static int sr_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct sr_tmon *tmon = data;
+	struct sr_tmon *tmon = tz->devdata;
 	struct sr_thermal *sr_thermal = tmon->priv;
 
 	*temp = readl(sr_thermal->regs + SR_TMON_TEMP_BASE(tmon->tmon_id));
@@ -41,13 +40,14 @@ static int sr_get_temp(void *data, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops sr_tz_ops = {
+static const struct thermal_zone_device_ops sr_tz_ops = {
 	.get_temp = sr_get_temp,
 };
 
 static int sr_thermal_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct thermal_zone_device *tz;
 	struct sr_thermal *sr_thermal;
 	struct sr_tmon *tmon;
 	struct resource *res;
@@ -84,10 +84,10 @@ static int sr_thermal_probe(struct platform_device *pdev)
 		writel(0, sr_thermal->regs + SR_TMON_TEMP_BASE(i));
 		tmon->tmon_id = i;
 		tmon->priv = sr_thermal;
-		tmon->tz = devm_thermal_zone_of_sensor_register(dev, i, tmon,
-								&sr_tz_ops);
-		if (IS_ERR(tmon->tz))
-			return PTR_ERR(tmon->tz);
+		tz = devm_thermal_of_zone_register(dev, i, tmon,
+						   &sr_tz_ops);
+		if (IS_ERR(tz))
+			return PTR_ERR(tz);
 
 		dev_dbg(dev, "thermal sensor %d registered\n", i);
 	}
