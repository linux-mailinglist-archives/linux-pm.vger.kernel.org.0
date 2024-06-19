Return-Path: <linux-pm+bounces-9612-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD13090F4EC
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 19:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8F6E1C221AF
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 17:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D3215667C;
	Wed, 19 Jun 2024 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gtMUp7Xp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CDB155756;
	Wed, 19 Jun 2024 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718817690; cv=none; b=soJl3DKJOFJzoUG29xv/m+TM+a0eXbDnwV5JzYT/V+0jKgW0Br6HTj1jVTdZVQhNdrIUohRsVVYi8Y/0leR1nZcIh5KGyRhcQgJb3YKkGpasp4guQSezigltO9w/zT+vkWmtj9Qd4gyTOC5dg/hEqOX+OO74imjOBXNLd9QGaBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718817690; c=relaxed/simple;
	bh=Cu0ByNm/ERAUGe0F3pAMLdrsOhOHbxVr+qzN5u5RZZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uspcVb8FLaHPUmgzYthr+R8AXfUAJOQL6TdOq3Y5CbxRpkqCr4rkxNE3YA5ehEyFOu9nGsi1nhUi7WtIVZOJbiU0JYoxBuXjUB/GQp8F7v9HkEO+oEBecn/IsH3zIsaBL3krf0THuGlS+Tj2M7Va+XVg/a6QxFvn4a2Kbt4rX10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gtMUp7Xp; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718817688; x=1750353688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cu0ByNm/ERAUGe0F3pAMLdrsOhOHbxVr+qzN5u5RZZE=;
  b=gtMUp7XpwsegJT4SG2WqW4M/Ci9Nvl5CL4pTxO0dsJb72Us8ancnCeKx
   FWwh2HZiCKs0LGMXuKyuhfEjVv9rCJ339f7yyNcZb+ZIdrTbuVdnjiyu8
   ryKITC9CPu16BgBVtWm25/JymYnIXBDUlUndIZoZXXOurpu3IZ7H6r9Tj
   HcItVdTp1JI8PXoKTBVggBkLNAz4lo3z2rVlvoG3mnTt7rXpZxPWlQueQ
   JZdQu2lUhyHilhcU2c4mbSTVF7uR+nfBR+WI72L9J3ClRd5yDHUUPpU1v
   5XdPL8ygVl1mI3xfIXS5z5TSLqtjzh5Uz+8quSqILz7xuzCLjEcTrNoHR
   A==;
X-CSE-ConnectionGUID: UgMPOwWWSxe18tduo9R65g==
X-CSE-MsgGUID: HS14FC73R6ybhBU4BPKQoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15531169"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="15531169"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 10:21:25 -0700
X-CSE-ConnectionGUID: A9dGjRcESKqFZEa6oMX66Q==
X-CSE-MsgGUID: EasXzWrHRCaabJT/wWnPSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="41840032"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by fmviesa007.fm.intel.com with ESMTP; 19 Jun 2024 10:21:25 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/3] thermal: intel: int340x: Support MSI interrupt for Lunar Lake
Date: Wed, 19 Jun 2024 10:21:08 -0700
Message-ID: <20240619172109.497639-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240619172109.497639-1-srinivas.pandruvada@linux.intel.com>
References: <20240619172109.497639-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The legacy PCI interrupt is no longer supported for processor thermal
device on Lunar Lake. The support is via MSI.

Add feature PROC_THERMAL_FEATURE_MSI_SUPPORT to support MSI feature per
generation. Define this feature for Lunar Lake processors.

There are 4 MSI sources:
0 - Package thermal
1 - DDR Thermal
2 - Power floor interrupt
3 - Workload type hint

On interrupt check the source and call the corresponding handler. Here
don't need to call proc_thermal_check_wt_intr() and
proc_thermal_check_power_floor_intr to check if the interrupt is for
those sources as there is a dedicated MSI interrupt.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../processor_thermal_device.h                |   1 +
 .../processor_thermal_device_pci.c            | 112 ++++++++++++++----
 2 files changed, 90 insertions(+), 23 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
