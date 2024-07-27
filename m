Return-Path: <linux-pm+bounces-11486-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE9E93E08C
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 20:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0F991C20DC4
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 18:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE19618757E;
	Sat, 27 Jul 2024 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecDqKEoT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD19187568
	for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 18:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722104823; cv=none; b=HFOWLmqwEN/eiJ7WbLgCScT581bo498YotMXdXdRlTGBgYw8wsNuebauQA882ad9aVRMbY/fzpCY3mq+UlkzJj9np1Z3+qkc5GLTuoMIX/tAv71AaEo2gdDMRpOQAT8BAluWf+tEZlkLVCVv0U8D1mkpIASHA86liIIivpoYDek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722104823; c=relaxed/simple;
	bh=KRdAzCQyX7O7E7UMJ9imo6MmScl7wlqBhVVNHB+cyxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4OB30Py+a2MVESpQeSaQUOlLADl2/GtdorZmlJNoDKHPE1+3DgzmmF9yTPjNf4VzftfO7Cpw0T6252fOesXxP9yIsiP7EigZ8cJ+rYE8yhMEwWp1y3mulk0fDdjVM52lg0j/5+4iPZQkJm5khfjus8Txg9AuaYxBFfhVWGBjfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecDqKEoT; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2610623f445so1547820fac.1
        for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 11:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722104819; x=1722709619; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JfWUR1aU7RtsDp1AIqO9Co4TSbMNTX8j5FoUnkD6/ws=;
        b=ecDqKEoTaqrStuuXZeyJZTvYzErNTDAaGDxrOmuluanpj6jp04KQncoGJyAt87vusU
         RO/J6Ev/8YIwBbclkLucDdtihgyiRRHetcbq1mW4NiRdnr/oRYVxt6GQJGnkIrcwj7hI
         ERz54KD2Artmb7HzhLPEAc6dRg7H7qL1CmAzCjYAeoqo+coqEyfBBLdzZBxVor+1qTP7
         4KS+NSGdro+wBdo/Y5uZGiAimZ6tokzRtO4dRMNC9LHdmFs4y99d5eZhrZHaDHmsdVi0
         ta3e6bm0O5/40Z7nx8yUAsSbsFoJSiBQxcYmdZvcYWXH21gyrB8hwak3xSWF7CzAyrS9
         6GZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722104819; x=1722709619;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JfWUR1aU7RtsDp1AIqO9Co4TSbMNTX8j5FoUnkD6/ws=;
        b=E3ca8BckiOh61TqeXeHqX09YdWdzuhWwIh0upk3tPdNs3TWD4+FYPHv+bcYKjJ90Nh
         7ZHFgspDsCusgtQ/lmA2LBBIBt+xjfwGX8/qswkbvGUezNWOi8WnfkmTBfoFop4VkyKK
         693d/KtSyH4NCyijgw3X97tjVsXidpxbw3FOgpf/yqhE50qUuUU3tqIDLqqQ2HnATVyS
         qJxcD67YyAct8gQvXghlYOARZ+edC0KL49NeWowjspKa1yaCHDhU75LOwW12pGh94d9s
         T8UX1f43JEHh/3q4oL0Lh4Jre/T4+rMnjHzAMSbPOxGrEuhSnhf0rRqcE80TJgF1gWSI
         jJ3Q==
X-Gm-Message-State: AOJu0Yw1XsBYSZMgmo+5x9S4+RUAdRNU42x+VuJL9tXy3rZSOB6VFA3x
	CE39YkS3E1TW1Eu5bVnAntSGQgStSFJTaG1UuDWrEgX7Y2VBs7zzMP7qfw==
X-Google-Smtp-Source: AGHT+IG0YgnjY/U5n5fn6bwhJhZUcKXIrxWXq+2SH0Mqhl7hSOFmYknfKo6dumK7HOjByBWjvKuqyQ==
X-Received: by 2002:a05:6870:224c:b0:260:df77:2484 with SMTP id 586e51a60fabf-267d4d38357mr3670636fac.13.1722104818900;
        Sat, 27 Jul 2024 11:26:58 -0700 (PDT)
Received: from lenb-intel-nuc8i7hvkva.. (h75-100-80-185.cntcnh.broadband.dynamic.tds.net. [75.100.80.185])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7093050a35fsm1314136a34.6.2024.07.27.11.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 11:26:58 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 14/18] tools/power turbostat: Add early support for PMT counters
Date: Sat, 27 Jul 2024 14:23:40 -0400
Message-ID: <f0e4ed752fda6997b41917c94a5478b340178001.1722019621.git.len.brown@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1b3bf0747d4f1a963e59c26e602868bdce195318.1722019621.git.len.brown@intel.com>
References: <1b3bf0747d4f1a963e59c26e602868bdce195318.1722019621.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>

Allows users to read Intel PMT (Platform Monitoring Technology)
counters, providing interface similar to one used to add MSR and perf
counters. Because PMT is exposed as a raw MMIO range, without metadata,
user has to supply the necessary information to find and correctly
display the requested counter.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 768 +++++++++++++++++++++++++-
 1 file changed, 766 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 86bbea7d8e57..c9fdfb074ce9 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -44,6 +44,7 @@
 #include <sys/stat.h>
 #include <sys/select.h>
 #include <sys/resource.h>
