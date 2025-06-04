Return-Path: <linux-pm+bounces-28129-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36772ACE5C9
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 22:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B76D91896B25
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 20:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E8220E71C;
	Wed,  4 Jun 2025 20:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d4xpFs3b"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6752E1E0489;
	Wed,  4 Jun 2025 20:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749069332; cv=none; b=DkglQ7DcGgnC7mNcQCT4h9ARcM3RrAxLkTc3e/TAxU6yEedn1B7Vw/rzX8M0l0csUpmhJYUaGuJ/Jfjjj5vpjMaHy1+YASi09eDd8ImyMH81XsW7NBeC7rLbNDqILIsWVyY8em6CuN8WdT0QUOLRqr1H8ZZeEZCKBohSKLVjF6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749069332; c=relaxed/simple;
	bh=VirPm/RoBkw5zW/IxfKpKnRYxukitfwIFLDdgtJJ+ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YHx0NFLQg3nEK+2EinKLQTu/mtXjQtvrnCIPnbkTfuy32hsPF9IwMuN1VjNapPdxY5MQvQ02TQEu66Dft2k+bTyPGe9JyQKq8UipjBZH8Ei0fyqxmQK8rBAL2SzMbw4eKO2o8fgYSmZ8+PV9LT6+nda8g3Y1B+pfw3r2G2GAPnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d4xpFs3b; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749069330; x=1780605330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VirPm/RoBkw5zW/IxfKpKnRYxukitfwIFLDdgtJJ+ls=;
  b=d4xpFs3b4b6+XPrbgEa5ZIRlVp47IBshOBmLZM0YrRmJxRV6/Ww06B/Q
   YC81OGw5tSCwO1k6di3bP+Fj0CkRdbJc9eU/+D2dBJMc+Vj3Wf++ze14N
   fOX8cN3caPMmTKGu5aPrNILZaWXg1UYgPfdhCwkNMGjB6I9IU+d6WHtrY
   IGz4wP5nkGa7LkVssCe9Ih6c4/F/7wsdE7TF+EowKEc11Mu4A8SwqYOt/
   6J+BrUEQZ6/Eov+eozXyptDPP4Az/+bM+hcaPBBmxVFN6Z86ME6v6Z0G8
   9iQHVMfo6H/uu5c2wknpHCEJyjZkjpV2JCzKQcAYPi6hI5i7cmf4RHR7m
   A==;
X-CSE-ConnectionGUID: jeM/r9vYQLSm2RV5rfsFOA==
X-CSE-MsgGUID: I8A5ohZ7St6I1P9FM/B/Bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="61788245"
X-IronPort-AV: E=Sophos;i="6.16,210,1744095600"; 
   d="scan'208";a="61788245"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 13:35:25 -0700
X-CSE-ConnectionGUID: U6/fZCp7Tf2CK0x91M5YbQ==
X-CSE-MsgGUID: 5tXF31dJTNidBxxMnKbACQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,210,1744095600"; 
   d="scan'208";a="168461796"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by fmviesa002.fm.intel.com with ESMTP; 04 Jun 2025 13:35:25 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rui.zhang@intel.com,
	daniel.lezcano@linaro.org,
	rafael@kernel.org,
	lukasz.luba@arm.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/2] thermal: intel: int340x: Allow temperature override
Date: Wed,  4 Jun 2025 13:35:18 -0700
Message-ID: <20250604203518.2330533-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250604203518.2330533-1-srinivas.pandruvada@linux.intel.com>
References: <20250604203518.2330533-1-srinivas.pandruvada@linux.intel.com>
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
/sys/kernel/debug/plaftform_temperature_control/
├── temperature_0
├── temperature_1
└── temperature_2

These are write only attributes requires admin privilege. Any value
greater than 0, will override the temperature. A value of 0 will
stop overriding the temperature.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../platform_temperature_control.c            | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c b/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c
index 6cd05783a52d..5dcfd2cc9082 100644
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
@@ -222,6 +224,63 @@ static int ptc_create_groups(struct pci_dev *pdev, int instance, struct ptc_data
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
+	ptc_debugfs = debugfs_create_dir("plaftform_temperature_control", NULL);
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
@@ -230,10 +289,13 @@ int proc_thermal_ptc_add(struct pci_dev *pdev, struct proc_thermal_device *proc_
 
 		for (i = 0; i < PTC_MAX_INSTANCES; i++) {
 			ptc_instance[i].offset = ptc_offsets[i];
+			ptc_instance[i].pdev = pdev;
 			ptc_create_groups(pdev, i, &ptc_instance[i]);
 		}
 	}
 
+	ptc_create_debugfs();
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(proc_thermal_ptc_add);
@@ -248,6 +310,8 @@ void proc_thermal_ptc_remove(struct pci_dev *pdev)
 		for (i = 0; i < PTC_MAX_INSTANCES; i++)
 			sysfs_remove_group(&pdev->dev.kobj, &ptc_instance[i].ptc_attr_group);
 	}
+
+	ptc_delete_debugfs();
 }
 EXPORT_SYMBOL_GPL(proc_thermal_ptc_remove);
 
-- 
2.49.0


