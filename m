Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A323DFDC9
	for <lists+linux-pm@lfdr.de>; Wed,  4 Aug 2021 11:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbhHDJSy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Aug 2021 05:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236335AbhHDJSx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Aug 2021 05:18:53 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BCDC06179A
        for <linux-pm@vger.kernel.org>; Wed,  4 Aug 2021 02:18:39 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id x17so769014wmc.5
        for <linux-pm@vger.kernel.org>; Wed, 04 Aug 2021 02:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A71UIIEmzxTy7xNVG4UT+r8JIzT4ioreK+2pBDNyN20=;
        b=zkt74dOJS36CObDVjtaEwjz7ph7JDKjOPdvWu2MbeghkW6zlgm1V6MVNJ7gDWjLagI
         Lzoh47c+NSDiWdgLkveTEFKscLhQpH7dLD+viQypVnayatRUf0Hmi6j3a+tM8AP4Sye2
         oQAqYuXEbEDRCBGcWQewYR3wp1sMMcaqS8tMTOyRd2p1lnn7ExgcjtOUA6QhJTCcG9lt
         VtVQ+wLzr2Mk4I1CXy+p1KJf/oh47kMKRB9Q45js9ynZ8tejm80BrLmxwEvBbL6qZPqz
         02h0c6JZPrZTk6IVLSBtnt3Q3UjgjYLnSCQ78BpTgWyeTS464x0wFahL+3K6GdkaHMDk
         pgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A71UIIEmzxTy7xNVG4UT+r8JIzT4ioreK+2pBDNyN20=;
        b=In8mwPUhD0ghPkE6QrFuu1ZP1gVsToEMGZ2REjkNjGofUvUZdn3kIJQx3XQ4HMMVI1
         KTep5gYz36FZ5CA9DrQpN68WJu10ss0t6anNQ8efDbCTC6eIwi8Xl8y/G/PyrUU238S3
         KORv/rX53lmryTyxuAl6P31BwF9aW3jpXgQvJfrO+vsegc/fx1EukOYKERkBDbO4kN9S
         hsE40gFQj3Cb4STPEqDLPdPr/HekczijBFBhQ8AYfh6URBQ/yzB/b7Dx/YF5hnTzoqg3
         x7+1dtiglieHFjyEUlp9OOa+JoH/S974cqEcQfubJoi/DBeZeNnWfh5v7qnNX+CpqI0s
         PzoA==
X-Gm-Message-State: AOAM530c3qdqDnE3+EQ33+9pKOWFja0/mmsycmJdrUz8ILOZNLrOuZid
        39JeNhkkL9KXu9VYfjE/mI9ws7PNzY5szQ==
X-Google-Smtp-Source: ABdhPJyJaF9DOSpZqRV/7wf1SZ8CJUoJgD+WJ49fU+rjwhf41MhVId0ASIUSquwUMZNyzqmEKtk36g==
X-Received: by 2002:a05:600c:35cb:: with SMTP id r11mr3195575wmq.31.1628068718549;
        Wed, 04 Aug 2021 02:18:38 -0700 (PDT)
Received: from bismarck.berto.se (p4fca2222.dip0.t-ipconnect.de. [79.202.34.34])
        by smtp.googlemail.com with ESMTPSA id f74sm1653172wmf.16.2021.08.04.02.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 02:18:38 -0700 (PDT)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-pm@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v2 1/2] thermal: rcar_gen3_thermal: Add support for hardware trip points
Date:   Wed,  4 Aug 2021 11:18:17 +0200
Message-Id: <20210804091818.2196806-2-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210804091818.2196806-1-niklas.soderlund+renesas@ragnatech.se>
References: <20210804091818.2196806-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All supported hardware except V3U is capable of generating interrupts
to the CPU when the temperature go below or above a set value. Use this
to implement support for the set_trip() feature of the thermal core on
supported hardware.

The V3U have its interrupts routed to the ECM module and therefore can
not be used to implement set_trip() as the driver can't be made aware of
when the interrupt triggers.

Each TSC is capable of tracking up-to three different temperatures while
only two are needed to implement the tracking of the thermal window.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
* Changes since v1
- Remove the 'have_irq' flag from the OF match data and auto-detect if
  interrupts are available using platform_get_irq_optional().
- Have a non-static thermal_zone_of_device_ops and clear the .set_trips
  if interrupts are unavailable.
