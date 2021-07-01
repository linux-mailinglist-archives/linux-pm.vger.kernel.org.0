Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2153B9927
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbhGAXb1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbhGAXbQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:31:16 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA94C061765;
        Thu,  1 Jul 2021 16:28:43 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id f30so14845868lfj.1;
        Thu, 01 Jul 2021 16:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2tPCzNkUD5FTVgjEXVp96zo+k/1b4DbbmBjEro2BRIM=;
        b=o8AEp7eFIbO/XoUORRUEyUGhkcquM9an74Q4mSX0CyFKaDgA9bDIO8g4+BnrKdgzYC
         ztslIfxPNVVsc7Qp8kNl2nUYRW3udee+0h9GbphoRsvrQeuw3WHLspyLuhf/yKhEVbIA
         yE/tzwKJaXZ0Medr9E4EI2HtiUqvLj116L+HQdN22aYGYgu7brNpEvJktlqYQrWm/c3E
         G+TCrlSkGyA3/a2DpG8KWfVo+XIiEJ6zQaTz2CjAJ3AKybn4i63Mm3V3GXJt2ZQ6iySa
         vhs5XbO+nwe5IvPCtJjN7kKQZCczttuOEFdslFdZTuqq4QQrv6UM/GTkIgOJvQpGAp6h
         NVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2tPCzNkUD5FTVgjEXVp96zo+k/1b4DbbmBjEro2BRIM=;
        b=UZKa8W5mv2ON4qdk5mQNlnRQKXVeHgq5byJ6KpAvn7aoZHKivRaFz2aEwUZ56uqa+Y
         ZpSE9bC+c1wQv1su3Z2NwimsYnj1bxPDxFn6uNO0SV+clgWasRzxdOdEGBebfr30U6BD
         nfP/L2+1X3fa14k1sACHPEP/5KIDl6r07HU2F/KzkAGHFpqIyRJVWQLb0TeN1AJ8nV+h
         6yTwZAAKPyqRRU4RbOBiexayXfEjw/VtmA9nRNdpiC6SQH0cxfWMbHO4KGO40VBars46
         0jVC/Vj3lohs99J8UTTHY7W5C4cYIATCNdzETPI1UfGt1X4MXMQdl6i7yT54Uh1aAmKf
         oMtQ==
X-Gm-Message-State: AOAM531MB/P01alr6FBtxGPfG8H3QiN7hElRtK0iP50iRIK4SHX0yApa
        u62bF55niVs0rjOcCDm/zWQ=
X-Google-Smtp-Source: ABdhPJync9EPn0PVP/JR6wDHPDBE8bmqdg7LEQpWBLESHOActul2jR5Qkx+oFEGH/lGmoShT1rjEhw==
X-Received: by 2002:a19:ab19:: with SMTP id u25mr1491128lfe.414.1625182122039;
        Thu, 01 Jul 2021 16:28:42 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id s20sm102655lfr.39.2021.07.01.16.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:28:41 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 20/37] mmc: sdhci-tegra: Add runtime PM and OPP support
Date:   Fri,  2 Jul 2021 02:27:11 +0300
Message-Id: <20210701232728.23591-21-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701232728.23591-1-digetx@gmail.com>
References: <20210701232728.23591-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The SDHCI on Tegra belongs to the core power domain and we're going to
enable GENPD support for the core domain. Now SDHCI must be resumed using
runtime PM API in order to initialize the SDHCI power state. The SDHCI
clock rate must be changed using OPP API that will reconfigure the power
domain performance state in accordance to the rate. Add runtime PM and OPP
support to the SDHCI driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mmc/host/sdhci-tegra.c | 81 +++++++++++++++++++++++++++-------
 1 file changed, 65 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 387ce9cdbd7c..19be096b182a 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -15,6 +15,8 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/pm_opp.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/mmc/card.h>
@@ -24,6 +26,8 @@
 #include <linux/gpio/consumer.h>
 #include <linux/ktime.h>
 
+#include <soc/tegra/common.h>
+
 #include "sdhci-pltfm.h"
 #include "cqhci.h"
 
@@ -758,10 +762,15 @@ static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
+	struct device *dev = mmc_dev(host->mmc);
 	unsigned long host_clk;
+	int err;
 
-	if (!clock)
-		return sdhci_set_clock(host, clock);
+	if (!clock) {
+		sdhci_set_clock(host, clock);
+		dev_pm_opp_set_rate(dev, clock);
+		return;
+	}
 
 	/*
 	 * In DDR50/52 modes the Tegra SDHCI controllers require the SDHCI
@@ -776,7 +785,12 @@ static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	 * from clk_get_rate() is used.
 	 */
 	host_clk = tegra_host->ddr_signaling ? clock * 2 : clock;
