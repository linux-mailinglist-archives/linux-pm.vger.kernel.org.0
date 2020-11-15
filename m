Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B039F2B39AD
	for <lists+linux-pm@lfdr.de>; Sun, 15 Nov 2020 22:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgKOVeB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Nov 2020 16:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgKOVdZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Nov 2020 16:33:25 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E027C0613D1;
        Sun, 15 Nov 2020 13:33:25 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id u19so16122253lfr.7;
        Sun, 15 Nov 2020 13:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1j4+uPn19nYlQRV8K/ttREulXQcGNd6BoXro7m/3VBs=;
        b=Nlp3L19gxUd7A9vgC2aG49c6OYxgStk2chJSVbmKYDZHsEU1aFs/WEhNi2yEhdjE/Q
         m5DTW7wW0xYggpkgaGYJpkGIKvwjWjvRCIVkqYp+RJwWXUIfBOUb1Q42ALJVvId0uCFT
         Tc+phXSYSZWRF2sfx/FAt9QaU/uPMAerZnN1EkUWMcYmAbrXMaVsKgU3yizkY5k/3owc
         QpfllYXbQ0QXifTi/MMvN+6pKr3hnx5DPBrvpa3aVTFlk0NNEYRSqpL0oiF2PkFch9qc
         V6UuC2LWXXMo8/rgiyfAYxRHGycjhm3NTL5s4UuLKhmpm1UnloQhlHXmb+iNSKh+13mC
         klAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1j4+uPn19nYlQRV8K/ttREulXQcGNd6BoXro7m/3VBs=;
        b=XxnjxfFLp8PN1SeVcY9MaK+gnbo/NGQR4DQKk8U5d1I0WLX/S8DBvucoo1NU/48daZ
         loBCRLTfY66PJoh8+MakipEeK2KjvWxgca3CX0cst9H4hVi3oiXO6iGrr9gNb5X7Xh/y
         Lo8/TotzCY8Qe2LyzC6FuIOfHA0lvYK3Ui3tH4/IiPX6QvzyWOTLlMsSlAFkLLN0bmWW
         0DCxq3KvGKiNltw0GHF2HdAnTNe1Cr2o3zaeyNMr/faXJpgiOYiZZOMYDvn2O9YGFyG7
         KRLxvtMWnNimpgcO30kwTL7IudxkQTTOPtXHtDLqOZDr9osxBidyVOIUULIff1RIv8iP
         2dSg==
X-Gm-Message-State: AOAM530MErDuuOyJHcz5PFEKAFz1bZnXhJkRjvhBXMu3snS8WvFC0OgA
        VzhYvkac+pZTURiJ8CMbqBk=
X-Google-Smtp-Source: ABdhPJzRgWZWCCvzYp70o/fNJ/fp/jzSL3bgYijHaYrUcq79pbUTm67rsKdzWID5XIn46hPUy6NO/w==
X-Received: by 2002:a19:be8d:: with SMTP id o135mr4718421lff.200.1605476003812;
        Sun, 15 Nov 2020 13:33:23 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id o3sm2462055lfo.217.2020.11.15.13.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 13:33:23 -0800 (PST)
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
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v9 07/17] PM / devfreq: tegra30: Support interconnect and OPPs from device-tree
Date:   Mon, 16 Nov 2020 00:29:12 +0300
Message-Id: <20201115212922.4390-8-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201115212922.4390-1-digetx@gmail.com>
References: <20201115212922.4390-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch moves ACTMON driver away from generating OPP table by itself,
transitioning it to use the table which comes from device-tree. This
change breaks compatibility with older device-trees in order to bring
support for the interconnect framework to the driver. This is a mandatory
change which needs to be done in order to implement interconnect-based
memory DVFS. Users of legacy device-trees will get a message telling that
theirs DT needs to be upgraded. Now ACTMON issues memory bandwidth request
using dev_pm_opp_set_bw(), instead of driving EMC clock rate directly.

Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 86 ++++++++++++++++---------------
 1 file changed, 44 insertions(+), 42 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 38cc0d014738..ed6d4469c8c7 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -19,6 +19,8 @@
 #include <linux/reset.h>
 #include <linux/workqueue.h>
 
+#include <soc/tegra/fuse.h>
+
 #include "governor.h"
 
 #define ACTMON_GLB_STATUS					0x0
