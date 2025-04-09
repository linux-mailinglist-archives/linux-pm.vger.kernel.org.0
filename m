Return-Path: <linux-pm+bounces-25044-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AADD0A8302F
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 21:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 755F93B0288
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 19:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3469227CB1B;
	Wed,  9 Apr 2025 19:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O4AFoIIb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6112C27C16A;
	Wed,  9 Apr 2025 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744225869; cv=none; b=ZIV/SmyXeUdDehwBwjn1v7dAwkWx3R4tL5hCX+sYC8rxKdhCNc1ja6g9cpM8jUAw/RAQVXeM/A7AjDQPzLnDPaA9mTZGW4iy7OFB1tzoaGwzvy+nwJCqpVI92bnNjnyq9KFrcy7kOnbqAjmWdWjpCYOtjEgHqS6DQT7XqqEicaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744225869; c=relaxed/simple;
	bh=k90V0P8J6O3PoWv+NqE4CVkXpZJtGBSEOWwyYOKdD5A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dw8qbgVlTuNiIBdX/Nz80YotiVo53h2HfHhfVDDDQXb6iqJ94wO+3iAmED++5g4OCuSMEINdFfy6fomfK4jpcokXGJOySq1diFIYFVo9cq5cy6O6o7Ug3DG1jKXwKordLWJ0DdvwELZ1LsomMPOb0qL7nM0gaMknOt8JAUrMnR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O4AFoIIb; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744225868; x=1775761868;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=k90V0P8J6O3PoWv+NqE4CVkXpZJtGBSEOWwyYOKdD5A=;
  b=O4AFoIIblz+YHLPICdMnVi6g++TXlmKC+Vd/f+lfFgbAZNzmJ4fVXSbK
   8Orsdw2xAboG7pum2qPA0suaj3NpS0nKH4OE75zVuGZEWdh2n1Rkqmjwj
   F3Wvxq4eAekPAZ2ZDwDIGhYlCk90nhuUS5Q507iKPVrKpi0oPtZpE4ZuA
   oyupgxKy/8n2eBuvlCPC13c0rjCSHPgWcNUkEtFgFLncQapFXJm/bYdpY
   ECIGHD4G09F9yIYbbt6OvYojBm2/D1HhhyNQHyClhnEjLFmgrO3/XwTOR
   le9GQcUt1swwpbBdMOjmXQ+aMMyd0NMzrfoXWJsciDUXx1VkZPfnJxFPs
   g==;
X-CSE-ConnectionGUID: EC6VLGWsS3KrPerhnEr8JQ==
X-CSE-MsgGUID: cscae/vURlahcaTRnLYZBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="56386788"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="56386788"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 12:11:04 -0700
X-CSE-ConnectionGUID: rgnZR/P3TMueQaA3PdFHkQ==
X-CSE-MsgGUID: TQQ0cCT/TLuCOZmmjX6pGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="133401299"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.124.220.250])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 12:11:03 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 8/8] platform/x86:intel/pmc: Move error handling to init function
Date: Wed,  9 Apr 2025 12:10:50 -0700
Message-ID: <20250409191056.15434-9-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250409191056.15434-1-xi.pardee@linux.intel.com>
References: <20250409191056.15434-1-xi.pardee@linux.intel.com>
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
index 26c1c75b709a..c39e5f5f1475 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1584,10 +1584,26 @@ int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
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
@@ -1735,7 +1751,8 @@ static int pmc_core_probe(struct platform_device *pdev)
 		ret = generic_core_init(pmcdev, pmc_dev_info);
 
 	if (ret) {
-		pmc_core_clean_structure(pdev);
+		platform_set_drvdata(pdev, NULL);
+		mutex_destroy(&pmcdev->lock);
 		return ret;
 	}
 
-- 
2.43.0


