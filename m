Return-Path: <linux-pm+bounces-11477-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 352CF93E083
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 20:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5924B1C20DE4
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 18:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28817187328;
	Sat, 27 Jul 2024 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ou80uLvR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB3E86126
	for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722104816; cv=none; b=Z/bRKeqGFpbTDiyRVQlqqfqiJi9oJEGo8KhGq5W4WBaEtIxFMHu+dBDdYsvBnKsp+ndfFWa5FepEgDIl6fHtfU55eLEQ3Eumq5QBE1ubhw4WMTQmXG45zztR4Iax2Z/iwvlQb0qrMeQuXfzUy8SqNApbFv8JeVH0Fiq/nJG+SPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722104816; c=relaxed/simple;
	bh=Y8b/vg+fZg67qsaUf7qiI2Fc3ZvoiW8XZmItRs9OT2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZGkyWQ2pMTcWJtY7vX6KWV8n+/t+ZFO/5/M79q25Fo/I9qMxxmSZVq7suVYJetDDLM10Ijly/gqV/FKECpuMcMVqE/Kl+BR5Gn4d7nyOCwRgKWLSEOoj/0whfCarikB4iDo5VzHsrFz0vbVSN3GMu4rgOHcEa2s7DvghWj8gYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ou80uLvR; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5d3cf39c239so1284953eaf.1
        for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 11:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722104812; x=1722709612; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nM0+Cq5ojbl7npGQWDchSIJ7+Zsl+N8ipzrpLO8Qopc=;
        b=Ou80uLvRTg9TkMxdxjXSJNf0NX8rrUiTpma9XAN/sq8ZZJckmAbWp17+OiCjqGnscx
         vmpFzby4ChXX8sufHoh69JBweA3teKYwsGF4MW7EqYAWQgLfO/aq0VdmnFQ+2RfI9RGw
         /E5I/Kp6kNy16+E9fgpxyeOR/sGEFjKmQLk7fA/tgJWnyalXOSlQBsPHjd87kB34/5vP
         sadGhj7crxwft/xoOpFqy44sm/iN3gBjJAus23gRoPFOl/gho87aby7etBVBRnC+fc4P
         SzYzSt2UDKmSLk2o1d+iX4Z/KXhjAxCQbSTCRDalkgVS4/gvgDSZFombXqx4FEZauzLq
         3OcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722104812; x=1722709612;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nM0+Cq5ojbl7npGQWDchSIJ7+Zsl+N8ipzrpLO8Qopc=;
        b=IqpsKxmQfshSFufqjbkffre6dIxVb7nnaKgmcK3mJOU+l7rLm73YpiPuWdG4/i4tPz
         Ya27j6W4ocqPiNg//viiti2b5wIy6kq9/cbrQDDow2+L1hhGM4+6qTQ200kXSy/n7i+7
         2+kUdbTHJ/DjbUK+kMItq76duliNqgDTyEN4bRNrI7gum0zCBZ8TsbMiFfakoVSo+FEZ
         WyMeHOT1RMMqgk2J3TJxr707zmWU5OkiHzfDcyz3x5ddwxU5h7wR7uo2ffa05XYo0UoY
         IBEeQw+UjMx83S4n3yKHDf8ubgKGRMseNzkcCrcV0RCQTewfIEPJBlEsKQmjGdPIebIr
         QdRw==
X-Gm-Message-State: AOJu0YyaL5ItP5Lo4zcdTqih46AEtJELGsRPDq8D5zaWXSt8xv1sV1Lp
	wdN/bnIijXirN0nZv59vbW+P93qV0ciQpbBjW7KWwj4TQOfA8OJOr7g/fA==
X-Google-Smtp-Source: AGHT+IGQALgwZr69hUTxQxpKlBEeqnHEVk8mUX7OF4Cq5nUIkvAbdkSsi1ZIqp4d2CVMtHkQhU+ddg==
X-Received: by 2002:a05:6870:71ce:b0:261:10b7:8c48 with SMTP id 586e51a60fabf-267d4dd3f23mr4012717fac.27.1722104812019;
        Sat, 27 Jul 2024 11:26:52 -0700 (PDT)
Received: from lenb-intel-nuc8i7hvkva.. (h75-100-80-185.cntcnh.broadband.dynamic.tds.net. [75.100.80.185])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7093050a35fsm1314136a34.6.2024.07.27.11.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 11:26:51 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 06/18] tools/power turbostat: Extend --add option with perf counters
Date: Sat, 27 Jul 2024 14:23:32 -0400
Message-ID: <361b8fc73cf63dc0c3be3778720631f1a33ba9db.1722019621.git.len.brown@intel.com>
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

User can now read perf counters using "--add perf/<device>/<event>".
Other details work similarly to how --add works with MSRs.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/Makefile    |   1 +
 tools/power/x86/turbostat/turbostat.8 |   5 +-
 tools/power/x86/turbostat/turbostat.c | 562 +++++++++++++++++++++++++-
 3 files changed, 557 insertions(+), 11 deletions(-)

