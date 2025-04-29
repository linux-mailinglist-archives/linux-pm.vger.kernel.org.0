Return-Path: <linux-pm+bounces-26341-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E978A9FE09
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 02:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C4D31888B7C
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 00:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7246B197A8A;
	Tue, 29 Apr 2025 00:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CJfwng2Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6787D1C6B4;
	Tue, 29 Apr 2025 00:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745884884; cv=none; b=rt0eoTWa2g9VEtx5PMxzg1j7dD+tLYtHjDqtOOydfR3fFkctigzVI5/EfCoQ7VQWfCs3rOvND4oK1wud2klDTjOK4nHDsGCjZL0TZyJYsFSmRmnGfvy1KjQXwJDaD96rAwe1pQyd//KtuQ2MWVQmE4s8wPnfWC8BKF8sD59bNvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745884884; c=relaxed/simple;
	bh=XUZSTA7s7f3Lzrhz30+Lmdb5WQPqUWXdAq7WdsfwF+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jp6XzxB5kUUEjMSlxVM7j2EgkzZs5gCoWSdKY2qvo8rzzYFuJnTJyWdlVrEu51b8deFIhppwNvGwiiYriqjmETcj538150hwCW1lF4oEpixfoTVXG7UbDX2FfrWNfaT2N4JKz4zt+8b9JIO6HB/IJ+8GY6I5wJGsr/tdQ/HGmYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CJfwng2Y; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745884882; x=1777420882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XUZSTA7s7f3Lzrhz30+Lmdb5WQPqUWXdAq7WdsfwF+A=;
  b=CJfwng2Y4owqW9REblM9T71wQUSt3ZEgD9QjMTYQsnBvfgfWjlDRMCvx
   MOOYB8T+GupfgLnOKHVRHrtPrSPBasmMreAlUMweoyZvcuJJ3g/0s9l05
   s43W3uUBY6itN70SR90EdLFSV6nfdKi9HIfp4Fbz2EJanbu3uNn+FU5a8
   SCZrEjVKaU9hHuw1VHwi/LKjlE/WLOwuGDjX7au+aOOHvlectEU6WkykG
   OeHHTeKiOm9JjG5qbuqS/EbxW6c5Wx+djB9kLXnf/lugU3GUl8n/5F9RW
   dFe4hEu7KZiGMhibl2NJ7WsHpEybaMaWOTV9C/VYxyOmVbvij/oeE7koL
   Q==;
X-CSE-ConnectionGUID: GVeLqRDwQxOkU++7ZNTjwQ==
X-CSE-MsgGUID: M76rSxlDT8KYhC+J42Zxvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="58864058"
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="58864058"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 17:01:19 -0700
X-CSE-ConnectionGUID: lVYtA7s1Q+OuwpBT7MtwOQ==
X-CSE-MsgGUID: SqX2/d9VS1aNmJyYtW2JpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="133386493"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by orviesa009.jf.intel.com with ESMTP; 28 Apr 2025 17:01:19 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rui.zhang@intel.com,
	daniel.lezcano@linaro.org,
	rafael@kernel.org,
	lukasz.luba@arm.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 2/3] thermal: intel: int340x: Enable platform temperature control
Date: Mon, 28 Apr 2025 17:01:09 -0700
Message-ID: <20250429000110.236243-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250429000110.236243-1-srinivas.pandruvada@linux.intel.com>
References: <20250429000110.236243-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable platform temperature control feature for Lunar Lake and
Panther Lake.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2:
No change

 .../intel/int340x_thermal/processor_thermal_device_pci.c     | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index 2097aae39946..00160936070a 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -486,7 +486,8 @@ static const struct pci_device_id proc_thermal_pci_ids[] = {
 	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WT_REQ) },
 	{ PCI_DEVICE_DATA(INTEL, LNLM_THERMAL, PROC_THERMAL_FEATURE_MSI_SUPPORT |
 	  PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_DLVR | PROC_THERMAL_FEATURE_DVFS |
-	  PROC_THERMAL_FEATURE_WT_HINT | PROC_THERMAL_FEATURE_POWER_FLOOR) },
+	  PROC_THERMAL_FEATURE_WT_HINT | PROC_THERMAL_FEATURE_POWER_FLOOR |
+	  PROC_THERMAL_FEATURE_PTC) },
 	{ PCI_DEVICE_DATA(INTEL, MTLP_THERMAL, PROC_THERMAL_FEATURE_RAPL |
 	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_DLVR |
 	  PROC_THERMAL_FEATURE_WT_HINT | PROC_THERMAL_FEATURE_POWER_FLOOR) },
@@ -497,7 +498,7 @@ static const struct pci_device_id proc_thermal_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, PTL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
 	  PROC_THERMAL_FEATURE_DLVR | PROC_THERMAL_FEATURE_DVFS |
 	  PROC_THERMAL_FEATURE_MSI_SUPPORT | PROC_THERMAL_FEATURE_WT_HINT |
-	  PROC_THERMAL_FEATURE_POWER_FLOOR) },
+	  PROC_THERMAL_FEATURE_POWER_FLOOR | PROC_THERMAL_FEATURE_PTC) },
 	{ },
 };
 
-- 
2.49.0


