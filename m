Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2213A2C5C36
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 19:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405085AbgKZSzI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 13:55:08 -0500
Received: from relay08.th.seeweb.it ([5.144.164.169]:53471 "EHLO
        relay08.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405038AbgKZSzB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2020 13:55:01 -0500
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 2348A405F5;
        Thu, 26 Nov 2020 19:46:33 +0100 (CET)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, ulf.hansson@linaro.org,
        jorge.ramirez-ortiz@linaro.org, broonie@kernel.org,
        lgirdwood@gmail.com, daniel.lezcano@linaro.org, nks@flawful.org,
        bjorn.andersson@linaro.org, agross@kernel.org, robh+dt@kernel.org,
        viresh.kumar@linaro.org, rjw@rjwysocki.net,
        konrad.dybcio@somainline.org, martin.botka@somainline.org,
        marijn.suijten@somainline.org, phone-devel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH 01/13] cpuidle: qcom_spm: Detach state machine from main SPM handling
Date:   Thu, 26 Nov 2020 19:45:47 +0100
Message-Id: <20201126184559.3052375-2-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126184559.3052375-1-angelogioacchino.delregno@somainline.org>
References: <20201126184559.3052375-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In commit a871be6b8eee the SPM driver has been converted to a
generic CPUidle driver: that was mainly made to simplify the
driver and that was a great accomplishment;
Though, it was ignored that the SPM driver is not used only
on the ARM architecture.

In preparation for the enablement of SPM features on AArch64/ARM64,
split the cpuidle-qcom-spm driver in two: the CPUIdle related
state machine (currently used only on ARM SoCs) stays there, while
the SPM communication handling lands back in soc/qcom/spm.c and
also making sure to not discard the simplifications that were
introduced in the aforementioned commit.

Since now the "two drivers" are split, the SCM dependency in the
main SPM handling is gone and for this reason it was also possible
to move the SPM initialization early: this will also make sure that
whenever the SAW CPUIdle driver is getting initialized, the SPM
driver will be ready to do the job.

Please note that the anticipation of the SPM initialization was
also done to optimize the boot times on platforms that have their
CPU/L2 idle states managed by other means (such as PSCI), while
needing SAW initialization for other purposes, like AVS control.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 drivers/cpuidle/Kconfig.arm        |   1 +
 drivers/cpuidle/cpuidle-qcom-spm.c | 294 ++++++-----------------------
 drivers/soc/qcom/Kconfig           |   9 +
 drivers/soc/qcom/Makefile          |   1 +
 drivers/soc/qcom/spm.c             | 198 +++++++++++++++++++
 include/soc/qcom/spm.h             |  45 +++++
 6 files changed, 312 insertions(+), 236 deletions(-)
 create mode 100644 drivers/soc/qcom/spm.c
 create mode 100644 include/soc/qcom/spm.h

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 0844fadc4be8..c5e2f4d0df04 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -112,6 +112,7 @@ config ARM_QCOM_SPM_CPUIDLE
 	select CPU_IDLE_MULTIPLE_DRIVERS
 	select DT_IDLE_STATES
 	select QCOM_SCM
+	select QCOM_SPM
 	help
 	  Select this to enable cpuidle for Qualcomm processors.
 	  The Subsystem Power Manager (SPM) controls low power modes for the
diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
index adf91a6e4d7d..3dd7bb10b82d 100644
--- a/drivers/cpuidle/cpuidle-qcom-spm.c
+++ b/drivers/cpuidle/cpuidle-qcom-spm.c
@@ -18,146 +18,13 @@
 #include <linux/cpuidle.h>
 #include <linux/cpu_pm.h>
 #include <linux/qcom_scm.h>
+#include <soc/qcom/spm.h>
 
 #include <asm/proc-fns.h>
 #include <asm/suspend.h>
 
 #include "dt_idle_states.h"
 
