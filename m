Return-Path: <linux-pm+bounces-22114-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C0EA367AA
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 22:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4959F3B13AA
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 21:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864551D89F0;
	Fri, 14 Feb 2025 21:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="goG4Q+C6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6391B6CE3;
	Fri, 14 Feb 2025 21:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739569461; cv=none; b=Gvx10AXYIXLV/2ya7siedGdoNa+nWZKrnl5QqEaT5ji7isNFBND+4/a4zRdZyPYY+lG64Tq6s9RbGbBuzy5zl2ClXvg4mZOxpeRnX2Y7r41ho0EsN8ZC2Fll1GGSc4e8WvxEhnNzyF1mUpZXvPRJcKUpJjx3TFCx2w0v58GLAwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739569461; c=relaxed/simple;
	bh=UePcqZveBeBZvHRWAm7ZHm3uWwWcLFEzUGOt58Cr9h8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ioJBhjWmvi/ebo5JQlZPAlaqmMwXNPvohJUxgSkhR9gnmIpBVplYxaS5HsPbYXI2OY7cIuMZaXMnJ/AEB+jOLKEW4DxBeX8X2Ldlm9scgSpJwmlVFBngNQ/e8tCqg+NaCwfVzzdzM5pooTPnIqlM6FtdzmFRBAtNDuw5KPXR7SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=goG4Q+C6; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739569460; x=1771105460;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UePcqZveBeBZvHRWAm7ZHm3uWwWcLFEzUGOt58Cr9h8=;
  b=goG4Q+C6KFxxjP15efgR0enS3qt3ZlNmY6bm1b0IbYQ0smysFkPS78ES
   9hjrg2Th5JHw1RaNxSRacQAjAT9H7e+d0HF1vuP3EWTFUAUa/t8u2G2J8
   1UsqTcCtV8YQd6kzfEnTxEfmYWtXx/gne6lXznSNxy3yTvc2e7ZAyfshi
   +CxLhhXHQet66pTK/J/gmIVmUfZnysjAxdqNntjMCacb3H2k+tHutU1Fl
   VujgyUncvts5XFy/R2We7yQPrhETd/pSGmEiZQCV4xqJOjbWiu7aaj7/t
   opXFsy0UnrlfMaNnGmoe56/Ok49N96+4xrEPYsVJpIpdTCXwt3lkcVjPz
   A==;
X-CSE-ConnectionGUID: ZnO2IRssQqmaFQ40yx/nTg==
X-CSE-MsgGUID: e48KMvDhRQmBbQDQzVSBRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40253119"
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="40253119"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 13:44:19 -0800
X-CSE-ConnectionGUID: Xcxq3PUVTLG+Bst+CUvDkw==
X-CSE-MsgGUID: VC7NV0P5SOauuZ5bzzq2XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="113546302"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.124.223.241])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 13:44:18 -0800
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
Subject: [PATCH v2 0/3] Add Pather Lake support to intel_pmc_core
Date: Fri, 14 Feb 2025 13:44:08 -0800
Message-ID: <20250214214416.10150-1-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series contains three patches. The first one adds Panther
Lake support to intel_pmc_core driver. The second patch removes
unnecessary declarations in header file. The third patch removes
unnecessary extern keyword of function declaration in header file.

v2->v1:
- Remove unnecessary variable declarations in header file
- Remove unnecessary extern keyword in header file

Xi Pardee (3):
  platform/x86/intel/pmc: Add Panther Lake support to intel_pmc_core
  platform/x86/intel/pmc: Remove unnecessary declarations in header
  platform/x86/intel/pmc: Remove unneeded extern keyword in header

 drivers/platform/x86/intel/pmc/Makefile |   2 +-
 drivers/platform/x86/intel/pmc/adl.c    |  34 +-
 drivers/platform/x86/intel/pmc/arl.c    |  58 +--
 drivers/platform/x86/intel/pmc/cnp.c    |   8 +-
 drivers/platform/x86/intel/pmc/core.c   |   1 +
 drivers/platform/x86/intel/pmc/core.h   | 149 +------
 drivers/platform/x86/intel/pmc/icl.c    |   6 +-
 drivers/platform/x86/intel/pmc/lnl.c    |  42 +-
 drivers/platform/x86/intel/pmc/mtl.c    |  64 +--
 drivers/platform/x86/intel/pmc/ptl.c    | 551 ++++++++++++++++++++++++
 drivers/platform/x86/intel/pmc/spt.c    |  12 +-
 drivers/platform/x86/intel/pmc/tgl.c    |  20 +-
 12 files changed, 691 insertions(+), 256 deletions(-)
 create mode 100644 drivers/platform/x86/intel/pmc/ptl.c

-- 
2.43.0