index 674f3c85dfbc..d5eca6db2c00 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
@@ -65,6 +65,7 @@ struct rapl_mmio_regs {
 #define PROC_THERMAL_FEATURE_DLVR	0x10
 #define PROC_THERMAL_FEATURE_WT_HINT	0x20
 #define PROC_THERMAL_FEATURE_POWER_FLOOR	0x40
+#define PROC_THERMAL_FEATURE_MSI_SUPPORT	0x80
 
 #if IS_ENABLED(CONFIG_PROC_THERMAL_MMIO_RAPL)
 int proc_thermal_rapl_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index 59eb76d4dd81..8c6d19fe37c0 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -63,6 +63,18 @@ static struct proc_thermal_mmio_info proc_thermal_mmio_info[] = {
 	{ PROC_THERMAL_MMIO_INT_STATUS_1, 0x7200, 8, 0x01 },
 };
 
+/* List of supported MSI IDs (sources) */
+enum proc_thermal_msi_ids {
+	PKG_THERMAL,
+	DDR_THERMAL,
+	THERM_POWER_FLOOR,
+	WORKLOAD_CHANGE,
+	MSI_THERMAL_MAX
+};
+
+/* Stores IRQ associated with a MSI ID */
+static int proc_thermal_msi_map[MSI_THERMAL_MAX];
+
 #define B0D4_THERMAL_NOTIFY_DELAY	1000
 static int notify_delay_ms = B0D4_THERMAL_NOTIFY_DELAY;
 
@@ -146,22 +158,41 @@ static irqreturn_t proc_thermal_irq_thread_handler(int irq, void *devid)
 	return IRQ_HANDLED;
 }
 
+static int proc_thermal_match_msi_irq(int irq)
+{
+	int i;
+
+	if (!use_msi)
+		goto msi_fail;
+
+	for (i = 0; i < MSI_THERMAL_MAX; i++) {
+		if (proc_thermal_msi_map[i] == irq)
+			return i;
+	}
+
+msi_fail:
+	return -EOPNOTSUPP;
+}
+
 static irqreturn_t proc_thermal_irq_handler(int irq, void *devid)
 {
 	struct proc_thermal_pci *pci_info = devid;
 	struct proc_thermal_device *proc_priv;
-	int ret = IRQ_NONE;
+	int ret = IRQ_NONE, msi_id;
 	u32 status;
 
 	proc_priv = pci_info->proc_priv;
 
+	msi_id = proc_thermal_match_msi_irq(irq);
+
 	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_WT_HINT) {
-		if (proc_thermal_check_wt_intr(pci_info->proc_priv))
+		if (msi_id == WORKLOAD_CHANGE || proc_thermal_check_wt_intr(pci_info->proc_priv))
 			ret = IRQ_WAKE_THREAD;
 	}
 
 	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_POWER_FLOOR) {
-		if (proc_thermal_check_power_floor_intr(pci_info->proc_priv))
+		if (msi_id == THERM_POWER_FLOOR ||
+		    proc_thermal_check_power_floor_intr(pci_info->proc_priv))
 			ret = IRQ_WAKE_THREAD;
 	}
 
@@ -171,7 +202,7 @@ static irqreturn_t proc_thermal_irq_handler(int irq, void *devid)
 	 * interrupt before scheduling work function for thermal threshold.
 	 */
 	proc_thermal_mmio_read(pci_info, PROC_THERMAL_MMIO_INT_STATUS_0, &status);
