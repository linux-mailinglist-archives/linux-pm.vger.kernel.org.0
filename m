Return-Path: <linux-pm+bounces-43451-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMk1CfsPpmnlJgAAu9opvQ
	(envelope-from <linux-pm+bounces-43451-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 23:32:27 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEC71E58EA
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 23:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C6AF130117DE
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 22:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A96F31F99F;
	Mon,  2 Mar 2026 22:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="no2O1dGj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C708530EF8F;
	Mon,  2 Mar 2026 22:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772490740; cv=none; b=bt5MsLg/ltGNMNWrq2bi4AQAXcdLZ5EXzuH+HCHnJ6s2DIjl7MW8DNRqeqba6u4vpPooV1DZkn1NLUKHZ+/v0M2nQzVnJ9rqFDxo5ZBIC8K81Of18vM0QbdR1CeRXwE225e3Eufg+J6zGmbCRpnj4eXGmsoZS7NQcmzvkb91u0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772490740; c=relaxed/simple;
	bh=2xXK1zfjG+pDRjcIAlysG+ZrdsietD1wjifwDPdEtQk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JSjP2stLAnnXjnY+MKe+EyWXBpfpaAiWMS5h5GJ5RAV5naTpuaNlUR7h/GTHeoZmJ70UgmFKfUTe0nU7X2IguHmt3F7izmei7s0E0TQ2aHBIEmzMhGFwKHvlHVCRn5rctvx69KaJ/F499/mYQFTCAkkZyv+/DDtsT6wBELdFJwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=no2O1dGj; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772490738; x=1804026738;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=2xXK1zfjG+pDRjcIAlysG+ZrdsietD1wjifwDPdEtQk=;
  b=no2O1dGjNDpuHU08KOuBb9uqVi9li+4xKYlKPBYH5BPkVuxpfmbuFhQs
   CpfPczY7g3hr5tqEtE5hIZCo9Ra7VvtRzysZ2qe3eJy+WQcuueHt5uRjA
   BcV5y1+ffEg9e9/breFRop3BCDpyhRdmb9Bg7dq6JzVXTFyW8KMH+bCxO
   xQ7VT97oea8HOJgnSIHSIC85L+AefGhaN9EtHuEUbfSux+tmt0TY/Wtf4
   0RtO4G6TN0cYDWIEETYAarFqVhkn3QcEou5HG90UAGoLGSHWezmjC10dg
   in6kee5YTji2ybvEohCbaJNEwClY2GQbjLc0bNGgiwRl2kyNzfE5ztZDC
   g==;
X-CSE-ConnectionGUID: 9+OGe7QTR+SZ/lzQhAZuqw==
X-CSE-MsgGUID: ZkQqzsOESvadbSeNInRjSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73554500"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="73554500"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 14:32:17 -0800
X-CSE-ConnectionGUID: 6TqqYMe9R++lddDet26HoA==
X-CSE-MsgGUID: yQIU1LpSS+OLnlOyymTcAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="217793509"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.125.108.86])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 14:32:18 -0800
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 1/6] platform/x86/intel/pmc: Enable PkgC LTR blocking counter
Date: Mon,  2 Mar 2026 14:32:03 -0800
Message-ID: <20260302223214.484585-2-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260302223214.484585-1-xi.pardee@linux.intel.com>
References: <20260302223214.484585-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0DEC71E58EA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[xi.pardee@linux.intel.com,linux-pm@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-43451-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linux.intel.com,gmail.com,vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.intel.com:mid]
X-Rspamd-Action: no action

Enable the Package C-state LTR blocking counter in the PMT telemetry
region. This counter records how many times any Package C-state entry
is blocked for the specified reasons.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 77 ++++++++++++++++++++++-----
 drivers/platform/x86/intel/pmc/core.h | 15 +++++-
 2 files changed, 79 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 02b303418d185..bf95a1f2ba428 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1071,6 +1071,28 @@ static int pmc_core_die_c6_us_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_die_c6_us);
 
