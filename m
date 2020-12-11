Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47122D764E
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 14:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436631AbgLKNKg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Dec 2020 08:10:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34906 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436589AbgLKNJr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2020 08:09:47 -0500
Date:   Fri, 11 Dec 2020 13:09:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607692143;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6MGGiOoIt3X+19kZTHc5Dyx1jasuztpTa+65XiAZOGM=;
        b=K9wwFSJHH6BONSiLI5Q3RQb4EptLNX93n4wr74WzHHneUrQ68gS/bAhxcvS5A6/9zal/zA
        07AbacHTgKnWCPB0ev/0yKH9G3VtSxCzuoh7oTyL0qzxNpEUeIYtSm2HTpP1gV8hAiqDKx
        6oasIvEfPYLy5R5eDZVW+tLSkyrrlhUaIGjIbSlnb8Zs7mvouPhBaTXHsjO2GpMtEtfBre
        xVuyTFBwDvzLAT+2NjQAz2wVyrA5MS5rOtmRFysJqhYyq+DuAg1jQVmRtIyIo3i11T14Bg
        W6wtOyCXGSL8/Dj7jkSNFPDHz+qMGIcLxBO1s3pZNePXaqYeNf6u3iRIa1+1Sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607692143;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6MGGiOoIt3X+19kZTHc5Dyx1jasuztpTa+65XiAZOGM=;
        b=scjMeDnAgTIauqo9Yba6+Fjud9VpyEOShqt1efrJbYV9WZlOwXJmUs4PVFWZ3zWImGDNhl
        NB5WEqw0BYSlvOCA==
From:   "thermal-bot for Srinivas Pandruvada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: int340x: processor_thermal: Refactor
 MMIO interface
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201126171829.945969-1-srinivas.pandruvada@linux.intel.com>
References: <20201126171829.945969-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Message-ID: <160769214277.3364.17930332523415997411.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     a5923b6c3137b9d4fc2ea1c997f6e4d51ac5d774
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//a5923b6c3137b9d4fc2ea1c997f6e4d51ac5d774
Author:        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
AuthorDate:    Thu, 26 Nov 2020 09:18:26 -08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 10 Dec 2020 12:29:47 +01:00

thermal: int340x: processor_thermal: Refactor MMIO interface

The Processor Thermal PCI device supports multiple features. Currently
we export only RAPL. But we need more features from this device exposed
for Tiger Lake and Alder Lake based platforms. So re-structure the
current MMIO interface, so that more features can be added cleanly.

No functional changes are expected with this change.

Changes done in this patch:
- Using PCI_DEVICE_DATA(), hence names of defines changed
- Move RAPL MMIO code to its own module
- Move the RAPL MMIO offsets to RAPL MMIO module
- Adjust Kconfig dependency of PROC_THERMAL_MMIO_RAPL
- Per processor driver data now contains the supported features
- Moved all the common data structures and defines to a common header
  file
- This new header file contains all the processor_thermal_* interfaces
- Based on the features supported the module interface is called
- Each module atleast provides one add and one remove function

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201126171829.945969-1-srinivas.pandruvada@linux.intel.com
---
 drivers/thermal/intel/int340x_thermal/Kconfig                    |   6 +--
 drivers/thermal/intel/int340x_thermal/Makefile                   |   1 +-
 drivers/thermal/intel/int340x_thermal/processor_thermal_device.c | 261 ++++++++++++++--------------------------------------------------------
 drivers/thermal/intel/int340x_thermal/processor_thermal_device.h |  72 +++++++++++++++++++-
 drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c   | 134 ++++++++++++++++++++++++++++++++++++-
 5 files changed, 263 insertions(+), 211 deletions(-)
 create mode 100644 drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
 create mode 100644 drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c

diff --git a/drivers/thermal/intel/int340x_thermal/Kconfig b/drivers/thermal/intel/int340x_thermal/Kconfig
index 7979075..45c31f3 100644
--- a/drivers/thermal/intel/int340x_thermal/Kconfig
+++ b/drivers/thermal/intel/int340x_thermal/Kconfig
@@ -10,6 +10,7 @@ config INT340X_THERMAL
 	select ACPI_THERMAL_REL
 	select ACPI_FAN
 	select INTEL_SOC_DTS_IOSF_CORE
