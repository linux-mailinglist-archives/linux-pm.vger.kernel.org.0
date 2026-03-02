Return-Path: <linux-pm+bounces-43452-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAT9IrcWpmnZKAAAu9opvQ
	(envelope-from <linux-pm+bounces-43452-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 00:01:11 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 598491E6298
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 00:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0CB4B30986BD
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 22:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480E831F9B6;
	Mon,  2 Mar 2026 22:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SXcLagpt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B8A31E84F;
	Mon,  2 Mar 2026 22:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772490741; cv=none; b=JKHOXogLLGb7LZraD1J8ZpY8N9BQWAAT0i3bJAAkSnRmvxlGqsq6UGGgSMh7HkrPaf5V8UfNGeYS7ItqOKClhYgoJ5G2KfbI+U+euSR9Mu8fD0UsQU9FgUtnULaVSMOLioPhtI491eJ68fszuQes4r7971lS66Ar72nn9iPxmFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772490741; c=relaxed/simple;
	bh=w0R5D59fw0/fMLooZV/U0tOSrRlfoHbcQIZawVTLQP4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FKuw0aSoJO/MZoOFYTjPMZxdXwSAkB99Qx+awDbUIwU4hxjj6x+ykROQnkHG1L2Ra97YUbmDiwkkPxGHgPJ3N4kRY2bCSFxPTJSMM6PVf5TDDa9ETM0/G1CvNTJH/34h862NdoXH39A4OKO8SExgrMmBRVEk2KmvAYRA6tWXzCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SXcLagpt; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772490739; x=1804026739;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=w0R5D59fw0/fMLooZV/U0tOSrRlfoHbcQIZawVTLQP4=;
  b=SXcLagptzr3vAiVgoMg4Cm/YJ1bxWPdKPCnNpRG6bd7sjSalqUSmzUSN
   WIsWonIJ8zzcIkNNepHZRGtoafILcDDMGqN7wxtc+JYxFckmOWpfU524X
   qPLi2Gk5L0pD/wFlPA7IJRDZUA2mSlPV0tW4L/LKC3gsrjkPCGjpVuz3Q
   8ieE6WxQwoICw/xP4nyYhcDocz0liedykAOhY/2FyGE2T7qun48eS0Z+X
   iyD6zciZDEafnaSwiP4Y9N6VMXPNrpnH2LaZ/kd6gEZ/Xl+70DNde3w++
   u+144YhbhIGv4xxm7T6PZlGlLPKVHQJQ9IVxnSsb3U9As99meVG9tEOMb
   g==;
X-CSE-ConnectionGUID: WRfy64d1QmOShhbYgaM0wA==
X-CSE-MsgGUID: YbUMa7xqSUSptaeQ8QrJrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73554502"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="73554502"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 14:32:18 -0800
X-CSE-ConnectionGUID: onJHx5fsQYOv274+VXLo+w==
X-CSE-MsgGUID: Is5S46t8TSmdDP1nnj6wcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="217793510"
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
Subject: [PATCH 2/6] platform/x86/intel/pmc: Enable Pkgc blocking residency counter
Date: Mon,  2 Mar 2026 14:32:04 -0800
Message-ID: <20260302223214.484585-3-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260302223214.484585-1-xi.pardee@linux.intel.com>
References: <20260302223214.484585-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 598491E6298
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FREEMAIL_TO(0.00)[linux.intel.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-43452-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xi.pardee@linux.intel.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.intel.com:mid]
X-Rspamd-Action: no action

Enable the Package C-state blocking counter in the PMT telemetry
region. This counter reports the number of 10 µs intervals during
which a Package C-state 10.2/3 entry was blocked for the specified
reasons.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 27 +++++++++++++++++++++++++++
 drivers/platform/x86/intel/pmc/core.h |  8 ++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index bf95a1f2ba428..e5b48a68cf495 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1093,6 +1093,28 @@ static int pmc_core_pkgc_ltr_blocker_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_pkgc_ltr_blocker);
 