diff --git a/tools/power/x86/turbostat/Makefile b/tools/power/x86/turbostat/Makefile
index b1e6817f1e54..3946d5254a1f 100644
--- a/tools/power/x86/turbostat/Makefile
+++ b/tools/power/x86/turbostat/Makefile
@@ -46,6 +46,7 @@ snapshot: turbostat
 	@echo "#define GENMASK_ULL(h, l) (((~0ULL) << (l)) & (~0ULL >> (sizeof(long long) * 8 - 1 - (h))))" >> $(SNAPSHOT)/bits.h
 
 	@echo '#define BUILD_BUG_ON(cond) do { enum { compile_time_check ## __COUNTER__ = 1/(!(cond)) }; } while (0)' > $(SNAPSHOT)/build_bug.h
+	@echo '#define __must_be_array(arr) 0' >> $(SNAPSHOT)/build_bug.h
 
 	@echo PWD=. > $(SNAPSHOT)/Makefile
 	@echo "CFLAGS +=	-DMSRHEADER='\"msr-index.h\"'" >> $(SNAPSHOT)/Makefile
diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index 8d37acd39201..5537fc6b5bc3 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -28,10 +28,13 @@ name as necessary to disambiguate it from others is necessary.  Note that option
 .PP
 \fB--add attributes\fP add column with counter having specified 'attributes'.  The 'location' attribute is required, all others are optional.
 .nf
-	location: {\fBmsrDDD\fP | \fBmsr0xXXX\fP | \fB/sys/path...\fP}
+	location: {\fBmsrDDD\fP | \fBmsr0xXXX\fP | \fB/sys/path...\fP | \fBperf/<device>/<event>\fP}
 		msrDDD is a decimal offset, eg. msr16
 		msr0xXXX is a hex offset, eg. msr0x10
 		/sys/path... is an absolute path to a sysfs attribute
+		<device> is a perf device from /sys/bus/event_source/devices/<device> eg. cstate_core
+		<event> is a perf event for given device from /sys/bus/event_source/devices/<device>/events/<event> eg. c1-residency
+			perf/cstate_core/c1-residency would then use /sys/bus/event_source/devices/cstate_core/events/c1-residency
 
 	scope: {\fBcpu\fP | \fBcore\fP | \fBpackage\fP}
 		sample and print the counter for every cpu, core, or package.
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 495235055fa2..be345a4bbe96 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -79,14 +79,40 @@
  */
 #define	NAME_BYTES 20
 #define PATH_BYTES 128
+#define PERF_NAME_BYTES 128
 
 #define MAX_NOFILE 0x8000
 
+#define COUNTER_KIND_PERF_PREFIX "perf/"
+#define COUNTER_KIND_PERF_PREFIX_LEN strlen(COUNTER_KIND_PERF_PREFIX)
+#define PERF_DEV_NAME_BYTES 32
+#define PERF_EVT_NAME_BYTES 32
+
 enum counter_scope { SCOPE_CPU, SCOPE_CORE, SCOPE_PACKAGE };
 enum counter_type { COUNTER_ITEMS, COUNTER_CYCLES, COUNTER_SECONDS, COUNTER_USEC, COUNTER_K2M };
 enum counter_format { FORMAT_RAW, FORMAT_DELTA, FORMAT_PERCENT, FORMAT_AVERAGE };
 enum counter_source { COUNTER_SOURCE_NONE, COUNTER_SOURCE_PERF, COUNTER_SOURCE_MSR };
 
