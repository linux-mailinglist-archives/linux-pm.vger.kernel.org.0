Return-Path: <linux-pm+bounces-42775-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qO3gOK+8lGm4HQIAu9opvQ
	(envelope-from <linux-pm+bounces-42775-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 20:08:31 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6408214F7E7
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 20:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B2A730557EF
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 19:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B35C37419A;
	Tue, 17 Feb 2026 19:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVlzx3pj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3C336F402
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 19:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771355279; cv=none; b=YmS9dmkprPN5/a3Ui9fL70FlPdajtqj5CycbFLMltuCTKs4b/HGtjgVCILtt7RAEvyXt2YY3cZZ/Fnn2ZjBZLHlAniT5bHBM3QhFIVT9UydYX5IwtwQcQ8k/f+d5Hk/2EqVhiEMgZZjmTu54HlmDzOC8pVo1focf5Br98lShrGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771355279; c=relaxed/simple;
	bh=i+jFcBqVsD6dnIsv9GQIYIyIkKbxkLswYZ5TaL1RpJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9XS3lQFzSn7C4ZX+GXDJnCNWlVAv3JJiQFVdePdOR6iSns3tAMJyw8TVORQNZiZ+JPava3y9sJegR5GGiuvuHcNtw/7TNQLcovcbCbQuweZ5afdSrmWhipUUjnZ7vZ8+UYUnCQ6WBoU+lEAuNjkdvuQgklVhmUHE6Oc+9gg4AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVlzx3pj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B0FC4CEF7;
	Tue, 17 Feb 2026 19:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771355279;
	bh=i+jFcBqVsD6dnIsv9GQIYIyIkKbxkLswYZ5TaL1RpJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=gVlzx3pj87c4aA/1l3nHR0FTjBkqYrcfagCkPqhX7YUV7lGaYO9LPQLKg3BFmbmm3
	 +jp17MlLd6FsNUBFUN8JjxTrSUZ16b+5yq8Sn1MUfhS6Q0jyddWTPWYG4+VUpLnv9/
	 cepsVwj4XpgpQv2IOspZ4eOTVb9eW+EvelpIFFecZ3zzFo+7rxsU1FXnT6HxuWdBH7
	 oKdTSXMLkuB0JRJKCd6qxfOMu3jjLPo5+Db0M0zeoIf0vva4PQ/gkCR0Qsz81Pt3WO
	 1wYWY/cxoOfZIIas2tuaxuqE0/jnkJjQ8yS2YDeUa4kRT1kaCO8NxiztcK8B0NIRR9
	 xFo/r7l/2qW/Q==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 07/23] tools/power turbostat: Rename "LLCkRPS" column to "LLCMRPS"
