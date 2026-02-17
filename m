Return-Path: <linux-pm+bounces-42783-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAxkGJ68lGm4HQIAu9opvQ
	(envelope-from <linux-pm+bounces-42783-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 20:08:14 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E659214F79C
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 20:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0858C300DEC5
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 19:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBFD37472C;
	Tue, 17 Feb 2026 19:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKrNZBiM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B670372B44
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 19:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771355290; cv=none; b=fqoMYUQPJFnTcHMUiaByUPFDkyALkIhQjmyzA4iJ/E5Wy8dJ1UgiDBq6LHF8Mhva32aDemp6KA1tbsxV43Ov61hk8OfBcJDkxwD7DnFq1oHv1eUZkQWrWmQSEGTe1hvRX4KL9wry5IDZMV77VwLtrvQN3tXyrpN73GgQtsZtQ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771355290; c=relaxed/simple;
	bh=4/8LTBUwKUSD5x2LmtCuuYWtoGa0QapQOjGf1kCaYbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=st/yw3rRcDF9xgms+Vu1hgcQVb6CHIT22qX+zwyzOGra98MgSqbtq8vkqx9yHeFd1AWzy1ayOXIbhsECpH7vEsUirbZBfuJTLNKmlG5I7C7cW2RC5ycVdY0OJRoIz65Lvt5+4y4Nd7UMNbTui8iiZSfSj86cECuzBrzuGrEDJWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKrNZBiM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B4AC19421;
	Tue, 17 Feb 2026 19:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771355290;
	bh=4/8LTBUwKUSD5x2LmtCuuYWtoGa0QapQOjGf1kCaYbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=GKrNZBiMrA/1/zr4xFAGWzWhstDUJkf0gu8+rg1N/yr2TQEIze1s3FwlBuT7Eg17d
	 MUogPMqTxSIPpFFxF0DCJkLhY3UIzIdKPi+xxNkMUMgyzAP5F1FjVF3Hw69N3V+TAt
	 PgIrksW9CvdMWzx5oxdEGaI2VThfPoamt1GUG1xd5p6Rl4DtGauS0260SbFxnRT4VR
	 KYmiG2595gqFgpxlNH2GdF+PcbjhRbTmHHbmA8se/94KcEKmmqWkcvMCzUFlH3CN+g
	 tEGhjlH/iBQgXb/MHKmbQoYdhs8UFTunakSRItdv4sQvr6TJcFZtwSFUEiUIVtMp+G
	 YfKi/au97Aj8g==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 15/23] tools/power turbostat: Allocate average counters dynamically
