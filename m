Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF34186E3F
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 01:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405158AbfHHXr4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 19:47:56 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12850 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404923AbfHHXrH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 19:47:07 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4cb47b0004>; Thu, 08 Aug 2019 16:47:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 08 Aug 2019 16:47:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 08 Aug 2019 16:47:06 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 8 Aug
 2019 23:47:05 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 8 Aug
 2019 23:47:05 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 8 Aug 2019 23:47:05 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.110]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d4cb4790000>; Thu, 08 Aug 2019 16:47:05 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <linus.walleij@linaro.org>,
        <stefan@agner.ch>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <jckuo@nvidia.com>,
        <josephl@nvidia.com>, <talho@nvidia.com>, <skomatineni@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mperttunen@nvidia.com>, <spatra@nvidia.com>, <robh+dt@kernel.org>,
        <digetx@gmail.com>, <devicetree@vger.kernel.org>,
        <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v8 16/21] soc/tegra: pmc: Add pmc wake support for tegra210
Date:   Thu, 8 Aug 2019 16:46:55 -0700
Message-ID: <1565308020-31952-17-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565308020-31952-1-git-send-email-skomatineni@nvidia.com>
References: <1565308020-31952-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565308027; bh=YC2WyHhKcxO32X94/1fVg0egtzrRq/QXLMfSSFFNqSI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=BCwzIi+6qqnfoJoTWzUOic3TGcYxxtanAowKJWSEfwy/eP/vmQuGLbYl1r3IOn8s8
         jkU5Orf6qEdfLP64gjd0EtJRrTThVNvUEVVy58Ek3sExRxPtxYnGAb77hbIOrbXsPx
         wy7IRgKyArIIM1Evr5yIANAYGo9wDP8wMW3op/uoOPVDR3qCGvbO1hZLzoK/VhOwN8
         ZOw7UAP/3HwL6q8IpnPIcfyc73gzoj63xL8r4HFwxexVf19zbANZ+UylqdeI7xPiib
         rikzRhxgOQ5kV2E5j7FDeRHB92FxlQGUxq7aCV3sGCsD3xdmqIIDWGEeiAX6LYMmF9
         rv7HtzW/OP4NQ==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch implements PMC wakeup sequence for Tegra210 and defines
common used RTC alarm wake event.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 91c84d0e66ae..3aa71c28a10a 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -58,6 +58,11 @@
 #define  PMC_CNTRL_SYSCLK_POLARITY	BIT(10) /* sys clk polarity */
 #define  PMC_CNTRL_MAIN_RST		BIT(4)
 
+#define PMC_WAKE_MASK			0x0c
+#define PMC_WAKE_LEVEL			0x10
+#define PMC_WAKE_STATUS			0x14
+#define PMC_SW_WAKE_STATUS		0x18
+
 #define DPD_SAMPLE			0x020
 #define  DPD_SAMPLE_ENABLE		BIT(0)
 #define  DPD_SAMPLE_DISABLE		(0 << 0)
@@ -87,6 +92,11 @@
 
 #define PMC_SCRATCH41			0x140
 
+#define PMC_WAKE2_MASK			0x160
+#define PMC_WAKE2_LEVEL			0x164
+#define PMC_WAKE2_STATUS		0x168
+#define PMC_SW_WAKE2_STATUS		0x16c
+
 #define PMC_SENSOR_CTRL			0x1b0
 #define  PMC_SENSOR_CTRL_SCRATCH_WRITE	BIT(2)
 #define  PMC_SENSOR_CTRL_ENABLE_RST	BIT(1)
@@ -1922,6 +1932,43 @@ static const struct irq_domain_ops tegra_pmc_irq_domain_ops = {
 	.alloc = tegra_pmc_irq_alloc,
 };
 
