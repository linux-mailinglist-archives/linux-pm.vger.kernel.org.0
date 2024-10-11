Return-Path: <linux-pm+bounces-15511-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E11999811
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 02:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E90B41C262B1
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 00:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AB97E1;
	Fri, 11 Oct 2024 00:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g5mvIu1M"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04C828FF;
	Fri, 11 Oct 2024 00:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728607007; cv=none; b=AlegcHwkcwp4jEZD/RuRgQsZ/oPlqsYxvz7c0EL/92pS+JpZfMESf8oICjQ9X2yEX1Hl5QPjT+nrB9j8F4FFdUmUvX+M93Z2SuyJbGd6omfMy8vQPDsrGeF/9y3u9Q7gi/CPZR5m1EzE3jtP9e9ll/FD5/HARy/at3GyW4PvhyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728607007; c=relaxed/simple;
	bh=E0OSVMmcSEdiYVrWimSgTaqNzfUCX+2YnRAyIdQqQOY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FyN2nIyjIto5HgEMlO7LrVANgtxVyknMhCxBRChQav1qWlPn3uMD553MTcPMsdUvgsy33yPJMuAFNyPEI9nOr0MThXEcZaLLbEBjhoIdK86TNRD4xwY2fwtsHx4hinpMAev40FyogBt07c4jv2Fk/bYry81d986Rew6YzJ/TEMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g5mvIu1M; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728607006; x=1760143006;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E0OSVMmcSEdiYVrWimSgTaqNzfUCX+2YnRAyIdQqQOY=;
  b=g5mvIu1MvubQ49S+0MdjHVn6btTv9mDbPa/qVR2rLoozyt4w0Uss5VXA
   KdqVbOp4qSQtoeP1rTcLhUxYUBQZKZ6vWDWyN9OjVO5iLEZzlf5ARwpiP
   Ky+p/S0VHryydHSwAYYzcmHBuKxGbI/dOxti7V2/Hu2THrDbTjUJ3R+wk
   6CDBFkmtjDvPqOb708Pk5ryQhGvQAS+/ktW1ntz6ipf8I487g0OG5DI/j
   IW3rhLq80QiDQWqopIML8hpy64e9NW0vlNy4RYCZePEqO1HHDEESJabGy
   4pgX4XkI0FXakAgS69ngC9WBgsYXCoec7FTFPVvvP7wDtfKXFPNysmtg8
   A==;
X-CSE-ConnectionGUID: wrzY1YTFRGOQSnNQE5M6sg==
X-CSE-MsgGUID: JYWCpNDDSwK6bn29uKmzUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="50535452"
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="50535452"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 17:36:45 -0700
X-CSE-ConnectionGUID: MdxVHel6TMWy1GADZDhLKA==
X-CSE-MsgGUID: OawCZuxeSwaGFW7ovrosUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="76399769"
Received: from cmdeoliv-mobl.amr.corp.intel.com (HELO debox1-desk4.lan) ([10.125.111.90])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 17:36:44 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	rjw@rjwysocki.net,
	srinivas.pandruvada@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V2 1/2] platform/x86/intel/pmc: Refactor platform resume functions to use cnl_resume()
Date: Thu, 10 Oct 2024 17:36:38 -0700
Message-ID: <20241011003640.1613812-1-david.e.box@linux.intel.com>
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


