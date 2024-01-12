Return-Path: <linux-pm+bounces-2160-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B86B82BFF9
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jan 2024 13:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 871211C2378E
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jan 2024 12:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB3A6BB26;
	Fri, 12 Jan 2024 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dHMnwwz+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D101D5D744
	for <linux-pm@vger.kernel.org>; Fri, 12 Jan 2024 12:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705063755; x=1736599755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wj0CM3usT3ek7DpFNjUL7rrOmPw50xgkZ0/iKC3yqGo=;
  b=dHMnwwz+ilVC9fdGrw0brOmYoVnl7+2fOVCxrf10e1xRbxn0lJW3FF8k
   Y26o9T262EmMsoRAY3xpZrEwKOorLTcPwZex48lhvKwssxBiWMFRxbHPZ
   0ByraXh5z7niTj8DF4ki31KZqKp9SDoW4pZ4zbTOuyWIOQvJe116Q+w84
   OpG9xIOZzUhPoRpZj4nCTGirwlGj3yKkwujDyayq8aTIfOnc2xMBUFJYj
   JSz4qGerLlohqm3Ws9TIQpGkhalJKcSkyc/FlUM0MnhJhfcT6bBVeb8+x
   HwGbN2QT1sETNZaXnt30qqW6yQ/5WLaH3evcYfvMixXUfXpGSg5Yf5yaz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="6525663"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="6525663"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 04:49:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="17390868"
Received: from pwlazlyn-mobl.ger.corp.intel.com (HELO pwlazlyn) ([10.246.16.73])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 04:49:12 -0800
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
To: len.brown@intel.com
Cc: linux-pm@vger.kernel.org
Subject: [PATCH 3/4] tools/power turbostat: Don't print invalid ucode revision
Date: Fri, 12 Jan 2024 13:48:14 +0100
Message-Id: <20240112124815.970-4-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240112124815.970-1-patryk.wlazlyn@linux.intel.com>
References: <20240112124815.970-1-patryk.wlazlyn@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Earlier we printed "microcode 0x0" if we failed to obtain it via MSR.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index ba10a10c5144..bf733e7d73b5 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5710,6 +5710,7 @@ void process_cpuid()
 	unsigned int eax, ebx, ecx, edx;
 	unsigned int fms, family, model, stepping, ecx_flags, edx_flags;
 	unsigned long long ucode_patch = 0;
+	bool ucode_patch_valid = false;
 
 	eax = ebx = ecx = edx = 0;
 
@@ -5740,6 +5741,8 @@ void process_cpuid()
 	if (!no_msr) {
 		if (get_msr(sched_getcpu(), MSR_IA32_UCODE_REV, &ucode_patch))
 			warnx("get_msr(UCODE)");
+		else
+			ucode_patch_valid = true;
 	}
 
 	/*
@@ -5751,9 +5754,12 @@ void process_cpuid()
 	__cpuid(0x80000000, max_extended_level, ebx, ecx, edx);
 
 	if (!quiet) {
-		fprintf(outf, "CPUID(1): family:model:stepping 0x%x:%x:%x (%d:%d:%d) microcode 0x%x\n",
-			family, model, stepping, family, model, stepping,
-			(unsigned int)((ucode_patch >> 32) & 0xFFFFFFFF));
+		fprintf(outf, "CPUID(1): family:model:stepping 0x%x:%x:%x (%d:%d:%d)",
+			family, model, stepping, family, model, stepping);
+		if (ucode_patch_valid)
+			fprintf(outf, " microcode 0x%x", (unsigned int)((ucode_patch >> 32) & 0xFFFFFFFF));
+		fputc('\n', outf);
+
 		fprintf(outf, "CPUID(0x80000000): max_extended_levels: 0x%x\n", max_extended_level);
 		fprintf(outf, "CPUID(1): %s %s %s %s %s %s %s %s %s %s\n",
 			ecx_flags & (1 << 0) ? "SSE3" : "-",
-- 
2.43.0