+static int pmc_core_pkgc_ltr_blocker_show(struct seq_file *s, void *unused)
+{
+	struct pmc_dev *pmcdev = s->private;
+	const char **pkgc_ltr_blocker_counters;
+	u32 counter, offset;
+	unsigned int i;
+	int ret;
+
+	offset = pmcdev->pkgc_ltr_blocker_offset;
+	pkgc_ltr_blocker_counters = pmcdev->pkgc_ltr_blocker_counters;
+	for (i = 0; pkgc_ltr_blocker_counters[i]; i++, offset++) {
+		ret = pmt_telem_read32(pmcdev->pc_ep, offset,
+				       &counter, 1);
+		if (ret)
+			return ret;
+		seq_printf(s, "%-30s %-30u\n", pkgc_ltr_blocker_counters[i], counter);
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(pmc_core_pkgc_ltr_blocker);
+
 static int pmc_core_lpm_latch_mode_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
@@ -1322,7 +1344,7 @@ static struct telem_endpoint *pmc_core_register_endpoint(struct pci_dev *pcidev,
 	return ERR_PTR(-ENODEV);
 }
 
-void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, u32 *guids)
+void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
 {
 	struct telem_endpoint *ep;
 	struct pci_dev *pcidev;
@@ -1333,17 +1355,35 @@ void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, u32 *guids)
 		return;
 	}
 
-	ep = pmc_core_register_endpoint(pcidev, guids);
-	pci_dev_put(pcidev);
-	if (IS_ERR(ep)) {
-		dev_err(&pmcdev->pdev->dev,
-			"pmc_core: couldn't get DMU telem endpoint %ld",
-			PTR_ERR(ep));
-		return;
+	if (pmc_dev_info->dmu_guids) {
+		ep = pmc_core_register_endpoint(pcidev, pmc_dev_info->dmu_guids);
+		if (IS_ERR(ep)) {
+			dev_err(&pmcdev->pdev->dev,
+				"pmc_core: couldn't get DMU telem endpoint %ld",
+				PTR_ERR(ep));
+			goto release_dev;
+		}
+
+		pmcdev->punit_ep = ep;
+		pmcdev->die_c6_offset = MTL_PMT_DMU_DIE_C6_OFFSET;
+	}
+
+	if (pmc_dev_info->pc_guid) {
+		ep = pmt_telem_find_and_register_endpoint(pcidev, pmc_dev_info->pc_guid, 0);
+		if (IS_ERR(ep)) {
+			dev_err(&pmcdev->pdev->dev,
+				"pmc_core: couldn't get Package C-state telem endpoint %ld",
+				PTR_ERR(ep));
+			goto release_dev;
+		}
+
+		pmcdev->pc_ep = ep;
+		pmcdev->pkgc_ltr_blocker_counters = pmc_dev_info->pkgc_ltr_blocker_counters;
+		pmcdev->pkgc_ltr_blocker_offset = pmc_dev_info->pkgc_ltr_blocker_offset;
 	}
 
-	pmcdev->punit_ep = ep;
-	pmcdev->die_c6_offset = MTL_PMT_DMU_DIE_C6_OFFSET;
+release_dev:
+	pci_dev_put(pcidev);
 }
 
 void pmc_core_set_device_d3(unsigned int device)
@@ -1467,6 +1507,13 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev, struct pmc_dev_info
 				    pmcdev->dbgfs_dir, pmcdev,
 				    &pmc_core_die_c6_us_fops);
 	}
