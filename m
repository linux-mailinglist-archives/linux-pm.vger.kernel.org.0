Return-Path: <linux-pm+bounces-11473-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4976193E07F
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 20:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 034BB281D50
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 18:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50484187341;
	Sat, 27 Jul 2024 18:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igN/bZUT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E118187321
	for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 18:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722104812; cv=none; b=KqXn9/ounbsLjSr+W8LyxczYclEhS84gmjZwMEqJCAkGHOqlx8b5GY6j6jfdecemW5G+ZiPGSrbd3mjqwBX+d+7zdj/tk9N28olg7HpcNIOsvCqiozA7tUjbI4IR8ej/CfkfgottET0BDXHP8GnU/aHHW5VSwgutW9oMhwGw3Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722104812; c=relaxed/simple;
	bh=FivlYD+8mFHlKLwS+2VY9QsvB25fT5B99uam6OHOqKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WjbI9KKcbPrWe/E7FuoSXpQuxlrn+0PlDIy8gyNcXWCS0FFV5HZlyhRfk4DzUfutyhfHKZ7C4sgfJLPHRQ7sibSL4AssvAaMt2USMNeBIuLdPxnjy8uYn2pdPS6zRDhaoAsMj84BnyH5NZ0pXLQUKU0L0tEebCfRXNvpdApjluI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igN/bZUT; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-260fed6c380so1263288fac.1
        for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 11:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722104809; x=1722709609; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BZAUWWKq4sYsAdX/NEopjvhRe7Dn7tXymODWnnG6eBw=;
        b=igN/bZUTRUnqiRdWZjZFoN74Om7kZThuKQx7q1ZQdmDtgAkEIeamyoEq0XTeHJc9zz
         +Eb0Sf9pOrcOjCyBvtzHTCfEH8ECINXJiJVUnmkR9J0FRKNSp6D0CQK6kiNnZ/4DdrtI
         juoY6Z22XWRA6sQVrloLEoMb5jqypdLhiQaPtb6/zAMyNPClqohOT/Eq0sumMiC05IvH
         GgvQeKlnaXlqeCKK7Qgvot5vma8mlStHzoRN5sMdoOwVUPP8g5bKElEKJfpaS+TYq9Fv
         6ZbY3C/6G8CqFa7ZDi8T96RI5k0CQ4ejPFP9IwjY57hDI1a35/DPPAsnX3LiTTUPoCjz
         wLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722104809; x=1722709609;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZAUWWKq4sYsAdX/NEopjvhRe7Dn7tXymODWnnG6eBw=;
        b=TnNQwhyZ2JNjiBZrVKhrXe80I2++2h3HYGVxv+L0XKppG7+CNMLe1ZXiRuRzQ32JBB
         TF6cDzc4GYHjvCoEMD/cdB3GeJ+YaUuqjzTgNPHFtz/OOmgvUTpUWopn2tFDllYPRfXg
         zS/s5u+L0LBHTCfgUBUM++KIACWEVE6vCGjV85o2uBSVL+hJGUwMQ5lw6hCk6hSQJNHR
         GJlSkHM4/xEtIo/jbDV//in+7SSXf7GM7JiwYi6GjaTxTD81LiLTU29gnnoQ5SpsgvLg
         hLmboZSym0VQQ0qdgEg3VfGkirI5bm0+gmCU9T0hv2lOoJM7/ym7j1UIXrlZks7MSz19
         su8Q==
X-Gm-Message-State: AOJu0YxjUf+5HJhfvjp/7UltLTq8ZfgVlpHNUm7wtYoKlfrf9NOtCEyS
	vv+q1BYuSF7BN1PGaexdmvCCAv4V9ovk03fS1+7S1TUstvjnij3XsEMlWw==
X-Google-Smtp-Source: AGHT+IHOkCaT/ZC/XBEYqIqUmyrJ2EiYlqwrLUY20i+in13Ow7Yty6gxTf5QMimECXZROmIiCtK5Xg==
X-Received: by 2002:a05:6871:438b:b0:261:15d9:a9e with SMTP id 586e51a60fabf-267d4f59d68mr4231760fac.47.1722104809356;
        Sat, 27 Jul 2024 11:26:49 -0700 (PDT)