+#include <sys/mman.h>
 #include <fcntl.h>
 #include <signal.h>
 #include <sys/time.h>
@@ -1082,6 +1083,9 @@ size_t cpu_present_setsize, cpu_effective_setsize, cpu_allowed_setsize, cpu_affi
 #define MAX_ADDED_THREAD_COUNTERS 24
 #define MAX_ADDED_CORE_COUNTERS 8
 #define MAX_ADDED_PACKAGE_COUNTERS 16
+#define PMT_MAX_ADDED_THREAD_COUNTERS 24
+#define PMT_MAX_ADDED_CORE_COUNTERS 8
+#define PMT_MAX_ADDED_PACKAGE_COUNTERS 16
 #define BITMASK_SIZE 32
 
 #define ZERO_ARRAY(arr) (memset(arr, 0, sizeof(arr)) + __must_be_array(arr))
@@ -1466,6 +1470,100 @@ static struct msr_counter_arch_info msr_counter_arch_infos[] = {
 	},
 };
 
+/* Can be redefined when compiling, useful for testing. */
+#ifndef SYSFS_TELEM_PATH
+#define SYSFS_TELEM_PATH "/sys/class/intel_pmt"
+#endif
+
+#define PMT_COUNTER_NAME_SIZE_BYTES      16
+#define PMT_COUNTER_TYPE_NAME_SIZE_BYTES 32
+
+struct pmt_mmio {
+	struct pmt_mmio *next;
+
+	unsigned int guid;
+	unsigned int size;
+
+	/* Base pointer to the mmaped memory. */
+	void *mmio_base;
+
+	/*
+	 * Offset to be applied to the mmio_base
+	 * to get the beginning of the PMT counters for given GUID.
+	 */
+	unsigned long pmt_offset;
+} *pmt_mmios;
+
+enum pmt_datatype {
+	PMT_TYPE_RAW,
+};
+
+struct pmt_domain_info {
+	/*
+	 * Pointer to the MMIO obtained by applying a counter offset
+	 * to the mmio_base of the mmaped region for the given GUID.
+	 *
+	 * This is where to read the raw value of the counter from.
+	 */
+	unsigned long *pcounter;
+};
+
+struct pmt_counter {
+	struct pmt_counter *next;
+
+	/* PMT metadata */
+	char name[PMT_COUNTER_NAME_SIZE_BYTES];
+	enum pmt_datatype type;
+	enum counter_scope scope;
+	unsigned int lsb;
+	unsigned int msb;
+
+	/* BIC-like metadata */
+	enum counter_format format;
+
+	unsigned int num_domains;
+	struct pmt_domain_info *domains;
+};
+
+unsigned int pmt_counter_get_width(const struct pmt_counter *p)
+{
+	return (p->msb - p->lsb)+1;
+}
+
+void pmt_counter_resize_(struct pmt_counter *pcounter, unsigned int new_size)
+{
+	struct pmt_domain_info *new_mem;
+
+	new_mem = (struct pmt_domain_info*) reallocarray(pcounter->domains, new_size, sizeof(*pcounter->domains));
+	if (!new_mem) {
+		fprintf(stderr, "%s: failed to allocate memory for PMT counters\n", __func__);
+		exit(1);
+	}
+
+	/* Zero initialize just allocated memory. */
+	const size_t num_new_domains = new_size - pcounter->num_domains;
+
+	memset(&new_mem[pcounter->num_domains], 0, num_new_domains * sizeof(*pcounter->domains));
+
+	pcounter->num_domains = new_size;
+	pcounter->domains = new_mem;
+}
+
+void pmt_counter_resize(struct pmt_counter *pcounter, unsigned int new_size)
+{
+	/*
+	 * Allocate more memory ahead of time.
+	 *
+	 * Always allocate space for at least 8 elements
+	 * and double the size when growing.
+	 */
+	if (new_size < 8)
+		new_size = 8;
+	new_size = MAX(new_size, pcounter->num_domains*2);
+
+	pmt_counter_resize_(pcounter, new_size);
+}
+
 struct thread_data {
 	struct timeval tv_begin;
 	struct timeval tv_end;
@@ -1484,6 +1582,7 @@ struct thread_data {
 	bool is_atom;
 	unsigned long long counter[MAX_ADDED_THREAD_COUNTERS];
 	unsigned long long perf_counter[MAX_ADDED_THREAD_COUNTERS];
+	unsigned long long pmt_counter[PMT_MAX_ADDED_THREAD_COUNTERS];
 } *thread_even, *thread_odd;
 
 struct core_data {
@@ -1498,6 +1597,7 @@ struct core_data {
 	unsigned long long core_throt_cnt;
 	unsigned long long counter[MAX_ADDED_CORE_COUNTERS];
 	unsigned long long perf_counter[MAX_ADDED_CORE_COUNTERS];
+	unsigned long long pmt_counter[PMT_MAX_ADDED_CORE_COUNTERS];
 } *core_even, *core_odd;
 
 struct pkg_data {
@@ -1532,6 +1632,7 @@ struct pkg_data {
 	unsigned int uncore_mhz;
 	unsigned long long counter[MAX_ADDED_PACKAGE_COUNTERS];
 	unsigned long long perf_counter[MAX_ADDED_PACKAGE_COUNTERS];
+	unsigned long long pmt_counter[PMT_MAX_ADDED_PACKAGE_COUNTERS];
 } *package_even, *package_odd;
 
 #define ODD_COUNTERS thread_odd, core_odd, package_odd
@@ -1681,6 +1782,10 @@ struct sys_counters {
 	struct perf_counter_info *perf_tp;
 	struct perf_counter_info *perf_cp;
 	struct perf_counter_info *perf_pp;
+
+	struct pmt_counter *pmt_tp;
+	struct pmt_counter *pmt_cp;
+	struct pmt_counter *pmt_pp;
 } sys;
 
 static size_t free_msr_counters_(struct msr_counter **pp)
@@ -1981,6 +2086,7 @@ void help(void)
 		"  -a, --add	add a counter\n"
 		"		  eg. --add msr0x10,u64,cpu,delta,MY_TSC\n"
 		"		  eg. --add perf/cstate_pkg/c2-residency,package,delta,percent,perfPC2\n"
+		"		  eg. --add pmt,name=XTAL,type=raw,domain=package0,offset=0,lsb=0,msb=63,guid=0x1a067102\n"
 		"  -c, --cpu	cpu-set	limit output to summary plus cpu-set:\n"
 		"		  {core | package | j,k,l..m,n-p }\n"
 		"  -d, --debug	displays usec, Time_Of_Day_Seconds and more debugging\n"
@@ -2092,6 +2198,7 @@ void print_header(char *delim)
 {
 	struct msr_counter *mp;
 	struct perf_counter_info *pp;
+	struct pmt_counter *ppmt;
 	int printed = 0;
 
 	if (DO_BIC(BIC_USEC))
@@ -2164,6 +2271,21 @@ void print_header(char *delim)
 		}
 	}
 
+	ppmt = sys.pmt_tp;
+	while (ppmt) {
+		switch(ppmt->type) {
+		case PMT_TYPE_RAW:
+			if (pmt_counter_get_width(ppmt) <= 32)
+				outp += sprintf(outp, "%s%10.10s", (printed++ ? delim : ""), ppmt->name);
+			else
+				outp += sprintf(outp, "%s%18.18s", (printed++ ? delim : ""), ppmt->name);
+
+			break;
+		}
+
+		ppmt = ppmt->next;
+	}
+
 	if (DO_BIC(BIC_CPU_c1))
 		outp += sprintf(outp, "%sCPU%%c1", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_CPU_c3))
@@ -2219,6 +2341,21 @@ void print_header(char *delim)
 		}
 	}
 
