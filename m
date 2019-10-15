Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E60AAD81D1
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 23:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389843AbfJOVSO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 17:18:14 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44957 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfJOVRM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 17:17:12 -0400
Received: by mail-lf1-f68.google.com with SMTP id q12so15591933lfc.11;
        Tue, 15 Oct 2019 14:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M1IGNHI8du2Zq3gFJxEz/wszSn7KLQR6VXkH2NjIP24=;
        b=jEBTOr98hTarxb6M30tQaGYBWQUqhAStA6oNL2Or9pCAeg/BryzeOstbh+XAsy3EGv
         cxysyZub8E2ZgqpeWHbb7JqVaMa2dCrmaZlF6S/xy9bgMB/k72hVWUF6Hc9otRnY+d3x
         Z95znfyCIVIUnzQNz50EWgkicNMXwzDfIMcmNNG/jN6qbJeO6wLBX2YDbLkVJg1vd74E
         5i7Kyfy6aLfJ2EL2clTxYpoe1tHcnlZGMHICZhxvRkucgRed4Mwy7HuCfb5MkR9X7C04
         bUMilNIAJPUKLcNY5sPAWxsSrnGXP86uMUmkxtSSObwAuxe7CaQG2v6sQcdoXsr713Ye
         h0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M1IGNHI8du2Zq3gFJxEz/wszSn7KLQR6VXkH2NjIP24=;
        b=IeijQFxIMiyzV8p8geZkOSLoU31zl2qbUtY9U52B+tl+lEtFJa0FPkOG15oNCpibC4
         Xhiu/PqUyeBj3FcUB7WP/1922j4vUnpz4YSX8OW4098ITbMgwgJOhVmPS7mOIW5hDUrd
         4wCZqv4UrK89KeRlDYfxrpUoMR1hlqdRIv4Z+sEH+VLCbXZZco4fbzz+TkGp3kkJfVwM
         KpKQNtXJCg7xs15LjSo8ij8mAEA3FASDabvnYdErvZePYMVFDUVg4wjzNzwExMkOr2Es
         eY/w5Xn/mDKIS7fHYbhOJ4GJs9VTjhgAXOOBL9kLgLyHNFaojdoAtJbJTqKN8Cr765Eb
         L+nA==
X-Gm-Message-State: APjAAAUIQbBr5Y7d1lTsvhnrN/oOry0shLj2YvJq7geaxtxgJxF4hFhQ
        9tYsQ4KkfjTO5lM6Bib3QD4=
X-Google-Smtp-Source: APXvYqxgswHxllGzzYFwyGlOzRkoAwL7vTegOJrc7H+SSZxjDZdsvfNn/AkPPJgQafcp5u8JHaPmAw==
X-Received: by 2002:a19:148:: with SMTP id 69mr10650519lfb.76.1571174226898;
        Tue, 15 Oct 2019 14:17:06 -0700 (PDT)
Received: from localhost.localdomain ([94.29.10.250])
        by smtp.gmail.com with ESMTPSA id t16sm5269186ljj.29.2019.10.15.14.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 14:17:06 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 07/17] cpufreq: tegra20: Use generic cpufreq-dt driver (Tegra30 supported now)
Date:   Wed, 16 Oct 2019 00:16:08 +0300
Message-Id: <20191015211618.20758-8-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015211618.20758-1-digetx@gmail.com>
References: <20191015211618.20758-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Re-parenting to intermediate clock is supported now by the clock driver
and thus there is no need in a customized CPUFreq driver, all that code
is common for both Tegra20 and Tegra30. The available CPU freqs are now
specified in device-tree in a form of OPPs, all users should update their
device-trees.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpufreq/Kconfig.arm          |   4 +-
 drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
 drivers/cpufreq/tegra20-cpufreq.c    | 236 ++++++---------------------
 3 files changed, 55 insertions(+), 187 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index a905796f7f85..2118c45d0acd 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -301,8 +301,8 @@ config ARM_TANGO_CPUFREQ
 	default y
 
 config ARM_TEGRA20_CPUFREQ
