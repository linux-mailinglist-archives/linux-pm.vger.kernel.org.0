Return-Path: <linux-pm+bounces-39123-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5570BC9D0D4
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 22:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE203A3547
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 21:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893A92FC00D;
	Tue,  2 Dec 2025 21:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPmX0lZP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625252F7AD3
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 21:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764710331; cv=none; b=jxEKvIzIakb/2XfLPYgBgRcUGt2b8ydSLAQfOVAdwpOwsEP6PtWJH+ThLe5GNzgeQAc42yaOhGlL5m9U5Uh5V+JfrKfuV8rXsZRO8oo1k7rWu6C1sYj0YLPZ4jc0FUh5BR2mCZ911S9oo0x5s4z6wqHAFjklJBifcnUEKgBNN70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764710331; c=relaxed/simple;
	bh=/4LkTLBb7fVbr9PNYrkK5eX5AlzmSwR9FoeLQTp+G4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hnf0WE4BBG2kz5cT09CmhD17rLk2yLT5NNGkX27BPEvhpMs7kLqVXmeQAJk4Y1FP45ot2Eemc2x+lmhRQGQxx0mp8nF1OLUjQBAeUnfsM4XdyrKs3b2/8gFDHlgzR2z8QuqxvfPnq1oXc+beM8f70R5And/+ztvd8gtm1CgXeBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPmX0lZP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FB1C113D0;
	Tue,  2 Dec 2025 21:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764710331;
	bh=/4LkTLBb7fVbr9PNYrkK5eX5AlzmSwR9FoeLQTp+G4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=hPmX0lZPjCVyHD/58sTACdpJn8ZCBNmDsrx652CyLDaVUu9X1uYOnGHNJyzCBNNbm
	 DMdFtGTFLmKzTVitiyrTmtCTH6TUbBrFiAF4BD+5hp8EOkUUStIopQtzYJ/pvM64He
	 RaQRO2fHRGZqecqjcO6rIaWM5Fcwbd47/DFghIYSYv5+acEUAulJlwdXHzpxstVczF
	 pKx+lQlIKi2E1+2j4uP2woH7pzREVPqDZw8mzBFKgvsjYY5tFTSf762oaD+x8m7U1j
	 BTr+4IGraIXNzeuffJ75f8p6oiWO1yqhgx3j74RHayZybaubSYR0g04Hflg6YWzDKU
	 VbSJPWhamR+mg==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>,
	David Arcari <darcari@redhat.com>
Subject: [PATCH 17/21] tools/power turbostat: Validate APERF access for VMWARE
Date: Tue,  2 Dec 2025 16:13:35 -0500
Message-ID: <951845d51d1dd27ecd28a3743af3a8b22bc930ac.1764710012.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <92664f2e6ab2228a3330734fc72dabeaf8a49ee1.1764710012.git.len.brown@intel.com>
References: <92664f2e6ab2228a3330734fc72dabeaf8a49ee1.1764710012.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

VMWARE correctly enumerates lack of APERF and MPERF in CPUID,
but turbostat didn't consult that before attempting to access them.

Since VMWARE allows access, but always returns 0, turbostat
got confusd into an infinite reset loop.

Head this off by listening to CPUID.6.APERF_MPERF
(and rename the existing variable to make this more clear)

Reported-by: David Arcari <darcari@redhat.com>
Tested-by: David Arcari <darcari@redhat.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index ab28ac6e74b6..0064f9091c7f 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -497,7 +497,7 @@ unsigned int summary_only;
 unsigned int list_header_only;
 unsigned int dump_only;
 unsigned int force_load;
-unsigned int has_aperf;
+unsigned int cpuid_has_aperf_mperf;
 unsigned int has_aperf_access;
 unsigned int has_epb;
 unsigned int has_turbo;
@@ -8404,7 +8404,7 @@ void linux_perf_init(void)
 	if (access("/proc/sys/kernel/perf_event_paranoid", F_OK))
 		return;
 
-	if (BIC_IS_ENABLED(BIC_IPC) && has_aperf) {
+	if (BIC_IS_ENABLED(BIC_IPC) && cpuid_has_aperf_mperf) {
 		fd_instr_count_percpu = calloc(topo.max_cpu_num + 1, sizeof(int));
 		if (fd_instr_count_percpu == NULL)
 			err(-1, "calloc fd_instr_count_percpu");
@@ -8524,7 +8524,7 @@ void rapl_perf_init(void)
 /* Assumes msr_counter_info is populated */
 static int has_amperf_access(void)
 {
-	return msr_counter_arch_infos[MSR_ARCH_INFO_APERF_INDEX].present &&
+	return cpuid_has_aperf_mperf && msr_counter_arch_infos[MSR_ARCH_INFO_APERF_INDEX].present &&
 	    msr_counter_arch_infos[MSR_ARCH_INFO_MPERF_INDEX].present;
 }
 
@@ -8936,7 +8936,7 @@ void process_cpuid()
 	 */
 
 	__cpuid(0x6, eax, ebx, ecx, edx);
-	has_aperf = ecx & (1 << 0);
+	cpuid_has_aperf_mperf = ecx & (1 << 0);
 	do_dts = eax & (1 << 0);
 	if (do_dts)
 		BIC_PRESENT(BIC_CoreTmp);
@@ -8954,7 +8954,7 @@ void process_cpuid()
 	if (!quiet)
 		fprintf(outf, "CPUID(6): %sAPERF, %sTURBO, %sDTS, %sPTM, %sHWP, "
 			"%sHWPnotify, %sHWPwindow, %sHWPepp, %sHWPpkg, %sEPB\n",
-			has_aperf ? "" : "No-",
+			cpuid_has_aperf_mperf ? "" : "No-",
 			has_turbo ? "" : "No-",
 			do_dts ? "" : "No-",
 			do_ptm ? "" : "No-",
@@ -9032,7 +9032,7 @@ void process_cpuid()
 				base_mhz, max_mhz, bus_mhz);
 	}
 
-	if (has_aperf)
+	if (cpuid_has_aperf_mperf)
 		aperf_mperf_multiplier = platform->need_perf_multiplier ? 1024 : 1;
 
 	BIC_PRESENT(BIC_IRQ);
@@ -10231,7 +10231,7 @@ int get_and_dump_counters(void)
 
 void print_version()
 {
-	fprintf(outf, "turbostat version 2025.12.01 - Len Brown <lenb@kernel.org>\n");
+	fprintf(outf, "turbostat version 2025.12.02 - Len Brown <lenb@kernel.org>\n");
 }
 
 #define COMMAND_LINE_SIZE 2048
-- 
2.45.2


