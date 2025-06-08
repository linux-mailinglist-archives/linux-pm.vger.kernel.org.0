Return-Path: <linux-pm+bounces-28238-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA89AD13B4
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 20:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22F95168FA1
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 18:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E14B1D6DC5;
	Sun,  8 Jun 2025 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6ICc9jN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A384C2FB
	for <linux-pm@vger.kernel.org>; Sun,  8 Jun 2025 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749406741; cv=none; b=SSC2yNM6lXzA1S7DGGZfrpjA2h7iDP/OanPA8iROm2QLpUPSVplCR1cRv6w+6V9McY6t3/eaKmk9dO5AecZeVEQvV5+jgaheayeJQJQUL+BV2Xb5mJykdiqtcw58sHQCWKamu8JGCPTVQZl7WeCTaJi6cFONDGbPcPlOCdpXfC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749406741; c=relaxed/simple;
	bh=RkeD4VU5ihkZYUE18puxYB7Wgu+C9Y8ufNw740HesFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1Vnty39ologNzhSc2235KwYGLVSOEA2Ll95Jkn8fb8BNop2gPtiyv7qGOwq1wO5IajLPVOSmu3JhbIuR6Tpr08+J/FXqMcCJAPtDJSaI0rU7gpJQtzs3aytWQBHoem3EURQLDPcBYfDRhw6R3u0jykdAmVc/qOWqW3C2LtI6ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6ICc9jN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9C2C4CEF0;
	Sun,  8 Jun 2025 18:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749406741;
	bh=RkeD4VU5ihkZYUE18puxYB7Wgu+C9Y8ufNw740HesFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=F6ICc9jNnQke4n18x22ILDEQYEuBj2m8P4+0mSx+ryTnlZDv9Z8689hdOAttD1DDk
	 AfO//qsfqJNw7kDZfNrtMysssmileGuDK7s1E5I2dLlnAH7IB24fYwaT1YtamDPMIS
	 W4BqPgNzv7rpFUlFwI8Buajxi/Oqo/DcN7u4pn46UWGA0JF2kvrXsxnBCOglhSpjmw
	 0LOsAQHytLxBJsav0g1cE8MGcN2JaK+BkLOQa6XKfHUZjBfKaJgvdbxBofJduvNYsB
	 xxGeg0XHbENyFqvLfArMO54ihsD/iEbDyTbpTeg3Cque8zvvCkYxJwMELBWkl1KZ3g
	 BnkhItdJ1Uraw==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 13/18] tools/power turbostat: Allow probing RAPL with platform_features->rapl_msrs cleared
Date: Sun,  8 Jun 2025 14:17:12 -0400
Message-ID: <653d21afccf1812c95ca042777aeebcfca080173.1749406068.git.len.brown@intel.com>
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

platform_features->rapl_msrs describes the RAPL MSRs supported. While
RAPL Perf counters can be exposed from different kernel backend drivers,
e.g. RAPL MSR I/F driver, or RAPL TPMI I/F driver.

Thus, turbostat should first blindly probe all the available RAPL Perf
counters, and falls back to the RAPL MSR counters if they are listed in
platform_features->rapl_msrs.

With this, platforms that don't have RAPL MSRs can clear the
platform_features->rapl_msrs bits and use RAPL Perf counters only.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 49 +++++++++++++--------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 5a0c526e33c0..6f91ec3f3f14 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2245,15 +2245,18 @@ int add_msr_counter(int cpu, off_t offset)
 	return 1;
 }
 