+struct perf_counter_info {
+	struct perf_counter_info *next;
+
+	/* How to open the counter / What counter it is. */
+	char device[PERF_DEV_NAME_BYTES];
+	char event[PERF_EVT_NAME_BYTES];
+
+	/* How to show/format the counter. */
+	char name[PERF_NAME_BYTES];
+	unsigned int width;
+	enum counter_scope scope;
+	enum counter_type type;
+	enum counter_format format;
+	double scale;
+
+	/* For reading the counter. */
+	int *fd_perf_per_domain;
+	size_t num_domains;
+};
+
 struct sysfs_path {
 	char path[PATH_BYTES];
 	int id;
@@ -1457,6 +1483,7 @@ struct thread_data {
 	unsigned int flags;
 	bool is_atom;
 	unsigned long long counter[MAX_ADDED_THREAD_COUNTERS];
+	unsigned long long perf_counter[MAX_ADDED_THREAD_COUNTERS];
 } *thread_even, *thread_odd;
 
 struct core_data {
@@ -1470,6 +1497,7 @@ struct core_data {
 	unsigned int core_id;
 	unsigned long long core_throt_cnt;
 	unsigned long long counter[MAX_ADDED_CORE_COUNTERS];
+	unsigned long long perf_counter[MAX_ADDED_CORE_COUNTERS];
 } *core_even, *core_odd;
 
 struct pkg_data {
@@ -1503,6 +1531,7 @@ struct pkg_data {
 	unsigned int pkg_temp_c;
 	unsigned int uncore_mhz;
 	unsigned long long counter[MAX_ADDED_PACKAGE_COUNTERS];
+	unsigned long long perf_counter[MAX_ADDED_PACKAGE_COUNTERS];
 } *package_even, *package_odd;
 
 #define ODD_COUNTERS thread_odd, core_odd, package_odd
@@ -1637,12 +1666,21 @@ int idx_valid(int idx)
 }
 
 struct sys_counters {
+	/* MSR added counters */
 	unsigned int added_thread_counters;
 	unsigned int added_core_counters;
 	unsigned int added_package_counters;
 	struct msr_counter *tp;
 	struct msr_counter *cp;
 	struct msr_counter *pp;
+
+	/* perf added counters */
+	unsigned int added_thread_perf_counters;
+	unsigned int added_core_perf_counters;
+	unsigned int added_package_perf_counters;
+	struct perf_counter_info *perf_tp;
+	struct perf_counter_info *perf_cp;
+	struct perf_counter_info *perf_pp;
 } sys;
 
 static size_t free_msr_counters_(struct msr_counter **pp)
@@ -1902,6 +1940,23 @@ int probe_msr(int cpu, off_t offset)
 	return 0;
 }
 
+/* Convert CPU ID to domain ID for given added perf counter. */
+unsigned int cpu_to_domain(const struct perf_counter_info *pc, int cpu)
+{
+	switch (pc->scope) {
+	case SCOPE_CPU:
+		return cpu;
+
+	case SCOPE_CORE:
+		return cpus[cpu].physical_core_id;
+
+	case SCOPE_PACKAGE:
+		return cpus[cpu].physical_package_id;
+	}
+
+	__builtin_unreachable();
+}
+
 #define MAX_DEFERRED 16
 char *deferred_add_names[MAX_DEFERRED];
 char *deferred_skip_names[MAX_DEFERRED];
@@ -1925,6 +1980,7 @@ void help(void)
 		"to print statistics, until interrupted.\n"
 		"  -a, --add	add a counter\n"
 		"		  eg. --add msr0x10,u64,cpu,delta,MY_TSC\n"
+		"		  eg. --add perf/cstate_pkg/c2-residency,package,delta,percent,perfPC2\n"
 		"  -c, --cpu	cpu-set	limit output to summary plus cpu-set:\n"
 		"		  {core | package | j,k,l..m,n-p }\n"
 		"  -d, --debug	displays usec, Time_Of_Day_Seconds and more debugging\n"
@@ -2034,6 +2090,7 @@ unsigned long long bic_lookup(char *name_list, enum show_hide_mode mode)
 void print_header(char *delim)
 {
 	struct msr_counter *mp;
+	struct perf_counter_info *pp;
 	int printed = 0;
 
 	if (DO_BIC(BIC_USEC))
@@ -2091,6 +2148,21 @@ void print_header(char *delim)
 		}
 	}
 
+	for (pp = sys.perf_tp; pp; pp = pp->next) {
+
+		if (pp->format == FORMAT_RAW) {
+			if (pp->width == 64)
+				outp += sprintf(outp, "%s%18.18s", (printed++ ? delim : ""), pp->name);
+			else
+				outp += sprintf(outp, "%s%10.10s", (printed++ ? delim : ""), pp->name);
+		} else {
+			if ((pp->type == COUNTER_ITEMS) && sums_need_wide_columns)
+				outp += sprintf(outp, "%s%8s", (printed++ ? delim : ""), pp->name);
+			else
+				outp += sprintf(outp, "%s%s", (printed++ ? delim : ""), pp->name);
+		}
+	}
+
 	if (DO_BIC(BIC_CPU_c1))
 		outp += sprintf(outp, "%sCPU%%c1", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_CPU_c3))
@@ -2131,6 +2203,21 @@ void print_header(char *delim)
 		}
 	}
 
+	for (pp = sys.perf_cp; pp; pp = pp->next) {
+
+		if (pp->format == FORMAT_RAW) {
+			if (pp->width == 64)
+				outp += sprintf(outp, "%s%18.18s", (printed++ ? delim : ""), pp->name);
+			else
+				outp += sprintf(outp, "%s%10.10s", (printed++ ? delim : ""), pp->name);
+		} else {
+			if ((pp->type == COUNTER_ITEMS) && sums_need_wide_columns)
+				outp += sprintf(outp, "%s%8s", (printed++ ? delim : ""), pp->name);
+			else
+				outp += sprintf(outp, "%s%s", (printed++ ? delim : ""), pp->name);
+		}
+	}
+
 	if (DO_BIC(BIC_PkgTmp))
 		outp += sprintf(outp, "%sPkgTmp", (printed++ ? delim : ""));
 
@@ -2226,6 +2313,21 @@ void print_header(char *delim)
 		}
 	}
 
+	for (pp = sys.perf_pp; pp; pp = pp->next) {
+
+		if (pp->format == FORMAT_RAW) {
+			if (pp->width == 64)
+				outp += sprintf(outp, "%s%18.18s", (printed++ ? delim : ""), pp->name);
+			else
+				outp += sprintf(outp, "%s%10.10s", (printed++ ? delim : ""), pp->name);
+		} else {
+			if ((pp->type == COUNTER_ITEMS) && sums_need_wide_columns)
+				outp += sprintf(outp, "%s%8s", (printed++ ? delim : ""), pp->name);
+			else
+				outp += sprintf(outp, "%s%s", (printed++ ? delim : ""), pp->name);
+		}
+	}
+
 	outp += sprintf(outp, "\n");
 }
 
@@ -2346,6 +2448,7 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 	char *fmt8;
 	int i;
 	struct msr_counter *mp;
+	struct perf_counter_info *pp;
 	char *delim = "\t";
 	int printed = 0;
 
@@ -2483,6 +2586,31 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 		}
 	}
 
