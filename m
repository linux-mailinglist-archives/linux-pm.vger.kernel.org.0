Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5E32D1272
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 14:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgLGNr4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 08:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgLGNr4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 08:47:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACC9C0613D2
        for <linux-pm@vger.kernel.org>; Mon,  7 Dec 2020 05:47:15 -0800 (PST)
Date:   Mon, 07 Dec 2020 13:47:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607348833;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k5dAWGKV6s9PkFPi5bk5H5T6vFag0mKd0Jq/SHwUdNI=;
        b=B05aYaYuqZUn6oeLCgcxlTvpjVUZHBxXEkqQEc6HYLotSkOvzTDMXjIJr+UNggA6p397xz
        8KRSP6QtI12bdHrLC/SKaCUhuMCHseDE9jJq3BIULlUllHE+INiY8jDczt2ZCHoy4Ljctl
        3HqjdwjROnvyMsCghSuhzaU3n+egYfJerXszQt4dYIuHkSOxoWZVyyRnQXMUHXW6CwWcCH
        9LysSouQ/d9cOPMjqpENpchkgQVKRltk2IGjlKXKVAwRjEpCC4cv+7bGaYOZUVlg5BPMWn
        Kcfk8dskT3Y9GLhbBB4YTJEZ8JAbLL0LPfFuN6Y5cNq3qWTAhfY+dpC6xWd4sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607348833;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k5dAWGKV6s9PkFPi5bk5H5T6vFag0mKd0Jq/SHwUdNI=;
        b=7RoJuawBhQ8brbz53zeI7V+9Wja+Ss97ASmB52WNqKCvJnviJdDwh3/SPzqV5X+oSFoQCm
        xtBz4a23Pjv8hdBg==
From:   thermal-bot for Niklas =?utf-8?q?S=C3=B6derlund?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: rcar_gen3_thermal: Do not use
 interrupts for normal operation
Cc:     niklas.soderlund+renesas@ragnatech.se,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201126220923.3107213-1-niklas.soderlund+renesas@ragnatech.se>
References: <20201126220923.3107213-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Message-ID: <160734883281.3364.5930229521034807240.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     1b57b9597c779f0a20c5837abec31f600240496b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//1b57b9597c779f0a20c5837abec31f600240496b
Author:        Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
AuthorDate:    Thu, 26 Nov 2020 23:09:23 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 30 Nov 2020 16:38:27 +01:00

thermal: rcar_gen3_thermal: Do not use interrupts for normal operation

Remove the usage of interrupts for the normal temperature operation and
depend on the polling performed by the thermal core. This is done to
prepare to use the interrupts as they are intended to trigger once
specific trip points are passed and not to react to temperature changes
in the normal operational range.

Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201126220923.3107213-1-niklas.soderlund+ren=
esas@ragnatech.se
---
 drivers/thermal/rcar_gen3_thermal.c | 108 +---------------------------
 1 file changed, 2 insertions(+), 106 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_=
thermal.c
index 0dd47dc..94f2c13 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -188,70 +188,10 @@ static int rcar_gen3_thermal_get_temp(void *devdata, in=
t *temp)
 	return 0;
 }
=20
-static int rcar_gen3_thermal_mcelsius_to_temp(struct rcar_gen3_thermal_tsc *=
tsc,
-					      int mcelsius)
-{
-	int celsius, val;
-
-	celsius =3D DIV_ROUND_CLOSEST(mcelsius, 1000);
-	if (celsius <=3D INT_FIXPT(tsc->tj_t))
-		val =3D celsius * tsc->coef.a1 + tsc->coef.b1;
-	else
-		val =3D celsius * tsc->coef.a2 + tsc->coef.b2;
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
-	low =3D temperature - MCELSIUS(1);
-	high =3D temperature + MCELSIUS(1);
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
 static const struct thermal_zone_of_device_ops rcar_gen3_tz_of_ops =3D {
 	.get_temp	=3D rcar_gen3_thermal_get_temp,
 };
=20
-static void rcar_thermal_irq_set(struct rcar_gen3_thermal_priv *priv, bool o=
n)
-{
-	unsigned int i;
-	u32 val =3D on ? IRQ_TEMPD1 | IRQ_TEMP2 : 0;
-
-	for (i =3D 0; i < priv->num_tscs; i++)
-		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQMSK, val);
-}
-
-static irqreturn_t rcar_gen3_thermal_irq(int irq, void *data)
-{
-	struct rcar_gen3_thermal_priv *priv =3D data;
-	u32 status;
-	int i;
-
-	for (i =3D 0; i < priv->num_tscs; i++) {
-		status =3D rcar_gen3_thermal_read(priv->tscs[i], REG_GEN3_IRQSTR);
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
 static const struct soc_device_attribute r8a7795es1[] =3D {
 	{ .soc_id =3D "r8a7795", .revision =3D "ES1.*" },
 	{ /* sentinel */ }
@@ -268,7 +208,6 @@ static void rcar_gen3_thermal_init_r8a7795es1(struct rcar=
_gen3_thermal_tsc *tsc)
=20
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0x3F);
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQMSK, 0);
-	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQEN, IRQ_TEMPD1 | IRQ_TEMP2);
=20
 	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,
 				CTSR_PONM | CTSR_AOUT | CTSR_THBGR | CTSR_VMEN);
