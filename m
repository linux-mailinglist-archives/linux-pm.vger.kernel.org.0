Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0831132CC6D
	for <lists+linux-pm@lfdr.de>; Thu,  4 Mar 2021 07:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbhCDGKC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Mar 2021 01:10:02 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2990 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbhCDGJh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Mar 2021 01:09:37 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B604079540001>; Wed, 03 Mar 2021 22:08:20 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 4 Mar
 2021 06:08:18 +0000
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 4 Mar 2021 06:08:19 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <daniel.lezcano@linaro.org>,
        <robh+dt@kernel.org>
CC:     <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v1 4/5] cpuidle: Add Tegra194 cpuidle driver
Date:   Wed, 3 Mar 2021 22:08:11 -0800
Message-ID: <1614838092-30398-5-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614838092-30398-1-git-send-email-skomatineni@nvidia.com>
References: <1614838092-30398-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614838100; bh=0pJEP6jipLYvv6sFAICyxbzrST6NiET4EpYzd0/C6LI=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=BBZ5qWoUshnDmW9wQt64U6agB1kKABpctK/uoHFjtBAetyOgIFGdK2yZFazxEODw9
         XtFvVNGIu73PxF/8DzhQDKGBRdz3/ux5QjF4e2IHyue/5xt0/6wFoDSaB14zfrXLnj
         R45x2lObcErWgMGdZfTrdVy1znKDdVpA0cICYElxpOLFhFKOxO75INyaiUAdWSNlx+
         ZjG5xuPSZ19pYdGAJJHWjSkrJhYdzaobyoGIdUPX4PWelCDPRd2UzTrsd8Xs2lOeUo
         Tgp3gQGyoU+COWXS4tENmQJgLuS5wKBhrVtHWcQKGJlmVXSzZ+X43mr2Bvpa+CpR03
         InslMDnEATnAg==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds cpuidle driver for Tegra194.

Tegra194 Carmel CPU supports two core idle state C1 (clock gated)
and C6 (power gated with state restoration) and one cluster idle
state CC6 (power gated).

MCE firmware makes decision on core/cluster power state transition
based on its background tasks and states information provided by
CPU idle driver.

CPU idle driver provides deepest cluster power state, core power
state transition request, estimated time of next wake-up and states
crossover thresholds to MCE firmware through Tegra mce driver.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/cpuidle/Kconfig.arm        |  10 ++
 drivers/cpuidle/Makefile           |   1 +
 drivers/cpuidle/cpuidle-tegra194.c | 319 +++++++++++++++++++++++++++++++++++++
 3 files changed, 330 insertions(+)
 create mode 100644 drivers/cpuidle/cpuidle-tegra194.c

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 0844fad..e9adad1 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -105,6 +105,16 @@ config ARM_TEGRA_CPUIDLE
 	help
 	  Select this to enable cpuidle for NVIDIA Tegra20/30/114/124 SoCs.
 
+config ARM_TEGRA194_CPUIDLE
+	tristate "CPU Idle Driver for NVIDIA Tegra194 SoC"
+	depends on ARCH_TEGRA_194_SOC
+	select ARM_CPU_SUSPEND
+	select DT_IDLE_STATES
+	select TEGRA_MCE
+	default y
+	help
+	  Select this to enable cpuidle for NVIDIA Tegra194 SoC.
+
 config ARM_QCOM_SPM_CPUIDLE
 	bool "CPU Idle Driver for Qualcomm Subsystem Power Manager (SPM)"
 	depends on (ARCH_QCOM || COMPILE_TEST) && !ARM64
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 26bbc5e..4d89578 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_ARM_CPUIDLE)		+= cpuidle-arm.o
 obj-$(CONFIG_ARM_PSCI_CPUIDLE)		+= cpuidle-psci.o
 obj-$(CONFIG_ARM_PSCI_CPUIDLE_DOMAIN)	+= cpuidle-psci-domain.o
 obj-$(CONFIG_ARM_TEGRA_CPUIDLE)		+= cpuidle-tegra.o
+obj-$(CONFIG_ARM_TEGRA194_CPUIDLE)      += cpuidle-tegra194.o
 obj-$(CONFIG_ARM_QCOM_SPM_CPUIDLE)	+= cpuidle-qcom-spm.o
 
 ###############################################################################
