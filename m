Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCE03B9905
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbhGAXbJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234192AbhGAXbE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:31:04 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F18FC061765;
        Thu,  1 Jul 2021 16:28:32 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id u13so14871082lfk.2;
        Thu, 01 Jul 2021 16:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/aJ3rO0obgv/dk/av8APlj6qYGi3UG1POE4HkgpMfsI=;
        b=l+NRm+C8MpZp0LAy2j2qcTIVyaxAldCFDPpX3Wv4OTdd9uTONJActpI9U9AcWWxC3j
         3Ux0/VDTs0LBYgk165KPdHyFdcyh+ZrWdtgVt1KDuRHXVVVwI4OldqEoOjg1hKPIFKE5
         SGxjpzRYHgkAGpsYTp8zA5sN55ZIEusXv6dg09FgxfJX1E9waSHDmm82aSHlvvKZ6MU+
         BdcTHptBoCDdiCFx/Lt92VQXsayDQ6HTMPRMCZB0d0aKk/2xf1SdV130+yxK2vsgMPTP
         KLgLbfWSzccNkkLRSkM31ZwxYqudhsN7DlbrReeatKBvSfu37hYg1kYlxNnuSGyT2POX
         oS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/aJ3rO0obgv/dk/av8APlj6qYGi3UG1POE4HkgpMfsI=;
        b=TQzom207Pvezelz70Xtm35FUYUHBi9AbTRp4F55/7o+6PLZSD/bFShwdO4/ZyieNqk
         jrSwBAWFtSQNR1OFzAC1qHAN6fJsPFj+1xg0K/ix3vk8l3dGqE/bK+NgTCn9jcbbacrV
         hGIukvylL4m7Opr/Dgd0oOkt75gnCr5CI3EfSFzIxNTTdCod2gih54XQSfwJXaARqhOJ
         i+IN2CwFdN10UIeUE6w2S0yGXFwodLDlzehxzRUyBtAKxHBXKnoqgwB0Uzev9qooORAH
         tplK/cKWy1Kpv/3OKEMVJTatdkPA5eVfHCSyBTVVDV8YHjN/1t00BrD9udhG1t5Acn/6
         3WAA==
X-Gm-Message-State: AOAM530W4aLX5AN6EUxodOBthpBs/arogTFmM88I4+n+Y0oFVrzEmxmu
        e+Km5Rm+YyQD9w4XEHxwPEk=
X-Google-Smtp-Source: ABdhPJxEdqeuE7KZSaXkFfoydhrDnYK1YpuZtyv4PM8pWRzL1ZMsZIK9N8xQAYw9DIen3LOYgh1xKw==
X-Received: by 2002:a19:501a:: with SMTP id e26mr1478263lfb.161.1625182110450;
        Thu, 01 Jul 2021 16:28:30 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id s20sm102655lfr.39.2021.07.01.16.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:28:30 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 02/37] soc/tegra: pmc: Implement attach_dev() of power domain drivers
Date:   Fri,  2 Jul 2021 02:26:53 +0300
Message-Id: <20210701232728.23591-3-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701232728.23591-1-digetx@gmail.com>
References: <20210701232728.23591-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Implement attach_dev() callback of power domain drivers that initializes
the domain's performance state. GENPD core will apply the performance
state on the first runtime PM resume of the attached device.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/pmc.c | 147 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index f63dfb2ca3f9..ebafb818b08e 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -506,6 +506,151 @@ static void tegra_pmc_scratch_writel(struct tegra_pmc *pmc, u32 value,
 		writel(value, pmc->scratch + offset);
 }
 
