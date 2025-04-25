Return-Path: <linux-pm+bounces-26253-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B946AA9D26A
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 21:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD1D1B61D2A
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 19:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD68D22258B;
	Fri, 25 Apr 2025 19:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LJbN67Rf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B1A221704;
	Fri, 25 Apr 2025 19:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745610790; cv=none; b=ODJ2+v4J5ZGMvsUyUBXWR5ijRVuOlvywuyfDiBCHC6tvOvcheg3ILn6EHaKkXOD7dI9pynBCnvLoGkhiQ81iD4Q/jSW1LbXKUc6repqXWDuJQLqNVAQ7GtFxRUWW4HR/af37HNbTOLInM3dMxdZ0hSkFXwUXCdCWizf8IhRLhVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745610790; c=relaxed/simple;
	bh=3eSQv2UNe5eOwT6TAzbtProjbgsWSt99OXQzpmeAQDI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCrFBsFT9Kp332rcTm17l4+ibYZixkJVV29CfJ09RayNTI23LdDhrmf8rf2tY3m9lPyy9+8X+W/bWu8Go/fj211mMVp1eTc1SI/AAQKDH4s1fmEEDpS/ThAaVISsT08kjk+TdLc8UXCSPYsJiXvKU1a3lMJtHEm0RWJDOxKH67U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LJbN67Rf; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745610789; x=1777146789;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=3eSQv2UNe5eOwT6TAzbtProjbgsWSt99OXQzpmeAQDI=;
  b=LJbN67RfefH4Gx3EkWMxSc64i8TyGwvpwTi8ewkqGVHF/1obG17fiiUZ
   64i3ZhVi0yNrVC867ASx2omxf5fQMtjqokuFrFQWT7tCHiQHh2c4opmTi
   d3nzPPId4gtBx7hzLTklVTgvNHqmkFXRvZqtwdsvJ692M0t34au62Xktn
   wxe5yVVohVuaLE0t5qlvRGkj3+yy/63muo8G4jFj7jLL8XXrQYGT7Z+wn
   mskz9ogA/OR2cZlswmqHu0mTkVr7282HgU/lCvcCCMN028lxTB1tAADSn
   kyOSXrP0/lsMz0+xJKMakK821a7YXzZgfncm0kK1cl9mnDloJAjUHzRpJ
   w==;
X-CSE-ConnectionGUID: jZXrsT94TqCUN9XlHknzew==
X-CSE-MsgGUID: ++tQRgmcQ6OljMJSfpsW2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="69776233"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="69776233"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 12:52:42 -0700
X-CSE-ConnectionGUID: lyNoPJcvQYuPcxp9U4a3yw==
X-CSE-MsgGUID: +gKk4N5gSQOZtBNJ12vAjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="132897658"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.124.222.107])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 12:52:42 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v5 5/5] platform/x86:intel/pmc: Improve pmc_core_get_lpm_req()
Date: Fri, 25 Apr 2025 12:52:33 -0700
Message-ID: <20250425195237.493129-6-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425195237.493129-1-xi.pardee@linux.intel.com>
References: <20250425195237.493129-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Minor improvements on pmc_core_get_lpm_req().
1. Move the long comment to be above the function
2. Use %pe to print error pointer
3. Remove unneeded devm_kfree call

These changes improves the code maintainability.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 91 +++++++++++++--------------
 1 file changed, 45 insertions(+), 46 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 93a335b0ea63..a32adc53da98 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1355,6 +1355,50 @@ static u32 pmc_core_find_guid(struct pmc_info *list, const struct pmc_reg_map *m
 	return 0;
 }
 
