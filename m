Return-Path: <linux-pm+bounces-9611-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFB690F4EA
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 19:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE7EFB212B2
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 17:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AEC155744;
	Wed, 19 Jun 2024 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mfCSzUVQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9681714EC56;
	Wed, 19 Jun 2024 17:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718817688; cv=none; b=SSPh0Dhve193KpXO1lEVQ2eU00vbHkuyHGcD1C1XP+FYDXbWloWx7RSszUSTho4AahtP56eRaZB29nCE21YS3Qjel4YurqA2l2hcq+Mi2uX5Bvl5Jvhx5R/8vYNTE2tNLs58RXXWKT3Lj+ouJ5dgXVgyxyziFKdYRpGO7bXyt90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718817688; c=relaxed/simple;
	bh=y0IUJVMAX3Rx9n5Lt2qfD8qol1F3Pi4PRGQQhBNI5uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WXjcFG3r5vB5EcCWW+DgLdYhZwLKArwtDlIuND07YDXpbB2Eolt17Az6hn+FgHPURtk2KFBZ03DtB85zrsEO+azhShLNsmxv+07CWCZ6OPajj9z2aMSxRvBnHeZ3qeTZZ/9uIInKWm4wallSnmdJoQzWwKHPUP7iSUeHwh/9aIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mfCSzUVQ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718817686; x=1750353686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y0IUJVMAX3Rx9n5Lt2qfD8qol1F3Pi4PRGQQhBNI5uw=;
  b=mfCSzUVQdmtevVprOyxlIwZSajgjT0Uk5TG1Q9yTd3fRwPBC/1hPN/Mc
   iwjwKRUQqPImK78vhRQf2jFhVgu7HJ55Z5nzqnGJG/Y/4jjqrp2C34Kev
   OeCnH/2qkqLqVz8N1PhyezBYqMT8+vHbeaP1QUbPVkGBjsL7C2LJ4DRAb
   BsH6C+payqdXhs8X1QjqXNQdOHvxHTykB5a2bPueU06pK1IeWMcxLOD+y
   /rreKae7utPWylVvtdZxiNU1n19JGGWV6kqA4RVjIMRXEAQYdr3OWtZFR
   xYAc78yUWyCDAjD96hGPBCKV01nB5rmmTa1ajZsYPsqyaRy9dLKQ/4saQ
   w==;
X-CSE-ConnectionGUID: Bi2AHN9VQn+SfYwRYomIHw==
X-CSE-MsgGUID: UWC1SAz/Tl+/Yex8ZGyqXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15531165"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="15531165"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 10:21:25 -0700
X-CSE-ConnectionGUID: xvDyPDd4Q7qlgweISSMWCQ==
X-CSE-MsgGUID: Osgl9LJjR9CGVtseTV1btQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="41840028"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by fmviesa007.fm.intel.com with ESMTP; 19 Jun 2024 10:21:25 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/3] thermal: intel: int340x: Remove unnecessary calls to free irq
Date: Wed, 19 Jun 2024 10:21:07 -0700
Message-ID: <20240619172109.497639-2-srinivas.pandruvada@linux.intel.com>
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

Remove calls to devm_free_irq() and pci_free_irq_vectors().
They will be called on driver release anyway.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel/int340x_thermal/processor_thermal_device_pci.c       | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index b6bb96d07ce2..59eb76d4dd81 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -352,9 +352,6 @@ static void proc_thermal_pci_remove(struct pci_dev *pdev)
 	proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_THRES_0, 0);
 	proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_INT_ENABLE_0, 0);
 
-	devm_free_irq(&pdev->dev, pdev->irq, pci_info);
-	pci_free_irq_vectors(pdev);
-
 	thermal_zone_device_unregister(pci_info->tzone);
 	proc_thermal_mmio_remove(pdev, pci_info->proc_priv);
 	if (!pci_info->no_legacy)
-- 
2.40.1


