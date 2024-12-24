Return-Path: <linux-pm+bounces-19736-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE639FBBD8
	for <lists+linux-pm@lfdr.de>; Tue, 24 Dec 2024 11:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7FB21887EA0
	for <lists+linux-pm@lfdr.de>; Tue, 24 Dec 2024 09:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF4A1BCA1C;
	Tue, 24 Dec 2024 09:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ju8NuTRx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m127221.xmail.ntesmail.com (mail-m127221.xmail.ntesmail.com [115.236.127.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D772E1B652C;
	Tue, 24 Dec 2024 09:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735034142; cv=none; b=ap1ds8bAWxyEicGODv7V+hymKrrZWoGcCk/Sh8IKFfy6x4wN3qLj1wIwGMIRz7BbTHY8Y0hzx7TqljVuXLbLmuZLdB4cbPe8k+V0eV1ufa3TAnM/PI9MBLsoR95E23Gp0zB7IElkMXXJh3wxAeqUXkHGdJ6wRv/INamDC5NabqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735034142; c=relaxed/simple;
	bh=WqR1jwv7UuUrWVuuVIQkBxpxMZidcqABbl4oG17ZpgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lRAw/T2NKnHS5yCdBT5/ymryi2EofOhtJlB4iW39Njiaboppukruno7z2hvMmyGGV6MmGFaJFOzkLRVcPLTxssc9g7JOX7xa8n09foOImoahBsMO9d3KLoleQT7qB4WAcbJjy2ljKeWQ91TXKVJO0BHDXMMAxrNg2JesQ95twV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ju8NuTRx; arc=none smtp.client-ip=115.236.127.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 6aa90537;
	Tue, 24 Dec 2024 17:40:20 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Shaohan Yao <shaohan.yao@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	linux-pm@vger.kernel.org,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-kernel@vger.kernel.org,
	Zhang Rui <rui.zhang@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 2/2] thermal: rockchip: Support the rk3562 SoC in thermal driver
Date: Tue, 24 Dec 2024 17:40:15 +0800
Message-Id: <20241224094015.3816301-2-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241224094015.3816301-1-kever.yang@rock-chips.com>
References: <20241224094015.3816301-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkwYSFZMS0MaSx9KQh5JTxlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a93f809ecbd03afkunm6aa90537
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OBQ6NAw5MzIWUUpKSzgLMRMS
	VjgKCU9VSlVKTEhOS0hISUlKTExMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFNSU9NNwY+
DKIM-Signature:a=rsa-sha256;
	b=ju8NuTRxypQ+vafyGJ0EUsS7lZDiIqnBPvtmdVI7pJzN+Eu5oIh9DG/7SIRnpGPR/w2vje8FkNyuKmgnygw4Dii1Oaube9ACQdzDPWm24yf9qRvNX/eQzxUeLxP5uavAyLjI1ljDr3xGRMpaD/bLTLCCDrw9Jd85ybrEuc2RmrM=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=NjLVTN7/RI83990q23Vq9VUZh5/11YsOgwaHHfMOObk=;
	h=date:mime-version:subject:message-id:from;

From: Shaohan Yao <shaohan.yao@rock-chips.com>

There are one Temperature Sensor on rk3562, channel 0 is for chip.

Signed-off-by: Shaohan Yao <shaohan.yao@rock-chips.com>
Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 drivers/thermal/rockchip_thermal.c | 112 ++++++++++++++++++++++++++++-
 1 file changed, 111 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index f551df48eef9..aec0e634bd1f 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2014-2016, Fuzhou Rockchip Electronics Co., Ltd
+ * Copyright (c) 2014-2021, Fuzhou Rockchip Electronics Co., Ltd.
+ * Copyright (c) 2021-2024, Rockchip Electronics Co., Ltd.
  * Caesar Wang <wxt@rock-chips.com>
  */
 
@@ -185,6 +186,8 @@ struct rockchip_thermal_data {
 #define TSADCV2_AUTO_PERIOD_HT			0x6c
 #define TSADCV3_AUTO_PERIOD			0x154
 #define TSADCV3_AUTO_PERIOD_HT			0x158
+#define TSADCV9_Q_MAX				0x210
+#define TSADCV9_FLOW_CON			0x218
 
 #define TSADCV2_AUTO_EN				BIT(0)
 #define TSADCV2_AUTO_EN_MASK			BIT(16)
@@ -195,6 +198,7 @@ struct rockchip_thermal_data {
 #define TSADCV2_AUTO_TSHUT_POLARITY_MASK	BIT(24)
 
 #define TSADCV3_AUTO_Q_SEL_EN			BIT(1)
+#define TSADCV3_AUTO_Q_SEL_EN_MASK		BIT(17)
 
 #define TSADCV2_INT_SRC_EN(chn)			BIT(chn)
 #define TSADCV2_INT_SRC_EN_MASK(chn)		BIT(16 + (chn))
@@ -220,6 +224,12 @@ struct rockchip_thermal_data {
 #define TSADCV5_AUTO_PERIOD_HT_TIME		1622 /* 2.5ms */
 #define TSADCV6_AUTO_PERIOD_TIME		5000 /* 2.5ms */
 #define TSADCV6_AUTO_PERIOD_HT_TIME		5000 /* 2.5ms */
+#define TSADCV7_AUTO_PERIOD_TIME		3000 /* 2.5ms */
+#define TSADCV7_AUTO_PERIOD_HT_TIME		3000 /* 2.5ms */
+#define TSADCV12_AUTO_PERIOD_TIME		3000 /* 2.5ms */
+#define TSADCV12_AUTO_PERIOD_HT_TIME		3000 /* 2.5ms */
+#define TSADCV3_Q_MAX_VAL			0x7ff /* 11bit 2047 */
+#define TSADCV12_Q_MAX_VAL			0xfff /* 12bit 4095 */
 
 #define TSADCV2_USER_INTER_PD_SOC		0x340 /* 13 clocks */
 #define TSADCV5_USER_INTER_PD_SOC		0xfc0 /* 97us, at least 90us */
@@ -230,6 +240,8 @@ struct rockchip_thermal_data {
 
 #define PX30_GRF_SOC_CON2			0x0408
 
+#define RK3562_GRF_TSADC_CON			0x0580
+
 #define RK3568_GRF_TSADC_CON			0x0600
 #define RK3568_GRF_TSADC_ANA_REG0		(0x10001 << 0)
 #define RK3568_GRF_TSADC_ANA_REG1		(0x10001 << 1)
@@ -497,6 +509,45 @@ static const struct tsadc_table rk3399_code_table[] = {
 	{TSADCV3_DATA_MASK, 125000},
 };
 
+static const struct tsadc_table rk3562_code_table[] = {
+	{0, -40000},
+	{1419, -40000},
+	{1428, -35000},
+	{1436, -30000},
+	{1445, -25000},
+	{1453, -20000},
+	{1462, -15000},
+	{1470, -10000},
+	{1479, -5000},
+	{1487, 0},
+	{1496, 5000},
+	{1504, 10000},
+	{1512, 15000},
+	{1521, 20000},
+	{1529, 25000},
+	{1538, 30000},
+	{1546, 35000},
+	{1555, 40000},
+	{1563, 45000},
+	{1572, 50000},
+	{1580, 55000},
+	{1589, 60000},
+	{1598, 65000},
+	{1606, 70000},
+	{1615, 75000},
+	{1623, 80000},
+	{1632, 85000},
+	{1640, 90000},
+	{1648, 95000},
+	{1657, 100000},
+	{1666, 105000},
+	{1674, 110000},
+	{1682, 115000},
+	{1691, 120000},
+	{1699, 125000},
+	{TSADCV2_DATA_MASK, 125000},
+};
+
 static const struct tsadc_table rk3568_code_table[] = {
 	{0, -40000},
 	{1584, -40000},
@@ -834,6 +885,37 @@ static void rk_tsadcv8_initialize(struct regmap *grf, void __iomem *regs,
 			       regs + TSADCV2_AUTO_CON);
 }
 
+static void rk_tsadcv12_initialize(struct regmap *grf, void __iomem *regs,
+				   enum tshut_polarity tshut_polarity)
+{
+	writel_relaxed(TSADCV12_AUTO_PERIOD_TIME, regs + TSADCV3_AUTO_PERIOD);
+	writel_relaxed(TSADCV12_AUTO_PERIOD_HT_TIME,
+		       regs + TSADCV3_AUTO_PERIOD_HT);
+	writel_relaxed(TSADCV2_HIGHT_INT_DEBOUNCE_COUNT,
+		       regs + TSADCV3_HIGHT_INT_DEBOUNCE);
+	writel_relaxed(TSADCV2_HIGHT_TSHUT_DEBOUNCE_COUNT,
+		       regs + TSADCV3_HIGHT_TSHUT_DEBOUNCE);
+	writel_relaxed(TSADCV12_Q_MAX_VAL, regs + TSADCV9_Q_MAX);
+	writel_relaxed(TSADCV3_AUTO_Q_SEL_EN | TSADCV3_AUTO_Q_SEL_EN_MASK,
+		       regs + TSADCV2_AUTO_CON);
+	if (tshut_polarity == TSHUT_HIGH_ACTIVE)
+		writel_relaxed(TSADCV2_AUTO_TSHUT_POLARITY_HIGH |
+			       TSADCV2_AUTO_TSHUT_POLARITY_MASK,
+			       regs + TSADCV2_AUTO_CON);
+	else
+		writel_relaxed(TSADCV2_AUTO_TSHUT_POLARITY_MASK,
+			       regs + TSADCV2_AUTO_CON);
+
+	if (!IS_ERR(grf)) {
+		regmap_write(grf, RK3562_GRF_TSADC_CON, RK3568_GRF_TSADC_TSEN);
+		udelay(15);
+		regmap_write(grf, RK3562_GRF_TSADC_CON, RK3568_GRF_TSADC_ANA_REG0);
+		regmap_write(grf, RK3562_GRF_TSADC_CON, RK3568_GRF_TSADC_ANA_REG1);
+		regmap_write(grf, RK3562_GRF_TSADC_CON, RK3568_GRF_TSADC_ANA_REG2);
+		usleep_range(100, 200);
+	}
+}
+
 static void rk_tsadcv2_irq_ack(void __iomem *regs)
 {
 	u32 val;
@@ -1258,6 +1340,30 @@ static const struct rockchip_tsadc_chip rk3399_tsadc_data = {
 	},
 };
 
+static const struct rockchip_tsadc_chip rk3562_tsadc_data = {
+	.chn_offset = 0,
+	.chn_num = 1, /* one channels for tsadc */
+
+	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
+	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
+	.tshut_temp = 95000,
+
+	.initialize = rk_tsadcv12_initialize,
+	.irq_ack = rk_tsadcv4_irq_ack,
+	.control = rk_tsadcv4_control,
+	.get_temp = rk_tsadcv4_get_temp,
+	.set_alarm_temp = rk_tsadcv3_alarm_temp,
+	.set_tshut_temp = rk_tsadcv3_tshut_temp,
+	.set_tshut_mode = rk_tsadcv3_tshut_mode,
+
+	.table = {
+		.id = rk3562_code_table,
+		.length = ARRAY_SIZE(rk3562_code_table),
+		.data_mask = TSADCV2_DATA_MASK,
+		.mode = ADC_INCREMENT,
+	},
+};
+
 static const struct rockchip_tsadc_chip rk3568_tsadc_data = {
 	/* cpu, gpu */
 	.chn_offset = 0,
@@ -1337,6 +1443,10 @@ static const struct of_device_id of_rockchip_thermal_match[] = {
 		.compatible = "rockchip,rk3399-tsadc",
 		.data = (void *)&rk3399_tsadc_data,
 	},
+	{
+		.compatible = "rockchip,rk3562-tsadc",
+		.data = (void *)&rk3562_tsadc_data,
+	},
 	{
 		.compatible = "rockchip,rk3568-tsadc",
 		.data = (void *)&rk3568_tsadc_data,
-- 
2.25.1


