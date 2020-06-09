Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4211F3B90
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 15:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgFINOm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 09:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgFINOi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 09:14:38 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D36FC08C5C3;
        Tue,  9 Jun 2020 06:14:37 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id r125so12406803lff.13;
        Tue, 09 Jun 2020 06:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+95j4xiCVDnfcLUm7JOEhc1KRXPcYGWky6OtXHtOxdU=;
        b=fF4O/Kp8bp2aC6LDSu8w3J8POQSvK7tfBc+Vsw5T2WcWwfmbQ6NVsefHBdsQB29eJs
         TlVaBUvpMhtOTUa0Ryt/K4S360qhF8hawBijaQA2LyEHxtB3drfu3xuHIeiwQ4HThurd
         JbMox4nwo5vQiZbmK22cb87RRjayGYe0wDiumBsk23uvvHWZRvcNoSIShaatBtUFebG5
         BOyWG5yULvspnDjwwor8tT3VYRd3h/3Fjqh9BS7GWbKL56VBuCZik1sri2B5R4uRE5pi
         eom4aqwxgZeERfio4absDUNrWcJsjJSpxX7iS4DiBWOpF220Mid9m682tpCxjLjlFLJz
         a4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+95j4xiCVDnfcLUm7JOEhc1KRXPcYGWky6OtXHtOxdU=;
        b=c5wA7YmW3cVfrgnFeUHpoKuq3OCd5d47lB/Tcn8tjRRQdM3Wnxty+FB7WPBaxnOiFR
         g9C1CpAIR3zgSYf+MlfsWgvdNVThs6IcouGCMTExW0VV51rxU7sotbL+odWte/pzMe2N
         BaI0/s20z2I8UWGFhLvqjfZ7tTUshRUD6lL3QdqBsz4RDC7Z8iR3sgmBKazO+freo5jy
         BPVSNMvBcFGtvdFg20A4Wilg2Yw1T2Ho/pkjl2r5a/1unW17cf5q2NoiiGlPuCFlsxI3
         nupxejNUBGrtPWcp109EScOSc4Lr77FzOhTINcGr1dOxIUjK9n8zpcVIEDyXol12k/5d
         XvFQ==
X-Gm-Message-State: AOAM530+1lYR/ALgG6uav/rclh1b0sOONb4aJnZln2l0MpORmGOb0tFi
        kCs5RS/hZtzmYDexw8L9q1U=
X-Google-Smtp-Source: ABdhPJwpOmAZQvJDK7Bkc7F/ZxxtIqqFVMtBeQh4BlWFAESl0Ak0kldnvP0J0H5rXh7Bfp+rXpSKTg==
X-Received: by 2002:a19:be55:: with SMTP id o82mr15072927lff.168.1591708476142;
        Tue, 09 Jun 2020 06:14:36 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id l22sm4323522lji.120.2020.06.09.06.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:14:35 -0700 (PDT)
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
Subject: [PATCH v4 09/37] memory: tegra20-emc: Initialize MC timings
Date:   Tue,  9 Jun 2020 16:13:36 +0300
Message-Id: <20200609131404.17523-10-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200609131404.17523-1-digetx@gmail.com>
References: <20200609131404.17523-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We're going to add interconnect support to the EMC driver. Once this
support will be added, the Tegra20 devfreq driver will no longer be
able to use clk_round_rate(emc) for building up OPP table. It's quite
handy that struct tegra_mc contains memory timings which could be used
by the devfreq drivers instead of the clk rate-rounding. The tegra_mc
timings are populated by the MC driver only for Tegra30+ SoCs, hence
the Tegra20 EMC could populate timings by itself.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/Kconfig       |  2 +-
 drivers/memory/tegra/tegra20-emc.c | 47 ++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/Kconfig b/drivers/memory/tegra/Kconfig
index c1cad4ce6251..5bf75b316a2f 100644
--- a/drivers/memory/tegra/Kconfig
+++ b/drivers/memory/tegra/Kconfig
@@ -10,7 +10,7 @@ config TEGRA_MC
 config TEGRA20_EMC
 	tristate "NVIDIA Tegra20 External Memory Controller driver"
 	default y
-	depends on ARCH_TEGRA_2x_SOC
+	depends on TEGRA_MC && ARCH_TEGRA_2x_SOC
 	help
 	  This driver is for the External Memory Controller (EMC) found on
 	  Tegra20 chips. The EMC controls the external DRAM on the board.
diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 0baa6590adea..2e310c51c599 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -15,12 +15,15 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/sort.h>
 #include <linux/types.h>
 
 #include <soc/tegra/fuse.h>
 
+#include "mc.h"
+
 #define EMC_INTSTATUS				0x000
 #define EMC_INTMASK				0x004
 #define EMC_DBG					0x008
@@ -650,6 +653,38 @@ static void tegra_emc_debugfs_init(struct tegra_emc *emc)
 			    emc, &tegra_emc_debug_max_rate_fops);
 }
 
+static int tegra_emc_init_mc_timings(struct tegra_emc *emc)
+{
+	struct tegra_mc_timing *timing;
+	struct platform_device *pdev;
+	struct device_node *np;
+	struct tegra_mc *mc;
+	unsigned int i;
+
+	np = of_find_compatible_node(NULL, NULL, "nvidia,tegra20-mc-gart");
+	if (!np)
+		return -ENOENT;
+
+	pdev = of_find_device_by_node(np);
+	of_node_put(np);
+	if (!pdev)
+		return -ENOENT;
+
+	mc = platform_get_drvdata(pdev);
+	if (!mc)
+		return -EPROBE_DEFER;
+
+	mc->timings = devm_kcalloc(mc->dev, emc->num_timings, sizeof(*timing),
+				   GFP_KERNEL);
+	if (!mc->timings)
+		return -ENOMEM;
+
+	for (i = 0; i < emc->num_timings; i++)
+		mc->timings[mc->num_timings++].rate = emc->timings[i].rate;
+
+	return 0;
+}
+
 static int tegra_emc_probe(struct platform_device *pdev)
 {
 	struct device_node *np;
@@ -705,6 +740,18 @@ static int tegra_emc_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	/*
+	 * Only Tegra30+ SoCs are having Memory Controller timings initialized
+	 * by the MC driver. For Tegra20 we need to populate the MC timings
+	 * from here. The MC timings will be used by the Tegra20 devfreq driver.
+	 */
+	err = tegra_emc_init_mc_timings(emc);
+	if (err) {
+		dev_err(&pdev->dev, "failed to initialize mc timings: %d\n",
+			err);
+		return err;
+	}
+
 	tegra20_clk_set_emc_round_callback(emc_round_rate, emc);
 
 	emc->clk = devm_clk_get(&pdev->dev, "emc");
-- 
2.26.0

