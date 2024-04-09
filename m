Return-Path: <linux-pm+bounces-6091-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B10889CF6F
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 02:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70C2BB2428A
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 00:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4727E8BE2;
	Tue,  9 Apr 2024 00:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CICaOOnX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB1A79CF
	for <linux-pm@vger.kernel.org>; Tue,  9 Apr 2024 00:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712622723; cv=none; b=AUBDKf4LOoTRGGf6CnaoqWCNmsBTeNBTclNDVbM/Pu8Cjjbpevay9lumEpL1zSGQjwO1UtLMPCjh8QaBeVYT43TyXytwEcdrr++Y6GBTOY2mQGKX+nJMh5MAkL+eSkDR3QjzbfLvvYJQIXUxnQz0HB53ooQiutKIgOCfajwf8y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712622723; c=relaxed/simple;
	bh=zjf5AEaP7uj90Gyi8coH49jsxMe32q4BTUQdiQaQZf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A14Xdq2LeSL47v624AYcC+RgQbr7IG1zIKT8ETcnnwTSQJ6BiTFUbeGF5SflKh20iU5wrOqhjf5FCjHFIU5gkRwKH1WR7pKeHvU69ClC02uvFXTzn7jtA/YzBKFcQXRuu1hlFM1PoXsqfzlAJUXjp9wXZAudRxI6BWKQ17gfFG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CICaOOnX; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dd161eb03afso4472541276.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2024 17:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712622719; x=1713227519; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9+I/8uzXnwLU+ZRXHmnaEOuEqCS/nMkpUJBVrhitEWg=;
        b=CICaOOnXbJYmBAcmMNGCYg5yeCopnGkl/oNQgRZqhfHppcrAxwIXDMlAD4GEZSYGMz
         BJEkLFMHnjUgZVZVC10ng/7Y01uQ94DmF56YMg9CUktE7QBhp45Tyqc58X3ZyBEbYBdv
         rxKXGvpp+V5tbqJoA6Kr6gHY3oTQOtYhLQxM8QICdfs97Z5LsIZPNr7dhZdlgUhsog8j
         3rgfHBrWjFq6vpqYLDJaK3iCsuJaKkZbCP6aq2JdEzDX3Sa6gOdpEsL+wG6TmfhxtzKQ
         dsr1QK4uSYcuNJBWxV3cP0FbP9gTrZ9FyBkd9V3gWWYi8yWqxdn5nvxVWyKfC0uuTZTJ
         14cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712622719; x=1713227519;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9+I/8uzXnwLU+ZRXHmnaEOuEqCS/nMkpUJBVrhitEWg=;
        b=jxO4SeQX2CygjwoPC1JW5qsHK5XBq5KRZlCcem5LqPEMs+urKF+Sqprj3DM8A0fE9g
         GXIzNzlFBP9K69zbWMd0kyEgY2NEqXajp6Ojn8PmnMxIMJW+YrD2/2ZEOrjo46wWlPsN
         3/0aWJScTlGsbhFTvBsdNKaSDg1K2HwS0yDbuapWMUblrx1GA+AE8S9FBqyso+RUS0hy
         07Dky2Z1inT+eP8Up2ciyIEJV3EfJ3IO0kuWW+8dScQ5zAdsuxlL2OM2ePBDCk/pTgB7
         3XuS2gIBX9owKXuLez4a5q//l7ILimyZr7lX/66hrQSUfBj30k6qZatv4SrqnhjRUp2M
         cBRA==
X-Gm-Message-State: AOJu0YzruKbIilMmsMUe5QgdH4gkWpFUvibfmmKfEgfZoQEOCtc5BbQw
	r7G0TQFsJEf5MbJjSsPkRjWXMoo7uDy+eF70yeo8NoGbHNdVqvhY/0+s2BaB
X-Google-Smtp-Source: AGHT+IEtrOvOLDGmnzjz+6x8mEUmtouiTSRA2CvBaxg5X192pg2MXSXO5+NUvKsAsY12srzsjMx36Q==
X-Received: by 2002:a5b:64f:0:b0:dc2:2e01:4ff0 with SMTP id o15-20020a5b064f000000b00dc22e014ff0mr8381867ybq.45.1712622718973;
        Mon, 08 Apr 2024 17:31:58 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net (2603-9000-9f01-67cf-100c-5508-c194-b194.inf6.spectrum.com. [2603:9000:9f01:67cf:100c:5508:c194:b194])
        by smtp.gmail.com with ESMTPSA id h6-20020a25e206000000b00dc74ac54f5fsm1531949ybe.63.2024.04.08.17.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 17:31:58 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 17/26] tools/power turbostat: read RAPL counters via perf
Date: Mon,  8 Apr 2024 20:31:11 -0400
Message-Id: <ec16f0a157968246a93eabb1e719b817f32ff996.1712621427.git.len.brown@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e5f4e68eed85fa8495d78cd966eecc2b27bb9e53.1712621427.git.len.brown@intel.com>
References: <e5f4e68eed85fa8495d78cd966eecc2b27bb9e53.1712621427.git.len.brown@intel.com>
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

Some of the future Intel platforms will require reading the RAPL
counters via perf and not MSR. On current platforms we can still read
them using both ways.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 784 +++++++++++++++++++++-----
 1 file changed, 646 insertions(+), 138 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index a380829c5890..e813831e73a5 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -37,6 +37,7 @@
 #include <asm/unistd.h>
 #include <stdbool.h>
 #include <assert.h>
+#include <linux/kernel.h>
 
 #define UNUSED(x) (void)(x)
 
@@ -60,6 +61,7 @@ enum counter_scope { SCOPE_CPU, SCOPE_CORE, SCOPE_PACKAGE };
 enum counter_type { COUNTER_ITEMS, COUNTER_CYCLES, COUNTER_SECONDS, COUNTER_USEC };
 enum counter_format { FORMAT_RAW, FORMAT_DELTA, FORMAT_PERCENT };
 enum amperf_source { AMPERF_SOURCE_PERF, AMPERF_SOURCE_MSR };