-	tristate "Tegra20 CPUFreq support"
-	depends on ARCH_TEGRA
+	bool "Tegra20 CPUFreq support"
+	depends on ARCH_TEGRA && CPUFREQ_DT
 	default y
 	help
 	  This adds the CPUFreq driver support for Tegra20 SOCs.
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 54bc76743b1f..07e88dcd112d 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -121,6 +121,8 @@ static const struct of_device_id blacklist[] __initconst = {
 	{ .compatible = "mediatek,mt8176", },
 	{ .compatible = "mediatek,mt8183", },
 
+	{ .compatible = "nvidia,tegra20", },
+	{ .compatible = "nvidia,tegra30", },
 	{ .compatible = "nvidia,tegra124", },
 	{ .compatible = "nvidia,tegra210", },
 
diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
index f84ecd22f488..042017c73afa 100644
--- a/drivers/cpufreq/tegra20-cpufreq.c
+++ b/drivers/cpufreq/tegra20-cpufreq.c
@@ -7,215 +7,81 @@
  *	Based on arch/arm/plat-omap/cpu-omap.c, (C) 2005 Nokia Corporation
  */
 
-#include <linux/clk.h>
-#include <linux/cpufreq.h>
+#define pr_fmt(fmt) "tegra20-cpufreq: " fmt
+
+#include <linux/bits.h>
 #include <linux/err.h>
 #include <linux/init.h>
-#include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm_opp.h>
 #include <linux/types.h>
 
-static struct cpufreq_frequency_table freq_table[] = {
-	{ .frequency = 216000 },
-	{ .frequency = 312000 },
-	{ .frequency = 456000 },
-	{ .frequency = 608000 },
-	{ .frequency = 760000 },
-	{ .frequency = 816000 },
-	{ .frequency = 912000 },
-	{ .frequency = 1000000 },
-	{ .frequency = CPUFREQ_TABLE_END },
-};
-
-struct tegra20_cpufreq {
-	struct device *dev;
-	struct cpufreq_driver driver;
-	struct clk *cpu_clk;
-	struct clk *pll_x_clk;
-	struct clk *pll_p_clk;
-	bool pll_x_prepared;
-};
-
-static unsigned int tegra_get_intermediate(struct cpufreq_policy *policy,
-					   unsigned int index)
-{
-	struct tegra20_cpufreq *cpufreq = cpufreq_get_driver_data();
-	unsigned int ifreq = clk_get_rate(cpufreq->pll_p_clk) / 1000;
-
-	/*
-	 * Don't switch to intermediate freq if:
-	 * - we are already at it, i.e. policy->cur == ifreq
-	 * - index corresponds to ifreq
-	 */
-	if (freq_table[index].frequency == ifreq || policy->cur == ifreq)
-		return 0;
-
-	return ifreq;
-}
+#include <soc/tegra/common.h>
+#include <soc/tegra/fuse.h>
 
-static int tegra_target_intermediate(struct cpufreq_policy *policy,
-				     unsigned int index)
+static bool __init cpu0_node_has_opp_v2_prop(void)
 {
-	struct tegra20_cpufreq *cpufreq = cpufreq_get_driver_data();
-	int ret;
-
-	/*
-	 * Take an extra reference to the main pll so it doesn't turn
-	 * off when we move the cpu off of it as enabling it again while we
-	 * switch to it from tegra_target() would take additional time.
-	 *
-	 * When target-freq is equal to intermediate freq we don't need to
-	 * switch to an intermediate freq and so this routine isn't called.
-	 * Also, we wouldn't be using pll_x anymore and must not take extra
-	 * reference to it, as it can be disabled now to save some power.
-	 */
-	clk_prepare_enable(cpufreq->pll_x_clk);
-
-	ret = clk_set_parent(cpufreq->cpu_clk, cpufreq->pll_p_clk);
-	if (ret)
-		clk_disable_unprepare(cpufreq->pll_x_clk);
-	else
-		cpufreq->pll_x_prepared = true;
+	struct device_node *np = of_cpu_device_node_get(0);
+	bool ret = false;
 
-	return ret;
-}
-
-static int tegra_target(struct cpufreq_policy *policy, unsigned int index)
-{
-	struct tegra20_cpufreq *cpufreq = cpufreq_get_driver_data();
-	unsigned long rate = freq_table[index].frequency;
-	unsigned int ifreq = clk_get_rate(cpufreq->pll_p_clk) / 1000;
-	int ret;
-
-	/*
-	 * target freq == pll_p, don't need to take extra reference to pll_x_clk
-	 * as it isn't used anymore.
-	 */
-	if (rate == ifreq)
-		return clk_set_parent(cpufreq->cpu_clk, cpufreq->pll_p_clk);
-
-	ret = clk_set_rate(cpufreq->pll_x_clk, rate * 1000);
-	/* Restore to earlier frequency on error, i.e. pll_x */
-	if (ret)
-		dev_err(cpufreq->dev, "Failed to change pll_x to %lu\n", rate);
-
-	ret = clk_set_parent(cpufreq->cpu_clk, cpufreq->pll_x_clk);
-	/* This shouldn't fail while changing or restoring */
-	WARN_ON(ret);
-
-	/*
-	 * Drop count to pll_x clock only if we switched to intermediate freq
-	 * earlier while transitioning to a target frequency.
-	 */
-	if (cpufreq->pll_x_prepared) {
-		clk_disable_unprepare(cpufreq->pll_x_clk);
-		cpufreq->pll_x_prepared = false;
-	}
+	if (of_get_property(np, "operating-points-v2", NULL))
+		ret = true;
 
+	of_node_put(np);
 	return ret;
 }
 
-static int tegra_cpu_init(struct cpufreq_policy *policy)
+static int __init tegra20_cpufreq_init(void)
 {
-	struct tegra20_cpufreq *cpufreq = cpufreq_get_driver_data();
-
-	clk_prepare_enable(cpufreq->cpu_clk);
-
-	/* FIXME: what's the actual transition time? */
-	cpufreq_generic_init(policy, freq_table, 300 * 1000);
-	policy->clk = cpufreq->cpu_clk;
-	policy->suspend_freq = freq_table[0].frequency;
-	return 0;
-}
-
-static int tegra_cpu_exit(struct cpufreq_policy *policy)
-{
-	struct tegra20_cpufreq *cpufreq = cpufreq_get_driver_data();
-
-	clk_disable_unprepare(cpufreq->cpu_clk);
-	return 0;
-}
-
-static int tegra20_cpufreq_probe(struct platform_device *pdev)
-{
-	struct tegra20_cpufreq *cpufreq;
+	struct platform_device *cpufreq_dt;
+	struct opp_table *opp_table;
+	u32 versions[2];
 	int err;
 
-	cpufreq = devm_kzalloc(&pdev->dev, sizeof(*cpufreq), GFP_KERNEL);
-	if (!cpufreq)
-		return -ENOMEM;
+	if (!soc_is_tegra())
+		return 0;
 
-	cpufreq->cpu_clk = clk_get_sys(NULL, "cclk");
-	if (IS_ERR(cpufreq->cpu_clk))
-		return PTR_ERR(cpufreq->cpu_clk);
+	switch (tegra_get_chip_id()) {
+	case TEGRA20:
+		versions[0] = BIT(tegra_sku_info.cpu_process_id);
+		versions[1] = BIT(tegra_sku_info.soc_speedo_id);
+		break;
+	case TEGRA30:
+		versions[0] = BIT(tegra_sku_info.cpu_process_id);
+		versions[1] = BIT(tegra_sku_info.cpu_speedo_id);
+		break;
+	default:
+		return 0;
+	}
 
-	cpufreq->pll_x_clk = clk_get_sys(NULL, "pll_x");
-	if (IS_ERR(cpufreq->pll_x_clk)) {
-		err = PTR_ERR(cpufreq->pll_x_clk);
-		goto put_cpu;
+	if (!cpu0_node_has_opp_v2_prop()) {
+		pr_err("operating points not found\n");
+		pr_err("can't continue, please update your device tree\n");
+		return 0;
 	}
 
-	cpufreq->pll_p_clk = clk_get_sys(NULL, "pll_p");
-	if (IS_ERR(cpufreq->pll_p_clk)) {
-		err = PTR_ERR(cpufreq->pll_p_clk);
-		goto put_pll_x;
+	pr_info("hardware version 0x%x 0x%x\n", versions[0], versions[1]);
+
+	opp_table = dev_pm_opp_set_supported_hw(get_cpu_device(0), versions, 2);
+	err = PTR_ERR_OR_ZERO(opp_table);
+	if (err) {
+		pr_err("failed to set supported hw: %d\n", err);
+		return err;
 	}
 
-	cpufreq->dev = &pdev->dev;
-	cpufreq->driver.get = cpufreq_generic_get;
-	cpufreq->driver.attr = cpufreq_generic_attr;
-	cpufreq->driver.init = tegra_cpu_init;
-	cpufreq->driver.exit = tegra_cpu_exit;
-	cpufreq->driver.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK;
-	cpufreq->driver.verify = cpufreq_generic_frequency_table_verify;
-	cpufreq->driver.suspend = cpufreq_generic_suspend;
-	cpufreq->driver.driver_data = cpufreq;
-	cpufreq->driver.target_index = tegra_target;
-	cpufreq->driver.get_intermediate = tegra_get_intermediate;
-	cpufreq->driver.target_intermediate = tegra_target_intermediate;
-	snprintf(cpufreq->driver.name, CPUFREQ_NAME_LEN, "tegra");
-
-	err = cpufreq_register_driver(&cpufreq->driver);
-	if (err)
-		goto put_pll_p;
-
-	platform_set_drvdata(pdev, cpufreq);
+	cpufreq_dt = platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
+	err = PTR_ERR_OR_ZERO(cpufreq_dt);
+	if (err) {
+		pr_err("failed to create cpufreq-dt device: %d\n", err);
+		goto err_put_supported_hw;
+	}
 
 	return 0;
 
-put_pll_p:
-	clk_put(cpufreq->pll_p_clk);
-put_pll_x:
-	clk_put(cpufreq->pll_x_clk);
-put_cpu:
-	clk_put(cpufreq->cpu_clk);
+err_put_supported_hw:
+	dev_pm_opp_put_supported_hw(opp_table);
 
 	return err;
 }
-
-static int tegra20_cpufreq_remove(struct platform_device *pdev)
-{
-	struct tegra20_cpufreq *cpufreq = platform_get_drvdata(pdev);
-
-	cpufreq_unregister_driver(&cpufreq->driver);
-
-	clk_put(cpufreq->pll_p_clk);
-	clk_put(cpufreq->pll_x_clk);
-	clk_put(cpufreq->cpu_clk);
-
-	return 0;
-}
-
-static struct platform_driver tegra20_cpufreq_driver = {
-	.probe		= tegra20_cpufreq_probe,
-	.remove		= tegra20_cpufreq_remove,
-	.driver		= {
-		.name	= "tegra20-cpufreq",
-	},
-};
-module_platform_driver(tegra20_cpufreq_driver);
-
-MODULE_ALIAS("platform:tegra20-cpufreq");
-MODULE_AUTHOR("Colin Cross <ccross@android.com>");
-MODULE_DESCRIPTION("NVIDIA Tegra20 cpufreq driver");
-MODULE_LICENSE("GPL");
+late_initcall(tegra20_cpufreq_init);
-- 
2.23.0

