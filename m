Return-Path: <linux-pm+bounces-20170-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A00A083F0
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 01:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 155F6188C12F
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 00:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E7A1A8F97;
	Fri, 10 Jan 2025 00:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R/ofA0j7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FC73FBA7;
	Fri, 10 Jan 2025 00:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736468782; cv=none; b=qWhs79miwCGP2OQ0LsTJodHMrpaK/GXpPlRzir+fVOaIj/wokR7biBuZnYSWyyCn4nckqKbaAszk66FHJvGsnCNzZ6UghYwKvdbv5yO/05dGCMFk7iCgiu0Dlpr+G3Z+/0/c9H0V8fcNs9Eb5In+Q4QYuP4NpJ+hG5eVNx7jqzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736468782; c=relaxed/simple;
	bh=/244OWp4sv4+GPpMOflZBbt/X4JpCPVitjXKMXywhLs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6lT+/ucFa4cTIZ6TXeSJu4dA5iuXQaWeUb/kQVqvqn/i8W5h2y2OK8pY0pD9MvgEM7D7og9ydyO8D7oOM58/vFhjOupuD7G4uETzzcp49VDI+6x29wKEa62PdZ3n5vL/gqU8foYmDvwys9eX6kqCsnAa5W6ZyqiNKqrzaveEy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R/ofA0j7; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736468781; x=1768004781;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=/244OWp4sv4+GPpMOflZBbt/X4JpCPVitjXKMXywhLs=;
  b=R/ofA0j7jZRHHpzJBnFujZfoA3VwmQmgNUrbtQzozZFbVvWIJ6V9vpH0
   Le0YrDILq8RJhSif96uSqgaC12LxifYkzbzl+bDpDBVjFqtUMI9Iowpa5
   ORr2ED1V5NA5j9ETncDEqGmChZDs10Zw3QPpoKXAmBZ9pnWuRTGpKaaQj
   9tQvPnWTA8LRpp+AYlZTY6mhjWez9NL2YozL4SZioBR7Yda/TQEq36rAB
   aGrh36h0Mv4XjptOY/5RupmGaanDHPr8swDnb2s6IjkHCwlG3lwPkoj/9
   Kt+kbEAjNse/t2/KCCzu5+BarnDIfcnfj6M4J9p06+hBtzQGwi2HvvnSP
   g==;
X-CSE-ConnectionGUID: QrvAcPhYTkK8RC45WO49Zw==
X-CSE-MsgGUID: OcEqu9BtSwaQJq2hxvmtFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="36653491"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="36653491"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 16:26:19 -0800
X-CSE-ConnectionGUID: E32QdJnrQOeB1GEJSSJEng==
X-CSE-MsgGUID: MGrZmKPxTdWFROVJfP4MAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104097030"
Received: from sramkris-mobl1.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.124.222.100])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 16:26:19 -0800
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
Subject: [PATCH v4 4/6] platform/x86/intel/pmc: Create architecture specific callback
Date: Thu,  9 Jan 2025 16:26:06 -0800
Message-ID: <20250110002612.244782-5-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250110002612.244782-1-xi.pardee@linux.intel.com>
References: <20250110002612.244782-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add architecture specific callback field in pmc_dev_info structure.
Architecture specific action could be handled in this callback instead
of per architecture init functions. Convert Arrow Lake, Lunar Lake,
Meteor Lake and Tiger Lake platforms to use this field.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/arl.c  | 15 +++++++--------
 drivers/platform/x86/intel/pmc/core.c |  3 +++
 drivers/platform/x86/intel/pmc/core.h |  7 +++++++
 drivers/platform/x86/intel/pmc/lnl.c  | 15 +++++++--------
 drivers/platform/x86/intel/pmc/mtl.c  | 15 +++++++--------
 drivers/platform/x86/intel/pmc/tgl.c  | 15 +++++----------
 6 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
index dedf752237ca0..9ff90d32a635f 100644
--- a/drivers/platform/x86/intel/pmc/arl.c
+++ b/drivers/platform/x86/intel/pmc/arl.c
@@ -698,16 +698,15 @@ static struct pmc_dev_info arl_pmc_dev = {
 	.map = &arl_socs_reg_map,
 	.suspend = cnl_suspend,
 	.resume = arl_resume,
+	.arch_specific = arl_specific_init,
 };
 
-int arl_core_init(struct pmc_dev *pmcdev)
+void arl_specific_init(struct pmc_dev *pmcdev)
 {
-	int ret;
-
-	ret = generic_core_init(pmcdev, &arl_pmc_dev);
-	if (ret)
-		return ret;
-
 	arl_d3_fixup();
-	return 0;
+}
+
+int arl_core_init(struct pmc_dev *pmcdev)
+{
+	return generic_core_init(pmcdev, &arl_pmc_dev);
 }
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 64b1c15e0c81d..45efe0e948831 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1380,6 +1380,9 @@ int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
 	if (pmc_dev_info->dmu_guid)
 		pmc_core_punit_pmt_init(pmcdev, pmc_dev_info->dmu_guid);
 
