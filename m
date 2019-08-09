Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5885A87823
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 13:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbfHILDq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 07:03:46 -0400
Received: from foss.arm.com ([217.140.110.172]:45586 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406470AbfHILDa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Aug 2019 07:03:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B61B11596;
        Fri,  9 Aug 2019 04:03:29 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C0293F575;
        Fri,  9 Aug 2019 04:03:28 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pm@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Shawn Guo <shawnguo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LAKML <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 5/8] ARM: psci: cpuidle: Enable PSCI CPUidle driver
Date:   Fri,  9 Aug 2019 12:03:11 +0100
Message-Id: <f9eb301af9ac8a6022b3efbe89e9f7579234f3f2.1565348376.git.lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1565348376.git.lorenzo.pieralisi@arm.com>
References: <20190722153745.32446-1-lorenzo.pieralisi@arm.com> <cover.1565348376.git.lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Allow selection of the PSCI CPUidle in the kernel by updating
the respective Kconfig entry.

Remove PSCI callbacks from ARM/ARM64 generic CPU ops
to prevent the PSCI idle driver from clashing with the generic
ARM CPUidle driver initialization, that relies on CPU ops
to initialize and enter idle states.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Will Deacon <will@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 arch/arm64/kernel/cpuidle.c  |  7 ++++---
 arch/arm64/kernel/psci.c     |  4 ----
 drivers/cpuidle/Kconfig.arm  |  2 +-
 drivers/firmware/psci/psci.c | 10 ----------
 4 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
index d1048173fd8a..619e0ebb8399 100644
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
+	return psci_cpu_init_idle(cpu);
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
index eb014aa5ce6b..d8530475493c 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -14,7 +14,7 @@ config ARM_CPUIDLE
           provided by architecture code.
 
 config ARM_PSCI_CPUIDLE
-	bool
+	bool "PSCI CPU idle Driver"
 	depends on ARM_PSCI_FW
 	select DT_IDLE_STATES
 	select CPU_IDLE_MULTIPLE_DRIVERS
diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index f82ccd39a913..b343f8a34c6a 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -436,16 +436,6 @@ int psci_cpu_suspend_enter(unsigned long index)
 
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
-#endif
 #endif
 
 static int psci_system_suspend(unsigned long unused)
-- 
2.21.0

