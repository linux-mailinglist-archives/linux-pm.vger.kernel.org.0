Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676C7393852
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 23:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbhE0Vpw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 17:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbhE0Vpl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 May 2021 17:45:41 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBBEC061574;
        Thu, 27 May 2021 14:44:04 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id e11so2677455ljn.13;
        Thu, 27 May 2021 14:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2HXxBEjKnEhLTbsgfhlVChSuNctEvdWxJbeZRkTbs7Y=;
        b=Jywjo6rspFdJm89gph+loOWtDMTnxnFTPCYUjv4IXzj2akJTlt1QEZEgdjmsPLuR2T
         FCHRjce4zftn3aYLRsijlhLa4krEycJyoOBwwf1zIQDkV2afZ8Wi4iiJ/Wj4FVtnFiJx
         625/XfhgAX0SHcmeJGfFlVEMJUfvW0nswRvfJMaPXXxWs4TKcMHGqbnD0UMmat11GtMM
         Rsxj7BwVCr3UDGpQR4lgGVbIr8e3vADuHWqOtHLjG9V9kj6HS4/3Z/OCaCjEqOK7CCTi
         ZAHTzZ2Cb5CkMGOA7dYZbGmf07q3DGHmVcrcBjauRCS5v/ee2zuPySp5GAfGlT3hN5XE
         yV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2HXxBEjKnEhLTbsgfhlVChSuNctEvdWxJbeZRkTbs7Y=;
        b=khaAmOouUzeb4ohonFUDuGCcQryexCM6+kYjEJNGFozF15FglPTH6SO1gxPZPmmTsm
         nLw7bdpBp076BcuXBb9T9BBabYaOu4hLAZFLqiFqPT8x0LWgi+BjvafYUcsn9SHfr+ZW
         +kTB7SpXKkNPnfED7AUAPKAWUmOTuEPbfrVsHfPZQENYpm8NL0UhftVgC/0wG+5QWpCr
         ADvjf9p4eKX3Pl9SpJbH/IGNf6hOt74OMyToCGfPXklqy+lowa5oo/6SfDtZcNk1fJ5Y
         qEi5QsehjzAyQ3l+ZxUFWHmKxpFGD+V8xAKdQqSnGLvqPlDThkiYNpKxs2hH8GH4hhI1
         2IPA==
X-Gm-Message-State: AOAM532EgidcQIN47uJDp0gkGgupmtV8aPOMH63Vq4eMFhM9z/FHfOud
        OrbblGhq1PJcAwB23UojVY8=
X-Google-Smtp-Source: ABdhPJwUmuY9rWQXkxau0Bu+SMEaSJNZj+HtpvgAptSbxQlaCWKGg9GBPwWBKg4lRG+Zv6DzZ0Py3A==
X-Received: by 2002:a2e:b80b:: with SMTP id u11mr4244615ljo.94.1622151842845;
        Thu, 27 May 2021 14:44:02 -0700 (PDT)
Received: from localhost.localdomain (46-138-12-55.dynamic.spd-mgts.ru. [46.138.12.55])
        by smtp.gmail.com with ESMTPSA id v11sm298153lfr.44.2021.05.27.14.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 14:44:02 -0700 (PDT)
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
Subject: [PATCH v4 12/14] soc/tegra: pmc: Add core power domain
Date:   Fri, 28 May 2021 00:43:15 +0300
Message-Id: <20210527214317.31014-13-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210527214317.31014-1-digetx@gmail.com>
References: <20210527214317.31014-1-digetx@gmail.com>
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

