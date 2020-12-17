Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE322DD68B
	for <lists+linux-pm@lfdr.de>; Thu, 17 Dec 2020 18:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbgLQRrp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Dec 2020 12:47:45 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:52434 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729070AbgLQRrp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Dec 2020 12:47:45 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BHHfCRu008156;
        Thu, 17 Dec 2020 09:46:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=7r2s8jjI/0KAmhEmqujIYnznq+lYGbLaAnA/tbZfCCw=;
 b=EK7KxR3xKkQpLgWY3H2ragRuD9vKbokc8QtqfYt8ArlveXkyQ/Mvbo4KOesoVV40xr+x
 ex7Xt8B/7KlJeX2HB93evounKko/FX1ms3z0ihSA9NlocON0Fuirt5pA5VMoniWmKPq/
 A3eelCETmZxXFxUFyXBgsh4eZgI2kRORqUa8pY0giYDjRIfWKkcaSfovNm+rWRNCa2X3
 ElJ30A6z5RNAUH8bbciIQr8E7IN8wWCV8AEszDyTWFoXNmJx4TGGFS8k3CKdWu0LCYyp
 OuCZtB5fX7OdyHt99igMKThGURsm3C4NBF+kBp+A7ofTVukklY0zFqchLR6A6PKsaBgq 3A== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 35cx8tgfjy-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 09:46:56 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Dec
 2020 09:46:54 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Dec 2020 09:46:54 -0800
Received: from vb-cavnet.porotchkin.lan (PT-LT0319.marvell.com [10.6.202.166])
        by maili.marvell.com (Postfix) with ESMTP id 5D5053F703F;
        Thu, 17 Dec 2020 09:46:50 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-clk@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <miquel.raynal@bootlin.com>, <rui.zhang@intel.com>,
        <daniel.lezcano@linaro.org>, <amitk@kernel.org>, <mw@semihalf.com>,
        <jaz@semihalf.com>, <nadavh@marvell.com>, <bpeled@marvell.com>,
        <stefanc@marvell.com>, Konstantin Porotchkin <kostap@marvell.com>
Subject: [PATCH 2/2] clk: mvebu: use firmware SiP service for accessing dfx register set
Date:   Thu, 17 Dec 2020 19:46:02 +0200
Message-ID: <20201217174602.22212-3-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201217174602.22212-1-kostap@marvell.com>
References: <20201217174602.22212-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-17_13:2020-12-15,2020-12-17 signatures=0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Grzegorz Jaszczyk <jaz@semihalf.com>

This patch introduces support for cpu clk driver in case when SoC
DFX region is marked as secure by the firmware. In such case accessing
cpu clk registers, which are part of dfx register set, will not be
possible from non-secure world.

The ARM Trusted Firmware exposes SiP service which allows to read/write
some dfx registers (white-listed in firmware). This allows Linux cpu clk
driver to set_rate and recalc_rate with use of SMC calls.

If during cpu clk operation the SMC is unhandled (old fw case), fallback
to regmap handling.

Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 drivers/clk/mvebu/ap-cpu-clk.c    | 141 +++++++++++++++++---
 include/soc/marvell/armada8k/fw.h |   3 +
 2 files changed, 128 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/mvebu/ap-cpu-clk.c b/drivers/clk/mvebu/ap-cpu-clk.c
index b4259b60dcfd..52721ef2d7d9 100644
--- a/drivers/clk/mvebu/ap-cpu-clk.c
+++ b/drivers/clk/mvebu/ap-cpu-clk.c
@@ -10,6 +10,7 @@
 
 #define pr_fmt(fmt) "ap-cpu-clk: " fmt
 
+#include <linux/arm-smccc.h>
 #include <linux/clk-provider.h>
 #include <linux/clk.h>
 #include <linux/mfd/syscon.h>
@@ -19,6 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include "armada_ap_cp_helper.h"
+#include "soc/marvell/armada8k/fw.h"
 
 #define AP806_CPU_CLUSTER0		0
 #define AP806_CPU_CLUSTER1		1
@@ -139,8 +141,107 @@ struct ap_cpu_clk {
 	struct clk_hw hw;
 	struct regmap *pll_cr_base;
 	const struct cpu_dfs_regs *pll_regs;
+	phys_addr_t phys;
 };
 
