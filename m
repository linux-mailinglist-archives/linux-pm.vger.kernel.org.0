Return-Path: <linux-pm+bounces-37768-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 142AEC49E5B
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 01:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8D67534BC4A
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 00:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06771DF258;
	Tue, 11 Nov 2025 00:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fSnOxdkF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DE2288D2;
	Tue, 11 Nov 2025 00:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762821956; cv=none; b=IU1iODPjb6H10Lw0VifmgBzMBeCxUrT6rjEEVrUWAS+b5LTlzk04eIOG7c9HRGTkDSMAy+g+TSPTEo5x1tFq8Li3Yo/S6FO2k5NumvmB6hL2iW4T8gPpXM31iJ2PeE9LtjJB9fRfVYfBWYRqS4O2AHyUzXRtbl+T2hMmZy4lmRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762821956; c=relaxed/simple;
	bh=b8cD4WvVEexbf9p6szJdPbYyfldjKMN1ilpVL86gdg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=htxmqckk2E2mH5wDI0Phptt4TIsPNHjmSHLgCX6I5bY6NDWFbUUic9j2gatcPM6PNOUQiswdrBY/u4hHswHbL0nJvG5bbOQ9hMO71Z+JBc8Mr07kcAiRLAt4kd89Q4ESFkQwNxRHtM7zauTbhaaHeawBTQqsUDZCNFjtMDniF94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fSnOxdkF; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762821954; x=1794357954;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b8cD4WvVEexbf9p6szJdPbYyfldjKMN1ilpVL86gdg4=;
  b=fSnOxdkFSN7yjJlOQsVs3oQJZRjxILAjyHcZ3yyy4SSXRNjZC/3ZLGh1
   hUOJCuosIebEsR+RJdfBh3vsDrhHp8pSOyWUxMxBTU5XfCyJKnB0aGUPr
   WWS5Ld8jfq4bDiq9QNChay2QNTt1BYe8P5FDRFnLTXJFw1Q5DDOT8Fnxl
   xU2cxPxhp2ykcr4XWOD89kMmS4tgge4snxrjArIoHvtAN3oMdBRR/z4eA
   FROEiaZpK8LS9w8PP5aRmn44vu7l6id8ORcIp6IRtXCL1cSXJW9VXGoAX
   eDBPl3cGmDYdRtnbeF6yZi8fRGcwWnMIK+n8HaJHmEAwu+5BKiKMOU6qU
   Q==;
X-CSE-ConnectionGUID: CnUyKNwvRKiGrKLZejNhWA==
X-CSE-MsgGUID: hqe8ipKARHaKYQPsWT1FcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64792708"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64792708"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 16:45:54 -0800
X-CSE-ConnectionGUID: ST1rCEzTRE2ucBhd8LYDvg==
X-CSE-MsgGUID: jIYehKRxShuVbQCmWOcp9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="189258884"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by fmviesa009.fm.intel.com with ESMTP; 10 Nov 2025 16:45:53 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/3] thermal: int340x: processor_thermal: Add Nova Lake processor thermal device
Date: Mon, 10 Nov 2025 16:45:50 -0800
Message-ID: <20251111004552.137984-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add PCI IDs for Nova Lake processor thermal device.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel/int340x_thermal/processor_thermal_device.h   |  2 ++
 .../int340x_thermal/processor_thermal_device_pci.c     | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
index 30760475102f..b79937a386ec 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
@@ -27,6 +27,8 @@
 #define PCI_DEVICE_ID_INTEL_JSL_THERMAL	0x4E03
 #define PCI_DEVICE_ID_INTEL_LNLM_THERMAL	0x641D
 #define PCI_DEVICE_ID_INTEL_MTLP_THERMAL	0x7D03
+#define PCI_DEVICE_ID_INTEL_NVL_H_THERMAL	0xD703
+#define PCI_DEVICE_ID_INTEL_NVL_S_THERMAL	0xAD03
 #define PCI_DEVICE_ID_INTEL_RPL_THERMAL	0xA71D
 #define PCI_DEVICE_ID_INTEL_SKL_THERMAL	0x1903
 #define PCI_DEVICE_ID_INTEL_TGL_THERMAL	0x9A03
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index e2471768d355..0d4dcc66e097 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -504,6 +504,16 @@ static const struct pci_device_id proc_thermal_pci_ids[] = {
 	  PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_DLVR |
 	  PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WT_HINT |
 	  PROC_THERMAL_FEATURE_POWER_FLOOR | PROC_THERMAL_FEATURE_PTC) },
+	{ PCI_DEVICE_DATA(INTEL, NVL_H_THERMAL, PROC_THERMAL_FEATURE_RAPL |
+	  PROC_THERMAL_FEATURE_DLVR | PROC_THERMAL_FEATURE_DVFS |
+	  PROC_THERMAL_FEATURE_MSI_SUPPORT | PROC_THERMAL_FEATURE_WT_HINT |
+	  PROC_THERMAL_FEATURE_POWER_FLOOR | PROC_THERMAL_FEATURE_PTC |
+	  PROC_THERMAL_FEATURE_SOC_POWER_SLIDER) },
+	{ PCI_DEVICE_DATA(INTEL, NVL_S_THERMAL, PROC_THERMAL_FEATURE_RAPL |
+	  PROC_THERMAL_FEATURE_DLVR | PROC_THERMAL_FEATURE_DVFS |
+	  PROC_THERMAL_FEATURE_MSI_SUPPORT | PROC_THERMAL_FEATURE_WT_HINT |
+	  PROC_THERMAL_FEATURE_POWER_FLOOR | PROC_THERMAL_FEATURE_PTC |
+	  PROC_THERMAL_FEATURE_SOC_POWER_SLIDER) },
 	{ },
 };
 
-- 
2.51.0


