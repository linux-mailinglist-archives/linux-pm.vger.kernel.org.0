Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97EDF2983FF
	for <lists+linux-pm@lfdr.de>; Sun, 25 Oct 2020 23:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1419383AbgJYWSt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 18:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419368AbgJYWSq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 18:18:46 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB9AC0613CE;
        Sun, 25 Oct 2020 15:18:45 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id r127so9383647lff.12;
        Sun, 25 Oct 2020 15:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fsBHBQLfmL5DVRGRuAIQ1q46vl5bbq+Y8aKUMiZpU2Q=;
        b=PoyPS0RY64q57u+81iJUcH15fICx8V32h7Yy/S1oC8U2YhtxtvnkZzTvC8OHrJGHD9
         ZixcGAyLQEOtAdEC9U1sD/y9MEOESR8e/+4BB8q1Wi/X/fwGVcsa7L+O1aNnh4i8LW5c
         gxsKB3zN2fen65FtBNmqv0HrQrYrt04ojEodiFz+0EK/X+I+NHDe+UQMZNQ379GCfJVH
         swUpz3ouCiF5sawldNexar8w7IYgEeT0PZ+qn6Csb1l/H2fXXhRM+KKfd9bE0kqEq1aq
         rJAX4IiufhvsnWfyujuYgE2dINffvysRDwwiPQhk2qM/88ymPfbgsfJnCqWYBH7fRG/q
         c1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fsBHBQLfmL5DVRGRuAIQ1q46vl5bbq+Y8aKUMiZpU2Q=;
        b=Ytylimle8HvH7r8ExR1dyFh5c0C/rSGUk/5C4KdH5LNHbRllqZoMgE0PSxYYCfSODX
         W7HVj5QoTq6jiC86IZvoersU8M1KtFRChFlc0ybjSER6qusjG+w7zGw+7Ge7FQDfxbaH
         fqkUCnV9AJEgqxslOl2+hlCaT6mqQZ8daOZHwv3D7aR7iBcXPljYvcAyTNVoaXZldIDh
         bzKOSZaICqxyKUD/qfcZmnhDN6mw5qS2XhSPSt2qKWB1SDPG8Yd4JRScJDjLar+QNXav
         4fLDZww4nsjkJePl67nzQcAq3br/7FO+UJz7ezeYzAXOn487PBT0+ub2Bhy4IcVGfxGV
         o+2A==
X-Gm-Message-State: AOAM530RgwKRZyH3tCuVdJMa8oyxX3e34O80WnzMrnU/FiRJCH/sCsuc
        7v4zGeP93gJ0lCXIZ4glv+E=
X-Google-Smtp-Source: ABdhPJwoMQrwV5VZFOy1fKWusn+lWHHseo+bLcyOWzaWz5uyEypwMV9jqCEziPGE1yK853MuwWPuBw==
X-Received: by 2002:a19:64b:: with SMTP id 72mr3955120lfg.47.1603664324107;
        Sun, 25 Oct 2020 15:18:44 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.gmail.com with ESMTPSA id k13sm932423ljh.136.2020.10.25.15.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 15:18:43 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v6 49/52] PM / devfreq: tegra20: Convert to EMC_STAT driver, support interconnect and device-tree
Date:   Mon, 26 Oct 2020 01:17:32 +0300
Message-Id: <20201025221735.3062-50-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201025221735.3062-1-digetx@gmail.com>
References: <20201025221735.3062-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

External (EMC) and Internal Memory Controllers (IMC) have a nearly
identical statistics gathering module. This patch switches driver to use
EMC_STAT instead of IMC_STAT and adds device-tree support which brings ICC
support and makes driver to use bandwidth OPPs defined in device-tree.

The previous tegra20-devfreq variant was depending on presence of both
EMC and IMC drivers simultaneously because it wasn't apparent how to use
EMC_STAT properly back in the day. Dependency on the IMC driver is gone
after this patch.

The older variant of the devfreq driver also isn't suitable anymore
because EMC got support for interconnect framework and DVFS, hence
tegra20-devfreq shouldn't drive the EMC clock directly, but use OPP
API for issuing memory bandwidth requests.