+	/* Added perf counters */
+	for (i = 0, pp = sys.perf_tp; pp; ++i, pp = pp->next) {
+		if (pp->format == FORMAT_RAW) {
+			if (pp->width == 32)
+				outp +=
+				    sprintf(outp, "%s0x%08x", (printed++ ? delim : ""),
+					    (unsigned int)t->perf_counter[i]);
+			else
+				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), t->perf_counter[i]);
+		} else if (pp->format == FORMAT_DELTA) {
+			if ((pp->type == COUNTER_ITEMS) && sums_need_wide_columns)
+				outp += sprintf(outp, "%s%8lld", (printed++ ? delim : ""), t->perf_counter[i]);
+			else
+				outp += sprintf(outp, "%s%lld", (printed++ ? delim : ""), t->perf_counter[i]);
+		} else if (pp->format == FORMAT_PERCENT) {
+			if (pp->type == COUNTER_USEC)
+				outp +=
+				    sprintf(outp, "%s%.2f", (printed++ ? delim : ""),
+					    t->perf_counter[i] / interval_float / 10000);
+			else
+				outp +=
+				    sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * t->perf_counter[i] / tsc);
+		}
+	}
+
 	/* C1 */
 	if (DO_BIC(BIC_CPU_c1))
 		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * t->c1 / tsc);
@@ -2526,6 +2654,24 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 		}
 	}
 
+	for (i = 0, pp = sys.perf_cp; pp; i++, pp = pp->next) {
+		if (pp->format == FORMAT_RAW) {
+			if (pp->width == 32)
+				outp +=
+				    sprintf(outp, "%s0x%08x", (printed++ ? delim : ""),
+					    (unsigned int)c->perf_counter[i]);
+			else
+				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), c->perf_counter[i]);
+		} else if (pp->format == FORMAT_DELTA) {
+			if ((pp->type == COUNTER_ITEMS) && sums_need_wide_columns)
+				outp += sprintf(outp, "%s%8lld", (printed++ ? delim : ""), c->perf_counter[i]);
+			else
+				outp += sprintf(outp, "%s%lld", (printed++ ? delim : ""), c->perf_counter[i]);
+		} else if (pp->format == FORMAT_PERCENT) {
+			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * c->perf_counter[i] / tsc);
+		}
+	}
+
 	fmt8 = "%s%.2f";
 
 	if (DO_BIC(BIC_CorWatt) && platform->has_per_core_rapl)
@@ -2680,6 +2826,26 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 			outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), (unsigned int)p->counter[i] / 1000);
 	}
 
+	for (i = 0, pp = sys.perf_pp; pp; i++, pp = pp->next) {
+		if (pp->format == FORMAT_RAW) {
+			if (pp->width == 32)
+				outp +=
+				    sprintf(outp, "%s0x%08x", (printed++ ? delim : ""),
+					    (unsigned int)p->perf_counter[i]);
+			else
+				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), p->perf_counter[i]);
+		} else if (pp->format == FORMAT_DELTA) {
+			if ((pp->type == COUNTER_ITEMS) && sums_need_wide_columns)
+				outp += sprintf(outp, "%s%8lld", (printed++ ? delim : ""), p->perf_counter[i]);
+			else
+				outp += sprintf(outp, "%s%lld", (printed++ ? delim : ""), p->perf_counter[i]);
+		} else if (pp->format == FORMAT_PERCENT) {
+			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->perf_counter[i] / tsc);
+		} else if (pp->type == COUNTER_K2M)
+			outp +=
+			    sprintf(outp, "%s%d", (printed++ ? delim : ""), (unsigned int)p->perf_counter[i] / 1000);
+	}
+
 done:
 	if (*(outp - 1) != '\n')
 		outp += sprintf(outp, "\n");
@@ -2733,6 +2899,7 @@ int delta_package(struct pkg_data *new, struct pkg_data *old)
 {
 	int i;
 	struct msr_counter *mp;
+	struct perf_counter_info *pp;
 
 	if (DO_BIC(BIC_Totl_c0))
 		old->pkg_wtd_core_c0 = new->pkg_wtd_core_c0 - old->pkg_wtd_core_c0;
@@ -2793,6 +2960,15 @@ int delta_package(struct pkg_data *new, struct pkg_data *old)
 			old->counter[i] = new->counter[i] - old->counter[i];
 	}
 
+	for (i = 0, pp = sys.perf_pp; pp; i++, pp = pp->next) {
+		if (pp->format == FORMAT_RAW)
+			old->perf_counter[i] = new->perf_counter[i];
+		else if (pp->format == FORMAT_AVERAGE)
+			old->perf_counter[i] = new->perf_counter[i];
+		else
+			old->perf_counter[i] = new->perf_counter[i] - old->perf_counter[i];
+	}
+
 	return 0;
 }
 
@@ -2800,6 +2976,7 @@ void delta_core(struct core_data *new, struct core_data *old)
 {
 	int i;
 	struct msr_counter *mp;
+	struct perf_counter_info *pp;
 
 	old->c3 = new->c3 - old->c3;
 	old->c6 = new->c6 - old->c6;
@@ -2816,6 +2993,13 @@ void delta_core(struct core_data *new, struct core_data *old)
 		else
 			old->counter[i] = new->counter[i] - old->counter[i];
 	}
