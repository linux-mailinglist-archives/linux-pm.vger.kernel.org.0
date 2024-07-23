Return-Path: <linux-pm+bounces-11335-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF32393A238
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 16:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DE41284829
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 14:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8429154BF0;
	Tue, 23 Jul 2024 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Th/rWI8t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313CF153BF7;
	Tue, 23 Jul 2024 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721743366; cv=none; b=pdi++R/TcT9t9/zAq4BNeUx8kQij7bx4O1UeOQxmD+fc/dggwwAmLO9+dngXtDD9PrM2gPNBecjSE17x/MyisutEvtQQFvF2+72R0vG/tYf/Bf2c5g9UEtyDab2tu9vF2RIjcGgUdw63NwxyLltWKHDgLfX27MzE/GZ7Ab4846s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721743366; c=relaxed/simple;
	bh=RLt8jhrYw41hVzb8SoBJYba6QBbCi+6+Cpn6StTevts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YxS5O/+hgMIhbD7NdbiUggZtNXMEY+5KJGGTT7QVfQDCOoaaSgK7rWIHTh2qxxny+y9NVxMb87SeDEMCjMREgvsBR9f9Kj/gEo43RkmH5+fE4AlpQi9l0/1nwZgpXH/Ky5GYotfF93cVuUihMjkPGhDiNGkiGR09SHEsHE47E/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Th/rWI8t; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721743365; x=1753279365;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RLt8jhrYw41hVzb8SoBJYba6QBbCi+6+Cpn6StTevts=;
  b=Th/rWI8tMcETBkNaZTz2XO0dxdUIKpObWmuXmrwQsYoxJ0LDkLJFWJ2z
   7SyRBBuBtkDIjjcGcRDtA02pZWGr88nevVIxE3/+yx/x+Te6JD2bvdtvy
   7eUv5dbQlz4XsDpFrOaLA32+ZliJDK6SpUu36kCsxIGQHFpULEHEtN4lG
   Hl9SxkGwIQKDiOI1akbPCQX7DGwqK/jlloVhzl+0z+KIe6Xuw2cjyypAp
   Kg5PIE4UfpycXPev+pG8dQa7uEj/4VpScc/LrUdo2JcWsUxCWhxcNIyC/
   gcvgJVDi+nCTSX7DcN1FRuqLcGQWb3eFbzi6Lfw8YUyWOjMIsCcMzGz2Q
   g==;
X-CSE-ConnectionGUID: 515XpwlCT1OU5jjFxhSWEQ==
X-CSE-MsgGUID: tUW3lqM8TnCmB+XMvSKqbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19518136"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="19518136"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 07:02:34 -0700
X-CSE-ConnectionGUID: w4PTbP8nRn+/HGz7RO8XAg==
X-CSE-MsgGUID: psbCLC0bRyWW4Th96gDJgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="56546566"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by fmviesa005.fm.intel.com with ESMTP; 23 Jul 2024 07:02:34 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yijun.Shen@dell.com,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/3] thermal: intel: int340x: Free MSI IRQ vectors on module exit
Date: Tue, 23 Jul 2024 07:02:28 -0700
Message-ID: <20240723140228.865919-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240723140228.865919-1-srinivas.pandruvada@linux.intel.com>
References: <20240723140228.865919-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On module exit call proc_thermal_free_msi() to free vectors allocated by
pci_alloc_irq_vectors().

Fixes: 7a9a8c5faf41 ("thermal: intel: int340x: Support MSI interrupt for Lunar Lake")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel/int340x_thermal/processor_thermal_device_pci.c       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index ff296626c498..006614921870 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -431,6 +431,9 @@ static void proc_thermal_pci_remove(struct pci_dev *pdev)
 	proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_THRES_0, 0);
 	proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_INT_ENABLE_0, 0);
 
+	if (msi_irq)
+		proc_thermal_free_msi(pdev, pci_info);
+
 	thermal_zone_device_unregister(pci_info->tzone);
 	proc_thermal_mmio_remove(pdev, pci_info->proc_priv);
 	if (!pci_info->no_legacy)
-- 
2.45.0


