Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0DC405998
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 16:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbhIIOsQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 10:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237641AbhIIOrv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 10:47:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C5CC0560C7
        for <linux-pm@vger.kernel.org>; Thu,  9 Sep 2021 07:38:44 -0700 (PDT)
Date:   Thu, 09 Sep 2021 14:38:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631198323;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kSZ2vUyXPgn+DsMr/mZVsIrNwfzkM7dJevM+5yWMgCI=;
        b=mQ9mviqnuYSr/ts0trke+lko59n+bgcKkotFI/+LZYTH7k54EumxqcFXwIxoP7iDg1MiWA
        LH358U1711tbkmcjlCYvl+DyEOSs1Y//brhEsWutyKutrw3y5WMajkZWLOofuNZ706sfzq
        iB80OA2ZIUJssuQtdLD83X47mQM+fYmYvqqUK/pVoH9q7c+PfzGvwzKpweBgwkmOjBra6C
        q1E/BptAq5Kk476nK5EHd3CyGZkdWKYihLm7qW5nrWZx1fivmGeDo+dXwDujNjKyT10GMG
        Ek+7gK0c7yWzRqPKgnldQUy4Q28SVol0Os6KC7j1ow2OkuH/EWG5gGzxoUGchQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631198323;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kSZ2vUyXPgn+DsMr/mZVsIrNwfzkM7dJevM+5yWMgCI=;
        b=8QVKBlHhHtrkY//D8hlDUovCo9FK91hwJoYnpSunxr+udYfwMuRbZccjtHUGY0teqnMIaa
        SpytVFEQDPWptLCw==
From:   thermal-bot for Niklas =?utf-8?q?S=C3=B6derlund?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/rcar_gen3_thermal: Add
 support for hardware trip points
Cc:     niklas.soderlund+renesas@ragnatech.se,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210804091818.2196806-2-niklas.soderlund+renesas@ragnatech.se>
References: <20210804091818.2196806-2-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Message-ID: <163119832268.25758.5178169044027020483.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     47cf09e0f4fc51200ecea15387bec3584562f55d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//47cf09e0f4fc51200ecea15387bec3584562f55d
Author:        Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
AuthorDate:    Wed, 04 Aug 2021 11:18:17 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 14 Aug 2021 12:48:00 +02:00

thermal/drivers/rcar_gen3_thermal: Add support for hardware trip points

All supported hardware except V3U is capable of generating interrupts
to the CPU when the temperature go below or above a set value. Use this
to implement support for the set_trip() feature of the thermal core on
supported hardware.

The V3U have its interrupts routed to the ECM module and therefore can
not be used to implement set_trip() as the driver can't be made aware of
when the interrupt triggers.

Each TSC is capable of tracking up-to three different temperatures while
only two are needed to implement the tracking of the thermal window.

Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210804091818.2196806-2-niklas.soderlund+ren=
esas@ragnatech.se
---
 drivers/thermal/rcar_gen3_thermal.c | 103 +++++++++++++++++++++++++--
 1 file changed, 99 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_=
thermal.c
index fdf16aa..e495934 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -190,10 +190,64 @@ static int rcar_gen3_thermal_get_temp(void *devdata, in=
t *temp)
 	return 0;
 }
=20
-static const struct thermal_zone_of_device_ops rcar_gen3_tz_of_ops =3D {
+static int rcar_gen3_thermal_mcelsius_to_temp(struct rcar_gen3_thermal_tsc *=
tsc,
+					      int mcelsius)
+{
+	int celsius, val;
+
+	celsius =3D DIV_ROUND_CLOSEST(mcelsius, 1000);
+	if (celsius <=3D INT_FIXPT(tsc->tj_t))
+		val =3D celsius * tsc->coef.a1 + tsc->coef.b1;
+	else
+		val =3D celsius * tsc->coef.a2 + tsc->coef.b2;
+
+	return INT_FIXPT(val);
+}
+
+static int rcar_gen3_thermal_set_trips(void *devdata, int low, int high)
+{
+	struct rcar_gen3_thermal_tsc *tsc =3D devdata;
+	u32 irqmsk =3D 0;
+
+	if (low !=3D -INT_MAX) {
+		irqmsk |=3D IRQ_TEMPD1;
+		rcar_gen3_thermal_write(tsc, REG_GEN3_IRQTEMP1,
+					rcar_gen3_thermal_mcelsius_to_temp(tsc, low));
+	}
+
+	if (high !=3D INT_MAX) {
+		irqmsk |=3D IRQ_TEMP2;
+		rcar_gen3_thermal_write(tsc, REG_GEN3_IRQTEMP2,
+					rcar_gen3_thermal_mcelsius_to_temp(tsc, high));
+	}
+
+	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQMSK, irqmsk);
+
+	return 0;
+}
+
+static struct thermal_zone_of_device_ops rcar_gen3_tz_of_ops =3D {
 	.get_temp	=3D rcar_gen3_thermal_get_temp,
+	.set_trips	=3D rcar_gen3_thermal_set_trips,
 };
