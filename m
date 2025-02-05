Return-Path: <linux-pm+bounces-21353-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89946A2800B
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 01:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 053923A048C
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 00:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347C4623;
	Wed,  5 Feb 2025 00:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lbQdF8+6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD8917E;
	Wed,  5 Feb 2025 00:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738714568; cv=none; b=qPPwrchsq60LukCn+JJZatOE+JE+SuUuSD+BfnzlXFzG7sFWu0uJudA4PJ4LwojMw5YpIrYSB7iyIvPPthkWPyp4yIMzUDYlpENhv5HmQ3YaiXCglpZf3BYyJ2mNiKjUOhn5PGK+6gVP9u3nL9EWKGlnm5OtvrYYPnJ7rxFJHuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738714568; c=relaxed/simple;
	bh=4vbeTF/TPyZyLWys3SvlNDSWEjzl0IvqKPnuH3QvhHg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r9vCXy0eKtjW5As5K6ezo9TbQZmYUwkWHDJMkqnV1GmN6KHJvIay31a0Yg7adSCoiR+hacUL4hLnXh/bZj5F70b0RjMD6qt8hFaJo1s7MRx7/yPnwva7//vjUdiy7p7s5ji5DrdnHWtOE6dUHlf3wcPPg2LU/RWlmjvnqm4k0ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lbQdF8+6; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738714567; x=1770250567;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4vbeTF/TPyZyLWys3SvlNDSWEjzl0IvqKPnuH3QvhHg=;
  b=lbQdF8+6eV+PYeQS40eq+zc9Wt0GxX0BR3kVDh+Mvm9ZGCoG7qjQphnd
   FnpFbD+QCORKPUFBwT/TCf+YQ/NWW1tsjrv3quZGB4kKBvDD3t1Ez62JC
   lziVEH+XFcHUgFv6BRyQf9ISipI72z0qUJg6tqBLgNm1kfP8iu5IMsbAO
   eYFJqdB/lD4CfAsDy4fuKXGe33pQdO4Bz4SVYKtp9dK6+PqAckn/fF1Pr
   rqWJDZer56f5wTSHL0JXdIaBq1qVFqilDcmH+g+2JNKqXXk9ThJ7MIF3J
   JSNH5ehE0yTn1XuZshcpLr7OkMPPM4UIt97i0yl7tW7fhCrouCsV8BgiZ
   A==;
X-CSE-ConnectionGUID: tKk1Dj2YQ06XkYu/UFHYow==
X-CSE-MsgGUID: xkEfFXtHRUyB/PkNcpZTxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39372350"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="39372350"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 16:16:06 -0800
X-CSE-ConnectionGUID: 7VjPg7NORpyqEArhRDwlig==
X-CSE-MsgGUID: ciVKl8ZXTB2SSW1V7/hPGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="110635678"
Received: from tfalcon-desk.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.124.223.214])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 16:16:04 -0800
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
Subject: [PATCH v5 0/5] Add Arrow Lake U/H support
Date: Tue,  4 Feb 2025 16:15:52 -0800
Message-ID: <20250205001601.689782-1-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series contains five patches to add Arrow Lake
U/H support in intel_pmc_core driver. 

The first four patches are preparation patches. The third
patch creates a generic init function for all platforms.
The fourth patch replaces the init functions with pmc_dev_info
structures in X86_MATCH_VFM() of core.c file. In order to
support platform specific init actions, the patch also
adds a init function field in the pmc_dev_info structure.

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

Xi Pardee (5):
  platform/x86:intel/pmc: Make tgl_core_generic_init() static
  platform/x86/intel/pmc: Remove duplicate enum
  platform/x86:intel/pmc: Create generic_core_init() for all platforms
  platform/x86/intel/pmc: Remove simple init functions
  platform/x86/intel/pmc: Add Arrow Lake U/H support to intel_pmc_core
    driver

 drivers/platform/x86/intel/pmc/adl.c  |  22 ++----
 drivers/platform/x86/intel/pmc/arl.c  |  79 +++++++++++--------
 drivers/platform/x86/intel/pmc/cnp.c  |  21 ++----
 drivers/platform/x86/intel/pmc/core.c | 105 +++++++++++++++++++-------
 drivers/platform/x86/intel/pmc/core.h |  52 ++++++++++---
 drivers/platform/x86/intel/pmc/icl.c  |  18 +----
 drivers/platform/x86/intel/pmc/lnl.c  |  25 +++---
 drivers/platform/x86/intel/pmc/mtl.c  |  45 +++--------
 drivers/platform/x86/intel/pmc/spt.c  |  18 +----
 drivers/platform/x86/intel/pmc/tgl.c  |  34 ++++-----
 10 files changed, 216 insertions(+), 203 deletions(-)

-- 
2.43.0