-	if (status) {
+	if (msi_id == PKG_THERMAL || status) {
 		/* Disable enable interrupt flag */
 		proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_INT_ENABLE_0, 0);
 		pkg_thermal_schedule_work(&pci_info->work);
@@ -244,6 +275,45 @@ static struct thermal_zone_params tzone_params = {
 	.no_hwmon = true,
 };
 
+static bool msi_irq;
+
+static int proc_thermal_setup_msi(struct pci_dev *pdev, struct proc_thermal_pci *pci_info)
+{
+	int ret, i, irq;
+
+	ret = pci_alloc_irq_vectors(pdev, 1, MSI_THERMAL_MAX, PCI_IRQ_MSI | PCI_IRQ_MSIX);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to allocate vectors!\n");
+		return ret;
+	}
+
+	dev_info(&pdev->dev, "msi enabled:%d msix enabled:%d\n", pdev->msi_enabled,
+		 pdev->msix_enabled);
+
+	for (i = 0; i < MSI_THERMAL_MAX; i++) {
+		irq =  pci_irq_vector(pdev, i);
+
+		ret = devm_request_threaded_irq(&pdev->dev, irq, proc_thermal_irq_handler,
+						proc_thermal_irq_thread_handler,
+						0, KBUILD_MODNAME, pci_info);
+		if (ret) {
+			dev_err(&pdev->dev, "Request IRQ %d failed\n", irq);
+			goto err_free_msi_vectors;
+		}
+
+		proc_thermal_msi_map[i] = irq;
+	}
+
+	msi_irq = true;
+
+	return 0;
+
+err_free_msi_vectors:
+	pci_free_irq_vectors(pdev);
+
+	return ret;
+}
+
 static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct proc_thermal_device *proc_priv;
@@ -253,7 +323,6 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
 		.flags = THERMAL_TRIP_FLAG_RW_TEMP,
 	};
 	int irq_flag = 0, irq, ret;
-	bool msi_irq = false;
 
 	proc_priv = devm_kzalloc(&pdev->dev, sizeof(*proc_priv), GFP_KERNEL);
 	if (!proc_priv)
@@ -299,27 +368,24 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
 		goto err_del_legacy;
 	}
 
-	if (use_msi && (pdev->msi_enabled || pdev->msix_enabled)) {
-		/* request and enable interrupt */
-		ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "Failed to allocate vectors!\n");
-			goto err_ret_tzone;
-		}
+	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_MSI_SUPPORT)
+		use_msi = true;
 
-		irq =  pci_irq_vector(pdev, 0);
-		msi_irq = true;
+	if (use_msi) {
+		ret = proc_thermal_setup_msi(pdev, pci_info);
+		if (ret)
+			goto err_ret_tzone;
 	} else {
 		irq_flag = IRQF_SHARED;
 		irq = pdev->irq;
-	}
 
-	ret = devm_request_threaded_irq(&pdev->dev, irq,
-					proc_thermal_irq_handler, proc_thermal_irq_thread_handler,
-					irq_flag, KBUILD_MODNAME, pci_info);
-	if (ret) {
-		dev_err(&pdev->dev, "Request IRQ %d failed\n", pdev->irq);
-		goto err_free_vectors;
+		ret = devm_request_threaded_irq(&pdev->dev, irq, proc_thermal_irq_handler,
+						proc_thermal_irq_thread_handler, irq_flag,
+						KBUILD_MODNAME, pci_info);
+		if (ret) {
+			dev_err(&pdev->dev, "Request IRQ %d failed\n", pdev->irq);
+			goto err_ret_tzone;
+		}
 	}
 
 	ret = thermal_zone_device_enable(pci_info->tzone);
@@ -405,8 +471,8 @@ static SIMPLE_DEV_PM_OPS(proc_thermal_pci_pm, proc_thermal_pci_suspend,
 static const struct pci_device_id proc_thermal_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, ADL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
 	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WT_REQ) },
-	{ PCI_DEVICE_DATA(INTEL, LNLM_THERMAL, PROC_THERMAL_FEATURE_RAPL |
-	  PROC_THERMAL_FEATURE_DLVR) },
+	{ PCI_DEVICE_DATA(INTEL, LNLM_THERMAL, PROC_THERMAL_FEATURE_MSI_SUPPORT |
+	  PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_DLVR) },
 	{ PCI_DEVICE_DATA(INTEL, MTLP_THERMAL, PROC_THERMAL_FEATURE_RAPL |
 	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_DLVR |
 	  PROC_THERMAL_FEATURE_WT_HINT | PROC_THERMAL_FEATURE_POWER_FLOOR) },
-- 
2.40.1