@@ -155,6 +157,7 @@ struct tegra_devfreq_device {
 
 struct tegra_devfreq {
 	struct devfreq		*devfreq;
+	struct opp_table	*opp_table;
 
 	struct reset_control	*reset;
 	struct clk		*clock;
@@ -612,34 +615,19 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
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
 	if (IS_ERR(opp)) {
 		dev_err(dev, "Failed to find opp for %lu Hz\n", *freq);
 		return PTR_ERR(opp);
 	}
-	rate = dev_pm_opp_get_freq(opp);
-	dev_pm_opp_put(opp);
-
-	err = clk_set_min_rate(tegra->emc_clock, rate * KHZ);
-	if (err)
-		return err;
-
-	err = clk_set_rate(tegra->emc_clock, 0);
-	if (err)
-		goto restore_min_rate;
 
-	return 0;
-
-restore_min_rate:
-	clk_set_min_rate(tegra->emc_clock, devfreq->previous_freq);
+	ret = dev_pm_opp_set_bw(dev, opp);
+	dev_pm_opp_put(opp);
 
-	return err;
+	return ret;
 }
 
 static int tegra_devfreq_get_dev_status(struct device *dev,
@@ -655,7 +643,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
 	stat->private_data = tegra;
 
 	/* The below are to be used by the other governors */
-	stat->current_frequency = cur_freq;
+	stat->current_frequency = cur_freq * KHZ;
 
 	actmon_dev = &tegra->devices[MCALL];
 
@@ -705,7 +693,12 @@ static int tegra_governor_get_target(struct devfreq *devfreq,
 		target_freq = max(target_freq, dev->target_freq);
 	}
 
-	*freq = target_freq;
+	/*
+	 * tegra-devfreq driver operates with KHz units, while OPP table
+	 * entries use Hz units. Hence we need to convert the units for the
+	 * devfreq core.
+	 */
+	*freq = target_freq * KHZ;
 
 	return 0;
 }
@@ -774,6 +767,7 @@ static struct devfreq_governor tegra_devfreq_governor = {
 
 static int tegra_devfreq_probe(struct platform_device *pdev)
 {
+	u32 hw_version = BIT(tegra_sku_info.soc_speedo_id);
 	struct tegra_devfreq_device *dev;
 	struct tegra_devfreq *tegra;
 	struct devfreq *devfreq;
@@ -781,6 +775,13 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	long rate;
 	int err;
 
+	/* legacy device-trees don't have OPP table and must be updated */
+	if (!device_property_present(&pdev->dev, "operating-points-v2")) {
+		dev_err(&pdev->dev,
+			"OPP table not found, please update your device tree\n");
+		return -ENODEV;
+	}
+
 	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
 	if (!tegra)
 		return -ENOMEM;
@@ -822,11 +823,25 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	tegra->opp_table = dev_pm_opp_set_supported_hw(&pdev->dev,
+						       &hw_version, 1);
+	err = PTR_ERR_OR_ZERO(tegra->opp_table);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to set supported HW: %d\n", err);
+		return err;
+	}
+
+	err = dev_pm_opp_of_add_table(&pdev->dev);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to add OPP table: %d\n", err);
+		goto put_hw;
+	}
+
 	err = clk_prepare_enable(tegra->clock);
 	if (err) {
 		dev_err(&pdev->dev,
 			"Failed to prepare and enable ACTMON clock\n");
-		return err;
+		goto remove_table;
 	}
 
 	err = reset_control_reset(tegra->reset);
@@ -850,23 +865,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		dev->regs = tegra->regs + dev->config->offset;
 	}
 
-	for (rate = 0; rate <= tegra->max_freq * KHZ; rate++) {
-		rate = clk_round_rate(tegra->emc_clock, rate);
-
-		if (rate < 0) {
-			dev_err(&pdev->dev,
-				"Failed to round clock rate: %ld\n", rate);
-			err = rate;
-			goto remove_opps;
-		}
-
-		err = dev_pm_opp_add(&pdev->dev, rate / KHZ, 0);
-		if (err) {
-			dev_err(&pdev->dev, "Failed to add OPP: %d\n", err);
-			goto remove_opps;
-		}
-	}
-
 	platform_set_drvdata(pdev, tegra);
 
 	tegra->clk_rate_change_nb.notifier_call = tegra_actmon_clk_notify_cb;
@@ -882,7 +880,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	}
 
 	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
-	tegra_devfreq_profile.initial_freq /= KHZ;
 
 	devfreq = devfreq_add_device(&pdev->dev, &tegra_devfreq_profile,
 				     "tegra_actmon", NULL);
@@ -902,6 +899,10 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	reset_control_reset(tegra->reset);
 disable_clk:
 	clk_disable_unprepare(tegra->clock);
+remove_table:
+	dev_pm_opp_of_remove_table(&pdev->dev);
+put_hw:
+	dev_pm_opp_put_supported_hw(tegra->opp_table);
 
 	return err;
 }
@@ -913,11 +914,12 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
 	devfreq_remove_device(tegra->devfreq);
 	devfreq_remove_governor(&tegra_devfreq_governor);
 
-	dev_pm_opp_remove_all_dynamic(&pdev->dev);
-
 	reset_control_reset(tegra->reset);
 	clk_disable_unprepare(tegra->clock);
 
+	dev_pm_opp_of_remove_table(&pdev->dev);
+	dev_pm_opp_put_supported_hw(tegra->opp_table);
+
 	return 0;
 }
 
-- 
2.29.2

