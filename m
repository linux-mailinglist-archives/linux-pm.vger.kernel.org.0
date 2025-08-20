Return-Path: <linux-pm+bounces-32735-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B1CB2E42A
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 19:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2451C85A5A
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 17:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2292C260582;
	Wed, 20 Aug 2025 17:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aIgO1PcR"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9A825785C;
	Wed, 20 Aug 2025 17:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755711667; cv=none; b=Vz1V5hJExzk3klldwwozHEGt+1jcMH6w/e3dwaJZccf3q3j4hSxkwdkx0wckEWp14prxwnQ+TypeTO8+q+xk8xzW7eUOA+Kr32KUpC70atLB9r8KqwJ0ocoGwIhTIgy+w4tY8zjp0Opu/cCCZqgAiI93Py+pFUofndRukfMRFm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755711667; c=relaxed/simple;
	bh=cv/HvJA3SdPGsRxB/T+jdV8EVtU5USfUusiJ3NtOEdA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FafZOL5jDSa/FXmhyWySYrTLOweaQcebDgLRb/7rF+OC1P+KOBbQ5vboq7ypiHRQaA1oZYEzUPoN9zFUF0s9pQYsCC81gNmRB3BRdlZ+AT4PUPXA1T//wNFJByfSHX0hgZxkQ+bfVBL/eI5PvgZ2rKefvs8ufVV7+pR6PfupKr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aIgO1PcR; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755711657;
	bh=cv/HvJA3SdPGsRxB/T+jdV8EVtU5USfUusiJ3NtOEdA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aIgO1PcRxnI+r/PXwGZoIO+Ltv8Ewi2WVfQvnJ7Kmvb1jtUBuGoWKhAt4OxKvtPgY
	 DG6qklDDtrFx5UcwFFTNlgFgj4kHYSG4Y/n0Y5f4yknyF3afD6Xg+quTnr9gsdcPy9
	 r1jFbwsxmt7dC6/+aQJlmnAd+kMwGQhg6WQSHt8BtRyttZ0EWcDxrPllhGuLavyRCw
	 JbLWYZyCz45Gd0zSeuaVdFzrCZitqiFCu1qJvFa5mxiVOZp76L4iAvOmOEpgrshCRu
	 S0tlq3vdNyMuF5mYZUJ5XrtJ/ZDQa6r1N3T3CZ9JRT9Gq+xZ33vzQO5feZEj5jja9V
	 qZ1kcY0CiUnKQ==
