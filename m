Return-Path: <linux-pm+bounces-38945-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2A7C95A3B
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 04:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF2503A1CCE
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 03:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583F2184524;
	Mon,  1 Dec 2025 03:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BuM3NxFs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A16163CF
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 03:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764559238; cv=none; b=Pb4qd/CLy4pQuRLJ6Mgl3a9d0hHmzt1fdAYY40lYP0F6V0dNyyMnDOu+hQLuabEywovZJoi21WswjQnUxa56hz1vwTM4Nl87mc+BQyxhZTOBiVZIfFIIyzkKPx5e3Awd5sCL9Ko+tsI0BuhYf5desUVPAAMugyCF4ME/8KXrSdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764559238; c=relaxed/simple;
	bh=3USdm9gqufyPNtDfmx9xSpvQM4a1eZVomSbRFc7hAb0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JQw/O2FyXlcJRNqpRxGjtxltVDGK02nuEknKjqKWGGOmR+I6ZErpFYMmyu5cmr5tP0SYufgnIrvyY6g2KULpkXJ8iZbTOSa8BRV7Pw+Y72xLWUKeJPlT9jnk7k6lD+Esx/0XLslpz23d+k8vOP/P9wyWqrtyPOzVK2SXhyBHw9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BuM3NxFs; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764559236; x=1796095236;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3USdm9gqufyPNtDfmx9xSpvQM4a1eZVomSbRFc7hAb0=;
  b=BuM3NxFsNVsoc0RudYqjdSWBZUy/Y7Hay9U+coy+Dt1cky/yQVYmksD7
   yLmy6tkA8UqtHLuO0N3gvzo7gCB9sxqPXoA77vphbPGpV2bqvReew5aKR
   D3ZekGcQr4acshYr+6f46GbZzu6x3btqLtG4UsNl0w+AVYaYXrY6r966C
   1I42iRZbI65DcHGHDuvFc+5P59QN1Q99Z9thPj+bu4ahyYLcx544ZdBze
   G7Sg2rMXSs/BGUn77hF1mB+iV+C31nTtsGpXLSZomcPMpTqtQomp2xyai
   Dp5wBcw69i2mJq4SBZKaj1ghhDEtDlp25l8TgT9RwZP5KfO+i9FyAnjyN
   w==;
X-CSE-ConnectionGUID: WaYWpxdjTceO/w/tUoUbeQ==
X-CSE-MsgGUID: UOmr4NpjRcOXGWDKVu8hjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="66441526"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; 
   d="scan'208";a="66441526"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2025 19:20:36 -0800
X-CSE-ConnectionGUID: VbQ7g10mSU+p4Q1ob7r0MA==
X-CSE-MsgGUID: BnKN1v+0QAuXZtbfyQv1Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; 
   d="scan'208";a="198894667"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa004.fm.intel.com with ESMTP; 30 Nov 2025 19:20:34 -0800
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: lenb@kernel.org
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] tools/power turbostat: Refine iteration parsing
Date: Mon,  1 Dec 2025 08:48:11 +0530
Message-Id: <20251201031811.1362803-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Validate the `-n/-N` arguments as signed ints before casting to
unsigned,so the user sees the correct value in error paths and
negative input is rejected cleanly.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index f2512d78bcbd..807b2d7f1809 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -11123,20 +11123,22 @@ void cmdline(int argc, char **argv)
 			/* Parsed earlier */
 			break;
 		case 'n':
-			num_iterations = strtod(optarg, NULL);
+			int iterations = strtod(optarg, NULL);
 
-			if (num_iterations <= 0) {
-				fprintf(outf, "iterations %d should be positive number\n", num_iterations);
+			if (iterations <= 0) {
+				fprintf(outf, "iterations %d should be positive number\n", iterations);
 				exit(2);
 			}
+			num_iterations = (unsigned int)iterations;
 			break;
 		case 'N':
-			header_iterations = strtod(optarg, NULL);
+			int h_iterations = strtod(optarg, NULL);
 
-			if (header_iterations <= 0) {
-				fprintf(outf, "iterations %d should be positive number\n", header_iterations);
+			if (h_iterations <= 0) {
+				fprintf(outf, "iterations %d should be positive number\n", h_iterations);
 				exit(2);
 			}
+			header_iterations = (unsigned int)h_iterations;
 			break;
 		case 's':
 			/*
-- 
2.34.1