-	clk_set_rate(pltfm_host->clk, host_clk);
+
+	err = dev_pm_opp_set_rate(dev, host_clk);
+	if (err)
+		dev_err(dev, "failed to set clk rate to %luHz: %d\n",
+			host_clk, err);
+
 	tegra_host->curr_clk_rate = host_clk;
 	if (tegra_host->ddr_signaling)
 		host->max_clk = host_clk;
@@ -1696,7 +1710,6 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 				   "failed to get clock\n");
 		goto err_clk_get;
 	}
-	clk_prepare_enable(clk);
 	pltfm_host->clk = clk;
 
 	tegra_host->rst = devm_reset_control_get_exclusive(&pdev->dev,
@@ -1704,9 +1717,18 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	if (IS_ERR(tegra_host->rst)) {
 		rc = PTR_ERR(tegra_host->rst);
 		dev_err(&pdev->dev, "failed to get reset control: %d\n", rc);
-		goto err_rst_get;
+		goto err_clk_get;
 	}
 
+	rc = devm_tegra_core_dev_init_opp_table_simple(&pdev->dev);
+	if (rc)
+		goto err_clk_get;
+
+	pm_runtime_enable(&pdev->dev);
+	rc = pm_runtime_resume_and_get(&pdev->dev);
+	if (rc)
+		goto err_pm_get;
+
 	rc = reset_control_assert(tegra_host->rst);
 	if (rc)
 		goto err_rst_get;
@@ -1728,7 +1750,9 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 err_add_host:
 	reset_control_assert(tegra_host->rst);
 err_rst_get:
-	clk_disable_unprepare(pltfm_host->clk);
+	pm_runtime_put(&pdev->dev);
+err_pm_get:
+	pm_runtime_disable(&pdev->dev);
 err_clk_get:
 	clk_disable_unprepare(tegra_host->tmclk);
 err_power_req:
@@ -1747,7 +1771,9 @@ static int sdhci_tegra_remove(struct platform_device *pdev)
 
 	reset_control_assert(tegra_host->rst);
 	usleep_range(2000, 4000);
-	clk_disable_unprepare(pltfm_host->clk);
+
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(tegra_host->tmclk);
 
 	sdhci_pltfm_free(pdev);
@@ -1755,11 +1781,27 @@ static int sdhci_tegra_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int __maybe_unused sdhci_tegra_suspend(struct device *dev)
+static int __maybe_unused sdhci_tegra_runtime_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	clk_disable_unprepare(pltfm_host->clk);
+
+	return 0;
+}
+
+static int __maybe_unused sdhci_tegra_runtime_resume(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	return clk_prepare_enable(pltfm_host->clk);
+}
+
+static int __maybe_unused sdhci_tegra_suspend(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
 	int ret;
 
 	if (host->mmc->caps2 & MMC_CAP2_CQE) {
@@ -1774,17 +1816,22 @@ static int __maybe_unused sdhci_tegra_suspend(struct device *dev)
 		return ret;
 	}
 
-	clk_disable_unprepare(pltfm_host->clk);
+	ret = pm_runtime_force_suspend(dev);
+	if (ret) {
+		sdhci_resume_host(host);
+		cqhci_resume(host->mmc);
+		return ret;
+	}
+
 	return 0;
 }
 
 static int __maybe_unused sdhci_tegra_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	int ret;
 
-	ret = clk_prepare_enable(pltfm_host->clk);
+	ret = pm_runtime_force_resume(dev);
 	if (ret)
 		return ret;
 
@@ -1803,13 +1850,15 @@ static int __maybe_unused sdhci_tegra_resume(struct device *dev)
 suspend_host:
 	sdhci_suspend_host(host);
 disable_clk:
-	clk_disable_unprepare(pltfm_host->clk);
+	pm_runtime_force_suspend(dev);
 	return ret;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(sdhci_tegra_dev_pm_ops, sdhci_tegra_suspend,
-			 sdhci_tegra_resume);
+static const struct dev_pm_ops sdhci_tegra_dev_pm_ops = {
+	SET_RUNTIME_PM_OPS(sdhci_tegra_runtime_suspend, sdhci_tegra_runtime_resume,
+			   NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(sdhci_tegra_suspend, sdhci_tegra_resume)
+};
 
 static struct platform_driver sdhci_tegra_driver = {
 	.driver		= {
-- 
2.30.2