+enum rapl_source { RAPL_SOURCE_NONE, RAPL_SOURCE_PERF, RAPL_SOURCE_MSR };
 
 struct msr_counter {
 	unsigned int msr_num;
@@ -958,6 +960,175 @@ size_t cpu_present_setsize, cpu_effective_setsize, cpu_allowed_setsize, cpu_affi
 #define MAX_ADDED_THREAD_COUNTERS 24
 #define BITMASK_SIZE 32
 
+/* Indexes used to map data read from perf and MSRs into global variables */
+enum rapl_rci_index {
+	RAPL_RCI_INDEX_ENERGY_PKG = 0,
+	RAPL_RCI_INDEX_ENERGY_CORES = 1,
+	RAPL_RCI_INDEX_DRAM = 2,
+	RAPL_RCI_INDEX_GFX = 3,
+	RAPL_RCI_INDEX_PKG_PERF_STATUS = 4,
+	RAPL_RCI_INDEX_DRAM_PERF_STATUS = 5,
+	RAPL_RCI_INDEX_CORE_ENERGY = 6,
+	NUM_RAPL_COUNTERS,
+};
+
+enum rapl_unit {
+	RAPL_UNIT_INVALID,
+	RAPL_UNIT_JOULES,
+	RAPL_UNIT_WATTS,
+};
+
+struct rapl_counter_info_t {
+	unsigned long long data[NUM_RAPL_COUNTERS];
+	enum rapl_source source[NUM_RAPL_COUNTERS];
+	unsigned long long flags[NUM_RAPL_COUNTERS];
+	double scale[NUM_RAPL_COUNTERS];
+	enum rapl_unit unit[NUM_RAPL_COUNTERS];
+
+	union {
+		/* Active when source == RAPL_SOURCE_MSR */
+		struct {
+			unsigned long long msr[NUM_RAPL_COUNTERS];
+			unsigned long long msr_mask[NUM_RAPL_COUNTERS];
+			int msr_shift[NUM_RAPL_COUNTERS];
+		};
+	};
+
+	int fd_perf;
+};
+
+/* struct rapl_counter_info_t for each RAPL domain */
+struct rapl_counter_info_t *rapl_counter_info_perdomain;
+
+#define RAPL_COUNTER_FLAG_USE_MSR_SUM (1u << 1)
+
+struct rapl_counter_arch_info {
+	int feature_mask;	/* Mask for testing if the counter is supported on host */
+	const char *perf_subsys;
+	const char *perf_name;
+	unsigned long long msr;
+	unsigned long long msr_mask;
+	int msr_shift;		/* Positive mean shift right, negative mean shift left */
+	double *platform_rapl_msr_scale;	/* Scale applied to values read by MSR (platform dependent, filled at runtime) */
+	unsigned int rci_index;	/* Maps data from perf counters to global variables */
+	unsigned long long bic;
+	double compat_scale;	/* Some counters require constant scaling to be in the same range as other, similar ones */
+	unsigned long long flags;
+};
+
+static const struct rapl_counter_arch_info rapl_counter_arch_infos[] = {
+	{
+	 .feature_mask = RAPL_PKG,
+	 .perf_subsys = "power",
+	 .perf_name = "energy-pkg",
+	 .msr = MSR_PKG_ENERGY_STATUS,
+	 .msr_mask = 0xFFFFFFFFFFFFFFFF,
+	 .msr_shift = 0,
+	 .platform_rapl_msr_scale = &rapl_energy_units,
+	 .rci_index = RAPL_RCI_INDEX_ENERGY_PKG,
+	 .bic = BIC_PkgWatt | BIC_Pkg_J,
+	 .compat_scale = 1.0,
+	 .flags = RAPL_COUNTER_FLAG_USE_MSR_SUM,
+	  },
+	{
+	 .feature_mask = RAPL_AMD_F17H,
+	 .perf_subsys = "power",
+	 .perf_name = "energy-pkg",
+	 .msr = MSR_PKG_ENERGY_STAT,
+	 .msr_mask = 0xFFFFFFFFFFFFFFFF,
+	 .msr_shift = 0,
+	 .platform_rapl_msr_scale = &rapl_energy_units,
+	 .rci_index = RAPL_RCI_INDEX_ENERGY_PKG,
+	 .bic = BIC_PkgWatt | BIC_Pkg_J,
+	 .compat_scale = 1.0,
+	 .flags = RAPL_COUNTER_FLAG_USE_MSR_SUM,
+	  },
+	{
+	 .feature_mask = RAPL_CORE_ENERGY_STATUS,
+	 .perf_subsys = "power",
+	 .perf_name = "energy-cores",
+	 .msr = MSR_PP0_ENERGY_STATUS,
+	 .msr_mask = 0xFFFFFFFFFFFFFFFF,
+	 .msr_shift = 0,
+	 .platform_rapl_msr_scale = &rapl_energy_units,
+	 .rci_index = RAPL_RCI_INDEX_ENERGY_CORES,
+	 .bic = BIC_CorWatt | BIC_Cor_J,
+	 .compat_scale = 1.0,
+	 .flags = RAPL_COUNTER_FLAG_USE_MSR_SUM,
+	  },
+	{
+	 .feature_mask = RAPL_DRAM,
+	 .perf_subsys = "power",
+	 .perf_name = "energy-ram",
+	 .msr = MSR_DRAM_ENERGY_STATUS,
+	 .msr_mask = 0xFFFFFFFFFFFFFFFF,
+	 .msr_shift = 0,
+	 .platform_rapl_msr_scale = &rapl_dram_energy_units,
+	 .rci_index = RAPL_RCI_INDEX_DRAM,
+	 .bic = BIC_RAMWatt | BIC_RAM_J,
+	 .compat_scale = 1.0,
+	 .flags = RAPL_COUNTER_FLAG_USE_MSR_SUM,
+	  },
+	{
+	 .feature_mask = RAPL_GFX,
+	 .perf_subsys = "power",
+	 .perf_name = "energy-gpu",
+	 .msr = MSR_PP1_ENERGY_STATUS,
+	 .msr_mask = 0xFFFFFFFFFFFFFFFF,
+	 .msr_shift = 0,
+	 .platform_rapl_msr_scale = &rapl_energy_units,
+	 .rci_index = RAPL_RCI_INDEX_GFX,
+	 .bic = BIC_GFXWatt | BIC_GFX_J,
+	 .compat_scale = 1.0,
+	 .flags = RAPL_COUNTER_FLAG_USE_MSR_SUM,
+	  },
+	{
+	 .feature_mask = RAPL_PKG_PERF_STATUS,
+	 .perf_subsys = NULL,
+	 .perf_name = NULL,
+	 .msr = MSR_PKG_PERF_STATUS,
+	 .msr_mask = 0xFFFFFFFFFFFFFFFF,
+	 .msr_shift = 0,
+	 .platform_rapl_msr_scale = &rapl_time_units,
+	 .rci_index = RAPL_RCI_INDEX_PKG_PERF_STATUS,
+	 .bic = BIC_PKG__,
+	 .compat_scale = 100.0,
+	 .flags = RAPL_COUNTER_FLAG_USE_MSR_SUM,
+	  },
+	{
+	 .feature_mask = RAPL_DRAM_PERF_STATUS,
+	 .perf_subsys = NULL,
+	 .perf_name = NULL,
+	 .msr = MSR_DRAM_PERF_STATUS,
+	 .msr_mask = 0xFFFFFFFFFFFFFFFF,
+	 .msr_shift = 0,
+	 .platform_rapl_msr_scale = &rapl_time_units,
+	 .rci_index = RAPL_RCI_INDEX_DRAM_PERF_STATUS,
+	 .bic = BIC_RAM__,
+	 .compat_scale = 100.0,
+	 .flags = RAPL_COUNTER_FLAG_USE_MSR_SUM,
+	  },
+	{
+	 .feature_mask = RAPL_AMD_F17H,
+	 .perf_subsys = NULL,
+	 .perf_name = NULL,
+	 .msr = MSR_CORE_ENERGY_STAT,
+	 .msr_mask = 0xFFFFFFFF,
+	 .msr_shift = 0,
+	 .platform_rapl_msr_scale = &rapl_energy_units,
+	 .rci_index = RAPL_RCI_INDEX_CORE_ENERGY,
+	 .bic = BIC_CorWatt | BIC_Cor_J,
+	 .compat_scale = 1.0,
+	 .flags = 0,
+	  },
+};
+
+struct rapl_counter {
+	unsigned long long raw_value;
+	enum rapl_unit unit;
+	double scale;
+};
+
 struct thread_data {
 	struct timeval tv_begin;
 	struct timeval tv_end;
@@ -984,7 +1155,7 @@ struct core_data {
 	unsigned long long c7;
 	unsigned long long mc6_us;	/* duplicate as per-core for now, even though per module */
 	unsigned int core_temp_c;
-	unsigned int core_energy;	/* MSR_CORE_ENERGY_STAT */
+	struct rapl_counter core_energy;	/* MSR_CORE_ENERGY_STAT */
 	unsigned int core_id;
 	unsigned long long core_throt_cnt;
 	unsigned long long counter[MAX_ADDED_COUNTERS];
@@ -1009,12 +1180,12 @@ struct pkg_data {
 	unsigned int gfx_mhz;
 	unsigned int gfx_act_mhz;
 	unsigned int package_id;
-	unsigned long long energy_pkg;	/* MSR_PKG_ENERGY_STATUS */
-	unsigned long long energy_dram;	/* MSR_DRAM_ENERGY_STATUS */
-	unsigned long long energy_cores;	/* MSR_PP0_ENERGY_STATUS */
-	unsigned long long energy_gfx;	/* MSR_PP1_ENERGY_STATUS */
-	unsigned long long rapl_pkg_perf_status;	/* MSR_PKG_PERF_STATUS */
-	unsigned long long rapl_dram_perf_status;	/* MSR_DRAM_PERF_STATUS */
+	struct rapl_counter energy_pkg;	/* MSR_PKG_ENERGY_STATUS */
+	struct rapl_counter energy_dram;	/* MSR_DRAM_ENERGY_STATUS */
+	struct rapl_counter energy_cores;	/* MSR_PP0_ENERGY_STATUS */
+	struct rapl_counter energy_gfx;	/* MSR_PP1_ENERGY_STATUS */
+	struct rapl_counter rapl_pkg_perf_status;	/* MSR_PKG_PERF_STATUS */
+	struct rapl_counter rapl_dram_perf_status;	/* MSR_DRAM_PERF_STATUS */
 	unsigned int pkg_temp_c;
 	unsigned int uncore_mhz;
 	unsigned long long counter[MAX_ADDED_COUNTERS];
@@ -1403,6 +1574,21 @@ int get_msr(int cpu, off_t offset, unsigned long long *msr)
 	return 0;
 }
 
+int probe_msr(int cpu, off_t offset)
+{
+	ssize_t retval;
+	unsigned long long dummy;
+
+	assert(!no_msr);
+
+	retval = pread(get_msr_fd(cpu), &dummy, sizeof(dummy), offset);
+
+	if (retval != sizeof(dummy))
+		return 1;
+
+	return 0;
+}
+
 #define MAX_DEFERRED 16
 char *deferred_add_names[MAX_DEFERRED];
 char *deferred_skip_names[MAX_DEFERRED];
@@ -1755,7 +1941,11 @@ int dump_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p
 		outp += sprintf(outp, "c7: %016llX\n", c->c7);
 		outp += sprintf(outp, "DTS: %dC\n", c->core_temp_c);
 		outp += sprintf(outp, "cpu_throt_count: %016llX\n", c->core_throt_cnt);
-		outp += sprintf(outp, "Joules: %0X\n", c->core_energy);
+
+		const unsigned long long energy_value = c->core_energy.raw_value * c->core_energy.scale;
+		const double energy_scale = c->core_energy.scale;
+		if (c->core_energy.unit == RAPL_UNIT_JOULES)
+			outp += sprintf(outp, "Joules: %0llX (scale: %lf)\n", energy_value, energy_scale);
 
 		for (i = 0, mp = sys.cp; mp; i++, mp = mp->next) {
 			outp +=
@@ -1785,12 +1975,12 @@ int dump_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p
 		outp += sprintf(outp, "pc10: %016llX\n", p->pc10);
 		outp += sprintf(outp, "cpu_lpi: %016llX\n", p->cpu_lpi);
 		outp += sprintf(outp, "sys_lpi: %016llX\n", p->sys_lpi);
-		outp += sprintf(outp, "Joules PKG: %0llX\n", p->energy_pkg);
-		outp += sprintf(outp, "Joules COR: %0llX\n", p->energy_cores);
-		outp += sprintf(outp, "Joules GFX: %0llX\n", p->energy_gfx);
-		outp += sprintf(outp, "Joules RAM: %0llX\n", p->energy_dram);
-		outp += sprintf(outp, "Throttle PKG: %0llX\n", p->rapl_pkg_perf_status);
-		outp += sprintf(outp, "Throttle RAM: %0llX\n", p->rapl_dram_perf_status);
+		outp += sprintf(outp, "Joules PKG: %0llX\n", p->energy_pkg.raw_value);
+		outp += sprintf(outp, "Joules COR: %0llX\n", p->energy_cores.raw_value);
+		outp += sprintf(outp, "Joules GFX: %0llX\n", p->energy_gfx.raw_value);
+		outp += sprintf(outp, "Joules RAM: %0llX\n", p->energy_dram.raw_value);
+		outp += sprintf(outp, "Throttle PKG: %0llX\n", p->rapl_pkg_perf_status.raw_value);
+		outp += sprintf(outp, "Throttle RAM: %0llX\n", p->rapl_dram_perf_status.raw_value);
 		outp += sprintf(outp, "PTM: %dC\n", p->pkg_temp_c);
 
 		for (i = 0, mp = sys.pp; mp; i++, mp = mp->next) {
@@ -1805,6 +1995,23 @@ int dump_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p
 	return 0;
 }
 
+double rapl_counter_get_value(const struct rapl_counter *c, enum rapl_unit desired_unit, double interval)
+{
+	assert(desired_unit != RAPL_UNIT_INVALID);
+
+	/*
+	 * For now we don't expect anything other than joules,
+	 * so just simplify the logic.
+	 */
+	assert(c->unit == RAPL_UNIT_JOULES);
+
+	const double scaled = c->raw_value * c->scale;
+
+	if (desired_unit == RAPL_UNIT_WATTS)
+		return scaled / interval;
+	return scaled;
+}
+
 /*
  * column formatting convention & formats
  */
@@ -1998,9 +2205,11 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 
 	if (DO_BIC(BIC_CorWatt) && platform->has_per_core_rapl)
 		outp +=
-		    sprintf(outp, fmt8, (printed++ ? delim : ""), c->core_energy * rapl_energy_units / interval_float);
+		    sprintf(outp, fmt8, (printed++ ? delim : ""),
+			    rapl_counter_get_value(&c->core_energy, RAPL_UNIT_WATTS, interval_float));
 	if (DO_BIC(BIC_Cor_J) && platform->has_per_core_rapl)
-		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), c->core_energy * rapl_energy_units);
+		outp += sprintf(outp, fmt8, (printed++ ? delim : ""),
+				rapl_counter_get_value(&c->core_energy, RAPL_UNIT_JOULES, interval_float));
 
 	/* print per-package data only for 1st core in package */
 	if (!is_cpu_first_core_in_package(t, c, p))
@@ -2072,34 +2281,40 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 
 	if (DO_BIC(BIC_PkgWatt))
 		outp +=
-		    sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_pkg * rapl_energy_units / interval_float);
-
+		    sprintf(outp, fmt8, (printed++ ? delim : ""),
+			    rapl_counter_get_value(&p->energy_pkg, RAPL_UNIT_WATTS, interval_float));
 	if (DO_BIC(BIC_CorWatt) && !platform->has_per_core_rapl)
 		outp +=
-		    sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_cores * rapl_energy_units / interval_float);
+		    sprintf(outp, fmt8, (printed++ ? delim : ""),
+			    rapl_counter_get_value(&p->energy_cores, RAPL_UNIT_WATTS, interval_float));
 	if (DO_BIC(BIC_GFXWatt))
 		outp +=
