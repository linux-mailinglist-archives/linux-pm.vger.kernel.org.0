Return-Path: <linux-pm+bounces-24853-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3899A7CFD4
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 20:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F81F7A419D
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 18:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C878F1A3142;
	Sun,  6 Apr 2025 18:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqASQ9SQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A477B1A3035
	for <linux-pm@vger.kernel.org>; Sun,  6 Apr 2025 18:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743965906; cv=none; b=dyqXWIZ29mQqPQhNFvEd6Cv1WgWjom9mLlTrhDAbpYIBI6sp0W1D7adt2+CAQlykVRMm6Pocnxq33AnoRbv65O4WTk1g1cxuH77pW6Z15NvPtsjggtMW/3rMaQ4QOr1lG/RA2zCwIx0dm3viBZaDBfrtNpR473uy3Kb2IehY6gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743965906; c=relaxed/simple;
	bh=xC+50Bwa9nQ8jnzIJOkSmSePr2jjZfw86Dl/KsSW67E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sP6ei4IYFW+5L5ziWkGffH7Qdy2okGfpqNWwj1+QyeY1E1Zwqxm/NWaNsOvPTRGfCZs4N8uMi8Qpk6IwvFV8NSk+ZGbgTPwYiAv9rn4fsTrMKRNUO/tXq2mSDbesHRGtae0R/A7FQ5D5aUSWA8JpTX5sBs5ncs2+rbE8G1DWPH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqASQ9SQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DF9C4CEE3;
	Sun,  6 Apr 2025 18:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743965906;
	bh=xC+50Bwa9nQ8jnzIJOkSmSePr2jjZfw86Dl/KsSW67E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=PqASQ9SQ5btxrbBIfGg+0BTmPbPy3c0v+iDNExaD20JoBUfIFbZnYPE5I9gegNqZk
	 zJF3ypBr1aozrtHyeKKN37YwhQT9B1piIy4xX+EzPE6f2rTrfykqjL3YM+Mr5enk7E
	 ozCU8y/ToWsfkDaHMr70l2YZY4TwISHmkZLVyuhG288FF2OjTFu53SXVRC1JBi7LLM
	 WQ9ZcI2hIakwC1jr2UrmYJHRkkKafaPU6WXdoazjMeO3e2FfUSiVqtkLjQpRR80/rN
	 w7iCzP5arJ5lJhhT2iq5f4+9F4VazwseIFd9uXEO3a+fToWKg8woJT4cnqOwRsV3kj
	 cdz9HIhhXN5ww==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Artem Bityutskiy <artem.bityutskiy@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 02/10] tools/power turbostat: Allow Zero return value for some RAPL registers
Date: Sun,  6 Apr 2025 14:57:11 -0400
Message-ID: <b312d880fb462d4759396950865ec914de9d253c.1743965272.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <1c7c7388e6c31f46b26a884d80b45efbad8237b2.1743965272.git.len.brown@intel.com>
References: <1c7c7388e6c31f46b26a884d80b45efbad8237b2.1743965272.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Zhang Rui <rui.zhang@intel.com>

turbostat aborted with below messages on a dual-package system,

   turbostat: turbostat.c:3744: rapl_counter_accumulate: Assertion `dst->unit == src->unit' failed.
   Aborted

This is because
1. the MSR_DRAM_PERF_STATUS returns Zero for one package, and non-Zero
   for another package
2. probe_msr() treats Zero return value as a failure so this feature is
   enabled on one package, and disabled for another package.
3. turbostat aborts because the feature is invalid on some package

Unlike the RAPL energy counter registers, MSR_DRAM_PERF_STATUS can
return Zero value, and this should not be treated as a failure.

Fix the problem by allowing Zero return value for RAPL registers other
than the energy counters.

Fixes: 7c6fee25bdf5 ("tools/power turbostat: Check for non-zero value when MSR probing")
Reported-by: Artem Bityutskiy <artem.bityutskiy@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 5eef95956c2f..d26008f37a2c 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2211,7 +2211,7 @@ int get_msr(int cpu, off_t offset, unsigned long long *msr)
 	return 0;
 }
 
-int probe_msr(int cpu, off_t offset)
+int probe_rapl_msr(int cpu, off_t offset, int index)
 {
 	ssize_t retval;
 	unsigned long long value;
@@ -2220,13 +2220,22 @@ int probe_msr(int cpu, off_t offset)
 
 	retval = pread(get_msr_fd(cpu), &value, sizeof(value), offset);
 
-	/*
-	 * Expect MSRs to accumulate some non-zero value since the system was powered on.
-	 * Treat zero as a read failure.
-	 */
-	if (retval != sizeof(value) || value == 0)
+	/* if the read failed, the probe fails */
+	if (retval != sizeof(value))
 		return 1;
 
+	/* If an Energy Status Counter MSR returns 0, the probe fails */
+	switch (index) {
+	case RAPL_RCI_INDEX_ENERGY_PKG:
+	case RAPL_RCI_INDEX_ENERGY_CORES:
+	case RAPL_RCI_INDEX_DRAM:
+	case RAPL_RCI_INDEX_GFX:
+	case RAPL_RCI_INDEX_ENERGY_PLATFORM:
+		if (value == 0)
+			return 1;
+	}
+
+	/* PKG,DRAM_PERF_STATUS MSRs, can return any value */
 	return 0;
 }
 
@@ -7907,7 +7916,7 @@ void rapl_perf_init(void)
 					rci->flags[cai->rci_index] = cai->flags;
 
 					/* Use MSR for this counter */
-				} else if (!no_msr && cai->msr && probe_msr(cpu, cai->msr) == 0) {
+				} else if (!no_msr && cai->msr && probe_rapl_msr(cpu, cai->msr, cai->rci_index) == 0) {
 					rci->source[cai->rci_index] = COUNTER_SOURCE_MSR;
 					rci->msr[cai->rci_index] = cai->msr;
 					rci->msr_mask[cai->rci_index] = cai->msr_mask;
@@ -8045,7 +8054,7 @@ void msr_perf_init_(void)
 					cai->present = true;
 
 					/* User MSR for this counter */
-				} else if (!no_msr && cai->msr && probe_msr(cpu, cai->msr) == 0) {
+				} else if (!no_msr && cai->msr && probe_rapl_msr(cpu, cai->msr, cai->rci_index) == 0) {
 					cci->source[cai->rci_index] = COUNTER_SOURCE_MSR;
 					cci->msr[cai->rci_index] = cai->msr;
 					cci->msr_mask[cai->rci_index] = cai->msr_mask;
@@ -8159,7 +8168,7 @@ void cstate_perf_init_(bool soft_c1)
 
 					/* User MSR for this counter */
 				} else if (!no_msr && cai->msr && pkg_cstate_limit >= cai->pkg_cstate_limit
-					   && probe_msr(cpu, cai->msr) == 0) {
+					   && probe_rapl_msr(cpu, cai->msr, cai->rci_index) == 0) {
 					cci->source[cai->rci_index] = COUNTER_SOURCE_MSR;
 					cci->msr[cai->rci_index] = cai->msr;
 				}
-- 
2.45.2