-#define MAX_PMIC_DATA		2
-#define MAX_SEQ_DATA		64
-#define SPM_CTL_INDEX		0x7f
-#define SPM_CTL_INDEX_SHIFT	4
-#define SPM_CTL_EN		BIT(0)
-
-enum pm_sleep_mode {
-	PM_SLEEP_MODE_STBY,
-	PM_SLEEP_MODE_RET,
-	PM_SLEEP_MODE_SPC,
-	PM_SLEEP_MODE_PC,
-	PM_SLEEP_MODE_NR,
-};
-
-enum spm_reg {
-	SPM_REG_CFG,
-	SPM_REG_SPM_CTL,
-	SPM_REG_DLY,
-	SPM_REG_PMIC_DLY,
-	SPM_REG_PMIC_DATA_0,
-	SPM_REG_PMIC_DATA_1,
-	SPM_REG_VCTL,
-	SPM_REG_SEQ_ENTRY,
-	SPM_REG_SPM_STS,
-	SPM_REG_PMIC_STS,
-	SPM_REG_NR,
-};
-
-struct spm_reg_data {
-	const u8 *reg_offset;
-	u32 spm_cfg;
-	u32 spm_dly;
-	u32 pmic_dly;
-	u32 pmic_data[MAX_PMIC_DATA];
-	u8 seq[MAX_SEQ_DATA];
-	u8 start_index[PM_SLEEP_MODE_NR];
-};
-
-struct spm_driver_data {
-	struct cpuidle_driver cpuidle_driver;
-	void __iomem *reg_base;
-	const struct spm_reg_data *reg_data;
-};
-
-static const u8 spm_reg_offset_v2_1[SPM_REG_NR] = {
-	[SPM_REG_CFG]		= 0x08,
-	[SPM_REG_SPM_CTL]	= 0x30,
-	[SPM_REG_DLY]		= 0x34,
-	[SPM_REG_SEQ_ENTRY]	= 0x80,
-};
-
-/* SPM register data for 8974, 8084 */
-static const struct spm_reg_data spm_reg_8974_8084_cpu  = {
-	.reg_offset = spm_reg_offset_v2_1,
-	.spm_cfg = 0x1,
-	.spm_dly = 0x3C102800,
-	.seq = { 0x03, 0x0B, 0x0F, 0x00, 0x20, 0x80, 0x10, 0xE8, 0x5B, 0x03,
-		0x3B, 0xE8, 0x5B, 0x82, 0x10, 0x0B, 0x30, 0x06, 0x26, 0x30,
-		0x0F },
-	.start_index[PM_SLEEP_MODE_STBY] = 0,
-	.start_index[PM_SLEEP_MODE_SPC] = 3,
-};
-
-static const u8 spm_reg_offset_v1_1[SPM_REG_NR] = {
-	[SPM_REG_CFG]		= 0x08,
-	[SPM_REG_SPM_CTL]	= 0x20,
-	[SPM_REG_PMIC_DLY]	= 0x24,
-	[SPM_REG_PMIC_DATA_0]	= 0x28,
-	[SPM_REG_PMIC_DATA_1]	= 0x2C,
-	[SPM_REG_SEQ_ENTRY]	= 0x80,
-};
-
-/* SPM register data for 8064 */
-static const struct spm_reg_data spm_reg_8064_cpu = {
-	.reg_offset = spm_reg_offset_v1_1,
-	.spm_cfg = 0x1F,
-	.pmic_dly = 0x02020004,
-	.pmic_data[0] = 0x0084009C,
-	.pmic_data[1] = 0x00A4001C,
-	.seq = { 0x03, 0x0F, 0x00, 0x24, 0x54, 0x10, 0x09, 0x03, 0x01,
-		0x10, 0x54, 0x30, 0x0C, 0x24, 0x30, 0x0F },
-	.start_index[PM_SLEEP_MODE_STBY] = 0,
-	.start_index[PM_SLEEP_MODE_SPC] = 2,
-};
-
-static inline void spm_register_write(struct spm_driver_data *drv,
-					enum spm_reg reg, u32 val)
-{
-	if (drv->reg_data->reg_offset[reg])
-		writel_relaxed(val, drv->reg_base +
-				drv->reg_data->reg_offset[reg]);
-}
-
-/* Ensure a guaranteed write, before return */
-static inline void spm_register_write_sync(struct spm_driver_data *drv,
-					enum spm_reg reg, u32 val)
-{
-	u32 ret;
-
-	if (!drv->reg_data->reg_offset[reg])
-		return;
-
-	do {
-		writel_relaxed(val, drv->reg_base +
-				drv->reg_data->reg_offset[reg]);
-		ret = readl_relaxed(drv->reg_base +
-				drv->reg_data->reg_offset[reg]);
-		if (ret == val)
-			break;
-		cpu_relax();
-	} while (1);
-}
-
-static inline u32 spm_register_read(struct spm_driver_data *drv,
-					enum spm_reg reg)
-{
-	return readl_relaxed(drv->reg_base + drv->reg_data->reg_offset[reg]);
-}
-
-static void spm_set_low_power_mode(struct spm_driver_data *drv,
-					enum pm_sleep_mode mode)
-{
-	u32 start_index;
-	u32 ctl_val;
-
-	start_index = drv->reg_data->start_index[mode];
-
-	ctl_val = spm_register_read(drv, SPM_REG_SPM_CTL);
-	ctl_val &= ~(SPM_CTL_INDEX << SPM_CTL_INDEX_SHIFT);
-	ctl_val |= start_index << SPM_CTL_INDEX_SHIFT;
-	ctl_val |= SPM_CTL_EN;
-	spm_register_write_sync(drv, SPM_REG_SPM_CTL, ctl_val);
-}
-
 static int qcom_pm_collapse(unsigned long int unused)
 {
 	qcom_scm_cpu_power_down(QCOM_SCM_CPU_PWR_DOWN_L2_ON);
@@ -213,132 +80,87 @@ static const struct of_device_id qcom_idle_state_match[] = {
 	{ },
 };
 
-static int spm_cpuidle_init(struct cpuidle_driver *drv, int cpu)
+static int spm_cpuidle_register(int cpu)
 {
+	struct platform_device *pdev = NULL;
+	struct spm_driver_data *spm = NULL;
+	struct device_node *cpu_node, *saw_node;
 	int ret;
 
-	memcpy(drv, &qcom_spm_idle_driver, sizeof(*drv));
-	drv->cpumask = (struct cpumask *)cpumask_of(cpu);
+	cpu_node = of_cpu_device_node_get(cpu);
+	if (!cpu_node)
+		return -ENODEV;
 
-	/* Parse idle states from device tree */
-	ret = dt_init_idle_driver(drv, qcom_idle_state_match, 1);
-	if (ret <= 0)
-		return ret ? : -ENODEV;
+	saw_node = of_parse_phandle(cpu_node, "qcom,saw", 0);
+	if (!saw_node)
+		return -ENODEV;
 
-	/* We have atleast one power down mode */
-	return qcom_scm_set_warm_boot_addr(cpu_resume_arm, drv->cpumask);
-}
+	pdev = of_find_device_by_node(saw_node);
+	of_node_put(saw_node);
+	of_node_put(cpu_node);
+	if (!pdev)
+		return -ENODEV;
 
-static struct spm_driver_data *spm_get_drv(struct platform_device *pdev,
-		int *spm_cpu)
-{
-	struct spm_driver_data *drv = NULL;
-	struct device_node *cpu_node, *saw_node;
-	int cpu;
-	bool found = 0;
+	spm = dev_get_drvdata(&pdev->dev);
+	if (!spm)
+		return -EINVAL;
 
-	for_each_possible_cpu(cpu) {
-		cpu_node = of_cpu_device_node_get(cpu);
-		if (!cpu_node)
-			continue;
-		saw_node = of_parse_phandle(cpu_node, "qcom,saw", 0);
-		found = (saw_node == pdev->dev.of_node);
-		of_node_put(saw_node);
-		of_node_put(cpu_node);
-		if (found)
-			break;
-	}
+	spm->cpuidle_driver = qcom_spm_idle_driver;
 
-	if (found) {
-		drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
-		if (drv)
-			*spm_cpu = cpu;
-	}
+	ret = dt_init_idle_driver(&spm->cpuidle_driver,
+				  qcom_idle_state_match, 1);
+	if (ret <= 0)
+		return ret ? : -ENODEV;
 
-	return drv;
-}
+	ret = qcom_scm_set_warm_boot_addr(cpu_resume_arm, cpumask_of(cpu));
+	if (ret)
+		return ret;
 
-static const struct of_device_id spm_match_table[] = {
-	{ .compatible = "qcom,msm8974-saw2-v2.1-cpu",
-	  .data = &spm_reg_8974_8084_cpu },
-	{ .compatible = "qcom,apq8084-saw2-v2.1-cpu",
-	  .data = &spm_reg_8974_8084_cpu },
-	{ .compatible = "qcom,apq8064-saw2-v1.1-cpu",
-	  .data = &spm_reg_8064_cpu },
-	{ },
-};
+	return cpuidle_register(&spm->cpuidle_driver, NULL);
+}
 
