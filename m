Return-Path: <linux-pm+bounces-4765-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C5D874CE6
	for <lists+linux-pm@lfdr.de>; Thu,  7 Mar 2024 12:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B787EB21065
	for <lists+linux-pm@lfdr.de>; Thu,  7 Mar 2024 11:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3150B126F3E;
	Thu,  7 Mar 2024 11:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="AodWp4R4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D45B1272BB
	for <linux-pm@vger.kernel.org>; Thu,  7 Mar 2024 11:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709809387; cv=none; b=TbGTrhYc1TRF0cg00bkFLyzHHeprQhV48Ay5cQ2krImJS+nuFqhFcqhAQEubWNg6llSw78oGFNwtnB0ABoY4a5ke7Dn97dFh0OSbm8kVAEorc4u/pKD9NStrViIy/r0lMeRQeHKnNto0MUwHnq3Y0W4xwKlem6rGdXMMx9y1h50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709809387; c=relaxed/simple;
	bh=2m1YY0rIly3m5sSThMMcZIbdwY/oz9s5q3dfrcm+iUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bTMOZ3NIJO3vHLjrrxAF+tZBmGb8K7U2jo1aZMq1nJa6dxeT4afxUWz/mUPbz842DJNKj9tFOJcLV/vBzH1H5dedEH8BIpeZiMFcuIf0d+RVQMD9VWIMZmX7DH3L+Mbr1mup8gO7b4W3sOy2R0jhH8sj4RsOXHgFB/jlybBucgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=AodWp4R4; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso340523766b.1
        for <linux-pm@vger.kernel.org>; Thu, 07 Mar 2024 03:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech.se; s=google; t=1709809383; x=1710414183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNeWp6TemAEi1Zm1Q4VxUUy/msfWwrXc5r2iSOQoraY=;
        b=AodWp4R4RmWjootnDJbZwIsS028MSA6WkcNL9UgdJ0rlXp7EqJcw+4hVUCfoqVM7iu
         MuIHpqqYc4hp55xDzIZ4TX5NspEvv4Ujc3/p2Pu9msHYH+vC+OhaAYY3C+gx3u56rhM7
         JQn4WGWTVH5Ng76omNf4ml4abKzDnAI8CsXocGoO/tMmFCSbJWL0Pv3Vay9aDaJBXRQs
         yqZK7quovnDVzK3EEO4XB7S605epAgJ3Cyfig7V03Tw8jF9lCV+n9AOfjHu6ihSB3e8M
         x6iQ5i6apBHyAyA3JQbjOEGO8ab6j/7VBrh8aspGj0+XDjD+yz4HGAJpfHxZhd+zxPqj
         zEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709809383; x=1710414183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNeWp6TemAEi1Zm1Q4VxUUy/msfWwrXc5r2iSOQoraY=;
        b=FY4yoQciiiSyOThGHpAr6CiOankJ+jHk96m+7leUGF7LBKv3h7+MYiNHttARuYNzLs
         jOPY+MzlxPRqF7a/8csACXKAm39uuBhsWIbSPZzJ0s89TxzwuNiS9qwMfoj5EoUigBCx
         eQuNR2mr2rsFX4OrFz7h2m39pyz1oGOqjagcpkMC0AMkovT9jM4VcWVVCC7XK9Ma6WZ/
         Tcj1ebUnfSAx2ise08u34OQRqqs9u24I7QXb2R4noGP2M/526z0ej4Y3QO3zW3G4Plht
         jYUy/14EWj/tIaJwCXSAX5+yRVcrOA12UwroGcxDlfCRhtFZCF1E8sFuURuKHh/hUyoS
         PJBg==
X-Forwarded-Encrypted: i=1; AJvYcCUuOiaZJGi+BpekmvTwGJL8/EF6EdfURPXd+nDgGMMZytmIP8g8asuwlGJ9SCdATNASEFRfkgBXLtlnb1zN8zRDetTyyau5dxo=
X-Gm-Message-State: AOJu0YyHQYnGJufY7kwE0P3eb/kD9TRVoYewgShhqQvevLLKGlgrua1a
	01h9woUB/T3wWHFcVPEa7QQ2wVTsgQ2TQrDkHg6POBPJFUyC5EhMsI8tQJofY1U=
