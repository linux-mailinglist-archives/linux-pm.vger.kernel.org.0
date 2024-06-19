Return-Path: <linux-pm+bounces-9613-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B15890F4ED
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 19:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4CAC283F3C
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 17:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12E615689B;
	Wed, 19 Jun 2024 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CtaLtj6K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F979155C98;
	Wed, 19 Jun 2024 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718817690; cv=none; b=ARPvjZu84PCrJFLJDcFn0q9SCdsFX3WbZBxhR5cCCoEjvO9BpVHvhOBTgqMFpy/RznyGukdOn2vmG1wgDMAX//zjVm79xxlRlfpbK19Am8Hw4x8XhYC8iHArD7HfdxAosVUo/5a/MCzEBmYAHeOJVrPmBT/st643uD7zxRTvqoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718817690; c=relaxed/simple;
	bh=8yOFLJZ+q2dncU4RGOsYMGZ0m0prJcres5E2ecx6EnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXauzYgGUyGgA5i0kfqerBkAyU0+z4KMOtd9Q0GFFf5sNwe7OpIDaCl32WHUE9Eh/dZg5O7wiHcVveLu4PnvfsksLIPEZztOAIcx9463hToEtU/Zx7hCxWN4ZfJ5WXSWBVbs6/17HiuxUg6LsVQkuqtYRudumO2aI4uW5xNnrwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CtaLtj6K; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718817689; x=1750353689;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8yOFLJZ+q2dncU4RGOsYMGZ0m0prJcres5E2ecx6EnM=;
  b=CtaLtj6K8KbtkddCtVgLNcVAL09/WaIk46+1y/+amoEv9xyCnRzl4iXw
   vkRSm8VnMFwiFY58gs9HHxBrECq/FVYz6cMr6A3DuJpZio94LSNterJl2
   1be2DcjgsSAk4wfrlDr9jaQWGq9TdZGrxkx7CPnbfPKbVLh8/bwQSEkQN
   88x9Gts0OQ1WCGILR3h3ClID8yh44+Sn3Gkqf4IPcZ6cjgr6vTFQVtZZm
   FqC5nBVFuB+efnRm6usiPTppUR312Lp8h5fL0wUx+eMMoBxkeXlvSHwRE
   tyuRUZPU/xiyMR/0SvAkUSUdaN3eg3CX41CgCecHeIQ9lu+AOLhf5BGz9
   g==;
X-CSE-ConnectionGUID: HcKTcC+RQZ2pN4CuLeacmA==
X-CSE-MsgGUID: FIOrC/MaSrO0YXqHzpgkOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15531174"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="15531174"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 10:21:26 -0700
X-CSE-ConnectionGUID: HsQR7QiwSU+7I2W/bCTJ5g==
X-CSE-MsgGUID: Ih/YiA+hSaWJpwrqzoZvKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="41840037"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by fmviesa007.fm.intel.com with ESMTP; 19 Jun 2024 10:21:26 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/3] thermal: intel: int340x: Enable WLT and power floor support for Lunar Lake
Date: Wed, 19 Jun 2024 10:21:09 -0700
Message-ID: <20240619172109.497639-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240619172109.497639-1-srinivas.pandruvada@linux.intel.com>
References: <20240619172109.497639-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add feature flgas for WLT and power floor for Lunar Lake.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel/int340x_thermal/processor_thermal_device_pci.c       | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index 8c6d19fe37c0..7772bc63f64b 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -472,7 +472,8 @@ static const struct pci_device_id proc_thermal_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, ADL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
 	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WT_REQ) },
 	{ PCI_DEVICE_DATA(INTEL, LNLM_THERMAL, PROC_THERMAL_FEATURE_MSI_SUPPORT |
-	  PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_DLVR) },
+	  PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_DLVR |
+	  PROC_THERMAL_FEATURE_WT_HINT | PROC_THERMAL_FEATURE_POWER_FLOOR) },
 	{ PCI_DEVICE_DATA(INTEL, MTLP_THERMAL, PROC_THERMAL_FEATURE_RAPL |
 	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_DLVR |
 	  PROC_THERMAL_FEATURE_WT_HINT | PROC_THERMAL_FEATURE_POWER_FLOOR) },
-- 
2.40.1


