Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A89995FBE6
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2019 18:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfGDQfK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Jul 2019 12:35:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:33048 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727229AbfGDQfK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 4 Jul 2019 12:35:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2019 09:35:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,451,1557212400"; 
   d="scan'208";a="169480554"
Received: from conghuic-mobl.ccr.corp.intel.com (HELO rzhang-dell-9360.ccr.corp.intel.com) ([10.249.172.41])
  by orsmga006.jf.intel.com with ESMTP; 04 Jul 2019 09:35:07 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, srinivas.pandruvada@intel.com,
        rui.zhang@intel.com
Subject: [PATCH V2 12/13] int340X/processor_thermal_device: add support for MMIO RAPL
Date:   Fri,  5 Jul 2019 00:34:44 +0800
Message-Id: <1562258085-3165-13-git-send-email-rui.zhang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562258085-3165-1-git-send-email-rui.zhang@intel.com>
References: <1562258085-3165-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce MMIO RAPL support as Intel processor_thermal device exposes the
capability to do RAPL control via MMIO registers.

Reviewed-and-tested-by: Pandruvada, Srinivas <srinivas.pandruvada@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/intel/int340x_thermal/Kconfig      |   6 +
 .../int340x_thermal/processor_thermal_device.c     | 173 ++++++++++++++++++++-
 2 files changed, 173 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/Kconfig b/drivers/thermal/intel/int340x_thermal/Kconfig
index 5333e01..7979075 100644
--- a/drivers/thermal/intel/int340x_thermal/Kconfig
+++ b/drivers/thermal/intel/int340x_thermal/Kconfig
@@ -40,4 +40,10 @@ config INT3406_THERMAL
 	  brightness in order to address a thermal condition or to reduce
 	  power consumed by display device.
 
+config PROC_THERMAL_MMIO_RAPL
+	bool
+	depends on 64BIT
+	depends on POWERCAP
+	select INTEL_RAPL_CORE
+	default y
 endif
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index 53c84fa..06c7ab3 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -11,6 +11,8 @@
 #include <linux/platform_device.h>
 #include <linux/acpi.h>
 #include <linux/thermal.h>
+#include <linux/cpuhotplug.h>
+#include <linux/intel_rapl.h>
 #include "int340x_thermal_zone.h"
 #include "../intel_soc_dts_iosf.h"
 
@@ -37,6 +39,8 @@
 /* GeminiLake thermal reporting device */
 #define PCI_DEVICE_ID_PROC_GLK_THERMAL	0x318C
 