+
+	for (i = 0, pp = sys.perf_cp; pp; i++, pp = pp->next) {
+		if (pp->format == FORMAT_RAW)
+			old->perf_counter[i] = new->perf_counter[i];
+		else
+			old->perf_counter[i] = new->perf_counter[i] - old->perf_counter[i];
+	}
 }
 
 int soft_c1_residency_display(int bic)
@@ -2833,6 +3017,7 @@ int delta_thread(struct thread_data *new, struct thread_data *old, struct core_d
 {
 	int i;
 	struct msr_counter *mp;
+	struct perf_counter_info *pp;
 
 	/* we run cpuid just the 1st time, copy the results */
 	if (DO_BIC(BIC_APIC))
@@ -2911,6 +3096,14 @@ int delta_thread(struct thread_data *new, struct thread_data *old, struct core_d
 		else
 			old->counter[i] = new->counter[i] - old->counter[i];
 	}
+
+	for (i = 0, pp = sys.perf_tp; pp; i++, pp = pp->next) {
+		if (pp->format == FORMAT_RAW)
+			old->perf_counter[i] = new->perf_counter[i];
+		else
+			old->perf_counter[i] = new->perf_counter[i] - old->perf_counter[i];
+	}
+
 	return 0;
 }
 
@@ -3013,6 +3206,10 @@ void clear_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 
 	for (i = 0, mp = sys.pp; mp; i++, mp = mp->next)
 		p->counter[i] = 0;
+
+	memset(&t->perf_counter[0], 0, sizeof(t->perf_counter));
+	memset(&c->perf_counter[0], 0, sizeof(c->perf_counter));
+	memset(&p->perf_counter[0], 0, sizeof(p->perf_counter));
 }
 
 void rapl_counter_accumulate(struct rapl_counter *dst, const struct rapl_counter *src)
@@ -3033,6 +3230,7 @@ int sum_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 {
 	int i;
 	struct msr_counter *mp;
+	struct perf_counter_info *pp;
 
 	/* copy un-changing apic_id's */
 	if (DO_BIC(BIC_APIC))
@@ -3063,6 +3261,12 @@ int sum_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 		average.threads.counter[i] += t->counter[i];
 	}
 
+	for (i = 0, pp = sys.perf_tp; pp; i++, pp = pp->next) {
+		if (pp->format == FORMAT_RAW)
+			continue;
+		average.threads.perf_counter[i] += t->perf_counter[i];
+	}
+
 	/* sum per-core values only for 1st thread in core */
 	if (!is_cpu_first_thread_in_core(t, c, p))
 		return 0;
@@ -3083,6 +3287,12 @@ int sum_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 		average.cores.counter[i] += c->counter[i];
 	}
 
+	for (i = 0, pp = sys.perf_cp; pp; i++, pp = pp->next) {
+		if (pp->format == FORMAT_RAW)
+			continue;
+		average.cores.perf_counter[i] += c->perf_counter[i];
+	}
+
 	/* sum per-pkg values only for 1st core in pkg */
 	if (!is_cpu_first_core_in_package(t, c, p))
 		return 0;
@@ -3134,6 +3344,14 @@ int sum_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 		else
 			average.packages.counter[i] += p->counter[i];
 	}
+
+	for (i = 0, pp = sys.perf_pp; pp; i++, pp = pp->next) {
+		if ((pp->format == FORMAT_RAW) && (topo.num_packages == 0))
+			average.packages.perf_counter[i] = p->perf_counter[i];
+		else
+			average.packages.perf_counter[i] += p->perf_counter[i];
+	}
+
 	return 0;
 }
 
@@ -3145,6 +3363,7 @@ void compute_average(struct thread_data *t, struct core_data *c, struct pkg_data
 {
 	int i;
 	struct msr_counter *mp;
+	struct perf_counter_info *pp;
 
 	clear_counters(&average.threads, &average.cores, &average.packages);
 
@@ -3216,6 +3435,35 @@ void compute_average(struct thread_data *t, struct core_data *c, struct pkg_data
 		}
 		average.packages.counter[i] /= topo.allowed_packages;
 	}
+
+	for (i = 0, pp = sys.perf_tp; pp; i++, pp = pp->next) {
+		if (pp->format == FORMAT_RAW)
+			continue;
+		if (pp->type == COUNTER_ITEMS) {
+			if (average.threads.perf_counter[i] > 9999999)
+				sums_need_wide_columns = 1;
+			continue;
+		}
+		average.threads.perf_counter[i] /= topo.allowed_cpus;
+	}
+	for (i = 0, pp = sys.perf_cp; pp; i++, pp = pp->next) {
+		if (pp->format == FORMAT_RAW)
+			continue;
+		if (pp->type == COUNTER_ITEMS) {
+			if (average.cores.perf_counter[i] > 9999999)
+				sums_need_wide_columns = 1;
+		}
+		average.cores.perf_counter[i] /= topo.allowed_cores;
+	}
+	for (i = 0, pp = sys.perf_pp; pp; i++, pp = pp->next) {
+		if (pp->format == FORMAT_RAW)
+			continue;
+		if (pp->type == COUNTER_ITEMS) {
+			if (average.packages.perf_counter[i] > 9999999)
+				sums_need_wide_columns = 1;
+		}
+		average.packages.perf_counter[i] /= topo.allowed_packages;
+	}
 }
 
 static unsigned long long rdtsc(void)
@@ -3848,6 +4096,31 @@ int get_smi_aperf_mperf(unsigned int cpu, struct thread_data *t)
 	return 0;
 }
 
