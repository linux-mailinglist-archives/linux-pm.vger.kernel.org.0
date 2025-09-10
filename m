Return-Path: <linux-pm+bounces-34420-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E9FB52339
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 23:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160371BC17B9
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 21:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB2D307AEA;
	Wed, 10 Sep 2025 21:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KC0YSGjv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645352FF153;
	Wed, 10 Sep 2025 21:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757538398; cv=none; b=nYNojE1b3M9JopIsPmOybUFoH1icOt+hnX3FsE6NeYU59xegLz8dzyxdfN5Rhya12r7kWuCt6LxcG/nvotNbpJkWNDNiO8HhImUEs943ZTXDPpNbzBkEah6uFNL9pO+4s8C+xOE9UuoFP8FyHrYW5b8h11YV1YypD21x2bjuMFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757538398; c=relaxed/simple;
	bh=0z/Nbj1kE8mbPlXF92Y9+gDFjDvitcs7BqLjo1TY3gM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qFrhB0qCR852Qzq1/eaoywUITF9A9SOzsYUsE4478TEG2SdGbFxg00huN1fCC8u0x3CKx6kFuWhVGmJcaxCS/gWjZghLJTOKh6toA00/mdIRbD+oc7XfOE2uy8WttVP6qtQ4frmJpdjXOlMMUpbVMRIgtOyF8QJqTF/EXMsCzB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KC0YSGjv; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757538396; x=1789074396;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=0z/Nbj1kE8mbPlXF92Y9+gDFjDvitcs7BqLjo1TY3gM=;
  b=KC0YSGjvWCTRZJaoaiefLZ5kzPLVQ0widRVztIXQy24l2Oix8uneJ+C8
   pwV6538DEvI8ZQnMriN2fBTz8nVNyw3gbrAnksfSqZAc5mmzNroB99KPI
   hSFxFUbkVfmAwXFrrQ8t0YiZdTpcBPwIJxYBlHSErgxY9j98EdMx2eUYo
   8/24CS9zNuh5oqiVtT4pCB5jXT5MpGq4xW2j+163PneufM29w7kBAQ+mv
   vBS4eCRnp1xhiB14EQT9lCLSkIs+bBAxCRHMaK5irqJZYmSrFqcPPPoJ/
   MeJYSZLhTpYzhdvKyD4a3VWsv2i4lzDyKAp9VtMGF423hbbQqsMdUyjSW
   Q==;
X-CSE-ConnectionGUID: yC3X/zvzTlOlxjwZzssUDQ==
X-CSE-MsgGUID: kMu6Wfe4Sfq4f6D/O1HaXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="82448484"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="82448484"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 14:06:35 -0700
X-CSE-ConnectionGUID: wuSpmqVoR1qZy/Zz4bBylA==
X-CSE-MsgGUID: nphju6HWSs6xpjzAyLQIbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,255,1751266800"; 
   d="scan'208";a="177842753"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.125.110.232])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 14:06:35 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v4 3/5] platform/x86:intel/pmc: Improve function to show substate header
Date: Wed, 10 Sep 2025 14:06:23 -0700
Message-ID: <20250910210629.11198-4-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910210629.11198-1-xi.pardee@linux.intel.com>
References: <20250910210629.11198-1-xi.pardee@linux.intel.com>
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
index a1ab0e31eca7b..b3e9ea31db9c6 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -11,6 +11,11 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+enum header_type {
+	HEADER_STATUS,
+	HEADER_VALUE,
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


