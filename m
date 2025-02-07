Return-Path: <linux-pm+bounces-21569-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 812D8A2D10A
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 23:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C747188C2B7
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 22:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD351C68A6;
	Fri,  7 Feb 2025 22:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CNhNQvw3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848AD1B040E;
	Fri,  7 Feb 2025 22:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968981; cv=none; b=MbEH/Np5plujR02Moz4uoj8zQfBPIWUngpXhbqulp1czFqT8ntCB0L3vcrFliKz8heVBHjkw+ZIoeWgvQhQ/vLoCsPZg3kd5tLKXEWjGcTeZskdMBxCs8f+Arwf1ZYB1DsuoQo2MohMrvEWVdxK14RDFmkpjSg3dfM03owQ15L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968981; c=relaxed/simple;
	bh=J0Zof1jX8lwMfeOx7nFV7wNnWKhmohl7boxXi/fPwN0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LO4PY8DQo471dO8HG1Mqcv2Flz77EORILaNScpjCxjsW+2EEP70o+mHNTdFlSzKE4N8uMdxtHG3vzTL06DUMuyWrOw9A4gGRJxYItFGkVvJWBTZ8TZVzNWRbBFxlU1wB9hGNHuzoondNDyUPbV0WYtr/AOt4Lg0oblItk0sLaMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CNhNQvw3; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738968979; x=1770504979;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J0Zof1jX8lwMfeOx7nFV7wNnWKhmohl7boxXi/fPwN0=;
  b=CNhNQvw39wh4tIoD6zr3a31C4OOglA+Og+lL+ENCcniSYl/APYkrgfhF
   w4zbdRW6M7TficXsZR6YWskfbZi87xUk6DjbRer32vSbGHWb6r1fSgYHa
   SGMYmbhOBXTNFAzE4vladduMk3b4xuggFMi1n13AvIxBfGVsW9Bky/lwo
   W4zexDZzD/iGDp9mCZMo2IFBEfnXY3WMlH4WO+7INx7wx37LZ7IFNydGK
   7eTYRQR1jVBJnsce4SZosFYBV+XByScxKOr7CTAGcVn8cHJ3O4od68sI3
   HcgOwsLPpskaf4Y/KmJUiGex/0JLG5bYwbeTh5qW49W8MpdDnL7+/e8JP
   g==;
X-CSE-ConnectionGUID: NMEvnQk8QDq0klRXzNCp4g==
X-CSE-MsgGUID: SQYaJeHUQOC6+Tm29HOAaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="38855795"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="38855795"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 14:56:18 -0800
X-CSE-ConnectionGUID: XzKn7J1AQR2sKm7JS5F0zw==
X-CSE-MsgGUID: O2PlMsNGTbKVIxZiwCav5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="111421966"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.124.221.44])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 14:56:17 -0800
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	rajvi0912@gmail.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v6 0/6] Add Arrow Lake U/H support
Date: Fri,  7 Feb 2025 14:56:06 -0800
Message-ID: <20250207225615.401235-1-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series contains six patches to add Arrow Lake
U/H support in intel_pmc_core driver. 

The first five patches are preparation patches. The third
patch creates a generic init function for all platforms.
The fourth patch replaces the init functions with pmc_dev_info
structures in X86_MATCH_VFM() of core.c file. In order to
support platform specific init actions, the patch also
adds a init function field in the pmc_dev_info structure.
The fifth patch moves architecture specific action from
core.c to init() function in spt.c.

v6->v5:
- Move arch specific action from core.c to init() function
  of spt.c
- Remove core init functions from header and change them
  to static functions within each file.

v5->v4:
- Replace DMU with full name.
- Rename func field to pci_func.
- Remove arch_specific callback function and replace 
  generic_core_init completely with arch specific init
  functions when needed to allow more flexibility.

v4->v3:
- Remove all per architecture init functions and replace with
  pmc_dev_info structures in x86_cpu_id structure in core.c.
- Remove fixup field and add arch_specific field in 
  pmc_dev_info structure.
- Move ssram init comment to be function comment.
- Remove ssram field in pmc_dev_info structure.
- Captilize PMC
- Remove PMC_IDX_SOC

v3->v2:
- Create a generic init function for all platforms

v2->v1:
- Create an info structure for platform variation information
- Make generic init function to static in tgl.c
- Fix typo

Xi Pardee (6):
  platform/x86:intel/pmc: Make tgl_core_generic_init() static
  platform/x86/intel/pmc: Remove duplicate enum
  platform/x86:intel/pmc: Create generic_core_init() for all platforms
  platform/x86/intel/pmc: Remove simple init functions
  platform/x86:intel/pmc: Move arch specific action to init function
  platform/x86/intel/pmc: Add Arrow Lake U/H support to intel_pmc_core
    driver

 drivers/platform/x86/intel/pmc/adl.c  |  22 ++---
 drivers/platform/x86/intel/pmc/arl.c  |  79 ++++++++++--------
 drivers/platform/x86/intel/pmc/cnp.c  |  21 ++---
 drivers/platform/x86/intel/pmc/core.c | 114 +++++++++++++++++---------
 drivers/platform/x86/intel/pmc/core.h |  46 ++++++++---
 drivers/platform/x86/intel/pmc/icl.c  |  18 +---
 drivers/platform/x86/intel/pmc/lnl.c  |  25 ++----
 drivers/platform/x86/intel/pmc/mtl.c  |  45 +++-------
 drivers/platform/x86/intel/pmc/spt.c  |  33 +++++---
 drivers/platform/x86/intel/pmc/tgl.c  |  39 ++++-----
 10 files changed, 228 insertions(+), 214 deletions(-)

-- 
2.43.0


