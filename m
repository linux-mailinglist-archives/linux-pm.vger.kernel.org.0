Return-Path: <linux-pm+bounces-28701-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04969AD97A1
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 23:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 980CC189ED6D
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 21:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117CC28DB54;
	Fri, 13 Jun 2025 21:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nxG+0o34"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5511B266562;
	Fri, 13 Jun 2025 21:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749851369; cv=none; b=a+GCJI989kCqEBn/d2Pf5iz8aKvcCRrgJSM5yMOKHdLPhfCZY131xmm0mrSm+Fv7j7Ju9uPDA1l/eXCcub+bdi5/sL9UWRBxJAY/cQoU30sQggA1caOqCLYJ4+MKam4REeqPMiMLzZG022qxODC57D3zVRnWVeGaXx1KpspBm8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749851369; c=relaxed/simple;
	bh=2MgfHVzX3SwajkWGrEXV7Nx593niZm6qyNjR/CCj6VY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oMG4zbb4U6kHhny/7vqHCu+c30y8UQbkrQEMaiWT4cQx68FlijfvQNKHgGfUkUTVzOhI6qB6N7TJq4ynYPvcIhwDeNyqcls3PbHEuEmn3wVfS6vuaJrHmY57tcyUBP2m0sls5vJOPCZe7S7BKSt4E5D/0ymRphr5kkJQ3b35U/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nxG+0o34; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749851368; x=1781387368;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2MgfHVzX3SwajkWGrEXV7Nx593niZm6qyNjR/CCj6VY=;
  b=nxG+0o34M/1qxSjizMIctIjfuL/EVfJwYrGiOAHUxOdHrME6zv/oL40m
   +7sBoRcAfxN7MCA1cGoSMT3HLed3jLKcyMkVT9EMKNBLoXhwzcDgY7GoW
   X5SEwxfsviqc9WPybWrI0c+/wz4owAr5oDEhRSs+jFjDP3Xa75fc5P6vH
   djDouabrKMYt9jdGZ7ylxa40exrPCxYEe7cNzwYYbEp/N5ROfrzWnOgfJ
   8ByMLoVP/G18vVd35cfTAlA+QB9pGMIrAECVtOzG4Y0SlTiZgAvw9gz3Z
   K/wS1nsemV4BwO1Fz/nuSAICzhqwBO9MR9So/tDibwum/GuiRyJDMmQl/
   Q==;
X-CSE-ConnectionGUID: ixqproggTZKZWBeVWr0HhQ==
X-CSE-MsgGUID: Q8cffoPSQ46Tmxm+7mJejw==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="69656426"
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="69656426"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 14:49:25 -0700
X-CSE-ConnectionGUID: dnpmjTXnSy6PWHEflWr+wA==
X-CSE-MsgGUID: LceKpaVyTqyvPTIxy8J1/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="178822022"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by orviesa002.jf.intel.com with ESMTP; 13 Jun 2025 14:49:24 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rui.zhang@intel.com,
	daniel.lezcano@linaro.org,
	rafael@kernel.org,
	lukasz.luba@arm.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 2/2] thermal: intel: int340x: Allow temperature override
Date: Fri, 13 Jun 2025 14:49:23 -0700
Message-ID: <20250613214923.2910397-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250613214923.2910397-1-srinivas.pandruvada@linux.intel.com>
References: <20250613214923.2910397-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add debugfs interface to override hardware provide temperature. This
interface can be used primarily for debug. Alternatively this can
be also used to use hardware control loops to manage temperature for
virtual sensors. Virtual sensors are soft sensors created by kernel/
user space aggregating other sensors.

There are three attributes to override the maximum three instances of
platform temperature control.
/sys/kernel/debug/platform_temperature_control/
├── temperature_0
├── temperature_1
└── temperature_2

These are write only attributes requires admin privilege. Any value
greater than 0, will override the temperature. A value of 0 will
stop overriding the temperature.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2:
- correct platform spelling
- Move the ptc_create_debugfs under PROC_THERMAL_FEATURE_PTC mask

 .../platform_temperature_control.c            | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c b/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c