-static int spm_dev_probe(struct platform_device *pdev)
+static int spm_cpuidle_drv_probe(struct platform_device *pdev)
 {
-	struct spm_driver_data *drv;
-	struct resource *res;
-	const struct of_device_id *match_id;
-	void __iomem *addr;
 	int cpu, ret;
 
 	if (!qcom_scm_is_available())
 		return -EPROBE_DEFER;
 
-	drv = spm_get_drv(pdev, &cpu);
-	if (!drv)
-		return -EINVAL;
-	platform_set_drvdata(pdev, drv);
+	for_each_possible_cpu(cpu) {
+		ret = spm_cpuidle_register(cpu);
+		if (ret != -ENODEV) {
+			dev_err(&pdev->dev,
+				"Cannot register for CPU%d: %d\n", cpu, ret);
+			break;
+		}
+	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	drv->reg_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(drv->reg_base))
-		return PTR_ERR(drv->reg_base);
+	return ret;
+}
 
-	match_id = of_match_node(spm_match_table, pdev->dev.of_node);
-	if (!match_id)
-		return -ENODEV;
+static struct platform_driver spm_cpuidle_driver = {
+	.probe = spm_cpuidle_drv_probe,
+	.driver = {
+		.name = "qcom-spm-cpuidle",
+	},
+};
 
