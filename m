Return-Path: <linux-pm+bounces-25243-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC31A85C4D
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 13:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D9E16E253
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 11:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8019227CCEA;
	Fri, 11 Apr 2025 11:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yu44am9v"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9526A1DE3C7;
	Fri, 11 Apr 2025 11:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744372483; cv=none; b=fBsGQ5WPJMX3VYuztit6DNJB50lSQulW1b36WQhO7ngYunRz+LLw3NALBnKiiYrcjWvljmTxw67EJPmfMIze4VXEopXc4htS7DFoXFhlP+khw+P0xQwDTAGZF+d4Y/xyXYL7kSiJ0boRxbetSjhksmE9m5laq9k+PTbtpWHsSF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744372483; c=relaxed/simple;
	bh=FkkJf/hTRJd9G+IbffEny8MkSPwptYc8MpG0MAAxlvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=izWkPaDU6xU5B5rZJ3TGF+PEDEt3vNAlDMs6D1jbof/EkBQGytYmzSmpKGjecCC2JhVcQSPtG0jdEStSTrM3PPkB4VOj6nbe61UdGm5DcQDk0tIl44IpCbyZkADkcIGQ0PZs+kwGMPVWuZVsoB/dPjTfjrC8cHAaUttMNmtig0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yu44am9v; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744372482; x=1775908482;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FkkJf/hTRJd9G+IbffEny8MkSPwptYc8MpG0MAAxlvI=;
  b=Yu44am9vDkqvGEQs4D++JqUdTd8CyyzPd24akKjhNy5DRvmgCZsNpeGM
   M78C6eg3fbXex/xxPx2xW+UP/LTG1MCaDlqwM+fKUBSCurCrUJ5dJX9k3
   4U4bJT6y9T1bryfd7PNr0c/UGR7Orar9GqGsuzDFgXdiXaSe3rlniTCx3
   rI3ZPuFK+Nou11orwXtPDey2R3N1Ulh3xrBiTMmQv5jbVIDf+VmAcYej1
   hICKmbm+RtKgz+/YluR+tarSxbM7LJ4Gm6r0UX+BufxEXJ0J1Au2hVEn5
   /Miyklb+Pk4LmW+jeigBrrNwGHRQqoSzlBQxwuReaRD20gMb3091eil2M
   g==;
X-CSE-ConnectionGUID: s4JmWa6pTvq7lO4l4T0Wlg==
X-CSE-MsgGUID: ceZHJgLWQleXidKmA57eWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="56566792"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="56566792"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 04:54:40 -0700
X-CSE-ConnectionGUID: KhyK7pI+TIqKkR5vc0rFHw==
X-CSE-MsgGUID: REe/K4z4QNSmfO1Is0nqVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="129176852"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by fmviesa007.fm.intel.com with ESMTP; 11 Apr 2025 04:54:40 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal: intel: int340x: Fix Panther Lake DLVR support
Date: Fri, 11 Apr 2025 04:54:38 -0700
Message-ID: <20250411115438.594114-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Panther lake uses same register offsets as Lunar Lake. But the
registers are still pointing to the default table.

Move the selection of register offsets table from the actual attribute
read/write callbacks to the proc_thermal_rfim_add(). This way it is clean
and in future such issues can be avoided.

Fixes: e50eeababa94 ("thermal: intel: int340x: Panther Lake DLVR support")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../int340x_thermal/processor_thermal_rfim.c  | 33 ++++++++++---------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
index dad63f2d5f90..3a028b78d9af 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
@@ -166,15 +166,18 @@ static const struct mmio_reg adl_dvfs_mmio_regs[] = {
 	{ 0, 0x5A40, 1, 0x1, 0}, /* rfi_disable */
 };
 
+static const struct mapping_table *dlvr_mapping;
+static const struct mmio_reg *dlvr_mmio_regs_table;
+
 #define RFIM_SHOW(suffix, table)\
 static ssize_t suffix##_show(struct device *dev,\
 			      struct device_attribute *attr,\
 			      char *buf)\
 {\
-	const struct mapping_table *mapping = NULL;\
+	const struct mmio_reg *mmio_regs = dlvr_mmio_regs_table;\
+	const struct mapping_table *mapping = dlvr_mapping;\
 	struct proc_thermal_device *proc_priv;\
 	struct pci_dev *pdev = to_pci_dev(dev);\
-	const struct mmio_reg *mmio_regs;\
 	const char **match_strs;\
 	int ret, err;\
 	u32 reg_val;\
@@ -186,12 +189,6 @@ static ssize_t suffix##_show(struct device *dev,\
 		mmio_regs = adl_dvfs_mmio_regs;\
 	} else if (table == 2) { \
 		match_strs = (const char **)dlvr_strings;\
-		if (pdev->device == PCI_DEVICE_ID_INTEL_LNLM_THERMAL) {\
-			mmio_regs = lnl_dlvr_mmio_regs;\
-			mapping = lnl_dlvr_mapping;\
-		} else {\
-			mmio_regs = dlvr_mmio_regs;\
-		} \
 	} else {\
 		match_strs = (const char **)fivr_strings;\
 		mmio_regs = tgl_fivr_mmio_regs;\
@@ -214,12 +211,12 @@ static ssize_t suffix##_store(struct device *dev,\
 			       struct device_attribute *attr,\
 			       const char *buf, size_t count)\
 {\
-	const struct mapping_table *mapping = NULL;\
+	const struct mmio_reg *mmio_regs = dlvr_mmio_regs_table;\
+	const struct mapping_table *mapping = dlvr_mapping;\
 	struct proc_thermal_device *proc_priv;\
 	struct pci_dev *pdev = to_pci_dev(dev);\
 	unsigned int input;\
 	const char **match_strs;\
-	const struct mmio_reg *mmio_regs;\
 	int ret, err;\
 	u32 reg_val;\
 	u32 mask;\
@@ -230,12 +227,6 @@ static ssize_t suffix##_store(struct device *dev,\
 		mmio_regs = adl_dvfs_mmio_regs;\
 	} else if (table == 2) { \
 		match_strs = (const char **)dlvr_strings;\
-		if (pdev->device == PCI_DEVICE_ID_INTEL_LNLM_THERMAL) {\
-			mmio_regs = lnl_dlvr_mmio_regs;\
-			mapping = lnl_dlvr_mapping;\
-		} else {\
-			mmio_regs = dlvr_mmio_regs;\
-		} \
 	} else {\
 		match_strs = (const char **)fivr_strings;\
 		mmio_regs = tgl_fivr_mmio_regs;\
@@ -448,6 +439,16 @@ int proc_thermal_rfim_add(struct pci_dev *pdev, struct proc_thermal_device *proc
 	}
 
 	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_DLVR) {
+		switch (pdev->device) {
+		case PCI_DEVICE_ID_INTEL_LNLM_THERMAL:
+		case PCI_DEVICE_ID_INTEL_PTL_THERMAL:
+			dlvr_mmio_regs_table = lnl_dlvr_mmio_regs;
+			dlvr_mapping = lnl_dlvr_mapping;
+			break;
+		default:
+			dlvr_mmio_regs_table = dlvr_mmio_regs;
+			break;
+		}
 		ret = sysfs_create_group(&pdev->dev.kobj, &dlvr_attribute_group);
 		if (ret)
 			return ret;
-- 
2.49.0


