Return-Path: <linux-pm+bounces-13812-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2053096FB5A
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 20:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E5931C2184D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 18:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBF41487FE;
	Fri,  6 Sep 2024 18:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nJ/Gz7g9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF3113C3F2;
	Fri,  6 Sep 2024 18:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725648023; cv=none; b=JRbDioLJ/UY1wF+fHTYCTSjcE/BG98rj/P2/Cn+/LBsKaWpXrKx31fn6Wea04vBXa91sIli2qAxH4YdrScgL4f9pdJzHcwlzdBzE7F31Dt0oUJsbWWm6yhKz8554aI3PX4BSxu15Qwps3EgyBmjnQXFVEA9Om2MeN4FAqsqU2XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725648023; c=relaxed/simple;
	bh=ByBLS/TgKju3kVxjNGcln0VluWof+FbKlFmQWHtreFs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=i6NYOvLYqK7HmXPnzZOFdmCPkx7q/VQEpysTIxEoPMUEh/iUlKKPatc1gHtchG8Rn2DvQUU8rZmVAd19zJtk9EL4RgJnNjegCPvO7VkqegbLWRSArHXqTuoFcOOlA0wEVmYGcrcDEKHZWD510Mueg7mexf5SWuzDhjmSVKX3ofI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nJ/Gz7g9; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725648022; x=1757184022;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ByBLS/TgKju3kVxjNGcln0VluWof+FbKlFmQWHtreFs=;
  b=nJ/Gz7g94clH0LuHXny8rUYIEZ6x+O4nFz/9lsdcOipNMNQPY3jH9rgj
   tXS2UwV2choZoiT3VoN7QBkfFjGbHBxVGuyC2IvE+XOOdwbOCnkkm8ywI
   QQIPtfh4Gdv1Thkh37sCo4z8PEZmtDCxexDyw6oHdTgJnOrrxtjoSreQr
   cqNmW7VY8WsZSmEDDXdQ/DmEnjCaPGhSp2c2lEQKaPDbkkRjcF7Xd+S3l
   09PktvQ6YDFG8VLDeO+1czBLvbpB4vNtQMnT7dwqjGPiws7uXZRFZk1BA
   VqSBxC1NjvoB31rxuS/P/scJDu3XWysgNI7V6Gi19ALrxHUb00HhATGaK
   A==;
X-CSE-ConnectionGUID: LmrNQnZhQFaRmcJCYDg7IQ==
X-CSE-MsgGUID: xOHVwicRQAmYq/g4VDlH6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="41928408"
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="41928408"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 11:40:21 -0700
X-CSE-ConnectionGUID: ZmmYJvEYQKWj12aZUXAWYQ==
X-CSE-MsgGUID: 0Y8eQNHzQt+IcOC5XElDXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="66007696"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO xpardee-desk.hsd1.or.comcast.net) ([10.124.222.182])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 11:40:20 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2] platform/x86:intel/pmc: Ignore all LTRs during suspend
Date: Fri,  6 Sep 2024 11:40:03 -0700
Message-ID: <20240906184016.268153-1-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xi Pardee <xi.pardee@intel.com>

Add support to ignore all LTRs before suspend and restore the previous
LTR values after suspend. This feature could be turned off with module
parameter ltr_ignore_all_suspend.

LTR value is a mechanism for a device to indicate tolerance to access
the corresponding resource. When system suspends, the resource is not
available and therefore the LTR value could be ignored. Ignoring all
LTR values prevents problematic device from blocking the system to get
to the deepest package state during suspend.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Xi Pardee <xi.pardee@intel.com>

v2:
- Add more details to commit message
- Fix format: ltr->LTR, S0IX->S0ix, space between name and email

---
 drivers/platform/x86/intel/pmc/core.c | 53 +++++++++++++++++++++++++++
 drivers/platform/x86/intel/pmc/core.h |  2 +
 2 files changed, 55 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 01ae71c6df59..0ec703af16a4 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -714,6 +714,49 @@ static int pmc_core_s0ix_blocker_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_s0ix_blocker);
 
+static void pmc_core_ltr_ignore_all(struct pmc_dev *pmcdev)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); i++) {
+		struct pmc *pmc;
+		u32 ltr_ign;
+
+		pmc = pmcdev->pmcs[i];
+		if (!pmc)
+			continue;
+
+		guard(mutex)(&pmcdev->lock);
+		pmc->ltr_ign = pmc_core_reg_read(pmc, pmc->map->ltr_ignore_offset);
+
+		/* ltr_ignore_max is the max index value for LTR ignore register */
+		ltr_ign = pmc->ltr_ign | GENMASK(pmc->map->ltr_ignore_max, 0);
+		pmc_core_reg_write(pmc, pmc->map->ltr_ignore_offset, ltr_ign);
+	}
+
+	/*
+	 * Ignoring ME during suspend is blocking platforms with ADL PCH to get to
+	 * deeper S0ix substate.
+	 */
+	pmc_core_send_ltr_ignore(pmcdev, 6, 0);
+}
+
+static void pmc_core_ltr_restore_all(struct pmc_dev *pmcdev)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); i++) {
+		struct pmc *pmc;
+
+		pmc = pmcdev->pmcs[i];
+		if (!pmc)
+			continue;
+
+		guard(mutex)(&pmcdev->lock);
+		pmc_core_reg_write(pmc, pmc->map->ltr_ignore_offset, pmc->ltr_ign);
+	}
+}
+
 static inline u64 adjust_lpm_residency(struct pmc *pmc, u32 offset,
 				       const int lpm_adj_x2)
 {
@@ -1479,6 +1522,10 @@ static bool warn_on_s0ix_failures;
 module_param(warn_on_s0ix_failures, bool, 0644);
 MODULE_PARM_DESC(warn_on_s0ix_failures, "Check and warn for S0ix failures");
 
+static bool ltr_ignore_all_suspend = true;
+module_param(ltr_ignore_all_suspend, bool, 0644);
+MODULE_PARM_DESC(ltr_ignore_all_suspend, "Ignore all LTRs during suspend");
+
 static __maybe_unused int pmc_core_suspend(struct device *dev)
 {
 	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
@@ -1488,6 +1535,9 @@ static __maybe_unused int pmc_core_suspend(struct device *dev)
 	if (pmcdev->suspend)
 		pmcdev->suspend(pmcdev);
 
+	if (ltr_ignore_all_suspend)
+		pmc_core_ltr_ignore_all(pmcdev);
+
 	/* Check if the syspend will actually use S0ix */
 	if (pm_suspend_via_firmware())
 		return 0;
@@ -1594,6 +1644,9 @@ static __maybe_unused int pmc_core_resume(struct device *dev)
 {
 	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
 
+	if (ltr_ignore_all_suspend)
+		pmc_core_ltr_restore_all(pmcdev);
+
 	if (pmcdev->resume)
 		return pmcdev->resume(pmcdev);
 
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index ea04de7eb9e8..e862ea88b816 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -372,6 +372,7 @@ struct pmc_info {
  * @map:		pointer to pmc_reg_map struct that contains platform
  *			specific attributes
  * @lpm_req_regs:	List of substate requirements
+ * @ltr_ign:		Holds LTR ignore data while suspended
  *
  * pmc contains info about one power management controller device.
  */
@@ -380,6 +381,7 @@ struct pmc {
 	void __iomem *regbase;
 	const struct pmc_reg_map *map;
 	u32 *lpm_req_regs;
+	u32 ltr_ign;
 };
 
 /**
-- 
2.43.0


