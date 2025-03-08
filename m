Return-Path: <linux-pm+bounces-23683-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9FDA57D4B
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 19:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D82DA3B0165
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 18:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CED213E8D;
	Sat,  8 Mar 2025 18:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="deJr1bsQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE711DE4E7;
	Sat,  8 Mar 2025 18:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741459117; cv=none; b=IbDeg6KsoNBkEZHPD1QtGDlb4GeeSvj0vWht09FpkKBcbuQ5TMeCb7W/0ex3HH9DXuPDKaxX7HR3Gy3/Xb8ADFoA5rJM/4s52DI0Or8xpphPth1R4OzlhojupvU+i9/EJSeKsX+DSil3zYCoMqADcWbieXhnTP1DfMrQeLh8Hns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741459117; c=relaxed/simple;
	bh=t2B2o+S0wXOAA4+LJE2F4eNiPS9UXwAkOPzF1uone2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TwDjZVuSZKbnqpvxKtC+9SknpFgSrINRxX73yNCyUXBCEPLnhA1cchL09wspSjI/quwJfRMwIEclhk/xuSq79VHy/Zj3DBt9lNhOf4/VsAqyqdwDjRaSxFIbqtVHec3K2rRSkJwgWh8CWibr1Dn2EAWON0lUDYBO/CHdsZt0flY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=deJr1bsQ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741459116; x=1772995116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t2B2o+S0wXOAA4+LJE2F4eNiPS9UXwAkOPzF1uone2o=;
  b=deJr1bsQL/51neKDEmnX+zDEEZfN6nhRAMPH8R/mr3Dx0Z6lKF1EvRx5
   l4wAWR6esC7/hC3LAKdGZOldT7RALhAlgghz8F+zPk2yNC7s6m+3CuC5A
   gaDGDNWZWzTMmc9VZsukbNpCcsGU5WoP+e9eEjHRuTEQS8afi9MCAG6+a
   irk5yDhL6H8jOTa7FiqK5lWnPWxKwmGltFwhwVPWhFUd36CvH+JG9Wuso
   sayPLlr5Hbh1FsP9S+DcLqUCWv76Aqg59kpaLAlp8DiaBIKmOmDG/+N38
   hMxwZcYa012SIEh3OYyOPVpmF61WSIjFQKY/tb1kaJ1NttMqNkIAZl9Ad
   w==;
X-CSE-ConnectionGUID: tmRiTDkYSuOk2ZgQOD2Eeg==
X-CSE-MsgGUID: rz+wxwkzTXW1TQmzQZQgIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="46148338"
X-IronPort-AV: E=Sophos;i="6.14,232,1736841600"; 
   d="scan'208";a="46148338"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 10:38:33 -0800
X-CSE-ConnectionGUID: rZtE35f5RwKXHDyBxHus2A==
X-CSE-MsgGUID: dmnUx0OISRKEdI0/mNEsAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,232,1736841600"; 
   d="scan'208";a="119584468"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by orviesa006.jf.intel.com with ESMTP; 08 Mar 2025 10:38:33 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rui.zhang@intel.com,
	daniel.lezcano@linaro.org,
	rafael@kernel.org,
	lukasz.luba@arm.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/3] thermal: intel: int340x: Enable platform temperature control
Date: Sat,  8 Mar 2025 10:38:11 -0800
Message-ID: <20250308183812.118311-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250308183812.118311-1-srinivas.pandruvada@linux.intel.com>
References: <20250308183812.118311-1-srinivas.pandruvada@linux.intel.com>
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
 .../intel/int340x_thermal/processor_thermal_device_pci.c    | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index a55aaa8cef42..f7f03159606a 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -486,7 +486,8 @@ static const struct pci_device_id proc_thermal_pci_ids[] = {
 	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WT_REQ) },
 	{ PCI_DEVICE_DATA(INTEL, LNLM_THERMAL, PROC_THERMAL_FEATURE_MSI_SUPPORT |
 	  PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_DLVR |
-	  PROC_THERMAL_FEATURE_WT_HINT | PROC_THERMAL_FEATURE_POWER_FLOOR) },
+	  PROC_THERMAL_FEATURE_WT_HINT | PROC_THERMAL_FEATURE_POWER_FLOOR |
+	  PROC_THERMAL_FEATURE_PTC) },
 	{ PCI_DEVICE_DATA(INTEL, MTLP_THERMAL, PROC_THERMAL_FEATURE_RAPL |
 	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_DLVR |
 	  PROC_THERMAL_FEATURE_WT_HINT | PROC_THERMAL_FEATURE_POWER_FLOOR) },
@@ -496,7 +497,8 @@ static const struct pci_device_id proc_thermal_pci_ids[] = {
 	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WT_REQ) },
 	{ PCI_DEVICE_DATA(INTEL, PTL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
 	  PROC_THERMAL_FEATURE_DLVR | PROC_THERMAL_FEATURE_MSI_SUPPORT |
-	  PROC_THERMAL_FEATURE_WT_HINT | PROC_THERMAL_FEATURE_POWER_FLOOR) },
+	  PROC_THERMAL_FEATURE_WT_HINT | PROC_THERMAL_FEATURE_POWER_FLOOR |
+	  PROC_THERMAL_FEATURE_PTC) },
 	{ },
 };
 
-- 
2.48.1