Received: from lenb-intel-nuc8i7hvkva.. (h75-100-80-185.cntcnh.broadband.dynamic.tds.net. [75.100.80.185])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7093050a35fsm1314136a34.6.2024.07.27.11.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 11:26:49 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 03/18] tools/power turbostat: Replace enum rapl_source and cstate_source with counter_source
Date: Sat, 27 Jul 2024 14:23:29 -0400
Message-ID: <73ed3c941a76ff3348022477975c84b8d183599a.1722019621.git.len.brown@intel.com>
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

Reuse the enum. It means the same thing in both cases.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 39 +++++++++++++--------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 1ac74cd49cc9..0fc6c107e371 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -86,8 +86,7 @@ enum counter_scope { SCOPE_CPU, SCOPE_CORE, SCOPE_PACKAGE };
 enum counter_type { COUNTER_ITEMS, COUNTER_CYCLES, COUNTER_SECONDS, COUNTER_USEC, COUNTER_K2M };
 enum counter_format { FORMAT_RAW, FORMAT_DELTA, FORMAT_PERCENT, FORMAT_AVERAGE };
 enum amperf_source { AMPERF_SOURCE_PERF, AMPERF_SOURCE_MSR };
-enum rapl_source { RAPL_SOURCE_NONE, RAPL_SOURCE_PERF, RAPL_SOURCE_MSR };
-enum cstate_source { CSTATE_SOURCE_NONE, CSTATE_SOURCE_PERF, CSTATE_SOURCE_MSR };
+enum counter_source { COUNTER_SOURCE_NONE, COUNTER_SOURCE_PERF, COUNTER_SOURCE_MSR };
 
 struct sysfs_path {
 	char path[PATH_BYTES];
@@ -1081,7 +1080,7 @@ enum rapl_unit {
 
 struct rapl_counter_info_t {
 	unsigned long long data[NUM_RAPL_COUNTERS];
-	enum rapl_source source[NUM_RAPL_COUNTERS];
+	enum counter_source source[NUM_RAPL_COUNTERS];
 	unsigned long long flags[NUM_RAPL_COUNTERS];
 	double scale[NUM_RAPL_COUNTERS];
 	enum rapl_unit unit[NUM_RAPL_COUNTERS];
@@ -1243,7 +1242,7 @@ enum ccstate_rci_index {
 
 struct cstate_counter_info_t {
 	unsigned long long data[NUM_CSTATE_COUNTERS];
-	enum cstate_source source[NUM_CSTATE_COUNTERS];
+	enum counter_source source[NUM_CSTATE_COUNTERS];
 	unsigned long long msr[NUM_CSTATE_COUNTERS];
 	int fd_perf_core;
 	int fd_perf_pkg;
@@ -3601,7 +3600,7 @@ size_t rapl_counter_info_count_perf(const struct rapl_counter_info_t *rci)
 	size_t ret = 0;
 
 	for (int i = 0; i < NUM_RAPL_COUNTERS; ++i)
-		if (rci->source[i] == RAPL_SOURCE_PERF)
+		if (rci->source[i] == COUNTER_SOURCE_PERF)
 			++ret;
 
 	return ret;
@@ -3612,7 +3611,7 @@ static size_t cstate_counter_info_count_perf(const struct cstate_counter_info_t
 	size_t ret = 0;
 
 	for (int i = 0; i < NUM_CSTATE_COUNTERS; ++i)
-		if (cci->source[i] == CSTATE_SOURCE_PERF)
+		if (cci->source[i] == COUNTER_SOURCE_PERF)
 			++ret;
 
 	return ret;
@@ -3653,10 +3652,10 @@ int get_rapl_counters(int cpu, unsigned int domain, struct core_data *c, struct
 
 	for (unsigned int i = 0, pi = 1; i < NUM_RAPL_COUNTERS; ++i) {
 		switch (rci->source[i]) {
-		case RAPL_SOURCE_NONE:
+		case COUNTER_SOURCE_NONE:
 			break;
 
-		case RAPL_SOURCE_PERF:
+		case COUNTER_SOURCE_PERF:
 			assert(pi < ARRAY_SIZE(perf_data));
 			assert(rci->fd_perf != -1);
 
@@ -3669,7 +3668,7 @@ int get_rapl_counters(int cpu, unsigned int domain, struct core_data *c, struct
 			++pi;
 			break;
 
-		case RAPL_SOURCE_MSR:
+		case COUNTER_SOURCE_MSR:
 			if (debug)
 				fprintf(stderr, "Reading rapl counter via msr at %u\n", i);
 
@@ -3791,10 +3790,10 @@ int get_cstate_counters(unsigned int cpu, struct thread_data *t, struct core_dat
 
 	for (unsigned int i = 0, pi = 0; i < NUM_CSTATE_COUNTERS; ++i) {
 		switch (cci->source[i]) {
-		case CSTATE_SOURCE_NONE:
+		case COUNTER_SOURCE_NONE:
 			break;
 
-		case CSTATE_SOURCE_PERF:
+		case COUNTER_SOURCE_PERF:
 			assert(pi < ARRAY_SIZE(perf_data));
 			assert(cci->fd_perf_core != -1 || cci->fd_perf_pkg != -1);
 
@@ -3807,7 +3806,7 @@ int get_cstate_counters(unsigned int cpu, struct thread_data *t, struct core_dat
 			++pi;
 			break;
 
-		case CSTATE_SOURCE_MSR:
+		case COUNTER_SOURCE_MSR:
 			assert(!no_msr);
 			if (get_msr(cpu, cci->msr[i], &cci->data[i]))
 				return -13 - i;
@@ -3828,7 +3827,7 @@ int get_cstate_counters(unsigned int cpu, struct thread_data *t, struct core_dat
 	 * when invoked for the thread sibling.
 	 */
 #define PERF_COUNTER_WRITE_DATA(out_counter, index) do {	\
-	if (cci->source[index] != CSTATE_SOURCE_NONE)		\
+	if (cci->source[index] != COUNTER_SOURCE_NONE)		\
 		out_counter = cci->data[index];			\
 } while (0)
 
@@ -6894,7 +6893,7 @@ void rapl_perf_init(void)
 		rci->fd_perf = -1;
 		for (size_t i = 0; i < NUM_RAPL_COUNTERS; ++i) {
 			rci->data[i] = 0;
-			rci->source[i] = RAPL_SOURCE_NONE;
+			rci->source[i] = COUNTER_SOURCE_NONE;
 		}
 	}
 
@@ -6936,14 +6935,14 @@ void rapl_perf_init(void)
 				/* Use perf API for this counter */
 				if (!no_perf && cai->perf_name
 				    && add_rapl_perf_counter(cpu, rci, cai, &scale, &unit) != -1) {
-					rci->source[cai->rci_index] = RAPL_SOURCE_PERF;
+					rci->source[cai->rci_index] = COUNTER_SOURCE_PERF;
 					rci->scale[cai->rci_index] = scale * cai->compat_scale;
 					rci->unit[cai->rci_index] = unit;
 					rci->flags[cai->rci_index] = cai->flags;
 
 					/* Use MSR for this counter */
 				} else if (!no_msr && cai->msr && probe_msr(cpu, cai->msr) == 0) {
-					rci->source[cai->rci_index] = RAPL_SOURCE_MSR;
+					rci->source[cai->rci_index] = COUNTER_SOURCE_MSR;
 					rci->msr[cai->rci_index] = cai->msr;
 					rci->msr_mask[cai->rci_index] = cai->msr_mask;
 					rci->msr_shift[cai->rci_index] = cai->msr_shift;
@@ -6953,7 +6952,7 @@ void rapl_perf_init(void)
 				}
 			}
 
-			if (rci->source[cai->rci_index] != RAPL_SOURCE_NONE)
+			if (rci->source[cai->rci_index] != COUNTER_SOURCE_NONE)
 				has_counter = 1;
 		}
 
@@ -7146,17 +7145,17 @@ void cstate_perf_init_(bool soft_c1)
 				/* Use perf API for this counter */
 				if (!no_perf && cai->perf_name && add_cstate_perf_counter(cpu, cci, cai) != -1) {
 
-					cci->source[cai->rci_index] = CSTATE_SOURCE_PERF;
+					cci->source[cai->rci_index] = COUNTER_SOURCE_PERF;
 
 					/* User MSR for this counter */
 				} else if (!no_msr && cai->msr && pkg_cstate_limit >= cai->pkg_cstate_limit
 					   && probe_msr(cpu, cai->msr) == 0) {
-					cci->source[cai->rci_index] = CSTATE_SOURCE_MSR;
+					cci->source[cai->rci_index] = COUNTER_SOURCE_MSR;
 					cci->msr[cai->rci_index] = cai->msr;
 				}
 			}
 
-			if (cci->source[cai->rci_index] != CSTATE_SOURCE_NONE) {
+			if (cci->source[cai->rci_index] != COUNTER_SOURCE_NONE) {
 				has_counter = true;
 				cores_visited[core_id] = true;
 				pkg_visited[pkg_id] = true;
-- 
2.43.0


