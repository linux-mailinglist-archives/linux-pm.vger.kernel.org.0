Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F6D2C5DBA
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 23:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388936AbgKZWQA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 17:16:00 -0500
Received: from vsp-unauthed02.binero.net ([195.74.38.227]:19484 "EHLO
        vsp-unauthed02.binero.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388893AbgKZWQA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2020 17:16:00 -0500
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Nov 2020 17:16:00 EST
X-Halon-ID: afb85b74-3033-11eb-a076-005056917f90
Authorized-sender: niklas.soderlund@fsdn.se
Received: from bismarck.berto.se (p4fca2458.dip0.t-ipconnect.de [79.202.36.88])
        by bin-vsp-out-02.atm.binero.net (Halon) with ESMTPA
        id afb85b74-3033-11eb-a076-005056917f90;
        Thu, 26 Nov 2020 23:06:58 +0100 (CET)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH] thermal: rcar_gen3_thermal: Do not use interrupts for normal operation
Date:   Thu, 26 Nov 2020 23:09:23 +0100
Message-Id: <20201126220923.3107213-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Remove the usage of interrupts for the normal temperature operation and
depend on the polling performed by the thermal core. This is done to
prepare to use the interrupts as they are intended to trigger once
specific trip points are passed and not to react to temperature changes
in the normal operational range.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_gen3_thermal.c | 108 +---------------------------
 1 file changed, 2 insertions(+), 106 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 0dd47dca3e771256..94f2c133a47f66b6 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -188,70 +188,10 @@ static int rcar_gen3_thermal_get_temp(void *devdata, int *temp)
 	return 0;
 }
 
-static int rcar_gen3_thermal_mcelsius_to_temp(struct rcar_gen3_thermal_tsc *tsc,
-					      int mcelsius)
-{
-	int celsius, val;
-
-	celsius = DIV_ROUND_CLOSEST(mcelsius, 1000);
-	if (celsius <= INT_FIXPT(tsc->tj_t))
-		val = celsius * tsc->coef.a1 + tsc->coef.b1;
-	else
-		val = celsius * tsc->coef.a2 + tsc->coef.b2;
-
-	return INT_FIXPT(val);
-}
-
-static int rcar_gen3_thermal_update_range(struct rcar_gen3_thermal_tsc *tsc)
-{
-	int temperature, low, high;
-
-	rcar_gen3_thermal_get_temp(tsc, &temperature);
-
-	low = temperature - MCELSIUS(1);
-	high = temperature + MCELSIUS(1);
-
-	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQTEMP1,
-				rcar_gen3_thermal_mcelsius_to_temp(tsc, low));
-
-	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQTEMP2,
-				rcar_gen3_thermal_mcelsius_to_temp(tsc, high));
-
-	return 0;
-}
-
 static const struct thermal_zone_of_device_ops rcar_gen3_tz_of_ops = {
 	.get_temp	= rcar_gen3_thermal_get_temp,
 };
 
-static void rcar_thermal_irq_set(struct rcar_gen3_thermal_priv *priv, bool on)
-{
-	unsigned int i;
-	u32 val = on ? IRQ_TEMPD1 | IRQ_TEMP2 : 0;
-
-	for (i = 0; i < priv->num_tscs; i++)
-		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQMSK, val);
-}
-
-static irqreturn_t rcar_gen3_thermal_irq(int irq, void *data)
-{
-	struct rcar_gen3_thermal_priv *priv = data;
-	u32 status;
-	int i;
-
-	for (i = 0; i < priv->num_tscs; i++) {
-		status = rcar_gen3_thermal_read(priv->tscs[i], REG_GEN3_IRQSTR);
-		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQSTR, 0);
-		if (status) {
-			rcar_gen3_thermal_update_range(priv->tscs[i]);
-			thermal_zone_device_update(priv->tscs[i]->zone,
-						   THERMAL_EVENT_UNSPECIFIED);
-		}
-	}
-
-	return IRQ_HANDLED;
-}
-
 static const struct soc_device_attribute r8a7795es1[] = {
 	{ .soc_id = "r8a7795", .revision = "ES1.*" },
 	{ /* sentinel */ }
@@ -268,7 +208,6 @@ static void rcar_gen3_thermal_init_r8a7795es1(struct rcar_gen3_thermal_tsc *tsc)
 
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0x3F);
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQMSK, 0);
-	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQEN, IRQ_TEMPD1 | IRQ_TEMP2);
 
 	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,
 				CTSR_PONM | CTSR_AOUT | CTSR_THBGR | CTSR_VMEN);
