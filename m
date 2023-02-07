Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEB668DE8A
	for <lists+linux-pm@lfdr.de>; Tue,  7 Feb 2023 18:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjBGRLQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Feb 2023 12:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjBGRLP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Feb 2023 12:11:15 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD33B3C2BA
        for <linux-pm@vger.kernel.org>; Tue,  7 Feb 2023 09:11:13 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id c13so2595153ejz.1
        for <linux-pm@vger.kernel.org>; Tue, 07 Feb 2023 09:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/fUNiCLNvLYxVN4V7dFrBCGBJ6ieG61uRg7cqDK9W0=;
        b=YPrjSRRviTlxn5O6rsaS9MqRZRJwWRvA7lYzBbOAa2YwRFC78Bf1ZTKkgoCSN4m5og
         6G4n0gtj4pXDTBOpjqtwxCVM6vN+uIlpcd5DlDT7OK9k6Hzj5HH2e9q3MH9h196gHAKr
         cxncKgwVNR15+8Rf0ndXhwowMLP5Pzs5IMmgzNEtdx8I8+Zod7E404Me76XwVqBo7dEX
         s9K9EecJ1goMfRKOg2jPwDqwoISl9CAbUGZA8QvIHikS3ss8f0P1dri4ZtcRxq7rw7fi
         HZrvpv9LdfNjdq2RjrKbkmt4qwVav+GcGQbOf/DSHVffsFp8IS6GgE8L9u+/1k8rD/y6
         p7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/fUNiCLNvLYxVN4V7dFrBCGBJ6ieG61uRg7cqDK9W0=;
        b=I5QygfX4MKwL72CrcT1TAL3sxfXgMPCebkzr8c5NWG1pdSdXQj4Uu9CEYLftK7G0+o
         w6vFDYOiXA5NjL4hPsopk4H+MFGCmrO7Ct6W/fIJc50Z/UwzhNmnTi+mhli8sF8vQern
         rkkZX2YYbO8YNq2aMJEdN4+2aneLWkVF9UyqTcRiLgxChluAT99tqGeRzgxsF+HL/9tJ
         /ja+lnV5JTv+WYjRfA8GuWcALzzTo6pDRCzi90/9CdmPIl5I9w5qUe+4weV7yhNAsviU
         otWWNdQt35zzVKtBKKA5BQRYIMV5LplzOqFHZL3/2NY7ViTbdlhzBscnjWrEmGwQrI9c
         rbGQ==
X-Gm-Message-State: AO0yUKUb/r/duWMzHPEHfP90IQtStiAUwQMnqqEmcp/zjJ856gUTU1Yi
        cKsC28N8Hfj8JN8DnGwp7zWklg==
X-Google-Smtp-Source: AK7set8WtHapdiat1tJByb6ZuWhTjC5JWXfvr+nr4498wduX+U4awp6nDbEJAaEffZcXOQuGf4dqvg==
X-Received: by 2002:a17:907:1c0f:b0:88d:ba89:1836 with SMTP id nc15-20020a1709071c0f00b0088dba891836mr23511262ejc.7.1675789872281;
        Tue, 07 Feb 2023 09:11:12 -0800 (PST)
Received: from sleipner.berto.se (p4fca2792.dip0.t-ipconnect.de. [79.202.39.146])
        by smtp.googlemail.com with ESMTPSA id n23-20020a1709062bd700b007a4e02e32ffsm7132298ejg.60.2023.02.07.09.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 09:11:11 -0800 (PST)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Wolfram Sang <wsa@kernel.org>, linux-pm@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 2/2] drivers/thermal/rcar_gen3_thermal: Fix device initialization
Date:   Tue,  7 Feb 2023 18:10:11 +0100
Message-Id: <20230207171011.1596127-3-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230207171011.1596127-1-niklas.soderlund+renesas@ragnatech.se>
References: <20230207171011.1596127-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal zone is registered before the device is register and the
thermal coefficients are calculated, providing a window for very
incorrect readings.

The reason why the zone was register before the device was fully
initialized was that the presence of the set_trips() callback is used to
determine if the driver supports interrupt or not, as it is not defined
if the device is incapable of interrupts.

