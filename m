Return-Path: <linux-pm+bounces-26245-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC72A9D1E9
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 21:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BC419E1D7B
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 19:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF4F2236E9;
	Fri, 25 Apr 2025 19:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="N6wAXrDD"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A9621D5A2;
	Fri, 25 Apr 2025 19:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745609747; cv=pass; b=bKHo56JRCAW2fJYCQdA4S+EFZ8039PzzfIe3JW3UDVSr3+mNpVTXC1SX+sLt3nJcl9JvBgfbr2lx0oHfa8oyqgcZi9RWBsb6oMdB8s7uVwYNlRBrApiDLNWIrnwBXSuEgPcBKl1smOmf8w3ZwboXEVXgLa1S1ixYi+1AHevudGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745609747; c=relaxed/simple;
	bh=vJjZ8FV71hmGWM/Fi2tfuywEghJNM8FdhK5uksVx/B8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oY1TciCaoL6AwZ9CGKCIjgRL/Sf9/sLLYuiWGb44rfJpEWo35ouOrOnk1q1TLrDsTF8nyd4vHWIMFpKc+Ral46GzRleSzSNdEqCG3hFH0g5aPiiedzkPG6RTf5rgQEavHP8cjalvockrCNYzsaBVxaaVvDnMaZ/LD0pasYMGIPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=N6wAXrDD; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1745609718; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=agr8fBlBi6QGFgTHX7z5X5ocwUatpWFaRToL0s75p8C1uIvqw1zIKAU8gjz75Qbnm15ChWQQDG26jYpe6nxOQyQQ0NopmWNSXzzjLs2IwP5YKicz01SSON6C5zb+4exX93gpWS/P9VMXLFGQf/DIvLFlJJoo5GQ/oqDbROL9sxU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745609718; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QqVZpS1mMaiLHStCX0I5k62rBcrBowKTfedoAC9Jqi8=; 
	b=Xca7UHDnHEzgKZ2c3fHqDQnEZ7IJvtWw4/SpaTNKOrjeVRUvggXnV9+PP3jghX91vU+1jr1tSOFQZe5RtrddNzxiSRC3LN4x+93PYT+aZenRy6dChsUdeaBcMXV1ULCVv8jCcqBVJri1M0rypepAcDijzhdPfkcfUl1sgJGf5K8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745609718;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=QqVZpS1mMaiLHStCX0I5k62rBcrBowKTfedoAC9Jqi8=;
	b=N6wAXrDDC6rJQP2l4XM7nCpQ/zxWTQKeyhOw0x8nmOtFKbFfrsQbITocT2G7fTSA
	dgWNFwjmESwcu+3HkvObnZ61P1ewbkchLJ1sMq9vSejBKCfVkGfTqgIq+3z30OqiIOD
	k+HxNA06Wo3saEjNj3Ptx5L9X6Bebdl+tjXaf8gE=
Received: by mx.zohomail.com with SMTPS id 174560971603512.716898738069744;
	Fri, 25 Apr 2025 12:35:16 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 25 Apr 2025 21:34:37 +0200
Subject: [PATCH v5 3/7] thermal: rockchip: Support RK3576 SoC in the
 thermal driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-rk3576-tsadc-upstream-v5-3-0c840b99c30e@collabora.com>
References: <20250425-rk3576-tsadc-upstream-v5-0-0c840b99c30e@collabora.com>
In-Reply-To: <20250425-rk3576-tsadc-upstream-v5-0-0c840b99c30e@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Jonas Karlman <jonas@kwiboo.se>
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
 drivers/thermal/rockchip_thermal.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 40c7d234c3ef99f69dd8db4d8c47f9d493c0583d..89e3180667e2a8f0ef5542b0db4d9e19a21a24d3 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1284,6 +1284,28 @@ static const struct rockchip_tsadc_chip rk3568_tsadc_data = {
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
@@ -1342,6 +1364,10 @@ static const struct of_device_id of_rockchip_thermal_match[] = {
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
2.49.0