-int add_rapl_msr_counter(int cpu, off_t offset, int index)
+int add_rapl_msr_counter(int cpu, const struct rapl_counter_arch_info *cai)
 {
 	int ret;
 
-	ret = add_msr_counter(cpu, offset);
+	if (!(platform->rapl_msrs & cai->feature_mask))
+		return -1;
+
+	ret = add_msr_counter(cpu, cai->msr);
 	if (ret < 0)
 		return -1;
 
-	switch (index) {
+	switch (cai->rci_index) {
 	case RAPL_RCI_INDEX_ENERGY_PKG:
 	case RAPL_RCI_INDEX_ENERGY_CORES:
 	case RAPL_RCI_INDEX_DRAM:
@@ -2668,7 +2671,7 @@ void print_header(char *delim)
 	if (DO_BIC(BIC_SYS_LPI))
 		outp += sprintf(outp, "%sSYS%%LPI", (printed++ ? delim : ""));
 
-	if (platform->rapl_msrs && !rapl_joules) {
+	if (!rapl_joules) {
 		if (DO_BIC(BIC_PkgWatt))
 			outp += sprintf(outp, "%sPkgWatt", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_CorWatt) && !platform->has_per_core_rapl)
@@ -2681,7 +2684,7 @@ void print_header(char *delim)
 			outp += sprintf(outp, "%sPKG_%%", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_RAM__))
 			outp += sprintf(outp, "%sRAM_%%", (printed++ ? delim : ""));
-	} else if (platform->rapl_msrs && rapl_joules) {
+	} else {
 		if (DO_BIC(BIC_Pkg_J))
 			outp += sprintf(outp, "%sPkg_J", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_Cor_J) && !platform->has_per_core_rapl)
@@ -7988,26 +7991,22 @@ void rapl_perf_init(void)
 
 			struct rapl_counter_info_t *rci = &rapl_counter_info_perdomain[next_domain];
 
-			/* Check if the counter is enabled and accessible */
-			if (platform->rapl_msrs & cai->feature_mask) {
-
-				/* Use perf API for this counter */
-				if (add_rapl_perf_counter(cpu, rci, cai, &scale, &unit) != -1) {
-					rci->source[cai->rci_index] = COUNTER_SOURCE_PERF;
-					rci->scale[cai->rci_index] = scale * cai->compat_scale;
-					rci->unit[cai->rci_index] = unit;
-					rci->flags[cai->rci_index] = cai->flags;
-
-					/* Use MSR for this counter */
-				} else if (add_rapl_msr_counter(cpu, cai->msr, cai->rci_index) >= 0) {
-					rci->source[cai->rci_index] = COUNTER_SOURCE_MSR;
-					rci->msr[cai->rci_index] = cai->msr;
-					rci->msr_mask[cai->rci_index] = cai->msr_mask;
-					rci->msr_shift[cai->rci_index] = cai->msr_shift;
-					rci->unit[cai->rci_index] = RAPL_UNIT_JOULES;
-					rci->scale[cai->rci_index] = *cai->platform_rapl_msr_scale * cai->compat_scale;
-					rci->flags[cai->rci_index] = cai->flags;
-				}
+			/* Use perf API for this counter */
+			if (add_rapl_perf_counter(cpu, rci, cai, &scale, &unit) != -1) {
+				rci->source[cai->rci_index] = COUNTER_SOURCE_PERF;
+				rci->scale[cai->rci_index] = scale * cai->compat_scale;
+				rci->unit[cai->rci_index] = unit;
+				rci->flags[cai->rci_index] = cai->flags;
+
+			/* Use MSR for this counter */
+			} else if (add_rapl_msr_counter(cpu, cai) >= 0) {
+				rci->source[cai->rci_index] = COUNTER_SOURCE_MSR;
+				rci->msr[cai->rci_index] = cai->msr;
+				rci->msr_mask[cai->rci_index] = cai->msr_mask;
+				rci->msr_shift[cai->rci_index] = cai->msr_shift;
+				rci->unit[cai->rci_index] = RAPL_UNIT_JOULES;
+				rci->scale[cai->rci_index] = *cai->platform_rapl_msr_scale * cai->compat_scale;
+				rci->flags[cai->rci_index] = cai->flags;
 			}
 
 			if (rci->source[cai->rci_index] != COUNTER_SOURCE_NONE)
-- 
2.45.2


