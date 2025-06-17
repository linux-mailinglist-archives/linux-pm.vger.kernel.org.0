Return-Path: <linux-pm+bounces-28928-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24793ADDF88
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 01:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCC927A477D
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 23:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBADA29B78E;
	Tue, 17 Jun 2025 23:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZFEJsdLe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144012957AD;
	Tue, 17 Jun 2025 23:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750202393; cv=none; b=qRgzuCkqDEVuPvIN3rclUMwgSuVwCAZsANblmZPH4Dwl/cdOE/PJSxmZiqIklmBAmeVO5thrbCpAQ3nV6zs3oTj4bP7M04+zwHJD6V5LhkGNYBNMjKEFPIIgLzyaDzCAroyGvAANxZF24iV2Rig/Bs7FF314P7tMBWH7d6aYT+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750202393; c=relaxed/simple;
	bh=w4a/xlZzvzSTeyCYtqL9aFLjbsWcjKMfPUooqnwUlXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Or85ZStXCWGnacc0kxJlhjAIB24JtNYcYRXEwnMA0DJ1N91PI1a+mFObh/lCe7PYpK7KVG0EjP12UzzV4+XRHuehmPTYZz54cEJ9Aeti5C8cvLvhDdLVyvQdLOzV6xvJ9PInkcIs/4LP//W29N/IceGXp7kbTaK5RCgaVp556PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZFEJsdLe; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750202392; x=1781738392;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w4a/xlZzvzSTeyCYtqL9aFLjbsWcjKMfPUooqnwUlXU=;
  b=ZFEJsdLevJg05UmzxzZrRZUFnj7bp73Hh1Or+eHWmOWgrwQpI0aZy3hj
   9SB/kak7iYn1m/6YW3I4u/X0HZuXAaDBGUfg+YNWadB74USzXf6Yjlv3e
   P4gfsdSwWtpDU3z9jjk0WOMIvIappRjfXaroUYJnnEYV7P9LahW2ONrfo
   0IzDfVB3sfprGWcXXTVJcl9UYwaQ2OU9uVtPQRbkB0H1CWI7JWPB9D2cR
   z2fxAPSJvuAOVQh5TNyhjAA2zp6SE3ceKvJG7gWmGYWj9h4G5TW22yG1Q
   RUrlMiSOMmFzISpw8AWmvJhVZZ12hvlDwGkS9B0gFpNEX0Vmyrnxet4Yw
   g==;
X-CSE-ConnectionGUID: RTnOJGrYQGyANF+t/b1TeQ==
X-CSE-MsgGUID: Nxjpg6YiQ6evvdPe1TOqiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="63439716"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="63439716"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 16:19:52 -0700
X-CSE-ConnectionGUID: JaLInWayQWiJjpRNfSwbfg==
X-CSE-MsgGUID: pQ6mF+dRQWuhjiqMsiw52w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="152921944"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by fmviesa003.fm.intel.com with ESMTP; 17 Jun 2025 16:19:51 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rui.zhang@intel.com,
	daniel.lezcano@linaro.org,
	rafael@kernel.org,
	lukasz.luba@arm.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal: int340x: processor_thermal: Add Wildcat Lake PCI ID
Date: Tue, 17 Jun 2025 16:19:40 -0700
Message-ID: <20250617231940.3314546-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Wildcat Lake PCI ID for processor thermal device.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../thermal/intel/int340x_thermal/processor_thermal_device.h  | 1 +
 .../intel/int340x_thermal/processor_thermal_device_pci.c      | 4 ++++
 .../thermal/intel/int340x_thermal/processor_thermal_rfim.c    | 1 +
 3 files changed, 6 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
index 9a6ca43b6fa2..49398794124a 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
@@ -31,6 +31,7 @@
 #define PCI_DEVICE_ID_INTEL_SKL_THERMAL	0x1903
 #define PCI_DEVICE_ID_INTEL_TGL_THERMAL	0x9A03
 #define PCI_DEVICE_ID_INTEL_PTL_THERMAL	0xB01D
+#define PCI_DEVICE_ID_INTEL_WCL_THERMAL	0xFD1D
 
 struct power_config {
 	u32	index;
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index 00160936070a..d4d7e8e147d2 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -499,6 +499,10 @@ static const struct pci_device_id proc_thermal_pci_ids[] = {
 	  PROC_THERMAL_FEATURE_DLVR | PROC_THERMAL_FEATURE_DVFS |
 	  PROC_THERMAL_FEATURE_MSI_SUPPORT | PROC_THERMAL_FEATURE_WT_HINT |
 	  PROC_THERMAL_FEATURE_POWER_FLOOR | PROC_THERMAL_FEATURE_PTC) },
+	{ PCI_DEVICE_DATA(INTEL, WCL_THERMAL, PROC_THERMAL_FEATURE_MSI_SUPPORT |
+	  PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_DLVR |
+	  PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WT_HINT |
+	  PROC_THERMAL_FEATURE_POWER_FLOOR | PROC_THERMAL_FEATURE_PTC) },
 	{ },
 };
 
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
index 3a028b78d9af..1f3d22b659db 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
@@ -442,6 +442,7 @@ int proc_thermal_rfim_add(struct pci_dev *pdev, struct proc_thermal_device *proc
 		switch (pdev->device) {
 		case PCI_DEVICE_ID_INTEL_LNLM_THERMAL:
 		case PCI_DEVICE_ID_INTEL_PTL_THERMAL:
+		case PCI_DEVICE_ID_INTEL_WCL_THERMAL:
 			dlvr_mmio_regs_table = lnl_dlvr_mmio_regs;
 			dlvr_mapping = lnl_dlvr_mapping;
 			break;
-- 
2.49.0


