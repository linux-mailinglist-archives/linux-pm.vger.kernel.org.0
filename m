Return-Path: <linux-pm+bounces-32245-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6722DB24222
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 09:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7832D1B67BA0
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 07:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AB82D0615;
	Wed, 13 Aug 2025 07:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QElXm4aS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9552D660C
	for <linux-pm@vger.kernel.org>; Wed, 13 Aug 2025 07:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755068613; cv=none; b=BF4v+YtCcSHHK3GtEIogPc25dPglvjrG37J3K4J8YjN46qUnB+R1cCJKEBokhhUw/WEcVaRrgZx3M0b5DVM088C3hvbj2pgcyMPijgK7RiZlRx8QSD9STkCqaNxB8pAtf/igxdn49KUSbzme0lccX+cPUBcMF1irvgHfRhbsh/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755068613; c=relaxed/simple;
	bh=LX27+Fm4521I9vVBjV9RGAKpbdoAQTN7inSr0qWhQSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UQMvDjA3CCAPBxHE7PQt65ajexgyaLhejswZS6CbRmlBG6baAd8FXWuapICIHLLRekHuhGr1314NtATXy08dEp9rct0+96hkV4rpO6EJLeQx0eeCuiCW046jEjgWGzfiRi3Wi5vEbJRmRy+NGnibO1ki8cqXAbuJPbxfcpuVUlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QElXm4aS; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755068612; x=1786604612;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LX27+Fm4521I9vVBjV9RGAKpbdoAQTN7inSr0qWhQSQ=;
  b=QElXm4aScy1J7TxebqICNuYNPepiAV4FSrhWRXrDisNLZZBlHIx+vsx+
   VX3uk/VxaZrHRybRXEAxixf9308UL0M7Y6O9psAoNgFao11KuubDrRv1n
   1EDzkDoy//kRh90lZMPhox0DOl4uXxBKBuIpqoOdY89VJhN2WwEFMUdM9
   ZFANJRD3Ch4adCtAX0OOropdlNL40ZFQPERgPXr2/6d23zDJE9DUzL9Uv
   y5XKFAzwTY3gdCHD+FnATwB7hpf2Kp64i04RSAX7cs1Sbwza0L7t4sM36
   CCwetfpDgYYNQf1w1mjso3dLlROmJpAdagj7RwsZ1zV7TsBwCcZGSLrlv
   Q==;
X-CSE-ConnectionGUID: ZQr+bWxBSnKaDIyuQyazcQ==
X-CSE-MsgGUID: Oxf/kqG1R5iuKIFNdu4VjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="60974874"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="60974874"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 00:03:31 -0700
X-CSE-ConnectionGUID: Ru7lOTi3Q0uocprUplKfkQ==
X-CSE-MsgGUID: hcgY1qAWRBa+tXEDghkjDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="166388749"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa007.jf.intel.com with ESMTP; 13 Aug 2025 00:03:30 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: lenb@kernel.org
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] tools/power x86_energy_perf_policy: Fix incorrect fopen mode usage
Date: Wed, 13 Aug 2025 12:32:08 +0530
Message-Id: <20250813070208.78862-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fopen_or_die() function was previously hardcoded
to open files in read-only mode ("r"), ignoring the
mode parameter passed to it. This patch corrects
fopen_or_die() to use the provided mode argument,
allowing for flexible file access as intended.

Additionally, the call to fopen_or_die() in
err_on_hypervisor() incorrectly used the mode
"ro", which is not a valid fopen mode. This is
fixed to use the correct "r" mode.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 .../power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index ebda9c366b2b..c883f211dbcc 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -630,7 +630,7 @@ void cmdline(int argc, char **argv)
  */
 FILE *fopen_or_die(const char *path, const char *mode)
 {
-	FILE *filep = fopen(path, "r");
+	FILE *filep = fopen(path, mode);
 
 	if (!filep)
 		err(1, "%s: open failed", path);
@@ -644,7 +644,7 @@ void err_on_hypervisor(void)
 	char *buffer;
 
 	/* On VMs /proc/cpuinfo contains a "flags" entry for hypervisor */
-	cpuinfo = fopen_or_die("/proc/cpuinfo", "ro");
+	cpuinfo = fopen_or_die("/proc/cpuinfo", "r");
 
 	buffer = malloc(4096);
 	if (!buffer) {
-- 
2.34.1