+
+	if (pmcdev->pc_ep) {
+		debugfs_create_file("pkgc_ltr_blocker_show", 0444,
+				    pmcdev->dbgfs_dir, pmcdev,
+				    &pmc_core_pkgc_ltr_blocker_fops);
+	}
+
 }
 
 /*
@@ -1717,8 +1764,8 @@ int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
 	}
 
 	pmc_core_get_low_power_modes(pmcdev);
-	if (pmc_dev_info->dmu_guids)
-		pmc_core_punit_pmt_init(pmcdev, pmc_dev_info->dmu_guids);
+	if (pmc_dev_info->dmu_guids || pmc_dev_info->pc_guid)
+		pmc_core_punit_pmt_init(pmcdev, pmc_dev_info);
 
 	if (ssram) {
 		ret = pmc_core_get_telem_info(pmcdev, pmc_dev_info);
@@ -1739,6 +1786,9 @@ int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
 	if (pmcdev->punit_ep)
 		pmt_telem_unregister_endpoint(pmcdev->punit_ep);
 
+	if (pmcdev->pc_ep)
+		pmt_telem_unregister_endpoint(pmcdev->pc_ep);
+
 	return ret;
 }
 
@@ -1835,6 +1885,9 @@ static void pmc_core_clean_structure(struct platform_device *pdev)
 	if (pmcdev->punit_ep)
 		pmt_telem_unregister_endpoint(pmcdev->punit_ep);
 
+	if (pmcdev->pc_ep)
+		pmt_telem_unregister_endpoint(pmcdev->pc_ep);
+
 	platform_set_drvdata(pdev, NULL);
 }
 
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 118c8740ad3aa..a20aab73c1409 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -453,6 +453,9 @@ struct pmc {
  * @suspend:		Function to perform platform specific suspend
  * @resume:		Function to perform platform specific resume
  *
+ * @pkgc_ltr_blocker_counters: Array of PKGC LTR blocker counters
+ * @pkgc_ltr_blocker_offset: Offset to PKGC LTR blockers in telemetry region
+ *
  * pmc_dev contains info about power management controller device.
  */
 struct pmc_dev {
@@ -471,8 +474,12 @@ struct pmc_dev {
 	u8 num_of_pkgc;
 
 	u32 die_c6_offset;
+	struct telem_endpoint *pc_ep;
 	struct telem_endpoint *punit_ep;
 	struct pmc_info *regmap_list;
+
+	const char **pkgc_ltr_blocker_counters;
+	u32 pkgc_ltr_blocker_offset;
 };
 
 enum pmc_index {
@@ -486,12 +493,15 @@ enum pmc_index {
  * struct pmc_dev_info - Structure to keep PMC device info
  * @pci_func:		Function number of the primary PMC
  * @dmu_guids:		List of Die Management Unit GUID
+ * @pc_guid:		GUID for telemetry region to read PKGC blocker info
+ * @pkgc_ltr_blocker_offset: Offset to PKGC LTR blockers in telemetry region
  * @regmap_list:	Pointer to a list of pmc_info structure that could be
  *			available for the platform. When set, this field implies
  *			SSRAM support.
  * @map:		Pointer to a pmc_reg_map struct that contains platform
  *			specific attributes of the primary PMC
  * @sub_req_show:	File operations to show substate requirements
+ * @pkgc_ltr_blocker_counters: Array of PKGC LTR blocker counters
  * @suspend:		Function to perform platform specific suspend
  * @resume:		Function to perform platform specific resume
  * @init:		Function to perform platform specific init action
@@ -500,9 +510,12 @@ enum pmc_index {
 struct pmc_dev_info {
 	u8 pci_func;
 	u32 *dmu_guids;
+	u32 pc_guid;
+	u32 pkgc_ltr_blocker_offset;
 	struct pmc_info *regmap_list;
 	const struct pmc_reg_map *map;
 	const struct file_operations *sub_req_show;
+	const char **pkgc_ltr_blocker_counters;
 	void (*suspend)(struct pmc_dev *pmcdev);
 	int (*resume)(struct pmc_dev *pmcdev);
 	int (*init)(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
@@ -535,7 +548,7 @@ int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value, int ignore);
 
 int pmc_core_resume_common(struct pmc_dev *pmcdev);
 int get_primary_reg_base(struct pmc *pmc);
-void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, u32 *guids);
+void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
 void pmc_core_set_device_d3(unsigned int device);
 
 int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
-- 
2.43.0