+static int dfx_sread_smc(unsigned long addr, unsigned int *reg)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(MV_SIP_DFX, MV_SIP_DFX_SREAD, addr, 0, 0, 0, 0, 0, &res);
+
+	if (res.a0 == 0 && reg != NULL)
+		*reg = res.a1;
+
+	return res.a0;
+}
+
+static int dfx_swrite_smc(unsigned long addr, unsigned long val)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(MV_SIP_DFX, MV_SIP_DFX_SWRITE, addr, val,
+		      0, 0, 0, 0, &res);
+
+	return res.a0;
+}
+
+static int ap_clk_regmap_read(struct ap_cpu_clk *clk, unsigned int reg,
+			      unsigned int *val)
+{
+	int ret;
+
+	ret = dfx_sread_smc(clk->phys + reg, val);
+	if (ret != SMCCC_RET_SUCCESS)
+		ret = regmap_read(clk->pll_cr_base, reg, val);
+
+	return ret;
+}
+
+static int ap_clk_regmap_write(struct ap_cpu_clk *clk, unsigned int reg,
+			  unsigned int val)
+{
+	int ret;
+
+	ret = dfx_swrite_smc(clk->phys + reg, val);
+	if (ret != SMCCC_RET_SUCCESS)
+		ret = regmap_write(clk->pll_cr_base, reg, val);
+
+	return ret;
+}
+
+static int ap_clk_regmap_update_bits(struct ap_cpu_clk *clk, unsigned int reg,
+				     unsigned int mask, unsigned int val)
+{
+	int ret;
+	unsigned int tmp;
+
+	ret = dfx_sread_smc(clk->phys + reg, &tmp);
+	if (ret != SMCCC_RET_SUCCESS)
+		goto try_legacy;
+
+	tmp &= ~mask;
+	tmp |= val & mask;
+
+	ret = dfx_swrite_smc(clk->phys + reg, tmp);
+	if (ret == SMCCC_RET_SUCCESS)
+		return ret;
+
+try_legacy:
+	return regmap_update_bits(clk->pll_cr_base, reg, mask, val);
+}
+
+static int ap_clk_regmap_read_poll_timeout(struct ap_cpu_clk *clk,
+					    unsigned int reg,
+					    unsigned int stable_bit)
+{
+	int ret;
+	u32 val;
+	ktime_t timeout;
+
+	timeout = ktime_add_us(ktime_get(), STATUS_POLL_TIMEOUT_US);
+	do {
+		ret = dfx_sread_smc(clk->phys + reg, &val);
+		if (ret || (val & stable_bit))
+			break;
+
+		usleep_range((STATUS_POLL_PERIOD_US >> 2) + 1,
+			     STATUS_POLL_PERIOD_US);
+
+	} while (ktime_before(ktime_get(), timeout));
+
+	if (ret == SMCCC_RET_SUCCESS)
+		return (val & stable_bit) ? 0 : -ETIMEDOUT;
+
+	/* If above fail, try legacy */
+	ret = regmap_read_poll_timeout(clk->pll_cr_base,
+				       reg, val,
+				       val & stable_bit, STATUS_POLL_PERIOD_US,
+				       STATUS_POLL_TIMEOUT_US);
+
+	return ret;
+}
+
 static unsigned long ap_cpu_clk_recalc_rate(struct clk_hw *hw,
 					    unsigned long parent_rate)
 {
@@ -150,7 +251,7 @@ static unsigned long ap_cpu_clk_recalc_rate(struct clk_hw *hw,
 
 	cpu_clkdiv_reg = clk->pll_regs->divider_reg +
 		(clk->cluster * clk->pll_regs->cluster_offset);
-	regmap_read(clk->pll_cr_base, cpu_clkdiv_reg, &cpu_clkdiv_ratio);
+	ap_clk_regmap_read(clk, cpu_clkdiv_reg, &cpu_clkdiv_ratio);
 	cpu_clkdiv_ratio &= clk->pll_regs->divider_mask;
 	cpu_clkdiv_ratio >>= clk->pll_regs->divider_offset;
 
@@ -171,7 +272,7 @@ static int ap_cpu_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	cpu_ratio_reg = clk->pll_regs->ratio_reg +
 		(clk->cluster * clk->pll_regs->cluster_offset);
 
-	regmap_read(clk->pll_cr_base, cpu_clkdiv_reg, &reg);
+	ap_clk_regmap_read(clk, cpu_clkdiv_reg, &reg);
 	reg &= ~(clk->pll_regs->divider_mask);
 	reg |= (divider << clk->pll_regs->divider_offset);
 
@@ -184,29 +285,26 @@ static int ap_cpu_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 		reg |= ((divider * clk->pll_regs->divider_ratio) <<
 				AP807_PLL_CR_1_CPU_CLK_DIV_RATIO_OFFSET);
 	}
-	regmap_write(clk->pll_cr_base, cpu_clkdiv_reg, reg);
-
+	ap_clk_regmap_write(clk, cpu_clkdiv_reg, reg);
 
-	regmap_update_bits(clk->pll_cr_base, cpu_force_reg,
-			   clk->pll_regs->force_mask,
-			   clk->pll_regs->force_mask);
+	ap_clk_regmap_update_bits(clk, cpu_force_reg, clk->pll_regs->force_mask,
+				  clk->pll_regs->force_mask);
 
-	regmap_update_bits(clk->pll_cr_base, cpu_ratio_reg,
-			   BIT(clk->pll_regs->ratio_offset),
-			   BIT(clk->pll_regs->ratio_offset));
+	ap_clk_regmap_update_bits(clk, cpu_ratio_reg,
+				  BIT(clk->pll_regs->ratio_offset),
+				  BIT(clk->pll_regs->ratio_offset));
 
 	stable_bit = BIT(clk->pll_regs->ratio_state_offset +
 			 clk->cluster *
 			 clk->pll_regs->ratio_state_cluster_offset);
-	ret = regmap_read_poll_timeout(clk->pll_cr_base,
-				       clk->pll_regs->ratio_state_reg, reg,
-				       reg & stable_bit, STATUS_POLL_PERIOD_US,
-				       STATUS_POLL_TIMEOUT_US);
+	ret = ap_clk_regmap_read_poll_timeout(clk,
+					      clk->pll_regs->ratio_state_reg,
+					      stable_bit);
 	if (ret)
 		return ret;
 
-	regmap_update_bits(clk->pll_cr_base, cpu_ratio_reg,
-			   BIT(clk->pll_regs->ratio_offset), 0);
+	ap_clk_regmap_update_bits(clk, cpu_ratio_reg,
+				  BIT(clk->pll_regs->ratio_offset), 0);
 
 	return 0;
 }
