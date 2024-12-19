Return-Path: <linux-pm+bounces-19549-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 357489F88B4
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 00:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B05397A1FB6
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 23:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDC81E3DF7;
	Thu, 19 Dec 2024 23:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AtLjKEbq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D5A1C57B2;
	Thu, 19 Dec 2024 23:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734652548; cv=none; b=ZMuTrm4y6xJavzW9PyXgTaIKM0764WUgcPPx9Tl48fwzG3c372myxrLz4f0DF5BnfA5BKdsCrQLrfq/37g6hsur0dFt6beLpZNPs6XVwg1avZK/bb8HMUS1faUkhnjn/PrrTaLTAmzFERZob/dDITujJXQbaewqxr+0UDmyasig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734652548; c=relaxed/simple;
	bh=Mqck2DRppu/550M0kA0W0YNJY++k97lpF3Vg8iKSRu8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oc0E9A8LQBcLIIwsDbeSdLclq7domXw0eaZc7zdqMGFeJaBuCsEZv8V+4UDNIAOj02EGHH41xmZcxjAll7iJ1/DD6Da0LGszf1HO8P2l1x1QYP8YXNiLRHKXrAVnDUloRO+dss10icisKksDnfOzOF3blx3yek0RCcm4vYmQ3fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AtLjKEbq; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734652547; x=1766188547;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Mqck2DRppu/550M0kA0W0YNJY++k97lpF3Vg8iKSRu8=;
  b=AtLjKEbqPT/1jzHBsbqCsbYU9tqt2UeaRA0E94CM6MhxySdk+8AesGQ/
   ZtByItaGSEx0URnbRlhDvF3CLQSalcAwDMVR0E0a8Cz5pGpF1ayOEMWRO
   qdyjgnncJjKCcbPD84/M0HhEjV/YD7QiDsFfOWrHcWt/81qhlUnmjbUsf
   1vRo0L1PAxCXJ+jgHhYmMJmY/TMtEPuAfg6i+ik0IBMvlFPtu1O9YNO1x
   lUbCZelK4AS8y3WPBpPbekpffEtiAXiBIhbaVg2XwA5HS9Yd0FNCAMji/
   AYkNrb5IZ1BibTmAXeuTq5Bas9+ejzWhY/ZY42sG6Rn5AeSIEpBGJc4jf
   Q==;
X-CSE-ConnectionGUID: 6IZsmn3sSIK0/SEpDiTGDg==
X-CSE-MsgGUID: zirKbkdBSc6XXAclsHyvhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="38975805"
X-IronPort-AV: E=Sophos;i="6.12,249,1728975600"; 
   d="scan'208";a="38975805"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 15:55:46 -0800
X-CSE-ConnectionGUID: swm5Dgj6TjqDC341wDnBGg==
X-CSE-MsgGUID: 6b8vHTiZTs23WqRC25Rq0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,249,1728975600"; 
   d="scan'208";a="98745830"
Received: from jairdeje-mobl1.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.124.221.167])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 15:55:45 -0800
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
Subject: [PATCH v3 0/3] Add Arrow Lake U/H support
Date: Thu, 19 Dec 2024 15:55:37 -0800
Message-ID: <20241219235543.236592-1-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series contains three patches to add Arrow Lake
U/H support in intel_pmc_core driver. The first two patches
are preparation patches. The second patch creates a generic
init function for all platforms to reduce duplicate code.

v3->v2:
- Create a generic init function for all platforms

v2->v1:
- Create an info structure for platform variation information
- Make generic init function to static in tgl.c
- Fix typo

Xi Pardee (3):
  platform/x86:intel/pmc: Make tgl_core_generic_init() static
  platform/x86:intel/pmc: Create generic_core_init() for all platforms
  platform/x86/intel/pmc: Add Arrow Lake U/H support to intel_pmc_core
    driver

 drivers/platform/x86/intel/pmc/adl.c  | 21 +++----
 drivers/platform/x86/intel/pmc/arl.c  | 81 ++++++++++++++++-----------
 drivers/platform/x86/intel/pmc/cnp.c  | 21 +++----
 drivers/platform/x86/intel/pmc/core.c | 47 ++++++++++++++++
 drivers/platform/x86/intel/pmc/core.h | 27 ++++++++-
 drivers/platform/x86/intel/pmc/icl.c  | 18 ++----
 drivers/platform/x86/intel/pmc/lnl.c  | 24 +++-----
 drivers/platform/x86/intel/pmc/mtl.c  | 45 ++++-----------
 drivers/platform/x86/intel/pmc/spt.c  | 18 ++----
 drivers/platform/x86/intel/pmc/tgl.c  | 43 +++++++-------
 10 files changed, 189 insertions(+), 156 deletions(-)

-- 
2.43.0


