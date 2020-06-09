Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76991F3C02
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 15:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbgFINR5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 09:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729085AbgFINOn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 09:14:43 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E06C05BD1E;
        Tue,  9 Jun 2020 06:14:43 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a25so24978098ljp.3;
        Tue, 09 Jun 2020 06:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qWLmy17GC8FK7PHSQ8U9gnOM1EaYpHMCshqC+sIXbKQ=;
        b=PtZ3FafDGDMkjdGGg6qUN0OnJf60f+Oe1vAYv0QO8j+XNPvxdaM+EF1M1nmS3kUY34
         PzCcKoUALCwrQ9YAgAWxt1h153jj2rB9JUt3VwbSI42wowAlMvQsDICNmiCN3OmMmhlz
         CY1E8DYP5EpdGVDvulxqFCerF8gZqK+9S0R9kBF4vRQ+WcPMs+/9kUGzzZaEgQmvypjE
         cktPp97gljvUmgpnCARjetviUy1gBQzaB8Hwu6Bv9qQSn4LRzoPL+Va51fcCKRWmUJdX
         srgHviY8YRp+3xExR9wU8LjU6Kwb6279+fhVfw6UrWq/JJ4sKg+yyHYv2HWGiZkerWL0
         VpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qWLmy17GC8FK7PHSQ8U9gnOM1EaYpHMCshqC+sIXbKQ=;
        b=MOX+EtDiC1myP7Dgm4Ec0CrYIeQH/m292fuA53i2d/o419KssFr8DaMFuyhfmvKoC4
         9tvRsGlqDhTjVpFpNq6yAK1FVCHnOiugHitfCe1VoO6v86ijCCL97F8Xt3SuovspACKq
         B+dZ+YhQ9ImB3851HhUZ31ivhjRp+ZzFxHIpxymvowcvbux8JpKEIMjoXDtBXm8W3GLX
         jC2wwTBU8NF71T3MReG7LNsOzySfV6wfBVRFv1uJY9apiTu+3dQkF6V+55teY5YdRWw3
         cJgk54WD4VYDcMgg5k+NdR93jz/cCmjPxvwzndeXFHSh+GkhQIvJO6tvoW1ivTSI4Rhd
         88QQ==
X-Gm-Message-State: AOAM532D6eXQbcWfel1XZ6k3nbweh7GS4F0q1veqwkINuobpFBUYRFRg
        4G1EryFouvAw//ZH/IYCcFk=
X-Google-Smtp-Source: ABdhPJx+FulYheW9btOx43o7T/Zt34lJsITrRnYXhNXkpA2Lf7W9TFVIgsYgkcea3WXUz4a7xzLCdQ==
X-Received: by 2002:a2e:97ce:: with SMTP id m14mr13675149ljj.216.1591708481170;
        Tue, 09 Jun 2020 06:14:41 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id l22sm4323522lji.120.2020.06.09.06.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:14:40 -0700 (PDT)
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
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 13/37] PM / devfreq: tegra30: Use MC timings for building OPP table
Date:   Tue,  9 Jun 2020 16:13:40 +0300
Message-Id: <20200609131404.17523-14-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200609131404.17523-1-digetx@gmail.com>
References: <20200609131404.17523-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The clk_round_rate() won't be usable for building OPP table once
interconnect support will be added to the EMC driver because that CLK API
function limits the rounded rate based on the clk rate that is imposed by
active clk-users, and thus, the rounding won't work as expected if
interconnect will set the minimum EMC clock rate before devfreq driver is
loaded. The struct tegra_mc contains memory timings which could be used by
the devfreq driver for building up OPP table instead of rounding clock
rate, this patch implements this idea.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 98 ++++++++++++++++++++++---------
 1 file changed, 70 insertions(+), 28 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 423dd35c95b3..13f93c6038ab 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -19,6 +19,8 @@
 #include <linux/reset.h>
 #include <linux/workqueue.h>
 
+#include <soc/tegra/mc.h>
+
 #include "governor.h"
 
 #define ACTMON_GLB_STATUS					0x0