-		    sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_gfx * rapl_energy_units / interval_float);
+		    sprintf(outp, fmt8, (printed++ ? delim : ""),
+			    rapl_counter_get_value(&p->energy_gfx, RAPL_UNIT_WATTS, interval_float));
 	if (DO_BIC(BIC_RAMWatt))
 		outp +=
 		    sprintf(outp, fmt8, (printed++ ? delim : ""),
-			    p->energy_dram * rapl_dram_energy_units / interval_float);
+			    rapl_counter_get_value(&p->energy_dram, RAPL_UNIT_WATTS, interval_float));
 	if (DO_BIC(BIC_Pkg_J))
-		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_pkg * rapl_energy_units);
+		outp += sprintf(outp, fmt8, (printed++ ? delim : ""),
+				rapl_counter_get_value(&p->energy_pkg, RAPL_UNIT_JOULES, interval_float));
 	if (DO_BIC(BIC_Cor_J) && !platform->has_per_core_rapl)
-		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_cores * rapl_energy_units);
+		outp += sprintf(outp, fmt8, (printed++ ? delim : ""),
+				rapl_counter_get_value(&p->energy_cores, RAPL_UNIT_JOULES, interval_float));
 	if (DO_BIC(BIC_GFX_J))
-		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_gfx * rapl_energy_units);
+		outp += sprintf(outp, fmt8, (printed++ ? delim : ""),
+				rapl_counter_get_value(&p->energy_gfx, RAPL_UNIT_JOULES, interval_float));
 	if (DO_BIC(BIC_RAM_J))
