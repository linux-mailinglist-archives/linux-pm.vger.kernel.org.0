Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437223939B7
	for <lists+linux-pm@lfdr.de>; Fri, 28 May 2021 01:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbhE0X42 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 19:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbhE0X4N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 May 2021 19:56:13 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC22C061347;
        Thu, 27 May 2021 16:54:31 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id a5so2732629lfm.0;
        Thu, 27 May 2021 16:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2HXxBEjKnEhLTbsgfhlVChSuNctEvdWxJbeZRkTbs7Y=;
        b=oY8NtNrGvDhFYixLKUX+z6piuhdGUFrChMZoMGm8tFa+t8TUU/17aYw3ahrZLnKS88
         4j/5Cq5IS/CGFUF9NLcA0TO91nEV6N0S3B2u9N3q/YvElOWwPiKLtgXmQxLVV3U4Lfsn
         jpqq9T1v1H66F46sAk6Lf5gIppKDXujO/P3MELfPD3idCahx5p3ga0WEKxjOEEoruCD8
         +bNGfALwiS4uNuHx3uGOQ2dCMOn0Yve7Jx7zwlfapd96REW4L6DkbgXtUUQEc1PAAQc/
         WYVPI958uc1xKvm47vE3w+4Gc5eHHWzXYWlAUAXNwebOhl2br0z1I6CTRx/En5rSF2Go
         6obw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2HXxBEjKnEhLTbsgfhlVChSuNctEvdWxJbeZRkTbs7Y=;
        b=mOAo2EZBNVtfEc7CzUc/S/8cH2z6xArlLvGiUiI4s3Rm2YTTP7GDW/vyBohcE67gkj
         BEwRWiPBoUlFirTWWMeS+7C8TDovYmpxIZOHmu7WVVHaAxOZ1/403JWuqueF807SvUHR
         43h7laHjcSolrPCxT9jbA6ux/5g+9xOpNEHYwDxh433Z2exd9UBaILvDrENiQxn6QBDd
         TEsvMIXazji5c3uBfH6cj/jsRBnoX8eXOcMM6xFqPV2d3Mt6krhzEbqGpagQhWhHZeVD
         m+9m98ODzQ98W3iiyyEB9vUAbDQQNzF1D0p3l3imc88l/f1kxZsoJ84RD1aCyu3xZmcL
         8PxQ==
X-Gm-Message-State: AOAM533+1epFXaIeonZ1+OY2gBvbpAS3Zth/KDmSsPuyLKozEb84/yEv
        UNrxHnirUzy+Sr65tg1Z0B35ZdEMFno=
X-Google-Smtp-Source: ABdhPJxIMLYsdM5ms9z32YJO42FKfHEGbZyCYllUTSolTLSG9kEr9Han+hi+nJWI4ETvDc6kabxXNQ==
X-Received: by 2002:a19:495b:: with SMTP id l27mr4069456lfj.230.1622159669556;
        Thu, 27 May 2021 16:54:29 -0700 (PDT)
Received: from localhost.localdomain (46-138-12-55.dynamic.spd-mgts.ru. [46.138.12.55])
        by smtp.gmail.com with ESMTPSA id t129sm319000lff.109.2021.05.27.16.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 16:54:29 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        =?UTF-8?q?Nikola=20Milosavljevi=C4=87?= <mnidza@outlook.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Paul Fertser <fercerpav@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-clk@vger.kernel.org
Subject: [PATCH v5 12/14] soc/tegra: pmc: Add core power domain
Date:   Fri, 28 May 2021 02:54:11 +0300
Message-Id: <20210527235413.23120-13-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210527235413.23120-1-digetx@gmail.com>
References: <20210527235413.23120-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

NVIDIA Tegra SoCs have multiple power domains, each domain corresponds
to an external SoC power rail. Core power domain covers vast majority of
hardware blocks within a Tegra SoC. The voltage of a power domain should
be set to a level which satisfies all devices within the power domain.
Add support for the core power domain which controls voltage state of the
domain. This allows us to support system-wide DVFS on Tegra20-210 SoCs.
The PMC powergate domains now are sub-domains of the core domain, this
requires device-tree updating, older DTBs are unaffected and will continue
to work as before.

Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/Kconfig |  14 +++++
 drivers/soc/tegra/pmc.c   | 120 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 134 insertions(+)

diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
index 976dee036470..7057254604ee 100644
--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -13,6 +13,7 @@ config ARCH_TEGRA_2x_SOC
 	select PINCTRL_TEGRA20
 	select PL310_ERRATA_727915 if CACHE_L2X0
 	select PL310_ERRATA_769419 if CACHE_L2X0
+	select SOC_TEGRA_COMMON
 	select SOC_TEGRA_FLOWCTRL
 	select SOC_TEGRA_PMC
 	select SOC_TEGRA20_VOLTAGE_COUPLER
@@ -27,6 +28,7 @@ config ARCH_TEGRA_3x_SOC
 	select ARM_ERRATA_764369 if SMP
 	select PINCTRL_TEGRA30
 	select PL310_ERRATA_769419 if CACHE_L2X0
+	select SOC_TEGRA_COMMON
 	select SOC_TEGRA_FLOWCTRL
 	select SOC_TEGRA_PMC
 	select SOC_TEGRA30_VOLTAGE_COUPLER
@@ -40,6 +42,7 @@ config ARCH_TEGRA_114_SOC
 	select ARM_ERRATA_798181 if SMP
 	select HAVE_ARM_ARCH_TIMER
 	select PINCTRL_TEGRA114
+	select SOC_TEGRA_COMMON
 	select SOC_TEGRA_FLOWCTRL
 	select SOC_TEGRA_PMC
 	select TEGRA_TIMER
@@ -51,6 +54,7 @@ config ARCH_TEGRA_124_SOC
 	bool "Enable support for Tegra124 family"
 	select HAVE_ARM_ARCH_TIMER
 	select PINCTRL_TEGRA124
+	select SOC_TEGRA_COMMON
 	select SOC_TEGRA_FLOWCTRL
 	select SOC_TEGRA_PMC
 	select TEGRA_TIMER
@@ -66,6 +70,7 @@ if ARM64
 config ARCH_TEGRA_132_SOC
 	bool "NVIDIA Tegra132 SoC"
 	select PINCTRL_TEGRA124
+	select SOC_TEGRA_COMMON
 	select SOC_TEGRA_FLOWCTRL
 	select SOC_TEGRA_PMC
 	help
@@ -77,6 +82,7 @@ config ARCH_TEGRA_132_SOC
 config ARCH_TEGRA_210_SOC
 	bool "NVIDIA Tegra210 SoC"
 	select PINCTRL_TEGRA210
+	select SOC_TEGRA_COMMON
 	select SOC_TEGRA_FLOWCTRL
 	select SOC_TEGRA_PMC
 	select TEGRA_TIMER
@@ -99,6 +105,7 @@ config ARCH_TEGRA_186_SOC
 	select TEGRA_BPMP
 	select TEGRA_HSP_MBOX
 	select TEGRA_IVC
+	select SOC_TEGRA_COMMON
 	select SOC_TEGRA_PMC
 	help
 	  Enable support for the NVIDIA Tegar186 SoC. The Tegra186 features a
@@ -115,6 +122,7 @@ config ARCH_TEGRA_194_SOC
 	select TEGRA_BPMP
 	select TEGRA_HSP_MBOX
 	select TEGRA_IVC
+	select SOC_TEGRA_COMMON
 	select SOC_TEGRA_PMC
 	help
 	  Enable support for the NVIDIA Tegra194 SoC.
@@ -125,6 +133,7 @@ config ARCH_TEGRA_234_SOC
 	select TEGRA_BPMP
 	select TEGRA_HSP_MBOX
 	select TEGRA_IVC
+	select SOC_TEGRA_COMMON
 	select SOC_TEGRA_PMC
 	help
 	  Enable support for the NVIDIA Tegra234 SoC.
@@ -132,6 +141,11 @@ config ARCH_TEGRA_234_SOC
 endif
 endif
 
+config SOC_TEGRA_COMMON
+	bool
+	select PM_OPP
+	select PM_GENERIC_DOMAINS
+
 config SOC_TEGRA_FUSE
 	def_bool y
 	depends on ARCH_TEGRA
diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 8e3b78bb2ac2..62f0f928658d 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -38,6 +38,7 @@
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_opp.h>
 #include <linux/reboot.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
@@ -1302,12 +1303,110 @@ static int tegra_powergate_add(struct tegra_pmc *pmc, struct device_node *np)
 	return err;
 }
 
