Return-Path: <linux-pm+bounces-22161-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E107BA37149
	for <lists+linux-pm@lfdr.de>; Sun, 16 Feb 2025 00:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A835B18933E0
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 23:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BB81FECD9;
	Sat, 15 Feb 2025 23:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="k56Xl7mR"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A381FE44F;
	Sat, 15 Feb 2025 23:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739662542; cv=pass; b=YaJhR5tcj1AhjgYHvbezCxVpVsK+cpcAO2jkMsIXMc1QL6A6SlGSWrcURlmpOj8MXBEaRpoNqwheIaCKuMvXDvA6CxVbIG4z8fdTctFLE+vZroSLHmkaUEK0Z3PZQC87o6qvNQCX24Zq3H7aVxgwyzuBULg8OJWIPR7vrfVKz7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739662542; c=relaxed/simple;
	bh=QD0jq93xoktYm0t3DUu5Kk2WqhAumA8bjIfLWRpzn4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JUMTGwGaFpcW/yu6v7lvNQ5tQ0lmVcgqsWzztESMIR7AKywOhDjovHinPg69hsAZGmS9fESczOyBvgFNXVtT/KX6RJAu0IrK832bAabpuwXMlMiw2CPHQzluPNBJY070eKAgsDbi8jfRa3TOBIjQ7OJ15e0Bl9v/3rEVA4pfvWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=k56Xl7mR; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739662516; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Xd+CkQwCCaV7Oi+zEzJ9x7ICWGu+sjNSE5qhwYMCUVVre/r90iHy0XLd8XxkyADEzVZggUCJDy7XhosJ/0CEckKLo8tnGRF4Puyu7vIPPaLjkEDzSW3f3yiWlblyrjDQIVlMVnFdpuXnWIEDg1HuHvNLuale1DHWWMtSF0WRTS8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739662516; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nG2yRgvMP5dkYbP38lgXb6PzBoAUvs3TSS4EYrU79I8=; 
	b=Rv4VHdZKaZGNSd5oJASU9EEL07nQKoD20KYiKKqpBe2DnVTHzxuUb0c+mrjFrstcYIEPtOS05hDxsVkutyo+LGRC0l5oLztfwCZMNlI+n/X3VI5BXUYTxBmxmcKauVeOKvf+Cnd8jviyPTdpwmAfS28rYIvvZulPGCbCJoDIIdk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739662516;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=nG2yRgvMP5dkYbP38lgXb6PzBoAUvs3TSS4EYrU79I8=;
	b=k56Xl7mRjNy1ddOtPV7y/xKt0EnTTf+TvluN+43rC9kYD/sR7KCQA/88w+jQygtO
	O4urixkbaw7OHkaBunlpJT0Den4KIwLg55C7xkekiqn/yM2rwCnaQyTWECyGHVpysET
	j2FWX6S3o7pSbpzKxnpkxSEOOI3IWP9zx70XRsDg=
Received: by mx.zohomail.com with SMTPS id 1739662515179742.073174152887;
	Sat, 15 Feb 2025 15:35:15 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Sun, 16 Feb 2025 00:34:52 +0100
Subject: [PATCH 3/6] thermal: rockchip: Support RK3576 SoC in the thermal
 driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250216-rk3576-tsadc-upstream-v1-3-6ec969322a14@collabora.com>
References: <20250216-rk3576-tsadc-upstream-v1-0-6ec969322a14@collabora.com>
In-Reply-To: <20250216-rk3576-tsadc-upstream-v1-0-6ec969322a14@collabora.com>
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
index f551df48eef935757629f4a6b2a619f1506c1cf3..81f11af83f2b215177b93dc11800eb812aa9f1dd 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1060,6 +1060,22 @@ static void rk_tsadcv3_tshut_mode(int chn, void __iomem *regs,
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
@@ -1283,6 +1299,28 @@ static const struct rockchip_tsadc_chip rk3568_tsadc_data = {
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
@@ -1341,6 +1379,10 @@ static const struct of_device_id of_rockchip_thermal_match[] = {
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