-		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_dram * rapl_dram_energy_units);
+		outp += sprintf(outp, fmt8, (printed++ ? delim : ""),
+				rapl_counter_get_value(&p->energy_dram, RAPL_UNIT_JOULES, interval_float));
 	if (DO_BIC(BIC_PKG__))
 		outp +=
 		    sprintf(outp, fmt8, (printed++ ? delim : ""),
-			    100.0 * p->rapl_pkg_perf_status * rapl_time_units / interval_float);
+			    rapl_counter_get_value(&p->rapl_pkg_perf_status, RAPL_UNIT_WATTS, interval_float));
 	if (DO_BIC(BIC_RAM__))
 		outp +=
 		    sprintf(outp, fmt8, (printed++ ? delim : ""),
-			    100.0 * p->rapl_dram_perf_status * rapl_time_units / interval_float);
+			    rapl_counter_get_value(&p->rapl_dram_perf_status, RAPL_UNIT_WATTS, interval_float));
 	/* UncMHz */
 	if (DO_BIC(BIC_UNCORE_MHZ))
 		outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), p->uncore_mhz);
@@ -2208,12 +2423,13 @@ int delta_package(struct pkg_data *new, struct pkg_data *old)
 	old->gfx_mhz = new->gfx_mhz;
 	old->gfx_act_mhz = new->gfx_act_mhz;
 