+	ppmt = sys.pmt_cp;
+	while (ppmt) {
+		switch(ppmt->type) {
+		case PMT_TYPE_RAW:
+			if (pmt_counter_get_width(ppmt) <= 32)
+				outp += sprintf(outp, "%s%10.10s", (printed++ ? delim : ""), ppmt->name);
+			else
+				outp += sprintf(outp, "%s%18.18s", (printed++ ? delim : ""), ppmt->name);
+
+			break;
+		}
+
+		ppmt = ppmt->next;
+	}
+
 	if (DO_BIC(BIC_PkgTmp))
 		outp += sprintf(outp, "%sPkgTmp", (printed++ ? delim : ""));
 
@@ -2329,6 +2466,21 @@ void print_header(char *delim)
 		}
 	}
 
+	ppmt = sys.pmt_pp;
+	while (ppmt) {
+		switch(ppmt->type) {
+		case PMT_TYPE_RAW:
+			if (pmt_counter_get_width(ppmt) <= 32)
+				outp += sprintf(outp, "%s%10.10s", (printed++ ? delim : ""), ppmt->name);
+			else
+				outp += sprintf(outp, "%s%18.18s", (printed++ ? delim : ""), ppmt->name);
+
+			break;
+		}
+
+		ppmt = ppmt->next;
+	}
+
 	outp += sprintf(outp, "\n");
 }
 
@@ -2450,6 +2602,7 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 	int i;
 	struct msr_counter *mp;
 	struct perf_counter_info *pp;
+	struct pmt_counter *ppmt;
 	char *delim = "\t";
 	int printed = 0;
 
@@ -2612,6 +2765,19 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 		}
 	}
 
+	for (i = 0, ppmt = sys.pmt_tp; ppmt; i++, ppmt = ppmt->next) {
+		switch (ppmt->type) {
+		case PMT_TYPE_RAW:
+			if (pmt_counter_get_width(ppmt) <= 32)
+				outp += sprintf(outp, "%s0x%08x", (printed++ ? delim : ""),
+						(unsigned int)t->pmt_counter[i]);
+			else
+				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), t->pmt_counter[i]);
+
+			break;
+		}
+	}
+
 	/* C1 */
 	if (DO_BIC(BIC_CPU_c1))
 		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * t->c1 / tsc);
@@ -2673,6 +2839,19 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 		}
 	}
 
