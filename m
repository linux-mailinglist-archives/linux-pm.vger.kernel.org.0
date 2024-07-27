Return-Path: <linux-pm+bounces-11484-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C03A893E089
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 20:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41501C20DA9
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 18:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEB218734F;
	Sat, 27 Jul 2024 18:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAcFuw3U"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C1D18756E
	for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 18:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722104822; cv=none; b=cOC+RvhivQPFdBrHf0s4Cz7p/0xDCfTfrpdQreQG3e63By1MjQ2pITIbthYszY5qYgGSguymJtvIxJsO0PZTA2uAJHyCAMNDl4uNbW/bYPmY4uj7vz4lCt1yjuPdJxh9yp0m2SIu73cxS1CByfsYJvBhK3hpiSeJOoVe3vrFfz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722104822; c=relaxed/simple;
	bh=cCkbD3lsnlCRyVtaDnW1NHoo5E2RTNLvivDbZAuPyj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMYe9MfGIMkmMnrXzf7Tdlqo1K2PkdI25TiiPnwCB08vNKA0ARjU37KbGx3QdxfR+GLs2QUYN/wMrqHr5QaI8Gb0ZSRtSDAxjoFmmHWSiYnEpVVPB7F9u8Ssk/kTn6pZ0ZZx8VaL+9lURFYWKej2jaR6qTvcUUOfwMOrII1BApQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAcFuw3U; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5cdf7edddc5so910458eaf.0
        for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 11:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722104820; x=1722709620; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GE3Q1+0COIbhxKWBX0Aok6XDxXpA+GoIL1+s6qCL/uI=;
        b=hAcFuw3UMEzQ9ueWtATbbZQJTsM08Z6qI8rOuWOTjXBfsKx2jG7thVI+fe9MfXpCAM
         HNJH0vjGQHXtfp370DoPoB4XspJdiTdkTaL8cchA22SItxNteIqHjuyalX0WBEUeEKDC
         s6tnROsjkl8o6ZMffHOQxddOlgd/8g8NzV/7YS7Q0Gxejw+rpc3wZGFKgbwNcdiUiH/0
         6JcDbgMFa53GV36/VWiPFSXefwfa65FhUY7vlVtlHbqkFrV+HlgKA5yO36yQstwhe9vA
         bv2MaIOvv8nzkeuP5e0cPF23GvS8CE3mnU4Cva+PBcvpvqU9iM5q+/qeLzuObysf7T5P
         8bzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722104820; x=1722709620;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GE3Q1+0COIbhxKWBX0Aok6XDxXpA+GoIL1+s6qCL/uI=;
        b=wjjt1WYRdOlVHeF8Dplpu1zGn/s8ExMfDoVidAIf8ITAnK5nTmAMPTbISJduZyfa+8
         pMCpA3ySUp1coujsW79oOiuUdJt7yCi9btoT1bn6E2kaLkRUqtWtJUOTuT2HRuahlQv2
         CjATgNvw3Y/bwgq6xCxpYJ3bV2cSxvzD80RZwi4DzDE2VhaLZE9HkQl/4yxOLFWd724A
         1heOIO/DWdxhxxp1Pe3NtUCNmynDnm/1t8PBra/3P6VNKP/Nxz84J5fuvMCpbUtIiZk8
         xIVPyc76TvVnqV3HN/pe4KuixHAvz/eTN5QmA+FbiJsDfV/VfPx0zn9vfki8a7Cmejhg
         vSIA==
X-Gm-Message-State: AOJu0YzRjB/lddN+y9zp8XTDh/R0cQMSyRTbzlnqjs6YfQ4hGaJ4fx5x
	xocMjGc0nRHudwV49fZ082CRYo+tFLpWzYGZvhHh8v90OgyqER2yT/m3zA==
X-Google-Smtp-Source: AGHT+IFQUCmKWfK3IlRzvKqqGCjiPL40VqXLmhGLC2jxnohmKNXnFXtIp4UUw9ZHrwH/E42604n0Nw==
X-Received: by 2002:a05:6870:d14b:b0:261:b46:229 with SMTP id 586e51a60fabf-267d4f47fb6mr3651336fac.47.1722104819695;
        Sat, 27 Jul 2024 11:26:59 -0700 (PDT)
