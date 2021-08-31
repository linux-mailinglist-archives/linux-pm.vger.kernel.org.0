Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5110F3FC90B
	for <lists+linux-pm@lfdr.de>; Tue, 31 Aug 2021 15:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbhHaN6C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 09:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbhHaN56 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Aug 2021 09:57:58 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530ADC061760;
        Tue, 31 Aug 2021 06:57:03 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id s3so31957133ljp.11;
        Tue, 31 Aug 2021 06:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vxZLlezmdlBfmORUY8VTkoehAmXrLhditoSKpgYm74c=;
        b=OZPnxXBlgfpSfDwpyOGpPsulhCcuNiZlp1iz33kdT3xK7b7zcbBtyMPlh24brwFYqq
         RVPU8xGYktiVAHJpeSaMRpnNB6uqFsgvu9uV30h2oJvHQxj99JNL5w1T8aDTEd410jNh
         k1OoezMZTytNJqfPG8hUW4I1w0gCZWfn8jp9DsX7thlnyCShKVQjjXguWLGOl1PKZMaN
         g7lPtiEXzFXmZMa8uh8VfBTSepIzcO5g855XacQFJFHZ3tdjIeTO1gbBvYk0xKBNvt2q
         NZSABJ+G/Wm083zu/2w9bLEaayacvkN/+04KQFvTGdPf77c/mkRqIPr8Nvx30NrD3wkE
         NgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vxZLlezmdlBfmORUY8VTkoehAmXrLhditoSKpgYm74c=;
        b=AI03kaALkM+BMKZN7/f3OBEtY7/YqwN8z8FeqoaDarQkThDOxLgTnRyt0nT7PjmGMf
         mJLlMQTHJK1XiHjSpG3KlvUbrH4J3M5bHbY6+L0Zb5KqJ5OH0f2Pj9iSJqfm3IpraAGO
         1FTv9ju/9pEEwEPm5TP/Q5avWo+Vu6Y8xxcjiN3/psbBqapsgo2V8+DTtDdQJDx/BtGE
         /qA6MuWNVqG3RGLnqsZ0wdy7M8uHxz6pYWJkgGrRa1D21laFW55JEoab1mWT6ZBUNzOc
         T5RaspEt1CWX8vKsKLKArdSGiZ9nEDNBS80LOVIti7C1DUKa1/m6KsE6kMiz/M6wdXtQ
         bkkA==
X-Gm-Message-State: AOAM531Dd4hyP3ihSmtGtGqjYw84VXjeDmIXRmvCozTAtJWBcoq5MoP3
        8dQQuNFn/0uIUxD4OkVJo/U=
X-Google-Smtp-Source: ABdhPJxvLGSM2G1hi+P/eh8bjV7Otd9EPzCwKJnTc/HtDoTKHWQ5+JHmhCz1QWrHHodLfgqdqAuYhQ==
X-Received: by 2002:a05:651c:50e:: with SMTP id o14mr26038356ljp.351.1630418221715;
        Tue, 31 Aug 2021 06:57:01 -0700 (PDT)
Received: from localhost.localdomain (46-138-26-37.dynamic.spd-mgts.ru. [46.138.26.37])
        by smtp.gmail.com with ESMTPSA id x4sm2203622ljm.98.2021.08.31.06.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 06:57:01 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v10 5/8] soc/tegra: pmc: Implement dev_get_performance_state() callback
Date:   Tue, 31 Aug 2021 16:54:47 +0300
Message-Id: <20210831135450.26070-6-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210831135450.26070-1-digetx@gmail.com>
References: <20210831135450.26070-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Implement dev_get_performance_state() callback of the power domains to
pre-initialize theirs performance (voltage) state in accordance to the
clock rate of attached devices.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/pmc.c | 101 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 50091c4ec948..98015a6cdd1d 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -39,6 +39,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
+#include <linux/pm_runtime.h>
 #include <linux/reboot.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
@@ -505,6 +506,104 @@ static void tegra_pmc_scratch_writel(struct tegra_pmc *pmc, u32 value,
 		writel(value, pmc->scratch + offset);
 }
 
