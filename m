Return-Path: <linux-pm+bounces-21232-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49850A24F1E
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 18:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEAF51883D11
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 17:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722BF1FAC4E;
	Sun,  2 Feb 2025 17:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4Vky6yI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB7E1F8917
	for <linux-pm@vger.kernel.org>; Sun,  2 Feb 2025 17:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738516389; cv=none; b=mXm4bmTVIwzkITF7/6eyn93Tmjt4P5hz8Z0U4tOAYRomeWzPM4qjh9NUS5LI0N8v9PrUBEC7u9EgwgCSrCvaUisocU6ln0xsMRCY98hwz8LUlAn9lLthbz+8GTnkdnogN5KzDSd0IrVVwHFvc3nfDlIa5f9ggGrZCgbi4bERnts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738516389; c=relaxed/simple;
	bh=JxLS3TSJ4YczXSb/1IUkAJsWu0Z50hEAkvoyXf+p+Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=od0Os9bRTaQB8SE9bwZpUFpkF5TlVWj0LS5UfE+rMIeVV9DBrgeQPKsDNbp/MZzhkL8G5q33uJsCUWXp0MabrqmJ/xTHtSItC/8aOmZgHPxhSVi8brgjDefqKOwXQgBoogDYaUyS2quwETn5TH9TVaFTjgMsA4Yx+hX1/BfPJ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4Vky6yI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA661C4CED1;
	Sun,  2 Feb 2025 17:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738516388;
	bh=JxLS3TSJ4YczXSb/1IUkAJsWu0Z50hEAkvoyXf+p+Kk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=F4Vky6yIoDv9CYxlianX7lm4r/keUhLRDGqDpdF2TS0W9VIKY+GyiM0TXRTkCNWki
	 v2mQvKRVKZO8waUbzMKGTByM+w/dDbPwYzG8Cpq9Dfg+Kq5YKGXyBaoP7S36iN714A
	 d5fQer61A82YI0EnlSmLMQwCYl+leT6PxTmerCAm6KUpNtHhrMA3spr7EkumpSTanF
	 MwX7yod8ZBLCbXE2Ns9hegbuF0td3o6yo5iLpalBkiWfzTgLqKhvyzujJLv1fZRwvE
	 Kdd5MicCS3zWyA41Ax8UjpyPWUnNPeS+E0EbTOFQGHZDFI+y9hHLFkOSo9GVN8svY1
	 /28z4TKoOTgqg==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>,
	Artem Bityutskiy <artem.bityutskiy@intel.com>
Subject: [PATCH 09/25] tools/power turbostat: Add an NMI column
Date: Sun,  2 Feb 2025 11:09:25 -0600
Message-ID: <22a835282b6240f38097f479ae2194bbeb0181e4.1738515889.git.len.brown@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e8a99af68c068865dbac7f3330e97bf8e96edf33.1738515889.git.len.brown@intel.com>
References: <e8a99af68c068865dbac7f3330e97bf8e96edf33.1738515889.git.len.brown@intel.com>
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

Add an NMI column, a proper sub-set of the IRQ column.

It would be preferable if the kernel exported
/sys/kernel/irq/NMI/per_cpu_count.

But since we are already forced to parse /proc/interrupts,
noticing which row is the NMI is simple enough.

Suggested-by: Artem Bityutskiy <artem.bityutskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 54 ++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 7a10e51a1349..2620ed000ad0 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -202,6 +202,7 @@ struct msr_counter bic[] = {
 	{ 0x0, "Die%c6", NULL, 0, 0, 0, NULL, 0 },
 	{ 0x0, "SysWatt", NULL, 0, 0, 0, NULL, 0 },
 	{ 0x0, "Sys_J", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "NMI", NULL, 0, 0, 0, NULL, 0 },
 };
 
 #define MAX_BIC (sizeof(bic) / sizeof(struct msr_counter))
