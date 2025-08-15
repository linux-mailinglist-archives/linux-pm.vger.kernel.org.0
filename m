Return-Path: <linux-pm+bounces-32458-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C16B28888
	for <lists+linux-pm@lfdr.de>; Sat, 16 Aug 2025 00:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0D971D0392F
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 22:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3BC27144B;
	Fri, 15 Aug 2025 22:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QPb56MwM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DDD2405FD;
	Fri, 15 Aug 2025 22:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755297979; cv=none; b=dBdNYUiN3kuf+iWU5YtWOW9IT7HbtfUuCn763E7TcTZmlNIskScEWVbbN+KmxZrlmIXColER6umvE13u/Rasw03MmxDLZFwvndz4qHHY9n0WND3NjP+/r5FWTwNvrt3xN5veLJlWSfXtgV/9Fa2IngG7hOlV/PgW01YjLe8hy0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755297979; c=relaxed/simple;
	bh=powQdZtRV1wI6Xf73edribso9Z6LvnZixCxT06oB804=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SrISnGnypwl1o12q9H81NbuvplA4Ku3qfolTrPADZ3gcf2QEg9F/RS0xKFLaMTHXCw6xjOR+gFZOB/dBpNeBDabwwboHp/HMu9JrJTPb0Zeg56pvGbDELeH63NmxC7+rpOZ7TQ3B9puIUIdDD2MxHQj+orpykn5n0qbqOeJfXT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QPb56MwM; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755297978; x=1786833978;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=powQdZtRV1wI6Xf73edribso9Z6LvnZixCxT06oB804=;
  b=QPb56MwM44Oe/dUnU+h8lH9xpzUCydMAgIejAvC1YbMlHZOxN1nndkpe
   5lBsmjJEU1czgTe1pk8+mxdv98v5Fl7c+SoSw8kG+/9R/jA3i2ntMhMQs
   AOOSWcTGLYGCdBSYtA6eGHplYBh91fAOeg4d9wpOHu1iW9NaTU7lvxcsI
   0H0XVJBPe+aXJqT3gy4sTc3q8GFbib1MXQWS+EBZRqcmYALifp+Fyxprm
   GlCNP+jnoYNtBWjDs45wTjULVFGwBt1iluubUmWo0ZnvV8jKlPMUa/fL5
   7iLw/MRrC+z4kD0qiJZRIm9wHjLOAvj1+BS2tOT7buynDlN0NGpEurCTB
   A==;
X-CSE-ConnectionGUID: 80zCV9AHTqy8tio2vg3Wzg==
X-CSE-MsgGUID: vnuC1515TuqojXMUniz/zQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="57724944"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57724944"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 15:46:16 -0700
X-CSE-ConnectionGUID: 3a1FmGBUR8S8hWxIKcVpsA==
X-CSE-MsgGUID: 2G9ZV59xQCSEUtZIJFmjdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166734411"
Received: from jdoman-mobl3.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.124.223.173])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 15:46:16 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 3/6] platform/x86:intel/pmc: Improve function to show substate header
Date: Fri, 15 Aug 2025 15:46:01 -0700
Message-ID: <20250815224611.2460255-4-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250815224611.2460255-1-xi.pardee@linux.intel.com>
References: <20250815224611.2460255-1-xi.pardee@linux.intel.com>
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
 drivers/platform/x86/intel/pmc/core.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index a1dd80bdbd413..cbfdcdc50ad21 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -11,6 +11,11 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+enum header_type {
+	HEADER_STATUS,
+	HEADER_VALUE
+};
+
 #include <linux/bitfield.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
@@ -828,17 +833,22 @@ static int pmc_core_substate_l_sts_regs_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_l_sts_regs);
 
-static void pmc_core_substate_req_header_show(struct seq_file *s, int pmc_index)
+static void pmc_core_substate_req_header_show(struct seq_file *s, int pmc_index,
+					      enum header_type type)
 {
 	struct pmc_dev *pmcdev = s->private;
 	int mode;
 
-	seq_printf(s, "%30s |", "Element");
+	seq_printf(s, "%40s |", "Element");
 	pmc_for_each_mode(mode, pmcdev)
 		seq_printf(s, " %9s |", pmc_lpm_modes[mode]);
 
-	seq_printf(s, " %9s |", "Status");
-	seq_printf(s, " %11s |\n", "Live Status");
+	if (type == HEADER_STATUS) {
+		seq_printf(s, " %9s |", "Status");
+		seq_printf(s, " %11s |\n", "Live Status");
+	} else {
+		seq_printf(s, " %9s |\n", "Value");
+	}
 }
 
 static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
@@ -872,7 +882,7 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
 			continue;
 
 		/* Display the header */
-		pmc_core_substate_req_header_show(s, pmc_index);
+		pmc_core_substate_req_header_show(s, pmc_index, HEADER_STATUS);
 
 		/* Loop over maps */
 		for (mp = 0; mp < num_maps; mp++) {
@@ -910,7 +920,7 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
 				}
 
 				/* Display the element name in the first column */
-				seq_printf(s, "pmc%d: %26s |", pmc_index, map[i].name);
+				seq_printf(s, "pmc%d: %34s |", pmc_index, map[i].name);
 
 				/* Loop over the enabled states and display if required */
 				pmc_for_each_mode(mode, pmcdev) {
-- 
2.43.0


