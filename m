Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0CCD396B4E
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jun 2021 04:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbhFACfZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 22:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbhFACfS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 22:35:18 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E510C06138E;
        Mon, 31 May 2021 19:33:37 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x38so19336645lfa.10;
        Mon, 31 May 2021 19:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f8l3mwXhMPwYllO/ePBsiZtTrpb1R/1Eeya2pQTcbHw=;
        b=nTq1Mf8MXeEPcKa+ddwEs4UC+XGNJ03ymKxywiZyKHxa2Zcm/mCuig9ATq9aZWeMsN
         RGYpPpkvfAzU/QzcqoViBrT3E368VnG0+DM5vYLKjDKslX0Ax/ksATOKUhJELR6Sl+0/
         uhhyzCutLc001FuZQ/TKsZFs2fNPbZ+JHekvkwRJMBxEt9BuHJhXhMsNBpiFfetKlF5d
         bURsdtggKPe3P7qlxO79aN11uI2v5yu41bq1jZ69xdyu935fHNtR2Z+zTlgO2nGSql12
         EmF6RZc0RWcFsLYUPg0tjwXenHf49g7JV/HJ4KouUia1383exzF6Ti1lh3T8nfkxogZ1
         DmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f8l3mwXhMPwYllO/ePBsiZtTrpb1R/1Eeya2pQTcbHw=;
        b=nuOwHPOGynHuV44ZaJTtDgDxbvKEXtjru9qM5WQKjgcqmIimht7WpGw5/EDfC/6/Qh
         xM2/lV1jgysLUV501QUH1MbewzsGJyqZyJr3uoyjoxxeMMPddhpfRlH0i7SfPJFPpzlo
         9Mw59BgttO0SS23p51G87+S9+ybaZvbV8z6/ksIPR6G1dWNW5+gzv4NOwFTwS2XiPvCU
         oX0vNvGn9mxykZ+rKl2IBYrG1YHIpQwHqJGaTtnkEfDTsr7Rj6wmeyzFHOtIE7qTdCOl
         IL3jGxFyBupREYXwDkrJjZuM52e8A9u6jnH5Eoeh0LgP2cyITIeRuxDmDDVn/pA2eDrM
         7o8g==
X-Gm-Message-State: AOAM532pEqDnNNU1S8CGOJAPGrywIiz/rxOproEOS1T2wmEz+TaIzjjd
        2pu7LEHhExiHQcc0GCXJLmM=
X-Google-Smtp-Source: ABdhPJwEzV6kKqyTqj6H6mb2alwpj8MuzXez2Y5pGK+nVAvVRM0ok5Geo00v/TjMrbZOhp1U+C9EhA==
X-Received: by 2002:ac2:43ae:: with SMTP id t14mr15424844lfl.289.1622514815484;
        Mon, 31 May 2021 19:33:35 -0700 (PDT)
Received: from localhost.localdomain (79-139-170-222.dynamic.spd-mgts.ru. [79.139.170.222])
        by smtp.gmail.com with ESMTPSA id l21sm107848lfc.28.2021.05.31.19.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 19:33:35 -0700 (PDT)
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
Subject: [PATCH v6 12/14] soc/tegra: pmc: Add core power domain
Date:   Tue,  1 Jun 2021 05:31:17 +0300
Message-Id: <20210601023119.22044-13-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210601023119.22044-1-digetx@gmail.com>
References: <20210601023119.22044-1-digetx@gmail.com>
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
 drivers/soc/tegra/Kconfig |   2 +
 drivers/soc/tegra/pmc.c   | 120 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+)

diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
index 976dee036470..20ace654553a 100644
--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -144,6 +144,8 @@ config SOC_TEGRA_FLOWCTRL
 config SOC_TEGRA_PMC
 	bool
 	select GENERIC_PINCONF
+	select PM_OPP
+	select PM_GENERIC_DOMAINS
 
 config SOC_TEGRA_POWERGATE_BPMP
 	def_bool y
diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 4a582eae82ef..7e07910b9b88 100644
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
@@ -1297,12 +1298,110 @@ static int tegra_powergate_add(struct tegra_pmc *pmc, struct device_node *np)
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
@@ -1313,6 +1412,21 @@ static int tegra_powergate_init(struct tegra_pmc *pmc,
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
@@ -1356,6 +1470,12 @@ static void tegra_powergate_remove_all(struct device_node *parent)
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