X-Google-Smtp-Source: AGHT+IE37aWoVannLoNptWOFB8cwPoqQoADSb2zhzRrUCgqgTvWh55Fo27VtzawKbxvuKXeulB6G0Q==
X-Received: by 2002:a17:906:1804:b0:a44:144e:3463 with SMTP id v4-20020a170906180400b00a44144e3463mr1037203eje.7.1709809383568;
        Thu, 07 Mar 2024 03:03:03 -0800 (PST)
Received: from sleipner.berto.se (p4fcc8c6a.dip0.t-ipconnect.de. [79.204.140.106])
        by smtp.googlemail.com with ESMTPSA id md20-20020a170906ae9400b00a45c3a3390esm1167188ejb.200.2024.03.07.03.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 03:03:03 -0800 (PST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-renesas-soc@vger.kernel.org,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 2/3] thermal: rcar_gen3: Update temperature approximation calculation
Date: Thu,  7 Mar 2024 12:02:15 +0100
Message-ID: <20240307110216.2962918-3-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240307110216.2962918-1-niklas.soderlund+renesas@ragnatech.se>
References: <20240307110216.2962918-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The initial driver used a formula to approximation the temperature and
register value reversed engineered form an out-of-tree BSP driver. This
was needed as the datasheet at the time did not contain any information
on how to do this. Later Gen3 (Rev 2.30) and Gen4 (all) now contains
this information.

Update the approximation formula to use the datasheets information
instead of the reversed engineered one.

On an idle M3-N without fused calibration values for PTAT and THCODE the
old formula reports,

    zone0: 52000
    zone1: 53000
    zone2: 52500

While the new formula under the same circumstances reports,

    zone0: 52500
    zone1: 54000
    zone2: 54000

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_gen3_thermal.c | 137 +++++++++++++++-------------
 1 file changed, 76 insertions(+), 61 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index da1b971b287d..56fba675b986 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -65,26 +65,29 @@
 
 #define TSC_MAX_NUM	5
 
-/* Structure for thermal temperature calculation */
-struct equation_coefs {
-	int a1;
-	int b1;
-	int a2;
-	int b2;
-};
-
 struct rcar_gen3_thermal_priv;
 
 struct rcar_thermal_info {
-	int ths_tj_1;
+	int scale;
+	int adj_below;
+	int adj_above;
 	void (*read_fuses)(struct rcar_gen3_thermal_priv *priv);
 };
 
+struct equation_set_coef {
+	int a;
+	int b;
+};
+
 struct rcar_gen3_thermal_tsc {
 	struct rcar_gen3_thermal_priv *priv;
 	void __iomem *base;
 	struct thermal_zone_device *zone;
-	struct equation_coefs coef;
+	/* Different coefficients are used depending on a threshold. */
+	struct {
+		struct equation_set_coef below;
+		struct equation_set_coef above;
+	} coef;
 	int thcode[3];
 };
 
