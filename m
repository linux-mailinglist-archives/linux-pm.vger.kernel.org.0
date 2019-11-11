Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDB3CF7A9A
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 19:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfKKSQP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 13:16:15 -0500
Received: from inva020.nxp.com ([92.121.34.13]:56290 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbfKKSQO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 Nov 2019 13:16:14 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2E5BB1A0232;
        Mon, 11 Nov 2019 19:16:13 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1F6641A0657;
        Mon, 11 Nov 2019 19:16:13 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id B5F8B205FE;
        Mon, 11 Nov 2019 19:16:12 +0100 (CET)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org
Subject: [PATCH] PM / devfreq: Kconfig: Drop explicit selection of PM_OPP
Date:   Mon, 11 Nov 2019 20:16:10 +0200
Message-Id: <1fb316f5b2c4d36437a536cef46ce8e4567dee15.1573495711.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

CONFIG_PM_OPP is already selected by CONFIG_PM_DEVFREQ since
commit b9c69e043266 ("PM / devfreq: Add dependency on PM_OPP")

This means that individual drivers shouldn't "select PM_OPP" explicitly.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

---
Spawned by review comments on a new driver:
https://patchwork.kernel.org/patch/11235695/#22992159

This patch shouldn't have any dependencies.

 drivers/devfreq/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index defe1d438710..066e6c4efaa2 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -81,11 +81,10 @@ config ARM_EXYNOS_BUS_DEVFREQ
 	depends on ARCH_EXYNOS || COMPILE_TEST
 	select DEVFREQ_GOV_SIMPLE_ONDEMAND
 	select DEVFREQ_GOV_PASSIVE
 	select DEVFREQ_EVENT_EXYNOS_PPMU
 	select PM_DEVFREQ_EVENT
-	select PM_OPP
 	help
 	  This adds the common DEVFREQ driver for Exynos Memory bus. Exynos
 	  Memory bus has one more group of memory bus (e.g, MIF and INT block).
 	  Each memory bus group could contain many memoby bus block. It reads
 	  PPMU counters of memory controllers by using DEVFREQ-event device
@@ -96,22 +95,20 @@ config ARM_TEGRA_DEVFREQ
 	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"
 	depends on ARCH_TEGRA_3x_SOC || ARCH_TEGRA_114_SOC || \
 		ARCH_TEGRA_132_SOC || ARCH_TEGRA_124_SOC || \
 		ARCH_TEGRA_210_SOC || \
 		COMPILE_TEST
-	select PM_OPP
 	help
 	  This adds the DEVFREQ driver for the Tegra family of SoCs.
 	  It reads ACTMON counters of memory controllers and adjusts the
 	  operating frequencies and voltages with OPP support.
 
 config ARM_TEGRA20_DEVFREQ
 	tristate "NVIDIA Tegra20 DEVFREQ Driver"
 	depends on (TEGRA_MC && TEGRA20_EMC) || COMPILE_TEST
 	depends on COMMON_CLK
 	select DEVFREQ_GOV_SIMPLE_ONDEMAND
-	select PM_OPP
 	help
 	  This adds the DEVFREQ driver for the Tegra20 family of SoCs.
 	  It reads Memory Controller counters and adjusts the operating
 	  frequencies and voltages with OPP support.
 
@@ -119,11 +116,10 @@ config ARM_RK3399_DMC_DEVFREQ
 	tristate "ARM RK3399 DMC DEVFREQ Driver"
 	depends on ARCH_ROCKCHIP
 	select DEVFREQ_EVENT_ROCKCHIP_DFI
 	select DEVFREQ_GOV_SIMPLE_ONDEMAND
 	select PM_DEVFREQ_EVENT
-	select PM_OPP
 	help
           This adds the DEVFREQ driver for the RK3399 DMC(Dynamic Memory Controller).
           It sets the frequency for the memory controller and reads the usage counts
           from hardware.
 
-- 
2.17.1

