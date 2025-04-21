Return-Path: <linux-pm+bounces-25822-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2810DA957C8
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 23:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C4A171F20
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 21:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EDC2147EA;
	Mon, 21 Apr 2025 21:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LKWBnduK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BD22135C3;
	Mon, 21 Apr 2025 21:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745269871; cv=none; b=tEOCSuD2JQUqApLW+LGZ1PO7lGequpE2Bb0wOc2CbVuzSS19MslQJSUc4u2qx0RvPj6OGa/+NIRIeiTiyLs8parzFYxjpzQB8S4xAU6KNwYpA3qMNUSPipCL8DEzVHI60PxbyCLRgo2mZQc7pn78+UQgONOY539nrlR9S1UMWZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745269871; c=relaxed/simple;
	bh=nH0YXIvP0EbZOx0X2yfoIfLi9AhRns2vbzNHfKFg9Zs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2deX4nrWQNUFrPTcpDzDcKLqmCE/ULPgh8rjyv93R8zH/uyp0qkacr9dATPe39UvJbXIzFIR+n+JF9QxjBI6A51vf313XuQt3FUpAVObReQTDsCq9XbePtQX7XUE+qpVhKlrjphdxxJiseZcgqHWHQDkzcOo6ZYcJkHOYw3Yuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LKWBnduK; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745269870; x=1776805870;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=nH0YXIvP0EbZOx0X2yfoIfLi9AhRns2vbzNHfKFg9Zs=;
  b=LKWBnduKNPqflbe9t74enxEmYFJ1vA2J2OdXyBEF4kT/x5jZarmSdMvi
   sXH2XGIVcBdr/36hy4UtbDVcjgS/9N9fFqmct6+j/oa28vevok68vTBTy
   QHW5FG1sVRJI/plL1lwiLHZMdT3X1S+mEoa8Gop48b5I+es6j2r4HE2iq
   AlnaPMoCzG2xad+iPkp8pYIGmVT4V3kTR4Do+eCAQ6wcTDFMmRwW1F0vK
   Kctlq41jU9VFC3dgOMOxwl0UDGzFG0no9uxQkAFKzw9hHa/7TpVwiDJfr
   mri+EOg8Mz5KpH2h569gk09+WRZy2pc+eYeAv02Ojd8JX95y2gZ7wXvxd
   g==;
X-CSE-ConnectionGUID: PHvdJNE5RSic4ArYfp2KEQ==
X-CSE-MsgGUID: o27+sR0TS2GsWPZhRmlZzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="58189455"
X-IronPort-AV: E=Sophos;i="6.15,229,1739865600"; 
   d="scan'208";a="58189455"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 14:11:05 -0700
X-CSE-ConnectionGUID: C6A3qnPdRhSHbNGyXQEOKQ==
X-CSE-MsgGUID: Y1hknJoqQfOoYNiENvEipg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,229,1739865600"; 
   d="scan'208";a="136912164"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.124.220.165])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 14:11:04 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v4 3/4] platform/x86:intel/pmc: Move error handling to init function
Date: Mon, 21 Apr 2025 14:10:56 -0700
Message-ID: <20250421211100.687250-4-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250421211100.687250-1-xi.pardee@linux.intel.com>
References: <20250421211100.687250-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move error handling code to generic_core_init() function. The previous
implementation is that init function called for "full cleanup" function
when error occurs which is error prone. The init function should handle
the error path itself to improve code maintainability.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 042b60c1185f..e09a97564398 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1583,10 +1583,26 @@ int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
 	if (pmc_dev_info->dmu_guid)
 		pmc_core_punit_pmt_init(pmcdev, pmc_dev_info->dmu_guid);
 
-	if (ssram)
-		return pmc_core_ssram_get_lpm_reqs(pmcdev, pmc_dev_info->pci_func);
+	if (ssram) {
+		ret = pmc_core_ssram_get_lpm_reqs(pmcdev, pmc_dev_info->pci_func);
+		if (ret)
+			goto unmap_regbase;
+	}
 
 	return 0;
+
+unmap_regbase:
+	for (unsigned int i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
+		struct pmc *pmc = pmcdev->pmcs[i];
+
+		if (pmc && pmc->regbase)
+			iounmap(pmc->regbase);
+	}
+
+	if (pmcdev->punit_ep)
+		pmt_telem_unregister_endpoint(pmcdev->punit_ep);
+
+	return ret;
 }
 
 static const struct x86_cpu_id intel_pmc_core_ids[] = {
@@ -1734,7 +1750,8 @@ static int pmc_core_probe(struct platform_device *pdev)
 		ret = generic_core_init(pmcdev, pmc_dev_info);
 
 	if (ret) {
-		pmc_core_clean_structure(pdev);
+		platform_set_drvdata(pdev, NULL);
+		mutex_destroy(&pmcdev->lock);
 		return ret;
 	}
 
-- 
2.43.0


