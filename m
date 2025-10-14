Return-Path: <linux-pm+bounces-36102-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE3ABDB73D
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 23:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3ED195022DD
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 21:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD78A30E824;
	Tue, 14 Oct 2025 21:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RdV37sf7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D9130DD2B;
	Tue, 14 Oct 2025 21:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760478388; cv=none; b=WM6cdwWy7GvzV5qkU9zzym17d3Rs6eTLJzqb2F/X99KusJxQ1EUGbGQdGba/Bing39wj1+W8vjCQxlwh5LgzgmpzaFvI0LqiuQN5QR0URhP+JEnsfdCvu2K07WekR3d5v16KJLHzgd6DUwGayZkMKBHfeWvtgyrDD9nf8vDmlKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760478388; c=relaxed/simple;
	bh=9+nqjtv9D+8Gsfc0zTEGGTEvj2DMC2y1s1ZMhLvAW+I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=stIxvWVRCcH1AOGtQNyiy85crKkRJpKYVgzEDmF6fp73CXZakEgkPtjFCmQxZImpvHgdfGYYD2o5ZS2aJbXAbLfyNLx0Kx52iSxgRPov/46k+iyj0Mr6inGoKedFrg/fPstYrReQPTBEK4QhDTFGpR2wFEKwLDk+FinUkQRGSaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RdV37sf7; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760478387; x=1792014387;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=9+nqjtv9D+8Gsfc0zTEGGTEvj2DMC2y1s1ZMhLvAW+I=;
  b=RdV37sf7M3QTw/C6JX4BcmcHil9H8Tt0ijR26GNjgBBwUPAeGkRbbQA2
   XYJKv5cjlpcd2BKg9thd+XAPLxi6KA74xu7hlc83a6x4YJtwxivtvooQM
   7lAqS4NV2cCTqePtzXw00pyZf0tFJQ8JpolG1uwdTbBZWWxp/nbeeBlQ0
   FTXvmyyf8EbH3d8eIUezkG9ks35SRwktot3t6x1gLguB4Btv8sZTX+E1N
   fRpuj7waf7XQVPIH0dBQz5rt0NQRiJlcY1gE6pai4i/2A9ynBYXLn/mUw
   Z8F0Ou6jSUmR1LbuktbiLMMOWqa53xO/HFL8V9sIelF5PvLcr5oghwOvT
   Q==;
X-CSE-ConnectionGUID: +fEofX/rQ8eHfg2R+uwjwg==
X-CSE-MsgGUID: 4GX5GZ0XSIqk1snoDttUZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62682460"
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="scan'208";a="62682460"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 14:46:25 -0700
X-CSE-ConnectionGUID: 39xsQBlbRpCutuEuPze2ag==
X-CSE-MsgGUID: mKIabccSTSqhO/fRgCD1Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="scan'208";a="187300361"
Received: from kcaccard-desk.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.125.111.190])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 14:46:24 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 6/6] platform/x86:intel/pmc: Remove redundant has_die_c6 variable
Date: Tue, 14 Oct 2025 14:45:34 -0700
Message-ID: <20251014214548.629023-7-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014214548.629023-1-xi.pardee@linux.intel.com>
References: <20251014214548.629023-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove has_die_c6 variable from the pmc_dev struct. This variable
is unnecessary as the availability of die C6 could be inferred by
the punit_ep variable.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 4 +---
 drivers/platform/x86/intel/pmc/core.h | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index f10445220c2aa..4b857fc72f68c 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1317,8 +1317,6 @@ void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, u32 *guids)
 	}
 
 	pmcdev->punit_ep = ep;
-
-	pmcdev->has_die_c6 = true;
 	pmcdev->die_c6_offset = MTL_PMT_DMU_DIE_C6_OFFSET;
 }
 
@@ -1438,7 +1436,7 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev, struct pmc_dev_info
 				    pmcdev->dbgfs_dir, primary_pmc, &pmc_core_pson_residency);
 	}
 
-	if (pmcdev->has_die_c6) {
+	if (pmcdev->punit_ep) {
 		debugfs_create_file("die_c6_us_show", 0444,
 				    pmcdev->dbgfs_dir, pmcdev,
 				    &pmc_core_die_c6_us_fops);
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index cccd3bcafe00d..61c8d3c5faa0f 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -468,7 +468,6 @@ struct pmc_dev {
 	u64 *pkgc_res_cnt;
 	u8 num_of_pkgc;
 
-	bool has_die_c6;
 	u32 die_c6_offset;
 	struct telem_endpoint *punit_ep;
 	struct pmc_info *regmap_list;
-- 
2.43.0