Date: Tue, 17 Feb 2026 13:03:58 -0600
Message-ID: <041e975937123ee22a7925e468ab73b8a8991767.1771354332.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <16cc8f249c702b7cbb4c2c2be7cd8f4fdd5d1d0c.1771354332.git.len.brown@intel.com>
References: <16cc8f249c702b7cbb4c2c2be7cd8f4fdd5d1d0c.1771354332.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-42775-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[lenb@kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lenb@kernel.org,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 6408214F7E7
X-Rspamd-Action: no action

From: Len Brown <len.brown@intel.com>

The purpose of the LLC References per Second LLC column
is to qualify the significance of the LLC%hit column.

If RPS is high, then the hit rate matters.
If RPS is low, then the hit rate is not significant.

Remove unnecessary and distracting precision in the RPS column
by dividing my a million rather than by a thousand.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 |  2 +-
 tools/power/x86/turbostat/turbostat.c | 30 +++++++++++++--------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index cb3fd8576146..44a416a728b3 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -161,7 +161,7 @@ The system configuration dump (if --quiet is not used) is followed by statistics
 .PP
 \fBSMI\fP The number of System Management Interrupts  serviced CPU during the measurement interval.  While this counter is actually per-CPU, SMI are triggered on all processors, so the number should be the same for all CPUs.
 .PP
-\fBLLCkRPS\fP Last Level Cache Thousands of References Per Second.  For CPUs with an L3 LLC, this is the number of references that CPU made to the L3 (and the number of misses that CPU made to it's L2).  For CPUs with an L2 LLC, this is the number of references to the L2 (and the number of misses to the CPU's L1).  The system summary row shows the sum for all CPUs.  In both cases, the value displayed is the actual value divided by 1000 in the interest of usually fitting into 8 columns.
+\fBLLCMRPS\fP Last Level Cache Millions of References Per Second.  For CPUs with an L3 LLC, this is the number of references that CPU made to the L3 (and the number of misses that CPU made to it's L2).  For CPUs with an L2 LLC, this is the number of references to the L2 (and the number of misses to the CPU's L1).  The system summary row shows the sum for all CPUs.  In both cases, the value displayed is the actual value divided by 1,000,000.  If this value is large, then the LLC%hit column is significant.  If this value is small, then the LLC%hit column is not significant.
 .PP
 \fBLLC%hit\fP Last Level Cache Hit Rate %.  Hit Rate Percent = 100.0 * (References - Misses)/References.  The system summary row shows the weighted average for all CPUs (100.0 * (Sum_References - Sum_Misses)/Sum_References).
 .PP
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 4dd4b0f3e6d4..2dfc110ae483 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -210,7 +210,7 @@ struct msr_counter bic[] = {
 	{ 0x0, "NMI", NULL, 0, 0, 0, NULL, 0 },
 	{ 0x0, "CPU%c1e", NULL, 0, 0, 0, NULL, 0 },
 	{ 0x0, "pct_idle", NULL, 0, 0, 0, NULL, 0 },
-	{ 0x0, "LLCkRPS", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "LLCMRPS", NULL, 0, 0, 0, NULL, 0 },
 	{ 0x0, "LLC%hit", NULL, 0, 0, 0, NULL, 0 },
 };
 
@@ -281,7 +281,7 @@ enum bic_names {
 	BIC_NMI,
 	BIC_CPU_c1e,
 	BIC_pct_idle,
-	BIC_LLC_RPS,
+	BIC_LLC_MRPS,
 	BIC_LLC_HIT,
 	MAX_BIC
 };
@@ -424,7 +424,7 @@ static void bic_groups_init(void)
 	SET_BIC(BIC_pct_idle, &bic_group_idle);
 
 	BIC_INIT(&bic_group_cache);
-	SET_BIC(BIC_LLC_RPS, &bic_group_cache);
+	SET_BIC(BIC_LLC_MRPS, &bic_group_cache);
 	SET_BIC(BIC_LLC_HIT, &bic_group_cache);
 
 	BIC_INIT(&bic_group_other);
@@ -2440,7 +2440,7 @@ static void bic_disable_msr_access(void)
 static void bic_disable_perf_access(void)
 {
 	CLR_BIC(BIC_IPC, &bic_enabled);
-	CLR_BIC(BIC_LLC_RPS, &bic_enabled);
+	CLR_BIC(BIC_LLC_MRPS, &bic_enabled);
 	CLR_BIC(BIC_LLC_HIT, &bic_enabled);
 }
 
@@ -2814,8 +2814,8 @@ void print_header(char *delim)
 	if (DO_BIC(BIC_SMI))
 		outp += sprintf(outp, "%sSMI", (printed++ ? delim : ""));
 
-	if (DO_BIC(BIC_LLC_RPS))
-		outp += sprintf(outp, "%sLLCkRPS", (printed++ ? delim : ""));
+	if (DO_BIC(BIC_LLC_MRPS))
+		outp += sprintf(outp, "%sLLCMRPS", (printed++ ? delim : ""));
 
 	if (DO_BIC(BIC_LLC_HIT))
 		outp += sprintf(outp, "%sLLC%%hit", (printed++ ? delim : ""));
@@ -3306,9 +3306,9 @@ int format_counters(PER_THREAD_PARAMS)
 		outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), t->smi_count);
 
 	/* LLC Stats */
