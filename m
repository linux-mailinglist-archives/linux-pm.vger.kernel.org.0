Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967683BE896
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 15:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhGGNQ2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jul 2021 09:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbhGGNQZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jul 2021 09:16:25 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3211C061766
        for <linux-pm@vger.kernel.org>; Wed,  7 Jul 2021 06:13:43 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id h18-20020a05600c3512b029020e4ceb9588so4208129wmq.5
        for <linux-pm@vger.kernel.org>; Wed, 07 Jul 2021 06:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b+ppEpbWRmkGcXeCKQo2IL+aAX51yIlSVHR4b05C1K8=;
        b=qrkDi2z0KEFxwHixTE+5hcregz3SPAnVZlVlM2tCjltIMgPE289xWale/Yqzzn+aOF
         Bofy/ZyU9GTmOTDJoD78VFztGTV3BERwWaa/xMb7M9AYEqM4/Ht+DPHuT9suC5nnDw/b
         qjvaTEAV+B3t7KeAeimR2ecMAm4H3cpaClnAn+7T3QBxLI67OIfxhEsVzqrMH13wh2oz
         W+1IDVsXGIdP1pLwCeHVUo4fl9BVDClCKUr5ReQYcA5hLSFY3DIhWDRvnT5uOBacTykK
         a2pJNtE2j5WlKYARgfXLOTEYp9X1XcZh5pos7xsdY1HaOPmLcHsun07d74KBlUrxvU0O
         lY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b+ppEpbWRmkGcXeCKQo2IL+aAX51yIlSVHR4b05C1K8=;
        b=bYqu4fD6IX5hp5fb/L/YX+IATjXraH79YpKrIcdAQ/VLimbVDhMDX+YzEhL9QvPxUc
         oQoFMJpUB1pG8NE1VkBsEXj4MoXAzrxaRBF78r1AQpBKY0OOcIYZ64dDSpuywHUDg1ig
         z7FZik+hbp1VGoVaPekcQcgDfXQ/X9rF/J1EEieGs0PoxeywejXlG6kJSNah2jI+fGOg
         sXfheNaeOGQ/WZVhOYggz5c+iLoXXRQfn98TNZ/N9dLRY4ODffJLTIW0eSLurjJcCYmc
         T84HUsmFDOfTPbUFnxK0hn8sr/ATfYV0zjr0gD5kRU/eJUdccvL9GyrgMXXBkS4YiKTh
         8ZwQ==
X-Gm-Message-State: AOAM531Wdfusu+5FOeeKQ07KFRJDSzgk1wWhstqKW1dk4tk/z42Gwlw4
        w5jQDPJRtiW9hwWQTWfv+Hk//w==
X-Google-Smtp-Source: ABdhPJzQfcK5I06QTwGrVPF8P+x3RVJWCIybxr92Wgi8gv3cliCqh0fHDSdOQV8WvXWNa8kE08eiJQ==
X-Received: by 2002:a1c:f414:: with SMTP id z20mr6954905wma.94.1625663621379;
        Wed, 07 Jul 2021 06:13:41 -0700 (PDT)
Received: from bismarck.berto.se (p4fca2710.dip0.t-ipconnect.de. [79.202.39.16])
        by smtp.googlemail.com with ESMTPSA id l20sm19233670wmq.3.2021.07.07.06.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 06:13:41 -0700 (PDT)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 2/3] thermal: rcar_gen3_thermal: Add support for hardware trip points
Date:   Wed,  7 Jul 2021 15:13:05 +0200
Message-Id: <20210707131306.4098443-3-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210707131306.4098443-1-niklas.soderlund+renesas@ragnatech.se>
References: <20210707131306.4098443-1-niklas.soderlund+renesas@ragnatech.se>
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
 drivers/thermal/rcar_gen3_thermal.c | 130 ++++++++++++++++++++++++++--
 1 file changed, 123 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 770f1daae5379053..a438e05e7ca7f20e 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -81,6 +81,7 @@ struct equation_coefs {
 
 struct rcar_gen3_thermal_info {
 	int ths_tj_1;
+	bool have_irq;
 };
 
 struct rcar_gen3_thermal_tsc {
@@ -95,7 +96,8 @@ struct rcar_gen3_thermal_priv {
 	const struct rcar_gen3_thermal_info *info;
 	struct rcar_gen3_thermal_tsc *tscs[TSC_MAX_NUM];
 	unsigned int num_tscs;
-	void (*thermal_init)(struct rcar_gen3_thermal_tsc *tsc);
+	void (*thermal_init)(struct rcar_gen3_thermal_priv *priv,
+			     struct rcar_gen3_thermal_tsc *tsc);
 };
 
 static inline u32 rcar_gen3_thermal_read(struct rcar_gen3_thermal_tsc *tsc,
@@ -195,16 +197,75 @@ static int rcar_gen3_thermal_get_temp(void *devdata, int *temp)
 	return 0;
 }
 
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
 static const struct thermal_zone_of_device_ops rcar_gen3_tz_of_ops = {
 	.get_temp	= rcar_gen3_thermal_get_temp,
+	.set_trips	= rcar_gen3_thermal_set_trips,
 };
 
+static const struct thermal_zone_of_device_ops rcar_gen3_tz_of_ops_no_irq = {
+	.get_temp	= rcar_gen3_thermal_get_temp,
+};
+
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
 };
 
-static void rcar_gen3_thermal_init_r8a7795es1(struct rcar_gen3_thermal_tsc *tsc)
+static void rcar_gen3_thermal_init_r8a7795es1(struct rcar_gen3_thermal_priv *priv,
+					      struct rcar_gen3_thermal_tsc *tsc)
 {
 	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,  CTSR_THBGR);
 	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,  0x0);
