Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0755133813E
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 00:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhCKXPf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Mar 2021 18:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbhCKXPa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Mar 2021 18:15:30 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7FDC061574;
        Thu, 11 Mar 2021 15:15:29 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d15so3772491wrv.5;
        Thu, 11 Mar 2021 15:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b2w9mpc636QgZcQ3KhN9N6W9L5fmy+Ks+Eg/JPfevSU=;
        b=iG9PrCdKaD6u9Ne5dcQTX4Wg12IUSOOxp+Lwx7CuQZrxIuoeF6ZXjmanoN9etX4nLV
         oxi0bQLOzmIUNTiV9jXEtxzL5irm7hzZRt3pLVA8quZM+eDkVhq4dXuS8F5R7/wnEWNt
         OS89w2xzNWhjgku+GUjLyJdFKK7sffInvAEt25X8Jf+sstU6DYjkQpUaig+sB4ZZGP8J
         9cisO47PuHYDKTbNdNWgBKcuNTxYrAcHOwXiMEmjDHg3qbDWAgURARSkG+kwZ7ysbvCW
         eqp2ArEjEiqzdTsEghvOl6fGNw3wWVE+3pQ6ZanRD1w2bPwDnq8QUW2nwSAkgyrOaCNO
         Tvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b2w9mpc636QgZcQ3KhN9N6W9L5fmy+Ks+Eg/JPfevSU=;
        b=fYrpXmDAebdWq5elnc4bHcWHbypuMsXoZiahxFzeODW/XOJViMIX3SNlEri2wMzsuV
         I81/NYr/UKT856sWWZ7EC7THOYzfEMr+voS752qgULDp7Np1CXj/6ps0RFdDPr49M5Jq
         B9FOeZlEUJ09mPHnpiUfK3th2MQGbPiVxFU3Yig1WjoQIoctFwNHPy8cHai5UgAu5pKL
         vRP4lJivjXUISH73ZUEnae0Y2BirC4UnfU5TzQBpJW+tqkOP5jaMDJt1SFkUUnh2N37Z
         NwTVIhgEp6hNeGoZReMkbjyuqgb6sb9WChMG3vAub4u3mr8rAxmrWbMkBpWcBH1m7tvq
         HRuw==
X-Gm-Message-State: AOAM530gS1MEc2IE0Lqj7mTZU5+pR23BXJmOeWrmAobmWLQFpi6PxIGR
        cevU7CLElYLKrg6eb/JAeM8=
X-Google-Smtp-Source: ABdhPJwmd3xwn+J7g8zPor95wn0hzMJ6537P2c5KCUVb2hPPpDrluJOEiBOy3BnNWiKrw3CcDwoQHQ==
X-Received: by 2002:a5d:63d2:: with SMTP id c18mr10928605wrw.277.1615504528353;
        Thu, 11 Mar 2021 15:15:28 -0800 (PST)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id j203sm263918wmj.40.2021.03.11.15.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 15:15:28 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Fertser <fercerpav@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] soc/tegra: Introduce core power domain driver
Date:   Fri, 12 Mar 2021 02:12:06 +0300
Message-Id: <20210311231208.18180-5-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210311231208.18180-1-digetx@gmail.com>
References: <20210311231208.18180-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

NVIDIA Tegra SoCs have multiple power domains, each domain corresponds
to an external SoC power rail. Core power domain covers vast majority of
hardware blocks within a Tegra SoC. The voltage of a power domain should
be set to a value which satisfies all devices within a power domain. Add
driver for the core power domain which manages the voltage state of the
domain. This allows us to support a system-wide DVFS on Tegra.

Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/Kconfig             |   6 +
 drivers/soc/tegra/Makefile            |   1 +
 drivers/soc/tegra/core-power-domain.c | 154 ++++++++++++++++++++++++++
 include/soc/tegra/common.h            |   6 +
 4 files changed, 167 insertions(+)
 create mode 100644 drivers/soc/tegra/core-power-domain.c

diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
index bcd61ae59ba3..fccbc168dd87 100644
--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -16,6 +16,7 @@ config ARCH_TEGRA_2x_SOC
 	select SOC_TEGRA_COMMON
 	select SOC_TEGRA_FLOWCTRL
 	select SOC_TEGRA_PMC
+	select SOC_TEGRA_CORE_POWER_DOMAIN
 	select SOC_TEGRA20_VOLTAGE_COUPLER
 	select TEGRA_TIMER
 	help
@@ -31,6 +32,7 @@ config ARCH_TEGRA_3x_SOC
 	select SOC_TEGRA_COMMON
 	select SOC_TEGRA_FLOWCTRL
 	select SOC_TEGRA_PMC
+	select SOC_TEGRA_CORE_POWER_DOMAIN
 	select SOC_TEGRA30_VOLTAGE_COUPLER
 	select TEGRA_TIMER
 	help
@@ -170,3 +172,7 @@ config SOC_TEGRA20_VOLTAGE_COUPLER
 config SOC_TEGRA30_VOLTAGE_COUPLER
 	bool "Voltage scaling support for Tegra30 SoCs"
 	depends on ARCH_TEGRA_3x_SOC || COMPILE_TEST
+
+config SOC_TEGRA_CORE_POWER_DOMAIN
+	bool
+	select PM_GENERIC_DOMAINS
diff --git a/drivers/soc/tegra/Makefile b/drivers/soc/tegra/Makefile
index 9c809c1814bd..8f1294f954b4 100644
--- a/drivers/soc/tegra/Makefile
+++ b/drivers/soc/tegra/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_SOC_TEGRA_PMC) += pmc.o
 obj-$(CONFIG_SOC_TEGRA_POWERGATE_BPMP) += powergate-bpmp.o
 obj-$(CONFIG_SOC_TEGRA20_VOLTAGE_COUPLER) += regulators-tegra20.o
 obj-$(CONFIG_SOC_TEGRA30_VOLTAGE_COUPLER) += regulators-tegra30.o