+static int tegra210_pmc_irq_set_wake(struct irq_data *data, unsigned int on)
+{
+	struct tegra_pmc *pmc = irq_data_get_irq_chip_data(data);
+	unsigned int offset, bit;
+	u32 value;
+
+	if (data->hwirq == ULONG_MAX)
+		return 0;
+
+	offset = data->hwirq / 32;
+	bit = data->hwirq % 32;
+
+	/* clear wake status */
+	tegra_pmc_writel(pmc, 0, PMC_SW_WAKE_STATUS);
+	tegra_pmc_writel(pmc, 0, PMC_SW_WAKE2_STATUS);
+
+	tegra_pmc_writel(pmc, 0, PMC_WAKE_STATUS);
+	tegra_pmc_writel(pmc, 0, PMC_WAKE2_STATUS);
+
+	/* enable PMC wake */
+	if (data->hwirq >= 32)
+		offset = PMC_WAKE2_MASK;
+	else
+		offset = PMC_WAKE_MASK;
+
+	value = tegra_pmc_readl(pmc, offset);
+
+	if (on)
+		value |= 1 << bit;
+	else
+		value &= ~(1 << bit);
+
+	tegra_pmc_writel(pmc, value, offset);
+
+	return 0;
+}
+
 static int tegra186_pmc_irq_set_wake(struct irq_data *data, unsigned int on)
 {
 	struct tegra_pmc *pmc = irq_data_get_irq_chip_data(data);
@@ -1954,6 +2001,49 @@ static int tegra186_pmc_irq_set_wake(struct irq_data *data, unsigned int on)
 	return 0;
 }
 
+static int tegra210_pmc_irq_set_type(struct irq_data *data, unsigned int type)
+{
+	struct tegra_pmc *pmc = irq_data_get_irq_chip_data(data);
+	unsigned int offset, bit;
+	u32 value;
+
+	if (data->hwirq == ULONG_MAX)
+		return 0;
+
+	offset = data->hwirq / 32;
+	bit = data->hwirq % 32;
+
+	if (data->hwirq >= 32)
+		offset = PMC_WAKE2_LEVEL;
+	else
+		offset = PMC_WAKE_LEVEL;
+
+	value = tegra_pmc_readl(pmc, offset);
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+	case IRQ_TYPE_LEVEL_HIGH:
+		value |= 1 << bit;
+		break;
+
+	case IRQ_TYPE_EDGE_FALLING:
+	case IRQ_TYPE_LEVEL_LOW:
+		value &= ~(1 << bit);
+		break;
+
+	case IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING:
+		value ^= 1 << bit;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	tegra_pmc_writel(pmc, value, offset);
+
+	return 0;
+}
+
 static int tegra186_pmc_irq_set_type(struct irq_data *data, unsigned int type)
 {
 	struct tegra_pmc *pmc = irq_data_get_irq_chip_data(data);
@@ -2540,6 +2630,10 @@ static const struct pinctrl_pin_desc tegra210_pin_descs[] = {
 	TEGRA210_IO_PAD_TABLE(TEGRA_IO_PIN_DESC)
 };
 
+static const struct tegra_wake_event tegra210_wake_events[] = {
+	TEGRA_WAKE_IRQ("rtc", 16, 2),
+};
+
 static const struct tegra_pmc_soc tegra210_pmc_soc = {
 	.num_powergates = ARRAY_SIZE(tegra210_powergates),
 	.powergates = tegra210_powergates,
@@ -2557,10 +2651,14 @@ static const struct tegra_pmc_soc tegra210_pmc_soc = {
 	.regs = &tegra20_pmc_regs,
 	.init = tegra20_pmc_init,
 	.setup_irq_polarity = tegra20_pmc_setup_irq_polarity,
+	.irq_set_wake = tegra210_pmc_irq_set_wake,
+	.irq_set_type = tegra210_pmc_irq_set_type,
 	.reset_sources = tegra210_reset_sources,
 	.num_reset_sources = ARRAY_SIZE(tegra210_reset_sources),
 	.reset_levels = NULL,
 	.num_reset_levels = 0,
+	.num_wake_events = ARRAY_SIZE(tegra210_wake_events),
+	.wake_events = tegra210_wake_events,
 };
 
 #define TEGRA186_IO_PAD_TABLE(_pad)					     \
-- 
2.7.4