The polling interval is changed from 500ms to 30ms in order to improve
responsiveness of the system in general and because EMC clock is now
allowed to go lower than before since display driver supports ICC now
as well.

The parent EMC device is an MFD device now and tegra20-devfreq its
sub-device. Devfreq driver uses SYSCON API for retrieving regmap of the
EMC registers from the parent device.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/Kconfig           |   1 +
 drivers/devfreq/tegra20-devfreq.c | 174 +++++++++++++-----------------
 2 files changed, 75 insertions(+), 100 deletions(-)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 0ee36ae2fa79..1bd225e571df 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -126,6 +126,7 @@ config ARM_TEGRA20_DEVFREQ
 	depends on ARCH_TEGRA_2x_SOC || COMPILE_TEST
 	depends on COMMON_CLK
 	select DEVFREQ_GOV_SIMPLE_ONDEMAND
+	select MFD_SYSCON
 	help
 	  This adds the DEVFREQ driver for the Tegra20 family of SoCs.
 	  It reads Memory Controller counters and adjusts the operating
diff --git a/drivers/devfreq/tegra20-devfreq.c b/drivers/devfreq/tegra20-devfreq.c
index fd801534771d..0a36b085d32a 100644
--- a/drivers/devfreq/tegra20-devfreq.c
+++ b/drivers/devfreq/tegra20-devfreq.c
@@ -7,180 +7,148 @@
 
 #include <linux/clk.h>
 #include <linux/devfreq.h>
-#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mfd/syscon.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 
-#include <soc/tegra/mc.h>
-
 #include "governor.h"
 
-#define MC_STAT_CONTROL				0x90
-#define MC_STAT_EMC_CLOCK_LIMIT			0xa0
-#define MC_STAT_EMC_CLOCKS			0xa4
-#define MC_STAT_EMC_CONTROL			0xa8
-#define MC_STAT_EMC_COUNT			0xb8
+#define EMC_STAT_CONTROL			0x160
+#define EMC_STAT_LLMC_CONTROL			0x178
+#define EMC_STAT_PWR_CLOCK_LIMIT		0x198
+#define EMC_STAT_PWR_CLOCKS			0x19c
+#define EMC_STAT_PWR_COUNT			0x1a0
 