-	drv->reg_data = match_id->data;
+static int __init qcom_spm_cpuidle_init(void)
+{
+	struct platform_device *pdev;
+	int ret;
 
-	ret = spm_cpuidle_init(&drv->cpuidle_driver, cpu);
+	ret = platform_driver_register(&spm_cpuidle_driver);
 	if (ret)
 		return ret;
 
-	/* Write the SPM sequences first.. */
-	addr = drv->reg_base + drv->reg_data->reg_offset[SPM_REG_SEQ_ENTRY];
-	__iowrite32_copy(addr, drv->reg_data->seq,
-			ARRAY_SIZE(drv->reg_data->seq) / 4);
-
-	/*
-	 * ..and then the control registers.
-	 * On some SoC if the control registers are written first and if the
-	 * CPU was held in reset, the reset signal could trigger the SPM state
-	 * machine, before the sequences are completely written.
-	 */
-	spm_register_write(drv, SPM_REG_CFG, drv->reg_data->spm_cfg);
-	spm_register_write(drv, SPM_REG_DLY, drv->reg_data->spm_dly);
-	spm_register_write(drv, SPM_REG_PMIC_DLY, drv->reg_data->pmic_dly);
-	spm_register_write(drv, SPM_REG_PMIC_DATA_0,
-				drv->reg_data->pmic_data[0]);
-	spm_register_write(drv, SPM_REG_PMIC_DATA_1,
-				drv->reg_data->pmic_data[1]);
-
-	/* Set up Standby as the default low power mode */
-	spm_set_low_power_mode(drv, PM_SLEEP_MODE_STBY);
-
-	return cpuidle_register(&drv->cpuidle_driver, NULL);
-}
-
-static int spm_dev_remove(struct platform_device *pdev)
-{
-	struct spm_driver_data *drv = platform_get_drvdata(pdev);
+	pdev = platform_device_register_simple("qcom-spm-cpuidle",
+					       -1, NULL, 0);
+	if (IS_ERR(pdev)) {
+		platform_driver_unregister(&spm_cpuidle_driver);
+		return PTR_ERR(pdev);
+	}
 
-	cpuidle_unregister(&drv->cpuidle_driver);
 	return 0;
 }
