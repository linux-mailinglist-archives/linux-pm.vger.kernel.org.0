Return-Path: <linux-pm+bounces-19348-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4049F3CA2
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 22:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CDCF167B68
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 21:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68411D54EF;
	Mon, 16 Dec 2024 21:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nbcyyvl0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175621D47C3;
	Mon, 16 Dec 2024 21:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734383896; cv=none; b=RWNJ6M6BAa2fDOD66JQUBs9n4VJuFWXomfg8cvDrPbzH/vJz1UN4bJUyUQqn0s9jBDAiDI9e9u9GAzs+svLwuZZu1+qlBzo7uL2qG5itAbJ783YxCldvSmHZC9TdqkedsQhM8TEUj6wIEEU6FYbDrxapdqwvzv3IZ+WkGu16w24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734383896; c=relaxed/simple;
	bh=6oaY50F1Knju1fxAv0SpPwPn8szxt5f41SjuJaa83cw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DJUFfD73ccCzmzUIop9tgfBA/4mi/xRcWw48j/edeaOZAV1+tFV98Uzi0AzjWJFvUtY1FQrbhzppJcVfcNpp7byH8Gybt7mSt4rAiz+mJRWHS8zsbnAxI2tX3hKwgqQlHrenl8N08K9qz+l/rV6ox9gVsuY+E+n+Xsi/K5e7JU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nbcyyvl0; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734383895; x=1765919895;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6oaY50F1Knju1fxAv0SpPwPn8szxt5f41SjuJaa83cw=;
  b=Nbcyyvl0AJrbUgy308B4cIJA+3qM5arpJat307w5UjkWZat0imHjyjqA
   UrvTmPNE+KDzGqZZYEuIruTSdDBAVAZOk/T3SM41pJYIjW5ZZTKwJEASn
   SKdr/YEOcvd8t2EQOUmeBxsH5Rzyzr39tQchssITUc/3wVqeyoUh859zX
   pyZAzo0qmICiMCvHNrcDc9atQ7ZCVDAYJaNhRrnjKroIi/oigVgRsm8nV
   EXw5MlvoRRgmEUv+qlOLB/5DkuH0CyFi5T201Mct/CEUTAo7aHHBAlLT1
   Id3QNsHDX1WabQXSe2GarKJ6B94VIr8YX0gNk6SeoqBT3HT8DDLR8aBiI
   Q==;
X-CSE-ConnectionGUID: VVCpxfgdS7KfCpEOJP7lHQ==
X-CSE-MsgGUID: Df8CyjmqRoGerH5m8Rfb1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="45484876"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="45484876"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 13:18:12 -0800
X-CSE-ConnectionGUID: YYJE8oRBRQW2ONDLgQ4Siw==
X-CSE-MsgGUID: tSksifrTQeiWc789FNQfFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97781258"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by orviesa007.jf.intel.com with ESMTP; 16 Dec 2024 13:18:12 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	rui.zhang@intel.com,
	daniel.lezcano@linaro.org,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/2] thermal: intel: int340x: Panther Lake DLVR support
Date: Mon, 16 Dec 2024 13:18:09 -0800
Message-ID: <20241216211810.1207028-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Panther Lake follows same register set as Lunar Lake for DLVR. Enable
feature flag to support DLVR.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel/int340x_thermal/processor_thermal_device_pci.c       | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index 707bd1b23823..fb3820e72c11 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -495,7 +495,8 @@ static const struct pci_device_id proc_thermal_pci_ids[] = {
 	  PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_DLVR | PROC_THERMAL_FEATURE_WT_HINT) },
 	{ PCI_DEVICE_DATA(INTEL, RPL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
 	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WT_REQ) },
-	{ PCI_DEVICE_DATA(INTEL, PTL_THERMAL, PROC_THERMAL_FEATURE_RAPL) },
+	{ PCI_DEVICE_DATA(INTEL, PTL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
+	  PROC_THERMAL_FEATURE_DLVR) },
 	{ },
 };
 
-- 
2.47.1


