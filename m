Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1733AE670
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 11:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhFUJtd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 05:49:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43370 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhFUJtO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 05:49:14 -0400
Date:   Mon, 21 Jun 2021 09:46:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624268811;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lwB9mEJnl7gDV3hdODI/9PwdRTuhxAesmRLnmKUDb/g=;
        b=ZzkqcixQtgGQ+VjdIE6nQAxAk0nA35vBGzo5OQo6n9AqSRpBb5V2QHgcfF04nj2fvtBdxa
        48H9kK0kCM7yKaKtFiHSxMMBs2Ar0ooUCuqpK6Hztz4daqkf2cENZpcj4KytUjXLY7y6Ib
        chFWG8WnvqJrOA/DP1PvFArKwJggWJ3rP19IkO8It0mvbeqcaIA8nAnxUDvMJZ+B35raXQ
        +LNFkq/35kFa9djVVSp4LxqFeZrN7O2UOKuPQJWNubYcdl6OZcVTMANqm+qVb0i6pgUJON
        R7crwauXZK86iQg1R9RzKUML9w/6vLKX8Pgf1k4W1svAGaDOV3wguEOd0975sQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624268811;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lwB9mEJnl7gDV3hdODI/9PwdRTuhxAesmRLnmKUDb/g=;
        b=/8hs+4FrQr7mrgvfs1pEvMTieLGw3FaLcKsqUOdaWzzhiSuY9CLH7cJCLgVRWtj7UiTK+V
        fVJdQebWrHVIdjDA==
From:   "thermal-bot for Finley Xiao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/rockchip: Support RK3568 SoCs
 in the thermal driver
Cc:     Finley Xiao <finley.xiao@rock-chips.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210506175514.168365-5-ezequiel@collabora.com>
References: <20210506175514.168365-5-ezequiel@collabora.com>
MIME-Version: 1.0
Message-ID: <162426881088.395.11881885722158050019.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     16bee043fc0a6eb6e9d5306f8e9366a3dcee1fea
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//16bee043fc0a6eb6e9d5306f8e9366a3dcee1fea
Author:        Finley Xiao <finley.xiao@rock-chips.com>
AuthorDate:    Thu, 06 May 2021 14:55:14 -03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 11 Jun 2021 11:30:30 +02:00

thermal/drivers/rockchip: Support RK3568 SoCs in the thermal driver