Fix this by using the operations structure in the private data instead
of the zone to determine if interrupts are available or not, and
initialize the device before registering the zone.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_gen3_thermal.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index bfa2ff20b945..1dedeece1a00 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -89,7 +89,8 @@ struct rcar_gen3_thermal_priv {
 	struct rcar_gen3_thermal_tsc *tscs[TSC_MAX_NUM];
 	struct thermal_zone_device_ops ops;
 	unsigned int num_tscs;
-	void (*thermal_init)(struct rcar_gen3_thermal_tsc *tsc);
+	void (*thermal_init)(struct rcar_gen3_thermal_priv *priv,
+			     struct rcar_gen3_thermal_tsc *tsc);
 	int ptat[3];
 };
 
@@ -240,7 +241,7 @@ static irqreturn_t rcar_gen3_thermal_irq(int irq, void *data)
 	for (i = 0; i < priv->num_tscs; i++) {
 		status = rcar_gen3_thermal_read(priv->tscs[i], REG_GEN3_IRQSTR);
 		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQSTR, 0);
-		if (status)
+		if (status && priv->tscs[i]->zone)
 			thermal_zone_device_update(priv->tscs[i]->zone,
 						   THERMAL_EVENT_UNSPECIFIED);
 	}
@@ -311,7 +312,8 @@ static bool rcar_gen3_thermal_read_fuses(struct rcar_gen3_thermal_priv *priv)
 	return true;
 }
 
-static void rcar_gen3_thermal_init_r8a7795es1(struct rcar_gen3_thermal_tsc *tsc)
+static void rcar_gen3_thermal_init_r8a7795es1(struct rcar_gen3_thermal_priv *priv,
+					      struct rcar_gen3_thermal_tsc *tsc)
 {
 	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,  CTSR_THBGR);
 	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,  0x0);
@@ -322,7 +324,7 @@ static void rcar_gen3_thermal_init_r8a7795es1(struct rcar_gen3_thermal_tsc *tsc)
 
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0x3F);
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQMSK, 0);
-	if (tsc->zone->ops->set_trips)
+	if (priv->ops.set_trips)
 		rcar_gen3_thermal_write(tsc, REG_GEN3_IRQEN,
 					IRQ_TEMPD1 | IRQ_TEMP2);
 
@@ -338,7 +340,8 @@ static void rcar_gen3_thermal_init_r8a7795es1(struct rcar_gen3_thermal_tsc *tsc)
 	usleep_range(1000, 2000);
 }
 
-static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
+static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_priv *priv,
+				   struct rcar_gen3_thermal_tsc *tsc)
 {
 	u32 reg_val;
 
@@ -350,7 +353,7 @@ static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
 
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0);
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQMSK, 0);
-	if (tsc->zone->ops->set_trips)
+	if (priv->ops.set_trips)
 		rcar_gen3_thermal_write(tsc, REG_GEN3_IRQEN,
 					IRQ_TEMPD1 | IRQ_TEMP2);
 
@@ -510,6 +513,9 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	for (i = 0; i < priv->num_tscs; i++) {
 		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
 
+		priv->thermal_init(priv, tsc);
+		rcar_gen3_thermal_calc_coefs(priv, tsc, *ths_tj_1);
+
 		zone = devm_thermal_of_zone_register(dev, i, tsc, &priv->ops);
 		if (IS_ERR(zone)) {
 			dev_err(dev, "Sensor %u: Can't register thermal zone\n", i);
@@ -518,9 +524,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		}
 		tsc->zone = zone;
 
-		priv->thermal_init(tsc);
-		rcar_gen3_thermal_calc_coefs(priv, tsc, *ths_tj_1);
-
 		tsc->zone->tzp->no_hwmon = false;
 		ret = thermal_add_hwmon_sysfs(tsc->zone);
 		if (ret)
@@ -559,8 +562,8 @@ static int __maybe_unused rcar_gen3_thermal_resume(struct device *dev)
 		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
 		struct thermal_zone_device *zone = tsc->zone;
 
-		priv->thermal_init(tsc);
-		if (zone->ops->set_trips)
+		priv->thermal_init(priv, tsc);
+		if (priv->ops.set_trips)
 			rcar_gen3_thermal_set_trips(zone, zone->prev_low_trip,
 						    zone->prev_high_trip);
 	}
-- 
2.39.1