+static int
+tegra_pmc_core_pd_set_performance_state(struct generic_pm_domain *genpd,
+					unsigned int level)
+{
+	struct dev_pm_opp *opp;
+	int err;
+
+	opp = dev_pm_opp_find_level_ceil(&genpd->dev, &level);
+	if (IS_ERR(opp)) {
+		dev_err(&genpd->dev, "failed to find OPP for level %u: %pe\n",
+			level, opp);
+		return PTR_ERR(opp);
+	}
+
+	mutex_lock(&pmc->powergates_lock);
+	err = dev_pm_opp_set_opp(pmc->dev, opp);
+	mutex_unlock(&pmc->powergates_lock);
+
+	dev_pm_opp_put(opp);
+
+	if (err) {
+		dev_err(&genpd->dev, "failed to set voltage to %duV: %d\n",
+			level, err);
+		return err;
+	}
+
+	return 0;
+}
+
+static unsigned int
+tegra_pmc_core_pd_opp_to_performance_state(struct generic_pm_domain *genpd,
+					   struct dev_pm_opp *opp)
+{
+	return dev_pm_opp_get_level(opp);
+}
+
+static int tegra_pmc_core_pd_add(struct tegra_pmc *pmc, struct device_node *np)
+{
+	static struct lock_class_key tegra_core_domain_lock_class;
+	struct generic_pm_domain *genpd;
+	const char *rname = "core";
+	int err;
+
+	genpd = devm_kzalloc(pmc->dev, sizeof(*genpd), GFP_KERNEL);
+	if (!genpd)
+		return -ENOMEM;
+
+	genpd->name = np->name;
+	genpd->set_performance_state = tegra_pmc_core_pd_set_performance_state;
+	genpd->opp_to_performance_state = tegra_pmc_core_pd_opp_to_performance_state;
+
+	err = devm_pm_opp_set_regulators(pmc->dev, &rname, 1);
+	if (err)
+		return dev_err_probe(pmc->dev, err,
+				     "failed to set core OPP regulator\n");
+
+	err = pm_genpd_init(genpd, NULL, false);
+	if (err) {
+		dev_err(pmc->dev, "failed to init core genpd: %d\n", err);
+		return err;
+	}
+
+	/*
+	 * We have a "PMC pwrgate -> Core" hierarchy of the power domains
+	 * where PMC needs to resume and change performance (voltage) of the
+	 * Core domain from the PMC GENPD on/off callbacks, hence we need
+	 * to annotate the lock in order to remove confusion from the
+	 * lockdep checker when a nested access happens.
+	 */
+	lockdep_set_class(&genpd->mlock, &tegra_core_domain_lock_class);
+
+	err = of_genpd_add_provider_simple(np, genpd);
+	if (err) {
+		dev_err(pmc->dev, "failed to add core genpd: %d\n", err);
+		goto remove_genpd;
+	}
+
+	return 0;
+
+remove_genpd:
+	pm_genpd_remove(genpd);
+
+	return err;
+}
+
 static int tegra_powergate_init(struct tegra_pmc *pmc,
 				struct device_node *parent)
 {
+	struct of_phandle_args child_args, parent_args;
 	struct device_node *np, *child;
 	int err = 0;
 
+	/*
+	 * Core power domain is the parent of powergate domains, hence it
+	 * should be registered first.
+	 */
+	np = of_get_child_by_name(parent, "core-domain");
+	if (np) {
+		err = tegra_pmc_core_pd_add(pmc, np);
+		of_node_put(np);
+		if (err)
+			return err;
+	}
+
 	np = of_get_child_by_name(parent, "powergates");
 	if (!np)
 		return 0;
@@ -1318,6 +1417,21 @@ static int tegra_powergate_init(struct tegra_pmc *pmc,
 			of_node_put(child);
 			break;
 		}
+
+		if (of_parse_phandle_with_args(child, "power-domains",
+					       "#power-domain-cells",
+					       0, &parent_args))
+			continue;
+
+		child_args.np = child;
+		child_args.args_count = 0;
+
+		err = of_genpd_add_subdomain(&parent_args, &child_args);
+		of_node_put(parent_args.np);
+		if (err) {
+			of_node_put(child);
+			break;
+		}
 	}
 
 	of_node_put(np);
@@ -1361,6 +1475,12 @@ static void tegra_powergate_remove_all(struct device_node *parent)
 	}
 
 	of_node_put(np);
+
+	np = of_get_child_by_name(parent, "core-domain");
+	if (np) {
+		of_genpd_del_provider(np);
+		of_genpd_remove_last(np);
+	}
 }
 
 static const struct tegra_io_pad_soc *
-- 
2.30.2

