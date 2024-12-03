Return-Path: <linux-pm+bounces-18418-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD569E14DD
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 09:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14DFBB23819
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 08:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C484C1DFE32;
	Tue,  3 Dec 2024 07:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U7ZXssQI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DDB1D279F;
	Tue,  3 Dec 2024 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733212685; cv=none; b=ZS82yScvZ6Azg53TPGTcQLWf9Ewsig9JMtqUvLoHEPSVMKR5gzWI+oY5lIH5FI/zMK7KMcbXe8tPacr0LGLUfA2KRC9KSgSY0wpC20HjR0jAO8oJEAxs1jFc4gCiiC0EA3T7Nt9Dg/G/e3Ru17j7JASJFnpciIiHVL3UOARXOZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733212685; c=relaxed/simple;
	bh=tzoK3L/ZdPTVwyIcNZiwW1+1N+f655Ue0AOV/oNRWfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqilOOp6sd3BlUIwT0wrUw7R1QZS+1Y8e/IJamK/otpCq8yBcDesDIIIsQhcMEKTZpRPGMm5Mfgc1C9hl39i//i3iHLn0qcBOES90cGnoU6uTtvRMfjNpzAvz57ZKWbdGanX5J75N71ssXKTvyDqgBhFlbIqOhrFj6heOtJJbmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U7ZXssQI; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733212683; x=1764748683;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tzoK3L/ZdPTVwyIcNZiwW1+1N+f655Ue0AOV/oNRWfg=;
  b=U7ZXssQI7q6uTcFrcI0NjO69XN67W/tpS9nerFbHvFaStD020E2asg2x
   HVsOroUzpTC0QXfIVxowSiRHn1/fdSSMqCnfSRlFxx6Tr48PkBJ4N5kB9
   6GFO9Y0aUT3b3LmP1mTb28OMGHYGFZjDDlWyO+Zc76XlvVW5UEBGd1RQM
   z/vvGLM4QB02PoIWRrWu5yVWQDPXsVax+m8ibAD0wHYYVMvXDRfF3Im6D
   vp2MnSv/FOe8M/R0VPBbHacdawzZC3Kh+T0GIHnr8pitw1GjhXoHagrVF
   9L8iWL/ZHC9DRxtR+7DSj/Uq3D6PlTNr0o8adRT9yOWhLo6QwfBEUs+KO
   A==;
X-CSE-ConnectionGUID: MU/3OB7LRKGYI0FncygHhQ==
X-CSE-MsgGUID: AVPYWul/QZ+nGPMjxX4yZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="32758208"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="32758208"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 23:58:03 -0800
X-CSE-ConnectionGUID: rqoo3bFlRSKwrrZXsMXoCA==
X-CSE-MsgGUID: e2Zp7LGORSyopSaP52pIyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="93759609"
Received: from rzhang1-mobl.sh.intel.com ([10.239.158.59])
  by orviesa007.jf.intel.com with ESMTP; 02 Dec 2024 23:58:02 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	srinivas.pandruvada@intel.com
Subject: [PATCH 2/3] thermal: intel: int340x: processor: Enable MMIO RAPL for PantherLake
Date: Tue,  3 Dec 2024 15:58:01 +0800
Message-ID: <20241203075802.584741-3-rui.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203075802.584741-1-rui.zhang@intel.com>
References: <20241203075802.584741-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable MMIO RAPL support for PantherLake platform.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/intel/int340x_thermal/processor_thermal_device.h | 1 +
 .../thermal/intel/int340x_thermal/processor_thermal_device_pci.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
index d5eca6db2c00..ba2d89d3024c 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
@@ -30,6 +30,7 @@
 #define PCI_DEVICE_ID_INTEL_RPL_THERMAL	0xA71D
 #define PCI_DEVICE_ID_INTEL_SKL_THERMAL	0x1903
 #define PCI_DEVICE_ID_INTEL_TGL_THERMAL	0x9A03
+#define PCI_DEVICE_ID_INTEL_PTL_THERMAL	0xB01D
 
 struct power_config {
 	u32	index;
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index ba5d36d36fc4..a8eb4b20f26c 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -495,6 +495,7 @@ static const struct pci_device_id proc_thermal_pci_ids[] = {
 	  PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_DLVR | PROC_THERMAL_FEATURE_WT_HINT) },
 	{ PCI_DEVICE_DATA(INTEL, RPL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
 	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WT_REQ) },
+	{ PCI_DEVICE_DATA(INTEL, PTL_THERMAL, PROC_THERMAL_FEATURE_RAPL) },
 	{ },
 };
 
-- 
2.43.0


