Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA31244260
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 02:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgHNAHO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 20:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbgHNAHN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 20:07:13 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDD8C061757;
        Thu, 13 Aug 2020 17:07:12 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id t23so8128088ljc.3;
        Thu, 13 Aug 2020 17:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lSEBi5t/1eWk9v8pfAjD69qdXwECFUtZk9QQF5NKtbc=;
        b=r8XC1uLiNnkeMxT5jfdRxcYhubnseQuxIrcuYOdPtmdaOUGD671s9Mfkp6A9wYGt5D
         Lrgab0YOqlQoRtsGSlOgD/03cOyUQdu8iLJjKBRDQlxedvv6/ViFhXTUpSDf7k31VFX4
         ATne1xkPNOYwEco/qDU1ZTSJ9nGSmtumJZfdL4JuR2d7VowgvrLA+mVJVdtY0UEAh24N
         2lO+5J2GxZIp1dQtjPmjchVvUtA8yn6jKV1VDyGxSSNvk0IeP6ef9Y/7TyhPx6hSIe7C
         FSKDdA6z/j+zdGwbFDG8ILynmXGFlYZ0adHS75Igpzskpbrk0nxMoiuZzKkT+AiE0ToW
         gW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lSEBi5t/1eWk9v8pfAjD69qdXwECFUtZk9QQF5NKtbc=;
        b=n9JNoaQQZxxE34Wr0KmekkYl3/S7fQmSbg3+NFdLW4NQog1KfqrMI4952URg3QMvg0
         6hhEU2ffRRRAWNakuz44DiXE7ABXVPzE9mMLaiyzCn7PywyTdwu4J0jt0+vCfTLwckK/
         /A656hUKiY1Sz/JEBFVG7zD73RJn86AO90aZvbG2B1Xz4+wcca0POfQcRN5Fco9PxwUE
         CQcX23EDziR4DT8LtHUhDnhzX2OzxbOJRFLUow33x7jNyG2rvk7eXsy/AxUGgpwIItCw
         v4BgeLLFsmV8601JEOz6hM10nv4IIyN8BJwqzgs/pYGEHMl+siYw7zGPF47XfCLLR6xM
         Ge1w==
X-Gm-Message-State: AOAM531DGCCYd5rm1fA49gcVFMTzMSOKG7zvRJIdSCoX3KcneJzSQarc
        Q0P4UW8EMItiR8pNagIpDGQDU8Sb
X-Google-Smtp-Source: ABdhPJwP6MWMSylZ6EWHBUyEkh77vK1pHLi32W8cHZCx+9E+VZjNPW94F78XIa1PEjLWMgxfDy10SQ==
X-Received: by 2002:a2e:8084:: with SMTP id i4mr101890ljg.447.1597363631084;
        Thu, 13 Aug 2020 17:07:11 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id c17sm1504450lfr.23.2020.08.13.17.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 17:07:10 -0700 (PDT)
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
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 09/36] memory: tegra20-emc: Initialize MC timings
Date:   Fri, 14 Aug 2020 03:05:54 +0300
Message-Id: <20200814000621.8415-10-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814000621.8415-1-digetx@gmail.com>
References: <20200814000621.8415-1-digetx@gmail.com>
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
 drivers/memory/tegra/tegra20-emc.c | 54 ++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)

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
index 5aa3a1da2975..a02ffc09c39e 100644
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
@@ -650,6 +653,45 @@ static void tegra_emc_debugfs_init(struct tegra_emc *emc)
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
+	if (!emc->num_timings)
+		return 0;
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
+	/* shouldn't happen */
+	WARN_ON(mc->num_timings);
+	WARN_ON(mc->timings);
+
+	mc->timings = devm_kcalloc(emc->dev, emc->num_timings, sizeof(*timing),
+				   GFP_KERNEL);
+	if (!mc->timings)
+		return -ENOMEM;
+
+	for (i = 0; i < emc->num_timings; i++, mc->num_timings++)
+		mc->timings[i].rate = emc->timings[i].rate;
+
+	return 0;
+}
+
 static int tegra_emc_probe(struct platform_device *pdev)
 {
 	struct device_node *np;
@@ -721,6 +763,18 @@ static int tegra_emc_probe(struct platform_device *pdev)
 		goto unset_cb;
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
+		goto unset_cb;
+	}
+
 	platform_set_drvdata(pdev, emc);
 	tegra_emc_debugfs_init(emc);
 
-- 
2.27.0

