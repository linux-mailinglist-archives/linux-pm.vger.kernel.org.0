Return-Path: <linux-pm+bounces-39287-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 100A1CABF27
	for <lists+linux-pm@lfdr.de>; Mon, 08 Dec 2025 04:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2401300EA1B
	for <lists+linux-pm@lfdr.de>; Mon,  8 Dec 2025 03:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C619223DD4;
	Mon,  8 Dec 2025 03:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mcmzy43K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8151E1DE4FB
	for <linux-pm@vger.kernel.org>; Mon,  8 Dec 2025 03:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765163437; cv=none; b=bNQdGXH/6yhRMwrTXJb19GTasf69oESWJuhGCFZz3SCD+xdkqVLcfanuUGLEDGCgDWtmBHM80pQj45Qg/ypRMei7oYf6KtMM/CHCvEJ6e8JXqv+oMJCh0jtg7wmcn9AbKuHtP+qTpOccPZsmCvlHAN6C9dO3mHh7vFWNxcEbaY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765163437; c=relaxed/simple;
	bh=W+S3YtR+W+tAm/zcL7dBZxggEKiSDxqjciRRJ4SNlhE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gc2k8KuVxy/zkO6N6qWML77O85bS7sdF0HZLTy1Scs6Ao3LETwukMJnm20EZrUaDqPJxtETYeJHgnACNUuHvUoo5HeviFsj9SMjIu1AN1rRmt8RiZHEH3NTvFCS03KbWafoTRF6YmyCgpqIBdEk9Kz+wC2fuRqKA7R8Qhy7zgaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mcmzy43K; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765163436; x=1796699436;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W+S3YtR+W+tAm/zcL7dBZxggEKiSDxqjciRRJ4SNlhE=;
  b=Mcmzy43KZmx0AwYI++sfcO17mOisAyaxbV03vMZQ4+l+WqMNP+3uVTSW
   1MweMRzffvxCuNEa4pIxsV2YN2wSjNFQwnY86x1kch7e4BPlgdVCaBTHc
   AaGDbWJZPb+ivT9lcrMgcNEMyin0p8aYrheUAN4monjTnVmbVjMtckTVU
   71PGMYx1rVt3txS7PhgZXXjepgsryM2NeVlZ+AJI0oO/F0BbyyYOSinpJ
   sWBpOe7X5jYIDnv/DqRcU4rQdG1D81E6zo2IblvJYGcSYY4IxqPOSI/t7
   LQtkX7WWT64gIaF1H2yrG3ibE5D/jxvy6SHSlXxaDNaR1rkGr1+9EQsHP
   Q==;
X-CSE-ConnectionGUID: df0xhTJETkitJ71Ot1bHyQ==
X-CSE-MsgGUID: aruZHI4CTmSUZMS/kqNGeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="66992655"
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="66992655"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 19:10:36 -0800
X-CSE-ConnectionGUID: VVkyXIU5SW2prXBsEx2c4A==
X-CSE-MsgGUID: RqP10kznR4yHra6NK+u2eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="195449043"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa007.fm.intel.com with ESMTP; 07 Dec 2025 19:10:34 -0800
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: lenb@kernel.org
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH v2] tools/power turbostat: Use strtoul() for iteration parsing
Date: Mon,  8 Dec 2025 08:38:04 +0530
Message-Id: <20251208030804.2266670-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace strtod() with strtoul() and check errno for -n/-N options, since
num_iterations and header_iterations are unsigned long counters. Reject
zero and conversion errors; negative inputs wrap to large positive values
per standard unsigned semantics.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
v2: Use strtoul() + errno instead of strtod() with signed validation
per review feedback

 tools/power/x86/turbostat/turbostat.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index da51d430c8af..822637911978 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -11160,18 +11160,20 @@ void cmdline(int argc, char **argv)
 			/* Parsed earlier */
 			break;
 		case 'n':
-			num_iterations = strtod(optarg, NULL);
+			num_iterations = strtoul(optarg, NULL, 0);
+			errno = 0;
 
-			if (num_iterations <= 0) {
-				fprintf(outf, "iterations %d should be positive number\n", num_iterations);
+			if (errno || num_iterations == 0) {
+				fprintf(outf, "invalid iteration count: %s\n", optarg);
 				exit(2);
 			}
 			break;
 		case 'N':
-			header_iterations = strtod(optarg, NULL);
+			header_iterations = strtoul(optarg, NULL, 0);
+			errno = 0;
 
-			if (header_iterations <= 0) {
-				fprintf(outf, "iterations %d should be positive number\n", header_iterations);
+			if (errno || header_iterations == 0) {
+				fprintf(outf, "invalid header iteration count: %s\n", optarg);
 				exit(2);
 			}
 			break;
-- 
2.34.1