+	for (i = 0, ppmt = sys.pmt_cp; ppmt; i++, ppmt = ppmt->next) {
+		switch (ppmt->type) {
+		case PMT_TYPE_RAW:
+			if (pmt_counter_get_width(ppmt) <= 32)
+				outp += sprintf(outp, "%s0x%08x", (printed++ ? delim : ""),
+						(unsigned int)c->pmt_counter[i]);
+			else
+				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), c->pmt_counter[i]);
+
+			break;
+		}
+	}
+
 	fmt8 = "%s%.2f";
 
 	if (DO_BIC(BIC_CorWatt) && platform->has_per_core_rapl)
@@ -2842,9 +3021,23 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 				outp += sprintf(outp, "%s%lld", (printed++ ? delim : ""), p->perf_counter[i]);
 		} else if (pp->format == FORMAT_PERCENT) {
 			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->perf_counter[i] / tsc);
-		} else if (pp->type == COUNTER_K2M)
+		} else if (pp->type == COUNTER_K2M) {
 			outp +=
 			    sprintf(outp, "%s%d", (printed++ ? delim : ""), (unsigned int)p->perf_counter[i] / 1000);
+		}
+	}
+
+	for (i = 0, ppmt = sys.pmt_pp; ppmt; i++, ppmt = ppmt->next) {
+		switch (ppmt->type) {
+		case PMT_TYPE_RAW:
+			if (pmt_counter_get_width(ppmt) <= 32)
+				outp += sprintf(outp, "%s0x%08x", (printed++ ? delim : ""),
+						(unsigned int)p->pmt_counter[i]);
+			else
+				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), p->pmt_counter[i]);
+
+			break;
+		}
 	}
 
 done:
@@ -2901,6 +3094,7 @@ int delta_package(struct pkg_data *new, struct pkg_data *old)
 	int i;
 	struct msr_counter *mp;
 	struct perf_counter_info *pp;
+	struct pmt_counter *ppmt;
 
 	if (DO_BIC(BIC_Totl_c0))
 		old->pkg_wtd_core_c0 = new->pkg_wtd_core_c0 - old->pkg_wtd_core_c0;
@@ -2970,6 +3164,13 @@ int delta_package(struct pkg_data *new, struct pkg_data *old)
 			old->perf_counter[i] = new->perf_counter[i] - old->perf_counter[i];
 	}
 
+	for (i = 0, ppmt = sys.pmt_pp; ppmt; i++, ppmt = ppmt->next) {
+		if (ppmt->format == FORMAT_RAW)
+			old->pmt_counter[i] = new->pmt_counter[i];
+		else
+			old->pmt_counter[i] = new->pmt_counter[i] - old->pmt_counter[i];
+	}
+
 	return 0;
 }
 
@@ -2978,6 +3179,7 @@ void delta_core(struct core_data *new, struct core_data *old)
 	int i;
 	struct msr_counter *mp;
 	struct perf_counter_info *pp;
+	struct pmt_counter *ppmt;
 
 	old->c3 = new->c3 - old->c3;
 	old->c6 = new->c6 - old->c6;
@@ -3001,6 +3203,13 @@ void delta_core(struct core_data *new, struct core_data *old)
 		else
 			old->perf_counter[i] = new->perf_counter[i] - old->perf_counter[i];
 	}
+
+	for (i = 0, ppmt = sys.pmt_cp; ppmt; i++, ppmt = ppmt->next) {
+		if (ppmt->format == FORMAT_RAW)
+			old->pmt_counter[i] = new->pmt_counter[i];
+		else
+			old->pmt_counter[i] = new->pmt_counter[i] - old->pmt_counter[i];
+	}
 }
 
 int soft_c1_residency_display(int bic)
@@ -3019,6 +3228,7 @@ int delta_thread(struct thread_data *new, struct thread_data *old, struct core_d
 	int i;
 	struct msr_counter *mp;
 	struct perf_counter_info *pp;
+	struct pmt_counter *ppmt;
 
 	/* we run cpuid just the 1st time, copy the results */
 	if (DO_BIC(BIC_APIC))
@@ -3105,6 +3315,13 @@ int delta_thread(struct thread_data *new, struct thread_data *old, struct core_d
 			old->perf_counter[i] = new->perf_counter[i] - old->perf_counter[i];
 	}
 
+	for (i = 0, ppmt = sys.pmt_tp; ppmt; i++, ppmt = ppmt->next) {
+		if (ppmt->format == FORMAT_RAW)
+			old->pmt_counter[i] = new->pmt_counter[i];
+		else
+			old->pmt_counter[i] = new->pmt_counter[i] - old->pmt_counter[i];
+	}
+
 	return 0;
 }
 
@@ -3211,6 +3428,10 @@ void clear_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 	memset(&t->perf_counter[0], 0, sizeof(t->perf_counter));
 	memset(&c->perf_counter[0], 0, sizeof(c->perf_counter));
 	memset(&p->perf_counter[0], 0, sizeof(p->perf_counter));
+
+	memset(&t->pmt_counter[0], 0, ARRAY_SIZE(t->pmt_counter));
+	memset(&c->pmt_counter[0], 0, ARRAY_SIZE(c->pmt_counter));
+	memset(&p->pmt_counter[0], 0, ARRAY_SIZE(p->pmt_counter));
 }
 
 void rapl_counter_accumulate(struct rapl_counter *dst, const struct rapl_counter *src)