+static const char * const tegra_pd_no_perf_compats[] = {
+	"nvidia,tegra20-sclk",
+	"nvidia,tegra30-sclk",
+	"nvidia,tegra30-pllc",
+	"nvidia,tegra30-plle",
+	"nvidia,tegra30-pllm",
+	"nvidia,tegra20-dc",
+	"nvidia,tegra30-dc",
+	"nvidia,tegra20-emc",
+	"nvidia,tegra30-emc",
+	NULL,
+};
+
+static int
+tegra_pmc_pd_dev_get_performance_state(struct generic_pm_domain *genpd,
+				       struct device *dev)
+{
+	struct opp_table *hw_opp_table, *clk_opp_table;
+	struct dev_pm_opp *opp;
+	u32 hw_version;
+	int ret;
+
+	/*
+	 * The EMC devices are a special case because we have a protection
+	 * from non-EMC drivers getting clock handle before EMC driver is
+	 * fully initialized.  The goal of the protection is to prevent
+	 * devfreq driver from getting failures if it will try to change
+	 * EMC clock rate until clock is fully initialized.  The EMC drivers
+	 * will initialize the performance state by themselves.
+	 *
+	 * Display controller also is a special case because only controller
+	 * driver could get the clock rate based on configuration of internal
+	 * divider.
+	 *
+	 * Clock driver uses its own state syncing.
+	 */
+	if (of_device_compatible_match(dev->of_node, tegra_pd_no_perf_compats))
+		return 0;
+
+	if (of_machine_is_compatible("nvidia,tegra20"))
+		hw_version = BIT(tegra_sku_info.soc_process_id);
+	else
+		hw_version = BIT(tegra_sku_info.soc_speedo_id);
+
+	hw_opp_table = dev_pm_opp_set_supported_hw(dev, &hw_version, 1);
+	if (IS_ERR(hw_opp_table)) {
+		dev_err(dev, "failed to set OPP supported HW: %pe\n",
+			hw_opp_table);
+		return PTR_ERR(hw_opp_table);
+	}
+
+	/*
+	 * Older device-trees don't have OPPs, meanwhile drivers use
+	 * dev_pm_opp_set_rate() and it requires OPP table to be set
+	 * up using dev_pm_opp_set_clkname().
+	 *
+	 * The devm_tegra_core_dev_init_opp_table() is a common helper
+	 * that sets up OPP table for Tegra drivers and it sets the clk
+	 * for compatibility with older device-tress.  GR3D driver uses that
+	 * helper, it also uses devm_pm_opp_attach_genpd() to manually attach
+	 * power domains, which now holds the reference to OPP table that
+	 * already has clk set up implicitly by OPP core for a newly created
+	 * table using dev_pm_opp_of_add_table() invoked below.
+	 *
+	 * Hence we need to explicitly set/put the clk, otherwise
+	 * further dev_pm_opp_set_clkname() will fail with -EBUSY.
+	 */
+	clk_opp_table = dev_pm_opp_set_clkname(dev, NULL);
+	if (IS_ERR(clk_opp_table)) {
+		dev_err(dev, "failed to set OPP clk: %pe\n", clk_opp_table);
+		ret = PTR_ERR(clk_opp_table);
+		goto put_hw;
+	}
+
+	ret = dev_pm_opp_of_add_table(dev);
+	if (ret) {
+		dev_err(dev, "failed to add OPP table: %d\n", ret);
+		goto put_clk;
+	}
+
+	opp = dev_pm_opp_get_current(dev);
+	if (IS_ERR(opp)) {
+		dev_err(dev, "failed to get current OPP: %pe\n", opp);
+		ret = PTR_ERR(opp);
+	} else {
+		ret = dev_pm_opp_get_required_pstate(opp, 0);
+		dev_pm_opp_put(opp);
+	}
+
+	dev_pm_opp_of_remove_table(dev);
+put_clk:
+	dev_pm_opp_put_clkname(clk_opp_table);
+put_hw:
+	dev_pm_opp_put_supported_hw(hw_opp_table);
+
+	return ret;
+}
+
 /*
  * TODO Figure out a way to call this with the struct tegra_pmc * passed in.
  * This currently doesn't work because readx_poll_timeout() can only operate
@@ -1237,6 +1336,7 @@ static int tegra_powergate_add(struct tegra_pmc *pmc, struct device_node *np)
 
 	pg->id = id;
 	pg->genpd.name = np->name;
+	pg->genpd.dev_get_performance_state = tegra_pmc_pd_dev_get_performance_state;
 	pg->genpd.power_off = tegra_genpd_power_off;
 	pg->genpd.power_on = tegra_genpd_power_on;
 	pg->pmc = pmc;
@@ -1355,6 +1455,7 @@ static int tegra_pmc_core_pd_add(struct tegra_pmc *pmc, struct device_node *np)
 	genpd->name = np->name;
 	genpd->set_performance_state = tegra_pmc_core_pd_set_performance_state;
 	genpd->opp_to_performance_state = tegra_pmc_core_pd_opp_to_performance_state;
+	genpd->dev_get_performance_state = tegra_pmc_pd_dev_get_performance_state;
 
 	err = devm_pm_opp_set_regulators(pmc->dev, &rname, 1);
 	if (err)
-- 
2.32.0