+#define DRV_NAME "proc_thermal"
+
 struct power_config {
 	u32	index;
 	u32	min_uw;
@@ -52,6 +56,7 @@ struct proc_thermal_device {
 	struct power_config power_limits[2];
 	struct int34x_thermal_zone *int340x_zone;
 	struct intel_soc_dts_sensors *soc_dts;
+	void __iomem *mmio_base;
 };
 
 enum proc_thermal_emum_mode_type {
@@ -60,6 +65,12 @@ enum proc_thermal_emum_mode_type {
 	PROC_THERMAL_PLATFORM_DEV
 };
 
+struct rapl_mmio_regs {
+	u64 reg_unit;
+	u64 regs[RAPL_DOMAIN_MAX][RAPL_DOMAIN_REG_MAX];
+	int limits[RAPL_DOMAIN_MAX];
+};
+
 /*
  * We can have only one type of enumeration, PCI or Platform,
  * not both. So we don't need instance specific data.
@@ -367,8 +378,151 @@ static irqreturn_t proc_thermal_pci_msi_irq(int irq, void *devid)
 	return IRQ_HANDLED;
 }
 
+#ifdef CONFIG_PROC_THERMAL_MMIO_RAPL
+
+#define MCHBAR 0
+
+/* RAPL Support via MMIO interface */
+static struct rapl_if_priv rapl_mmio_priv;
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
+static int proc_thermal_rapl_add(struct pci_dev *pdev,
+				 struct proc_thermal_device *proc_priv,
+				 struct rapl_mmio_regs *rapl_regs)
+{
+	enum rapl_domain_reg_id reg;
+	enum rapl_domain_type domain;
+	int ret;
+
+	if (!rapl_regs)
+		return 0;
+
+	ret = pcim_iomap_regions(pdev, 1 << MCHBAR, DRV_NAME);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot reserve PCI memory region\n");
+		return -ENOMEM;
+	}
+
+	proc_priv->mmio_base = pcim_iomap_table(pdev)[MCHBAR];
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
+		return ret;
+	}
+	rapl_mmio_priv.pcap_rapl_online = ret;
+
+	return 0;
+}
+
+static void proc_thermal_rapl_remove(void)
+{
+	cpuhp_remove_state(rapl_mmio_priv.pcap_rapl_online);
+	powercap_unregister_control_type(rapl_mmio_priv.control_type);
+}
+
+static const struct rapl_mmio_regs rapl_mmio_hsw = {
+	.reg_unit = 0x5938,
+	.regs[RAPL_DOMAIN_PACKAGE] = { 0x59a0, 0x593c, 0x58f0, 0, 0x5930},
+	.regs[RAPL_DOMAIN_DRAM] = { 0x58e0, 0x58e8, 0x58ec, 0, 0},
+	.limits[RAPL_DOMAIN_PACKAGE] = 2,
+	.limits[RAPL_DOMAIN_DRAM] = 2,
+};
+
+#else
+
+static int proc_thermal_rapl_add(struct pci_dev *pdev,
+				 struct proc_thermal_device *proc_priv,
+				 struct rapl_mmio_regs *rapl_regs)
+{
+	return 0;
+}
+static void proc_thermal_rapl_remove(void) {}
+static const struct rapl_mmio_regs rapl_mmio_hsw;
+
+#endif /* CONFIG_MMIO_RAPL */
+
 static int  proc_thermal_pci_probe(struct pci_dev *pdev,
-				   const struct pci_device_id *unused)
+				   const struct pci_device_id *id)
 {
 	struct proc_thermal_device *proc_priv;
 	int ret;
@@ -378,15 +532,21 @@ static int  proc_thermal_pci_probe(struct pci_dev *pdev,
 		return -ENODEV;
 	}
 
-	ret = pci_enable_device(pdev);
+	ret = pcim_enable_device(pdev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "error: could not enable device\n");
 		return ret;
 	}
 
 	ret = proc_thermal_add(&pdev->dev, &proc_priv);
+	if (ret)
+		return ret;
+
+	ret = proc_thermal_rapl_add(pdev, proc_priv,
+				(struct rapl_mmio_regs *)id->driver_data);
 	if (ret) {
-		pci_disable_device(pdev);
+		dev_err(&pdev->dev, "failed to add RAPL MMIO interface\n");
+		proc_thermal_remove(proc_priv);
 		return ret;
 	}
 
@@ -439,14 +599,15 @@ static void  proc_thermal_pci_remove(struct pci_dev *pdev)
 			pci_disable_msi(pdev);
 		}
 	}
+	proc_thermal_rapl_remove();
 	proc_thermal_remove(proc_priv);
-	pci_disable_device(pdev);
 }
 
 static const struct pci_device_id proc_thermal_pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_BDW_THERMAL)},
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_HSB_THERMAL)},
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_SKL_THERMAL)},
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_SKL_THERMAL),
+		.driver_data = (kernel_ulong_t)&rapl_mmio_hsw, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_BSW_THERMAL)},
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_BXT0_THERMAL)},
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_BXT1_THERMAL)},
@@ -461,7 +622,7 @@ static const struct pci_device_id proc_thermal_pci_ids[] = {
 MODULE_DEVICE_TABLE(pci, proc_thermal_pci_ids);
 
 static struct pci_driver proc_thermal_pci_driver = {
-	.name		= "proc_thermal",
+	.name		= DRV_NAME,
 	.probe		= proc_thermal_pci_probe,
 	.remove		= proc_thermal_pci_remove,
 	.id_table	= proc_thermal_pci_ids,
-- 
2.7.4