Received: from lenb-intel-nuc8i7hvkva.. (h75-100-80-185.cntcnh.broadband.dynamic.tds.net. [75.100.80.185])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7093050a35fsm1314136a34.6.2024.07.27.11.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 11:26:59 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 15/18] tools/power turbostat: Add MTL's PMT DC6 builtin counter
Date: Sat, 27 Jul 2024 14:23:41 -0400
Message-ID: <640540beb88363a825524295664acfdb0f5d5fc2.1722019621.git.len.brown@intel.com>
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

Provide a definition for metadata that allows reading DC6 residency
counter via PMT and exposes it as a builtin counter.

Note that this residency counter is updated and read via
entirely different mechanisms vs the MSR-based residency counters.
On MTL processors, there are times when Die%c6 will report above 100%.
This is still useful, but don't expect 3 digits of precision...

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 70 ++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index c9fdfb074ce9..f769e8beabd3 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -193,6 +193,7 @@ struct msr_counter bic[] = {
 	{ 0x0, "SAM%mc6", NULL, 0, 0, 0, NULL, 0 },
 	{ 0x0, "SAMMHz", NULL, 0, 0, 0, NULL, 0 },
 	{ 0x0, "SAMAMHz", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "Die%c6", NULL, 0, 0, 0, NULL, 0 },
 };
 
 #define MAX_BIC (sizeof(bic) / sizeof(struct msr_counter))
@@ -254,11 +255,12 @@ struct msr_counter bic[] = {
 #define	BIC_SAM_mc6		(1ULL << 55)
 #define	BIC_SAMMHz		(1ULL << 56)
 #define	BIC_SAMACTMHz		(1ULL << 57)
+#define	BIC_Diec6		(1ULL << 58)
 
 #define BIC_TOPOLOGY (BIC_Package | BIC_Node | BIC_CoreCnt | BIC_PkgCnt | BIC_Core | BIC_CPU | BIC_Die )
 #define BIC_THERMAL_PWR ( BIC_CoreTmp | BIC_PkgTmp | BIC_PkgWatt | BIC_CorWatt | BIC_GFXWatt | BIC_RAMWatt | BIC_PKG__ | BIC_RAM__)
 #define BIC_FREQUENCY (BIC_Avg_MHz | BIC_Busy | BIC_Bzy_MHz | BIC_TSC_MHz | BIC_GFXMHz | BIC_GFXACTMHz | BIC_SAMMHz | BIC_SAMACTMHz | BIC_UNCORE_MHZ)
-#define BIC_IDLE (BIC_sysfs | BIC_CPU_c1 | BIC_CPU_c3 | BIC_CPU_c6 | BIC_CPU_c7 | BIC_GFX_rc6 | BIC_Pkgpc2 | BIC_Pkgpc3 | BIC_Pkgpc6 | BIC_Pkgpc7 | BIC_Pkgpc8 | BIC_Pkgpc9 | BIC_Pkgpc10 | BIC_CPU_LPI | BIC_SYS_LPI | BIC_Mod_c6 | BIC_Totl_c0 | BIC_Any_c0 | BIC_GFX_c0 | BIC_CPUGFX | BIC_SAM_mc6)
+#define BIC_IDLE (BIC_sysfs | BIC_CPU_c1 | BIC_CPU_c3 | BIC_CPU_c6 | BIC_CPU_c7 | BIC_GFX_rc6 | BIC_Pkgpc2 | BIC_Pkgpc3 | BIC_Pkgpc6 | BIC_Pkgpc7 | BIC_Pkgpc8 | BIC_Pkgpc9 | BIC_Pkgpc10 | BIC_CPU_LPI | BIC_SYS_LPI | BIC_Mod_c6 | BIC_Totl_c0 | BIC_Any_c0 | BIC_GFX_c0 | BIC_CPUGFX | BIC_SAM_mc6 | BIC_Diec6)
 #define BIC_OTHER ( BIC_IRQ | BIC_SMI | BIC_ThreadC | BIC_CoreTmp | BIC_IPC)
 
 #define BIC_DISABLED_BY_DEFAULT	(BIC_USEC | BIC_TOD | BIC_APIC | BIC_X2APIC)
@@ -1475,6 +1477,11 @@ static struct msr_counter_arch_info msr_counter_arch_infos[] = {
 #define SYSFS_TELEM_PATH "/sys/class/intel_pmt"
 #endif
 
+#define PMT_COUNTER_MTL_DC6_OFFSET 120
+#define PMT_COUNTER_MTL_DC6_LSB    0
+#define PMT_COUNTER_MTL_DC6_MSB    63
+#define PMT_MTL_DC6_GUID           0x1a067102
+
 #define PMT_COUNTER_NAME_SIZE_BYTES      16
 #define PMT_COUNTER_TYPE_NAME_SIZE_BYTES 32
 
@@ -1496,6 +1503,7 @@ struct pmt_mmio {
 
 enum pmt_datatype {
 	PMT_TYPE_RAW,
+	PMT_TYPE_XTAL_TIME,
 };
 
 struct pmt_domain_info {
@@ -1630,6 +1638,7 @@ struct pkg_data {
 	struct rapl_counter rapl_dram_perf_status;	/* MSR_DRAM_PERF_STATUS */
 	unsigned int pkg_temp_c;
 	unsigned int uncore_mhz;
+	unsigned long long die_c6;
 	unsigned long long counter[MAX_ADDED_PACKAGE_COUNTERS];
 	unsigned long long perf_counter[MAX_ADDED_PACKAGE_COUNTERS];
 	unsigned long long pmt_counter[PMT_MAX_ADDED_PACKAGE_COUNTERS];
@@ -2281,6 +2290,10 @@ void print_header(char *delim)
 				outp += sprintf(outp, "%s%18.18s", (printed++ ? delim : ""), ppmt->name);
 
 			break;
+
+		case PMT_TYPE_XTAL_TIME:
+			outp += sprintf(outp, "%s%s", delim, ppmt->name);
+			break;
 		}
 
 		ppmt = ppmt->next;
@@ -2351,6 +2364,10 @@ void print_header(char *delim)
 				outp += sprintf(outp, "%s%18.18s", (printed++ ? delim : ""), ppmt->name);
 
 			break;
+
+		case PMT_TYPE_XTAL_TIME:
+			outp += sprintf(outp, "%s%s", delim, ppmt->name);
+			break;
 		}
 
 		ppmt = ppmt->next;
@@ -2400,6 +2417,8 @@ void print_header(char *delim)
 		outp += sprintf(outp, "%sPkg%%pc9", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_Pkgpc10))
 		outp += sprintf(outp, "%sPk%%pc10", (printed++ ? delim : ""));
+	if (DO_BIC(BIC_Diec6))
+		outp += sprintf(outp, "%sDie%%c6", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_CPU_LPI))
 		outp += sprintf(outp, "%sCPU%%LPI", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_SYS_LPI))