@@ -294,7 +233,6 @@ static void rcar_gen3_thermal_init(struct rcar_gen3_therm=
al_tsc *tsc)
=20
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0);
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQMSK, 0);
-	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQEN, IRQ_TEMPD1 | IRQ_TEMP2);
=20
 	reg_val =3D rcar_gen3_thermal_read(tsc, REG_GEN3_THCTR);
 	reg_val |=3D THCTR_THSST;
@@ -345,9 +283,6 @@ MODULE_DEVICE_TABLE(of, rcar_gen3_thermal_dt_ids);
 static int rcar_gen3_thermal_remove(struct platform_device *pdev)
 {
 	struct device *dev =3D &pdev->dev;
-	struct rcar_gen3_thermal_priv *priv =3D dev_get_drvdata(dev);
-
-	rcar_thermal_irq_set(priv, false);
=20
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
@@ -369,8 +304,7 @@ static int rcar_gen3_thermal_probe(struct platform_device=
 *pdev)
 	const int *rcar_gen3_ths_tj_1 =3D of_device_get_match_data(dev);
 	struct resource *res;
 	struct thermal_zone_device *zone;
-	int ret, irq, i;
-	char *irqname;
+	int ret, i;
=20
 	/* default values if FUSEs are missing */
 	/* TODO: Read values from hardware on supported platforms */
@@ -386,28 +320,6 @@ static int rcar_gen3_thermal_probe(struct platform_devic=
e *pdev)
=20
 	platform_set_drvdata(pdev, priv);
=20
-	/*
-	 * Request 2 (of the 3 possible) IRQs, the driver only needs to
-	 * to trigger on the low and high trip points of the current
-	 * temp window at this point.
-	 */
-	for (i =3D 0; i < 2; i++) {
-		irq =3D platform_get_irq(pdev, i);
-		if (irq < 0)
-			return irq;
-
-		irqname =3D devm_kasprintf(dev, GFP_KERNEL, "%s:ch%d",
-					 dev_name(dev), i);
-		if (!irqname)
-			return -ENOMEM;
-
-		ret =3D devm_request_threaded_irq(dev, irq, NULL,
-						rcar_gen3_thermal_irq,
-						IRQF_ONESHOT, irqname, priv);
-		if (ret)
-			return ret;
-	}
-
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
=20
@@ -459,8 +371,6 @@ static int rcar_gen3_thermal_probe(struct platform_device=
 *pdev)
 		if (ret < 0)
 			goto error_unregister;
=20
-		rcar_gen3_thermal_update_range(tsc);
-
 		dev_info(dev, "TSC%d: Loaded %d trip points\n", i, ret);
 	}
=20
@@ -471,8 +381,6 @@ static int rcar_gen3_thermal_probe(struct platform_device=
 *pdev)
 		goto error_unregister;
 	}
=20
-	rcar_thermal_irq_set(priv, true);
-
 	return 0;
=20
 error_unregister:
@@ -481,15 +389,6 @@ error_unregister:
 	return ret;
 }
=20
-static int __maybe_unused rcar_gen3_thermal_suspend(struct device *dev)
-{
-	struct rcar_gen3_thermal_priv *priv =3D dev_get_drvdata(dev);
-
-	rcar_thermal_irq_set(priv, false);
-
-	return 0;
-}
-
 static int __maybe_unused rcar_gen3_thermal_resume(struct device *dev)
 {
 	struct rcar_gen3_thermal_priv *priv =3D dev_get_drvdata(dev);
@@ -499,15 +398,12 @@ static int __maybe_unused rcar_gen3_thermal_resume(stru=
ct device *dev)
 		struct rcar_gen3_thermal_tsc *tsc =3D priv->tscs[i];
=20
 		priv->thermal_init(tsc);
-		rcar_gen3_thermal_update_range(tsc);
 	}
=20
-	rcar_thermal_irq_set(priv, true);
-
 	return 0;
 }
=20
-static SIMPLE_DEV_PM_OPS(rcar_gen3_thermal_pm_ops, rcar_gen3_thermal_suspend,
+static SIMPLE_DEV_PM_OPS(rcar_gen3_thermal_pm_ops, NULL,
 			 rcar_gen3_thermal_resume);
=20
 static struct platform_driver rcar_gen3_thermal_driver =3D {
