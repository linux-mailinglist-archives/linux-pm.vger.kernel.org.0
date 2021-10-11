Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BACA4429991
	for <lists+linux-pm@lfdr.de>; Tue, 12 Oct 2021 00:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbhJKXAR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Oct 2021 19:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbhJKXAQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Oct 2021 19:00:16 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF10CC06161C
        for <linux-pm@vger.kernel.org>; Mon, 11 Oct 2021 15:58:15 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u18so60976986wrg.5
        for <linux-pm@vger.kernel.org>; Mon, 11 Oct 2021 15:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pn14IuVJg5cHmUa2BU6D6/oXtH1qICDQLXwkbJStSzE=;
        b=nTdkHZKORyH6g2yiu+d0M9ifLE7PabYt/uoQjJWAEvLNls7HvW0C29Pw4HPtTQqG2G
         qEKJvOEJjCDhzIt93Ts2QZLlzg6JRTxrsptHUmmhSv00Tb5IQX58YPCySf25gb9FyUx5
         p60YsNUnpFQ+uB+WqnEy/9IoCc2ttsy02giIX+uqh5xSuW5vCWIr2jqieRr6tY9c+w4W
         Z/AQesF+uc47nayE+sv+Nj21xO54zlXYaq0NsXTbTTX9L7aJgrbphv5kyU2/sWQlp0sJ
         eLUwaozudHRn8UzrSvvqbXPqNAgb+2hakb6sp5lVTKst0Zm1i17beGpcwzh+tBHyBdDd
         fQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pn14IuVJg5cHmUa2BU6D6/oXtH1qICDQLXwkbJStSzE=;
        b=NsMmVWhMJP/PKza0A3SQaSwYH+zNljqowQF61dMCRNjh3+5wC9ib34jhgfssmT0IhU
         BSDvvh+YlHGoB0c79wLvfUrme6nB03rihj2/5bMkMSEcWqn+MwTDKVlzEm7aFc1hpA61
         rRZZPSvsENzuTRpYfYJMYEVQh6QKxKrCSbQcIU4twRO1Mjk1jqwU6rZ3dM+ecIAG+gTY
         gVxrniSPC7KqLxuYRWgC7EFHlsXueTnQV7ClbMmmqBtyJdxo76FW/ZUHmEcToIED0KbE
         Lq9Zc8InN1HEsx67dNjUYcdeLhHHNAlcDrlQuAzB931iBhb848IRfiu1naTDH/u95imf
         9oFA==
X-Gm-Message-State: AOAM532LLwuXr/HhxA1TKfuKQpUOsIRxgfF5UFbkFWWhF8VUVBu+LWEJ
        85DaOZ0IcFDU80tkBIVFjOdEnw==
X-Google-Smtp-Source: ABdhPJxYMWAxykwcFGkqewxLq+Hj2KuJazU5zWAaug0Okk+BEvkDutijtQZmnkxOsWNrVqjqq4Ymqg==
X-Received: by 2002:a05:6000:1889:: with SMTP id a9mr12111829wri.400.1633993094532;
        Mon, 11 Oct 2021 15:58:14 -0700 (PDT)
Received: from bismarck.berto.se (p54ac5892.dip0.t-ipconnect.de. [84.172.88.146])
        by smtp.googlemail.com with ESMTPSA id h8sm9240890wrm.27.2021.10.11.15.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 15:58:14 -0700 (PDT)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-pm@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 2/2] thermal: rcar_gen3_thermal: Read calibration from hardware
Date:   Tue, 12 Oct 2021 00:58:02 +0200
Message-Id: <20211011225802.11497-3-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011225802.11497-1-niklas.soderlund+renesas@ragnatech.se>
References: <20211011225802.11497-1-niklas.soderlund+renesas@ragnatech.se>
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
---
* Changes since RFT
- Keep thcodes array static.
---
 drivers/thermal/rcar_gen3_thermal.c | 94 +++++++++++++++++++++++------
 1 file changed, 74 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 7d7e6ebe837a83af..897b625e1b498f05 100644
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
 
+static bool rcar_gen3_thermal_update_fuses(struct rcar_gen3_thermal_priv *priv)
+{
+	unsigned int i;
+	u32 thscp;
+
+	/* Default THCODE values in case FUSEs are not set. */
+	static const int thcodes[TSC_MAX_NUM][3] = {
+		{ 3397, 2800, 2221 },
+		{ 3393, 2795, 2216 },
+		{ 3389, 2805, 2237 },
+		{ 3415, 2694, 2195 },
+		{ 3356, 2724, 2244 },
+	};
+
+	/* If fuses are not set, fallback to pseudo values. */
+	thscp = rcar_gen3_thermal_read(priv->tscs[0], REG_GEN3_THSCP);
+	if ((thscp & THSCP_COR_PARA_VLD) != THSCP_COR_PARA_VLD) {
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
+	if (rcar_gen3_thermal_update_fuses(priv))
+		dev_info(dev, "Using fused calibration values\n");
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