@@ -153,6 +155,18 @@ struct tegra_devfreq_device {
 	unsigned long target_freq;
 };
 
+struct tegra_devfreq_soc_data {
+	const char *mc_compatible;
+};
+
+static const struct tegra_devfreq_soc_data tegra30_soc = {
+	.mc_compatible = "nvidia,tegra30-mc",
+};
+
+static const struct tegra_devfreq_soc_data tegra124_soc = {
+	.mc_compatible = "nvidia,tegra124-mc",
+};
+
 struct tegra_devfreq {
 	struct devfreq		*devfreq;
 
@@ -771,15 +785,44 @@ static struct devfreq_governor tegra_devfreq_governor = {
 	.interrupt_driven = true,
 };
 
+static struct tegra_mc *tegra_get_memory_controller(const char *compatible)
+{
+	struct platform_device *pdev;
+	struct device_node *np;
+	struct tegra_mc *mc;
+
+	np = of_find_compatible_node(NULL, NULL, compatible);
+	if (!np)
+		return ERR_PTR(-ENOENT);
+
+	pdev = of_find_device_by_node(np);
+	of_node_put(np);
+	if (!pdev)
+		return ERR_PTR(-ENODEV);
+
+	mc = platform_get_drvdata(pdev);
+	if (!mc)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	return mc;
+}
+
 static int tegra_devfreq_probe(struct platform_device *pdev)
 {
+	const struct tegra_devfreq_soc_data *soc_data;
 	struct tegra_devfreq_device *dev;
 	struct tegra_devfreq *tegra;
 	struct devfreq *devfreq;
+	struct tegra_mc *mc;
 	unsigned int i;
-	long rate;
 	int err;
 
+	soc_data = of_device_get_match_data(&pdev->dev);
+
+	mc = tegra_get_memory_controller(soc_data->mc_compatible);
+	if (IS_ERR(mc))
+		return PTR_ERR(mc);
+
 	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
 	if (!tegra)
 		return -ENOMEM;
@@ -825,6 +868,30 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	if (!mc->num_timings) {
+		tegra->max_freq = clk_get_rate(tegra->clock) / KHZ;
+
+		err = dev_pm_opp_add(&pdev->dev, tegra->max_freq, 0);
+		if (err) {
+			dev_err(&pdev->dev, "Failed to add OPP: %d\n", err);
+			return err;
+		}
+	}
+
+	for (i = 0; i < mc->num_timings; i++) {
+		/*
+		 * Memory Controller timings are sorted in ascending clock
+		 * rate order, so the last timing will be the max freq.
+		 */
+		tegra->max_freq = mc->timings[i].rate / KHZ;
+
+		err = dev_pm_opp_add(&pdev->dev, tegra->max_freq, 0);
+		if (err) {
+			dev_err(&pdev->dev, "Failed to add OPP: %d\n", err);
+			goto remove_opps;
+		}
+	}
+
 	reset_control_assert(tegra->reset);
 
 	err = clk_prepare_enable(tegra->clock);
@@ -836,37 +903,12 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	reset_control_deassert(tegra->reset);
 
-	rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
-	if (rate < 0) {
-		dev_err(&pdev->dev, "Failed to round clock rate: %ld\n", rate);
-		return rate;
-	}
-
-	tegra->max_freq = rate / KHZ;
-
 	for (i = 0; i < ARRAY_SIZE(actmon_device_configs); i++) {
 		dev = tegra->devices + i;
 		dev->config = actmon_device_configs + i;
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
@@ -921,8 +963,8 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id tegra_devfreq_of_match[] = {
-	{ .compatible = "nvidia,tegra30-actmon" },
-	{ .compatible = "nvidia,tegra124-actmon" },
+	{ .compatible = "nvidia,tegra30-actmon",  .data = &tegra30_soc, },
+	{ .compatible = "nvidia,tegra124-actmon", .data = &tegra124_soc, },
 	{ },
 };
 
-- 
2.26.0

