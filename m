Return-Path: <linux-pm+bounces-11334-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD18193A236
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 16:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BEE2B22A8C
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 14:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA4D15443C;
	Tue, 23 Jul 2024 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SeaPBDgf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FBB15383D;
	Tue, 23 Jul 2024 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721743365; cv=none; b=T2yN1dWVyOiBNs+WzfeFOUsdkK5kS8YHAicim49SJqLNYFCYAWFURSa4sXMh7TB642umVHE2N5NhM3kEP0N0shZcE+0Ar+rQeKOI8TdUJsXo/SpuG4FEyAtx4ICP4NB683BRO1c1VxqjGxnopEfIOv5PZDE3HoG2YAK6h2V/YLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721743365; c=relaxed/simple;
	bh=iNsnR3sCLxuTea2o3o3CWGFYhvw06dSVKKyayF5tm30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kw+gtIfvVKRK10nV4h6qpv0TXPJAL83Oc4YZzacU+vZ6i+vJaO6vtNVw1HDM2xFAbvjSDetrYL6nXcMAaaD7jjPtT8ejLCPi6bxEe2jWB5B587UJtWSPgDPn572VlaJl7f7x3qPzkegwR83G4YZ8MOV5coKqtp8HBHvDvOaMslM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SeaPBDgf; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721743364; x=1753279364;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iNsnR3sCLxuTea2o3o3CWGFYhvw06dSVKKyayF5tm30=;
  b=SeaPBDgf33xHw9uWorzJm0xrgtvRhtWhioAWJT4iRYwUbkPOM1XHy2Wb
   DeXixhPaWWHmWd8eRlbrOQL0hl2ptQ7NlkRVApRAEm/iyLs11VzCIHcir
   q1oEoa33VMGozpyB4OboQMSvUH0CvyMBbgH+D9gsDW+kMA56xLUyU5oog
   VbDzE8X91u3V7rV6k1qgMPE7SJeOhTh4FdAP/2NFA3C/6Dhh0k5cyqu8h
   CX+M6T1s5lmqbvt6mnu0wERX+2XBKEueYx/0vNWK8Be3ximUbirPmm17j
   xyviUwMxI2CaeCwzRYikbaMcCIAYRjTpV0LBv/18yj+/LZDaqqiajhOtE
   g==;
X-CSE-ConnectionGUID: UXX4u+UYRFaks7ss+Z0F3Q==
X-CSE-MsgGUID: w+3kEREbTle/mi5m5mCBOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19518131"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="19518131"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 07:02:34 -0700
X-CSE-ConnectionGUID: l+FU3oOyRkawgpOliFFTjQ==
X-CSE-MsgGUID: GxBL1IlaTLqIychLHUgGFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="56546562"
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
Subject: [PATCH 2/3] thermal: intel: int340x: Allow limited thermal MSI support
Date: Tue, 23 Jul 2024 07:02:27 -0700
Message-ID: <20240723140228.865919-3-srinivas.pandruvada@linux.intel.com>
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

On some Lunar Lake pre-production systems, not all the MSI thermal
vectors are valid. In that case instead of failing module load, continue
with partial thermal interrupt support.

pci_alloc_irq_vectors() can return less than expected maximum vectors.
In that case call devm_request_threaded_irq() only for current maximum
vectors.

Fixes: 7a9a8c5faf41 ("thermal: intel: int340x: Support MSI interrupt for Lunar Lake")
Reported-by: Yijun Shen <Yijun.Shen@dell.com>
Tested-by: Yijun Shen <Yijun.Shen@dell.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../int340x_thermal/processor_thermal_device_pci.c     | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index 2c9c45eb5b4a..ff296626c498 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -292,18 +292,18 @@ static void proc_thermal_free_msi(struct pci_dev *pdev, struct proc_thermal_pci
 
 static int proc_thermal_setup_msi(struct pci_dev *pdev, struct proc_thermal_pci *pci_info)
 {
-	int ret, i, irq;
+	int ret, i, irq, count;
 
-	ret = pci_alloc_irq_vectors(pdev, 1, MSI_THERMAL_MAX, PCI_IRQ_MSI | PCI_IRQ_MSIX);
-	if (ret < 0) {
+	count = pci_alloc_irq_vectors(pdev, 1, MSI_THERMAL_MAX, PCI_IRQ_MSI | PCI_IRQ_MSIX);
+	if (count < 0) {
 		dev_err(&pdev->dev, "Failed to allocate vectors!\n");
-		return ret;
+		return count;
 	}
 
 	dev_info(&pdev->dev, "msi enabled:%d msix enabled:%d\n", pdev->msi_enabled,
 		 pdev->msix_enabled);
 
-	for (i = 0; i < MSI_THERMAL_MAX; i++) {
+	for (i = 0; i < count; i++) {
 		irq =  pci_irq_vector(pdev, i);
 
 		ret = devm_request_threaded_irq(&pdev->dev, irq, proc_thermal_irq_handler,
-- 
2.45.0