@@ -235,6 +333,11 @@ static int ap_cpu_clock_probe(struct platform_device *pdev)
 	struct clk_hw_onecell_data *ap_cpu_data;
 	struct ap_cpu_clk *ap_cpu_clk;
 	struct regmap *regmap;
+	struct resource res;
+
+	ret = of_address_to_resource(np->parent, 0, &res);
+	if (ret)
+		return ret;
 
 	regmap = syscon_node_to_regmap(np->parent);
 	if (IS_ERR(regmap)) {
@@ -313,6 +416,12 @@ static int ap_cpu_clock_probe(struct platform_device *pdev)
 		ap_cpu_clk[cluster_index].dev = dev;
 		ap_cpu_clk[cluster_index].pll_regs = of_device_get_match_data(&pdev->dev);
 
+		/*
+		 * Hack to retrieve a physical addr that will be given to the
+		 * firmware.
+		 */
+		ap_cpu_clk[cluster_index].phys = res.start;
+
 		init.name = ap_cpu_clk[cluster_index].clk_name;
 		init.ops = &ap_cpu_clk_ops;
 		init.num_parents = 1;
diff --git a/include/soc/marvell/armada8k/fw.h b/include/soc/marvell/armada8k/fw.h
index 2a80f26cbf6f..e646212a3796 100644
--- a/include/soc/marvell/armada8k/fw.h
+++ b/include/soc/marvell/armada8k/fw.h
@@ -16,4 +16,7 @@
 #define MV_SIP_DFX_THERMAL_THRESH	5
 #define MV_SIP_DFX_THERMAL_SEL_CHANNEL	6
 
+#define MV_SIP_DFX_SREAD		20
+#define MV_SIP_DFX_SWRITE		21
+
 #endif /* _SOC_MARVELL_ARMADA8K_FW_H */
-- 
2.17.1