+	select PROC_THERMAL_MMIO_RAPL if X86_64 && POWERCAP
 	help
 	  Newer laptops and tablets that use ACPI may have thermal sensors and
 	  other devices with thermal control capabilities outside the core
@@ -41,9 +42,6 @@ config INT3406_THERMAL
 	  power consumed by display device.
 
 config PROC_THERMAL_MMIO_RAPL
-	bool
-	depends on 64BIT
-	depends on POWERCAP
+	tristate
 	select INTEL_RAPL_CORE
-	default y
 endif
diff --git a/drivers/thermal/intel/int340x_thermal/Makefile b/drivers/thermal/intel/int340x_thermal/Makefile
index 287eb0a..86e8d3c 100644
--- a/drivers/thermal/intel/int340x_thermal/Makefile
+++ b/drivers/thermal/intel/int340x_thermal/Makefile
@@ -4,5 +4,6 @@ obj-$(CONFIG_INT340X_THERMAL)	+= int340x_thermal_zone.o
 obj-$(CONFIG_INT340X_THERMAL)	+= int3402_thermal.o
 obj-$(CONFIG_INT340X_THERMAL)	+= int3403_thermal.o
 obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_device.o
+obj-$(CONFIG_PROC_THERMAL_MMIO_RAPL) += processor_thermal_rapl.o
 obj-$(CONFIG_INT3406_THERMAL)	+= int3406_thermal.o
 obj-$(CONFIG_ACPI_THERMAL_REL)	+= acpi_thermal_rel.o
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index 81e8b15..5b8dc5e 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -12,74 +12,18 @@
 #include <linux/acpi.h>
 #include <linux/thermal.h>
 #include <linux/cpuhotplug.h>
-#include <linux/intel_rapl.h>
 #include "int340x_thermal_zone.h"
+#include "processor_thermal_device.h"
 #include "../intel_soc_dts_iosf.h"
 
-/* Broadwell-U/HSB thermal reporting device */
-#define PCI_DEVICE_ID_PROC_BDW_THERMAL	0x1603
-#define PCI_DEVICE_ID_PROC_HSB_THERMAL	0x0A03
-
-/* Skylake thermal reporting device */
-#define PCI_DEVICE_ID_PROC_SKL_THERMAL	0x1903
-
-/* CannonLake thermal reporting device */
-#define PCI_DEVICE_ID_PROC_CNL_THERMAL	0x5a03
-#define PCI_DEVICE_ID_PROC_CFL_THERMAL	0x3E83
-
-/* Braswell thermal reporting device */
-#define PCI_DEVICE_ID_PROC_BSW_THERMAL	0x22DC
-
-/* Broxton thermal reporting device */
-#define PCI_DEVICE_ID_PROC_BXT0_THERMAL  0x0A8C
-#define PCI_DEVICE_ID_PROC_BXT1_THERMAL  0x1A8C
-#define PCI_DEVICE_ID_PROC_BXTX_THERMAL  0x4A8C
-#define PCI_DEVICE_ID_PROC_BXTP_THERMAL  0x5A8C
-
-/* GeminiLake thermal reporting device */
-#define PCI_DEVICE_ID_PROC_GLK_THERMAL	0x318C
-
-/* IceLake thermal reporting device */
-#define PCI_DEVICE_ID_PROC_ICL_THERMAL	0x8a03
-
-/* JasperLake thermal reporting device */
-#define PCI_DEVICE_ID_PROC_JSL_THERMAL	0x4E03
-
-/* TigerLake thermal reporting device */
-#define PCI_DEVICE_ID_PROC_TGL_THERMAL	0x9A03
-
 #define DRV_NAME "proc_thermal"
 