+int perf_counter_info_read_values(struct perf_counter_info *pp, int cpu, unsigned long long *out, size_t out_size)
+{
+	unsigned int domain;
+	unsigned long long value;
+	int fd_counter;
+
+	for (size_t i = 0; pp; ++i, pp = pp->next) {
+		domain = cpu_to_domain(pp, cpu);
+		assert(domain < pp->num_domains);
+
+		fd_counter = pp->fd_perf_per_domain[domain];
+
+		if (fd_counter == -1)
+			continue;
+
+		if (read(fd_counter, &value, sizeof(value)) != sizeof(value))
+			return 1;
+
+		assert(i < out_size);
+		out[i] = value * pp->scale;
+	}
+
+	return 0;
+}
+
 /*
  * get_counters(...)
  * migrate to cpu
@@ -3889,6 +4162,9 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 			return -10;
 	}
 
+	if (perf_counter_info_read_values(sys.perf_tp, cpu, t->perf_counter, MAX_ADDED_THREAD_COUNTERS))
+		return -10;
+
 	/* collect core counters only for 1st thread in core */
 	if (!is_cpu_first_thread_in_core(t, c, p))
 		goto done;
@@ -3927,6 +4203,9 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 			return -10;
 	}
 
+	if (perf_counter_info_read_values(sys.perf_cp, cpu, c->perf_counter, MAX_ADDED_CORE_COUNTERS))
+		return -10;
+
 	/* collect package counters only for 1st core in package */
 	if (!is_cpu_first_core_in_package(t, c, p))
 		goto done;
@@ -3999,6 +4278,10 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 		if (get_mp(cpu, mp, &p->counter[i], path))
 			return -10;
 	}
+
+	if (perf_counter_info_read_values(sys.perf_pp, cpu, p->perf_counter, MAX_ADDED_PACKAGE_COUNTERS))
+		return -10;
+
 done:
 	gettimeofday(&t->tv_end, (struct timezone *)NULL);
 
@@ -4528,6 +4811,36 @@ void free_fd_rapl_percpu(void)
 	rapl_counter_info_perdomain_size = 0;
 }
 
+void free_fd_added_perf_counters_(struct perf_counter_info *pp)
+{
+	if (!pp)
+		return;
+
+	if (!pp->fd_perf_per_domain)
+		return;
+
+	while (pp) {
+		for (size_t domain = 0; domain < pp->num_domains; ++domain) {
+			if (pp->fd_perf_per_domain[domain] != -1) {
+				close(pp->fd_perf_per_domain[domain]);
+				pp->fd_perf_per_domain[domain] = -1;
+			}
+		}
+
+		free(pp->fd_perf_per_domain);
+		pp->fd_perf_per_domain = NULL;
+
+		pp = pp->next;
+	}
+}
+
+void free_fd_added_perf_counters(void)
+{
+	free_fd_added_perf_counters_(sys.perf_tp);
+	free_fd_added_perf_counters_(sys.perf_cp);
+	free_fd_added_perf_counters_(sys.perf_pp);
+}
+
 void free_all_buffers(void)
 {
 	int i;
@@ -4573,6 +4886,7 @@ void free_all_buffers(void)
 	free_fd_msr();
 	free_fd_rapl_percpu();
 	free_fd_cstate();
+	free_fd_added_perf_counters();
 
 	free(irq_column_2_cpu);
 	free(irqs_per_cpu);
@@ -4910,6 +5224,7 @@ void linux_perf_init(void);
 void msr_perf_init(void);
 void rapl_perf_init(void);
 void cstate_perf_init(void);
+void added_perf_counters_init(void);
 
 void re_initialize(void)
 {
@@ -4919,6 +5234,7 @@ void re_initialize(void)
 	msr_perf_init();
 	rapl_perf_init();
 	cstate_perf_init();
+	added_perf_counters_init();
 	fprintf(outf, "turbostat: re-initialized with num_cpus %d, allowed_cpus %d\n", topo.num_cpus,
 		topo.allowed_cpus);
 }
@@ -7859,6 +8175,117 @@ void check_perf_access(void)
 		bic_enabled &= ~BIC_IPC;
 }
 