@@ -266,12 +267,13 @@ struct msr_counter bic[] = {
 #define	BIC_Diec6		(1ULL << 58)
 #define	BIC_SysWatt		(1ULL << 59)
 #define	BIC_Sys_J		(1ULL << 60)
+#define	BIC_NMI			(1ULL << 61)
 
 #define BIC_TOPOLOGY (BIC_Package | BIC_Node | BIC_CoreCnt | BIC_PkgCnt | BIC_Core | BIC_CPU | BIC_Die )
 #define BIC_THERMAL_PWR ( BIC_CoreTmp | BIC_PkgTmp | BIC_PkgWatt | BIC_CorWatt | BIC_GFXWatt | BIC_RAMWatt | BIC_PKG__ | BIC_RAM__)
 #define BIC_FREQUENCY (BIC_Avg_MHz | BIC_Busy | BIC_Bzy_MHz | BIC_TSC_MHz | BIC_GFXMHz | BIC_GFXACTMHz | BIC_SAMMHz | BIC_SAMACTMHz | BIC_UNCORE_MHZ)
 #define BIC_IDLE (BIC_Busy | BIC_sysfs | BIC_CPU_c1 | BIC_CPU_c3 | BIC_CPU_c6 | BIC_CPU_c7 | BIC_GFX_rc6 | BIC_Pkgpc2 | BIC_Pkgpc3 | BIC_Pkgpc6 | BIC_Pkgpc7 | BIC_Pkgpc8 | BIC_Pkgpc9 | BIC_Pkgpc10 | BIC_CPU_LPI | BIC_SYS_LPI | BIC_Mod_c6 | BIC_Totl_c0 | BIC_Any_c0 | BIC_GFX_c0 | BIC_CPUGFX | BIC_SAM_mc6 | BIC_Diec6)
-#define BIC_OTHER ( BIC_IRQ | BIC_SMI | BIC_ThreadC | BIC_CoreTmp | BIC_IPC)
+#define BIC_OTHER ( BIC_IRQ | BIC_NMI | BIC_SMI | BIC_ThreadC | BIC_CoreTmp | BIC_IPC)
 
 #define BIC_DISABLED_BY_DEFAULT	(BIC_USEC | BIC_TOD | BIC_APIC | BIC_X2APIC | BIC_SysWatt | BIC_Sys_J)
 
@@ -1628,6 +1630,7 @@ struct thread_data {
 	unsigned long long c1;
 	unsigned long long instr_count;
 	unsigned long long irq_count;
+	unsigned long long nmi_count;
 	unsigned int smi_count;
 	unsigned int cpu_id;
 	unsigned int apic_id;
@@ -1934,6 +1937,7 @@ struct timeval tv_even, tv_odd, tv_delta;
 
 int *irq_column_2_cpu;		/* /proc/interrupts column numbers */
 int *irqs_per_cpu;		/* indexed by cpu_num */
+int *nmi_per_cpu;		/* indexed by cpu_num */
 
 void setup_all_buffers(bool startup);
 
@@ -2319,6 +2323,12 @@ void print_header(char *delim)
 		else
 			outp += sprintf(outp, "%sIRQ", (printed++ ? delim : ""));
 	}
+	if (DO_BIC(BIC_NMI)) {
+		if (sums_need_wide_columns)
+			outp += sprintf(outp, "%s     NMI", (printed++ ? delim : ""));
+		else
+			outp += sprintf(outp, "%sNMI", (printed++ ? delim : ""));
+	}
 
 	if (DO_BIC(BIC_SMI))
 		outp += sprintf(outp, "%sSMI", (printed++ ? delim : ""));
@@ -2605,6 +2615,8 @@ int dump_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p
 
 		if (DO_BIC(BIC_IRQ))
 			outp += sprintf(outp, "IRQ: %lld\n", t->irq_count);
+		if (DO_BIC(BIC_NMI))
+			outp += sprintf(outp, "IRQ: %lld\n", t->nmi_count);
 		if (DO_BIC(BIC_SMI))
 			outp += sprintf(outp, "SMI: %d\n", t->smi_count);
 
@@ -2824,6 +2836,14 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 			outp += sprintf(outp, "%s%lld", (printed++ ? delim : ""), t->irq_count);
 	}
 
+	/* NMI */
+	if (DO_BIC(BIC_NMI)) {
+		if (sums_need_wide_columns)
+			outp += sprintf(outp, "%s%8lld", (printed++ ? delim : ""), t->nmi_count);
+		else
+			outp += sprintf(outp, "%s%lld", (printed++ ? delim : ""), t->nmi_count);
+	}
+
 	/* SMI */
 	if (DO_BIC(BIC_SMI))
 		outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), t->smi_count);