-	if (DO_BIC(BIC_LLC_RPS) || DO_BIC(BIC_LLC_HIT)) {
-		if (DO_BIC(BIC_LLC_RPS))
-			outp += sprintf(outp, "%s%.0f", (printed++ ? delim : ""), t->llc.references / interval_float / 1000);
+	if (DO_BIC(BIC_LLC_MRPS) || DO_BIC(BIC_LLC_HIT)) {
+		if (DO_BIC(BIC_LLC_MRPS))
+			outp += sprintf(outp, "%s%.0f", (printed++ ? delim : ""), t->llc.references / interval_float / 1000000);
 
 		if (DO_BIC(BIC_LLC_HIT))
 			outp += sprintf(outp, fmt8, (printed++ ? delim : ""), pct((t->llc.references - t->llc.misses), t->llc.references));
@@ -3855,7 +3855,7 @@ int delta_thread(struct thread_data *new, struct thread_data *old, struct core_d
 	if (DO_BIC(BIC_SMI))
 		old->smi_count = new->smi_count - old->smi_count;
 
-	if (DO_BIC(BIC_LLC_RPS))
+	if (DO_BIC(BIC_LLC_MRPS))
 		old->llc.references = new->llc.references - old->llc.references;
 
 	if (DO_BIC(BIC_LLC_HIT))
@@ -5067,7 +5067,7 @@ int get_counters(PER_THREAD_PARAMS)
 
 	get_smi_aperf_mperf(cpu, t);
 
-	if (DO_BIC(BIC_LLC_RPS) || DO_BIC(BIC_LLC_HIT))
+	if (DO_BIC(BIC_LLC_MRPS) || DO_BIC(BIC_LLC_HIT))
 		get_perf_llc_stats(cpu, &t->llc);
 
 	if (DO_BIC(BIC_IPC))
@@ -8344,7 +8344,7 @@ void linux_perf_init(void)
 		if (fd_instr_count_percpu == NULL)
 			err(-1, "calloc fd_instr_count_percpu");
 	}
-	if (BIC_IS_ENABLED(BIC_LLC_RPS)) {
+	if (BIC_IS_ENABLED(BIC_LLC_MRPS)) {
 		fd_llc_percpu = calloc(topo.max_cpu_num + 1, sizeof(int));
 		if (fd_llc_percpu == NULL)
 			err(-1, "calloc fd_llc_percpu");
@@ -9066,7 +9066,7 @@ void perf_llc_init(void)
 
 	if (no_perf)
 		return;
-	if (!(BIC_IS_ENABLED(BIC_LLC_RPS) && BIC_IS_ENABLED(BIC_LLC_HIT)))
+	if (!(BIC_IS_ENABLED(BIC_LLC_MRPS) && BIC_IS_ENABLED(BIC_LLC_HIT)))
 		return;
 
 	for (cpu = 0; cpu <= topo.max_cpu_num; ++cpu) {
@@ -9089,7 +9089,7 @@ void perf_llc_init(void)
 			return;
 		}
 	}
-	BIC_PRESENT(BIC_LLC_RPS);
+	BIC_PRESENT(BIC_LLC_MRPS);
 	BIC_PRESENT(BIC_LLC_HIT);
 }
 
@@ -9518,7 +9518,7 @@ void check_perf_access(void)
 		if (!has_perf_instr_count_access())
 			no_perf = 1;
 
-	if (BIC_IS_ENABLED(BIC_LLC_RPS) || BIC_IS_ENABLED(BIC_LLC_HIT))
+	if (BIC_IS_ENABLED(BIC_LLC_MRPS) || BIC_IS_ENABLED(BIC_LLC_HIT))
 		if (!has_perf_llc_access())
 			no_perf = 1;
 
-- 
2.45.2