+obj-$(CONFIG_SOC_TEGRA_CORE_POWER_DOMAIN) += core-power-domain.o
diff --git a/drivers/soc/tegra/core-power-domain.c b/drivers/soc/tegra/core-power-domain.c
new file mode 100644
index 000000000000..9099290c1b02
--- /dev/null
+++ b/drivers/soc/tegra/core-power-domain.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * NVIDIA Tegra SoC Core Power Domain Driver
+ */
+
+#include <linux/mutex.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_opp.h>
+#include <linux/slab.h>
+
+#include <soc/tegra/common.h>
+
+static struct lock_class_key tegra_core_domain_lock_class;
+static bool tegra_core_domain_state_synced;
+static DEFINE_MUTEX(tegra_core_lock);
+
+bool tegra_soc_core_domain_state_synced(void)
+{
+	return tegra_core_domain_state_synced;
+}
+
+static int tegra_genpd_set_performance_state(struct generic_pm_domain *genpd,
+					     unsigned int level)
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
+	mutex_lock(&tegra_core_lock);
+	err = dev_pm_opp_set_opp(&genpd->dev, opp);
+	mutex_unlock(&tegra_core_lock);
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
+tegra_genpd_opp_to_performance_state(struct generic_pm_domain *genpd,
+				     struct dev_pm_opp *opp)
+{
+	return dev_pm_opp_get_level(opp);
+}
+
+static int tegra_core_domain_probe(struct platform_device *pdev)
+{
+	struct generic_pm_domain *genpd;
+	struct opp_table *opp_table;
+	const char *rname = "power";
+	int err;
+
+	genpd = devm_kzalloc(&pdev->dev, sizeof(*genpd), GFP_KERNEL);
+	if (!genpd)
+		return -ENOMEM;
+
+	genpd->name = pdev->dev.of_node->name;
+	genpd->set_performance_state = tegra_genpd_set_performance_state;
+	genpd->opp_to_performance_state = tegra_genpd_opp_to_performance_state;
+
+	opp_table = devm_pm_opp_set_regulators(&pdev->dev, &rname, 1);
+	if (IS_ERR(opp_table))
+		return dev_err_probe(&pdev->dev, PTR_ERR(opp_table),
+				     "failed to set OPP regulator\n");
+
+	err = pm_genpd_init(genpd, NULL, false);
+	if (err) {
+		dev_err(&pdev->dev, "failed to init genpd: %d\n", err);
+		return err;
+	}
+
+	/*
+	 * We have a "PMC -> Core" hierarchy of the power domains where
+	 * PMC needs to resume and change performance (voltage) of the
+	 * Core domain from the PMC GENPD on/off callbacks, hence we need
+	 * to annotate the lock in order to remove confusion from the
+	 * lockdep checker when a nested access happens.
+	 */
+	lockdep_set_class(&genpd->mlock, &tegra_core_domain_lock_class);
+
+	err = of_genpd_add_provider_simple(pdev->dev.of_node, genpd);
+	if (err) {
+		dev_err(&pdev->dev, "failed to add genpd: %d\n", err);
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
+static void tegra_core_domain_set_synced(struct device *dev, bool synced)
+{
+	int err;
+
+	tegra_core_domain_state_synced = synced;
+
+	mutex_lock(&tegra_core_lock);
+	err = dev_pm_opp_sync_regulators(dev);
+	mutex_unlock(&tegra_core_lock);
+
+	if (err)
+		dev_err(dev, "failed to sync regulators: %d\n", err);
+}
+
+static void tegra_core_domain_sync_state(struct device *dev)
+{
+	tegra_core_domain_set_synced(dev, true);
+}
+
+static void tegra_core_domain_shutdown(struct platform_device *pdev)
+{
+	/*
+	 * Ensure that core voltage is at a level suitable for boot-up
+	 * before system is rebooted, which may be important for some
+	 * devices if regulators aren't reset on reboot. This is usually
+	 * the case if PMC soft-reboot is used.
+	 */
+	tegra_core_domain_set_synced(&pdev->dev, false);
+}
+
+static const struct of_device_id tegra_core_domain_match[] = {
+	{ .compatible = "nvidia,tegra20-core-domain", },
+	{ .compatible = "nvidia,tegra30-core-domain", },
+	{ }
+};
+
+static struct platform_driver tegra_core_domain_driver = {
+	.driver = {
+		.name = "tegra-core-power",
+		.of_match_table = tegra_core_domain_match,
+		.suppress_bind_attrs = true,
+		.sync_state = tegra_core_domain_sync_state,
+	},
+	.probe = tegra_core_domain_probe,
+	.shutdown = tegra_core_domain_shutdown,
+};
+builtin_platform_driver(tegra_core_domain_driver);
diff --git a/include/soc/tegra/common.h b/include/soc/tegra/common.h
index e8eab13aa199..9a4ac3af2401 100644
--- a/include/soc/tegra/common.h
+++ b/include/soc/tegra/common.h
@@ -22,6 +22,7 @@ struct tegra_core_opp_params {
 
 #ifdef CONFIG_ARCH_TEGRA
 bool soc_is_tegra(void);
+bool tegra_soc_core_domain_state_synced(void);
 int devm_tegra_core_dev_init_opp_table(struct device *dev,
 				       struct tegra_core_opp_params *params);
 #else
@@ -30,6 +31,11 @@ static inline bool soc_is_tegra(void)
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
2.29.2