@@ -294,7 +233,6 @@ static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
 
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0);
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQMSK, 0);
-	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQEN, IRQ_TEMPD1 | IRQ_TEMP2);
 
 	reg_val = rcar_gen3_thermal_read(tsc, REG_GEN3_THCTR);
 	reg_val |= THCTR_THSST;
@@ -345,9 +283,6 @@ MODULE_DEVICE_TABLE(of, rcar_gen3_thermal_dt_ids);
 static int rcar_gen3_thermal_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct rcar_gen3_thermal_priv *priv = dev_get_drvdata(dev);
-
-	rcar_thermal_irq_set(priv, false);
 
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
@@ -369,8 +304,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	const int *rcar_gen3_ths_tj_1 = of_device_get_match_data(dev);
 	struct resource *res;
 	struct thermal_zone_device *zone;
-	int ret, irq, i;
-	char *irqname;
+	int ret, i;
 
 	/* default values if FUSEs are missing */
 	/* TODO: Read values from hardware on supported platforms */
@@ -386,28 +320,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	/*
-	 * Request 2 (of the 3 possible) IRQs, the driver only needs to
-	 * to trigger on the low and high trip points of the current
-	 * temp window at this point.
-	 */
-	for (i = 0; i < 2; i++) {
-		irq = platform_get_irq(pdev, i);
-		if (irq < 0)
-			return irq;
-
-		irqname = devm_kasprintf(dev, GFP_KERNEL, "%s:ch%d",
-					 dev_name(dev), i);
-		if (!irqname)
-			return -ENOMEM;
-
-		ret = devm_request_threaded_irq(dev, irq, NULL,
-						rcar_gen3_thermal_irq,
-						IRQF_ONESHOT, irqname, priv);
-		if (ret)
-			return ret;
-	}
-
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
@@ -459,8 +371,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		if (ret < 0)
 			goto error_unregister;
 
-		rcar_gen3_thermal_update_range(tsc);
-
 		dev_info(dev, "TSC%d: Loaded %d trip points\n", i, ret);
 	}
 
@@ -471,8 +381,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		goto error_unregister;
 	}
 
-	rcar_thermal_irq_set(priv, true);
-
 	return 0;
 
 error_unregister:
@@ -481,15 +389,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __maybe_unused rcar_gen3_thermal_suspend(struct device *dev)
-{
-	struct rcar_gen3_thermal_priv *priv = dev_get_drvdata(dev);
-
-	rcar_thermal_irq_set(priv, false);
-
-	return 0;
-}
-
 static int __maybe_unused rcar_gen3_thermal_resume(struct device *dev)
 {
 	struct rcar_gen3_thermal_priv *priv = dev_get_drvdata(dev);
@@ -499,15 +398,12 @@ static int __maybe_unused rcar_gen3_thermal_resume(struct device *dev)
 		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
 
 		priv->thermal_init(tsc);
-		rcar_gen3_thermal_update_range(tsc);
 	}
 
-	rcar_thermal_irq_set(priv, true);
-
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(rcar_gen3_thermal_pm_ops, rcar_gen3_thermal_suspend,
+static SIMPLE_DEV_PM_OPS(rcar_gen3_thermal_pm_ops, NULL,
 			 rcar_gen3_thermal_resume);
 
 static struct platform_driver rcar_gen3_thermal_driver = {
-- 
2.29.2

