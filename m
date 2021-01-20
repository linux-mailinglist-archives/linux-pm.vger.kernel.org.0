Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403222FD1BD
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 14:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731603AbhATNZd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 08:25:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:54156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729591AbhATNR6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 Jan 2021 08:17:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 711AF2245C;
        Wed, 20 Jan 2021 13:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611148637;
        bh=seFF8AEbY7EFiGT41bEhA6Q4dwI7EdirV4FStnKMPAI=;
        h=From:To:Cc:Subject:Date:From;
        b=euNDx1AfrSK3cxkoVZdvr3ri3eVidaV67iWi97T8WJppoKT81vEpWhGGL/7D8izQl
         E5n+WuyAKViUPjnV1XdZZq7IqxFDjbToHx1LJExzt4y6maiG5mx07fj3p+l3kVwOAc
         si5xwWiMv3WvhgHyozCFDfLGQnu7aJC+o6mzsYrp+TxereHdapR+ZW4ElcURK48tKO
         GUGGG2/k9zxD1qhiAfs60slO9nVk7mdND4eCsx+aXT/VvOYtsG8Va49mGCaFlkZiPq
         QMFaPd1BXEOUZrD0B7yqSA76RkEGIXr7U8BpA+8aR+aVZkq6zAQOMQy4NeA3a+/KdC
         Avc8OWbS/e8gw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] cpufreq: remove tango driver
Date:   Wed, 20 Jan 2021 14:16:44 +0100
Message-Id: <20210120131709.1996711-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The tango platform is getting removed, so the driver is no
longer needed.

Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc: Mans Rullgard <mans@mansr.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cpufreq/Kconfig.arm     |  5 -----
 drivers/cpufreq/Makefile        |  1 -
 drivers/cpufreq/tango-cpufreq.c | 38 ---------------------------------
 3 files changed, 44 deletions(-)
 delete mode 100644 drivers/cpufreq/tango-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 1f73fa75b1a0..e65e0a43be64 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -289,11 +289,6 @@ config ARM_STI_CPUFREQ
 	  this config option if you wish to add CPUFreq support for STi based
 	  SoCs.
 
-config ARM_TANGO_CPUFREQ
-	bool
-	depends on CPUFREQ_DT && ARCH_TANGO
-	default y
-
 config ARM_TEGRA20_CPUFREQ
 	tristate "Tegra20/30 CPUFreq support"
 	depends on ARCH_TEGRA && CPUFREQ_DT
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index f1b7e3dd6e5d..1ab9b1536304 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -79,7 +79,6 @@ obj-$(CONFIG_ARM_SCPI_CPUFREQ)		+= scpi-cpufreq.o
 obj-$(CONFIG_ARM_SPEAR_CPUFREQ)		+= spear-cpufreq.o
 obj-$(CONFIG_ARM_STI_CPUFREQ)		+= sti-cpufreq.o
 obj-$(CONFIG_ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM) += sun50i-cpufreq-nvmem.o
-obj-$(CONFIG_ARM_TANGO_CPUFREQ)		+= tango-cpufreq.o
 obj-$(CONFIG_ARM_TEGRA20_CPUFREQ)	+= tegra20-cpufreq.o
 obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)	+= tegra124-cpufreq.o
 obj-$(CONFIG_ARM_TEGRA186_CPUFREQ)	+= tegra186-cpufreq.o
diff --git a/drivers/cpufreq/tango-cpufreq.c b/drivers/cpufreq/tango-cpufreq.c
deleted file mode 100644
index 89a7f860bfe8..000000000000
--- a/drivers/cpufreq/tango-cpufreq.c
+++ /dev/null
@@ -1,38 +0,0 @@
-#include <linux/of.h>
-#include <linux/cpu.h>
-#include <linux/clk.h>
-#include <linux/pm_opp.h>
-#include <linux/platform_device.h>
-
-static const struct of_device_id machines[] __initconst = {
-	{ .compatible = "sigma,tango4" },
-	{ /* sentinel */ }
-};
-
-static int __init tango_cpufreq_init(void)
-{
-	struct device *cpu_dev = get_cpu_device(0);
-	unsigned long max_freq;
-	struct clk *cpu_clk;
-	void *res;
-
-	if (!of_match_node(machines, of_root))
-		return -ENODEV;
-
-	cpu_clk = clk_get(cpu_dev, NULL);
-	if (IS_ERR(cpu_clk))
-		return -ENODEV;
-
-	max_freq = clk_get_rate(cpu_clk);
-
-	dev_pm_opp_add(cpu_dev, max_freq / 1, 0);
-	dev_pm_opp_add(cpu_dev, max_freq / 2, 0);
-	dev_pm_opp_add(cpu_dev, max_freq / 3, 0);
-	dev_pm_opp_add(cpu_dev, max_freq / 5, 0);
-	dev_pm_opp_add(cpu_dev, max_freq / 9, 0);
-
-	res = platform_device_register_data(NULL, "cpufreq-dt", -1, NULL, 0);
-
-	return PTR_ERR_OR_ZERO(res);
-}
-device_initcall(tango_cpufreq_init);
-- 
2.29.2

