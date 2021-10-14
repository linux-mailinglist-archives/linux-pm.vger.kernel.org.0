Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7B942D73E
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 12:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhJNKlE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 06:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhJNKlE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Oct 2021 06:41:04 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566ADC06174E
        for <linux-pm@vger.kernel.org>; Thu, 14 Oct 2021 03:38:59 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m22so18151225wrb.0
        for <linux-pm@vger.kernel.org>; Thu, 14 Oct 2021 03:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JNQ7unH4p4GdzAmfmmLNFZaa88jcFz4jGRQ3QMWXmys=;
        b=X+nzPW2LmuNF1vhvZeCIkvFlygn6hXzs4j5UQPxmy++/MmYN48Y3D245dZlAtKEFmt
         7+ohu76X0KS62dTIUrbHqon0+r0hc2woDpB8waSGa0iUKQsAJqENa0adicL6cdPNIDdU
         eXt+aL2Pmb2xLj9yLGl+RHuqfCA/3RyQix83YCoh7K+23mZRb9fBMPXJGBzbKuo3PKS+
         h/rqWVI7G5S2HPTBFrWGc2TcZtUPtpvpQ7LbA3CnZbOdwIfPSOC6n2kU3S9TjPQorcQk
         Qqvsz7sXVTBybVWyYMXcH2QWywAruJDLuqUod9hY9biBlG8usoa2014Wx1ckoZT4Z705
         sXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JNQ7unH4p4GdzAmfmmLNFZaa88jcFz4jGRQ3QMWXmys=;
        b=qdpRdmGqHbfGQ4xYkIHrSMs2kea2BRc/gkqnSnrs3AEHAlRSFJuog9Uk55PcUFwPYW
         x2zJ8ZA9FLUV58KadOvN4gH1kkkBDsvkNeAltxM6lDekUlQ9H8e6gHEFyLqrkMVL6qFT
         CjbJNQM4RQwlqldWTJfHzvnxa4P8VxIW1QZUHTWd5WazhLjq/MzLA1Tpmwf5PBIxC9zk
         wui1jqbpWydVNEvxeS2WOOyzVTuKjjQra8oofYVJinkc7l+90uwhCQZkML8iIJA+UWcN
         Iq/7NUmX/35G1Lcdab6HrzGxwW+KewLXFPlKuTufNsDpGo/GJsba2NU+NhxQChS/2V94
         Kflg==
X-Gm-Message-State: AOAM531PGd0Vq/69oDgTePqhjFUMmCyyiAoeG+xrsQ986XZSwWhOkjp5
        G6SApmERJD8wmPMW1gnKQxK9hQ==
X-Google-Smtp-Source: ABdhPJxFMvv4aXFUEoE22MmikRgoJYR38KUuaS7BlIDaD/6ShxRxoSobLRxGHAjKcPaA5o9/j0kfcg==
X-Received: by 2002:a5d:63ca:: with SMTP id c10mr5578771wrw.407.1634207937942;
        Thu, 14 Oct 2021 03:38:57 -0700 (PDT)
Received: from bismarck.berto.se (p54ac5892.dip0.t-ipconnect.de. [84.172.88.146])
        by smtp.googlemail.com with ESMTPSA id f6sm1744976wmj.28.2021.10.14.03.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 03:38:57 -0700 (PDT)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 2/2] thermal: rcar_gen3_thermal: Read calibration from hardware
Date:   Thu, 14 Oct 2021 12:38:16 +0200
Message-Id: <20211014103816.1939782-3-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211014103816.1939782-1-niklas.soderlund+renesas@ragnatech.se>
References: <20211014103816.1939782-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In production hardware the calibration values used to convert register
values to temperatures can be read from hardware. While pre-production
hardware still depends on pseudo values hard-coded in the driver.

Add support for reading out calibration values from hardware if it's
fused. The presence of fused calibration is indicated in the THSCP
register.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
* Changes since v1
- Renamed rcar_gen3_thermal_update_fuses() to
  rcar_gen3_thermal_read_fuses().
- Move static thcodes array inside the 'if' block where it's used.
- Invert dev_info logic to only inform if there are no fused
  calibration values, instead of logging if they are set as this should
  be the default case in production systems.
- Collect tags.

* Changes since RFT
- Keep thcodes array static.
---
 drivers/thermal/rcar_gen3_thermal.c | 94 +++++++++++++++++++++++------
 1 file changed, 74 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 7d7e6ebe837a83af..43eb25b167bc006f 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -34,6 +34,10 @@
 #define REG_GEN3_THCODE1	0x50
 #define REG_GEN3_THCODE2	0x54
 #define REG_GEN3_THCODE3	0x58
+#define REG_GEN3_PTAT1		0x5c
+#define REG_GEN3_PTAT2		0x60
+#define REG_GEN3_PTAT3		0x64
+#define REG_GEN3_THSCP		0x68
 
 /* IRQ{STR,MSK,EN} bits */
 #define IRQ_TEMP1		BIT(0)
@@ -55,6 +59,9 @@
 #define THCTR_PONM	BIT(6)
 #define THCTR_THSST	BIT(0)
 