=20
+static irqreturn_t rcar_gen3_thermal_irq(int irq, void *data)
+{
+	struct rcar_gen3_thermal_priv *priv =3D data;
+	unsigned int i;
+	u32 status;
+
+	for (i =3D 0; i < priv->num_tscs; i++) {
+		status =3D rcar_gen3_thermal_read(priv->tscs[i], REG_GEN3_IRQSTR);
+		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQSTR, 0);
+		if (status)
+			thermal_zone_device_update(priv->tscs[i]->zone,
+						   THERMAL_EVENT_UNSPECIFIED);
+	}
+
+	return IRQ_HANDLED;
+}
+
 static const struct soc_device_attribute r8a7795es1[] =3D {
 	{ .soc_id =3D "r8a7795", .revision =3D "ES1.*" },
 	{ /* sentinel */ }
@@ -210,6 +264,9 @@ static void rcar_gen3_thermal_init_r8a7795es1(struct rcar=
_gen3_thermal_tsc *tsc)
=20
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0x3F);
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQMSK, 0);
+	if (tsc->zone->ops->set_trips)
+		rcar_gen3_thermal_write(tsc, REG_GEN3_IRQEN,
+					IRQ_TEMPD1 | IRQ_TEMP2);
=20
 	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,
 				CTSR_PONM | CTSR_AOUT | CTSR_THBGR | CTSR_VMEN);
@@ -235,6 +292,9 @@ static void rcar_gen3_thermal_init(struct rcar_gen3_therm=
al_tsc *tsc)
=20
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0);
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQMSK, 0);
+	if (tsc->zone->ops->set_trips)
+		rcar_gen3_thermal_write(tsc, REG_GEN3_IRQEN,
+					IRQ_TEMPD1 | IRQ_TEMP2);
=20
 	reg_val =3D rcar_gen3_thermal_read(tsc, REG_GEN3_THCTR);
 	reg_val |=3D THCTR_THSST;
@@ -303,6 +363,34 @@ static void rcar_gen3_hwmon_action(void *data)
 	thermal_remove_hwmon_sysfs(zone);
 }
=20
+static int rcar_gen3_thermal_request_irqs(struct rcar_gen3_thermal_priv *pri=
v,
+					  struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	unsigned int i;
+	char *irqname;
+	int ret, irq;
+
+	for (i =3D 0; i < 2; i++) {
+		irq =3D platform_get_irq_optional(pdev, i);
+		if (irq < 0)
+			return irq;
+
+		irqname =3D devm_kasprintf(dev, GFP_KERNEL, "%s:ch%d",
+					 dev_name(dev), i);
+		if (!irqname)
+			return -ENOMEM;
+
+		ret =3D devm_request_threaded_irq(dev, irq, NULL,
+						rcar_gen3_thermal_irq,
+						IRQF_ONESHOT, irqname, priv);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 {
 	struct rcar_gen3_thermal_priv *priv;
@@ -326,6 +414,9 @@ static int rcar_gen3_thermal_probe(struct platform_device=
 *pdev)
=20
 	platform_set_drvdata(pdev, priv);
=20
+	if (rcar_gen3_thermal_request_irqs(priv, pdev))
+		rcar_gen3_tz_of_ops.set_trips =3D NULL;
+
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
=20
@@ -351,9 +442,6 @@ static int rcar_gen3_thermal_probe(struct platform_device=
 *pdev)
=20
 		priv->tscs[i] =3D tsc;
=20
-		priv->thermal_init(tsc);
-		rcar_gen3_thermal_calc_coefs(tsc, ptat, thcodes[i], *ths_tj_1);
-
 		zone =3D devm_thermal_zone_of_sensor_register(dev, i, tsc,
 							    &rcar_gen3_tz_of_ops);
 		if (IS_ERR(zone)) {
@@ -363,6 +451,9 @@ static int rcar_gen3_thermal_probe(struct platform_device=
 *pdev)
 		}
 		tsc->zone =3D zone;
=20
+		priv->thermal_init(tsc);
+		rcar_gen3_thermal_calc_coefs(tsc, ptat, thcodes[i], *ths_tj_1);
+
 		tsc->zone->tzp->no_hwmon =3D false;
 		ret =3D thermal_add_hwmon_sysfs(tsc->zone);
 		if (ret)
@@ -401,8 +492,12 @@ static int __maybe_unused rcar_gen3_thermal_resume(struc=
t device *dev)
=20
 	for (i =3D 0; i < priv->num_tscs; i++) {
 		struct rcar_gen3_thermal_tsc *tsc =3D priv->tscs[i];
+		struct thermal_zone_device *zone =3D tsc->zone;
=20
 		priv->thermal_init(tsc);
+		if (zone->ops->set_trips)
+			rcar_gen3_thermal_set_trips(tsc, zone->prev_low_trip,
+						    zone->prev_high_trip);
 	}
=20
 	return 0;