+/*
+ * This function retrieves low power mode requirement data from PMC Low
+ * Power Mode (LPM) table.
+ *
+ * In telemetry space, the LPM table contains a 4 byte header followed
+ * by 8 consecutive mode blocks (one for each LPM mode). Each block
+ * has a 4 byte header followed by a set of registers that describe the
+ * IP state requirements for the given mode. The IP mapping is platform
+ * specific but the same for each block, making for easy analysis.
+ * Platforms only use a subset of the space to track the requirements
+ * for their IPs. Callers provide the requirement registers they use as
+ * a list of indices. Each requirement register is associated with an
+ * IP map that's maintained by the caller.
+ *
+ * Header
+ * +----+----------------------------+----------------------------+
+ * |  0 |      REVISION              |      ENABLED MODES         |
+ * +----+--------------+-------------+-------------+--------------+
+ *
+ * Low Power Mode 0 Block
+ * +----+--------------+-------------+-------------+--------------+
+ * |  1 |     SUB ID   |     SIZE    |   MAJOR     |   MINOR      |
+ * +----+--------------+-------------+-------------+--------------+
+ * |  2 |           LPM0 Requirements 0                           |
+ * +----+---------------------------------------------------------+
+ * |    |                  ...                                    |
+ * +----+---------------------------------------------------------+
+ * | 29 |           LPM0 Requirements 27                          |
+ * +----+---------------------------------------------------------+
+ *
+ * ...
+ *
+ * Low Power Mode 7 Block
+ * +----+--------------+-------------+-------------+--------------+
+ * |    |     SUB ID   |     SIZE    |   MAJOR     |   MINOR      |
+ * +----+--------------+-------------+-------------+--------------+
+ * | 60 |           LPM7 Requirements 0                           |
+ * +----+---------------------------------------------------------+
+ * |    |                  ...                                    |
+ * +----+---------------------------------------------------------+
+ * | 87 |           LPM7 Requirements 27                          |
+ * +----+---------------------------------------------------------+
+ *
+ */
 static int pmc_core_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc, struct pci_dev *pcidev)
 {
 	struct telem_endpoint *ep;
@@ -1374,8 +1418,7 @@ static int pmc_core_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc, struct
 
 	ep = pmt_telem_find_and_register_endpoint(pcidev, guid, 0);
 	if (IS_ERR(ep)) {
-		dev_dbg(&pmcdev->pdev->dev, "couldn't get telem endpoint %ld",
-			PTR_ERR(ep));
+		dev_dbg(&pmcdev->pdev->dev, "couldn't get telem endpoint %pe", ep);
 		return -EPROBE_DEFER;
 	}
 
@@ -1387,49 +1430,6 @@ static int pmc_core_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc, struct
 		goto unregister_ep;
 	}
 
-	/*
-	 * PMC Low Power Mode (LPM) table
-	 *
-	 * In telemetry space, the LPM table contains a 4 byte header followed
-	 * by 8 consecutive mode blocks (one for each LPM mode). Each block
-	 * has a 4 byte header followed by a set of registers that describe the
-	 * IP state requirements for the given mode. The IP mapping is platform
-	 * specific but the same for each block, making for easy analysis.
-	 * Platforms only use a subset of the space to track the requirements
-	 * for their IPs. Callers provide the requirement registers they use as
-	 * a list of indices. Each requirement register is associated with an
-	 * IP map that's maintained by the caller.
-	 *
-	 * Header
-	 * +----+----------------------------+----------------------------+
-	 * |  0 |      REVISION              |      ENABLED MODES         |
-	 * +----+--------------+-------------+-------------+--------------+
-	 *
-	 * Low Power Mode 0 Block
-	 * +----+--------------+-------------+-------------+--------------+
-	 * |  1 |     SUB ID   |     SIZE    |   MAJOR     |   MINOR      |
-	 * +----+--------------+-------------+-------------+--------------+
-	 * |  2 |           LPM0 Requirements 0                           |
-	 * +----+---------------------------------------------------------+
-	 * |    |                  ...                                    |
-	 * +----+---------------------------------------------------------+
-	 * | 29 |           LPM0 Requirements 27                          |
-	 * +----+---------------------------------------------------------+
-	 *
-	 * ...
-	 *
-	 * Low Power Mode 7 Block
-	 * +----+--------------+-------------+-------------+--------------+
-	 * |    |     SUB ID   |     SIZE    |   MAJOR     |   MINOR      |
-	 * +----+--------------+-------------+-------------+--------------+
-	 * | 60 |           LPM7 Requirements 0                           |
-	 * +----+---------------------------------------------------------+
-	 * |    |                  ...                                    |
-	 * +----+---------------------------------------------------------+
-	 * | 87 |           LPM7 Requirements 27                          |
-	 * +----+---------------------------------------------------------+
-	 *
-	 */
 	mode_offset = LPM_HEADER_OFFSET + LPM_MODE_OFFSET;
 	pmc_for_each_mode(mode, pmcdev) {
 		u32 *req_offset = pmc->lpm_req_regs + (mode * num_maps);
@@ -1442,7 +1442,6 @@ static int pmc_core_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc, struct
 			if (ret) {
 				dev_err(&pmcdev->pdev->dev,
 					"couldn't read Low Power Mode requirements: %d\n", ret);
-				devm_kfree(&pmcdev->pdev->dev, pmc->lpm_req_regs);
 				goto unregister_ep;
 			}
 			++req_offset;
-- 
2.43.0


