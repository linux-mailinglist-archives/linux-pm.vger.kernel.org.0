Return-Path: <linux-pm+bounces-18413-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1579E149F
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 08:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 800BC282CCF
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 07:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5255A1C8FD4;
	Tue,  3 Dec 2024 07:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SMpEtrmN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D541AC42C;
	Tue,  3 Dec 2024 07:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733212284; cv=none; b=c0uC6JMQ3sC0OHCApRXRpFZlLEZcFsAmZ8VB3oFBefbtpGHFCWSvZ9WCdlQ+vmZGa8P2qySg/cJ4WkIwRo4e1PwZa27qnZSLtiFtFQMFqEDi6rbwA8GApcCxptqOUvuzpPd279Lm+jc9ebWEi4/bdSgutcWGq7CmCVQX9v8gCW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733212284; c=relaxed/simple;
	bh=+yIOxg7UD6tb/FP26lMAhHqnhMvbQO7H+dY3oMrMgiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hty2e8Ur2ONYJhbDdvtUsfNxZZXkAMC2oGwJvCcoGunV1I/4q+XX04NoYMWXMMeovZK4aMoamcdVAf3nTXVdpsBACL1ak7eS2bidGAAkbhEcyGO6mwp+XOBXxaPTErUYY79j7hvW+ELKT5RISa7tta4/SSjkVEa1Xi+HA6cRP0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SMpEtrmN; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733212282; x=1764748282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+yIOxg7UD6tb/FP26lMAhHqnhMvbQO7H+dY3oMrMgiY=;
  b=SMpEtrmN9EZaZ41iAo9ZbSnRibP+B27toKRLkhN5bG0XRX98NkXT/oh7
   S/F7kU3YlVWM5liE56/G1I6AfQAWVCtoU8l+72vpwNscK9hVvqQCVlMlx
   sWhnPROEomY5vTl+uabm8BxABOe6GN5g92t6lvpa0Rx5UZgPUckmOHgBu
   NeYTdQBubd1aYQ3pgB7uOO1SMRFT9/0Et6/IhRyuq58TVAigYX0dqChYl
   /rr2m4fv8JHeyoEdGnP9G+dUpovtQ1jTsBO1cA3HmSKc0M9oC4UMN2x8l
   hC3ph27JPfP+kjxswNeNWl2Qfbg9UoTdPJobGSHakIvCLN3knhh37w26k
   g==;
X-CSE-ConnectionGUID: 0V6kPoWeT7KOFUH/7FPPwA==
X-CSE-MsgGUID: X+2aNNYJTk21gs0WCS2V0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="50822851"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="50822851"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 23:51:20 -0800
X-CSE-ConnectionGUID: hMtNNo0mRYu9GArDgl+pyw==
X-CSE-MsgGUID: xcvWm42BRTWzXz+z6dpUQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="124183026"
Received: from rzhang1-mobl.sh.intel.com ([10.239.158.59])
  by orviesa002.jf.intel.com with ESMTP; 02 Dec 2024 23:51:20 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 2/4] tools/power turbostat: Exit on unsupported Vendors
Date: Tue,  3 Dec 2024 15:51:17 +0800
Message-ID: <20241203075119.584419-3-rui.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203075119.584419-1-rui.zhang@intel.com>
References: <20241203075119.584419-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Turbostat currently supports x86 processors from Intel, AMD, and Hygon.
The behavior of turbostat on CPUs from other vendors has not been
evaluated and may lead to incorrect or undefined behavior.

Enhance turbostat to exit by default when running on an unsupported CPU
vendor. This ensures that users are aware that their CPU is not
currently supported by turbostat, guiding them to seek support for their
specific hardware through future patches.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index bb65c5e1273c..508d65e60981 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1056,9 +1056,9 @@ void probe_platform_features(unsigned int family, unsigned int model)
 {
 	int i;
 
-	platform = &default_features;
 
 	if (authentic_amd || hygon_genuine) {
+		platform = &default_features;
 		if (max_extended_level >= 0x80000007) {
 			unsigned int eax, ebx, ecx, edx;
 
@@ -1071,7 +1071,7 @@ void probe_platform_features(unsigned int family, unsigned int model)
 	}
 
 	if (!genuine_intel)
-		return;
+		goto end;
 
 	for (i = 0; turbostat_pdata[i].features; i++) {
 		if (VFM_FAMILY(turbostat_pdata[i].vfm) == family && VFM_MODEL(turbostat_pdata[i].vfm) == model) {
@@ -1080,6 +1080,10 @@ void probe_platform_features(unsigned int family, unsigned int model)
 		}
 	}
 
+end:
+	if (platform)
+		return;
+
 	fprintf(stderr, "Unsupported platform detected.\n"
 		"\tTo get latest turbostat support, please contact\n"
 		"\t   lenb@kernel.org\n"
-- 
2.43.0


