Return-Path: <linux-pm+bounces-40500-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E25B7D05ECC
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 20:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C041304F894
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 19:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3C532C932;
	Thu,  8 Jan 2026 19:53:39 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A83B327206;
	Thu,  8 Jan 2026 19:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767902018; cv=none; b=Vbi1PJ3iUogwJx9vyrsAS/pLi1yw7HDFj88oAO6MSDGhP4eVF0cqIKb5KbtYhYa1p62t2Hrhj3iCzFszvtgL0TD8I1sLnMpewS5FcQlHhhfDmGCG4dDulhlamRq7A39RhJSPRSHy4e6gKKyrtlc7LA47D3wDG4AbRISQAxW83OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767902018; c=relaxed/simple;
	bh=8GPukBzyzonRme1F+reTq27VoIs4/pRuWr1SYXTxWOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+4ihKd4CxlyoSo+wKK2B3Cly1+cQ6t3Zlp5/lDF932gXwZPdB4Oj821rrHmmBpr8bT1C0zf7s8gD4Th5kL4g8C47hwzH2rCK49+zYcr6Px7yExC/wslQ626iLMtuvSVGeIPkGMjJQDsMFwHshA+X2U3M8c496IL76uyyi32kHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: GUFMR25ET1ijklJGQhDmaQ==
X-CSE-MsgGUID: YnONpCNrQumzOHUnwau7Aw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 09 Jan 2026 04:53:35 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.68])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3ADA8475F1F5;
	Fri,  9 Jan 2026 04:53:29 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: John Madieu <john.madieu.xa@bp.renesas.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v5 2/5] thermal: renesas: rzg3e: make min and max temperature per-chip
Date: Thu,  8 Jan 2026 21:52:20 +0200
Message-ID: <20260108195223.193531-3-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108195223.193531-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260108195223.193531-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have
different minimum and maximum temperatures compared to the already
supported RZ/G3E.

Prepare for them by moving these into a chip-specific struct.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: John Madieu <john.madieu.xa@bp.renesas.com>
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V5:
 * no changes

V4:
 * pick up Geert's Reviewed-by
 * pick up John's Reviewed-by and Tested-by

V3:
 * no changes

V2:
 * no changes

 drivers/thermal/renesas/rzg3e_thermal.c | 35 ++++++++++++++++---------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/renesas/rzg3e_thermal.c b/drivers/thermal/renesas/rzg3e_thermal.c
index 86c10810e5bf..3c9ff5e43d7e 100644
--- a/drivers/thermal/renesas/rzg3e_thermal.c
+++ b/drivers/thermal/renesas/rzg3e_thermal.c
@@ -62,8 +62,6 @@
 #define TSU_SICR_CMPCLR	BIT(1)
 
 /* Temperature calculation constants from datasheet */
-#define TSU_TEMP_D		(-41)
-#define TSU_TEMP_E		126
 #define TSU_CODE_MAX		0xFFF
 
 /* Timing specifications from datasheet */
@@ -72,6 +70,11 @@
 #define TSU_POLL_DELAY_US	10	/* Polling interval */
 #define TSU_MIN_CLOCK_RATE	24000000  /* TSU_PCLK minimum 24MHz */
 
+struct rzg3e_thermal_info {
+	int temp_d_mc;
+	int temp_e_mc;
+};
+
 /**
  * struct rzg3e_thermal_priv - RZ/G3E TSU private data
  * @base: TSU register base
@@ -79,6 +82,7 @@
  * @syscon: regmap for calibration values
  * @zone: thermal zone device
  * @rstc: reset control
+ * @info: chip type specific information
  * @trmval0: calibration value 0 (b)
  * @trmval1: calibration value 1 (c)
  * @trim_offset: offset for trim registers in syscon
@@ -90,6 +94,7 @@ struct rzg3e_thermal_priv {
 	struct regmap *syscon;
 	struct thermal_zone_device *zone;
 	struct reset_control *rstc;
+	const struct rzg3e_thermal_info *info;
 	u16 trmval0;
 	u16 trmval1;
 	u32 trim_offset;
@@ -161,17 +166,17 @@ static void rzg3e_thermal_power_off(struct rzg3e_thermal_priv *priv)
  */
 static int rzg3e_thermal_code_to_temp(struct rzg3e_thermal_priv *priv, u16 code)
 {
-	int temp_e_mc = TSU_TEMP_E * MILLIDEGREE_PER_DEGREE;
-	int temp_d_mc = TSU_TEMP_D * MILLIDEGREE_PER_DEGREE;
+	const struct rzg3e_thermal_info *info = priv->info;
 	s64 numerator, denominator;
 	int temp_mc;
 
-	numerator = (temp_e_mc - temp_d_mc) * (s64)(code - priv->trmval0);
+	numerator = (info->temp_e_mc - info->temp_d_mc) *
+		    (s64)(code - priv->trmval0);
 	denominator = priv->trmval1 - priv->trmval0;
 
-	temp_mc = div64_s64(numerator, denominator) + temp_d_mc;
+	temp_mc = div64_s64(numerator, denominator) + info->temp_d_mc;
 
-	return clamp(temp_mc, temp_d_mc, temp_e_mc);
+	return clamp(temp_mc, info->temp_d_mc, info->temp_e_mc);
 }
 
 /*
@@ -180,13 +185,12 @@ static int rzg3e_thermal_code_to_temp(struct rzg3e_thermal_priv *priv, u16 code)
  */
 static u16 rzg3e_thermal_temp_to_code(struct rzg3e_thermal_priv *priv, int temp_mc)
 {
-	int temp_e_mc = TSU_TEMP_E * MILLIDEGREE_PER_DEGREE;
-	int temp_d_mc = TSU_TEMP_D * MILLIDEGREE_PER_DEGREE;
+	const struct rzg3e_thermal_info *info = priv->info;
 	s64 numerator, denominator;
 	s64 code;
 
-	numerator = (temp_mc - temp_d_mc) * (priv->trmval1 - priv->trmval0);
-	denominator = temp_e_mc - temp_d_mc;
+	numerator = (temp_mc - info->temp_d_mc) * (priv->trmval1 - priv->trmval0);
+	denominator = info->temp_e_mc - info->temp_d_mc;
 
 	code = div64_s64(numerator, denominator) + priv->trmval0;
 
@@ -392,6 +396,8 @@ static int rzg3e_thermal_probe(struct platform_device *pdev)
 		return ret;
 	platform_set_drvdata(pdev, priv);
 
+	priv->info = device_get_match_data(dev);
+
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
@@ -526,8 +532,13 @@ static const struct dev_pm_ops rzg3e_thermal_pm_ops = {
 	SYSTEM_SLEEP_PM_OPS(rzg3e_thermal_suspend, rzg3e_thermal_resume)
 };
 
+static const struct rzg3e_thermal_info rzg3e_thermal_info = {
+	.temp_d_mc = -41000,
+	.temp_e_mc = 126000,
+};
+
 static const struct of_device_id rzg3e_thermal_dt_ids[] = {
-	{ .compatible = "renesas,r9a09g047-tsu" },
+	{ .compatible = "renesas,r9a09g047-tsu", .data = &rzg3e_thermal_info },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rzg3e_thermal_dt_ids);
-- 
2.52.0