---
 drivers/thermal/rcar_gen3_thermal.c | 103 ++++++++++++++++++++++++++--
 1 file changed, 99 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index fdf16aa34eb470c7..e49593437edeb3ca 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -190,10 +190,64 @@ static int rcar_gen3_thermal_get_temp(void *devdata, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops rcar_gen3_tz_of_ops = {
+static int rcar_gen3_thermal_mcelsius_to_temp(struct rcar_gen3_thermal_tsc *tsc,
+					      int mcelsius)
+{
+	int celsius, val;
+
+	celsius = DIV_ROUND_CLOSEST(mcelsius, 1000);
+	if (celsius <= INT_FIXPT(tsc->tj_t))
+		val = celsius * tsc->coef.a1 + tsc->coef.b1;
+	else
+		val = celsius * tsc->coef.a2 + tsc->coef.b2;
+
+	return INT_FIXPT(val);
+}
+
+static int rcar_gen3_thermal_set_trips(void *devdata, int low, int high)
+{
+	struct rcar_gen3_thermal_tsc *tsc = devdata;
+	u32 irqmsk = 0;
+
+	if (low != -INT_MAX) {
+		irqmsk |= IRQ_TEMPD1;
+		rcar_gen3_thermal_write(tsc, REG_GEN3_IRQTEMP1,
+					rcar_gen3_thermal_mcelsius_to_temp(tsc, low));
+	}
+
+	if (high != INT_MAX) {
+		irqmsk |= IRQ_TEMP2;
+		rcar_gen3_thermal_write(tsc, REG_GEN3_IRQTEMP2,
+					rcar_gen3_thermal_mcelsius_to_temp(tsc, high));
+	}
+
+	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQMSK, irqmsk);
+
+	return 0;
+}
+
+static struct thermal_zone_of_device_ops rcar_gen3_tz_of_ops = {
 	.get_temp	= rcar_gen3_thermal_get_temp,
+	.set_trips	= rcar_gen3_thermal_set_trips,
 };
 
+static irqreturn_t rcar_gen3_thermal_irq(int irq, void *data)
+{
+	struct rcar_gen3_thermal_priv *priv = data;
+	unsigned int i;
+	u32 status;
+
+	for (i = 0; i < priv->num_tscs; i++) {
+		status = rcar_gen3_thermal_read(priv->tscs[i], REG_GEN3_IRQSTR);
+		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQSTR, 0);
+		if (status)
+			thermal_zone_device_update(priv->tscs[i]->zone,
+						   THERMAL_EVENT_UNSPECIFIED);
+	}
+
+	return IRQ_HANDLED;
+}
+
 static const struct soc_device_attribute r8a7795es1[] = {
 	{ .soc_id = "r8a7795", .revision = "ES1.*" },
 	{ /* sentinel */ }
@@ -210,6 +264,9 @@ static void rcar_gen3_thermal_init_r8a7795es1(struct rcar_gen3_thermal_tsc *tsc)
 
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0x3F);
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQMSK, 0);
+	if (tsc->zone->ops->set_trips)
+		rcar_gen3_thermal_write(tsc, REG_GEN3_IRQEN,
+					IRQ_TEMPD1 | IRQ_TEMP2);
 
 	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,
 				CTSR_PONM | CTSR_AOUT | CTSR_THBGR | CTSR_VMEN);
@@ -235,6 +292,9 @@ static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
 
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0);
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQMSK, 0);
+	if (tsc->zone->ops->set_trips)
+		rcar_gen3_thermal_write(tsc, REG_GEN3_IRQEN,
+					IRQ_TEMPD1 | IRQ_TEMP2);
 
 	reg_val = rcar_gen3_thermal_read(tsc, REG_GEN3_THCTR);
 	reg_val |= THCTR_THSST;
@@ -303,6 +363,34 @@ static void rcar_gen3_hwmon_action(void *data)
 	thermal_remove_hwmon_sysfs(zone);
 }
 
+static int rcar_gen3_thermal_request_irqs(struct rcar_gen3_thermal_priv *priv,
+					  struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	unsigned int i;
+	char *irqname;
+	int ret, irq;
+
+	for (i = 0; i < 2; i++) {
+		irq = platform_get_irq_optional(pdev, i);
+		if (irq < 0)
+			return irq;
+
+		irqname = devm_kasprintf(dev, GFP_KERNEL, "%s:ch%d",
+					 dev_name(dev), i);
+		if (!irqname)
+			return -ENOMEM;
+
+		ret = devm_request_threaded_irq(dev, irq, NULL,
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
@@ -326,6 +414,9 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
+	if (rcar_gen3_thermal_request_irqs(priv, pdev))
+		rcar_gen3_tz_of_ops.set_trips = NULL;
+
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
@@ -351,9 +442,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 
 		priv->tscs[i] = tsc;
 
-		priv->thermal_init(tsc);
-		rcar_gen3_thermal_calc_coefs(tsc, ptat, thcodes[i], *ths_tj_1);
-
 		zone = devm_thermal_zone_of_sensor_register(dev, i, tsc,
 							    &rcar_gen3_tz_of_ops);
 		if (IS_ERR(zone)) {
@@ -363,6 +451,9 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		}
 		tsc->zone = zone;
 
+		priv->thermal_init(tsc);
+		rcar_gen3_thermal_calc_coefs(tsc, ptat, thcodes[i], *ths_tj_1);
+
 		tsc->zone->tzp->no_hwmon = false;
 		ret = thermal_add_hwmon_sysfs(tsc->zone);
 		if (ret)
@@ -401,8 +492,12 @@ static int __maybe_unused rcar_gen3_thermal_resume(struct device *dev)
 
 	for (i = 0; i < priv->num_tscs; i++) {
 		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
+		struct thermal_zone_device *zone = tsc->zone;
 
 		priv->thermal_init(tsc);
+		if (zone->ops->set_trips)
+			rcar_gen3_thermal_set_trips(tsc, zone->prev_low_trip,
+						    zone->prev_high_trip);
 	}
 
 	return 0;
-- 
2.32.0

