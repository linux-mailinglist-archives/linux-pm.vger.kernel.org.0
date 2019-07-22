Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37916703EB
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2019 17:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbfGVPiB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 11:38:01 -0400
Received: from foss.arm.com ([217.140.110.172]:39784 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729472AbfGVPiA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Jul 2019 11:38:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2D381509;
        Mon, 22 Jul 2019 08:37:59 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83A453F694;
        Mon, 22 Jul 2019 08:37:58 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pm@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        LAKML <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 5/6] ARM: psci: cpuidle: Enable PSCI CPUidle driver
Date:   Mon, 22 Jul 2019 16:37:44 +0100
Message-Id: <20190722153745.32446-6-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722153745.32446-1-lorenzo.pieralisi@arm.com>
References: <20190722153745.32446-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Allow selection of the PSCI CPUidle in the kernel by adding
the required Kconfig options.

Remove PSCI callbacks from ARM/ARM64 generic CPU ops
to prevent the PSCI idle driver from clashing with the generic
ARM CPUidle driver initialization, that relies on CPU ops
to initialize and enter idle states.

Update the affected defconfig files to guarantee seamingless
transition from the generic ARM CPUidle to the PSCI CPUidle
driver on arch/platforms using it.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 arch/arm64/configs/defconfig         | 1 +
 arch/arm64/kernel/cpuidle.c          | 7 ++++---
 arch/arm64/kernel/psci.c             | 4 ----
 drivers/cpuidle/Kconfig.arm          | 8 ++++++--
 drivers/firmware/psci/psci.c         | 9 ---------
 6 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index a53b29251ed4..4174fd1b79e7 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -60,6 +60,7 @@ CONFIG_ARM_IMX6Q_CPUFREQ=y
 CONFIG_ARM_IMX_CPUFREQ_DT=y
 CONFIG_CPU_IDLE=y
 CONFIG_ARM_CPUIDLE=y
+CONFIG_ARM_PSCI_CPUIDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_PM_DEBUG=y
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0e58ef02880c..c0a7cfe3aebd 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -72,6 +72,7 @@ CONFIG_RANDOMIZE_BASE=y
 CONFIG_HIBERNATION=y
 CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
 CONFIG_ARM_CPUIDLE=y
+CONFIG_ARM_PSCI_CPUIDLE=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_STAT=y
 CONFIG_CPU_FREQ_GOV_POWERSAVE=m
diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
index d1048173fd8a..4bcd1bca0dfc 100644
--- a/arch/arm64/kernel/cpuidle.c
+++ b/arch/arm64/kernel/cpuidle.c
@@ -11,6 +11,7 @@
 #include <linux/cpu_pm.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/psci.h>
 
 #include <asm/cpuidle.h>
 #include <asm/cpu_ops.h>
@@ -48,15 +49,15 @@ int arm_cpuidle_suspend(int index)
 
 int acpi_processor_ffh_lpi_probe(unsigned int cpu)
 {
-	return arm_cpuidle_init(cpu);
+	return psci_acpi_cpu_init_idle(cpu);
 }
 
 int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
 {
 	if (ARM64_LPI_IS_RETENTION_STATE(lpi->arch_flags))
-		return CPU_PM_CPU_IDLE_ENTER_RETENTION(arm_cpuidle_suspend,
+		return CPU_PM_CPU_IDLE_ENTER_RETENTION(psci_cpu_suspend_enter,
 						lpi->index);
 	else
-		return CPU_PM_CPU_IDLE_ENTER(arm_cpuidle_suspend, lpi->index);
+		return CPU_PM_CPU_IDLE_ENTER(psci_cpu_suspend_enter, lpi->index);
 }
 #endif
diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 85ee7d07889e..a543ab7e007c 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -105,10 +105,6 @@ static int cpu_psci_cpu_kill(unsigned int cpu)
 
 const struct cpu_operations cpu_psci_ops = {
 	.name		= "psci",
-#ifdef CONFIG_CPU_IDLE
-	.cpu_init_idle	= psci_cpu_init_idle,
-	.cpu_suspend	= psci_cpu_suspend_enter,
-#endif
 	.cpu_init	= cpu_psci_cpu_init,
 	.cpu_prepare	= cpu_psci_cpu_prepare,
 	.cpu_boot	= cpu_psci_cpu_boot,
diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 929b57424ea4..b9c56c60ab98 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -14,8 +14,12 @@ config ARM_CPUIDLE
           provided by architecture code.
 
 config ARM_PSCI_CPUIDLE
-	bool
-
+	bool "PSCI CPU idle Driver"
+	depends on ARM_PSCI_FW
+	select DT_IDLE_STATES
+	select CPU_IDLE_MULTIPLE_DRIVERS
+	help
+	  Select this to enable PSCI firmware based CPUidle driver for ARM.
 config ARM_BIG_LITTLE_CPUIDLE
 	bool "Support for ARM big.LITTLE processors"
 	depends on ARCH_VEXPRESS_TC2_PM || ARCH_EXYNOS
diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index f82ccd39a913..bae734d13a52 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -436,15 +436,6 @@ int psci_cpu_suspend_enter(unsigned long index)
 
 	return ret;
 }
-
-/* ARM specific CPU idle operations */
-#ifdef CONFIG_ARM
-static const struct cpuidle_ops psci_cpuidle_ops __initconst = {
-	.suspend = psci_cpu_suspend_enter,
-	.init = psci_dt_cpu_init_idle,
-};
-
-CPUIDLE_METHOD_OF_DECLARE(psci, "psci", &psci_cpuidle_ops);
 #endif
 #endif
 
-- 
2.21.0