diff --git a/drivers/cpuidle/cpuidle-tegra194.c b/drivers/cpuidle/cpuidle-tegra194.c
new file mode 100644
index 0000000..4ae67ce
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-tegra194.c
@@ -0,0 +1,319 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * CPU idle driver for Tegra194 CPUs
+ *
+ * Copyright (c) 2020-2021, NVIDIA Corporation.
+ */
+
+#include <asm/arch_timer.h>
+#include <asm/cpu.h>
+#include <asm/cpuidle.h>
+#include <asm/cputype.h>
+#include <asm/suspend.h>
+
+#include <linux/cpuhotplug.h>
+#include <linux/cpuidle.h>
+#include <linux/cpu_pm.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/psci.h>
+#include <linux/suspend.h>
+
+#include <soc/tegra/mce.h>
+#include <soc/tegra/t194_nvg.h>
+
+#include "cpuidle-psci.h"
+#include "dt_idle_states.h"
+
+#define T194_NVG_CROSSOVER_C6		TEGRA_NVG_CHANNEL_CROSSOVER_C6_LOWER_BOUND
+#define T194_NVG_CROSSOVER_CC6		TEGRA_NVG_CHANNEL_CROSSOVER_CC6_LOWER_BOUND
+
+#define PSCI_PSTATE_ID_MASK		0xf
+#define PSCI_PSTATE_WKTIM_MASK		0x0ffffff0
+#define PSCI_PSTATE_WKTIM_SHIFT		4
+
+/*
+ * BG_TIME is margin added to target_residency so that actual HW has better
+ * chance entering deep idle state instead of getting back to shallower one.
+ * Units in us.
+ */
+#define BG_TIME				2000
+
+static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
+
+static struct cpuidle_driver t194_cpu_idle_driver;
+static enum cpuhp_state hp_state;
+static u32 deepest_cc_state;
+static u32 tsc_per_usec;
+
+static bool check_mce_version(void)
+{
+	u32 mce_version_major, mce_version_minor;
+	int err;
+
+	err = tegra_mce_read_versions(&mce_version_major, &mce_version_minor);
+	if (!err && mce_version_major >= TEGRA_NVG_VERSION_MAJOR)
+		return true;
+	else
+		return false;
+}
+
+static int
+t194_cpu_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv, int index)
+{
+	u32 *state = __this_cpu_read(psci_power_state);
+	u32 power_state = state[index];
+	u32 wake_time;
+	int ret;
+
+	/*
+	 * MCE firmware does the state transition based on requested idle state,
+	 * state crossover thresholds and target residency time along with its
+	 * background work.
+	 * Pass the state target_residency time along with state ID to MCE
+	 * firmware through PSCI power-state value.
+	 *
+	 * LSB 8 bits of wake time is lost and only 24 MSB bits of wake time can fit
+	 * into additional bits of state value.
+	 */
+	wake_time = (drv->states[index].target_residency + BG_TIME) * tsc_per_usec;
+	power_state |= ((wake_time >> PSCI_PSTATE_WKTIM_SHIFT) & PSCI_PSTATE_WKTIM_MASK);
+
+	if ((power_state & PSCI_PSTATE_ID_MASK) == TEGRA_NVG_CORE_C6)
+		ret = CPU_PM_CPU_IDLE_ENTER_RETENTION_PARAM(psci_cpu_suspend_enter, index,
+							    power_state);
+	else
+		ret = CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter, index, power_state);
+
+	return ret;
+}
+
+static struct cpuidle_driver t194_cpu_idle_driver = {
+	.name = "tegra194_cpuidle_driver",
+	.owner = THIS_MODULE,
+	.states[0] = {
+		.enter			= t194_cpu_enter_state,
+		.exit_latency		= 1,
+		.target_residency	= 1,
+		.power_usage		= UINT_MAX,
+		.flags			= 0,
+		.name			= "c1",
+		.desc			= "CPU clock gated",
+	}
+};
+
+static const struct of_device_id t194_cpuidle_of_match[] = {
+	{ .compatible = "nvidia,tegra194-cpuidle-core", .data = t194_cpu_enter_state },
+	{ },
+};
+
+struct xover_table {
+	char *name;
+	int index;
+};
+
+static void send_crossover(void *data)
+{
+	struct device_node *of_states = (struct device_node *)data;
+	struct device_node *child;
+	u32 value;
+	int i;
+
+	struct xover_table table1[] = {
+		{"crossover_c1_c6", T194_NVG_CROSSOVER_C6},
+		{"crossover_cc1_cc6", T194_NVG_CROSSOVER_CC6},
+	};
+
+	/* pass the state crossover thresholds to MCE firmware */
+	for_each_child_of_node(of_states, child)
+		for (i = 0; i < ARRAY_SIZE(table1); i++) {
+			if (of_property_read_u32(child, table1[i].name, &value) == 0)
+				tegra_mce_update_crossover_time(table1[i].index,
+								value * tsc_per_usec);
+	}
+}
+
+static int crossover_init(struct device_node *cpunode)
+{
+	struct device_node *cpu_xover;
+
+	cpu_xover = of_get_child_by_name(cpunode, "cpu_crossover_thresholds");
+	if (!cpu_xover)
+		pr_warn("cpuidle: %s: missing crossover thresholds in dt\n", __func__);
+	else
+		on_each_cpu_mask(cpu_online_mask, send_crossover, cpu_xover, 1);
+
+	return 0;
+}
+
+static void program_cc_state(void *data)
+{
+	u32 *cc_state = (u32 *)data;
+
+	tegra_mce_update_cstate_info(*cc_state, 0, 0, 0, 0, 0);
+}
+
+static int
+tegra_suspend_notify_callback(struct notifier_block *nb, unsigned long action, void *pcpu)
+{
+	switch (action) {
+	case PM_POST_SUSPEND:
+	/*
+	 * Re-program deepest allowed cluster and cluster group power state
+	 * after system resumes from SC7
+	 */
+		on_each_cpu_mask(cpu_online_mask, program_cc_state, &deepest_cc_state, 1);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block suspend_notifier = {
+	.notifier_call = tegra_suspend_notify_callback,
+};
+
+static int tegra_cpu_online(unsigned int cpu)
+{
+	/*
+	 * Program deepest allowed cluster and cluster group power state
+	 * after a core in that cluster is onlined.
+	 */
+	smp_call_function_single(cpu, program_cc_state, &deepest_cc_state, 1);
+
+	return 0;
+}
+
+static int tegra_cpuidle_psci_dt_init(struct device *dev, struct cpuidle_driver *drv)
+{
+	unsigned int state_count = drv->state_count;
+	struct device_node *cpu_node, *state_node;
+	int i, cpu, state_idx = 1, ret = 0;
+	u32 *psci_states;
+
+	psci_states = devm_kcalloc(dev, state_count, sizeof(*psci_states), GFP_KERNEL);
+	if (!psci_states)
+		return -ENOMEM;
+
+	cpu_node = of_cpu_device_node_get(cpumask_first(drv->cpumask));
+	for (i = 1; ; i++) {
+		state_node = of_get_cpu_state_node(cpu_node, i - 1);
+		if (!state_node)
+			break;
+
+		if (!of_device_is_available(state_node)) {
+			of_node_put(state_node);
+			continue;
+		}
+
+		ret = psci_dt_parse_state_node(state_node, &psci_states[state_idx++]);
+		of_node_put(state_node);
+		if (ret)
+			goto put_cpunode;
+	}
+
+	of_node_put(cpu_node);
+
+	for_each_online_cpu(cpu)
+		per_cpu(psci_power_state, cpu) = psci_states;
+
+	return 0;
+
+put_cpunode:
+	of_node_put(cpu_node);
+	return ret;
+}
+
+static int __init tegra194_cpuidle_probe(struct platform_device *pdev)
+{
+	struct cpumask *cpumask;
+	int cpu, ret;
+
+	if (!check_mce_version()) {
+		pr_err("cpuidle: incompatible MCE version, cannot register driver\n");
+		return -ENODEV;
+	}
+
+	tsc_per_usec = arch_timer_get_cntfrq() / 1000000;
+
+	cpumask = devm_kzalloc(&pdev->dev, cpumask_size(), GFP_KERNEL);
+	for_each_online_cpu(cpu)
+		cpumask_set_cpu(cpu, cpumask);
+	t194_cpu_idle_driver.cpumask = cpumask;
+
+	/*
+	 * CCPLEX MCE firmware does core/cluster state transitions based on idle
+	 * thresholds along with requested state and target residency time.
+	 * So, state idle time crossover thresholds should be provided to MCE
+	 * firmware.
+	 */
+	crossover_init(pdev->dev.of_node);
+
+	ret = of_property_read_u32(pdev->dev.of_node,
+				   "cluster-deepest-power-state", &deepest_cc_state);
+	on_each_cpu_mask(cpu_online_mask, program_cc_state, &deepest_cc_state, 1);
+
+	ret = dt_init_idle_driver(&t194_cpu_idle_driver, t194_cpuidle_of_match, 1);
+	if (ret <= 0) {
+		pr_err("cpuidle: failed to init idle driver states\n");
+		ret = -ENODEV;
+		goto probe_exit;
+	}
+
+	/* initialize cpuidle states psci power-state from DT */
+	ret = tegra_cpuidle_psci_dt_init(&pdev->dev, &t194_cpu_idle_driver);
+	if (ret)
+		goto probe_exit;
+
+	ret = cpuidle_register(&t194_cpu_idle_driver, NULL);
+	if (ret) {
+		pr_err("cpuidle: failed to register cpuidle driver\n");
+		goto probe_exit;
+	}
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "tegra_cpu:online", tegra_cpu_online, NULL);
+	if (ret < 0) {
+		pr_err("cpuidle: failed to setup cpu hotplug state callbacks\n");
+		goto cpuhp_error;
+	}
+
+	hp_state = ret;
+
+	register_pm_notifier(&suspend_notifier);
+
+	return 0;
+
+cpuhp_error:
+	cpuidle_unregister(&t194_cpu_idle_driver);
+probe_exit:
+	return ret;
+}
+
+static int tegra194_cpuidle_remove(struct platform_device *pdev)
+{
+	unregister_pm_notifier(&suspend_notifier);
+	cpuhp_remove_state(hp_state);
+	cpuidle_unregister(&t194_cpu_idle_driver);
+	kfree(t194_cpu_idle_driver.cpumask);
+
+	return 0;
+}
+
+static const struct of_device_id tegra194_cpuidle_of_match[] = {
+	{ .compatible = "nvidia,tegra194-ccplex" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver tegra194_cpuidle_driver __refdata = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "cpuidle-tegra194",
+		.of_match_table = of_match_ptr(tegra194_cpuidle_of_match),
+	},
+	.probe	= tegra194_cpuidle_probe,
+	.remove	= tegra194_cpuidle_remove,
+};
+
+module_platform_driver(tegra194_cpuidle_driver);
-- 
2.7.4