@@ -3232,6 +3453,7 @@ int sum_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	int i;
 	struct msr_counter *mp;
 	struct perf_counter_info *pp;
+	struct pmt_counter *ppmt;
 
 	/* copy un-changing apic_id's */
 	if (DO_BIC(BIC_APIC))
@@ -3268,6 +3490,10 @@ int sum_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 		average.threads.perf_counter[i] += t->perf_counter[i];
 	}
 
+	for (i = 0, ppmt = sys.pmt_tp; ppmt; i++, ppmt = ppmt->next) {
+		average.threads.pmt_counter[i] += t->pmt_counter[i];
+	}
+
 	/* sum per-core values only for 1st thread in core */
 	if (!is_cpu_first_thread_in_core(t, c, p))
 		return 0;
@@ -3294,6 +3520,10 @@ int sum_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 		average.cores.perf_counter[i] += c->perf_counter[i];
 	}
 
+	for (i = 0, ppmt = sys.pmt_cp; ppmt; i++, ppmt = ppmt->next) {
+		average.cores.pmt_counter[i] += c->pmt_counter[i];
+	}
+
 	/* sum per-pkg values only for 1st core in pkg */
 	if (!is_cpu_first_core_in_package(t, c, p))
 		return 0;
@@ -3353,6 +3583,10 @@ int sum_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 			average.packages.perf_counter[i] += p->perf_counter[i];
 	}
 
+	for (i = 0, ppmt = sys.pmt_pp; ppmt; i++, ppmt = ppmt->next) {
+		average.packages.pmt_counter[i] += p->pmt_counter[i];
+	}
+
 	return 0;
 }
 
@@ -3365,6 +3599,7 @@ void compute_average(struct thread_data *t, struct core_data *c, struct pkg_data
 	int i;
 	struct msr_counter *mp;
 	struct perf_counter_info *pp;
+	struct pmt_counter *ppmt;
 
 	clear_counters(&average.threads, &average.cores, &average.packages);
 
@@ -3465,6 +3700,16 @@ void compute_average(struct thread_data *t, struct core_data *c, struct pkg_data
 		}
 		average.packages.perf_counter[i] /= topo.allowed_packages;
 	}
+
+	for (i = 0, ppmt = sys.pmt_tp; ppmt; i++, ppmt = ppmt->next) {
+		average.threads.pmt_counter[i] /= topo.allowed_cpus;
+	}
+	for (i = 0, ppmt = sys.pmt_cp; ppmt; i++, ppmt = ppmt->next) {
+		average.cores.pmt_counter[i] /= topo.allowed_cores;
+	}
+	for (i = 0, ppmt = sys.pmt_pp; ppmt; i++, ppmt = ppmt->next) {
+		average.packages.pmt_counter[i] /= topo.allowed_packages;
+	}
 }
 
 static unsigned long long rdtsc(void)
@@ -4120,6 +4365,32 @@ int perf_counter_info_read_values(struct perf_counter_info *pp, int cpu, unsigne
 	return 0;
 }
 
+unsigned long pmt_gen_value_mask(unsigned int lsb, unsigned int msb)
+{
+	unsigned long mask;
+
+	if (msb == 63)
+		mask = 0xffffffffffffffff;
+	else
+		mask = ((1<<(msb+1))-1);
+
+	mask -= (1<<lsb)-1;
+
+	return mask;
+}
+
+unsigned long pmt_read_counter(struct pmt_counter *ppmt, unsigned int domain_id)
+{
+	assert(domain_id < ppmt->num_domains);
+
+	const unsigned long *pmmio = ppmt->domains[domain_id].pcounter;
+	const unsigned long value = pmmio ? *pmmio : 0;
+	const unsigned long value_mask = pmt_gen_value_mask(ppmt->lsb, ppmt->msb);
+	const unsigned long value_shift = ppmt->lsb;
+
+	return (value & value_mask) >> value_shift;
+}
+
 /*
  * get_counters(...)
  * migrate to cpu
@@ -4130,6 +4401,7 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	int cpu = t->cpu_id;
 	unsigned long long msr;
 	struct msr_counter *mp;
+	struct pmt_counter *pp;
 	int i;
 	int status;
 
@@ -4164,6 +4436,9 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	if (perf_counter_info_read_values(sys.perf_tp, cpu, t->perf_counter, MAX_ADDED_THREAD_COUNTERS))
 		return -10;
 
+	for (i = 0, pp = sys.pmt_tp; pp; i++, pp = pp->next)
+		t->pmt_counter[i] = pmt_read_counter(pp, t->cpu_id);
+
 	/* collect core counters only for 1st thread in core */
 	if (!is_cpu_first_thread_in_core(t, c, p))
 		goto done;
@@ -4205,6 +4480,9 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	if (perf_counter_info_read_values(sys.perf_cp, cpu, c->perf_counter, MAX_ADDED_CORE_COUNTERS))
 		return -10;
 
+	for (i = 0, pp = sys.pmt_cp; pp; i++, pp = pp->next)
+		c->pmt_counter[i] = pmt_read_counter(pp, c->core_id);
+
 	/* collect package counters only for 1st core in package */
 	if (!is_cpu_first_core_in_package(t, c, p))
 		goto done;