@@ -3439,6 +3459,9 @@ int delta_thread(struct thread_data *new, struct thread_data *old, struct core_d
 	if (DO_BIC(BIC_IRQ))
 		old->irq_count = new->irq_count - old->irq_count;
 
+	if (DO_BIC(BIC_NMI))
+		old->nmi_count = new->nmi_count - old->nmi_count;
+
 	if (DO_BIC(BIC_SMI))
 		old->smi_count = new->smi_count - old->smi_count;
 
@@ -3519,6 +3542,7 @@ void clear_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 	t->instr_count = 0;
 
 	t->irq_count = 0;
+	t->nmi_count = 0;
 	t->smi_count = 0;
 
 	c->c3 = 0;
@@ -3623,6 +3647,7 @@ int sum_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	average.threads.instr_count += t->instr_count;
 
 	average.threads.irq_count += t->irq_count;
+	average.threads.nmi_count += t->nmi_count;
 	average.threads.smi_count += t->smi_count;
 
 	for (i = 0, mp = sys.tp; mp; i++, mp = mp->next) {
@@ -3764,6 +3789,9 @@ void compute_average(struct thread_data *t, struct core_data *c, struct pkg_data
 
 	if (average.threads.irq_count > 9999999)
 		sums_need_wide_columns = 1;
+	if (average.threads.nmi_count > 9999999)
+		sums_need_wide_columns = 1;
+
 
 	average.cores.c3 /= topo.allowed_cores;
 	average.cores.c6 /= topo.allowed_cores;
@@ -4620,6 +4648,8 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 
 	if (DO_BIC(BIC_IRQ))
 		t->irq_count = irqs_per_cpu[cpu];
+	if (DO_BIC(BIC_NMI))
+		t->nmi_count = nmi_per_cpu[cpu];
 
 	get_cstate_counters(cpu, t, c, p);
 
@@ -5365,6 +5395,7 @@ void free_all_buffers(void)
 
 	free(irq_column_2_cpu);
 	free(irqs_per_cpu);
+	free(nmi_per_cpu);
 
 	for (i = 0; i <= topo.max_cpu_num; ++i) {
 		if (cpus[i].put_ids)
@@ -5821,31 +5852,37 @@ int snapshot_proc_interrupts(void)
 
 		irq_column_2_cpu[column] = cpu_number;
 		irqs_per_cpu[cpu_number] = 0;
+		nmi_per_cpu[cpu_number] = 0;
 	}
 
 	/* read /proc/interrupt count lines and sum up irqs per cpu */
 	while (1) {
 		int column;
 		char buf[64];
+		int this_row_is_nmi = 0;
 
-		retval = fscanf(fp, " %s:", buf);	/* flush irq# "N:" */
+		retval = fscanf(fp, " %s:", buf);	/* irq# "N:" */
 		if (retval != 1)
 			break;
 
+		if (strncmp(buf, "NMI", strlen("NMI")) == 0)
+			this_row_is_nmi = 1;
+
 		/* read the count per cpu */
 		for (column = 0; column < topo.num_cpus; ++column) {
 
 			int cpu_number, irq_count;
 
 			retval = fscanf(fp, " %d", &irq_count);
+
 			if (retval != 1)
 				break;
 
 			cpu_number = irq_column_2_cpu[column];
 			irqs_per_cpu[cpu_number] += irq_count;
-
+			if (this_row_is_nmi)
+				nmi_per_cpu[cpu_number] += irq_count;
 		}
-
 		while (getc(fp) != '\n') ;	/* flush interrupt description */
 
 	}
@@ -5942,7 +5979,7 @@ int snapshot_sys_lpi_us(void)
  */
 int snapshot_proc_sysfs_files(void)
 {
-	if (DO_BIC(BIC_IRQ))
+	if (DO_BIC(BIC_IRQ) || DO_BIC(BIC_NMI))
 		if (snapshot_proc_interrupts())
 			return 1;
 
@@ -8263,6 +8300,7 @@ void process_cpuid()
 		aperf_mperf_multiplier = platform->need_perf_multiplier ? 1024 : 1;
 
 	BIC_PRESENT(BIC_IRQ);
+	BIC_PRESENT(BIC_NMI);
 	BIC_PRESENT(BIC_TSC_MHz);
 }
 
@@ -8613,7 +8651,11 @@ void allocate_irq_buffers(void)
 
 	irqs_per_cpu = calloc(topo.max_cpu_num + 1, sizeof(int));
 	if (irqs_per_cpu == NULL)
-		err(-1, "calloc %d", topo.max_cpu_num + 1);
+		err(-1, "calloc %d IRQ", topo.max_cpu_num + 1);
+
+	nmi_per_cpu = calloc(topo.max_cpu_num + 1, sizeof(int));
+	if (nmi_per_cpu == NULL)
+		err(-1, "calloc %d NMI", topo.max_cpu_num + 1);
 }
 
 int update_topo(struct thread_data *t, struct core_data *c, struct pkg_data *p)
-- 
2.43.0


