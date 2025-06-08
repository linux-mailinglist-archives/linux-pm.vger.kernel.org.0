Return-Path: <linux-pm+bounces-28237-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 131F1AD13B3
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 20:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214113A7FAE
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 18:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E409A1D5CEA;
	Sun,  8 Jun 2025 18:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m24zHWfD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03DC199947
	for <linux-pm@vger.kernel.org>; Sun,  8 Jun 2025 18:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749406740; cv=none; b=lnaOFb/a5MR+7Ih2ExonaauryznJK+DSYKKnM9THQFDZJTZx7BxF0UowwLk6eo+Jyk2F56keiN+ynxTmMefwNDyozcvs79Wof6I4NoMU1hBCRH5FqBv+wLDGrP7GtsKc348medENGHtZIn+kot+LyuIQKv8NfxI57vOkYod2Cc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749406740; c=relaxed/simple;
	bh=MWCngn20Bq1JUliEaQUoBN136L/IfdmyQCZ6iFXSvwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bno7NNS34wEvFY3euKiGtauLyhh/4d2FjMw1MpcowPx+624I+pdwTULeGnOq0gIzVijcuG3N4oeY7yoaB6JPe5QhPB208wlDm9Eed/3U98jzl1SFQz/w6DQ17kJLCmfVIhSQhikDc3pCYXTUdgioEn+QFB50d48zRlOfrK6qZSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m24zHWfD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F924C4CEF2;
	Sun,  8 Jun 2025 18:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749406740;
	bh=MWCngn20Bq1JUliEaQUoBN136L/IfdmyQCZ6iFXSvwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=m24zHWfDIogyfgbewJSBO2IKIG0OnQ8txJWzRNyaZ8rU9lujVloOCX2vuOoUl87Zz
	 YpY9XKhO9cBGMdCKSee/bZlw+pdK2zchYnMxJQkttsVSJLzEDRwRBH5aGzrGJTUtQ7
	 nHthfrqC/S5vruy8Kug+Ab02d1oDkOLlOERbMmfxwFTqvJ0rXX9mAkn6huG72qE7kq
	 JmfbJkbe7riA3S31hMbA/Z4BVXnozYjtPkJ/5FUb2Zx+usLDrGYyAcAktuwfYlpHlC
	 6U/P+pQOdH37/uwXYdX+AB8Ge46mGnIXxmmZGocxpQl0h+rLoOnWLSloSbenHney1F
	 1q78J1BFN7Vcw==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 12/18] tools/power turbostat: Clean up add perf/msr counter logic
Date: Sun,  8 Jun 2025 14:17:11 -0400
Message-ID: <843b32ccdfdf88563e46fca209b8e562536c7a8f.1749406068.git.len.brown@intel.com>
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

Increase the code readability by moving the no_perf/no_msr flag and the
cai->perf_name/cai->msr sanity checks into the counter probe functions.

No functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index a38cb43ff140..5a0c526e33c0 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2230,6 +2230,9 @@ int add_msr_counter(int cpu, off_t offset)
 	if (no_msr)
 		return -1;
 
+	if (!offset)
+		return -1;
+
 	retval = pread(get_msr_fd(cpu), &value, sizeof(value), offset);
 
 	/* if the read failed, the probe fails */
@@ -7875,6 +7878,9 @@ int add_rapl_perf_counter(int cpu, struct rapl_counter_info_t *rci, const struct
 	if (no_perf)
 		return -1;
 
+	if (!cai->perf_name)
+		return -1;
+
 	const double scale = read_perf_scale(cai->perf_subsys, cai->perf_name);
 
 	if (scale == 0.0)
@@ -7986,15 +7992,14 @@ void rapl_perf_init(void)
 			if (platform->rapl_msrs & cai->feature_mask) {
 
 				/* Use perf API for this counter */
-				if (!no_perf && cai->perf_name
-				    && add_rapl_perf_counter(cpu, rci, cai, &scale, &unit) != -1) {
+				if (add_rapl_perf_counter(cpu, rci, cai, &scale, &unit) != -1) {
 					rci->source[cai->rci_index] = COUNTER_SOURCE_PERF;
 					rci->scale[cai->rci_index] = scale * cai->compat_scale;
 					rci->unit[cai->rci_index] = unit;
 					rci->flags[cai->rci_index] = cai->flags;
 
 					/* Use MSR for this counter */
-				} else if (!no_msr && cai->msr && add_rapl_msr_counter(cpu, cai->msr, cai->rci_index) >= 0) {
+				} else if (add_rapl_msr_counter(cpu, cai->msr, cai->rci_index) >= 0) {
 					rci->source[cai->rci_index] = COUNTER_SOURCE_MSR;
 					rci->msr[cai->rci_index] = cai->msr;
 					rci->msr_mask[cai->rci_index] = cai->msr_mask;
@@ -8042,6 +8047,9 @@ int add_cstate_perf_counter(int cpu, struct cstate_counter_info_t *cci, const st
 	if (no_perf)
 		return -1;
 
+	if (!cai->perf_name)
+		return -1;
+
 	int *pfd_group = get_cstate_perf_group_fd(cci, cai->perf_subsys);
 
 	if (pfd_group == NULL)
@@ -8073,6 +8081,9 @@ int add_msr_perf_counter(int cpu, struct msr_counter_info_t *cci, const struct m
 	if (no_perf)
 		return -1;
 
+	if (!cai->perf_name)
+		return -1;
+
 	const unsigned int type = read_perf_type(cai->perf_subsys);
 	const unsigned int config = read_perf_config(cai->perf_subsys, cai->perf_name);
 
@@ -8119,12 +8130,12 @@ void msr_perf_init_(void)
 
 			if (cai->needed) {
 				/* Use perf API for this counter */
-				if (!no_perf && cai->perf_name && add_msr_perf_counter(cpu, cci, cai) != -1) {
+				if (add_msr_perf_counter(cpu, cci, cai) != -1) {
 					cci->source[cai->rci_index] = COUNTER_SOURCE_PERF;
 					cai->present = true;
 
 					/* User MSR for this counter */
-				} else if (!no_msr && cai->msr && add_msr_counter(cpu, cai->msr) >= 0) {
+				} else if (add_msr_counter(cpu, cai->msr) >= 0) {
 					cci->source[cai->rci_index] = COUNTER_SOURCE_MSR;
 					cci->msr[cai->rci_index] = cai->msr;
 					cci->msr_mask[cai->rci_index] = cai->msr_mask;
@@ -8232,12 +8243,12 @@ void cstate_perf_init_(bool soft_c1)
 
 			if (counter_needed && counter_supported) {
 				/* Use perf API for this counter */
-				if (!no_perf && cai->perf_name && add_cstate_perf_counter(cpu, cci, cai) != -1) {
+				if (add_cstate_perf_counter(cpu, cci, cai) != -1) {
 
 					cci->source[cai->rci_index] = COUNTER_SOURCE_PERF;
 
 					/* User MSR for this counter */
-				} else if (!no_msr && cai->msr && pkg_cstate_limit >= cai->pkg_cstate_limit
+				} else if (pkg_cstate_limit >= cai->pkg_cstate_limit
 					   && add_msr_counter(cpu, cai->msr) >= 0) {
 					cci->source[cai->rci_index] = COUNTER_SOURCE_MSR;
 					cci->msr[cai->rci_index] = cai->msr;
-- 
2.45.2