@@ -2476,6 +2495,10 @@ void print_header(char *delim)
 				outp += sprintf(outp, "%s%18.18s", (printed++ ? delim : ""), ppmt->name);
 
 			break;
+
+		case PMT_TYPE_XTAL_TIME:
+			outp += sprintf(outp, "%s%s", delim, ppmt->name);
+			break;
 		}
 
 		ppmt = ppmt->next;
@@ -2775,6 +2798,13 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), t->pmt_counter[i]);
 
 			break;
+
+		case PMT_TYPE_XTAL_TIME:
+			const unsigned long value_raw = t->pmt_counter[i];
+			const double value_converted = 100.0 * value_raw / crystal_hz / interval_float;
+
+			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), value_converted);
+			break;
 		}
 	}
 
@@ -2849,6 +2879,13 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), c->pmt_counter[i]);
 
 			break;
+
+		case PMT_TYPE_XTAL_TIME:
+			const unsigned long value_raw = c->pmt_counter[i];
+			const double value_converted = 100.0 * value_raw / crystal_hz / interval_float;
+
+			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), value_converted);
+			break;
 		}
 	}
 
@@ -2931,6 +2968,9 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 	if (DO_BIC(BIC_Pkgpc10))
 		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc10 / tsc);
 
+	if (DO_BIC(BIC_Diec6))
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->die_c6 / crystal_hz / interval_float);
+
 	if (DO_BIC(BIC_CPU_LPI)) {
 		if (p->cpu_lpi >= 0)
 			outp +=
@@ -3037,6 +3077,13 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), p->pmt_counter[i]);
 
 			break;
