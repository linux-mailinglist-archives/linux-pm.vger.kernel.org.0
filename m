Return-Path: <linux-pm+bounces-20166-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78881A083E4
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 01:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8993F16869B
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 00:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507F21F941;
	Fri, 10 Jan 2025 00:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ysx/PQOa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501E811187;
	Fri, 10 Jan 2025 00:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736468779; cv=none; b=IA5+O7axk+2HmZj+zQi/UdJAVYw5+4rj8Q/2XgQvtPRyyXjJCjsXmTcoiWFWC1/8UexXsG6tGlbG5P0CVUg9AjHQRUH8AbTXLLVrSMRHH2wGGVPLBhmKu/J/UerqXsSY+9X7HJ57J+rLO+lTbccdCkQeZQZAlFPcn9t83Ucb3+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736468779; c=relaxed/simple;
	bh=dICDqNh7Rij1Bee1+gwWVYFY2gN9otXv0IKNIymDSBE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nwn0ynZw4QhFb1s6Imx4drJ5vlzOPaiFy9GevfdfwEcka/c1Quh6uw5hDdbMCUBZVeK+uxR6b5e4+5LpLd/nzQwtw9UH2MWa4N5YoKFnSoRTn6NDSnxrNECB4waDeuQBfZucSak0ldl8ENx71NdxKI69ZdywIA/9cHXataMiJqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ysx/PQOa; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736468778; x=1768004778;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dICDqNh7Rij1Bee1+gwWVYFY2gN9otXv0IKNIymDSBE=;
  b=Ysx/PQOaRZpwW6M9Twh27I6dhh+paQoC5eRikhDUmhXMshA+pZis87bq
   BH/+4+YS5z7ZGf9woSL3BbFALnmKSJqx89YhmupJCXijX9mgo0QlUX+gU
   lKpY9y28taAoDXMgqbniSJD/YbDbbtQULlGpxnGaifp/+m0CdjBsEDZr7
   /f6A15F1VzmBCJ9VkHpujq8vDV1y3z06e7FekYCjlAXYnKEL3H+XwqAIo
   /TaRIDehbRt6K18YSCax+R+lwGo7RHiwKSyTXAc8nP/ReIHzxhkm7qvzy
   8mJ3APoxOXowOSOn1HuGd1t07t19Yt3VH2dM0ENXCh/+1CnjEi5RGWy/p
   w==;
X-CSE-ConnectionGUID: mPq+OIgKSaSE45qpmJbaug==
X-CSE-MsgGUID: T7R98Cz4RHu6NeoeUbtogw==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="36653476"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="36653476"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 16:26:17 -0800
X-CSE-ConnectionGUID: lIHa0yZDS4GcFnZm4tWOdA==
X-CSE-MsgGUID: t8v9MmNPQAeLbjrPogBwEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104097022"
Received: from sramkris-mobl1.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.124.222.100])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 16:26:16 -0800
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
Subject: [PATCH v4 0/6] Add Arrow Lake U/H support
Date: Thu,  9 Jan 2025 16:26:02 -0800
Message-ID: <20250110002612.244782-1-xi.pardee@linux.intel.com>
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

The first five patches are preparation patches. The second
patch creates a generic init function for all platforms. The
fourth patch create a callback field that allows platform
specific action to be done in generic init function. The
fifth patch removes all per architecture init functions.

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
  platform/x86/intel/pmc: Create architecture specific callback
  platform/x86/intel/pmc: Remove init functions per architecture
  platform/x86/intel/pmc: Add Arrow Lake U/H support to intel_pmc_core
    driver

 drivers/platform/x86/intel/pmc/adl.c  |  22 ++----
 drivers/platform/x86/intel/pmc/arl.c  |  78 +++++++++++--------
 drivers/platform/x86/intel/pmc/cnp.c  |  21 ++----
 drivers/platform/x86/intel/pmc/core.c | 103 +++++++++++++++++++-------
 drivers/platform/x86/intel/pmc/core.h |  52 ++++++++++---
 drivers/platform/x86/intel/pmc/icl.c  |  18 +----
 drivers/platform/x86/intel/pmc/lnl.c  |  24 ++----
 drivers/platform/x86/intel/pmc/mtl.c  |  44 +++--------
 drivers/platform/x86/intel/pmc/spt.c  |  18 +----
 drivers/platform/x86/intel/pmc/tgl.c  |  40 ++++------
 10 files changed, 210 insertions(+), 210 deletions(-)

-- 
2.43.0


