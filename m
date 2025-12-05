Return-Path: <linux-pm+bounces-39259-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A16CA98F4
	for <lists+linux-pm@lfdr.de>; Sat, 06 Dec 2025 00:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 94DF8301B3CC
	for <lists+linux-pm@lfdr.de>; Fri,  5 Dec 2025 23:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31602D878D;
	Fri,  5 Dec 2025 23:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fWTnRhdp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A691D130E;
	Fri,  5 Dec 2025 23:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764975622; cv=none; b=L7IJ8TmW4bt8t+xiz2ZEOzLDn6JACJWFQlV1eRqBrYp1GHUqStXX4lWdvZkGz0b5uFURVDnqXr1Vs6JThVJyu1+QP+kC4ollVi+Kug14555veoCN203UzRMsbubBPgzbnSTXDmsIb5b8J9f3GvxgR5uJV5TWZHzYp5Nb6/eB/l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764975622; c=relaxed/simple;
	bh=GH2+L5qh76nVQerKzhGtOMp+E/SSTIgxzLPYsFe4eVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KoawIWE+6k+vzcG6rixKVqWMQEPhLaz5jHhuXIxpZgrh41PIDk4RbUy3vzYb0BNRs3Zau00KDsQk9Fs26eJ9JAnw5Pt77gInHNCULLTYaK3ssr66XTDgH6u/Rz4yViSz380t9malqWvMBm8Tz5Fz4QyCwBFUk4q0Ztbh+MJMERo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fWTnRhdp; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764975620; x=1796511620;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GH2+L5qh76nVQerKzhGtOMp+E/SSTIgxzLPYsFe4eVI=;
  b=fWTnRhdp0Yqgi2Ny/T2hNoTbf6Y/OIY8o2EFiMzB9gCvCFoKda9f5ANm
   O+4K961Yv2anHPqYLW8+/7tHcMhQCC07hMYFewzHFg8yf7VQ3oH/yYCIX
   TbA04/tBVMFd4TVQ7FocUSt9sSSaruTlyvnBWTJKWxNGrqANc2xVI0WFV
   F55iJ9/AZ42coBTC1bSKcCwzW/Bu9sWqxQ9e8OUlej4pmhbmNODFsBDhA
   /ApsBC5YIpxfNkj0TK6aG19tXsw8Hz0HdacNMC281YFq+Qw0CYNTrYNxb
   ddPI/teSiVM/JKneNYvWnPSXQsJPXAsWNxJC+Euxbs6tEN/yq9R32mkBp
   g==;
X-CSE-ConnectionGUID: 1EGtDEQVTXSFOPkutoqJUw==
X-CSE-MsgGUID: fbMr0gsKSqq8V9Fd5DF1UA==
X-IronPort-AV: E=McAfee;i="6800,10657,11633"; a="67052851"
X-IronPort-AV: E=Sophos;i="6.20,253,1758610800"; 
   d="scan'208";a="67052851"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 15:00:20 -0800
X-CSE-ConnectionGUID: HW2+RMcrRZm0bYBPGsWFYw==
X-CSE-MsgGUID: zSVPUXI8Qwq/BBkvaBJksg==
X-ExtLoop1: 1
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by fmviesa003.fm.intel.com with ESMTP; 05 Dec 2025 15:00:19 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal: intel: int340x: Enable power slider interface for Wildcat Lake
Date: Fri,  5 Dec 2025 15:00:07 -0800
Message-ID: <20251205230007.2218533-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set the PROC_THERMAL_FEATURE_SOC_POWER_SLIDER feature flag in
proc_thermal_pci_ids[] for Wildcat Lake to enable power slider interface.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel/int340x_thermal/processor_thermal_device_pci.c       | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index 0d4dcc66e097..c693d934103a 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -503,7 +503,8 @@ static const struct pci_device_id proc_thermal_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, WCL_THERMAL, PROC_THERMAL_FEATURE_MSI_SUPPORT |
 	  PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_DLVR |
 	  PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WT_HINT |
-	  PROC_THERMAL_FEATURE_POWER_FLOOR | PROC_THERMAL_FEATURE_PTC) },
+	  PROC_THERMAL_FEATURE_POWER_FLOOR | PROC_THERMAL_FEATURE_PTC |
+	  PROC_THERMAL_FEATURE_SOC_POWER_SLIDER) },
 	{ PCI_DEVICE_DATA(INTEL, NVL_H_THERMAL, PROC_THERMAL_FEATURE_RAPL |
 	  PROC_THERMAL_FEATURE_DLVR | PROC_THERMAL_FEATURE_DVFS |
 	  PROC_THERMAL_FEATURE_MSI_SUPPORT | PROC_THERMAL_FEATURE_WT_HINT |
-- 
2.51.1