+	if (pmc_dev_info->arch_specific)
+		pmc_dev_info->arch_specific(pmcdev);
+
 	if (ssram)
 		return pmc_core_ssram_get_lpm_reqs(pmcdev);
 
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 80adae582ce5f..9430e4209ce97 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -446,6 +446,7 @@ enum pmc_index {
  *			specific attributes of the primary PMC
  * @suspend:		Function to perform platform specific suspend
  * @resume:		Function to perform platform specific resume
+ * @arch_specific:	Function to perform platform specific init action
  */
 struct pmc_dev_info {
 	u8 func;
@@ -454,6 +455,7 @@ struct pmc_dev_info {
 	const struct pmc_reg_map *map;
 	void (*suspend)(struct pmc_dev *pmcdev);
 	int (*resume)(struct pmc_dev *pmcdev);
+	void (*arch_specific)(struct pmc_dev *pmcdev);
 };
 
 extern const struct pmc_bit_map msr_map[];
@@ -623,6 +625,11 @@ int mtl_core_init(struct pmc_dev *pmcdev);
 int arl_core_init(struct pmc_dev *pmcdev);
 int lnl_core_init(struct pmc_dev *pmcdev);
 
+void arl_specific_init(struct pmc_dev *pmcdev);
+void mtl_specific_init(struct pmc_dev *pmcdev);
+void lnl_specific_init(struct pmc_dev *pmcdev);
+void tgl_specific_init(struct pmc_dev *pmcdev);
+
 void cnl_suspend(struct pmc_dev *pmcdev);
 int cnl_resume(struct pmc_dev *pmcdev);
 
diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
index 2e6d4fddd2858..957d7a9062397 100644
--- a/drivers/platform/x86/intel/pmc/lnl.c
+++ b/drivers/platform/x86/intel/pmc/lnl.c
@@ -554,16 +554,15 @@ static struct pmc_dev_info lnl_pmc_dev = {
 	.map = &lnl_socm_reg_map,
 	.suspend = cnl_suspend,
 	.resume = lnl_resume,
+	.arch_specific = lnl_specific_init,
 };
 
-int lnl_core_init(struct pmc_dev *pmcdev)
+void lnl_specific_init(struct pmc_dev *pmcdev)
 {
-	int ret;
-
-	ret = generic_core_init(pmcdev, &lnl_pmc_dev);
-	if (ret)
-		return ret;
-
 	lnl_d3_fixup();
-	return 0;
+}
+
+int lnl_core_init(struct pmc_dev *pmcdev)
+{
+	return generic_core_init(pmcdev, &lnl_pmc_dev);
 }
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index 3bc0b64d19141..2a7d79dd37d6a 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -997,16 +997,15 @@ static struct pmc_dev_info mtl_pmc_dev = {
 	.map = &mtl_socm_reg_map,
 	.suspend = cnl_suspend,
 	.resume = mtl_resume,
+	.arch_specific = mtl_specific_init,
 };
 
-int mtl_core_init(struct pmc_dev *pmcdev)
+void mtl_specific_init(struct pmc_dev *pmcdev)
 {
-	int ret;
-
-	ret = generic_core_init(pmcdev, &mtl_pmc_dev);
-	if (ret)
-		return ret;
-
 	mtl_d3_fixup();
-	return 0;
+}
+
+int mtl_core_init(struct pmc_dev *pmcdev)
+{
+	return generic_core_init(pmcdev, &mtl_pmc_dev);
 }
diff --git a/drivers/platform/x86/intel/pmc/tgl.c b/drivers/platform/x86/intel/pmc/tgl.c
index bc3cb949c672e..29a9109afc782 100644
--- a/drivers/platform/x86/intel/pmc/tgl.c
+++ b/drivers/platform/x86/intel/pmc/tgl.c
@@ -289,32 +289,27 @@ static struct pmc_dev_info tgl_l_pmc_dev = {
 	.map = &tgl_reg_map,
 	.suspend = cnl_suspend,
 	.resume = cnl_resume,
+	.arch_specific = tgl_specific_init,
 };
 
 static struct pmc_dev_info tgl_pmc_dev = {
 	.map = &tgl_h_reg_map,
 	.suspend = cnl_suspend,
 	.resume = cnl_resume,
+	.arch_specific = tgl_specific_init,
 };
 
-static int tgl_core_generic_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
+void tgl_specific_init(struct pmc_dev *pmcdev)
 {
-	int ret;
-
-	ret = generic_core_init(pmcdev, pmc_dev_info);
-	if (ret)
-		return ret;
-
 	pmc_core_get_tgl_lpm_reqs(pmcdev->pdev);
-	return 0;
 }
 
 int tgl_l_core_init(struct pmc_dev *pmcdev)
 {
-	return tgl_core_generic_init(pmcdev, &tgl_l_pmc_dev);
+	return generic_core_init(pmcdev, &tgl_l_pmc_dev);
 }
 
 int tgl_core_init(struct pmc_dev *pmcdev)
 {
-	return tgl_core_generic_init(pmcdev, &tgl_pmc_dev);
+	return generic_core_init(pmcdev, &tgl_pmc_dev);
 }
-- 
2.43.0


