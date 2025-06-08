Return-Path: <linux-pm+bounces-28236-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254E9AD13B1
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 20:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6503168F12
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 18:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A0C1D61AA;
	Sun,  8 Jun 2025 18:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiXoDRbp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332A51D5CEA
	for <linux-pm@vger.kernel.org>; Sun,  8 Jun 2025 18:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749406740; cv=none; b=W5e1fZzSFg+4wscOdCacJIVNcDQLDUodpFvXPez3LMyl7a9rCgMdH96WL6xB+16gXi8SdC0K6yobq5zfZB80iEZTeTVY6PMP4x/Boh9EioLLM+5L0dDBVmeW7g39AWmKAzllPfPSxXqla43hnvtJtYlD7uVg6Y5woabLgoPyY5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749406740; c=relaxed/simple;
	bh=JpDQcv1oYiX4oNyhU8kLkpuinSLRHqHGdKBzhV93bpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOG75gELV4WaVFKyE6/Q8DtsK/2NyHSg1SLzCqgaENZ/eEGiBy8KVtfEr4lOXaissbBKdlvIEfi1KSEYG13X03npodq1/hiGT7l5wuoRhiUVYTsbzUEkH9CYpArFt8dz46+uEwaPHhJtXOtbQG8XVnXBZFwn/mSIxf9Mb/IzoGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiXoDRbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3179C4CEF5;
	Sun,  8 Jun 2025 18:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749406740;
	bh=JpDQcv1oYiX4oNyhU8kLkpuinSLRHqHGdKBzhV93bpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=CiXoDRbp9DhDRna+JX6dN49cp08wgNvHOfa1p3nV+Ph81ewmJhrw0mDZE01wh3Fnp
	 /rKDQeJnRtcWngSf/lF/ytXSl+C5wwXXtYCvgUzgE8L0gC0pbak2gJViEt5TRr3KhO
	 91FfmYQPbd1cUt3PDjSQdDX1EFAw+Z9oikZ82uXZncYv/VBOglTt3ZLvmf0jYu+APb
	 hZmWcERRUx0aq7BC056qUOkNzmqr0JEDST7bvNb400BrABbJtVn7mY/a03779t4m/a
	 /TFAmgcZt+s6o5/51n7Z5/m6j40j9mWUDZ1r4OzSX8E4OtKgUulIpfCwrhTN4Y9m2J
	 RiWdA/zZxDphw==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 11/18] tools/power turbostat: Introduce add_msr_counter()
Date: Sun,  8 Jun 2025 14:17:10 -0400
Message-ID: <71b820f0c32c3ee25fd492a728493d19f24f6972.1749406068.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <780da8a9557f2d114aaffda0eb0a517fe6a244c8.1749406068.git.len.brown@intel.com>
References: <780da8a9557f2d114aaffda0eb0a517fe6a244c8.1749406068.git.len.brown@intel.com>
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

probe_rapl_msr() is reused for probing RAPL MSR counters, cstate MSR
counters and MPERF/APERF/SMI MSR counters, thus its name is misleading.

Similar to add_perf_counter(), introduce add_msr_counter() to probe a
counter via MSR. Introduce wrapper function add_rapl_msr_counter() at
the same time to add extra check for Zero return value for specified
RAPL counters.

No functional change intended.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 32 +++++++++++++++++++--------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index ef923da00765..a38cb43ff140 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2222,32 +2222,46 @@ int get_msr(int cpu, off_t offset, unsigned long long *msr)
 	return 0;
 }
 
-int probe_rapl_msr(int cpu, off_t offset, int index)
+int add_msr_counter(int cpu, off_t offset)
 {
 	ssize_t retval;
 	unsigned long long value;
 
-	assert(!no_msr);
+	if (no_msr)
+		return -1;
 
 	retval = pread(get_msr_fd(cpu), &value, sizeof(value), offset);
 
 	/* if the read failed, the probe fails */
 	if (retval != sizeof(value))
-		return 1;
+		return -1;
+
+	if (value == 0)
+		return 0;
+
+	return 1;
+}
+
+int add_rapl_msr_counter(int cpu, off_t offset, int index)
+{
+	int ret;
+
+	ret = add_msr_counter(cpu, offset);
+	if (ret < 0)
+		return -1;
 
-	/* If an Energy Status Counter MSR returns 0, the probe fails */
 	switch (index) {
 	case RAPL_RCI_INDEX_ENERGY_PKG:
 	case RAPL_RCI_INDEX_ENERGY_CORES:
 	case RAPL_RCI_INDEX_DRAM:
 	case RAPL_RCI_INDEX_GFX:
 	case RAPL_RCI_INDEX_ENERGY_PLATFORM:
-		if (value == 0)
+		if (ret == 0)
 			return 1;
 	}
 
 	/* PKG,DRAM_PERF_STATUS MSRs, can return any value */
-	return 0;
+	return 1;
 }
 
 /* Convert CPU ID to domain ID for given added perf counter. */
@@ -7980,7 +7994,7 @@ void rapl_perf_init(void)
 					rci->flags[cai->rci_index] = cai->flags;
 
 					/* Use MSR for this counter */
-				} else if (!no_msr && cai->msr && probe_rapl_msr(cpu, cai->msr, cai->rci_index) == 0) {
+				} else if (!no_msr && cai->msr && add_rapl_msr_counter(cpu, cai->msr, cai->rci_index) >= 0) {
 					rci->source[cai->rci_index] = COUNTER_SOURCE_MSR;
 					rci->msr[cai->rci_index] = cai->msr;
 					rci->msr_mask[cai->rci_index] = cai->msr_mask;
@@ -8110,7 +8124,7 @@ void msr_perf_init_(void)
 					cai->present = true;
 
 					/* User MSR for this counter */
-				} else if (!no_msr && cai->msr && probe_rapl_msr(cpu, cai->msr, cai->rci_index) == 0) {
+				} else if (!no_msr && cai->msr && add_msr_counter(cpu, cai->msr) >= 0) {
 					cci->source[cai->rci_index] = COUNTER_SOURCE_MSR;
 					cci->msr[cai->rci_index] = cai->msr;
 					cci->msr_mask[cai->rci_index] = cai->msr_mask;
@@ -8224,7 +8238,7 @@ void cstate_perf_init_(bool soft_c1)
 
 					/* User MSR for this counter */
 				} else if (!no_msr && cai->msr && pkg_cstate_limit >= cai->pkg_cstate_limit
-					   && probe_rapl_msr(cpu, cai->msr, cai->rci_index) == 0) {
+					   && add_msr_counter(cpu, cai->msr) >= 0) {
 					cci->source[cai->rci_index] = COUNTER_SOURCE_MSR;
 					cci->msr[cai->rci_index] = cai->msr;
 				}
-- 
2.45.2


