Return-Path: <linux-pm+bounces-29204-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C81AE2C7D
	for <lists+linux-pm@lfdr.de>; Sat, 21 Jun 2025 23:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 331E47AABF4
	for <lists+linux-pm@lfdr.de>; Sat, 21 Jun 2025 21:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652B8272E67;
	Sat, 21 Jun 2025 21:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U8MC4hAX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35DE271A9D;
	Sat, 21 Jun 2025 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750539941; cv=none; b=Jg/5jyaEWBJUYoRXYmwUwvUONCA8JNgsj7BnQGdXI7CIQ9kdBNMAaeAxCmD34Nfn5PN85o3bQIn5d7+kGml3gwrN+cjFlo29S+QS/oCEaoHvK0QOcIT30lofLrceGcaajqSjSIhaFbR5vRDwUNwJB4zp0xHg2/khAKF/6MLPImI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750539941; c=relaxed/simple;
	bh=CDe/iMsRALBkORDbKS3tYGiYIGj+1h732grU6OFaPI8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1ImrvrGZgZBdS1rxGpb9V12EQdq1Nk2ahWO3L8aCgGPUB7BpUcNk4QFnjsBdcBI3BgjHsLilXFaYeNesdQz007RwaSKjquVnfjNHKWdPBegBjlG10tVc+GN9wEdqBUvfTTfPvy7w5nM0bu3MmX3gABfqTHtuC0S6C4KV4dGMjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U8MC4hAX; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750539940; x=1782075940;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=CDe/iMsRALBkORDbKS3tYGiYIGj+1h732grU6OFaPI8=;
  b=U8MC4hAXsN1ZPlyend16DD8c5GdIyZUIyPzF4U+h6VDZYwq8ug44QV5I
   P3h1TEiRyG5UVmm/kEUgFu4ibAnJm+lQ38qZd7G95HinV/QoCfcDHx1aK
   KZ3XBHgz0yJHlrd1FfmtLnhnLXlVTdE9F4fBfpBFfIzunryL+jNZNE21S
   ixsRNuiyNzT52d8KehP36pffLMbIRg+rzHVWFEkps55tKzqLU+RFssjjH
   x/J/zjnFs+3I+AhYlGcLSM1Mjg96o7JQTGgf23yZ9+rq6FCLWjolcqTto
   yiGsQBep6lWQHyyRpHageugiiqMjishYM9835xJfgjuX+83rrF6gpB8P8
   A==;
X-CSE-ConnectionGUID: jvD1iIr6RxKugaUcudOcMg==
X-CSE-MsgGUID: 1ugwhpxgSUqwH+eWHNLcjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11470"; a="63826256"
X-IronPort-AV: E=Sophos;i="6.16,254,1744095600"; 
   d="scan'208";a="63826256"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2025 14:05:40 -0700
X-CSE-ConnectionGUID: C3/LBdpEQ3CQShF7K53bJQ==
X-CSE-MsgGUID: 2JygPBjDS8q1+3IYj6ox9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,254,1744095600"; 
   d="scan'208";a="155775326"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.124.222.74])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2025 14:05:37 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v1 3/5] platform/x86:intel/pmc: Improve function to show substate header
Date: Sat, 21 Jun 2025 14:05:23 -0700
Message-ID: <20250621210529.237964-4-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621210529.237964-1-xi.pardee@linux.intel.com>
References: <20250621210529.237964-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor pmc_core_substate_req_header_show() to accept a new argument.
This is a preparation patch to introduce a new way to show Low Power
Mode substate requirement data for platforms starting from Panther
Lake. Increased the size for the name column as the Low Power Mode
requirement register name is longer in newer platforms.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index a1dd80bdbd413..47cc5120e7dd6 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -828,17 +828,20 @@ static int pmc_core_substate_l_sts_regs_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_l_sts_regs);
 
-static void pmc_core_substate_req_header_show(struct seq_file *s, int pmc_index)
+static void pmc_core_substate_req_header_show(struct seq_file *s, int pmc_index, char *name)
 {
 	struct pmc_dev *pmcdev = s->private;
 	int mode;
 
-	seq_printf(s, "%30s |", "Element");
+	seq_printf(s, "%40s |", "Element");
 	pmc_for_each_mode(mode, pmcdev)
 		seq_printf(s, " %9s |", pmc_lpm_modes[mode]);
 
-	seq_printf(s, " %9s |", "Status");
-	seq_printf(s, " %11s |\n", "Live Status");
+	if (!strcmp(name, "Status")) {
+		seq_printf(s, " %9s |", name);
+		seq_printf(s, " %11s |\n", "Live Status");
+	} else
+		seq_printf(s, " %9s |\n", name);
 }
 
 static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
@@ -872,7 +875,7 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
 			continue;
 
 		/* Display the header */
-		pmc_core_substate_req_header_show(s, pmc_index);
+		pmc_core_substate_req_header_show(s, pmc_index, "Status");
 
 		/* Loop over maps */
 		for (mp = 0; mp < num_maps; mp++) {
@@ -910,7 +913,7 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
 				}
 
 				/* Display the element name in the first column */
-				seq_printf(s, "pmc%d: %26s |", pmc_index, map[i].name);
+				seq_printf(s, "pmc%d: %34s |", pmc_index, map[i].name);
 
 				/* Loop over the enabled states and display if required */
 				pmc_for_each_mode(mode, pmcdev) {
-- 
2.43.0


