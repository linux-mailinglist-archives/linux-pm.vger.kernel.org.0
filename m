Return-Path: <linux-pm+bounces-40429-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A7BD0201C
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 11:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95D8A30D04BB
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 09:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2289357A2D;
	Thu,  8 Jan 2026 08:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="6VPKs3cy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD11033D4FD;
	Thu,  8 Jan 2026 08:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767860824; cv=none; b=bKXikeBz+nnCdPFS9ngjFvrm8Dfro7V9KkGxBPO/qToQSGiCCt0VAtvbX8x/a84Tw44ajquQkMxMtK5DIfofB7IBpjoy35aXV8JjQviYi2WXE70qpYkQ6t1f6bk1Gg2ktZQQTn15JBo9UYOS2OqVlwwcYpXElQIrQEVuT2P2nME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767860824; c=relaxed/simple;
	bh=cIINlx0pXAnhuBkTj6tCzNyC+6r8c+Me4t0PkzSNasg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qhtYQpndv02o6xjtpZwDWE6/lRXaGYmUmIuG8zjAQE4lE8PVgIVRGL6eA9gjC+3IrviSedlOrwsAEkhbMZAnd5ffYRYK2Gi3wgW56AJD8f4JjeUKb1WOxwkNM+ZmRjxfAzRFTgj2AuzRmBZheQETfna6vxxAN2XICueIynxvNXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=6VPKs3cy; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:In-Reply-To:References:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=X8ocl7fu5fatFsxlNtJzRAbZiPjohuelEktVlKMH2EA=; b=6VPKs3cyCFcmNeI/nFGcBPGvIt
	7xeYKFD5mq5/tarj1wZR2mKwb3xs0zuYC6ZhVThhaM4hNGYzvUsFi/4/zHffXaUwr0BDjrZDX21oa
	eGxQlDTMOvUHsZ1zs/r418oBrp8Yfb0C3f12FGCjqwAsak9EUFXDmj1vGYklb40aAv8uYOy3oxqCY
	6tra0/NIxe4aRPIVrxjofRPgC4WA2rwBraEbSgTBskCsQYcIh9ENjLsivGqAILuzmcWTjefgrLGfQ
	6gHi/ABhH0dYhbwgyhl4abNexMlOjopwod0KUIQxq+bTx0V6kxQMr6wH1ztaSC+hvmbvRGT4XeIna
	eSDWEgZw==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Thu, 08 Jan 2026 09:26:12 +0100
Subject: [PATCH 1/2] cpufreq: omap: remove driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-omap-cpufreq-removal-v1-1-8fe42f130f48@kemnade.info>
References: <20260108-omap-cpufreq-removal-v1-0-8fe42f130f48@kemnade.info>
In-Reply-To: <20260108-omap-cpufreq-removal-v1-0-8fe42f130f48@kemnade.info>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 linux-omap@vger.kernel.org
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7474; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=cIINlx0pXAnhuBkTj6tCzNyC+6r8c+Me4t0PkzSNasg=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDJnxWZYP5D4VHDUX7HLOUTSRnrN36YJ9B99I9Jtrsr42f
 KEStNeqo5SFQYyLQVZMkeWXtYLbJ5VnucFTI+xh5rAygQxh4OIUgInU7GT4X5H3zsY1/JGdZVrk
 l1y+TZUffk/1uRLooGpTO80zNMl8M8Nfgc0pnzTs2UtUlO4ZPK9Uy3Raou9x7sDltfMdqiyd2he
 yAQA=
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

The omap-cpufreq driver is not used in the corresponding defconfigs.
The pseudo platform device to use it was removed by
commit cb6675d6a868 ("ARM: OMAP2+: Remove legacy PM init")
10 years ago.

Checking if there is any need to reactivate it:
For omap3, dra7 there is ti-cpufreq to create cpufreq-dt device
For omap2/4/5 there is cpufreq-dt-plat to create cpufreq-dt device.
For omap1 this driver cannot be selected at all.