@@ -4281,6 +4559,9 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	if (perf_counter_info_read_values(sys.perf_pp, cpu, p->perf_counter, MAX_ADDED_PACKAGE_COUNTERS))
 		return -10;
 
+	for (i = 0, pp = sys.pmt_pp; pp; i++, pp = pp->next)
+		p->pmt_counter[i] = pmt_read_counter(pp, p->package_id);
+
 done:
 	gettimeofday(&t->tv_end, (struct timezone *)NULL);
 
@@ -8285,6 +8566,304 @@ void added_perf_counters_init(void)
 		errx(1, "%s: %s", __func__, "package");
 }
 
+int parse_telem_info_file(int fd_dir, const char *info_filename, const char *format, unsigned long *output)
+{
+	int fd_telem_info;
+	FILE *file_telem_info;
+	unsigned long value;
+
+	fd_telem_info = openat(fd_dir, info_filename, O_RDONLY);
+	if (fd_telem_info == -1)
+		return -1;
+
+	file_telem_info = fdopen(fd_telem_info, "r");
+	if (file_telem_info == NULL) {
+		close(fd_telem_info);
+		return -1;
+	}
+
+	if (fscanf(file_telem_info, format, &value) != 1) {
+		fclose(file_telem_info);
+		return -1;
+	}
+
+	fclose(file_telem_info);
+
+	*output = value;
+
+	return 0;
+}
+
+struct pmt_mmio* pmt_mmio_open(unsigned int target_guid)
+{
+	DIR *dirp;
+	struct dirent *entry;
+	struct stat st;
+	unsigned int telem_idx;
+	int fd_telem_dir, fd_pmt;
+	unsigned long guid, size, offset;
+	size_t mmap_size;
+	void *mmio;
+	struct pmt_mmio *ret = NULL;
+
+	if (stat(SYSFS_TELEM_PATH, &st) == -1)
+		return NULL;
+
+	dirp = opendir(SYSFS_TELEM_PATH);
+	if (dirp == NULL)
+		return NULL;
+
+	for (;;) {
+		entry = readdir(dirp);
+
+		if (entry == NULL)
+			break;
+
+		if (strcmp(entry->d_name, ".") == 0)
+			continue;
+
+		if (strcmp(entry->d_name, "..") == 0)
+			continue;
+
+		if (sscanf(entry->d_name, "telem%u", &telem_idx) != 1)
+			continue;
+
+		if (fstatat(dirfd(dirp), entry->d_name, &st, 0) == -1) {
+			break;
+		}
+
+		if (!S_ISDIR(st.st_mode))
+			continue;
+
+		fd_telem_dir = openat(dirfd(dirp), entry->d_name, O_RDONLY);
+		if (fd_telem_dir == -1) {
+			break;
+		}
+
+		if (parse_telem_info_file(fd_telem_dir, "guid", "%lx", &guid)) {
+			close(fd_telem_dir);
+			break;
+		}
+
+		if (parse_telem_info_file(fd_telem_dir, "size", "%lu", &size)) {
+			close(fd_telem_dir);
+			break;
+		}
+
+		if (guid != target_guid) {
+			close(fd_telem_dir);
+			continue;
+		}
+
+		if (parse_telem_info_file(fd_telem_dir, "offset", "%lu", &offset)) {
+			close(fd_telem_dir);
+			break;
+		}
+
+		assert(offset == 0);
+
+		fd_pmt = openat(fd_telem_dir, "telem", O_RDONLY);
+		if (fd_pmt == -1)
+			goto loop_cleanup_and_break;
+
+		mmap_size = (size + 0x1000UL) & (~0x1000UL);
+		mmio = mmap(0, mmap_size, PROT_READ, MAP_SHARED, fd_pmt, 0);
+		if (mmio != MAP_FAILED) {
+
+			if (debug)
+				fprintf(stderr, "%s: 0x%lx mmaped at: %p\n", __func__, guid, mmio);
+
+			ret = calloc(1, sizeof(*ret));
+
+			if (!ret) {
+				fprintf(stderr, "%s: Failed to allocate pmt_mmio\n", __func__);
+				exit(1);
+			}
+
+			ret->guid = guid;
+			ret->mmio_base = mmio;
+			ret->pmt_offset = offset;
+			ret->size = size;
+
+			ret->next = pmt_mmios;
+			pmt_mmios = ret;
+		}
+
+loop_cleanup_and_break:
+		close(fd_pmt);
+		close(fd_telem_dir);
+		break;
+	}
+
+	closedir(dirp);
+
+	return ret;
+}
+
+struct pmt_mmio* pmt_mmio_find(unsigned int guid)
+{
+	struct pmt_mmio *pmmio = pmt_mmios;
+
+	while (pmmio) {
+		if (pmmio->guid == guid)
+			return pmmio;
+
+		pmmio = pmmio->next;
+	 }
+
+	return NULL;
+}
+
+void* pmt_get_counter_pointer(struct pmt_mmio *pmmio, unsigned long counter_offset)
+{
+	char *ret;
+
+	/* Get base of mmaped PMT file. */
+	ret = (char*)pmmio->mmio_base;
+
+	/*
+	 * Apply PMT MMIO offset to obtain beginning of the mmaped telemetry data.
+	 * It's not guaranteed that the mmaped memory begins with the telemetry data
+	 * 	- we might have to apply the offset first.
+	 */
+	ret += pmmio->pmt_offset;
+
+	/* Apply the counter offset to get the address to the mmaped counter. */
+	ret += counter_offset;
+
+	return ret;
+}
+
+struct pmt_mmio* pmt_add_guid(unsigned int guid)
+{
+	struct pmt_mmio *ret;
+
+	ret = pmt_mmio_find(guid);
+	if (!ret)
+		ret = pmt_mmio_open(guid);
+
+	return ret;
+}
+
+enum pmt_open_mode {
+	PMT_OPEN_TRY,		/* Open failure is not an error. */
+	PMT_OPEN_REQUIRED,	/* Open failure is a fatal error. */
+};
+
+struct pmt_counter* pmt_find_counter(struct pmt_counter *pcounter, const char *name)
+{
+	while (pcounter) {
+		if (strcmp(pcounter->name, name) == 0)
+			break;
+
+		pcounter = pcounter->next;
+	}
+
+	return pcounter;
+}
+
+struct pmt_counter** pmt_get_scope_root(enum counter_scope scope)
+{
+	switch(scope) {
+	case SCOPE_CPU:
+		return &sys.pmt_tp;
+	case SCOPE_CORE:
+		return &sys.pmt_cp;
+	case SCOPE_PACKAGE:
+		return &sys.pmt_pp;
+	}
+
+	__builtin_unreachable();
+}
+
+void pmt_counter_add_domain(struct pmt_counter *pcounter, unsigned long *pmmio, unsigned int domain_id)
+{
+	/* Make sure the new domain fits. */
+	if (domain_id >= pcounter->num_domains)
+		pmt_counter_resize(pcounter, domain_id+1);
+
+	assert(pcounter->domains);
+	assert(domain_id < pcounter->num_domains);
+
+	pcounter->domains[domain_id].pcounter = pmmio;
+}
+
+int pmt_add_counter(unsigned int guid, const char *name, enum pmt_datatype type,
+	unsigned int lsb, unsigned int msb, unsigned int offset, enum counter_scope scope,
+	enum counter_format format, unsigned int domain_id, enum pmt_open_mode mode)
+{
+	struct pmt_mmio *mmio;
+	struct pmt_counter *pcounter;
+	struct pmt_counter ** const pmt_root = pmt_get_scope_root(scope);
+	bool new_counter = false;
+	int conflict = 0;
+
+	if (lsb > msb) {
+		fprintf(stderr, "%s: %s: `%s` must be satisfied\n", __func__, "lsb <= msb", name);
+		exit(1);
+	}
+
+	if (msb >= 64) {
+		fprintf(stderr, "%s: %s: `%s` must be satisfied\n", __func__, "msb < 64", name);
+		exit(1);
+	}
+
+	mmio = pmt_add_guid(guid);
+	if (!mmio) {
+		if (mode != PMT_OPEN_TRY) {
+			fprintf(stderr, "%s: failed to map PMT MMIO for guid %x\n", __func__, guid);
+			exit(1);
+		}
+
+		return 1;
+	}
+
+	if (offset >= mmio->size) {
+		if (mode != PMT_OPEN_TRY) {
+			fprintf(stderr, "%s: offset %u outside of PMT MMIO size %u\n", __func__, offset, mmio->size);
+			exit(1);
+		}
+
+		return 1;
+	}
+
+	pcounter = pmt_find_counter(*pmt_root, name);
+	if (!pcounter) {
+		pcounter = calloc(1, sizeof(*pcounter));
+		new_counter = true;
+	}
+
+	if (new_counter) {
+		strncpy(pcounter->name, name, ARRAY_SIZE(pcounter->name)-1);
+		pcounter->type = type;
+		pcounter->scope = scope;
+		pcounter->lsb = lsb;
+		pcounter->msb = msb;
+		pcounter->format = format;
+	} else {
+		conflict += pcounter->type != type;
+		conflict += pcounter->scope != scope;
+		conflict += pcounter->lsb != lsb;
+		conflict += pcounter->msb != msb;
+		conflict += pcounter->format != format;
+	}
+
+	if (conflict) {
+		fprintf(stderr, "%s: conflicting parameters for the PMT counter with the same name %s\n",
+			__func__, name);
+		exit(1);
+	}
+
+	pmt_counter_add_domain(pcounter, pmt_get_counter_pointer(mmio, offset), domain_id);
+
+	if (new_counter) {
+		pcounter->next = *pmt_root;
+		*pmt_root = pcounter;
+	}
+
+	return 0;
+}
+
 void turbostat_init()
 {
 	setup_all_buffers(true);
@@ -8622,7 +9201,7 @@ int add_perf_counter(const char *perf_device, const char *perf_event, const char
 	return 0;
 }
 
-void parse_add_command(char *add_command)
+void parse_add_command_msr(char *add_command)
 {
 	int msr_num = 0;
 	char *path = NULL;
@@ -8747,6 +9326,191 @@ void parse_add_command(char *add_command)
 	}
 }
 
