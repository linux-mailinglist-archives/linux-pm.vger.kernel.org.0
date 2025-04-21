Return-Path: <linux-pm+bounces-25823-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2D6A957CC
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 23:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 863943B55E5
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 21:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8786E214A77;
	Mon, 21 Apr 2025 21:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WPTt+w6R"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8688F21420B;
	Mon, 21 Apr 2025 21:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745269872; cv=none; b=etmb4bxVh2o22ITdHMjxUxHv+XkcyHdpDGpPkjglCsClraLWe9m0sQ6VE5C+eNfrzo+e4A6nYUVSk7F6Nr2ZOgHOqMXHSxpIBrY0J0Goj/jfAMLxOTr+f2Ul1quamLP4zBHq1GM29O4Wzah4ms56K3c+JaZ3lC3ACfErQS+sN4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745269872; c=relaxed/simple;
	bh=dQTo2auo7YYe6bQD+dMhfbjfL+qqQOgNTyTqgNyA/K8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O4UpTLD27ExEUTsgZFyoNdU1JYA3ky2qOc2Hm/xdy9Vct0jTGH+JYUGplRjChz+FGjhpIEf6rPAGM59EZ48IbUN+Z64iKbloVEH4adLmbCbLVZF01b/wl4udU+h/W1Ozj2dijnltW3UbED9G/k3KzYPsFB+LO9V3sM4WUGoh+TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WPTt+w6R; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745269871; x=1776805871;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=dQTo2auo7YYe6bQD+dMhfbjfL+qqQOgNTyTqgNyA/K8=;
  b=WPTt+w6RDkERifuPrKOE4LR0Dcit7LjWAgZm6QGDdR3D1m8KfzEKuQy8
   eZPdwe15IrHtLcr7zCBY3EA8feshY9IxVyppwDvo1e0GUBJNLeW4gqnNc
   QXKzmNpjsQPXY8LskQjoSMl462MVnxWIHRBzo8dQWpOAwgk84fvyYdDIW
   SKwfb0ieUCtbdfehEzqIhrrfdWhe565z/8IMEoefe7QZtlW1MiZ8uQ6PT
   NBD0nH+4FzyuYnjR/HZ7goxFf1h/9ZjcBFu3y9ZUsYrM9ov38BjBM4x8t
   PfULMlVfdxkjwDMVyFSuKHe+fc7vHevxTzwHy5q1tZ3zbwlBUJisi8uGi
   w==;
X-CSE-ConnectionGUID: f44SpKKpSnOhC6nkVC8VPg==
X-CSE-MsgGUID: U9pOP4DKQ/G+9O9Aw3K3wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="58189458"
X-IronPort-AV: E=Sophos;i="6.15,229,1739865600"; 
   d="scan'208";a="58189458"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 14:11:06 -0700
X-CSE-ConnectionGUID: JcWcA1vhQp2pcmb1nrbeDw==
X-CSE-MsgGUID: ZI4WE/ckS4aAGDRDxoniVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,229,1739865600"; 
   d="scan'208";a="136912174"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.124.220.165])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 14:11:04 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v4 4/4] platform/x86:intel/pmc: Improve pmc_core_get_lpm_req()
Date: Mon, 21 Apr 2025 14:10:57 -0700
Message-ID: <20250421211100.687250-5-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250421211100.687250-1-xi.pardee@linux.intel.com>
References: <20250421211100.687250-1-xi.pardee@linux.intel.com>
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
index e09a97564398..6f092b00b030 100644
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