index 7850e91a6e2c..0ccc72c93499 100644
--- a/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c
+++ b/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c
@@ -38,6 +38,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/debugfs.h>
 #include <linux/pci.h>
 #include "processor_thermal_device.h"
 
@@ -53,6 +54,7 @@ struct mmio_reg {
 
 struct ptc_data {
 	u32 offset;
+	struct pci_dev *pdev;
 	struct attribute_group ptc_attr_group;
 	struct attribute *ptc_attrs[PTC_MAX_ATTRS];
 	struct device_attribute temperature_target_attr;
@@ -215,6 +217,63 @@ static int ptc_create_groups(struct pci_dev *pdev, int instance, struct ptc_data
 }
 
 static struct ptc_data ptc_instance[PTC_MAX_INSTANCES];
+static struct dentry *ptc_debugfs;
+
+#define PTC_TEMP_OVERRIDE_ENABLE_INDEX	4
+#define PTC_TEMP_OVERRIDE_INDEX		5
+
+static ssize_t ptc_temperature_write(struct file *file, const char __user *data,
+				     size_t count, loff_t *ppos)
+{
+	struct ptc_data *ptc_instance = file->private_data;
+	struct pci_dev *pdev = ptc_instance->pdev;
+	char buf[32];
+	ssize_t len;
+	u32 value;
+
+	len = min(count, sizeof(buf) - 1);
+	if (copy_from_user(buf, data, len))
+		return -EFAULT;
+
+	buf[len] = '\0';
+	if (kstrtouint(buf, 0, &value))
+		return -EINVAL;
+
+	if (ptc_mmio_regs[PTC_TEMP_OVERRIDE_INDEX].units)
+		value /= ptc_mmio_regs[PTC_TEMP_OVERRIDE_INDEX].units;
+
+	if (value > ptc_mmio_regs[PTC_TEMP_OVERRIDE_INDEX].mask)
+		return -EINVAL;
+
+	if (!value) {
+		ptc_mmio_write(pdev, ptc_instance->offset, PTC_TEMP_OVERRIDE_ENABLE_INDEX, 0);
+	} else {
+		ptc_mmio_write(pdev, ptc_instance->offset, PTC_TEMP_OVERRIDE_INDEX, value);
+		ptc_mmio_write(pdev, ptc_instance->offset, PTC_TEMP_OVERRIDE_ENABLE_INDEX, 1);
+	}
+
+	return count;
+}
+
+static const struct file_operations ptc_fops = {
+	.open = simple_open,
+	.write = ptc_temperature_write,
+	.llseek = generic_file_llseek,
+};
+
+static void ptc_create_debugfs(void)
+{
+	ptc_debugfs = debugfs_create_dir("platform_temperature_control", NULL);
+
+	debugfs_create_file("temperature_0",  0200, ptc_debugfs,  &ptc_instance[0], &ptc_fops);
+	debugfs_create_file("temperature_1",  0200, ptc_debugfs,  &ptc_instance[1], &ptc_fops);
+	debugfs_create_file("temperature_2",  0200, ptc_debugfs,  &ptc_instance[2], &ptc_fops);
+}
+
+static void ptc_delete_debugfs(void)
+{
+	debugfs_remove_recursive(ptc_debugfs);
+}
 
 int proc_thermal_ptc_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv)
 {
@@ -223,8 +282,11 @@ int proc_thermal_ptc_add(struct pci_dev *pdev, struct proc_thermal_device *proc_
 
 		for (i = 0; i < PTC_MAX_INSTANCES; i++) {
 			ptc_instance[i].offset = ptc_offsets[i];
+			ptc_instance[i].pdev = pdev;
 			ptc_create_groups(pdev, i, &ptc_instance[i]);
 		}
+
+		ptc_create_debugfs();
 	}
 
 	return 0;
@@ -240,6 +302,8 @@ void proc_thermal_ptc_remove(struct pci_dev *pdev)
 
 		for (i = 0; i < PTC_MAX_INSTANCES; i++)
 			sysfs_remove_group(&pdev->dev.kobj, &ptc_instance[i].ptc_attr_group);
+
+		ptc_delete_debugfs();
 	}
 }
 EXPORT_SYMBOL_GPL(proc_thermal_ptc_remove);
-- 
2.49.0