@@ -215,6 +276,9 @@ static void rcar_gen3_thermal_init_r8a7795es1(struct rcar_gen3_thermal_tsc *tsc)
 
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0x3F);
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQMSK, 0);
+	if (priv->info->have_irq)
+		rcar_gen3_thermal_write(tsc, REG_GEN3_IRQEN,
+					IRQ_TEMPD1 | IRQ_TEMP2);
 
 	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,
 				CTSR_PONM | CTSR_AOUT | CTSR_THBGR | CTSR_VMEN);
@@ -228,7 +292,8 @@ static void rcar_gen3_thermal_init_r8a7795es1(struct rcar_gen3_thermal_tsc *tsc)
 	usleep_range(1000, 2000);
 }
 
-static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
+static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_priv *priv,
+				   struct rcar_gen3_thermal_tsc *tsc)
 {
 	u32 reg_val;
 
@@ -240,6 +305,9 @@ static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
 
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0);
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQMSK, 0);
+	if (priv->info->have_irq)
+		rcar_gen3_thermal_write(tsc, REG_GEN3_IRQEN,
+					IRQ_TEMPD1 | IRQ_TEMP2);
 
 	reg_val = rcar_gen3_thermal_read(tsc, REG_GEN3_THCTR);
 	reg_val |= THCTR_THSST;
@@ -250,10 +318,16 @@ static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
 
 static const struct rcar_gen3_thermal_info rcar_gen3_thermal_gen3 = {
 	.ths_tj_1 = 126,
+	.have_irq = true,
 };
 
 static const struct rcar_gen3_thermal_info rcar_gen3_thermal_m3w = {
 	.ths_tj_1 = 116,
+	.have_irq = true,
+};
+
+static const struct rcar_gen3_thermal_info rcar_gen3_thermal_v3u = {
+	.ths_tj_1 = 126,
 };
 
 static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
@@ -291,7 +365,7 @@ static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
 	},
 	{
 		.compatible = "renesas,r8a779a0-thermal",
-		.data = &rcar_gen3_thermal_gen3,
+		.data = &rcar_gen3_thermal_v3u,
 	},
 	{},
 };
@@ -314,8 +388,37 @@ static void rcar_gen3_hwmon_action(void *data)
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
+		irq = platform_get_irq(pdev, i);
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
+	const struct thermal_zone_of_device_ops *tz_of_ops;
 	struct rcar_gen3_thermal_priv *priv;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
@@ -338,6 +441,15 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
+	tz_of_ops = &rcar_gen3_tz_of_ops_no_irq;
+	if (priv->info->have_irq) {
+		ret = rcar_gen3_thermal_request_irqs(priv, pdev);
+		if (ret)
+			return ret;
+
+		tz_of_ops = &rcar_gen3_tz_of_ops;
+	}
+
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
@@ -363,12 +475,12 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 
 		priv->tscs[i] = tsc;
 
-		priv->thermal_init(tsc);
+		priv->thermal_init(priv, tsc);
 		rcar_gen3_thermal_calc_coefs(tsc, ptat, thcodes[i],
 					     priv->info->ths_tj_1);
 
 		zone = devm_thermal_zone_of_sensor_register(dev, i, tsc,
-							    &rcar_gen3_tz_of_ops);
+							    tz_of_ops);
 		if (IS_ERR(zone)) {
 			dev_err(dev, "Can't register thermal zone\n");
 			ret = PTR_ERR(zone);
@@ -414,8 +526,12 @@ static int __maybe_unused rcar_gen3_thermal_resume(struct device *dev)
 
 	for (i = 0; i < priv->num_tscs; i++) {
 		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
+		struct thermal_zone_device *zone = tsc->zone;
 
-		priv->thermal_init(tsc);
+		priv->thermal_init(priv, tsc);
+		if (priv->info->have_irq)
+			rcar_gen3_thermal_set_trips(tsc, zone->prev_low_trip,
+						    zone->prev_high_trip);
 	}
 
 	return 0;
-- 
2.32.0