@@ -112,51 +115,41 @@ static inline void rcar_gen3_thermal_write(struct rcar_gen3_thermal_tsc *tsc,
 /*
  * Linear approximation for temperature
  *
- * [reg] = [temp] * a + b => [temp] = ([reg] - b) / a
+ * [temp] = ((thadj - [reg]) * a) / b + adj
+ * [reg] = thadj - ([temp] - adj) * b / a
  *
  * The constants a and b are calculated using two triplets of int values PTAT
  * and THCODE. PTAT and THCODE can either be read from hardware or use hard
  * coded values from driver. The formula to calculate a and b are taken from
- * BSP and sparsely documented and understood.
+ * the datasheet. Different calculations are needed for a and b depending on
+ * if the input variable ([temp] or [reg]) are above or below a threshold. The
+ * threshold is also calculated from PTAT and THCODE using formula from the
+ * datasheet.
  *
- * Examining the linear formula and the formula used to calculate constants a
- * and b while knowing that the span for PTAT and THCODE values are between
- * 0x000 and 0xfff the largest integer possible is 0xfff * 0xfff == 0xffe001.
- * Integer also needs to be signed so that leaves 7 bits for binary
- * fixed point scaling.
+ * The constant thadj is one of the THCODE values, which one to use depends on
+ * the threshold and input value.
+ *
+ * The constants adj is taken verbatim from the datasheet. Two values exists,
+ * which one to use depends on the input value and the calculated threshold.
+ * Furthermore different SoCs models supported by the driver have different sets
+ * of values. The values for each model is stored in the device match data.
  */
 
-#define FIXPT_SHIFT 7
-#define FIXPT_INT(_x) ((_x) << FIXPT_SHIFT)
-#define INT_FIXPT(_x) ((_x) >> FIXPT_SHIFT)
-#define FIXPT_DIV(_a, _b) DIV_ROUND_CLOSEST(((_a) << FIXPT_SHIFT), (_b))
-#define FIXPT_TO_MCELSIUS(_x) ((_x) * 1000 >> FIXPT_SHIFT)
-
 #define RCAR3_THERMAL_GRAN 500 /* mili Celsius */
 
-/* no idea where these constants come from */
-#define TJ_3 -41
-
 static void rcar_gen3_thermal_calc_coefs(struct rcar_gen3_thermal_priv *priv,
-					 struct rcar_gen3_thermal_tsc *tsc,
-					 int ths_tj_1)
+					 struct rcar_gen3_thermal_tsc *tsc)
 {
-	/* TODO: Find documentation and document constant calculation formula */
+	priv->tj_t =
+		DIV_ROUND_CLOSEST((priv->ptat[1] - priv->ptat[2]) * priv->info->scale,
+				  priv->ptat[0] - priv->ptat[2])
+		+ priv->info->adj_below;
 
-	/*
-	 * Division is not scaled in BSP and if scaled it might overflow
-	 * the dividend (4095 * 4095 << 14 > INT_MAX) so keep it unscaled
-	 */
-	priv->tj_t = (FIXPT_INT((priv->ptat[1] - priv->ptat[2]) * (ths_tj_1 - TJ_3))
-		      / (priv->ptat[0] - priv->ptat[2])) + FIXPT_INT(TJ_3);
+	tsc->coef.below.a = priv->info->scale * (priv->ptat[2] - priv->ptat[1]);
+	tsc->coef.above.a = priv->info->scale * (priv->ptat[0] - priv->ptat[1]);
 
-	tsc->coef.a1 = FIXPT_DIV(FIXPT_INT(tsc->thcode[1] - tsc->thcode[2]),
-				 priv->tj_t - FIXPT_INT(TJ_3));
-	tsc->coef.b1 = FIXPT_INT(tsc->thcode[2]) - tsc->coef.a1 * TJ_3;
-
-	tsc->coef.a2 = FIXPT_DIV(FIXPT_INT(tsc->thcode[1] - tsc->thcode[0]),
-				 priv->tj_t - FIXPT_INT(ths_tj_1));
-	tsc->coef.b2 = FIXPT_INT(tsc->thcode[0]) - tsc->coef.a2 * ths_tj_1;
+	tsc->coef.below.b = (priv->ptat[2] - priv->ptat[0]) * (tsc->thcode[2] - tsc->thcode[1]);
+	tsc->coef.above.b = (priv->ptat[0] - priv->ptat[2]) * (tsc->thcode[1] - tsc->thcode[0]);
 }
 
 static int rcar_gen3_thermal_round(int temp)
@@ -172,19 +165,29 @@ static int rcar_gen3_thermal_round(int temp)
 static int rcar_gen3_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct rcar_gen3_thermal_tsc *tsc = thermal_zone_device_priv(tz);