Date: Tue, 17 Feb 2026 13:04:06 -0600
Message-ID: <3cecd4a62d227d86ec6eb5387add0ca3d4d02b27.1771354333.git.len.brown@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
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
	TAGGED_FROM(0.00)[bounces-42783-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[lenb@kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lenb@kernel.org,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:mid,intel.com:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: E659214F79C
X-Rspamd-Action: no action

From: Len Brown <len.brown@intel.com>

The current static definition of average{} is inconsistent with
the dynamically allocated even{} and odd{} counters.

Allocate average{} counters dynamically.

No functional change.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 243 ++++++++++++++------------
 1 file changed, 131 insertions(+), 112 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index af6338460320..b3b697e669a3 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2383,9 +2383,9 @@ static void free_sys_msr_counters(void)
 }
 
 struct system_summary {
-	struct thread_data threads;
-	struct core_data cores;
-	struct pkg_data packages;
+	struct thread_data *threads;
+	struct core_data *cores;
+	struct pkg_data *packages;
 } average;
 
 struct platform_counters {
@@ -3308,7 +3308,7 @@ int format_counters(PER_THREAD_PARAMS)
 	char *delim = "\t";
 	int printed = 0;
 
-	if (t == &average.threads) {
+	if (t == average.threads) {
 		pplat_cnt = count & 1 ? &platform_counters_odd : &platform_counters_even;
 		++count;
 	}
@@ -3322,7 +3322,7 @@ int format_counters(PER_THREAD_PARAMS)
 		return 0;
 
 	/*if not summary line and --cpu is used */
-	if ((t != &average.threads) && (cpu_subset && !CPU_ISSET_S(t->cpu_id, cpu_subset_size, cpu_subset)))
+	if ((t != average.threads) && (cpu_subset && !CPU_ISSET_S(t->cpu_id, cpu_subset_size, cpu_subset)))
 		return 0;
 
 	if (DO_BIC(BIC_USEC)) {
@@ -3342,7 +3342,7 @@ int format_counters(PER_THREAD_PARAMS)
 	tsc = t->tsc * tsc_tweak;
 
 	/* topo columns, print blanks on 1st (average) line */
-	if (t == &average.threads) {
+	if (t == average.threads) {
 		if (DO_BIC(BIC_Package))
 			outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_Die))
@@ -3723,10 +3723,10 @@ int format_counters(PER_THREAD_PARAMS)
 		}
 	}
 
-	if (DO_BIC(BIC_SysWatt) && (t == &average.threads))
+	if (DO_BIC(BIC_SysWatt) && (t == average.threads))
 		outp += sprintf(outp, fmt8, (printed++ ? delim : ""),
 				rapl_counter_get_value(&pplat_cnt->energy_psys, RAPL_UNIT_WATTS, interval_float));
-	if (DO_BIC(BIC_Sys_J) && (t == &average.threads))
+	if (DO_BIC(BIC_Sys_J) && (t == average.threads))
 		outp += sprintf(outp, fmt8, (printed++ ? delim : ""),
 				rapl_counter_get_value(&pplat_cnt->energy_psys, RAPL_UNIT_JOULES, interval_float));
 
@@ -3766,7 +3766,7 @@ void format_all_counters(PER_THREAD_PARAMS)
 	if ((!count || (header_iterations && !(count % header_iterations))) || !summary_only)
 		print_header("\t");
 
-	format_counters(&average.threads, &average.cores, &average.packages);
+	format_counters(average.threads, average.cores, average.packages);
 
 	count++;
 
@@ -4170,78 +4170,78 @@ int sum_counters(PER_THREAD_PARAMS)
 
 	/* copy un-changing apic_id's */
 	if (DO_BIC(BIC_APIC))
-		average.threads.apic_id = t->apic_id;
+		average.threads->apic_id = t->apic_id;
 	if (DO_BIC(BIC_X2APIC))
-		average.threads.x2apic_id = t->x2apic_id;
+		average.threads->x2apic_id = t->x2apic_id;
 
 	/* remember first tv_begin */
-	if (average.threads.tv_begin.tv_sec == 0)
-		average.threads.tv_begin = procsysfs_tv_begin;
+	if (average.threads->tv_begin.tv_sec == 0)
+		average.threads->tv_begin = procsysfs_tv_begin;
 
 	/* remember last tv_end */
-	average.threads.tv_end = t->tv_end;
+	average.threads->tv_end = t->tv_end;
 
-	average.threads.tsc += t->tsc;
-	average.threads.aperf += t->aperf;
-	average.threads.mperf += t->mperf;
-	average.threads.c1 += t->c1;
+	average.threads->tsc += t->tsc;
+	average.threads->aperf += t->aperf;
+	average.threads->mperf += t->mperf;
+	average.threads->c1 += t->c1;
 
-	average.threads.instr_count += t->instr_count;
+	average.threads->instr_count += t->instr_count;
 
-	average.threads.irq_count += t->irq_count;
-	average.threads.nmi_count += t->nmi_count;
-	average.threads.smi_count += t->smi_count;
+	average.threads->irq_count += t->irq_count;
+	average.threads->nmi_count += t->nmi_count;
+	average.threads->smi_count += t->smi_count;
 
-	average.threads.llc.references += t->llc.references;
-	average.threads.llc.misses += t->llc.misses;
+	average.threads->llc.references += t->llc.references;
+	average.threads->llc.misses += t->llc.misses;
 
-	average.threads.l2.references += t->l2.references;
-	average.threads.l2.hits += t->l2.hits;
+	average.threads->l2.references += t->l2.references;
+	average.threads->l2.hits += t->l2.hits;
 
 	for (i = 0, mp = sys.tp; mp; i++, mp = mp->next) {
 		if (mp->format == FORMAT_RAW)
 			continue;
-		average.threads.counter[i] += t->counter[i];
+		average.threads->counter[i] += t->counter[i];
 	}
 
 	for (i = 0, pp = sys.perf_tp; pp; i++, pp = pp->next) {
 		if (pp->format == FORMAT_RAW)
 			continue;
-		average.threads.perf_counter[i] += t->perf_counter[i];
+		average.threads->perf_counter[i] += t->perf_counter[i];
 	}
 
 	for (i = 0, ppmt = sys.pmt_tp; ppmt; i++, ppmt = ppmt->next) {
-		average.threads.pmt_counter[i] += t->pmt_counter[i];
+		average.threads->pmt_counter[i] += t->pmt_counter[i];
 	}
 
 	/* sum per-core values only for 1st thread in core */
 	if (!is_cpu_first_thread_in_core(t, c))
 		return 0;
 
-	average.cores.c3 += c->c3;
-	average.cores.c6 += c->c6;
-	average.cores.c7 += c->c7;
-	average.cores.mc6_us += c->mc6_us;
+	average.cores->c3 += c->c3;
+	average.cores->c6 += c->c6;
+	average.cores->c7 += c->c7;
+	average.cores->mc6_us += c->mc6_us;
 
-	average.cores.core_temp_c = MAX(average.cores.core_temp_c, c->core_temp_c);
-	average.cores.core_throt_cnt = MAX(average.cores.core_throt_cnt, c->core_throt_cnt);
+	average.cores->core_temp_c = MAX(average.cores->core_temp_c, c->core_temp_c);
+	average.cores->core_throt_cnt = MAX(average.cores->core_throt_cnt, c->core_throt_cnt);
 
-	rapl_counter_accumulate(&average.cores.core_energy, &c->core_energy);
+	rapl_counter_accumulate(&average.cores->core_energy, &c->core_energy);
 
 	for (i = 0, mp = sys.cp; mp; i++, mp = mp->next) {
 		if (mp->format == FORMAT_RAW)
 			continue;
-		average.cores.counter[i] += c->counter[i];
+		average.cores->counter[i] += c->counter[i];
 	}
 
 	for (i = 0, pp = sys.perf_cp; pp; i++, pp = pp->next) {
 		if (pp->format == FORMAT_RAW)
 			continue;
-		average.cores.perf_counter[i] += c->perf_counter[i];
+		average.cores->perf_counter[i] += c->perf_counter[i];
 	}
 
 	for (i = 0, ppmt = sys.pmt_cp; ppmt; i++, ppmt = ppmt->next) {
-		average.cores.pmt_counter[i] += c->pmt_counter[i];
+		average.cores->pmt_counter[i] += c->pmt_counter[i];
 	}
 
 	/* sum per-pkg values only for 1st core in pkg */
@@ -4249,63 +4249,63 @@ int sum_counters(PER_THREAD_PARAMS)
 		return 0;
 
 	if (DO_BIC(BIC_Totl_c0))
-		average.packages.pkg_wtd_core_c0 += p->pkg_wtd_core_c0;
+		average.packages->pkg_wtd_core_c0 += p->pkg_wtd_core_c0;
 	if (DO_BIC(BIC_Any_c0))
-		average.packages.pkg_any_core_c0 += p->pkg_any_core_c0;
+		average.packages->pkg_any_core_c0 += p->pkg_any_core_c0;
 	if (DO_BIC(BIC_GFX_c0))
-		average.packages.pkg_any_gfxe_c0 += p->pkg_any_gfxe_c0;
+		average.packages->pkg_any_gfxe_c0 += p->pkg_any_gfxe_c0;
 	if (DO_BIC(BIC_CPUGFX))
-		average.packages.pkg_both_core_gfxe_c0 += p->pkg_both_core_gfxe_c0;
+		average.packages->pkg_both_core_gfxe_c0 += p->pkg_both_core_gfxe_c0;
 
-	average.packages.pc2 += p->pc2;
+	average.packages->pc2 += p->pc2;
 	if (DO_BIC(BIC_Pkgpc3))
-		average.packages.pc3 += p->pc3;
+		average.packages->pc3 += p->pc3;
 	if (DO_BIC(BIC_Pkgpc6))
-		average.packages.pc6 += p->pc6;
+		average.packages->pc6 += p->pc6;
 	if (DO_BIC(BIC_Pkgpc7))
-		average.packages.pc7 += p->pc7;
-	average.packages.pc8 += p->pc8;
-	average.packages.pc9 += p->pc9;
-	average.packages.pc10 += p->pc10;
-	average.packages.die_c6 += p->die_c6;
+		average.packages->pc7 += p->pc7;
+	average.packages->pc8 += p->pc8;
+	average.packages->pc9 += p->pc9;
+	average.packages->pc10 += p->pc10;
+	average.packages->die_c6 += p->die_c6;
 
-	average.packages.cpu_lpi = p->cpu_lpi;
-	average.packages.sys_lpi = p->sys_lpi;
+	average.packages->cpu_lpi = p->cpu_lpi;
+	average.packages->sys_lpi = p->sys_lpi;
 
-	rapl_counter_accumulate(&average.packages.energy_pkg, &p->energy_pkg);
-	rapl_counter_accumulate(&average.packages.energy_dram, &p->energy_dram);
-	rapl_counter_accumulate(&average.packages.energy_cores, &p->energy_cores);
-	rapl_counter_accumulate(&average.packages.energy_gfx, &p->energy_gfx);
+	rapl_counter_accumulate(&average.packages->energy_pkg, &p->energy_pkg);
+	rapl_counter_accumulate(&average.packages->energy_dram, &p->energy_dram);
+	rapl_counter_accumulate(&average.packages->energy_cores, &p->energy_cores);
+	rapl_counter_accumulate(&average.packages->energy_gfx, &p->energy_gfx);
 
-	average.packages.gfx_rc6_ms = p->gfx_rc6_ms;
-	average.packages.uncore_mhz = p->uncore_mhz;
-	average.packages.gfx_mhz = p->gfx_mhz;
-	average.packages.gfx_act_mhz = p->gfx_act_mhz;
-	average.packages.sam_mc6_ms = p->sam_mc6_ms;
-	average.packages.sam_mhz = p->sam_mhz;
-	average.packages.sam_act_mhz = p->sam_act_mhz;
+	average.packages->gfx_rc6_ms = p->gfx_rc6_ms;
+	average.packages->uncore_mhz = p->uncore_mhz;
+	average.packages->gfx_mhz = p->gfx_mhz;
+	average.packages->gfx_act_mhz = p->gfx_act_mhz;
+	average.packages->sam_mc6_ms = p->sam_mc6_ms;
+	average.packages->sam_mhz = p->sam_mhz;
+	average.packages->sam_act_mhz = p->sam_act_mhz;
 
-	average.packages.pkg_temp_c = MAX(average.packages.pkg_temp_c, p->pkg_temp_c);
+	average.packages->pkg_temp_c = MAX(average.packages->pkg_temp_c, p->pkg_temp_c);
 
-	rapl_counter_accumulate(&average.packages.rapl_pkg_perf_status, &p->rapl_pkg_perf_status);
-	rapl_counter_accumulate(&average.packages.rapl_dram_perf_status, &p->rapl_dram_perf_status);
+	rapl_counter_accumulate(&average.packages->rapl_pkg_perf_status, &p->rapl_pkg_perf_status);
+	rapl_counter_accumulate(&average.packages->rapl_dram_perf_status, &p->rapl_dram_perf_status);
 
 	for (i = 0, mp = sys.pp; mp; i++, mp = mp->next) {
 		if ((mp->format == FORMAT_RAW) && (topo.num_packages == 0))
-			average.packages.counter[i] = p->counter[i];
+			average.packages->counter[i] = p->counter[i];
 		else
-			average.packages.counter[i] += p->counter[i];
+			average.packages->counter[i] += p->counter[i];
 	}
 
 	for (i = 0, pp = sys.perf_pp; pp; i++, pp = pp->next) {
 		if ((pp->format == FORMAT_RAW) && (topo.num_packages == 0))
-			average.packages.perf_counter[i] = p->perf_counter[i];
+			average.packages->perf_counter[i] = p->perf_counter[i];
 		else
-			average.packages.perf_counter[i] += p->perf_counter[i];
+			average.packages->perf_counter[i] += p->perf_counter[i];
 	}
 
 	for (i = 0, ppmt = sys.pmt_pp; ppmt; i++, ppmt = ppmt->next) {
-		average.packages.pmt_counter[i] += p->pmt_counter[i];
+		average.packages->pmt_counter[i] += p->pmt_counter[i];
 	}
 
 	return 0;
@@ -4322,117 +4322,117 @@ void compute_average(PER_THREAD_PARAMS)
 	struct perf_counter_info *pp;
 	struct pmt_counter *ppmt;
 
-	clear_counters(&average.threads, &average.cores, &average.packages);
+	clear_counters(average.threads, average.cores, average.packages);
 
 	for_all_cpus(sum_counters, t, c, p);
 
 	/* Use the global time delta for the average. */
-	average.threads.tv_delta = tv_delta;
+	average.threads->tv_delta = tv_delta;
 
-	average.threads.tsc /= topo.allowed_cpus;
-	average.threads.aperf /= topo.allowed_cpus;
-	average.threads.mperf /= topo.allowed_cpus;
-	average.threads.instr_count /= topo.allowed_cpus;
-	average.threads.c1 /= topo.allowed_cpus;
+	average.threads->tsc /= topo.allowed_cpus;
+	average.threads->aperf /= topo.allowed_cpus;
+	average.threads->mperf /= topo.allowed_cpus;
+	average.threads->instr_count /= topo.allowed_cpus;
+	average.threads->c1 /= topo.allowed_cpus;
 
-	if (average.threads.irq_count > 9999999)
+	if (average.threads->irq_count > 9999999)
 		sums_need_wide_columns = 1;
-	if (average.threads.nmi_count > 9999999)
+	if (average.threads->nmi_count > 9999999)
 		sums_need_wide_columns = 1;
 
-	average.cores.c3 /= topo.allowed_cores;
-	average.cores.c6 /= topo.allowed_cores;
-	average.cores.c7 /= topo.allowed_cores;
-	average.cores.mc6_us /= topo.allowed_cores;
+	average.cores->c3 /= topo.allowed_cores;
+	average.cores->c6 /= topo.allowed_cores;
+	average.cores->c7 /= topo.allowed_cores;
+	average.cores->mc6_us /= topo.allowed_cores;
 
 	if (DO_BIC(BIC_Totl_c0))
-		average.packages.pkg_wtd_core_c0 /= topo.allowed_packages;
+		average.packages->pkg_wtd_core_c0 /= topo.allowed_packages;
 	if (DO_BIC(BIC_Any_c0))
-		average.packages.pkg_any_core_c0 /= topo.allowed_packages;
+		average.packages->pkg_any_core_c0 /= topo.allowed_packages;
 	if (DO_BIC(BIC_GFX_c0))
-		average.packages.pkg_any_gfxe_c0 /= topo.allowed_packages;
+		average.packages->pkg_any_gfxe_c0 /= topo.allowed_packages;
 	if (DO_BIC(BIC_CPUGFX))
-		average.packages.pkg_both_core_gfxe_c0 /= topo.allowed_packages;
+		average.packages->pkg_both_core_gfxe_c0 /= topo.allowed_packages;
 
-	average.packages.pc2 /= topo.allowed_packages;
+	average.packages->pc2 /= topo.allowed_packages;
 	if (DO_BIC(BIC_Pkgpc3))
-		average.packages.pc3 /= topo.allowed_packages;
+		average.packages->pc3 /= topo.allowed_packages;
 	if (DO_BIC(BIC_Pkgpc6))
-		average.packages.pc6 /= topo.allowed_packages;
+		average.packages->pc6 /= topo.allowed_packages;
 	if (DO_BIC(BIC_Pkgpc7))
-		average.packages.pc7 /= topo.allowed_packages;
+		average.packages->pc7 /= topo.allowed_packages;
 
-	average.packages.pc8 /= topo.allowed_packages;
-	average.packages.pc9 /= topo.allowed_packages;
-	average.packages.pc10 /= topo.allowed_packages;
-	average.packages.die_c6 /= topo.allowed_packages;
+	average.packages->pc8 /= topo.allowed_packages;
+	average.packages->pc9 /= topo.allowed_packages;
+	average.packages->pc10 /= topo.allowed_packages;
+	average.packages->die_c6 /= topo.allowed_packages;
 
 	for (i = 0, mp = sys.tp; mp; i++, mp = mp->next) {
 		if (mp->format == FORMAT_RAW)
 			continue;
 		if (mp->type == COUNTER_ITEMS) {
-			if (average.threads.counter[i] > 9999999)
+			if (average.threads->counter[i] > 9999999)
 				sums_need_wide_columns = 1;
 			continue;
 		}
-		average.threads.counter[i] /= topo.allowed_cpus;
+		average.threads->counter[i] /= topo.allowed_cpus;
 	}
 	for (i = 0, mp = sys.cp; mp; i++, mp = mp->next) {
 		if (mp->format == FORMAT_RAW)
 			continue;
 		if (mp->type == COUNTER_ITEMS) {
-			if (average.cores.counter[i] > 9999999)
+			if (average.cores->counter[i] > 9999999)
 				sums_need_wide_columns = 1;
 		}
-		average.cores.counter[i] /= topo.allowed_cores;
+		average.cores->counter[i] /= topo.allowed_cores;
 	}
 	for (i = 0, mp = sys.pp; mp; i++, mp = mp->next) {
 		if (mp->format == FORMAT_RAW)
 			continue;
 		if (mp->type == COUNTER_ITEMS) {
-			if (average.packages.counter[i] > 9999999)
+			if (average.packages->counter[i] > 9999999)
 				sums_need_wide_columns = 1;
 		}
-		average.packages.counter[i] /= topo.allowed_packages;
+		average.packages->counter[i] /= topo.allowed_packages;
 	}
 
 	for (i = 0, pp = sys.perf_tp; pp; i++, pp = pp->next) {
 		if (pp->format == FORMAT_RAW)
 			continue;
 		if (pp->type == COUNTER_ITEMS) {
-			if (average.threads.perf_counter[i] > 9999999)
+			if (average.threads->perf_counter[i] > 9999999)
 				sums_need_wide_columns = 1;
 			continue;
 		}
-		average.threads.perf_counter[i] /= topo.allowed_cpus;
+		average.threads->perf_counter[i] /= topo.allowed_cpus;
 	}
 	for (i = 0, pp = sys.perf_cp; pp; i++, pp = pp->next) {
 		if (pp->format == FORMAT_RAW)
 			continue;
 		if (pp->type == COUNTER_ITEMS) {
-			if (average.cores.perf_counter[i] > 9999999)
+			if (average.cores->perf_counter[i] > 9999999)
 				sums_need_wide_columns = 1;
 		}
-		average.cores.perf_counter[i] /= topo.allowed_cores;
+		average.cores->perf_counter[i] /= topo.allowed_cores;
 	}
 	for (i = 0, pp = sys.perf_pp; pp; i++, pp = pp->next) {
 		if (pp->format == FORMAT_RAW)
 			continue;
 		if (pp->type == COUNTER_ITEMS) {
-			if (average.packages.perf_counter[i] > 9999999)
+			if (average.packages->perf_counter[i] > 9999999)
 				sums_need_wide_columns = 1;
 		}
-		average.packages.perf_counter[i] /= topo.allowed_packages;
+		average.packages->perf_counter[i] /= topo.allowed_packages;
 	}
 
 	for (i = 0, ppmt = sys.pmt_tp; ppmt; i++, ppmt = ppmt->next) {
-		average.threads.pmt_counter[i] /= topo.allowed_cpus;
+		average.threads->pmt_counter[i] /= topo.allowed_cpus;
 	}
 	for (i = 0, ppmt = sys.pmt_cp; ppmt; i++, ppmt = ppmt->next) {
-		average.cores.pmt_counter[i] /= topo.allowed_cores;
+		average.cores->pmt_counter[i] /= topo.allowed_cores;
 	}
 	for (i = 0, ppmt = sys.pmt_pp; ppmt; i++, ppmt = ppmt->next) {
-		average.packages.pmt_counter[i] /= topo.allowed_packages;
+		average.packages->pmt_counter[i] /= topo.allowed_packages;
 	}
 }
 
@@ -9687,6 +9687,24 @@ void topology_probe(bool startup)
 
 }
 
+void allocate_counters_1(struct thread_data **t, struct core_data **c, struct pkg_data **p)
+{
+	*t = calloc(1, sizeof(struct thread_data));
+	if (*t == NULL)
+		goto error;
+
+	*c = calloc(1, sizeof(struct core_data));
+	if (*c == NULL)
+		goto error;
+
+	*p = calloc(1, sizeof(struct pkg_data));
+	if (*p == NULL)
+		goto error;
+
+	return;
+error:
+	err(1, "calloc counters_1");
+}
 void allocate_counters(struct thread_data **t, struct core_data **c, struct pkg_data **p)
 {
 	int i;
@@ -9813,6 +9831,7 @@ void setup_all_buffers(bool startup)
 	topology_probe(startup);
 	allocate_irq_buffers();
 	allocate_fd_percpu();
+	allocate_counters_1(&average.threads, &average.cores, &average.packages);
 	allocate_counters(&thread_even, &core_even, &package_even);
 	allocate_counters(&thread_odd, &core_odd, &package_odd);
 	allocate_output_buffer();
-- 
2.45.2