-#define EMC_GATHER_CLEAR			(1 << 8)
-#define EMC_GATHER_ENABLE			(3 << 8)
+#define EMC_PWR_GATHER_CLEAR			(1 << 8)
+#define EMC_PWR_GATHER_DISABLE			(2 << 8)
+#define EMC_PWR_GATHER_ENABLE			(3 << 8)
 
 struct tegra_devfreq {
+	struct devfreq_simple_ondemand_data ondemand_data;
+	struct opp_table *opp_table;
 	struct devfreq *devfreq;
 	struct clk *emc_clock;
-	void __iomem *regs;
+	struct regmap *rmap;
 };
 
 static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 				u32 flags)
 {
-	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
-	struct devfreq *devfreq = tegra->devfreq;
 	struct dev_pm_opp *opp;
-	unsigned long rate;
-	int err;
+	int ret;
 
 	opp = devfreq_recommended_opp(dev, freq, flags);
-	if (IS_ERR(opp))
+	if (IS_ERR(opp)) {
+		dev_err(dev, "failed to find opp for %lu Hz\n", *freq);
 		return PTR_ERR(opp);
+	}
 
-	rate = dev_pm_opp_get_freq(opp);
+	ret = dev_pm_opp_set_bw(dev, opp);
 	dev_pm_opp_put(opp);
 
-	err = clk_set_min_rate(tegra->emc_clock, rate);
-	if (err)
-		return err;
-
-	err = clk_set_rate(tegra->emc_clock, 0);
-	if (err)
-		goto restore_min_rate;
-
-	return 0;
-
-restore_min_rate:
-	clk_set_min_rate(tegra->emc_clock, devfreq->previous_freq);
-
-	return err;
+	return ret;
 }
 
 static int tegra_devfreq_get_dev_status(struct device *dev,
 					struct devfreq_dev_status *stat)
 {
 	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
+	u32 count, clocks;
 
-	/*
-	 * EMC_COUNT returns number of memory events, that number is lower
-	 * than the number of clocks. Conversion ratio of 1/8 results in a
-	 * bit higher bandwidth than actually needed, it is good enough for
-	 * the time being because drivers don't support requesting minimum
-	 * needed memory bandwidth yet.
-	 *
-	 * TODO: adjust the ratio value once relevant drivers will support
-	 * memory bandwidth management.
-	 */
-	stat->busy_time = readl_relaxed(tegra->regs + MC_STAT_EMC_COUNT);
-	stat->total_time = readl_relaxed(tegra->regs + MC_STAT_EMC_CLOCKS) / 8;
-	stat->current_frequency = clk_get_rate(tegra->emc_clock);
+	/* freeze counters */
+	regmap_write(tegra->rmap, EMC_STAT_CONTROL, EMC_PWR_GATHER_DISABLE);
+
+	/* number of clocks when EMC request was accepted */
+	regmap_read(tegra->rmap, EMC_STAT_PWR_COUNT, &count);
+	/* total number of clocks while PWR_GATHER control was set to ENABLE */
+	regmap_read(tegra->rmap, EMC_STAT_PWR_CLOCKS, &clocks);
 
-	writel_relaxed(EMC_GATHER_CLEAR, tegra->regs + MC_STAT_CONTROL);
-	writel_relaxed(EMC_GATHER_ENABLE, tegra->regs + MC_STAT_CONTROL);
+	/* clear counters and restart */
+	regmap_write(tegra->rmap, EMC_STAT_CONTROL, EMC_PWR_GATHER_CLEAR);
+	regmap_write(tegra->rmap, EMC_STAT_CONTROL, EMC_PWR_GATHER_ENABLE);
+
+	stat->busy_time = count;
+	stat->total_time = clocks;
+	stat->current_frequency = clk_get_rate(tegra->emc_clock);
 
 	return 0;
 }
 
 static struct devfreq_dev_profile tegra_devfreq_profile = {
-	.polling_ms	= 500,
+	.polling_ms	= 30,
 	.target		= tegra_devfreq_target,
 	.get_dev_status	= tegra_devfreq_get_dev_status,
 };
 