+/* THSCP bits */
+#define THSCP_COR_PARA_VLD	(BIT(15) | BIT(14))
+
 #define CTEMP_MASK	0xFFF
 
 #define MCELSIUS(temp)	((temp) * 1000)
@@ -245,6 +252,64 @@ static const struct soc_device_attribute r8a7795es1[] = {
 	{ /* sentinel */ }
 };
 
+static bool rcar_gen3_thermal_read_fuses(struct rcar_gen3_thermal_priv *priv)
+{
+	unsigned int i;
+	u32 thscp;
+
+	/* If fuses are not set, fallback to pseudo values. */
+	thscp = rcar_gen3_thermal_read(priv->tscs[0], REG_GEN3_THSCP);
+	if ((thscp & THSCP_COR_PARA_VLD) != THSCP_COR_PARA_VLD) {
+		/* Default THCODE values in case FUSEs are not set. */
+		static const int thcodes[TSC_MAX_NUM][3] = {
+			{ 3397, 2800, 2221 },
+			{ 3393, 2795, 2216 },
+			{ 3389, 2805, 2237 },
+			{ 3415, 2694, 2195 },
+			{ 3356, 2724, 2244 },
+		};
+
+		priv->ptat[0] = 2631;
+		priv->ptat[1] = 1509;
+		priv->ptat[2] = 435;
+
+		for (i = 0; i < priv->num_tscs; i++) {
+			struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
+
+			tsc->thcode[0] = thcodes[i][0];
+			tsc->thcode[1] = thcodes[i][1];
+			tsc->thcode[2] = thcodes[i][2];
+		}
+
+		return false;
+	}
+
+	/*
+	 * Set the pseudo calibration points with fused values.
+	 * PTAT is shared between all TSCs but only fused for the first
+	 * TSC while THCODEs are fused for each TSC.
+	 */
+	priv->ptat[0] = rcar_gen3_thermal_read(priv->tscs[0], REG_GEN3_PTAT1) &
+		GEN3_FUSE_MASK;
+	priv->ptat[1] = rcar_gen3_thermal_read(priv->tscs[0], REG_GEN3_PTAT2) &
+		GEN3_FUSE_MASK;
+	priv->ptat[2] = rcar_gen3_thermal_read(priv->tscs[0], REG_GEN3_PTAT3) &
+		GEN3_FUSE_MASK;
+
+	for (i = 0; i < priv->num_tscs; i++) {
+		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
+
+		tsc->thcode[0] = rcar_gen3_thermal_read(tsc, REG_GEN3_THCODE1) &
+			GEN3_FUSE_MASK;
+		tsc->thcode[1] = rcar_gen3_thermal_read(tsc, REG_GEN3_THCODE2) &
+			GEN3_FUSE_MASK;
+		tsc->thcode[2] = rcar_gen3_thermal_read(tsc, REG_GEN3_THCODE3) &
+			GEN3_FUSE_MASK;
+	}
+
+	return true;
+}
+
 static void rcar_gen3_thermal_init_r8a7795es1(struct rcar_gen3_thermal_tsc *tsc)
 {
 	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,  CTSR_THBGR);
@@ -393,16 +458,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	unsigned int i;
 	int ret;
 
-	/* Default THCODE values in case FUSEs are not set. */
-	/* TODO: Read values from hardware on supported platforms */
-	static const int thcodes[TSC_MAX_NUM][3] = {
-		{ 3397, 2800, 2221 },
-		{ 3393, 2795, 2216 },
-		{ 3389, 2805, 2237 },
-		{ 3415, 2694, 2195 },
-		{ 3356, 2724, 2244 },
-	};
-
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
@@ -411,10 +466,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	if (soc_device_match(r8a7795es1))
 		priv->thermal_init = rcar_gen3_thermal_init_r8a7795es1;
 
-	priv->ptat[0] = 2631;
-	priv->ptat[1] = 1509;
-	priv->ptat[2] = 435;
-
 	platform_set_drvdata(pdev, priv);
 
 	if (rcar_gen3_thermal_request_irqs(priv, pdev))
@@ -442,11 +493,16 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 			goto error_unregister;
 		}
 
-		tsc->thcode[0] = thcodes[i][0];
-		tsc->thcode[1] = thcodes[i][1];
-		tsc->thcode[2] = thcodes[i][2];
-
 		priv->tscs[i] = tsc;
+	}
+
+	priv->num_tscs = i;
+
+	if (!rcar_gen3_thermal_read_fuses(priv))
+		dev_info(dev, "No calibration values fused, fallback to driver values\n");
+
+	for (i = 0; i < priv->num_tscs; i++) {
+		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
 
 		zone = devm_thermal_zone_of_sensor_register(dev, i, tsc,
 							    &rcar_gen3_tz_of_ops);
@@ -476,8 +532,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		dev_info(dev, "TSC%u: Loaded %d trip points\n", i, ret);
 	}
 
-	priv->num_tscs = i;
-
 	if (!priv->num_tscs) {
 		ret = -ENODEV;
 		goto error_unregister;
-- 
2.33.0

