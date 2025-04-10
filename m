Return-Path: <linux-pm+bounces-25157-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A874A84AFD
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 19:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 370501B8729A
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 17:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94C921ABD1;
	Thu, 10 Apr 2025 17:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aUDPTE5T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BAA202C2A;
	Thu, 10 Apr 2025 17:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306187; cv=none; b=XuIblxt1aTHzhJxuX1qOsXzZLZDLBS2abxVOId6j0bF3zmJBhundGa2mBTCss36Sd5l1I4KlI300V5g6khwlt5hPDwDLdRa4TAlSbLj0TZZsAbmSINHYI3MoYNfU/XcbgBY9LbBC5KZ0ByH8GP9tBvOvkwLQQZ4CoPS7AzCRA/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306187; c=relaxed/simple;
	bh=RjhLzH5nFiR2QsgGOwzFzRiV6M20em0PyAetnxJO54M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IOYkFEHbgGiZr0MSh6zgmgkq039d5KwIoY+LfpQ8ZYnVRZS559Bj9e6SDu2ZcSwrI9nk/QDJYaV/4eWM9XmPQ7w5sCUA8iDKSmJuoeEtS0dtI5oWvO0YxmvTwy94GFIrSukPQu/XaBCoUUnB5iqezLwsLtHy5NnfkykKvPsQAlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aUDPTE5T; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744306186; x=1775842186;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RjhLzH5nFiR2QsgGOwzFzRiV6M20em0PyAetnxJO54M=;
  b=aUDPTE5TsGWNlbbHdeNRr8cAqD5npMpU/+F0DcClRJP2mdzcZgA3h9kT
   JN/qtka3R3k/10hRutWoaQu2fGgOFoBKxM+eFyhnyf457pSZxSFwYvtk4
   WKvxXnXiMxwJrWqAEVKyPouaT9cVCVopXYAtm+RvNboeVahg4ush4tSc7
   kjO8qxEDOyw9Nsnz63PHshPXqIBaibXDdpk81uxmySDLsARICT/q4Qdz3
   6eufkIeDrhXqpWPZP2OlWAUK+KYmrq2xSM0bK3kDUxSVdq02VaSR/OUeP
   rF7UcRQE7nr7+hqq+sXfzSvKF5g7g1VMbfmHNoADgSDT3Flx6g2CBoIX2
   g==;
X-CSE-ConnectionGUID: 9OJjlYciTZCEQtLnSFh9Iw==
X-CSE-MsgGUID: 7D4tubRBTDKBt5F2ds/vIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="68329731"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="68329731"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 10:29:46 -0700
X-CSE-ConnectionGUID: Ynd4baNKQ+CXPfkkCjCeOg==
X-CSE-MsgGUID: BFuJHxExTSWu3dIdMfiO5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="128828612"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by fmviesa006.fm.intel.com with ESMTP; 10 Apr 2025 10:29:45 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal: intel: int340x: Add missing DVFS support
Date: Thu, 10 Apr 2025 10:29:43 -0700
Message-ID: <20250410172943.577913-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DVFS (Dynamic Voltage Frequency Scaling) is still supported for DDR
memories on Lunar Lake and Panther Lake.

Add the missing flag PROC_THERMAL_FEATURE_DVFS.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel/int340x_thermal/processor_thermal_device_pci.c   | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index a55aaa8cef42..2097aae39946 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -485,7 +485,7 @@ static const struct pci_device_id proc_thermal_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, ADL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
 	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WT_REQ) },
 	{ PCI_DEVICE_DATA(INTEL, LNLM_THERMAL, PROC_THERMAL_FEATURE_MSI_SUPPORT |
-	  PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_DLVR |
+	  PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_DLVR | PROC_THERMAL_FEATURE_DVFS |
 	  PROC_THERMAL_FEATURE_WT_HINT | PROC_THERMAL_FEATURE_POWER_FLOOR) },
 	{ PCI_DEVICE_DATA(INTEL, MTLP_THERMAL, PROC_THERMAL_FEATURE_RAPL |
 	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_DLVR |
@@ -495,8 +495,9 @@ static const struct pci_device_id proc_thermal_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, RPL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
 	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WT_REQ) },
 	{ PCI_DEVICE_DATA(INTEL, PTL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
-	  PROC_THERMAL_FEATURE_DLVR | PROC_THERMAL_FEATURE_MSI_SUPPORT |
-	  PROC_THERMAL_FEATURE_WT_HINT | PROC_THERMAL_FEATURE_POWER_FLOOR) },
+	  PROC_THERMAL_FEATURE_DLVR | PROC_THERMAL_FEATURE_DVFS |
+	  PROC_THERMAL_FEATURE_MSI_SUPPORT | PROC_THERMAL_FEATURE_WT_HINT |
+	  PROC_THERMAL_FEATURE_POWER_FLOOR) },
 	{ },
 };
 
-- 
2.49.0