Received: from jupiter.universe (dyndsl-091-248-213-114.ewe-ip-backbone.de [91.248.213.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E33D417E0237;
	Wed, 20 Aug 2025 19:40:56 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id A5141480048; Wed, 20 Aug 2025 19:40:56 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Wed, 20 Aug 2025 19:40:48 +0200
Subject: [PATCH v2 2/3] thermal: rockchip: shut up GRF warning
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-thermal-rockchip-grf-warning-v2-2-c7e2d35017b8@kernel.org>
References: <20250820-thermal-rockchip-grf-warning-v2-0-c7e2d35017b8@kernel.org>
In-Reply-To: <20250820-thermal-rockchip-grf-warning-v2-0-c7e2d35017b8@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Heiko Stuebner <heiko@sntech.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, 
 Diederik de Haas <didi.debian@cknow.org>, linux-pm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5959; i=sre@kernel.org;
 h=from:subject:message-id; bh=cv/HvJA3SdPGsRxB/T+jdV8EVtU5USfUusiJ3NtOEdA=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGimCKhZB2Qy/66UnTyJwTNkprOFtM351AXBX
 MeqRJwywrIjnokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJopgioAAoJENju1/PI
 O/qapPMQAJ4AIB5czKPJT5zpXcir8OrTbNePX5Pa6EvaYMwXm1kTybwSx0Rsq/TpIqj7Sq8UV0Y
 ycI8O4/2RMNoyIlL0qsQBq+MXhKW8lVrtnIhO2JIPBGc+HlO7zDym7YgatR8lQWvn9ScFfqr/zc
 PROvFlNKInk7oeK8tfJdhTkJoNTxI7Uo3RLGct8VKwjvRxa+z0Cj7cpYMj8haB5Af6cVsIidq8T
 JxYS+RSJorssph5nphREzyz3IxKhC44lLV2WeZ7qWzr8w2WLS2y0aEnF/xrN+RKeJ+aLvO2i7fb
 3+DRyoayJEzM7AlUpsWnFw4Njk81AOLHXz1erb0AMA57h8qRftRN5pmnRwI8ed7kOZ5nkB5Wm0n
 qMz13GLorkTSKIA+0KfGTfvo8E9t9Rtd3PpZ3V7WaJucKOcq5BaRdnWiIBcHSkaU2I7LtFm6a7T
 EQDMRHWcOeLC8tMMZPxJDoel2LD8Z41S7BrgwO078mi95pDGAKg4xNvbMlKFzxgSEkY22gJqDX3
 I6Y0Mds5ZaFxzylFWohNWC2RRMrxHNXlCBQpueP1No2RpyG62y3J1G3+PgN7D9MbpRTDXx5lyPM
 ztVQOp2+QLlNCwDtncwEXuAP3g5OYqj1QTreyV+TkDBAp9/Nfyvn2Zt0hnX+sBSYHM982/YSFXq
 WSO4F0EOqBEIRDr3gp7Msaw==
X-Developer-Key: i=sre@kernel.org; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Most of the recent Rockchip devices do not have a GRF associated
with the tsadc IP. Let's avoid printing a warning on those devices.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/thermal/rockchip_thermal.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 7b18a705dfade6fa7318b28c2b57544a4446c1cc..c49ddf70f86e7beaf0190b1b3e93f5e6b2f72b2c 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -74,6 +74,7 @@ struct chip_tsadc_table {
  * @tshut_temp: the hardware-controlled shutdown temperature value, with no trim
  * @tshut_mode: the hardware-controlled shutdown mode (0:CRU 1:GPIO)
  * @tshut_polarity: the hardware-controlled active polarity (0:LOW 1:HIGH)
+ * @grf_required: true, if a GRF is required for proper functionality
  * @initialize: SoC special initialize tsadc controller method
  * @irq_ack: clear the interrupt
  * @control: enable/disable method for the tsadc controller
@@ -97,6 +98,9 @@ struct rockchip_tsadc_chip {
 	enum tshut_mode tshut_mode;
 	enum tshut_polarity tshut_polarity;
 
+	/* GRF availability */
+	bool grf_required;
+
 	/* Chip-wide methods */
 	void (*initialize)(struct regmap *grf,
 			   void __iomem *reg, enum tshut_polarity p);
@@ -1098,6 +1102,7 @@ static const struct rockchip_tsadc_chip px30_tsadc_data = {
 	/* cpu, gpu */
 	.chn_offset = 0,
 	.chn_num = 2, /* 2 channels for tsadc */
+	.grf_required = true,
 	.tshut_mode = TSHUT_MODE_CRU, /* default TSHUT via CRU */
 	.tshut_temp = 95000,
 	.initialize = rk_tsadcv4_initialize,
@@ -1119,6 +1124,7 @@ static const struct rockchip_tsadc_chip rv1108_tsadc_data = {
 	/* cpu */
 	.chn_offset = 0,
 	.chn_num = 1, /* one channel for tsadc */
+	.grf_required = false,
 	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
 	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
 	.tshut_temp = 95000,
@@ -1141,6 +1147,7 @@ static const struct rockchip_tsadc_chip rk3228_tsadc_data = {
 	/* cpu */
 	.chn_offset = 0,
 	.chn_num = 1, /* one channel for tsadc */
+	.grf_required = false,
 	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
 	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
 	.tshut_temp = 95000,
@@ -1163,6 +1170,7 @@ static const struct rockchip_tsadc_chip rk3288_tsadc_data = {
 	/* cpu, gpu */
 	.chn_offset = 1,
 	.chn_num = 2, /* two channels for tsadc */
+	.grf_required = false,
 	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
 	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
 	.tshut_temp = 95000,
@@ -1185,6 +1193,7 @@ static const struct rockchip_tsadc_chip rk3328_tsadc_data = {
 	/* cpu */
 	.chn_offset = 0,
 	.chn_num = 1, /* one channels for tsadc */
+	.grf_required = false,
 	.tshut_mode = TSHUT_MODE_CRU, /* default TSHUT via CRU */
 	.tshut_temp = 95000,
 	.initialize = rk_tsadcv2_initialize,
@@ -1206,6 +1215,7 @@ static const struct rockchip_tsadc_chip rk3366_tsadc_data = {
 	/* cpu, gpu */
 	.chn_offset = 0,
 	.chn_num = 2, /* two channels for tsadc */
+	.grf_required = true,
 	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
 	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
 	.tshut_temp = 95000,
@@ -1228,6 +1238,7 @@ static const struct rockchip_tsadc_chip rk3368_tsadc_data = {
 	/* cpu, gpu */
 	.chn_offset = 0,
 	.chn_num = 2, /* two channels for tsadc */
+	.grf_required = false,
 	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
 	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
 	.tshut_temp = 95000,
@@ -1250,6 +1261,7 @@ static const struct rockchip_tsadc_chip rk3399_tsadc_data = {
 	/* cpu, gpu */
 	.chn_offset = 0,
 	.chn_num = 2, /* two channels for tsadc */
+	.grf_required = true,
 	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
 	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
 	.tshut_temp = 95000,
@@ -1272,6 +1284,7 @@ static const struct rockchip_tsadc_chip rk3568_tsadc_data = {
 	/* cpu, gpu */
 	.chn_offset = 0,
 	.chn_num = 2, /* two channels for tsadc */
+	.grf_required = true,
 	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
 	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
 	.tshut_temp = 95000,
@@ -1294,6 +1307,7 @@ static const struct rockchip_tsadc_chip rk3576_tsadc_data = {
 	/* top, big_core, little_core, ddr, npu, gpu */
 	.chn_offset = 0,
 	.chn_num = 6, /* six channels for tsadc */
+	.grf_required = false,
 	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
 	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
 	.tshut_temp = 95000,
@@ -1318,6 +1332,7 @@ static const struct rockchip_tsadc_chip rk3588_tsadc_data = {
 	/* top, big_core0, big_core1, little_core, center, gpu, npu */
 	.chn_offset = 0,
 	.chn_num = 7, /* seven channels for tsadc */
+	.grf_required = false,
 	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
 	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
 	.tshut_temp = 95000,
@@ -1594,12 +1609,10 @@ static int rockchip_configure_from_dt(struct device *dev,
 		return -EINVAL;
 	}
 
-	/* The tsadc wont to handle the error in here since some SoCs didn't
-	 * need this property.
-	 */
 	thermal->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
-	if (IS_ERR(thermal->grf))
-		dev_warn(dev, "Missing rockchip,grf property\n");
+	if (IS_ERR(thermal->grf) && thermal->chip->grf_required)
+		return dev_err_probe(dev, PTR_ERR(thermal->grf),
+				     "Missing rockchip,grf property\n");
 
 	rockchip_get_trim_configuration(dev, np, thermal);
 

-- 
2.50.1


