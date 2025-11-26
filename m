Return-Path: <linux-pm+bounces-38708-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0A2C89E96
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 14:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1E144E15BB
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 13:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939F922156A;
	Wed, 26 Nov 2025 13:04:58 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A7421B905;
	Wed, 26 Nov 2025 13:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764162298; cv=none; b=NUYZ629QCcUtjJEJG//Ki+4zlT+A1SgOvkWIai+XSZdX9/mZoDFTy0Yn8n5c+pO3fxhoyuogqjPwsSWR05q6sB1v1jBGUfE2LR3IP60l03OPagSa8VYRy6HKqNWZihsPWGRbIIGVuHXJDuFfhkp/VFZbXHEAsT7fHR9Dt/jaAU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764162298; c=relaxed/simple;
	bh=J9yUnSMRv9Tph8SjqcMrQkdXFrwHmRg+3/BxnDv5X2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9RDK3CUILqoVlJmBrq3rLbKAtb6H9utaWHqqeix8TL8xTJ4BP8nYO1WpV1MrFnz6m7f80zINHLkCS6m4jLxoNGNzf/Xyh0p6wCAoYCz9o7h/wXxFQ9a54LE9gVNwmOm/xeu8ZIRJdfzoD0PqDPX3kTXiNPFG4H808H3tjlpiDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: WZp3P4KRQAWOBdcMj8r8SQ==
X-CSE-MsgGUID: yWByuc9OR5u5PPaTbabQDw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 26 Nov 2025 22:04:55 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.98])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8B6EF400EF74;
	Wed, 26 Nov 2025 22:04:50 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: John Madieu <john.madieu.xa@bp.renesas.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v3 2/9] thermal: renesas: rzg3e: make min and max temperature per-chip
Date: Wed, 26 Nov 2025 15:03:49 +0200
Message-ID: <20251126130356.2768625-3-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251126130356.2768625-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251126130356.2768625-1-cosmin-gabriel.tanislav.xa@renesas.com>
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

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
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


