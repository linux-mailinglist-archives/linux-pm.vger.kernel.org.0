Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DF73F9206
	for <lists+linux-pm@lfdr.de>; Fri, 27 Aug 2021 03:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244018AbhH0Biu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Aug 2021 21:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243992AbhH0Bis (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Aug 2021 21:38:48 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924E7C061757;
        Thu, 26 Aug 2021 18:37:59 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id d16so8593424ljq.4;
        Thu, 26 Aug 2021 18:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uC5mTv9GIr5hy4zC/Rc4VuhD4bWEaK9tTCVTW2lWVlg=;
        b=Vf3I9vqGSbQeOavUBCE9oNbJSVO42DxQgR3wjLIddVO97SP+juRUX+SnJlE8j+tyjY
         jpSmJphVi+hIkRDDFZd3MAvRPw7xOCFZpfrTXz1TeywftL7e8IpFGekFcqIySQpnuh05
         4TyPWYP+u35Cm83CwTRyAwk7RGaHqF3LG0aARY2lDFdC88SvneJ8rCfrOjIk2gGROwkR
         ZIXiGccJfhNGIWDIFeoehJSY03F9hXSRhHyb8j9WVJ8C3wI5OQ6pJCzB3LYTIZc2bPQy
         ovyLnNcZIaOYbHaqc6ZtGfYqjUkg6oRNF5vuKUHt/TatZhBrBaZZr7HgWnRt/XLuq2mB
         +CWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uC5mTv9GIr5hy4zC/Rc4VuhD4bWEaK9tTCVTW2lWVlg=;
        b=Ww5KrV5yLu8+N4QIhR2TJOxdMTXTUDmmQfD/+G61yjPjmtIcXJ60fWG68QaN2tHu2R
         fK80zsqqE1d9muVFNyrol9Y37+rzB13xYKAX2fRLnwtuP9g2NexwmbP/9fvym0OkVCc4
         0KHuUtOH0UuhhrMeEG5MVTgoIij7lDQLEU/eTQZ8rrDCdAXWAB3vjAxHXd4MG8+o8mRW
         6wxSKcMUW8O4JEN89R0l2q2pv2Pd9pjC9gdH0uLt59f9rjwhFjIefI0YxyHkN4Au2amF
         YbpV3KB/FoyRyuuFdkFJfNvVHHbGlPX3PLUg8A776qZVfl1nsJ8Bvo2Fsau10ev5S+7y
         SoPQ==
X-Gm-Message-State: AOAM531/Ry9gVjog2H5uhFa+XEoMupwJeBxy1TusITPRQPFx08V9+jv3
        6Dz1WzuXLMJCl8KjFIG5ju7hJaSILVk=
X-Google-Smtp-Source: ABdhPJzDhcr8vCeBSL2PK7U5FqCdcyjRRWnUS+4kq+QJO4rfztt0W9Oj5wPDnQ/7BmlueaXkV87G/Q==
X-Received: by 2002:a2e:b52c:: with SMTP id z12mr5524273ljm.271.1630028278002;
        Thu, 26 Aug 2021 18:37:58 -0700 (PDT)
Received: from localhost.localdomain (94-29-17-251.dynamic.spd-mgts.ru. [94.29.17.251])
        by smtp.gmail.com with ESMTPSA id y3sm494289lfa.240.2021.08.26.18.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 18:37:57 -0700 (PDT)
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
Subject: [PATCH v9 5/8] soc/tegra: pmc: Implement get_performance_state() callback
Date:   Fri, 27 Aug 2021 04:34:12 +0300
Message-Id: <20210827013415.24027-6-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210827013415.24027-1-digetx@gmail.com>
References: <20210827013415.24027-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Implement get_performance_state() callback of power domains to
initialize theirs performance state in accordance to the clock
rate of attached device.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/pmc.c | 86 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 50091c4ec948..ea552f7ed922 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -505,6 +505,90 @@ static void tegra_pmc_scratch_writel(struct tegra_pmc *pmc, u32 value,
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
+static int tegra_pmc_pd_get_performance_state(struct generic_pm_domain *genpd,
+					      struct device *dev,
+					      bool *dev_suspended)
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
+	clk_opp_table = dev_pm_opp_set_clkname(dev, NULL);
+	if (IS_ERR(clk_opp_table)) {
+		dev_err(dev, "failed to set OPP clk: %pe\n", clk_opp_table);
+		ret = PTR_ERR(clk_opp_table);
+		goto put_hw;
+	}
+
+	ret = devm_pm_opp_of_add_table(dev);
+	if (ret) {
+		dev_err(dev, "failed to add OPP table: %d\n", ret);
+		goto put_clk;
+	}
+
+	opp = dev_pm_opp_from_clk_rate(dev);
+	if (IS_ERR(opp)) {
+		dev_err(dev, "failed to get current OPP: %pe\n", opp);
+		ret = PTR_ERR(opp);
+	} else {
+		ret = dev_pm_opp_get_required_pstate(opp, 0);
+		dev_pm_opp_put(opp);
+	}
+
+	*dev_suspended = true;
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
@@ -1237,6 +1321,7 @@ static int tegra_powergate_add(struct tegra_pmc *pmc, struct device_node *np)
 
 	pg->id = id;
 	pg->genpd.name = np->name;
+	pg->genpd.get_performance_state = tegra_pmc_pd_get_performance_state;
 	pg->genpd.power_off = tegra_genpd_power_off;
 	pg->genpd.power_on = tegra_genpd_power_on;
 	pg->pmc = pmc;
@@ -1353,6 +1438,7 @@ static int tegra_pmc_core_pd_add(struct tegra_pmc *pmc, struct device_node *np)
 		return -ENOMEM;
 
 	genpd->name = np->name;
+	genpd->get_performance_state = tegra_pmc_pd_get_performance_state;
 	genpd->set_performance_state = tegra_pmc_core_pd_set_performance_state;
 	genpd->opp_to_performance_state = tegra_pmc_core_pd_opp_to_performance_state;
 
-- 
2.32.0

