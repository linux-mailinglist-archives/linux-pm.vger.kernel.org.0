Return-Path: <linux-pm+bounces-36696-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A5ABFFD7E
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 10:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E280E1A04E9E
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 08:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93ADD2F3C21;
	Thu, 23 Oct 2025 08:20:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185372F3611;
	Thu, 23 Oct 2025 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207624; cv=none; b=UNZ2hzBB9b8r7u7L2u85SqJr3jdaOF9afNUksQfhzvH5OgoSYXYFuMt73SU/TzJI84ydfARn9QjGAklVlBccMkwefQuA49D0bmGX5VZTbCHw4+OWNAFXkSWCY0JsrAGUnf+j0mf0t+7BSR/CiUuwVFlCSzR0FmxmFr5IN+5YK7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207624; c=relaxed/simple;
	bh=8XGgl/QqxZ/G9e52VBDeQ8yMQzvWYFSq06TkfE6206k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CM+3c17xa85rIInLtnWjMdSCOuFclN4Lo5CaqWHbBMpkjP3ADDNA0ohSq+TIhh2htqR3crqf/IJL5Td8ihPldZGi3dZGwPbADhObu0KLdD6sjoQrSffocTslR5CO3heIDCg0twJUzOboSbueQ1Fd8EbppiiK45nmtiLH6wqJ6TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: uGn7erzOQxKQW0zNFjR7BQ==
X-CSE-MsgGUID: UDmdz+diSFW/cmRs/eKj0A==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 23 Oct 2025 17:20:21 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.77])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6870C417CDAD;
	Thu, 23 Oct 2025 17:20:15 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: 
Cc: John Madieu <john.madieu.xa@bp.renesas.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 03/10] thermal: renesas: rzg3e: make min and max temperature per-chip
Date: Thu, 23 Oct 2025 11:19:17 +0300
Message-ID: <20251023081925.2412325-4-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251023081925.2412325-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251023081925.2412325-1-cosmin-gabriel.tanislav.xa@renesas.com>
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
2.51.1.dirty