+bool starts_with(const char *str, const char *prefix)
+{
+	return strncmp(prefix, str, strlen(prefix)) == 0;
+}
+
+void parse_add_command_pmt(char *add_command)
+{
+	char *name = NULL;
+	char *type_name = NULL;
+	char *format_name = NULL;
+	unsigned int offset;
+	unsigned int lsb;
+	unsigned int msb;
+	unsigned int guid;
+	unsigned int domain_id;
+	enum counter_scope scope = 0;
+	enum pmt_datatype type = PMT_TYPE_RAW;
+	enum counter_format format = FORMAT_RAW;
+	bool has_offset = false;
+	bool has_lsb = false;
+	bool has_msb = false;
+	bool has_format = true; /* Format has a default value. */
+	bool has_guid = false;
+	bool has_scope = false;
+	bool has_type = true; /* Type has a default value. */
+
+	/* Consume the "pmt," prefix. */
+	add_command = strchr(add_command, ',');
+	if (!add_command) {
+		help();
+		exit(1);
+	}
+	++add_command;
+
+	while (add_command) {
+		if (starts_with(add_command, "name=")) {
+			name = add_command + strlen("name=");
+			goto next;
+		}
+
+		if (starts_with(add_command, "type=")) {
+			type_name = add_command + strlen("type=");
+			goto next;
+		}
+
+		if (starts_with(add_command, "domain=")) {
+			const size_t prefix_len = strlen("domain=");
+
+			if (sscanf(add_command + prefix_len, "cpu%u", &domain_id) == 1) {
+				scope = SCOPE_CPU;
+				has_scope = true;
+			} else if (sscanf(add_command + prefix_len, "core%u", &domain_id) == 1) {
+				scope = SCOPE_CORE;
+				has_scope = true;
+			} else if (sscanf(add_command + prefix_len, "package%u", &domain_id) == 1) {
+				scope = SCOPE_PACKAGE;
+				has_scope = true;
+			}
+
+			if (!has_scope) {
+				printf("%s: invalid value for scope. Expected cpu%%u, core%%u or package%%u.\n",
+					__func__);
+				exit(1);
+			}
+
+			goto next;
+		}
+
+		if (starts_with(add_command, "format=")) {
+			format_name = add_command + strlen("format=");
+			goto next;
+		}
+
+		if (sscanf(add_command, "offset=%u", &offset) == 1) {
+			has_offset = true;
+			goto next;
+		}
+
+		if (sscanf(add_command, "lsb=%u", &lsb) == 1) {
+			has_lsb = true;
+			goto next;
+		}
+
+		if (sscanf(add_command, "msb=%u", &msb) == 1) {
+			has_msb = true;
+			goto next;
+		}
+
+		if (sscanf(add_command, "guid=%x", &guid) == 1) {
+			has_guid = true;
+			goto next;
+		}
+
+next:
+		add_command = strchr(add_command, ',');
+		if (add_command) {
+			*add_command = '\0';
+			add_command++;
+		}
+	}
+
+	if (!name) {
+		printf("%s: missing %s\n", __func__, "name");
+		exit(1);
+	}
+
+	if (strlen(name) >= PMT_COUNTER_NAME_SIZE_BYTES) {
+		printf("%s: name has to be at most %d characters long\n",
+			__func__, PMT_COUNTER_NAME_SIZE_BYTES);
+		exit(1);
+	}
+
+	if (format_name) {
+		has_format = false;
+
+		if (strcmp("raw", format_name) == 0) {
+			format = FORMAT_RAW;
+			has_format = true;
+		}
+
+		if (strcmp("delta", format_name) == 0) {
+			format = FORMAT_DELTA;
+			has_format = true;
+		}
+
+		if (!has_format) {
+			fprintf(stderr, "%s: Invalid format %s. Expected raw or delta\n", __func__, format_name);
+			exit(1);
+		}
+	}
+
+	if (type_name) {
+		has_type = false;
+
+		if (strcmp("raw", type_name) == 0) {
+			type = PMT_TYPE_RAW;
+			has_type = true;
+		}
+
+		if (!has_type) {
+			printf("%s: invalid %s: %s\n", __func__, "type", type_name);
+			exit(1);
+		}
+	}
+
+	if (!has_offset) {
+		printf("%s : missing %s\n", __func__, "offset");
+		exit(1);
+	}
+
+	if (!has_lsb) {
+		printf("%s: missing %s\n", __func__, "lsb");
+		exit(1);
+	}
+
+	if (!has_msb) {
+		printf("%s: missing %s\n", __func__, "msb");
+		exit(1);
+	}
+
+	if (!has_guid) {
+		printf("%s: missing %s\n", __func__, "guid");
+		exit(1);
+	}
+
+	if (!has_scope) {
+		printf("%s: missing %s\n", __func__, "scope");
+		exit(1);
+	}
+
+	if (lsb > msb) {
+		printf("%s: lsb > msb doesn't make sense\n", __func__);
+		exit(1);
+	}
+
+	pmt_add_counter(guid, name, type, lsb, msb, offset, scope, format, domain_id, PMT_OPEN_REQUIRED);
+}
+
+void parse_add_command(char *add_command)
+{
+	if (strncmp(add_command, "pmt", strlen("pmt")) == 0)
+		return parse_add_command_pmt(add_command);
+	return parse_add_command_msr(add_command);
+}
+
 int is_deferred_add(char *name)
 {
 	int i;
-- 
2.43.0


