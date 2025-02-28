Return-Path: <linux-pm+bounces-23196-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B4AA4A3B0
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 21:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEF9C19C1D44
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 20:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9E027C155;
	Fri, 28 Feb 2025 20:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="OPisixBS"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD0B27C151;
	Fri, 28 Feb 2025 20:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773267; cv=pass; b=dZEIPd1C4zoaOSN6ceUgF5HUS7McccsIBvI7cNHguyDW7c4UQ05ZvrH+tZTKVa5foF2FbrIWhDEdcvPKMqPeIEV4/NTfSdyK55Vv7p+pxM4H3kxuyIz7dI1Uy8ofOvRlV1eJIS2AbCHjjbNVLrOisSbvH3DHepVo1kbL6tSO13o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773267; c=relaxed/simple;
	bh=N0hAjvg6mvU2dzVgWEnk4GjB9T95fRycc6bEhWgtnaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PREgmrxdgk9uDYJfprPhAk65X5Ok+SaviNspa3enu70ddqGuvYqyfS8e+m+bbgJ+aW21qPEzlBSj92miESOlRYKNZIUuryusZV+AyuKnTvZin1xCAbF/CLSLqa7mqULdMuORlEyHZlmOx8l5TD3UgkUJqRS2aqVFgt/rk4ID12c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=OPisixBS; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740773244; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dW7p5MYvY85bgbrZvZjl9pSzGlPazQkiHSF4S8KOpAyeRydWxBp+NqmYiO1NDbzHaYaASJAoaSMpzuDGoOtIywigwqleVg0gl4xgU1MrQKA2xdURxTrE1c5d+zqjELhievZKzfdAq8AyGAWQAGW61KvU4HGYNebPCUM4NWZOxjU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740773244; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=k7eNk5qHMFWPJbC7DgO4/o0LboHoTT+Aabq56bbGgPE=; 
	b=mxtVsQO21lT4ub3bT3fNcAD1vcPX+/VqpsGsk45ygBjs5oMghVzlSXxfv/81ARM/NvZFJa0Oq7+BpT/Ln3BKL+K4zsm/dkRsGfRqgRdawXT3YmaheoSRI1W3BuWl4lSQ2SuStvsn3yCyWDlzj/i//Aewi20pCxhZwt2V4Wv9kXw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740773244;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=k7eNk5qHMFWPJbC7DgO4/o0LboHoTT+Aabq56bbGgPE=;
	b=OPisixBSu4VLmG8jGfr6XqaX2pxrHBQeBivO3irKYP5REWYh6pBluXKptrs8WuX1
	O8qpaTSIqBRAYOHpli7WDAdnyRmAtODRNh8oyq3pzpstsSxQG+iygU5gPGp3b0lBqVT
	+MKrd0tzo45VJJeUnDBUPexHzXqX3C5Y33v2xxM0=
Received: by mx.zohomail.com with SMTPS id 1740773241943112.92693793042736;
	Fri, 28 Feb 2025 12:07:21 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 28 Feb 2025 21:06:53 +0100
Subject: [PATCH v3 3/6] thermal: rockchip: Support RK3576 SoC in the
 thermal driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-rk3576-tsadc-upstream-v3-3-4bfbb3b699b9@collabora.com>
References: <20250228-rk3576-tsadc-upstream-v3-0-4bfbb3b699b9@collabora.com>
In-Reply-To: <20250228-rk3576-tsadc-upstream-v3-0-4bfbb3b699b9@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 kernel@collabora.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Ye Zhang <ye.zhang@rock-chips.com>
X-Mailer: b4 0.14.2

From: Ye Zhang <ye.zhang@rock-chips.com>

The RK3576 SoC has six TS-ADC channels: TOP, BIG_CORE, LITTLE_CORE,
DDR, NPU and GPU.

Signed-off-by: Ye Zhang <ye.zhang@rock-chips.com>
[ported to mainline, reworded commit message]
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/thermal/rockchip_thermal.c | 42 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index a8ad85feb68fbb7ec8d79602b16c47838ecb3c00..bec1930bebd87859a7e519cfc9f05e10b1c31e87 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1061,6 +1061,22 @@ static void rk_tsadcv3_tshut_mode(int chn, void __iomem *regs,
 	writel_relaxed(val_cru, regs + TSADCV3_HSHUT_CRU_INT_EN);
 }
 
+static void rk_tsadcv4_tshut_mode(int chn, void __iomem *regs,
+				  enum tshut_mode mode)
+{
+	u32 val_gpio, val_cru;
+
+	if (mode == TSHUT_MODE_GPIO) {
+		val_gpio = TSADCV2_INT_SRC_EN(chn) | TSADCV2_INT_SRC_EN_MASK(chn);
+		val_cru = TSADCV2_INT_SRC_EN_MASK(chn);
+	} else {
+		val_cru = TSADCV2_INT_SRC_EN(chn) | TSADCV2_INT_SRC_EN_MASK(chn);
+		val_gpio = TSADCV2_INT_SRC_EN_MASK(chn);
+	}
+	writel_relaxed(val_gpio, regs + TSADCV3_HSHUT_GPIO_INT_EN);
+	writel_relaxed(val_cru, regs + TSADCV3_HSHUT_CRU_INT_EN);
+}
+
 static const struct rockchip_tsadc_chip px30_tsadc_data = {
 	/* cpu, gpu */
 	.chn_offset = 0,
@@ -1284,6 +1300,28 @@ static const struct rockchip_tsadc_chip rk3568_tsadc_data = {
 	},
 };
 
+static const struct rockchip_tsadc_chip rk3576_tsadc_data = {
+	/* top, big_core, little_core, ddr, npu, gpu */
+	.chn_offset = 0,
+	.chn_num = 6, /* six channels for tsadc */
+	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
+	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
+	.tshut_temp = 95000,
+	.initialize = rk_tsadcv8_initialize,
+	.irq_ack = rk_tsadcv4_irq_ack,
+	.control = rk_tsadcv4_control,
+	.get_temp = rk_tsadcv4_get_temp,
+	.set_alarm_temp = rk_tsadcv3_alarm_temp,
+	.set_tshut_temp = rk_tsadcv3_tshut_temp,
+	.set_tshut_mode = rk_tsadcv4_tshut_mode,
+	.table = {
+		.id = rk3588_code_table,
+		.length = ARRAY_SIZE(rk3588_code_table),
+		.data_mask = TSADCV4_DATA_MASK,
+		.mode = ADC_INCREMENT,
+	},
+};
+
 static const struct rockchip_tsadc_chip rk3588_tsadc_data = {
 	/* top, big_core0, big_core1, little_core, center, gpu, npu */
 	.chn_offset = 0,
@@ -1342,6 +1380,10 @@ static const struct of_device_id of_rockchip_thermal_match[] = {
 		.compatible = "rockchip,rk3568-tsadc",
 		.data = (void *)&rk3568_tsadc_data,
 	},
+	{
+		.compatible = "rockchip,rk3576-tsadc",
+		.data = (void *)&rk3576_tsadc_data,
+	},
 	{
 		.compatible = "rockchip,rk3588-tsadc",
 		.data = (void *)&rk3588_tsadc_data,

-- 
2.48.1


