Return-Path: <linux-pm+bounces-29461-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 034A3AE770D
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 08:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 532545A4990
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 06:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B661F91F6;
	Wed, 25 Jun 2025 06:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OC2rc6On"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E381EB5DA;
	Wed, 25 Jun 2025 06:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750833113; cv=none; b=ZejCijPDAV74ZazLR/2iudCIWszZPhUev+2Gcuxv7kxiXdJRQ+YKeAacWDGr2iFSBj+YNXnwCnpOMA0nXiWWsmOVK653/lwmNoRpR9IyPpmdSkcxjdeMcibQw9KZ9pQufyuBAqYsOobg3p/uDKkBw5CkrmIiNAonInOP4oiQzWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750833113; c=relaxed/simple;
	bh=CDe/iMsRALBkORDbKS3tYGiYIGj+1h732grU6OFaPI8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R10WgS/D/nT7h/Gm+OgmFEJ7I2vKJw1uPr0hWcyDvuZL6on5T5SqW9s/pI7Kqkg21tsBXj6md3b2z3x4STcktqo2iHFH6wAmgyurZmqtUiGQUWVtkSdhub1vFSBfClaXQ+WzEgs4muM49VKxCb/QGZvti0Qb5815M2ibw5jbTK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OC2rc6On; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750833112; x=1782369112;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=CDe/iMsRALBkORDbKS3tYGiYIGj+1h732grU6OFaPI8=;
  b=OC2rc6OnM91/OQPXfGz8nC6pJ+F/5PU4QZDepswzSUtzZwfPI0VD1Kd9
   wjh+WpKtnLQGjzF5hMnzkSqGG3u+IjKjPZeW5DXVI+C3hsUI4fc24/sD7
   uf0t9GF/sf3g/9yJqpog+nQ+5QOhE0g5KnlKy6SMAHDElWBkQ61bJ9zww
   LWJ4A4ZpFDbpiw3RaGowPqTUVObnp2Bhxr3j1QbYlIoS/28WCHGxX6x0e
   +niMXOdmTDBUWTih3jNHzZZSkwXfH6aKVAleIBAmzYBTyvr135Z5dorLA
   f/JyGHfb3qqobZ5zR5zLCXri3DrfVwhNFmYpDEgpMBvLeVP0wwFg0GkH3
   w==;
X-CSE-ConnectionGUID: 6ehMkWe8QeOPnt3xToX0Qw==
X-CSE-MsgGUID: 8oq0U9aAQoaya84HKS/jCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="53187465"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="53187465"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 23:31:50 -0700
X-CSE-ConnectionGUID: 0txCQb95QwCJe/yJO2vm6Q==
X-CSE-MsgGUID: drbRQfVyTxem56/k96dxEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="152257578"
Received: from daliomra-mobl3.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.124.223.140])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 23:31:49 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 3/5] platform/x86:intel/pmc: Improve function to show substate header
Date: Tue, 24 Jun 2025 23:31:40 -0700
Message-ID: <20250625063145.624585-4-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625063145.624585-1-xi.pardee@linux.intel.com>
References: <20250625063145.624585-1-xi.pardee@linux.intel.com>
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


