Return-Path: <linux-pm+bounces-25038-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62925A83011
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 21:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6CE51783DB
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 19:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EB6279333;
	Wed,  9 Apr 2025 19:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DBfrAMSy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FCF267B00;
	Wed,  9 Apr 2025 19:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744225865; cv=none; b=DkWZLFynOa0GG+2gOzGOkIyDGKhrwGjIa5WP1dqNlUMthgjrkDJOVOcvHwJCBnwF+x7mvIRSpbwa/+HI0N9x1zxrZItFAwGcKWc7ls1uk6KIjx94Uv9Ue0xP/awiAXLcICktKNL86QdLkMWeWzf4njkF4A9W4yqrBtV9W1LewJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744225865; c=relaxed/simple;
	bh=dXsMifrTuHGprZ2MeS2nMbJy8tJ7MVdRW3lUsJkjkJc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fwgu6T2q5Qua9rtfL5xBgzZ5XFwNkI+U7hTlxJ9inbmCLWh8z3BWwvZU+Wj2+yggW1CpMTGJwpZ0OfVCHDiIHMYLvZQjHHRdqhT9CMZQZ3Q1k7jUaGKFNG7hdcuMSLCRMwV3N1jDdnrDmzfk5R4mcHmYFmZnfSpgSGS8thj/8k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DBfrAMSy; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744225864; x=1775761864;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=dXsMifrTuHGprZ2MeS2nMbJy8tJ7MVdRW3lUsJkjkJc=;
  b=DBfrAMSyuAaapUP1cL1JfY1YyDipoQUXeU6uDKtTNHnK0kM5p4XC0BEF
   CObJXFsAUGo3xHZ/PCg5ZtnSqw22dVSzGmc+kjQ+EEH5byoPwNy85ZlFK
   gr+NkiTCSWummLyzySIN5/V0KRdBIdA5Y6Tnullwd0TxzJuwryCVIqUoF
   xZzvPNRBis0WipHfZpy+q/vyQuzFVWN5ypx513wNxj97ogegsDWzwN/B4
   xXJScaunb1+jV/DTBwIgw7SAC97d2+1fYTpXoavEqOAncQPaGNvJAyLnj
   imwTBI4F2vZMIXS8+O6ifckF7nFzt/XWunRZbDXwshVMnwXiASue2HVmY
   A==;
X-CSE-ConnectionGUID: a+VVQ1zXTcONzdsCOorJjg==
X-CSE-MsgGUID: Nmrhj5urSF6DkheojNTjkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="56386765"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="56386765"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 12:11:02 -0700
X-CSE-ConnectionGUID: VIztQUvITImPgGZ50BYckw==
X-CSE-MsgGUID: lOWBMsCuSMiZYExeoMIMuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="133401228"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.124.220.250])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 12:11:01 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 2/8] platform/x86:intel/pmc: Rename core_ssram to ssram_telemetry
Date: Wed,  9 Apr 2025 12:10:44 -0700
Message-ID: <20250409191056.15434-3-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250409191056.15434-1-xi.pardee@linux.intel.com>
References: <20250409191056.15434-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Rename core_ssram.c to ssram_telemetry.c. This patch is a
preparation step to introduce a new SSRAM Telemetry driver
for the SSRAM device.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/Makefile                         | 2 +-
 .../platform/x86/intel/pmc/{core_ssram.c => ssram_telemetry.c}  | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/platform/x86/intel/pmc/{core_ssram.c => ssram_telemetry.c} (100%)

diff --git a/drivers/platform/x86/intel/pmc/Makefile b/drivers/platform/x86/intel/pmc/Makefile
index b148b40d09f5..e842647d3ced 100644
--- a/drivers/platform/x86/intel/pmc/Makefile
+++ b/drivers/platform/x86/intel/pmc/Makefile
@@ -3,7 +3,7 @@
 # Intel x86 Platform-Specific Drivers
 #
 
-intel_pmc_core-y			:= core.o core_ssram.o spt.o cnp.o \
+intel_pmc_core-y			:= core.o ssram_telemetry.o spt.o cnp.o \
 					   icl.o tgl.o adl.o mtl.o arl.o lnl.o ptl.o
 obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core.o
 intel_pmc_core_pltdrv-y			:= pltdrv.o
diff --git a/drivers/platform/x86/intel/pmc/core_ssram.c b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
similarity index 100%
rename from drivers/platform/x86/intel/pmc/core_ssram.c
rename to drivers/platform/x86/intel/pmc/ssram_telemetry.c
-- 
2.43.0


