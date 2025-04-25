Return-Path: <linux-pm+bounces-26251-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A36BA9D262
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 21:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B97C16D9F2
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 19:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1DB221574;
	Fri, 25 Apr 2025 19:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QDLPbjuC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D24F219A94;
	Fri, 25 Apr 2025 19:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745610788; cv=none; b=sh4+hd4ZcbIKQnQw2z4IcGU0WHsbFi5oVnTr4CEzTtLYDGLYZfj4RZlJZz0PORuo3EMcqhDML4n4ySz4x3H3g5osTXohM8L90j93mH0Tld+55lcaZQ97YfHswHYmgNRfFbSqdaC1bkd/0BfKtT6KZw/pdYV1XNwKFESOHLZzmH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745610788; c=relaxed/simple;
	bh=tDkrPFf0SYYldAGaWQZecxLtvI8HrAT9VbYubdDvHSA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JdReO/MXfIkmijt+gpqH5ur8t4+3e/xTQne9sck0Knc5muxdLfMNQkp4wd0a4vSXNeutnrvN6XM/7qG3x4UiSqo2G0IbRMyRjZRVo+czctJlU9k8QA624qRfM9oqOCADiF2ZrQE4wUbmtMWAhX9dvj72cfIlLOthevdQ/qEhNiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QDLPbjuC; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745610788; x=1777146788;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=tDkrPFf0SYYldAGaWQZecxLtvI8HrAT9VbYubdDvHSA=;
  b=QDLPbjuCNNlHtsyy1rnK/RfWOT3lo9GZs3RIxyseyk8yx2oCIc+XezXo
   rvV550s7M+hHELAHZr6sa0Wm7tFC6yo63wkggioAJy/wbBfTexMqwgBlz
   d4R3dmgCZNPv2o/jNHVEj16V0avSgQLbwuLqcE/f6FJsE/mG3sR/OVk2f
   3mCdaSRZRePGKMSw8rwnOkXJ6GxJxR6lpEw5qQVBy0xVBMwnZ8OjvyXeV
   eaxhVIabnmOtaVvrkIVlyoJYGyujIfe8CrnSGegW2fjMwcAGAtDrV8DXR
   uf3hHnxTutn5rS5qRkwSAWmQLaNXONgsrXsm1M7TaHfguNoEymA8myHWD
   w==;
X-CSE-ConnectionGUID: mpyoEMq6TrGvrwhozWBbPg==
X-CSE-MsgGUID: bCjPqZvuSEqOSwOg81re1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="69776228"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="69776228"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 12:52:42 -0700
X-CSE-ConnectionGUID: 4jWizRM0SkKC2SQTzlxKfg==
X-CSE-MsgGUID: B+ADvBbgT8m4HAOQ0yoMIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="132897656"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.124.222.107])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 12:52:41 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v5 4/5] platform/x86:intel/pmc: Move error handling to init function
Date: Fri, 25 Apr 2025 12:52:32 -0700
Message-ID: <20250425195237.493129-5-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425195237.493129-1-xi.pardee@linux.intel.com>
References: <20250425195237.493129-1-xi.pardee@linux.intel.com>
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
 drivers/platform/x86/intel/pmc/core.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index db3fccca06fb..93a335b0ea63 100644
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
@@ -1735,7 +1751,7 @@ static int pmc_core_probe(struct platform_device *pdev)
 		ret = generic_core_init(pmcdev, pmc_dev_info);
 
 	if (ret) {
-		pmc_core_clean_structure(pdev);
+		platform_set_drvdata(pdev, NULL);
 		return ret;
 	}
 
-- 
2.43.0