+static int pmc_core_pkgc_blocker_residency_show(struct seq_file *s, void *unused)
+{
+	struct pmc_dev *pmcdev = s->private;
+	const char **pkgc_blocker_counters;
+	u32 counter, offset;
+	unsigned int i;
+	int ret;
+
+	offset = pmcdev->pkgc_blocker_offset;
+	pkgc_blocker_counters = pmcdev->pkgc_blocker_counters;
+	for (i = 0; pkgc_blocker_counters[i]; i++, offset++) {
+		ret = pmt_telem_read32(pmcdev->pc_ep, offset,
+				       &counter, 1);
+		if (ret)
+			return ret;
+		seq_printf(s, "%-30s %-30u\n", pkgc_blocker_counters[i], counter);
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(pmc_core_pkgc_blocker_residency);
+
 static int pmc_core_lpm_latch_mode_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
@@ -1380,6 +1402,8 @@ void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_de
 		pmcdev->pc_ep = ep;
 		pmcdev->pkgc_ltr_blocker_counters = pmc_dev_info->pkgc_ltr_blocker_counters;
 		pmcdev->pkgc_ltr_blocker_offset = pmc_dev_info->pkgc_ltr_blocker_offset;
+		pmcdev->pkgc_blocker_counters = pmc_dev_info->pkgc_blocker_counters;
+		pmcdev->pkgc_blocker_offset = pmc_dev_info->pkgc_blocker_offset;
 	}
 
 release_dev:
@@ -1512,6 +1536,9 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev, struct pmc_dev_info
 		debugfs_create_file("pkgc_ltr_blocker_show", 0444,
 				    pmcdev->dbgfs_dir, pmcdev,
 				    &pmc_core_pkgc_ltr_blocker_fops);
+		debugfs_create_file("pkgc_blocker_residency_show", 0444,
+				    pmcdev->dbgfs_dir, pmcdev,
+				    &pmc_core_pkgc_blocker_residency_fops);
 	}
 
 }
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index a20aab73c1409..829b1dee3f636 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -455,6 +455,8 @@ struct pmc {
  *
  * @pkgc_ltr_blocker_counters: Array of PKGC LTR blocker counters
  * @pkgc_ltr_blocker_offset: Offset to PKGC LTR blockers in telemetry region
+ * @pkgc_blocker_counters: Array of PKGC blocker counters
+ * @pkgc_blocker_offset: Offset to PKGC blocker in telemetry region
  *
  * pmc_dev contains info about power management controller device.
  */
@@ -480,6 +482,8 @@ struct pmc_dev {
 
 	const char **pkgc_ltr_blocker_counters;
 	u32 pkgc_ltr_blocker_offset;
+	const char **pkgc_blocker_counters;
+	u32 pkgc_blocker_offset;
 };
 
 enum pmc_index {
@@ -495,6 +499,7 @@ enum pmc_index {
  * @dmu_guids:		List of Die Management Unit GUID
  * @pc_guid:		GUID for telemetry region to read PKGC blocker info
  * @pkgc_ltr_blocker_offset: Offset to PKGC LTR blockers in telemetry region
+ * @pkgc_blocker_offset:Offset to PKGC blocker in telemetry region
  * @regmap_list:	Pointer to a list of pmc_info structure that could be
  *			available for the platform. When set, this field implies
  *			SSRAM support.
@@ -502,6 +507,7 @@ enum pmc_index {
  *			specific attributes of the primary PMC
  * @sub_req_show:	File operations to show substate requirements
  * @pkgc_ltr_blocker_counters: Array of PKGC LTR blocker counters
+ * @pkgc_blocker_counters: Array of PKGC blocker counters
  * @suspend:		Function to perform platform specific suspend
  * @resume:		Function to perform platform specific resume
  * @init:		Function to perform platform specific init action
@@ -512,10 +518,12 @@ struct pmc_dev_info {
 	u32 *dmu_guids;
 	u32 pc_guid;
 	u32 pkgc_ltr_blocker_offset;
+	u32 pkgc_blocker_offset;
 	struct pmc_info *regmap_list;
 	const struct pmc_reg_map *map;
 	const struct file_operations *sub_req_show;
 	const char **pkgc_ltr_blocker_counters;
+	const char **pkgc_blocker_counters;
 	void (*suspend)(struct pmc_dev *pmcdev);
 	int (*resume)(struct pmc_dev *pmcdev);
 	int (*init)(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
-- 
2.43.0