+int added_perf_counters_init_(struct perf_counter_info *pinfo)
+{
+	size_t num_domains = 0;
+	unsigned int next_domain;
+	bool *domain_visited;
+	unsigned int perf_type, perf_config;
+	double perf_scale;
+	int fd_perf;
+
+	if (!pinfo)
+		return 0;
+
+	const size_t max_num_domains = MAX(topo.max_cpu_num + 1, MAX(topo.max_core_id + 1, topo.max_package_id + 1));
+
+	domain_visited = calloc(max_num_domains, sizeof(*domain_visited));
+
+	while (pinfo) {
+		switch (pinfo->scope) {
+		case SCOPE_CPU:
+			num_domains = topo.max_cpu_num + 1;
+			break;
+
+		case SCOPE_CORE:
+			num_domains = topo.max_core_id + 1;
+			break;
+
+		case SCOPE_PACKAGE:
+			num_domains = topo.max_package_id + 1;
+			break;
+		}
+
+		/* Allocate buffer for file descriptor for each domain. */
+		pinfo->fd_perf_per_domain = calloc(num_domains, sizeof(*pinfo->fd_perf_per_domain));
+		if (!pinfo->fd_perf_per_domain)
+			errx(1, "%s: alloc %s", __func__, "fd_perf_per_domain");
+
+		for (size_t i = 0; i < num_domains; ++i)
+			pinfo->fd_perf_per_domain[i] = -1;
+
+		pinfo->num_domains = num_domains;
+		pinfo->scale = 1.0;
+
+		memset(domain_visited, 0, max_num_domains * sizeof(*domain_visited));
+
+		for (int cpu = 0; cpu < topo.max_cpu_num + 1; ++cpu) {
+
+			next_domain = cpu_to_domain(pinfo, cpu);
+
+			assert(next_domain < num_domains);
+
+			if (cpu_is_not_allowed(cpu))
+				continue;
+
+			if (domain_visited[next_domain])
+				continue;
+
+			perf_type = read_perf_type(pinfo->device);
+			if (perf_type == (unsigned int)-1) {
+				warnx("%s: perf/%s/%s: failed to read %s",
+				      __func__, pinfo->device, pinfo->event, "type");
+				continue;
+			}
+
+			perf_config = read_rapl_config(pinfo->device, pinfo->event);
+			if (perf_config == (unsigned int)-1) {
+				warnx("%s: perf/%s/%s: failed to read %s",
+				      __func__, pinfo->device, pinfo->event, "config");
+				continue;
+			}
+
+			/* Scale is not required, some counters just don't have it. */
+			perf_scale = read_perf_rapl_scale(pinfo->device, pinfo->event);
+			if (perf_scale == 0.0)
+				perf_scale = 1.0;
+
+			fd_perf = open_perf_counter(cpu, perf_type, perf_config, -1, 0);
+			if (fd_perf == -1) {
+				warnx("%s: perf/%s/%s: failed to open counter on cpu%d",
+				      __func__, pinfo->device, pinfo->event, cpu);
+				continue;
+			}
+
+			domain_visited[next_domain] = 1;
+			pinfo->fd_perf_per_domain[next_domain] = fd_perf;
+			pinfo->scale = perf_scale;
+
+			if (debug)
+				printf("Add perf/%s/%s cpu%d: %d\n",
+				       pinfo->device, pinfo->event, cpu, pinfo->fd_perf_per_domain[next_domain]);
+		}
+
+		pinfo = pinfo->next;
+	}
+
+	free(domain_visited);
+
+	return 0;
+}
+
+void added_perf_counters_init(void)
+{
+	if (added_perf_counters_init_(sys.perf_tp))
+		errx(1, "%s: %s", __func__, "thread");
+
+	if (added_perf_counters_init_(sys.perf_cp))
+		errx(1, "%s: %s", __func__, "core");
+
+	if (added_perf_counters_init_(sys.perf_pp))
+		errx(1, "%s: %s", __func__, "package");
+}
+
 void turbostat_init()
 {
 	setup_all_buffers(true);
@@ -7872,6 +8299,7 @@ void turbostat_init()
 	linux_perf_init();
 	rapl_perf_init();
 	cstate_perf_init();
+	added_perf_counters_init();
 
 	for_all_cpus(get_cpu_type, ODD_COUNTERS);
 	for_all_cpus(get_cpu_type, EVEN_COUNTERS);
@@ -8061,6 +8489,7 @@ int add_counter(unsigned int msr_num, char *path, char *name,
 		msrp = calloc(1, sizeof(struct msr_counter));
 		if (msrp == NULL)
 			err(-1, "calloc msr_counter");
+
 		msrp->msr_num = msr_num;
 		strncpy(msrp->name, name, NAME_BYTES - 1);
 		msrp->width = width;
@@ -8101,11 +8530,106 @@ int add_counter(unsigned int msr_num, char *path, char *name,
 	return 0;
 }
 
+/*
+ * Initialize the fields used for identifying and opening the counter.
+ *
+ * Defer the initialization of any runtime buffers for actually reading
+ * the counters for when we initialize all perf counters, so we can later
+ * easily call re_initialize().
+ */
+struct perf_counter_info *make_perf_counter_info(const char *perf_device,
+						 const char *perf_event,
+						 const char *name,
+						 unsigned int width,
+						 enum counter_scope scope,
+						 enum counter_type type, enum counter_format format)
+{
+	struct perf_counter_info *pinfo;
+
+	pinfo = calloc(1, sizeof(*pinfo));
+	if (!pinfo)
+		errx(1, "%s: Failed to allocate %s/%s\n", __func__, perf_device, perf_event);
+
+	strncpy(pinfo->device, perf_device, ARRAY_SIZE(pinfo->device) - 1);
+	strncpy(pinfo->event, perf_event, ARRAY_SIZE(pinfo->event) - 1);
+
+	strncpy(pinfo->name, name, ARRAY_SIZE(pinfo->name) - 1);
+	pinfo->width = width;
+	pinfo->scope = scope;
+	pinfo->type = type;
+	pinfo->format = format;
+
+	return pinfo;
+}
+
+int add_perf_counter(const char *perf_device, const char *perf_event, const char *name_buffer, unsigned int width,
+		     enum counter_scope scope, enum counter_type type, enum counter_format format)
+{
+	struct perf_counter_info *pinfo;
+
+	switch (scope) {
+	case SCOPE_CPU:
+		if (sys.added_thread_perf_counters >= MAX_ADDED_THREAD_COUNTERS) {
+			warnx("ignoring thread counter perf/%s/%s", perf_device, perf_event);
+			return -1;
+		}
+		break;
+
+	case SCOPE_CORE:
+		if (sys.added_core_perf_counters >= MAX_ADDED_CORE_COUNTERS) {
+			warnx("ignoring core counter perf/%s/%s", perf_device, perf_event);
+			return -1;
+		}
+		break;
+
+	case SCOPE_PACKAGE:
+		if (sys.added_package_perf_counters >= MAX_ADDED_PACKAGE_COUNTERS) {
+			warnx("ignoring package counter perf/%s/%s", perf_device, perf_event);
+			return -1;
+		}
+		break;
+	}
+
+	pinfo = make_perf_counter_info(perf_device, perf_event, name_buffer, width, scope, type, format);
+
+	if (!pinfo)
+		return -1;
+
+	switch (scope) {
+	case SCOPE_CPU:
+		pinfo->next = sys.perf_tp;
+		sys.perf_tp = pinfo;
+		++sys.added_thread_perf_counters;
+		break;
+
+	case SCOPE_CORE:
+		pinfo->next = sys.perf_cp;
+		sys.perf_cp = pinfo;
+		++sys.added_core_perf_counters;
+		break;
+
+	case SCOPE_PACKAGE:
+		pinfo->next = sys.perf_pp;
+		sys.perf_pp = pinfo;
+		++sys.added_package_perf_counters;
+		break;
+	}
+
+	// FIXME: we might not have debug here yet
+	if (debug)
+		printf("%s: %s/%s, name: %s, scope%d\n",
+		       __func__, pinfo->device, pinfo->event, pinfo->name, pinfo->scope);
+
+	return 0;
+}
+
 void parse_add_command(char *add_command)
 {
 	int msr_num = 0;
 	char *path = NULL;
-	char name_buffer[NAME_BYTES] = "";
+	char perf_device[PERF_DEV_NAME_BYTES] = "";
+	char perf_event[PERF_EVT_NAME_BYTES] = "";
+	char name_buffer[PERF_NAME_BYTES] = "";
 	int width = 64;
 	int fail = 0;
 	enum counter_scope scope = SCOPE_CPU;
@@ -8120,6 +8644,11 @@ void parse_add_command(char *add_command)
 		if (sscanf(add_command, "msr%d", &msr_num) == 1)
 			goto next;
 
+		BUILD_BUG_ON(ARRAY_SIZE(perf_device) <= 31);
+		BUILD_BUG_ON(ARRAY_SIZE(perf_event) <= 31);
+		if (sscanf(add_command, "perf/%31[^/]/%31[^,]", &perf_device[0], &perf_event[0]) == 2)
+			goto next;
+
 		if (*add_command == '/') {
 			path = add_command;
 			goto next;
@@ -8167,7 +8696,8 @@ void parse_add_command(char *add_command)
 			goto next;
 		}
 
-		if (sscanf(add_command, "%18s,%*s", name_buffer) == 1) {	/* 18 < NAME_BYTES */
+		BUILD_BUG_ON(ARRAY_SIZE(name_buffer) <= 18);
+		if (sscanf(add_command, "%18s,%*s", name_buffer) == 1) {
 			char *eos;
 
 			eos = strchr(name_buffer, ',');
@@ -8184,21 +8714,33 @@ void parse_add_command(char *add_command)
 		}
 
 	}
-	if ((msr_num == 0) && (path == NULL)) {
-		fprintf(stderr, "--add: (msrDDD | msr0xXXX | /path_to_counter ) required\n");
+	if ((msr_num == 0) && (path == NULL) && (perf_device[0] == '\0' || perf_event[0] == '\0')) {
+		fprintf(stderr, "--add: (msrDDD | msr0xXXX | /path_to_counter | perf/device/event ) required\n");
 		fail++;
 	}
 
+	/* Test for non-empty perf_device and perf_event */
+	const bool is_perf_counter = perf_device[0] && perf_event[0];
+
 	/* generate default column header */
 	if (*name_buffer == '\0') {
-		if (width == 32)
-			sprintf(name_buffer, "M0x%x%s", msr_num, format == FORMAT_PERCENT ? "%" : "");
-		else
-			sprintf(name_buffer, "M0X%x%s", msr_num, format == FORMAT_PERCENT ? "%" : "");
+		if (is_perf_counter) {
+			snprintf(name_buffer, ARRAY_SIZE(name_buffer), "perf/%s", perf_event);
+		} else {
+			if (width == 32)
+				sprintf(name_buffer, "M0x%x%s", msr_num, format == FORMAT_PERCENT ? "%" : "");
+			else
+				sprintf(name_buffer, "M0X%x%s", msr_num, format == FORMAT_PERCENT ? "%" : "");
+		}
 	}
 
-	if (add_counter(msr_num, path, name_buffer, width, scope, type, format, 0, 0))
-		fail++;
+	if (is_perf_counter) {
+		if (add_perf_counter(perf_device, perf_event, name_buffer, width, scope, type, format))
+			fail++;
+	} else {
+		if (add_counter(msr_num, path, name_buffer, width, scope, type, format, 0, 0))
+			fail++;
+	}
 
 	if (fail) {
 		help();
-- 
2.43.0