-	int mcelsius, val;
-	int reg;
+	struct rcar_gen3_thermal_priv *priv = tsc->priv;
+	const struct equation_set_coef *coef;
+	int adj, mcelsius, reg, thcode;
 
 	/* Read register and convert to mili Celsius */
 	reg = rcar_gen3_thermal_read(tsc, REG_GEN3_TEMP) & CTEMP_MASK;
 
-	if (reg <= tsc->thcode[1])
-		val = FIXPT_DIV(FIXPT_INT(reg) - tsc->coef.b1,
-				tsc->coef.a1);
-	else
-		val = FIXPT_DIV(FIXPT_INT(reg) - tsc->coef.b2,
-				tsc->coef.a2);
-	mcelsius = FIXPT_TO_MCELSIUS(val);
+	if (reg < tsc->thcode[1]) {
+		adj = priv->info->adj_below;
+		coef = &tsc->coef.below;
+		thcode = tsc->thcode[2];
+	} else {
+		adj = priv->info->adj_above;
+		coef = &tsc->coef.above;
+		thcode = tsc->thcode[0];
+	}
+
+	/*
+	 * The dividend can't be grown as it might overflow, instead shorten the
+	 * divisor to convert to millidegree Celsius. If we convert after the
+	 * division precision is lost to a full degree Celsius.
+	 */
+	mcelsius = DIV_ROUND_CLOSEST(coef->a * (thcode - reg), coef->b / 1000) + adj * 1000;
 
 	/* Guaranteed operating range is -40C to 125C. */
 
@@ -198,15 +201,21 @@ static int rcar_gen3_thermal_mcelsius_to_temp(struct rcar_gen3_thermal_tsc *tsc,
 					      int mcelsius)
 {
 	struct rcar_gen3_thermal_priv *priv = tsc->priv;
-	int celsius, val;
+	const struct equation_set_coef *coef;
+	int adj, celsius, thcode;
 
 	celsius = DIV_ROUND_CLOSEST(mcelsius, 1000);
-	if (celsius <= INT_FIXPT(priv->tj_t))
-		val = celsius * tsc->coef.a1 + tsc->coef.b1;
-	else
-		val = celsius * tsc->coef.a2 + tsc->coef.b2;
+	if (celsius < priv->tj_t) {
+		coef = &tsc->coef.below;
+		adj = priv->info->adj_below;
+		thcode = tsc->thcode[2];
+	} else {
+		coef = &tsc->coef.above;
+		adj = priv->info->adj_above;
+		thcode = tsc->thcode[0];
+	}
 
-	return INT_FIXPT(val);
+	return thcode - DIV_ROUND_CLOSEST((celsius - adj) * coef->b, coef->a);
 }
 
 static int rcar_gen3_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
@@ -371,17 +380,23 @@ static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_priv *priv,
 }
 
 static const struct rcar_thermal_info rcar_m3w_thermal_info = {
-	.ths_tj_1 = 116,
+	.scale = 157,
+	.adj_below = -41,
+	.adj_above = 116,
 	.read_fuses = rcar_gen3_thermal_read_fuses_gen3,
 };
 
 static const struct rcar_thermal_info rcar_gen3_thermal_info = {
-	.ths_tj_1 = 126,
+	.scale = 167,
+	.adj_below = -41,
+	.adj_above = 126,
 	.read_fuses = rcar_gen3_thermal_read_fuses_gen3,
 };
 
 static const struct rcar_thermal_info rcar_gen4_thermal_info = {
-	.ths_tj_1 = 126,
+	.scale = 167,
+	.adj_below = -41,
+	.adj_above = 126,
 	.read_fuses = rcar_gen3_thermal_read_fuses_gen4,
 };
 
@@ -533,7 +548,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
 
 		rcar_gen3_thermal_init(priv, tsc);
-		rcar_gen3_thermal_calc_coefs(priv, tsc, priv->info->ths_tj_1);
+		rcar_gen3_thermal_calc_coefs(priv, tsc);
 
 		zone = devm_thermal_of_zone_register(dev, i, tsc, &priv->ops);
 		if (IS_ERR(zone)) {
-- 
2.44.0