-struct power_config {
-	u32	index;
-	u32	min_uw;
-	u32	max_uw;
-	u32	tmin_us;
-	u32	tmax_us;
-	u32	step_uw;
-};
-
-struct proc_thermal_device {
-	struct device *dev;
-	struct acpi_device *adev;
-	struct power_config power_limits[2];
-	struct int34x_thermal_zone *int340x_zone;
-	struct intel_soc_dts_sensors *soc_dts;
-	void __iomem *mmio_base;
-};
-
 enum proc_thermal_emum_mode_type {
 	PROC_THERMAL_NONE,
 	PROC_THERMAL_PCI,
 	PROC_THERMAL_PLATFORM_DEV
 };
 
-struct rapl_mmio_regs {
-	u64 reg_unit;
-	u64 regs[RAPL_DOMAIN_MAX][RAPL_DOMAIN_REG_MAX];
-	int limits[RAPL_DOMAIN_MAX];
-};
-
 /*
  * We can have only one type of enumeration, PCI or Platform,
  * not both. So we don't need instance specific data.
@@ -461,84 +405,13 @@ static irqreturn_t proc_thermal_pci_msi_irq(int irq, void *devid)
 	return IRQ_HANDLED;
 }
 
-#ifdef CONFIG_PROC_THERMAL_MMIO_RAPL
-
 #define MCHBAR 0
 
-/* RAPL Support via MMIO interface */
-static struct rapl_if_priv rapl_mmio_priv;
-
-static int rapl_mmio_cpu_online(unsigned int cpu)
-{
-	struct rapl_package *rp;
-
-	/* mmio rapl supports package 0 only for now */
-	if (topology_physical_package_id(cpu))
-		return 0;
-
-	rp = rapl_find_package_domain(cpu, &rapl_mmio_priv);
-	if (!rp) {
-		rp = rapl_add_package(cpu, &rapl_mmio_priv);
-		if (IS_ERR(rp))
-			return PTR_ERR(rp);
-	}
-	cpumask_set_cpu(cpu, &rp->cpumask);
-	return 0;
-}
-
-static int rapl_mmio_cpu_down_prep(unsigned int cpu)
+static int proc_thermal_set_mmio_base(struct pci_dev *pdev,
+				      struct proc_thermal_device *proc_priv)
 {
-	struct rapl_package *rp;
-	int lead_cpu;
-
-	rp = rapl_find_package_domain(cpu, &rapl_mmio_priv);
-	if (!rp)
-		return 0;
-
-	cpumask_clear_cpu(cpu, &rp->cpumask);
-	lead_cpu = cpumask_first(&rp->cpumask);
-	if (lead_cpu >= nr_cpu_ids)
-		rapl_remove_package(rp);
-	else if (rp->lead_cpu == cpu)
-		rp->lead_cpu = lead_cpu;
-	return 0;
-}
-
-static int rapl_mmio_read_raw(int cpu, struct reg_action *ra)
-{
-	if (!ra->reg)
-		return -EINVAL;
-
-	ra->value = readq((void __iomem *)ra->reg);
-	ra->value &= ra->mask;
-	return 0;
-}
-
-static int rapl_mmio_write_raw(int cpu, struct reg_action *ra)
-{
-	u64 val;
-
-	if (!ra->reg)
-		return -EINVAL;
-
-	val = readq((void __iomem *)ra->reg);
-	val &= ~ra->mask;
-	val |= ra->value;
-	writeq(val, (void __iomem *)ra->reg);
-	return 0;
-}
-
-static int proc_thermal_rapl_add(struct pci_dev *pdev,
-				 struct proc_thermal_device *proc_priv,
-				 struct rapl_mmio_regs *rapl_regs)
-{
-	enum rapl_domain_reg_id reg;
-	enum rapl_domain_type domain;
 	int ret;
 
-	if (!rapl_regs)
-		return 0;
-
 	ret = pcim_iomap_regions(pdev, 1 << MCHBAR, DRV_NAME);
 	if (ret) {
 		dev_err(&pdev->dev, "cannot reserve PCI memory region\n");
@@ -547,66 +420,42 @@ static int proc_thermal_rapl_add(struct pci_dev *pdev,
 
 	proc_priv->mmio_base = pcim_iomap_table(pdev)[MCHBAR];
 
-	for (domain = RAPL_DOMAIN_PACKAGE; domain < RAPL_DOMAIN_MAX; domain++) {
-		for (reg = RAPL_DOMAIN_REG_LIMIT; reg < RAPL_DOMAIN_REG_MAX; reg++)
-			if (rapl_regs->regs[domain][reg])
-				rapl_mmio_priv.regs[domain][reg] =
-						(u64)proc_priv->mmio_base +
-						rapl_regs->regs[domain][reg];
-		rapl_mmio_priv.limits[domain] = rapl_regs->limits[domain];
-	}
-	rapl_mmio_priv.reg_unit = (u64)proc_priv->mmio_base + rapl_regs->reg_unit;
+	return 0;
+}
 
-	rapl_mmio_priv.read_raw = rapl_mmio_read_raw;
-	rapl_mmio_priv.write_raw = rapl_mmio_write_raw;
+static int proc_thermal_mmio_add(struct pci_dev *pdev,
+				 struct proc_thermal_device *proc_priv,
+				 kernel_ulong_t feature_mask)
+{
+	int ret;
 
-	rapl_mmio_priv.control_type = powercap_register_control_type(NULL, "intel-rapl-mmio", NULL);
-	if (IS_ERR(rapl_mmio_priv.control_type)) {
-		pr_debug("failed to register powercap control_type.\n");
-		return PTR_ERR(rapl_mmio_priv.control_type);
+	if (feature_mask) {
+		ret = proc_thermal_set_mmio_base(pdev, proc_priv);
+		if (ret)
+			return ret;
 	}
 
-	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "powercap/rapl:online",
-				rapl_mmio_cpu_online, rapl_mmio_cpu_down_prep);
-	if (ret < 0) {
-		powercap_unregister_control_type(rapl_mmio_priv.control_type);
-		rapl_mmio_priv.control_type = NULL;
-		return ret;
+	if (feature_mask & PROC_THERMAL_FEATURE_RAPL) {
+		ret = proc_thermal_rapl_add(pdev, proc_priv);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to add RAPL MMIO interface\n");
+			return ret;
+		}
 	}
-	rapl_mmio_priv.pcap_rapl_online = ret;
+
+	proc_priv->mmio_feature_mask = feature_mask;
 
 	return 0;
 }
 
-static void proc_thermal_rapl_remove(void)
+static void proc_thermal_mmio_remove(struct pci_dev *pdev)
 {
-	if (IS_ERR_OR_NULL(rapl_mmio_priv.control_type))
-		return;
-
-	cpuhp_remove_state(rapl_mmio_priv.pcap_rapl_online);
-	powercap_unregister_control_type(rapl_mmio_priv.control_type);
-}
+	struct proc_thermal_device *proc_priv = pci_get_drvdata(pdev);
 
-static const struct rapl_mmio_regs rapl_mmio_hsw = {
-	.reg_unit = 0x5938,
-	.regs[RAPL_DOMAIN_PACKAGE] = { 0x59a0, 0x593c, 0x58f0, 0, 0x5930},
-	.regs[RAPL_DOMAIN_DRAM] = { 0x58e0, 0x58e8, 0x58ec, 0, 0},
-	.limits[RAPL_DOMAIN_PACKAGE] = 2,
-	.limits[RAPL_DOMAIN_DRAM] = 2,
-};
+	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_RAPL)
+		proc_thermal_rapl_remove();
 
-#else
-
-static int proc_thermal_rapl_add(struct pci_dev *pdev,
-				 struct proc_thermal_device *proc_priv,
-				 struct rapl_mmio_regs *rapl_regs)
-{
-	return 0;
 }
-static void proc_thermal_rapl_remove(void) {}
-static const struct rapl_mmio_regs rapl_mmio_hsw;
-
-#endif /* CONFIG_MMIO_RAPL */
 
 static int  proc_thermal_pci_probe(struct pci_dev *pdev,
 				   const struct pci_device_id *id)
@@ -629,18 +478,10 @@ static int  proc_thermal_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
-	ret = proc_thermal_rapl_add(pdev, proc_priv,
-				(struct rapl_mmio_regs *)id->driver_data);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to add RAPL MMIO interface\n");
-		proc_thermal_remove(proc_priv);
-		return ret;
-	}
-
 	pci_set_drvdata(pdev, proc_priv);
 	proc_thermal_emum_mode = PROC_THERMAL_PCI;
 