-
-static struct platform_driver spm_driver = {
-	.probe = spm_dev_probe,
-	.remove = spm_dev_remove,
-	.driver = {
-		.name = "saw",
-		.of_match_table = spm_match_table,
-	},
-};
-
-builtin_platform_driver(spm_driver);
+device_initcall(qcom_spm_cpuidle_init);
diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 6a3b69b43ad5..37f22dcd20af 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -189,6 +189,15 @@ config QCOM_SOCINFO
 	 Say yes here to support the Qualcomm socinfo driver, providing
 	 information about the SoC to user space.
 
+config QCOM_SPM
+	tristate "Qualcomm Subsystem Power Manager (SPM)"
+	depends on ARCH_QCOM
+	select QCOM_SCM
+	help
+	  Enable the support for the Qualcomm Subsystem Power Manager, used
+	  to manage cores, L2 low power modes and to configure the internal
+	  Adaptive Voltage Scaler parameters, where supported.
+
 config QCOM_WCNSS_CTRL
 	tristate "Qualcomm WCNSS control driver"
 	depends on ARCH_QCOM || COMPILE_TEST
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index ad675a6593d0..24514c722832 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_QCOM_SMEM_STATE) += smem_state.o
 obj-$(CONFIG_QCOM_SMP2P)	+= smp2p.o
 obj-$(CONFIG_QCOM_SMSM)	+= smsm.o
 obj-$(CONFIG_QCOM_SOCINFO)	+= socinfo.o
+obj-$(CONFIG_QCOM_SPM)		+= spm.o
 obj-$(CONFIG_QCOM_WCNSS_CTRL) += wcnss_ctrl.o
 obj-$(CONFIG_QCOM_APR) += apr.o
 obj-$(CONFIG_QCOM_LLCC) += llcc-qcom.o
diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
new file mode 100644
index 000000000000..0c8aa9240c41
--- /dev/null
+++ b/drivers/soc/qcom/spm.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2011-2014, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2014,2015, Linaro Ltd.
+ *
+ * SAW power controller driver
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <soc/qcom/spm.h>
+
+#define SPM_CTL_INDEX		0x7f
+#define SPM_CTL_INDEX_SHIFT	4
+#define SPM_CTL_EN		BIT(0)
+
+enum spm_reg {
+	SPM_REG_CFG,
+	SPM_REG_SPM_CTL,
+	SPM_REG_DLY,
+	SPM_REG_PMIC_DLY,
+	SPM_REG_PMIC_DATA_0,
+	SPM_REG_PMIC_DATA_1,
+	SPM_REG_VCTL,
+	SPM_REG_SEQ_ENTRY,
+	SPM_REG_SPM_STS,
+	SPM_REG_PMIC_STS,
+	SPM_REG_NR,
+};
+
+static const u16 spm_reg_offset_v2_1[SPM_REG_NR] = {
+	[SPM_REG_CFG]		= 0x08,
+	[SPM_REG_SPM_CTL]	= 0x30,
+	[SPM_REG_DLY]		= 0x34,
+	[SPM_REG_SEQ_ENTRY]	= 0x80,
+};
+
+/* SPM register data for 8974, 8084 */
+static const struct spm_reg_data spm_reg_8974_8084_cpu  = {
+	.reg_offset = spm_reg_offset_v2_1,
+	.spm_cfg = 0x1,
+	.spm_dly = 0x3C102800,
+	.seq = { 0x03, 0x0B, 0x0F, 0x00, 0x20, 0x80, 0x10, 0xE8, 0x5B, 0x03,
+		0x3B, 0xE8, 0x5B, 0x82, 0x10, 0x0B, 0x30, 0x06, 0x26, 0x30,
+		0x0F },
+	.start_index[PM_SLEEP_MODE_STBY] = 0,
+	.start_index[PM_SLEEP_MODE_SPC] = 3,
+};
+
+static const u16 spm_reg_offset_v1_1[SPM_REG_NR] = {
+	[SPM_REG_CFG]		= 0x08,
+	[SPM_REG_SPM_CTL]	= 0x20,
+	[SPM_REG_PMIC_DLY]	= 0x24,
+	[SPM_REG_PMIC_DATA_0]	= 0x28,
+	[SPM_REG_PMIC_DATA_1]	= 0x2C,
+	[SPM_REG_SEQ_ENTRY]	= 0x80,
+};
+
+/* SPM register data for 8064 */
+static const struct spm_reg_data spm_reg_8064_cpu = {
+	.reg_offset = spm_reg_offset_v1_1,
+	.spm_cfg = 0x1F,
+	.pmic_dly = 0x02020004,
+	.pmic_data[0] = 0x0084009C,
+	.pmic_data[1] = 0x00A4001C,
+	.seq = { 0x03, 0x0F, 0x00, 0x24, 0x54, 0x10, 0x09, 0x03, 0x01,
+		0x10, 0x54, 0x30, 0x0C, 0x24, 0x30, 0x0F },
+	.start_index[PM_SLEEP_MODE_STBY] = 0,
+	.start_index[PM_SLEEP_MODE_SPC] = 2,
+};
+
+static inline void spm_register_write(struct spm_driver_data *drv,
+					enum spm_reg reg, u32 val)
+{
+	if (drv->reg_data->reg_offset[reg])
+		writel_relaxed(val, drv->reg_base +
+				drv->reg_data->reg_offset[reg]);
+}
+
+/* Ensure a guaranteed write, before return */
+static inline void spm_register_write_sync(struct spm_driver_data *drv,
+					enum spm_reg reg, u32 val)
+{
+	u32 ret;
+
+	if (!drv->reg_data->reg_offset[reg])
+		return;
+
+	do {
+		writel_relaxed(val, drv->reg_base +
+				drv->reg_data->reg_offset[reg]);
+		ret = readl_relaxed(drv->reg_base +
+				drv->reg_data->reg_offset[reg]);
+		if (ret == val)
+			break;
+		cpu_relax();
+	} while (1);
+}
+
+static inline u32 spm_register_read(struct spm_driver_data *drv,
+					enum spm_reg reg)
+{
+	return readl_relaxed(drv->reg_base + drv->reg_data->reg_offset[reg]);
+}
+
+void spm_set_low_power_mode(struct spm_driver_data *drv,
+					enum pm_sleep_mode mode)
+{
+	u32 start_index;
+	u32 ctl_val;
+
+	start_index = drv->reg_data->start_index[mode];
+
+	ctl_val = spm_register_read(drv, SPM_REG_SPM_CTL);
+	ctl_val &= ~(SPM_CTL_INDEX << SPM_CTL_INDEX_SHIFT);
+	ctl_val |= start_index << SPM_CTL_INDEX_SHIFT;
+	ctl_val |= SPM_CTL_EN;
+	spm_register_write_sync(drv, SPM_REG_SPM_CTL, ctl_val);
+}
+
+static const struct of_device_id spm_match_table[] = {
+	{ .compatible = "qcom,msm8974-saw2-v2.1-cpu",
+	  .data = &spm_reg_8974_8084_cpu },
+	{ .compatible = "qcom,apq8084-saw2-v2.1-cpu",
+	  .data = &spm_reg_8974_8084_cpu },
+	{ .compatible = "qcom,apq8064-saw2-v1.1-cpu",
+	  .data = &spm_reg_8064_cpu },
+	{ },
+};
+
+static int spm_dev_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *match_id;
+	struct spm_driver_data *drv;
+	struct resource *res;
+	void __iomem *addr;
+
+	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
+	if (!drv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	drv->reg_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(drv->reg_base))
+		return PTR_ERR(drv->reg_base);
+
+	match_id = of_match_node(spm_match_table, pdev->dev.of_node);
+	if (!match_id)
+		return -ENODEV;
+
+	drv->reg_data = match_id->data;
+	platform_set_drvdata(pdev, drv);
+
+	/* Write the SPM sequences first.. */
+	addr = drv->reg_base + drv->reg_data->reg_offset[SPM_REG_SEQ_ENTRY];
+	__iowrite32_copy(addr, drv->reg_data->seq,
+			ARRAY_SIZE(drv->reg_data->seq) / 4);
+
+	/*
+	 * ..and then the control registers.
+	 * On some SoC if the control registers are written first and if the
+	 * CPU was held in reset, the reset signal could trigger the SPM state
+	 * machine, before the sequences are completely written.
+	 */
+	spm_register_write(drv, SPM_REG_CFG, drv->reg_data->spm_cfg);
+	spm_register_write(drv, SPM_REG_DLY, drv->reg_data->spm_dly);
+	spm_register_write(drv, SPM_REG_PMIC_DLY, drv->reg_data->pmic_dly);
+	spm_register_write(drv, SPM_REG_PMIC_DATA_0,
+				drv->reg_data->pmic_data[0]);
+	spm_register_write(drv, SPM_REG_PMIC_DATA_1,
+				drv->reg_data->pmic_data[1]);
+
+	/* Set up Standby as the default low power mode */
+	spm_set_low_power_mode(drv, PM_SLEEP_MODE_STBY);
+
+	return 0;
+}
+
+static struct platform_driver spm_driver = {
+	.probe = spm_dev_probe,
+	.driver = {
+		.name = "qcom_spm",
+		.of_match_table = spm_match_table,
+	},
+};
+
+static int __init qcom_spm_init(void)
+{
+	return platform_driver_register(&spm_driver);
+}
+arch_initcall(qcom_spm_init);
diff --git a/include/soc/qcom/spm.h b/include/soc/qcom/spm.h
new file mode 100644
index 000000000000..dfdb9e9edfc6
--- /dev/null
+++ b/include/soc/qcom/spm.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2011-2014, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2014,2015, Linaro Ltd.
+ * Copyright (C) 2020, AngeloGioacchino Del Regno <kholk11@gmail.com>
+ */
+
+#ifndef __SPM_H__
+#define __SPM_H__
+
+#include <linux/cpuidle.h>
+
+#define MAX_PMIC_DATA		2
+#define MAX_SEQ_DATA		64
+
+enum pm_sleep_mode {
+	PM_SLEEP_MODE_STBY,
+	PM_SLEEP_MODE_RET,
+	PM_SLEEP_MODE_SPC,
+	PM_SLEEP_MODE_PC,
+	PM_SLEEP_MODE_NR,
+};
+
+struct spm_reg_data {
+	const u16 *reg_offset;
+	u32 spm_cfg;
+	u32 spm_dly;
+	u32 pmic_dly;
+	u32 pmic_data[MAX_PMIC_DATA];
+	u32 avs_ctl;
+	u32 avs_limit;
+	u8 seq[MAX_SEQ_DATA];
+	u8 start_index[PM_SLEEP_MODE_NR];
+};
+
+struct spm_driver_data {
+	struct cpuidle_driver cpuidle_driver;
+	void __iomem *reg_base;
+	const struct spm_reg_data *reg_data;
+};
+
+void spm_set_low_power_mode(struct spm_driver_data *drv,
+					enum pm_sleep_mode mode);
+
+#endif /* __SPM_H__ */
-- 
2.29.2