-static struct tegra_mc *tegra_get_memory_controller(void)
-{
-	struct platform_device *pdev;
-	struct device_node *np;
-	struct tegra_mc *mc;
-
-	np = of_find_compatible_node(NULL, NULL, "nvidia,tegra20-mc-gart");
-	if (!np)
-		return ERR_PTR(-ENOENT);
-
-	pdev = of_find_device_by_node(np);
-	of_node_put(np);
-	if (!pdev)
-		return ERR_PTR(-ENODEV);
-
-	mc = platform_get_drvdata(pdev);
-	if (!mc)
-		return ERR_PTR(-EPROBE_DEFER);
-
-	return mc;
-}
-
 static int tegra_devfreq_probe(struct platform_device *pdev)
 {
+	struct device_node *emc_np = pdev->dev.parent->of_node;
 	struct tegra_devfreq *tegra;
-	struct tegra_mc *mc;
-	unsigned long max_rate;
-	unsigned long rate;
 	int err;
 
-	mc = tegra_get_memory_controller();
-	if (IS_ERR(mc)) {
-		err = PTR_ERR(mc);
-		dev_err(&pdev->dev, "failed to get memory controller: %d\n",
-			err);
-		return err;
-	}
-
 	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
 	if (!tegra)
 		return -ENOMEM;
 
 	/* EMC is a system-critical clock that is always enabled */
-	tegra->emc_clock = devm_clk_get(&pdev->dev, "emc");
+	tegra->emc_clock = devm_get_clk_from_child(&pdev->dev, emc_np, NULL);
 	if (IS_ERR(tegra->emc_clock))
 		return dev_err_probe(&pdev->dev, PTR_ERR(tegra->emc_clock),
 				     "failed to get emc clock\n");
 
-	tegra->regs = mc->regs;
-
-	max_rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
+	tegra->rmap = device_node_to_regmap(emc_np);
+	if (IS_ERR(tegra->rmap))
+		return dev_err_probe(&pdev->dev, PTR_ERR(tegra->rmap),
+				     "failed to get emc regmap\n");
 
-	for (rate = 0; rate <= max_rate; rate++) {
-		rate = clk_round_rate(tegra->emc_clock, rate);
+	tegra->opp_table = dev_pm_opp_get_opp_table(&pdev->dev);
+	if (IS_ERR(tegra->opp_table))
+		return dev_err_probe(&pdev->dev, PTR_ERR(tegra->opp_table),
+				     "failed to prepare opp table\n");
 
-		err = dev_pm_opp_add(&pdev->dev, rate, 0);
-		if (err) {
-			dev_err(&pdev->dev, "failed to add opp: %d\n", err);
-			goto remove_opps;
-		}
+	err = dev_pm_opp_of_add_table(&pdev->dev);
+	if (err) {
+		dev_err(&pdev->dev, "failed to add opp table: %d\n", err);
+		goto put_table;
 	}
 
+	/*
+	 * PWR_COUNT is 1/2 of PWR_CLOCKS at max, and thus, the up-threshold
+	 * should be less than 50.  Secondly, multiple active memory clients
+	 * may cause over 20 of lost clock cycles due to stalls caused by
+	 * competing memory accesses.  This means that threshold should be
+	 * set to a less than 30 in order to have a properly working governor.
+	 */
+	tegra->ondemand_data.upthreshold = 20;
+
 	/*
 	 * Reset statistic gathers state, select global bandwidth for the
 	 * statistics collection mode and set clocks counter saturation
 	 * limit to maximum.
 	 */
-	writel_relaxed(0x00000000, tegra->regs + MC_STAT_CONTROL);
-	writel_relaxed(0x00000000, tegra->regs + MC_STAT_EMC_CONTROL);
-	writel_relaxed(0xffffffff, tegra->regs + MC_STAT_EMC_CLOCK_LIMIT);
+	regmap_write(tegra->rmap, EMC_STAT_CONTROL, 0x00000000);
+	regmap_write(tegra->rmap, EMC_STAT_LLMC_CONTROL, 0x00000000);
+	regmap_write(tegra->rmap, EMC_STAT_PWR_CLOCK_LIMIT, 0xffffffff);
 
 	platform_set_drvdata(pdev, tegra);
 
 	tegra->devfreq = devfreq_add_device(&pdev->dev, &tegra_devfreq_profile,
-					    DEVFREQ_GOV_SIMPLE_ONDEMAND, NULL);
+					    DEVFREQ_GOV_SIMPLE_ONDEMAND,
+					    &tegra->ondemand_data);
 	if (IS_ERR(tegra->devfreq)) {
 		err = PTR_ERR(tegra->devfreq);
-		goto remove_opps;
+		goto put_table;
 	}
 
 	return 0;
 
-remove_opps:
-	dev_pm_opp_remove_all_dynamic(&pdev->dev);
+put_table:
+	dev_pm_opp_put_opp_table(tegra->opp_table);
 
 	return err;
 }
@@ -190,21 +158,27 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
 	struct tegra_devfreq *tegra = platform_get_drvdata(pdev);
 
 	devfreq_remove_device(tegra->devfreq);
-	dev_pm_opp_remove_all_dynamic(&pdev->dev);
+	dev_pm_opp_of_remove_table(&pdev->dev);
+	dev_pm_opp_put_opp_table(tegra->opp_table);
 
 	return 0;
 }
 
+static const struct of_device_id tegra_devfreq_of_match[] = {
+	{ .compatible = "nvidia,tegra20-emc-statistics" },
+	{ },
+};
+
 static struct platform_driver tegra_devfreq_driver = {
 	.probe		= tegra_devfreq_probe,
 	.remove		= tegra_devfreq_remove,
 	.driver		= {
 		.name	= "tegra20-devfreq",
+		.of_match_table = tegra_devfreq_of_match,
 	},
 };
 module_platform_driver(tegra_devfreq_driver);
 
-MODULE_ALIAS("platform:tegra20-devfreq");
 MODULE_AUTHOR("Dmitry Osipenko <digetx@gmail.com>");
 MODULE_DESCRIPTION("NVIDIA Tegra20 devfreq driver");
 MODULE_LICENSE("GPL v2");
-- 
2.27.0

