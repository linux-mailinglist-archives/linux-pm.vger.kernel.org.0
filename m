Return-Path: <linux-pm+bounces-15908-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 401629A2F27
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 23:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04045281B9A
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 21:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B636A227B8D;
	Thu, 17 Oct 2024 21:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FfV6XOPP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CA31D1E96;
	Thu, 17 Oct 2024 21:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729199090; cv=none; b=nn14OoZ/+muSdKEye9LOJ7IOH+XZMiGWHriJeZZ0Y0w3CrsjmjLF/oYLaF3e1Zu3X4r21IASvF+mVYR4tdwhfmrtcj4gkXMMkCv/3vNrtoKDSq/JH3V2lnRcH2Q2UZGra1ueE+bw9rZYy84NWDPY/zvaA3yNDbdOIxVkTKmGjBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729199090; c=relaxed/simple;
	bh=jenkFyMpowl04UVp9inylvOIAKLYb5nUzLLipU3u/8I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=N/sQjM1WkBHBERXIlyUbIf3Wvtb0+u7H3tVF97n5iVIzC9zVTub37JUFnqXRjxEeF6RJtPyw0zope4czkpXoNSVJ+rrskfMmyN4c9ZmTM+kMbHmLsITNXZJGX+4UjETEN8SViYHjrN22e2kYNvQ+dnmZgOLQ9G/6cBw/b8gN+Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FfV6XOPP; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729199086; x=1760735086;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jenkFyMpowl04UVp9inylvOIAKLYb5nUzLLipU3u/8I=;
  b=FfV6XOPPkBpLD77E9oly8gN6fZk0gfwPGjKGYQQGBMnO+M7MYcnXv4o7
   hhkjioOHPvwDTlNnafL/SVwmPWyL2u4lELAL+6Z84ttl5y1GQgMyyLfGj
   PWraziUR6wS8SuqfeznAsEh68Ab1CWs6eaTfSBpETsL5wHPu6v669/O5V
   elKssklaH2anR6VA9XPlMfs7Ig5oc+ND4PYiB0weoYvDwbv4JsPUQ2igP
   ZQk6aIJMhER06PoiRWPwz0Gp7G/FUrAmQMJ+3yyEPdlio/hld9SVMD2d6
   HS9ZcphpUjtfRl4D25JCAR8Ktg5mEsYlJqwIbJq50H6LJ6/wUtxoGfp3j
   A==;
X-CSE-ConnectionGUID: 1MA8WljySbSSsM8z5Gg3YQ==
X-CSE-MsgGUID: YFO3BN+YT1qnAXvdfru1Ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28810394"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28810394"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 14:04:44 -0700
X-CSE-ConnectionGUID: pY46lQCySwOGFXbab8g+YA==
X-CSE-MsgGUID: SLvelj+kRTiuXsUFaTYbVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="78340403"
Received: from mesiment-mobl2.amr.corp.intel.com (HELO debox1-desk4.lan) ([10.125.109.71])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 14:04:43 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rjw@rjwysocki.net,
	srinivas.pandruvada@linux.intel.com
Subject: [PATCH V3 1/2] platform/x86/intel/pmc: Refactor platform resume functions to use cnl_resume()
Date: Thu, 17 Oct 2024 14:04:37 -0700
Message-ID: <20241017210439.3449324-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several platform resume functions currently call pmc_core_send_ltr_ignore()
and pmc_core_resume_common(), both of which are already called by
cnl_resume(). Simplify the code by having these functions call cnl_resume()
directly.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
V3 - no change

V2 - New patch. Split from V1

 drivers/platform/x86/intel/pmc/arl.c | 3 +--
 drivers/platform/x86/intel/pmc/lnl.c | 3 +--
 drivers/platform/x86/intel/pmc/mtl.c | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
index e10527c4e3e0..05dec4f5019f 100644
--- a/drivers/platform/x86/intel/pmc/arl.c
+++ b/drivers/platform/x86/intel/pmc/arl.c
@@ -687,9 +687,8 @@ static void arl_d3_fixup(void)
 static int arl_resume(struct pmc_dev *pmcdev)
 {
 	arl_d3_fixup();
-	pmc_core_send_ltr_ignore(pmcdev, 3, 0);
 
-	return pmc_core_resume_common(pmcdev);
+	return cnl_resume(pmcdev);
 }
 
 int arl_core_init(struct pmc_dev *pmcdev)
diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
index e7a8077d1a3e..be029f12cdf4 100644
--- a/drivers/platform/x86/intel/pmc/lnl.c
+++ b/drivers/platform/x86/intel/pmc/lnl.c
@@ -546,9 +546,8 @@ static void lnl_d3_fixup(void)
 static int lnl_resume(struct pmc_dev *pmcdev)
 {
 	lnl_d3_fixup();
-	pmc_core_send_ltr_ignore(pmcdev, 3, 0);
 
-	return pmc_core_resume_common(pmcdev);
+	return cnl_resume(pmcdev);
 }
 
 int lnl_core_init(struct pmc_dev *pmcdev)
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index 91f2fa728f5c..fc6a89b8979f 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -988,9 +988,8 @@ static void mtl_d3_fixup(void)
 static int mtl_resume(struct pmc_dev *pmcdev)
 {
 	mtl_d3_fixup();
-	pmc_core_send_ltr_ignore(pmcdev, 3, 0);
 
-	return pmc_core_resume_common(pmcdev);
+	return cnl_resume(pmcdev);
 }
 
 int mtl_core_init(struct pmc_dev *pmcdev)

base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
-- 
2.43.0