+static const char * const tegra_emc_compats[] = {
+	"nvidia,tegra20-emc",
+	"nvidia,tegra30-emc",
+	NULL,
+};
+
+/*
+ * This GENPD callback is used by both powergate and core domains.
+ *
+ * We retrieve clock rate of the attached device and initialize domain's
+ * performance state in accordance to the clock rate.
+ */
+static int tegra_pmc_pd_attach_dev(struct generic_pm_domain *genpd,
+				   struct device *dev)
+{
+	struct generic_pm_domain_data *gpd_data = dev_gpd_data(dev);
+	struct opp_table *opp_table, *pd_opp_table;
+	struct generic_pm_domain *core_genpd;
+	struct dev_pm_opp *opp, *pd_opp;
+	unsigned long rate, state;
+	struct gpd_link *link;
+	struct clk *clk;
+	u32 hw_version;
+	int ret;
+
+	/*
+	 * Tegra114+ SocS don't support OPP yet.  But if they will get OPP
+	 * support, then we want to skip OPP for older kernels to preserve
+	 * compatibility of newer DTBs with older kernels.
+	 */
+	if (!pmc->soc->supports_core_domain)
+		return 0;
+
+	/*
+	 * The EMC devices are a special case because we have a protection
+	 * from non-EMC drivers getting clock handle before EMC driver is
+	 * fully initialized.  The goal of the protection is to prevent
+	 * devfreq driver from getting failures if it will try to change
+	 * EMC clock rate until clock is fully initialized.  The EMC drivers
+	 * will initialize the performance state by themselves.
+	 */
+	if (of_device_compatible_match(dev->of_node, tegra_emc_compats))
+		return 0;
+
+	clk = clk_get(dev, NULL);
+	if (IS_ERR(clk)) {
+		dev_err(&genpd->dev, "failed to get clk of %s: %pe\n",
+			dev_name(dev), clk);
+		return PTR_ERR(clk);
+	}
+
+	rate = clk_get_rate(clk);
+	if (!rate) {
+		dev_err(&genpd->dev, "failed to get clk rate of %s\n",
+			dev_name(dev));
+		ret = -EINVAL;
+		goto put_clk;
+	}
+
+	if (of_machine_is_compatible("nvidia,tegra20"))
+		hw_version = BIT(tegra_sku_info.soc_process_id);
+	else
+		hw_version = BIT(tegra_sku_info.soc_speedo_id);
+
+	opp_table = dev_pm_opp_set_supported_hw(dev, &hw_version, 1);
+	if (IS_ERR(opp_table)) {
+		dev_err(&genpd->dev, "failed to set OPP supported HW for %s: %d\n",
+			dev_name(dev), ret);
+		ret = PTR_ERR(opp_table);
+		goto put_clk;
+	}
+
+	ret = dev_pm_opp_of_add_table(dev);
+	if (ret) {
+		/* older DTBs that don't have OPPs will get -ENODEV here */
+		if (ret != -ENODEV)
+			dev_err(&genpd->dev, "failed to get OPP table of %s: %d\n",
+				dev_name(dev), ret);
+		else
+			ret = 0;
+
+		goto put_supported_hw;
+	}
+
+	/* find suitable OPP for the rate */
+	opp = dev_pm_opp_find_freq_ceil(dev, &rate);
+
+	if (opp == ERR_PTR(-ERANGE))
+		opp = dev_pm_opp_find_freq_floor(dev, &rate);
+
+	if (IS_ERR(opp)) {
+		dev_err(&genpd->dev, "failed to find OPP for %luHz of %s: %pe\n",
+			rate, dev_name(dev), opp);
+		ret = PTR_ERR(opp);
+		goto remove_dev_table;
+	}
+
+	if (!list_empty(&genpd->child_links)) {
+		link = list_first_entry(&genpd->child_links, struct gpd_link,
+					child_node);
+		core_genpd = link->parent;
+	} else {
+		core_genpd = genpd;
+	}
+
+	pd_opp_table = dev_pm_opp_get_opp_table(&core_genpd->dev);
+	if (IS_ERR(pd_opp_table)) {
+		dev_err(&genpd->dev, "failed to get OPP table of %s: %pe\n",
+			dev_name(&core_genpd->dev), pd_opp_table);
+		ret = PTR_ERR(pd_opp_table);
+		goto put_dev_opp;
+	}
+
+	pd_opp = dev_pm_opp_xlate_required_opp(opp_table, pd_opp_table, opp);
+	if (IS_ERR(pd_opp)) {
+		dev_err(&genpd->dev,
+			"failed to xlate required OPP for %luHz of %s: %pe\n",
+			rate, dev_name(dev), pd_opp);
+		ret = PTR_ERR(pd_opp);
+		goto put_pd_opp_table;
+	}
+
+	/*
+	 * The initialized state will be applied by GENPD core on the first
+	 * RPM-resume of the device.  This means that drivers don't need to
+	 * explicitly initialize performance state.
+	 */
+	state = pm_genpd_opp_to_performance_state(&core_genpd->dev, pd_opp);
+	gpd_data->rpm_pstate = state;
+	dev_pm_opp_put(pd_opp);
+
+put_pd_opp_table:
+	dev_pm_opp_put_opp_table(pd_opp_table);
+put_dev_opp:
+	dev_pm_opp_put(opp);
+remove_dev_table:
+	dev_pm_opp_of_remove_table(dev);
+put_supported_hw:
+	dev_pm_opp_put_supported_hw(opp_table);
+put_clk:
+	clk_put(clk);
+
+	return ret;
+}
+
 /*
  * TODO Figure out a way to call this with the struct tegra_pmc * passed in.
  * This currently doesn't work because readx_poll_timeout() can only operate
@@ -1238,6 +1383,7 @@ static int tegra_powergate_add(struct tegra_pmc *pmc, struct device_node *np)
 
 	pg->id = id;
 	pg->genpd.name = np->name;
+	pg->genpd.attach_dev = tegra_pmc_pd_attach_dev;
 	pg->genpd.power_off = tegra_genpd_power_off;
 	pg->genpd.power_on = tegra_genpd_power_on;
 	pg->pmc = pmc;
@@ -1354,6 +1500,7 @@ static int tegra_pmc_core_pd_add(struct tegra_pmc *pmc, struct device_node *np)
 		return -ENOMEM;
 
 	genpd->name = np->name;
+	genpd->attach_dev = tegra_pmc_pd_attach_dev;
 	genpd->set_performance_state = tegra_pmc_core_pd_set_performance_state;
 	genpd->opp_to_performance_state = tegra_pmc_core_pd_opp_to_performance_state;
 
-- 
2.30.2