So no users, no need to reactivate the driver somehow. So remove it.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/cpufreq/Kconfig.arm    |   5 --
 drivers/cpufreq/Makefile       |   1 -
 drivers/cpufreq/omap-cpufreq.c | 195 -----------------------------------------
 3 files changed, 201 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 9be0503df55a0..4014bc9dd73a2 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -141,11 +141,6 @@ config ARM_MEDIATEK_CPUFREQ_HW
 	  The driver implements the cpufreq interface for this HW engine.
 	  Say Y if you want to support CPUFreq HW.
 
-config ARM_OMAP2PLUS_CPUFREQ
-	bool "TI OMAP2+"
-	depends on ARCH_OMAP2PLUS || COMPILE_TEST
-	default ARCH_OMAP2PLUS
-
 config ARM_QCOM_CPUFREQ_NVMEM
 	tristate "Qualcomm nvmem based CPUFreq"
 	depends on ARCH_QCOM || COMPILE_TEST
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 681d687b5a18e..385c9fcc65c62 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -69,7 +69,6 @@ obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)	+= kirkwood-cpufreq.o
 obj-$(CONFIG_ARM_MEDIATEK_CPUFREQ)	+= mediatek-cpufreq.o
 obj-$(CONFIG_ARM_MEDIATEK_CPUFREQ_HW)	+= mediatek-cpufreq-hw.o
 obj-$(CONFIG_MACH_MVEBU_V7)		+= mvebu-cpufreq.o
-obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)	+= omap-cpufreq.o
 obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)	+= pxa2xx-cpufreq.o
 obj-$(CONFIG_PXA3xx)			+= pxa3xx-cpufreq.o
 obj-$(CONFIG_ARM_QCOM_CPUFREQ_HW)	+= qcom-cpufreq-hw.o
diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
deleted file mode 100644
index bbb01d93b54b1..0000000000000
--- a/drivers/cpufreq/omap-cpufreq.c
+++ /dev/null
@@ -1,195 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- *  CPU frequency scaling for OMAP using OPP information
- *
- *  Copyright (C) 2005 Nokia Corporation
- *  Written by Tony Lindgren <tony@atomide.com>
- *
- *  Based on cpu-sa1110.c, Copyright (C) 2001 Russell King
- *
- * Copyright (C) 2007-2011 Texas Instruments, Inc.
- * - OMAP3/4 support by Rajendra Nayak, Santosh Shilimkar
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/cpufreq.h>
-#include <linux/delay.h>
-#include <linux/init.h>
-#include <linux/err.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-#include <linux/pm_opp.h>
-#include <linux/cpu.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/regulator/consumer.h>
-
-/* OPP tolerance in percentage */
-#define	OPP_TOLERANCE	4
-
-static struct cpufreq_frequency_table *freq_table;
-static atomic_t freq_table_users = ATOMIC_INIT(0);
-static struct device *mpu_dev;
-static struct regulator *mpu_reg;
-
-static int omap_target(struct cpufreq_policy *policy, unsigned int index)
-{
-	int r, ret;
-	struct dev_pm_opp *opp;
-	unsigned long freq, volt = 0, volt_old = 0, tol = 0;
-	unsigned int old_freq, new_freq;
-
-	old_freq = policy->cur;
-	new_freq = freq_table[index].frequency;
-
-	freq = new_freq * 1000;
-	ret = clk_round_rate(policy->clk, freq);
-	if (ret < 0) {
-		dev_warn(mpu_dev,
-			 "CPUfreq: Cannot find matching frequency for %lu\n",
-			 freq);
-		return ret;
-	}
-	freq = ret;
-
-	if (mpu_reg) {
-		opp = dev_pm_opp_find_freq_ceil(mpu_dev, &freq);
-		if (IS_ERR(opp)) {
-			dev_err(mpu_dev, "%s: unable to find MPU OPP for %d\n",
-				__func__, new_freq);
-			return -EINVAL;
-		}
-		volt = dev_pm_opp_get_voltage(opp);
-		dev_pm_opp_put(opp);
-		tol = volt * OPP_TOLERANCE / 100;
-		volt_old = regulator_get_voltage(mpu_reg);
-	}
-
-	dev_dbg(mpu_dev, "cpufreq-omap: %u MHz, %ld mV --> %u MHz, %ld mV\n", 
-		old_freq / 1000, volt_old ? volt_old / 1000 : -1,
-		new_freq / 1000, volt ? volt / 1000 : -1);
-
-	/* scaling up?  scale voltage before frequency */
-	if (mpu_reg && (new_freq > old_freq)) {
-		r = regulator_set_voltage(mpu_reg, volt - tol, volt + tol);
-		if (r < 0) {
-			dev_warn(mpu_dev, "%s: unable to scale voltage up.\n",
-				 __func__);
-			return r;
-		}
-	}
-
-	ret = clk_set_rate(policy->clk, new_freq * 1000);
-
-	/* scaling down?  scale voltage after frequency */
-	if (mpu_reg && (new_freq < old_freq)) {
-		r = regulator_set_voltage(mpu_reg, volt - tol, volt + tol);
-		if (r < 0) {
-			dev_warn(mpu_dev, "%s: unable to scale voltage down.\n",
-				 __func__);
-			clk_set_rate(policy->clk, old_freq * 1000);
-			return r;
-		}
-	}
-
-	return ret;
-}
-
-static inline void freq_table_free(void)
-{
-	if (atomic_dec_and_test(&freq_table_users))
-		dev_pm_opp_free_cpufreq_table(mpu_dev, &freq_table);
-}
-
-static int omap_cpu_init(struct cpufreq_policy *policy)
-{
-	int result;
-
-	policy->clk = clk_get(NULL, "cpufreq_ck");
-	if (IS_ERR(policy->clk))
-		return PTR_ERR(policy->clk);
-
-	if (!freq_table) {
-		result = dev_pm_opp_init_cpufreq_table(mpu_dev, &freq_table);
-		if (result) {
-			dev_err(mpu_dev,
-				"%s: cpu%d: failed creating freq table[%d]\n",
-				__func__, policy->cpu, result);
-			clk_put(policy->clk);
-			return result;
-		}
-	}
-
-	atomic_inc_return(&freq_table_users);
-
-	/* FIXME: what's the actual transition time? */
-	cpufreq_generic_init(policy, freq_table, 300 * 1000);
-
-	return 0;
-}
-
-static void omap_cpu_exit(struct cpufreq_policy *policy)
-{
-	freq_table_free();
-	clk_put(policy->clk);
-}
-
-static struct cpufreq_driver omap_driver = {
-	.flags		= CPUFREQ_NEED_INITIAL_FREQ_CHECK,
-	.verify		= cpufreq_generic_frequency_table_verify,
-	.target_index	= omap_target,
-	.get		= cpufreq_generic_get,
-	.init		= omap_cpu_init,
-	.exit		= omap_cpu_exit,
-	.register_em	= cpufreq_register_em_with_opp,
-	.name		= "omap",
-};
-
-static int omap_cpufreq_probe(struct platform_device *pdev)
-{
-	mpu_dev = get_cpu_device(0);
-	if (!mpu_dev) {
-		pr_warn("%s: unable to get the MPU device\n", __func__);
-		return -EINVAL;
-	}
-
-	mpu_reg = regulator_get(mpu_dev, "vcc");
-	if (IS_ERR(mpu_reg)) {
-		pr_warn("%s: unable to get MPU regulator\n", __func__);
-		mpu_reg = NULL;
-	} else {
-		/* 
-		 * Ensure physical regulator is present.
-		 * (e.g. could be dummy regulator.)
-		 */
-		if (regulator_get_voltage(mpu_reg) < 0) {
-			pr_warn("%s: physical regulator not present for MPU\n",
-				__func__);
-			regulator_put(mpu_reg);
-			mpu_reg = NULL;
-		}
-	}
-
-	return cpufreq_register_driver(&omap_driver);
-}
-
-static void omap_cpufreq_remove(struct platform_device *pdev)
-{
-	cpufreq_unregister_driver(&omap_driver);
-}
-
-static struct platform_driver omap_cpufreq_platdrv = {
-	.driver = {
-		.name	= "omap-cpufreq",
-	},
-	.probe		= omap_cpufreq_probe,
-	.remove		= omap_cpufreq_remove,
-};
-module_platform_driver(omap_cpufreq_platdrv);
-
-MODULE_DESCRIPTION("cpufreq driver for OMAP SoCs");
-MODULE_LICENSE("GPL");

-- 
2.47.3