The RK3568 SoCs have two Temperature Sensors, channel 0 is for CPU,
channel 1 is for GPU.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210506175514.168365-5-ezequiel@collabora.com
---
 drivers/thermal/rockchip_thermal.c | 121 ++++++++++++++++++++++++++++-
 1 file changed, 121 insertions(+)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index aa9e0e3..657d84b 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -211,7 +211,11 @@ struct rockchip_thermal_data {
 #define TSADCV3_AUTO_PERIOD_TIME		1875 /* 2.5ms */
 #define TSADCV3_AUTO_PERIOD_HT_TIME		1875 /* 2.5ms */
 
+#define TSADCV5_AUTO_PERIOD_TIME		1622 /* 2.5ms */
+#define TSADCV5_AUTO_PERIOD_HT_TIME		1622 /* 2.5ms */
+
 #define TSADCV2_USER_INTER_PD_SOC		0x340 /* 13 clocks */
+#define TSADCV5_USER_INTER_PD_SOC		0xfc0 /* 97us, at least 90us */
 
 #define GRF_SARADC_TESTBIT			0x0e644
 #define GRF_TSADC_TESTBIT_L			0x0e648
@@ -219,6 +223,12 @@ struct rockchip_thermal_data {
 
 #define PX30_GRF_SOC_CON2			0x0408
 
+#define RK3568_GRF_TSADC_CON			0x0600
+#define RK3568_GRF_TSADC_ANA_REG0		(0x10001 << 0)
+#define RK3568_GRF_TSADC_ANA_REG1		(0x10001 << 1)
+#define RK3568_GRF_TSADC_ANA_REG2		(0x10001 << 2)
+#define RK3568_GRF_TSADC_TSEN			(0x10001 << 8)
+
 #define GRF_SARADC_TESTBIT_ON			(0x10001 << 2)
 #define GRF_TSADC_TESTBIT_H_ON			(0x10001 << 2)
 #define GRF_TSADC_VCM_EN_L			(0x10001 << 7)
@@ -474,6 +484,45 @@ static const struct tsadc_table rk3399_code_table[] = {
 	{TSADCV3_DATA_MASK, 125000},
 };
 
+static const struct tsadc_table rk3568_code_table[] = {
+	{0, -40000},
+	{1584, -40000},
+	{1620, -35000},
+	{1652, -30000},
+	{1688, -25000},
+	{1720, -20000},
+	{1756, -15000},
+	{1788, -10000},
+	{1824, -5000},
+	{1856, 0},
+	{1892, 5000},
+	{1924, 10000},
+	{1956, 15000},
+	{1992, 20000},
+	{2024, 25000},
+	{2060, 30000},
+	{2092, 35000},
+	{2128, 40000},
+	{2160, 45000},
+	{2196, 50000},
+	{2228, 55000},
+	{2264, 60000},
+	{2300, 65000},
+	{2332, 70000},
+	{2368, 75000},
+	{2400, 80000},
+	{2436, 85000},
+	{2468, 90000},
+	{2500, 95000},
+	{2536, 100000},
+	{2572, 105000},
+	{2604, 110000},
+	{2636, 115000},
+	{2672, 120000},
+	{2704, 125000},
+	{TSADCV2_DATA_MASK, 125000},
+};
+
 static u32 rk_tsadcv2_temp_to_code(const struct chip_tsadc_table *table,
 				   int temp)
 {
@@ -701,6 +750,49 @@ static void rk_tsadcv4_initialize(struct regmap *grf, void __iomem *regs,
 	regmap_write(grf, PX30_GRF_SOC_CON2, GRF_CON_TSADC_CH_INV);
 }
 
+static void rk_tsadcv7_initialize(struct regmap *grf, void __iomem *regs,
+				  enum tshut_polarity tshut_polarity)
+{
+	writel_relaxed(TSADCV5_USER_INTER_PD_SOC, regs + TSADCV2_USER_CON);
+	writel_relaxed(TSADCV5_AUTO_PERIOD_TIME, regs + TSADCV2_AUTO_PERIOD);
+	writel_relaxed(TSADCV2_HIGHT_INT_DEBOUNCE_COUNT,
+		       regs + TSADCV2_HIGHT_INT_DEBOUNCE);
+	writel_relaxed(TSADCV5_AUTO_PERIOD_HT_TIME,
+		       regs + TSADCV2_AUTO_PERIOD_HT);
+	writel_relaxed(TSADCV2_HIGHT_TSHUT_DEBOUNCE_COUNT,
+		       regs + TSADCV2_HIGHT_TSHUT_DEBOUNCE);
+
+	if (tshut_polarity == TSHUT_HIGH_ACTIVE)
+		writel_relaxed(0U | TSADCV2_AUTO_TSHUT_POLARITY_HIGH,
+			       regs + TSADCV2_AUTO_CON);
+	else
+		writel_relaxed(0U & ~TSADCV2_AUTO_TSHUT_POLARITY_HIGH,
+			       regs + TSADCV2_AUTO_CON);
+
+	/*
+	 * The general register file will is optional
+	 * and might not be available.
+	 */
+	if (!IS_ERR(grf)) {
+		regmap_write(grf, RK3568_GRF_TSADC_CON, RK3568_GRF_TSADC_TSEN);
+		/*
+		 * RK3568 TRM, section 18.5. requires a delay no less
+		 * than 10us between the rising edge of tsadc_tsen_en
+		 * and the rising edge of tsadc_ana_reg_0/1/2.
+		 */
+		udelay(15);
+		regmap_write(grf, RK3568_GRF_TSADC_CON, RK3568_GRF_TSADC_ANA_REG0);
+		regmap_write(grf, RK3568_GRF_TSADC_CON, RK3568_GRF_TSADC_ANA_REG1);
+		regmap_write(grf, RK3568_GRF_TSADC_CON, RK3568_GRF_TSADC_ANA_REG2);
+
+		/*
+		 * RK3568 TRM, section 18.5. requires a delay no less
+		 * than 90us after the rising edge of tsadc_ana_reg_0/1/2.
+		 */
+		usleep_range(100, 200);
+	}
+}
+
 static void rk_tsadcv2_irq_ack(void __iomem *regs)
 {
 	u32 val;
@@ -1027,6 +1119,31 @@ static const struct rockchip_tsadc_chip rk3399_tsadc_data = {
 	},
 };
 
+static const struct rockchip_tsadc_chip rk3568_tsadc_data = {
+	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
+	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
+	.chn_num = 2, /* two channels for tsadc */
+
+	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
+	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
+	.tshut_temp = 95000,
+
+	.initialize = rk_tsadcv7_initialize,
+	.irq_ack = rk_tsadcv3_irq_ack,
+	.control = rk_tsadcv3_control,
+	.get_temp = rk_tsadcv2_get_temp,
+	.set_alarm_temp = rk_tsadcv2_alarm_temp,
+	.set_tshut_temp = rk_tsadcv2_tshut_temp,
+	.set_tshut_mode = rk_tsadcv2_tshut_mode,
+
+	.table = {
+		.id = rk3568_code_table,
+		.length = ARRAY_SIZE(rk3568_code_table),
+		.data_mask = TSADCV2_DATA_MASK,
+		.mode = ADC_INCREMENT,
+	},
+};
+
 static const struct of_device_id of_rockchip_thermal_match[] = {
 	{	.compatible = "rockchip,px30-tsadc",
 		.data = (void *)&px30_tsadc_data,
@@ -1059,6 +1176,10 @@ static const struct of_device_id of_rockchip_thermal_match[] = {
 		.compatible = "rockchip,rk3399-tsadc",
 		.data = (void *)&rk3399_tsadc_data,
 	},
+	{
+		.compatible = "rockchip,rk3568-tsadc",
+		.data = (void *)&rk3568_tsadc_data,
+	},
 	{ /* end */ },
 };
 MODULE_DEVICE_TABLE(of, of_rockchip_thermal_match);