+
+		case PMT_TYPE_XTAL_TIME:
+			const unsigned long value_raw = p->pmt_counter[i];
+			const double value_converted = 100.0 * value_raw / crystal_hz / interval_float;
+
+			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), value_converted);
+			break;
 		}
 	}
 
@@ -3115,6 +3162,7 @@ int delta_package(struct pkg_data *new, struct pkg_data *old)
 	old->pc8 = new->pc8 - old->pc8;
 	old->pc9 = new->pc9 - old->pc9;
 	old->pc10 = new->pc10 - old->pc10;
+	old->die_c6 = new->die_c6 - old->die_c6;
 	old->cpu_lpi = new->cpu_lpi - old->cpu_lpi;
 	old->sys_lpi = new->sys_lpi - old->sys_lpi;
 	old->pkg_temp_c = new->pkg_temp_c;
@@ -3398,6 +3446,7 @@ void clear_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 	p->pc8 = 0;
 	p->pc9 = 0;
 	p->pc10 = 0;
+	p->die_c6 = 0;
 	p->cpu_lpi = 0;
 	p->sys_lpi = 0;
 
@@ -3547,6 +3596,7 @@ int sum_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	average.packages.pc8 += p->pc8;
 	average.packages.pc9 += p->pc9;
 	average.packages.pc10 += p->pc10;
+	average.packages.die_c6 += p->die_c6;
 
 	average.packages.cpu_lpi = p->cpu_lpi;
 	average.packages.sys_lpi = p->sys_lpi;
@@ -3642,6 +3692,7 @@ void compute_average(struct thread_data *t, struct core_data *c, struct pkg_data
 	average.packages.pc8 /= topo.allowed_packages;
 	average.packages.pc9 /= topo.allowed_packages;
 	average.packages.pc10 /= topo.allowed_packages;
+	average.packages.die_c6 /= topo.allowed_packages;
 
 	for (i = 0, mp = sys.tp; mp; i++, mp = mp->next) {
 		if (mp->format == FORMAT_RAW)
@@ -5505,6 +5556,7 @@ void msr_perf_init(void);
 void rapl_perf_init(void);
 void cstate_perf_init(void);
 void added_perf_counters_init(void);
+void pmt_init(void);
 
 void re_initialize(void)
 {
@@ -5515,6 +5567,7 @@ void re_initialize(void)
 	rapl_perf_init();
 	cstate_perf_init();
 	added_perf_counters_init();
+	pmt_init();
 	fprintf(outf, "turbostat: re-initialized with num_cpus %d, allowed_cpus %d\n", topo.num_cpus,
 		topo.allowed_cpus);
 }
@@ -8864,6 +8917,15 @@ int pmt_add_counter(unsigned int guid, const char *name, enum pmt_datatype type,
 	return 0;
 }
 
+void pmt_init(void)
+{
+	if (BIC_IS_ENABLED(BIC_Diec6)) {
+		pmt_add_counter(PMT_MTL_DC6_GUID, "Die%c6", PMT_TYPE_XTAL_TIME, PMT_COUNTER_MTL_DC6_LSB,
+				PMT_COUNTER_MTL_DC6_MSB, PMT_COUNTER_MTL_DC6_OFFSET, SCOPE_PACKAGE, FORMAT_DELTA,
+				0, PMT_OPEN_TRY);
+	}
+}
+
 void turbostat_init()
 {
 	setup_all_buffers(true);
@@ -8878,6 +8940,7 @@ void turbostat_init()
 	rapl_perf_init();
 	cstate_perf_init();
 	added_perf_counters_init();
+	pmt_init();
 
 	for_all_cpus(get_cpu_type, ODD_COUNTERS);
 	for_all_cpus(get_cpu_type, EVEN_COUNTERS);
@@ -9465,6 +9528,11 @@ void parse_add_command_pmt(char *add_command)
 			has_type = true;
 		}
 
+		if (strcmp("txtal_time", type_name) == 0) {
+			type = PMT_TYPE_XTAL_TIME;
+			has_type = true;
+		}
+
 		if (!has_type) {
 			printf("%s: invalid %s: %s\n", __func__, "type", type_name);
 			exit(1);
-- 
2.43.0