-	old->energy_pkg = new->energy_pkg - old->energy_pkg;
-	old->energy_cores = new->energy_cores - old->energy_cores;
-	old->energy_gfx = new->energy_gfx - old->energy_gfx;
-	old->energy_dram = new->energy_dram - old->energy_dram;
-	old->rapl_pkg_perf_status = new->rapl_pkg_perf_status - old->rapl_pkg_perf_status;
-	old->rapl_dram_perf_status = new->rapl_dram_perf_status - old->rapl_dram_perf_status;
+	old->energy_pkg.raw_value = new->energy_pkg.raw_value - old->energy_pkg.raw_value;
+	old->energy_cores.raw_value = new->energy_cores.raw_value - old->energy_cores.raw_value;
+	old->energy_gfx.raw_value = new->energy_gfx.raw_value - old->energy_gfx.raw_value;
+	old->energy_dram.raw_value = new->energy_dram.raw_value - old->energy_dram.raw_value;
+	old->rapl_pkg_perf_status.raw_value = new->rapl_pkg_perf_status.raw_value - old->rapl_pkg_perf_status.raw_value;
+	old->rapl_dram_perf_status.raw_value =
+	    new->rapl_dram_perf_status.raw_value - old->rapl_dram_perf_status.raw_value;
 
 	for (i = 0, mp = sys.pp; mp; i++, mp = mp->next) {
 		if (mp->format == FORMAT_RAW)
@@ -2237,7 +2453,7 @@ void delta_core(struct core_data *new, struct core_data *old)
 	old->core_throt_cnt = new->core_throt_cnt;
 	old->mc6_us = new->mc6_us - old->mc6_us;
 
-	DELTA_WRAP32(new->core_energy, old->core_energy);
+	DELTA_WRAP32(new->core_energy.raw_value, old->core_energy.raw_value);
 
 	for (i = 0, mp = sys.cp; mp; i++, mp = mp->next) {
 		if (mp->format == FORMAT_RAW)
@@ -2364,6 +2580,13 @@ int delta_cpu(struct thread_data *t, struct core_data *c,
 	return retval;
 }
 
+void rapl_counter_clear(struct rapl_counter *c)
+{
+	c->raw_value = 0;
+	c->scale = 0.0;
+	c->unit = RAPL_UNIT_INVALID;
+}
+
 void clear_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 {
 	int i;
@@ -2391,7 +2614,7 @@ void clear_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 	c->c7 = 0;
 	c->mc6_us = 0;
 	c->core_temp_c = 0;
-	c->core_energy = 0;
+	rapl_counter_clear(&c->core_energy);
 	c->core_throt_cnt = 0;
 
 	p->pkg_wtd_core_c0 = 0;
@@ -2412,12 +2635,12 @@ void clear_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 	p->cpu_lpi = 0;
 	p->sys_lpi = 0;
 
-	p->energy_pkg = 0;
-	p->energy_dram = 0;
-	p->energy_cores = 0;
-	p->energy_gfx = 0;
-	p->rapl_pkg_perf_status = 0;
-	p->rapl_dram_perf_status = 0;
+	rapl_counter_clear(&p->energy_pkg);
+	rapl_counter_clear(&p->energy_dram);
+	rapl_counter_clear(&p->energy_cores);
+	rapl_counter_clear(&p->energy_gfx);
+	rapl_counter_clear(&p->rapl_pkg_perf_status);
+	rapl_counter_clear(&p->rapl_dram_perf_status);
 	p->pkg_temp_c = 0;
 
 	p->gfx_rc6_ms = 0;
@@ -2434,6 +2657,20 @@ void clear_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 		p->counter[i] = 0;
 }
 
+void rapl_counter_accumulate(struct rapl_counter *dst, const struct rapl_counter *src)
+{
+	/* Copy unit and scale from src if dst is not initialized */
+	if (dst->unit == RAPL_UNIT_INVALID) {
+		dst->unit = src->unit;
+		dst->scale = src->scale;
+	}
+
+	assert(dst->unit == src->unit);
+	assert(dst->scale == src->scale);
+
+	dst->raw_value += src->raw_value;
+}
+
 int sum_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 {
 	int i;
@@ -2480,7 +2717,7 @@ int sum_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	average.cores.core_temp_c = MAX(average.cores.core_temp_c, c->core_temp_c);
 	average.cores.core_throt_cnt = MAX(average.cores.core_throt_cnt, c->core_throt_cnt);
 
-	average.cores.core_energy += c->core_energy;
+	rapl_counter_accumulate(&average.cores.core_energy, &c->core_energy);
 
 	for (i = 0, mp = sys.cp; mp; i++, mp = mp->next) {
 		if (mp->format == FORMAT_RAW)
@@ -2515,10 +2752,10 @@ int sum_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	average.packages.cpu_lpi = p->cpu_lpi;
 	average.packages.sys_lpi = p->sys_lpi;
 
-	average.packages.energy_pkg += p->energy_pkg;
-	average.packages.energy_dram += p->energy_dram;
-	average.packages.energy_cores += p->energy_cores;
-	average.packages.energy_gfx += p->energy_gfx;
+	rapl_counter_accumulate(&average.packages.energy_pkg, &p->energy_pkg);
+	rapl_counter_accumulate(&average.packages.energy_dram, &p->energy_dram);
+	rapl_counter_accumulate(&average.packages.energy_cores, &p->energy_cores);
+	rapl_counter_accumulate(&average.packages.energy_gfx, &p->energy_gfx);
 
 	average.packages.gfx_rc6_ms = p->gfx_rc6_ms;
 	average.packages.uncore_mhz = p->uncore_mhz;
@@ -2527,8 +2764,8 @@ int sum_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 
 	average.packages.pkg_temp_c = MAX(average.packages.pkg_temp_c, p->pkg_temp_c);
 
-	average.packages.rapl_pkg_perf_status += p->rapl_pkg_perf_status;
-	average.packages.rapl_dram_perf_status += p->rapl_dram_perf_status;
+	rapl_counter_accumulate(&average.packages.rapl_pkg_perf_status, &p->rapl_pkg_perf_status);
+	rapl_counter_accumulate(&average.packages.rapl_dram_perf_status, &p->rapl_dram_perf_status);
 
 	for (i = 0, mp = sys.pp; mp; i++, mp = mp->next) {
 		if ((mp->format == FORMAT_RAW) && (topo.num_packages == 0))
@@ -2797,25 +3034,53 @@ struct amperf_group_fd {
 	int mperf;
 };
 
-static unsigned int read_perf_counter_info(const char *const path, const char *const parse_format)
+static int read_perf_counter_info(const char *const path, const char *const parse_format, void *value_ptr)
 {
 	int fdmt;
-	char buf[16];
-	unsigned int v;
+	int bytes_read;
+	char buf[64];
+	int ret = -1;
 
 	fdmt = open(path, O_RDONLY, 0);
-	if (fdmt == -1)
-		errx(1, "Failed to read perf counter info %s\n", path);
+	if (fdmt == -1) {
+		if (debug)
+			fprintf(stderr, "Failed to parse perf counter info %s\n", path);
+		ret = -1;
+		goto cleanup_and_exit;
+	}
 
-	if (read(fdmt, buf, sizeof(buf)) <= 0)
-		return 0;
+	bytes_read = read(fdmt, buf, sizeof(buf) - 1);
+	if (bytes_read <= 0 || bytes_read >= (int)sizeof(buf)) {
+		if (debug)
+			fprintf(stderr, "Failed to parse perf counter info %s\n", path);
+		ret = -1;
+		goto cleanup_and_exit;
+	}
 
-	buf[sizeof(buf) - 1] = '\0';
+	buf[bytes_read] = '\0';
 
-	if (sscanf(buf, parse_format, &v) != 1)
-		errx(1, "Failed to parse perf counter info %s\n", path);
+	if (sscanf(buf, parse_format, value_ptr) != 1) {
+		if (debug)
+			fprintf(stderr, "Failed to parse perf counter info %s\n", path);
+		ret = -1;
+		goto cleanup_and_exit;
+	}
 
+	ret = 0;
+
+cleanup_and_exit:
 	close(fdmt);
+	return ret;
+}
+
+static unsigned int read_perf_counter_info_n(const char *const path, const char *const parse_format)
+{
+	unsigned int v;
+	int status;
+
+	status = read_perf_counter_info(path, parse_format, &v);
+	if (status)
+		v = -1;
 
 	return v;
 }
@@ -2825,7 +3090,7 @@ static unsigned read_msr_type(void)
 	const char *const path = "/sys/bus/event_source/devices/msr/type";
 	const char *const format = "%u";
 
-	return read_perf_counter_info(path, format);
+	return read_perf_counter_info_n(path, format);
 }
 
 static unsigned read_aperf_config(void)
@@ -2833,7 +3098,7 @@ static unsigned read_aperf_config(void)
 	const char *const path = "/sys/bus/event_source/devices/msr/events/aperf";
 	const char *const format = "event=%x";
 
-	return read_perf_counter_info(path, format);
+	return read_perf_counter_info_n(path, format);
 }
 
 static unsigned read_mperf_config(void)
@@ -2841,7 +3106,60 @@ static unsigned read_mperf_config(void)
 	const char *const path = "/sys/bus/event_source/devices/msr/events/mperf";
 	const char *const format = "event=%x";
 
-	return read_perf_counter_info(path, format);
+	return read_perf_counter_info_n(path, format);
+}
+
+static unsigned read_perf_type(const char *subsys)
+{
+	const char *const path_format = "/sys/bus/event_source/devices/%s/type";
+	const char *const format = "%u";
+	char path[128];
+
+	snprintf(path, sizeof(path), path_format, subsys);
+
+	return read_perf_counter_info_n(path, format);
+}
+
+static unsigned read_rapl_config(const char *subsys, const char *event_name)
+{
+	const char *const path_format = "/sys/bus/event_source/devices/%s/events/%s";
+	const char *const format = "event=%x";
+	char path[128];
+
+	snprintf(path, sizeof(path), path_format, subsys, event_name);
+
+	return read_perf_counter_info_n(path, format);
+}
+
+static unsigned read_perf_rapl_unit(const char *subsys, const char *event_name)
+{
+	const char *const path_format = "/sys/bus/event_source/devices/%s/events/%s.unit";
+	const char *const format = "%s";
+	char path[128];
+	char unit_buffer[16];
+
+	snprintf(path, sizeof(path), path_format, subsys, event_name);
+
+	read_perf_counter_info(path, format, &unit_buffer);
+	if (strcmp("Joules", unit_buffer) == 0)
+		return RAPL_UNIT_JOULES;
+
+	return RAPL_UNIT_INVALID;
+}
+
+static double read_perf_rapl_scale(const char *subsys, const char *event_name)
+{
+	const char *const path_format = "/sys/bus/event_source/devices/%s/events/%s.scale";
+	const char *const format = "%lf";
+	char path[128];
+	double scale;
+
+	snprintf(path, sizeof(path), path_format, subsys, event_name);
+
+	if (read_perf_counter_info(path, format, &scale))
+		return 0.0;
+
+	return scale;
 }
 
 static struct amperf_group_fd open_amperf_fd(int cpu)
@@ -2961,6 +3279,99 @@ static int read_aperf_mperf_tsc_msr(struct thread_data *t, int cpu)
 	return 0;
 }
 
+size_t rapl_counter_info_count_perf(const struct rapl_counter_info_t *rci)
+{
+	size_t ret = 0;
+
+	for (int i = 0; i < NUM_RAPL_COUNTERS; ++i)
+		if (rci->source[i] == RAPL_SOURCE_PERF)
+			++ret;
+
+	return ret;
+}
+
+void write_rapl_counter(struct rapl_counter *rc, struct rapl_counter_info_t *rci, unsigned int idx)
+{
+	rc->raw_value = rci->data[idx];
+	rc->unit = rci->unit[idx];
+	rc->scale = rci->scale[idx];
+}
+
+int get_rapl_counters(int cpu, int domain, struct core_data *c, struct pkg_data *p)
+{
+	unsigned long long perf_data[NUM_RAPL_COUNTERS + 1];
+	struct rapl_counter_info_t *rci = &rapl_counter_info_perdomain[domain];
+
+	if (debug)
+		fprintf(stderr, "get_rapl_counters: cpu%d domain%d\n", cpu, domain);
+
+	assert(rapl_counter_info_perdomain);
+
+	/*
+	 * If we have any perf counters to read, read them all now, in bulk
+	 */
+	if (rci->fd_perf != -1) {
+		size_t num_perf_counters = rapl_counter_info_count_perf(rci);
+		const ssize_t expected_read_size = (num_perf_counters + 1) * sizeof(unsigned long long);
+		const ssize_t actual_read_size = read(rci->fd_perf, &perf_data[0], sizeof(perf_data));
+		if (actual_read_size != expected_read_size)
+			err(-1, "get_rapl_counters: failed to read perf_data (%zu %zu)", expected_read_size,
+			    actual_read_size);
+	}
+
+	for (unsigned int i = 0, pi = 1; i < NUM_RAPL_COUNTERS; ++i) {
+		switch (rci->source[i]) {
+		case RAPL_SOURCE_NONE:
+			break;
+
+		case RAPL_SOURCE_PERF:
+			assert(pi < ARRAY_SIZE(perf_data));
+			assert(rci->fd_perf != -1);
+
+			if (debug)
+				fprintf(stderr, "Reading rapl counter via perf at %u (%llu %e %lf)\n",
+					i, perf_data[pi], rci->scale[i], perf_data[pi] * rci->scale[i]);
+
+			rci->data[i] = perf_data[pi];
+
+			++pi;
+			break;
+
+		case RAPL_SOURCE_MSR:
+			if (debug)
+				fprintf(stderr, "Reading rapl counter via msr at %u\n", i);
+
+			assert(!no_msr);
+			if (rci->flags[i] & RAPL_COUNTER_FLAG_USE_MSR_SUM) {
+				if (get_msr_sum(cpu, rci->msr[i], &rci->data[i]))
+					return -13 - i;
+			} else {
+				if (get_msr(cpu, rci->msr[i], &rci->data[i]))
+					return -13 - i;
+			}
+
+			rci->data[i] &= rci->msr_mask[i];
+			if (rci->msr_shift[i] >= 0)
+				rci->data[i] >>= abs(rci->msr_shift[i]);
+			else
+				rci->data[i] <<= abs(rci->msr_shift[i]);
+
+			break;
+		}
+	}
+
+	_Static_assert(NUM_RAPL_COUNTERS == 7);
+	write_rapl_counter(&p->energy_pkg, rci, RAPL_RCI_INDEX_ENERGY_PKG);
+	write_rapl_counter(&p->energy_cores, rci, RAPL_RCI_INDEX_ENERGY_CORES);
+	write_rapl_counter(&p->energy_dram, rci, RAPL_RCI_INDEX_DRAM);
+	write_rapl_counter(&p->energy_gfx, rci, RAPL_RCI_INDEX_GFX);
+	write_rapl_counter(&p->rapl_pkg_perf_status, rci, RAPL_RCI_INDEX_PKG_PERF_STATUS);
+	write_rapl_counter(&p->rapl_dram_perf_status, rci, RAPL_RCI_INDEX_DRAM_PERF_STATUS);
+	write_rapl_counter(&c->core_energy, rci, RAPL_RCI_INDEX_CORE_ENERGY);
+
+	return 0;
+}
+
 /*
  * get_counters(...)
  * migrate to cpu
@@ -2972,6 +3383,7 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	unsigned long long msr;
 	struct msr_counter *mp;
 	int i;
+	int status;
 
 	if (cpu_migrate(cpu)) {
 		fprintf(outf, "get_counters: Could not migrate to CPU %d\n", cpu);
@@ -3029,6 +3441,12 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	if (!is_cpu_first_thread_in_core(t, c, p))
 		goto done;
 
+	if (platform->has_per_core_rapl) {
+		status = get_rapl_counters(cpu, c->core_id, c, p);
+		if (status != 0)
+			return status;
+	}
+
 	if (DO_BIC(BIC_CPU_c3) || soft_c1_residency_display(BIC_CPU_c3)) {
 		if (get_msr(cpu, MSR_CORE_C3_RESIDENCY, &c->c3))
 			return -6;
@@ -3069,12 +3487,6 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	if (DO_BIC(BIC_CORE_THROT_CNT))
 		get_core_throt_cnt(cpu, &c->core_throt_cnt);
 
-	if ((platform->rapl_msrs & RAPL_AMD_F17H) && !no_msr) {
-		if (get_msr(cpu, MSR_CORE_ENERGY_STAT, &msr))
-			return -14;
-		c->core_energy = msr & 0xFFFFFFFF;
-	}
-
 	for (i = 0, mp = sys.cp; mp; i++, mp = mp->next) {
 		if (get_mp(cpu, mp, &c->counter[i]))
 			return -10;
@@ -3134,43 +3546,9 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	if (DO_BIC(BIC_SYS_LPI))
 		p->sys_lpi = cpuidle_cur_sys_lpi_us;
 
-	if (!no_msr) {
-		if (platform->rapl_msrs & RAPL_PKG) {
-			if (get_msr_sum(cpu, MSR_PKG_ENERGY_STATUS, &msr))
-				return -13;
-			p->energy_pkg = msr;
-		}
-		if (platform->rapl_msrs & RAPL_CORE_ENERGY_STATUS) {
-			if (get_msr_sum(cpu, MSR_PP0_ENERGY_STATUS, &msr))
-				return -14;
-			p->energy_cores = msr;
-		}
-		if (platform->rapl_msrs & RAPL_DRAM) {
-			if (get_msr_sum(cpu, MSR_DRAM_ENERGY_STATUS, &msr))
-				return -15;
-			p->energy_dram = msr;
-		}
-		if (platform->rapl_msrs & RAPL_GFX) {
-			if (get_msr_sum(cpu, MSR_PP1_ENERGY_STATUS, &msr))
-				return -16;
-			p->energy_gfx = msr;
-		}
-		if (platform->rapl_msrs & RAPL_PKG_PERF_STATUS) {
-			if (get_msr_sum(cpu, MSR_PKG_PERF_STATUS, &msr))
-				return -16;
-			p->rapl_pkg_perf_status = msr;
-		}
-		if (platform->rapl_msrs & RAPL_DRAM_PERF_STATUS) {
-			if (get_msr_sum(cpu, MSR_DRAM_PERF_STATUS, &msr))
-				return -16;
-			p->rapl_dram_perf_status = msr;
-		}
-		if (platform->rapl_msrs & RAPL_AMD_F17H) {
-			if (get_msr_sum(cpu, MSR_PKG_ENERGY_STAT, &msr))
-				return -13;
-			p->energy_pkg = msr;
-		}
-	}
+	status = get_rapl_counters(cpu, p->package_id, c, p);
+	if (status != 0)
+		return status;
 
 	if (DO_BIC(BIC_PkgTmp)) {
 		if (get_msr(cpu, MSR_IA32_PACKAGE_THERM_STATUS, &msr))
@@ -3714,6 +4092,19 @@ void free_fd_instr_count_percpu(void)
 	fd_instr_count_percpu = NULL;
 }
 
+void free_fd_rapl_percpu(void)
+{
+	if (!rapl_counter_info_perdomain)
+		return;
+
+	for (int i = 0; i < topo.max_cpu_num + 1; ++i) {
+		if (rapl_counter_info_perdomain[i].fd_perf != 0)
+			close(rapl_counter_info_perdomain[i].fd_perf);
+	}
+
+	free(rapl_counter_info_perdomain);
+}
+
 void free_all_buffers(void)
 {
 	int i;
@@ -3757,6 +4148,7 @@ void free_all_buffers(void)
 	free_fd_percpu();
 	free_fd_instr_count_percpu();
 	free_fd_amperf_percpu();
+	free_fd_rapl_percpu();
 
 	free(irq_column_2_cpu);
 	free(irqs_per_cpu);
@@ -4091,12 +4483,14 @@ static void update_effective_set(bool startup)
 }
 
 void linux_perf_init(void);
+void rapl_perf_init(void);
 
 void re_initialize(void)
 {
 	free_all_buffers();
 	setup_all_buffers(false);
 	linux_perf_init();
+	rapl_perf_init();
 	fprintf(outf, "turbostat: re-initialized with num_cpus %d, allowed_cpus %d\n", topo.num_cpus,
 		topo.allowed_cpus);
 }
@@ -5315,31 +5709,18 @@ void rapl_probe_intel(void)
 	unsigned long long msr;
 	unsigned int time_unit;
 	double tdp;
+	const unsigned long long bic_watt_bits = BIC_PkgWatt | BIC_CorWatt | BIC_RAMWatt | BIC_GFXWatt;
+	const unsigned long long bic_joules_bits = BIC_Pkg_J | BIC_Cor_J | BIC_RAM_J | BIC_GFX_J;
 
-	if (rapl_joules) {
-		if (platform->rapl_msrs & RAPL_PKG_ENERGY_STATUS)
-			BIC_PRESENT(BIC_Pkg_J);
-		if (platform->rapl_msrs & RAPL_CORE_ENERGY_STATUS)
-			BIC_PRESENT(BIC_Cor_J);
-		if (platform->rapl_msrs & RAPL_DRAM_ENERGY_STATUS)
-			BIC_PRESENT(BIC_RAM_J);
-		if (platform->rapl_msrs & RAPL_GFX_ENERGY_STATUS)
-			BIC_PRESENT(BIC_GFX_J);
-	} else {
-		if (platform->rapl_msrs & RAPL_PKG_ENERGY_STATUS)
-			BIC_PRESENT(BIC_PkgWatt);
-		if (platform->rapl_msrs & RAPL_CORE_ENERGY_STATUS)
-			BIC_PRESENT(BIC_CorWatt);
-		if (platform->rapl_msrs & RAPL_DRAM_ENERGY_STATUS)
-			BIC_PRESENT(BIC_RAMWatt);
-		if (platform->rapl_msrs & RAPL_GFX_ENERGY_STATUS)
-			BIC_PRESENT(BIC_GFXWatt);
-	}
+	if (rapl_joules)
+		bic_enabled &= ~bic_watt_bits;
+	else
+		bic_enabled &= ~bic_joules_bits;
 
-	if (platform->rapl_msrs & RAPL_PKG_PERF_STATUS)
-		BIC_PRESENT(BIC_PKG__);
-	if (platform->rapl_msrs & RAPL_DRAM_PERF_STATUS)
-		BIC_PRESENT(BIC_RAM__);
+	if (!(platform->rapl_msrs & RAPL_PKG_PERF_STATUS))
+		bic_enabled &= ~BIC_PKG__;
+	if (!(platform->rapl_msrs & RAPL_DRAM_PERF_STATUS))
+		bic_enabled &= ~BIC_RAM__;
 
 	/* units on package 0, verify later other packages match */
 	if (get_msr(base_cpu, MSR_RAPL_POWER_UNIT, &msr))
@@ -5373,14 +5754,13 @@ void rapl_probe_amd(void)
 {
 	unsigned long long msr;
 	double tdp;
+	const unsigned long long bic_watt_bits = BIC_PkgWatt | BIC_CorWatt;
+	const unsigned long long bic_joules_bits = BIC_Pkg_J | BIC_Cor_J;
 
-	if (rapl_joules) {
-		BIC_PRESENT(BIC_Pkg_J);
-		BIC_PRESENT(BIC_Cor_J);
-	} else {
-		BIC_PRESENT(BIC_PkgWatt);
-		BIC_PRESENT(BIC_CorWatt);
-	}
+	if (rapl_joules)
+		bic_enabled &= ~bic_watt_bits;
+	else
+		bic_enabled &= ~bic_joules_bits;
 
 	if (get_msr(base_cpu, MSR_RAPL_PWR_UNIT, &msr))
 		return;
@@ -5885,6 +6265,48 @@ bool is_aperf_access_required(void)
 	    || BIC_IS_ENABLED(BIC_IPC);
 }
 
+int add_rapl_perf_counter_(int cpu, struct rapl_counter_info_t *rci, const struct rapl_counter_arch_info *cai,
+			   double *scale_, enum rapl_unit *unit_)
+{
+	if (no_perf)
+		return -1;
+
+	const double scale = read_perf_rapl_scale(cai->perf_subsys, cai->perf_name);
+	if (scale == 0.0)
+		return -1;
+
+	const enum rapl_unit unit = read_perf_rapl_unit(cai->perf_subsys, cai->perf_name);
+	if (unit == RAPL_UNIT_INVALID)
+		return -1;
+
+	const unsigned rapl_type = read_perf_type(cai->perf_subsys);
+	const unsigned rapl_energy_pkg_config = read_rapl_config(cai->perf_subsys, cai->perf_name);
+
+	const int fd_counter =
+	    open_perf_counter(cpu, rapl_type, rapl_energy_pkg_config, rci->fd_perf, PERF_FORMAT_GROUP);
+	if (fd_counter == -1)
+		return -1;
+
+	/* If it's the first counter opened, make it a group descriptor */
+	if (rci->fd_perf == -1)
+		rci->fd_perf = fd_counter;
+
+	*scale_ = scale;
+	*unit_ = unit;
+	return fd_counter;
+}
+
+int add_rapl_perf_counter(int cpu, struct rapl_counter_info_t *rci, const struct rapl_counter_arch_info *cai,
+			  double *scale, enum rapl_unit *unit)
+{
+	int ret = add_rapl_perf_counter_(cpu, rci, cai, scale, unit);
+
+	if (debug)
+		fprintf(stderr, "add_rapl_perf_counter: %d (cpu: %d)\n", ret, cpu);
+
+	return ret;
+}
+
 /*
  * Linux-perf manages the HW instructions-retired counter
  * by enabling when requested, and hiding rollover
@@ -5908,17 +6330,101 @@ void linux_perf_init(void)
 	}
 }
 
-static int has_amperf_access_via_msr(void)
+void rapl_perf_init(void)
 {
-	unsigned long long dummy;
+	const int num_domains = platform->has_per_core_rapl ? topo.num_cores : topo.num_packages;
+	bool *domain_visited = calloc(num_domains, sizeof(bool));
+
+	rapl_counter_info_perdomain = calloc(num_domains, sizeof(*rapl_counter_info_perdomain));
+	if (rapl_counter_info_perdomain == NULL)
+		err(-1, "calloc rapl_counter_info_percpu");
 
+	/*
+	 * Initialize rapl_counter_info_percpu
+	 */
+	for (int domain_id = 0; domain_id < num_domains; ++domain_id) {
+		struct rapl_counter_info_t *rci = &rapl_counter_info_perdomain[domain_id];
+		rci->fd_perf = -1;
+		for (size_t i = 0; i < NUM_RAPL_COUNTERS; ++i) {
+			rci->data[i] = 0;
+			rci->source[i] = RAPL_SOURCE_NONE;
+		}
+	}
+
+	/*
+	 * Open/probe the counters
+	 * If can't get it via perf, fallback to MSR
+	 */
+	for (size_t i = 0; i < ARRAY_SIZE(rapl_counter_arch_infos); ++i) {
+
+		const struct rapl_counter_arch_info *const cai = &rapl_counter_arch_infos[i];
+		bool has_counter = 0;
+		double scale;
+		enum rapl_unit unit;
+		int next_domain;
+
+		memset(domain_visited, 0, num_domains * sizeof(*domain_visited));
+
+		for (int cpu = 0; cpu < topo.max_cpu_num + 1; ++cpu) {
+
+			if (cpu_is_not_allowed(cpu))
+				continue;
+
+			/* Skip already seen and handled RAPL domains */
+			next_domain =
+			    platform->has_per_core_rapl ? cpus[cpu].physical_core_id : cpus[cpu].physical_package_id;
+
+			if (domain_visited[next_domain])
+				continue;
+
+			domain_visited[next_domain] = 1;
+
+			struct rapl_counter_info_t *rci = &rapl_counter_info_perdomain[next_domain];
+
+			/* Check if the counter is enabled and accessible */
+			if (BIC_IS_ENABLED(cai->bic) && (platform->rapl_msrs & cai->feature_mask)) {
+
+				/* Use perf API for this counter */
+				if (!no_perf && cai->perf_name
+				    && add_rapl_perf_counter(cpu, rci, cai, &scale, &unit) != -1) {
+					rci->source[cai->rci_index] = RAPL_SOURCE_PERF;
+					rci->scale[cai->rci_index] = scale * cai->compat_scale;
+					rci->unit[cai->rci_index] = unit;
+					rci->flags[cai->rci_index] = cai->flags;
+
+					/* Use MSR for this counter */
+				} else if (!no_msr && cai->msr && probe_msr(cpu, cai->msr) == 0) {
+					rci->source[cai->rci_index] = RAPL_SOURCE_MSR;
+					rci->msr[cai->rci_index] = cai->msr;
+					rci->msr_mask[cai->rci_index] = cai->msr_mask;
+					rci->msr_shift[cai->rci_index] = cai->msr_shift;
+					rci->unit[cai->rci_index] = RAPL_UNIT_JOULES;
+					rci->scale[cai->rci_index] = *cai->platform_rapl_msr_scale * cai->compat_scale;
+					rci->flags[cai->rci_index] = cai->flags;
+				}
+			}
+
+			if (rci->source[cai->rci_index] != RAPL_SOURCE_NONE)
+				has_counter = 1;
+		}
+
+		/* If any CPU has access to the counter, make it present */
+		if (has_counter)
+			BIC_PRESENT(cai->bic);
+	}
+
+	free(domain_visited);
+}
+
+static int has_amperf_access_via_msr(void)
+{
 	if (no_msr)
 		return 0;
 
-	if (get_msr(base_cpu, MSR_IA32_APERF, &dummy))
+	if (probe_msr(base_cpu, MSR_IA32_APERF))
 		return 0;
 
-	if (get_msr(base_cpu, MSR_IA32_MPERF, &dummy))
+	if (probe_msr(base_cpu, MSR_IA32_MPERF))
 		return 0;
 
 	return 1;
@@ -6696,6 +7202,7 @@ bool is_msr_access_required(void)
 	    || BIC_IS_ENABLED(BIC_Pkgpc8)
 	    || BIC_IS_ENABLED(BIC_Pkgpc9)
 	    || BIC_IS_ENABLED(BIC_Pkgpc10)
+	    /* TODO: Multiplex access with perf */
 	    || BIC_IS_ENABLED(BIC_CorWatt)
 	    || BIC_IS_ENABLED(BIC_Cor_J)
 	    || BIC_IS_ENABLED(BIC_PkgWatt)
@@ -6749,6 +7256,7 @@ void turbostat_init()
 	probe_pm_features();
 	set_amperf_source();
 	linux_perf_init();
+	rapl_perf_init();
 
 	for_all_cpus(get_cpu_type, ODD_COUNTERS);
 	for_all_cpus(get_cpu_type, EVEN_COUNTERS);
-- 
2.40.1