-	if (pdev->device == PCI_DEVICE_ID_PROC_BSW_THERMAL) {
+	if (pdev->device == PCI_DEVICE_ID_INTEL_BSW_THERMAL) {
 		/*
 		 * Enumerate additional DTS sensors available via IOSF.
 		 * But we are not treating as a failure condition, if
@@ -676,10 +517,18 @@ static int  proc_thermal_pci_probe(struct pci_dev *pdev,
 		return ret;
 
 	ret = sysfs_create_group(&pdev->dev.kobj, &power_limit_attribute_group);
-	if (ret)
+	if (ret) {
 		sysfs_remove_file(&pdev->dev.kobj, &dev_attr_tcc_offset_degree_celsius.attr);
+		return ret;
+	}
 
-	return ret;
+	ret = proc_thermal_mmio_add(pdev, proc_priv, id->driver_data);
+	if (ret) {
+		proc_thermal_remove(proc_priv);
+		return ret;
+	}
+
+	return 0;
 }
 
 static void  proc_thermal_pci_remove(struct pci_dev *pdev)
@@ -693,7 +542,8 @@ static void  proc_thermal_pci_remove(struct pci_dev *pdev)
 			pci_disable_msi(pdev);
 		}
 	}
-	proc_thermal_rapl_remove();
+
+	proc_thermal_mmio_remove(pdev);
 	proc_thermal_remove(proc_priv);
 }
 
@@ -716,24 +566,21 @@ static int proc_thermal_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(proc_thermal_pm, NULL, proc_thermal_resume);
 
 static const struct pci_device_id proc_thermal_pci_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_BDW_THERMAL)},
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_HSB_THERMAL)},
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_SKL_THERMAL),
-		.driver_data = (kernel_ulong_t)&rapl_mmio_hsw, },
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_BSW_THERMAL)},
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_BXT0_THERMAL)},
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_BXT1_THERMAL)},
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_BXTX_THERMAL)},
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_BXTP_THERMAL)},
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_CNL_THERMAL)},
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_CFL_THERMAL)},
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_GLK_THERMAL)},
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_ICL_THERMAL),
-		.driver_data = (kernel_ulong_t)&rapl_mmio_hsw, },
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_JSL_THERMAL)},
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_TGL_THERMAL),
-		.driver_data = (kernel_ulong_t)&rapl_mmio_hsw, },
-	{ 0, },
+	{ PCI_DEVICE_DATA(INTEL, BDW_THERMAL, 0) },
+	{ PCI_DEVICE_DATA(INTEL, BSW_THERMAL, 0) },
+	{ PCI_DEVICE_DATA(INTEL, BXT0_THERMAL, 0) },
+	{ PCI_DEVICE_DATA(INTEL, BXT1_THERMAL, 0) },
+	{ PCI_DEVICE_DATA(INTEL, BXTX_THERMAL, 0) },
+	{ PCI_DEVICE_DATA(INTEL, BXTP_THERMAL, 0) },
+	{ PCI_DEVICE_DATA(INTEL, CNL_THERMAL, 0) },
+	{ PCI_DEVICE_DATA(INTEL, CFL_THERMAL, 0) },
+	{ PCI_DEVICE_DATA(INTEL, GLK_THERMAL, 0) },
+	{ PCI_DEVICE_DATA(INTEL, HSB_THERMAL, 0) },
+	{ PCI_DEVICE_DATA(INTEL, ICL_THERMAL, PROC_THERMAL_FEATURE_RAPL) },
+	{ PCI_DEVICE_DATA(INTEL, JSL_THERMAL, 0) },
+	{ PCI_DEVICE_DATA(INTEL, SKL_THERMAL, PROC_THERMAL_FEATURE_RAPL) },
+	{ PCI_DEVICE_DATA(INTEL, TGL_THERMAL, PROC_THERMAL_FEATURE_RAPL) },
+	{ },
 };
 
 MODULE_DEVICE_TABLE(pci, proc_thermal_pci_ids);
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
new file mode 100644
index 0000000..e20d142
--- /dev/null
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * processor_thermal_device.h
+ * Copyright (c) 2020, Intel Corporation.
+ */
+
+#ifndef __PROCESSOR_THERMAL_DEVICE_H__
+#define __PROCESSOR_THERMAL_DEVICE_H__
+
+#include <linux/intel_rapl.h>
+
+#define PCI_DEVICE_ID_INTEL_BDW_THERMAL	0x1603
+#define PCI_DEVICE_ID_INTEL_BSW_THERMAL	0x22DC
+
+#define PCI_DEVICE_ID_INTEL_BXT0_THERMAL	0x0A8C
+#define PCI_DEVICE_ID_INTEL_BXT1_THERMAL	0x1A8C
+#define PCI_DEVICE_ID_INTEL_BXTX_THERMAL	0x4A8C
+#define PCI_DEVICE_ID_INTEL_BXTP_THERMAL	0x5A8C
+
+#define PCI_DEVICE_ID_INTEL_CNL_THERMAL	0x5a03
+#define PCI_DEVICE_ID_INTEL_CFL_THERMAL	0x3E83
+#define PCI_DEVICE_ID_INTEL_GLK_THERMAL	0x318C
+#define PCI_DEVICE_ID_INTEL_HSB_THERMAL	0x0A03
+#define PCI_DEVICE_ID_INTEL_ICL_THERMAL	0x8a03
+#define PCI_DEVICE_ID_INTEL_JSL_THERMAL	0x4E03
+#define PCI_DEVICE_ID_INTEL_SKL_THERMAL	0x1903
+#define PCI_DEVICE_ID_INTEL_TGL_THERMAL	0x9A03
+
+struct power_config {
+	u32	index;
+	u32	min_uw;
+	u32	max_uw;
+	u32	tmin_us;
+	u32	tmax_us;
+	u32	step_uw;
+};
+
+struct proc_thermal_device {
+	struct device *dev;
+	struct acpi_device *adev;
+	struct power_config power_limits[2];
+	struct int34x_thermal_zone *int340x_zone;
+	struct intel_soc_dts_sensors *soc_dts;
+	u32 mmio_feature_mask;
+	void __iomem *mmio_base;
+};
+
+struct rapl_mmio_regs {
+	u64 reg_unit;
+	u64 regs[RAPL_DOMAIN_MAX][RAPL_DOMAIN_REG_MAX];
+	int limits[RAPL_DOMAIN_MAX];
+};
+
+#define PROC_THERMAL_FEATURE_NONE	0x00
+#define PROC_THERMAL_FEATURE_RAPL	0x01
+
+#if IS_ENABLED(CONFIG_PROC_THERMAL_MMIO_RAPL)
+int proc_thermal_rapl_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
+void proc_thermal_rapl_remove(void);
+#else
+static int __maybe_unused proc_thermal_rapl_add(struct pci_dev *pdev,
+						struct proc_thermal_device *proc_priv)
+{
+	return 0;
+}
+
+static void __maybe_unused proc_thermal_rapl_remove(void)
+{
+}
+#endif
+
+#endif
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
new file mode 100644
index 0000000..a205221
--- /dev/null
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * processor thermal device RFIM control
+ * Copyright (c) 2020, Intel Corporation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include "processor_thermal_device.h"
+
+static struct rapl_if_priv rapl_mmio_priv;
+
+static const struct rapl_mmio_regs rapl_mmio_default = {
+	.reg_unit = 0x5938,
+	.regs[RAPL_DOMAIN_PACKAGE] = { 0x59a0, 0x593c, 0x58f0, 0, 0x5930},
+	.regs[RAPL_DOMAIN_DRAM] = { 0x58e0, 0x58e8, 0x58ec, 0, 0},
+	.limits[RAPL_DOMAIN_PACKAGE] = 2,
+	.limits[RAPL_DOMAIN_DRAM] = 2,
+};
+
+static int rapl_mmio_cpu_online(unsigned int cpu)
+{
+	struct rapl_package *rp;
+
+	/* mmio rapl supports package 0 only for now */
+	if (topology_physical_package_id(cpu))
+		return 0;
+
+	rp = rapl_find_package_domain(cpu, &rapl_mmio_priv);
+	if (!rp) {
+		rp = rapl_add_package(cpu, &rapl_mmio_priv);
+		if (IS_ERR(rp))
+			return PTR_ERR(rp);
+	}
+	cpumask_set_cpu(cpu, &rp->cpumask);
+	return 0;
+}
+
+static int rapl_mmio_cpu_down_prep(unsigned int cpu)
+{
+	struct rapl_package *rp;
+	int lead_cpu;
+
+	rp = rapl_find_package_domain(cpu, &rapl_mmio_priv);
+	if (!rp)
+		return 0;
+
+	cpumask_clear_cpu(cpu, &rp->cpumask);
+	lead_cpu = cpumask_first(&rp->cpumask);
+	if (lead_cpu >= nr_cpu_ids)
+		rapl_remove_package(rp);
+	else if (rp->lead_cpu == cpu)
+		rp->lead_cpu = lead_cpu;
+	return 0;
+}
+
+static int rapl_mmio_read_raw(int cpu, struct reg_action *ra)
+{
+	if (!ra->reg)
+		return -EINVAL;
+
+	ra->value = readq((void __iomem *)ra->reg);
+	ra->value &= ra->mask;
+	return 0;
+}
+
+static int rapl_mmio_write_raw(int cpu, struct reg_action *ra)
+{
+	u64 val;
+
+	if (!ra->reg)
+		return -EINVAL;
+
+	val = readq((void __iomem *)ra->reg);
+	val &= ~ra->mask;
+	val |= ra->value;
+	writeq(val, (void __iomem *)ra->reg);
+	return 0;
+}
+
+int proc_thermal_rapl_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv)
+{
+	const struct rapl_mmio_regs *rapl_regs = &rapl_mmio_default;
+	enum rapl_domain_reg_id reg;
+	enum rapl_domain_type domain;
+	int ret;
+
+	if (!rapl_regs)
+		return 0;
+
+	for (domain = RAPL_DOMAIN_PACKAGE; domain < RAPL_DOMAIN_MAX; domain++) {
+		for (reg = RAPL_DOMAIN_REG_LIMIT; reg < RAPL_DOMAIN_REG_MAX; reg++)
+			if (rapl_regs->regs[domain][reg])
+				rapl_mmio_priv.regs[domain][reg] =
+						(u64)proc_priv->mmio_base +
+						rapl_regs->regs[domain][reg];
+		rapl_mmio_priv.limits[domain] = rapl_regs->limits[domain];
+	}
+	rapl_mmio_priv.reg_unit = (u64)proc_priv->mmio_base + rapl_regs->reg_unit;
+
+	rapl_mmio_priv.read_raw = rapl_mmio_read_raw;
+	rapl_mmio_priv.write_raw = rapl_mmio_write_raw;
+
+	rapl_mmio_priv.control_type = powercap_register_control_type(NULL, "intel-rapl-mmio", NULL);
+	if (IS_ERR(rapl_mmio_priv.control_type)) {
+		pr_debug("failed to register powercap control_type.\n");
+		return PTR_ERR(rapl_mmio_priv.control_type);
+	}
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "powercap/rapl:online",
+				rapl_mmio_cpu_online, rapl_mmio_cpu_down_prep);
+	if (ret < 0) {
+		powercap_unregister_control_type(rapl_mmio_priv.control_type);
+		rapl_mmio_priv.control_type = NULL;
+		return ret;
+	}
+	rapl_mmio_priv.pcap_rapl_online = ret;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(proc_thermal_rapl_add);
+
+void proc_thermal_rapl_remove(void)
+{
+	if (IS_ERR_OR_NULL(rapl_mmio_priv.control_type))
+		return;
+
+	cpuhp_remove_state(rapl_mmio_priv.pcap_rapl_online);
+	powercap_unregister_control_type(rapl_mmio_priv.control_type);
+}
+EXPORT_SYMBOL_GPL(proc_thermal_rapl_remove);
+
+MODULE_LICENSE("GPL v2");
