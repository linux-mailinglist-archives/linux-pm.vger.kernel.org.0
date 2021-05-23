Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1821C38DDF3
	for <lists+linux-pm@lfdr.de>; Mon, 24 May 2021 01:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbhEWXPj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 May 2021 19:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbhEWXPc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 May 2021 19:15:32 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2ED1C061346;
        Sun, 23 May 2021 16:13:59 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id w15so31119072ljo.10;
        Sun, 23 May 2021 16:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IzFYrbKct9v7QhaslHi1ijTTshQlF3DsOMMvEeyyy5s=;
        b=l09CzhFxXg9GZr3SmMKbaJhAMCaR8PQPyL7O/owaehBZngx/q6oWm73SnbRcE2+aYf
         pB06asJdDS1jQLm6Wp+jXQv5p3srp/HmXnFk4ajQBLZp1xLqXjnWvox2HLdX9aklhtKB
         dhrr+SHFTQAzwIpb9cmI6O39plSu5oaKHscvwxz+7TnUsIXkHPWIdVmrZLeSJfaU7f0I
         a9Y45wBFGkTAF9bwe4EPSbfDxHkeibUN/jO/RtzUsvaiX1SShmPuU9LmODp1roczFAvU
         vb5BnytrkgMifD4ToowMbE0zfNLF4jUW2NoUuOQ9HSn7V2nVkFqLs3LvxTwnyjBbYY/J
         l8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IzFYrbKct9v7QhaslHi1ijTTshQlF3DsOMMvEeyyy5s=;
        b=O5DvQqv5JP4nr429PK8nvDofXfjrJvgQKPZw1xG/eN54IuoLKy6vTV0EG5SCZTrwOD
         qr+QT2zt/OsHSRqSkQh03l/kkrhDsfehV9q0JaG/DZV+orq9+UjNMNaayA6Wr9ERDDjz
         /OjCXWgsaW21FH56HBK9yNLDuy5L2UH78EFITiOPMpjnrBuCZRaiFjSxnd5cmqMUBrY2
         OySK63i1nHOtV6N7xd37A3FryT5wboTb8Wg+h+mP+b0gLxrkFoJ9Nd+oOardf4iJBQa4
         BHxMtd0mBvxIGf06E0yomcyE0AN76GVywtapqZ+jlB7a5HeuE2Zzimo7Ypyqxuol6dpS
         sS1w==
X-Gm-Message-State: AOAM533l8vx4whQHy8jQ3quWC7f0FfbnRqjeDS7Bxckr77w6Ae61WHGu
        62YBB1IhT6yfzmvV8jwufY8=
X-Google-Smtp-Source: ABdhPJzdoFPETY/DzNyV2GuurKZ4ph2lj5Vzl+BY6K5mZfA8rWsTt3LyGlFrHWpStcCkeN+fk166+w==
X-Received: by 2002:a2e:580d:: with SMTP id m13mr15063042ljb.31.1621811638367;
        Sun, 23 May 2021 16:13:58 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-110.dynamic.spd-mgts.ru. [109.252.193.110])
        by smtp.gmail.com with ESMTPSA id p7sm1268619lfr.184.2021.05.23.16.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 16:13:58 -0700 (PDT)
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
Subject: [PATCH v2 13/14] soc/tegra: pmc: Add core power domain
Date:   Mon, 24 May 2021 02:13:34 +0300
Message-Id: <20210523231335.8238-14-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210523231335.8238-1-digetx@gmail.com>
References: <20210523231335.8238-1-digetx@gmail.com>
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
requires device-tree updating, older DTBs are unaffected.

Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/Kconfig  |  14 ++++
 drivers/soc/tegra/pmc.c    | 143 +++++++++++++++++++++++++++++++++++++
 include/soc/tegra/common.h |   7 ++
 3 files changed, 164 insertions(+)

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
index 8e3b78bb2ac2..33b6e0885020 100644
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
@@ -428,6 +429,8 @@ struct tegra_pmc {
 	struct irq_chip irq;
 
 	struct notifier_block clk_nb;
+
+	bool core_domain_state_synced;
 };
 
 static struct tegra_pmc *pmc = &(struct tegra_pmc) {
@@ -1302,12 +1305,115 @@ static int tegra_powergate_add(struct tegra_pmc *pmc, struct device_node *np)
 	return err;
 }
 
+bool tegra_soc_core_domain_state_synced(void)
+{
+	return pmc->core_domain_state_synced;
+}
+
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
@@ -1318,6 +1424,21 @@ static int tegra_powergate_init(struct tegra_pmc *pmc,
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
@@ -1361,6 +1482,12 @@ static void tegra_powergate_remove_all(struct device_node *parent)
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
@@ -3672,6 +3799,21 @@ static const struct of_device_id tegra_pmc_match[] = {
 	{ }
 };
 
+static void tegra_pmc_sync_state(struct device *dev)
+{
+	int err;
+
+	pmc->core_domain_state_synced = true;
+
+	/* this is a no-op if core regulator isn't used */
+	mutex_lock(&pmc->powergates_lock);
+	err = dev_pm_opp_sync_regulators(dev);
+	mutex_unlock(&pmc->powergates_lock);
+
+	if (err)
+		dev_err(dev, "failed to sync regulators: %d\n", err);
+}
+
 static struct platform_driver tegra_pmc_driver = {
 	.driver = {
 		.name = "tegra-pmc",
@@ -3680,6 +3822,7 @@ static struct platform_driver tegra_pmc_driver = {
 #if defined(CONFIG_PM_SLEEP) && defined(CONFIG_ARM)
 		.pm = &tegra_pmc_pm_ops,
 #endif
+		.sync_state = tegra_pmc_sync_state,
 	},
 	.probe = tegra_pmc_probe,
 };
diff --git a/include/soc/tegra/common.h b/include/soc/tegra/common.h
index af41ad80ec21..135a6956a18c 100644
--- a/include/soc/tegra/common.h
+++ b/include/soc/tegra/common.h
@@ -23,6 +23,8 @@ struct tegra_core_opp_params {
 #ifdef CONFIG_ARCH_TEGRA
 bool soc_is_tegra(void);
 
+bool tegra_soc_core_domain_state_synced(void);
+
 int devm_tegra_core_dev_init_opp_table(struct device *dev,
 				       struct tegra_core_opp_params *params);
 #else
@@ -31,6 +33,11 @@ static inline bool soc_is_tegra(void)
 	return false;
 }
 
+static inline bool tegra_soc_core_domain_state_synced(void)
+{
+	return false;
+}
+
 static inline int
 devm_tegra_core_dev_init_opp_table(struct device *dev,
 				   struct tegra_core_opp_params *params)
-- 
2.30.2

