Return-Path: <linux-pm+bounces-11481-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C80993E087
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 20:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0EF11F21BDC
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 18:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD933187341;
	Sat, 27 Jul 2024 18:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChceasrA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC13187553
	for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 18:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722104818; cv=none; b=NVtUcYjeQ25UBuhEI9j8qJy0KHXKasWeE+mN8YdJWFjPgKYXMUTS4JbNM6pVJN3vqphxs85LfJMiq1MwsKiB6t7FosidC4P+P5ZvxCYYwzETbYdP+90Z3w5+mRszuhOkvjD2Cx9ZI5+aforfBQIxXBzUHXto7He25/bonMapk88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722104818; c=relaxed/simple;
	bh=K0mk1PZBH574OLvSOXXRU6kBsdvdETohQvBKE2euLcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEVAAht5FBAyLC/UbzlJ/4Ze4tZ8gCzUoMDTD3dUwtWj/41A9AL/GRqv9biZDZaj1g/7Wo4MWtkiWeYpI1JCtBHyvfTVYY0sJH9NE6IY++Aej+0kZsRSTQ9FqvPVcVMurGFSDC/dlTmgr+ptcEWlA3Y0cunmDL9h+rYws59kOn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChceasrA; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7093f6adc4aso572324a34.3
        for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 11:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722104816; x=1722709616; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b1kfyj2Mws1fHy2eLaLj9Wh5o0iGnT6mMxzD1h8ZkHo=;
        b=ChceasrA/8Qq4XzaXVMNp5WOX2EqJK3tQC4K9uZWkUJvZbz8PsfyxOQ4yGRTmBOdR3
         a256XNb03+1Mz3nw5/uEcNcXzV8zoNsFJ0NN8jCBXxpXmSr0xgA+dOFt2XzbwZ2AtRRq
         0eu4pFYMmKWbRbF6iwXmz71APPcU9ohP9DC6kg8/urUhrA1AjQ5/cryD5v08pcs+ZEQT
         Bic90GvPUCjwrrwnyc+NDAGZr7/ZZ6b0RgI6t3sSo82X+ZPMu5LjVYu9aBF+uj8A/HMI
         Xd2U9lYLiMcJqNXFVkZlXtpWn3TfUF3aPzUTZ++vIM69gpRSE5VudLQsBMjlSYfJofkJ
         Imkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722104816; x=1722709616;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b1kfyj2Mws1fHy2eLaLj9Wh5o0iGnT6mMxzD1h8ZkHo=;
        b=m8lvcS5D/cDazFha6ZlsEgpqlQsC+nSS8Iovemk8q3JuN5Q/EiReI+k5mGpVdL09gu
         hXp/wLECJSf4quY7wyqW7bk8YfHyGZ3GkIz/iIAEvCC5cqstlDv+yDVf/Qd/LyHEXIh5
         7l6Si/fNDLvUadiY+yNvmQnspX0BJh9HkHPRtnRg0Y8qFz/jit3cAqaPZQRbEkEl+rYF
         gJ2rRhxjdlJLafmY68Vv/tijgZurlo4wSwhxo+9328QBptAFxBpIv2UASwsTH9UoO0bg
         +moKMO0Cxa7E5ehcrzMS9yg7AyueOQjbhk0IPBIFXm8jOVHk+dLgrUKGglq6ijs6a9eb
         Lrxg==
X-Gm-Message-State: AOJu0Yw8Smgm558aO3bI2g3Sxb3SUT6dr2ZF/bZSjLe1kvF/WqUjcmwG
	45Hq2WQYHESCefXWJOn+RbxXhIpND5dHRqn+8ujPvoQGsfLXLxxJLXQ2Ww==
X-Google-Smtp-Source: AGHT+IH1+jKcY7FQ6YTJ2UyWyPo8MMRWPkjL/lUZ/Wp6v2YX/qV7j3I2wLvgvxnVJndp54V9Ypk1pA==
X-Received: by 2002:a9d:76d1:0:b0:708:b344:fed8 with SMTP id 46e09a7af769-70940c9d683mr3117370a34.33.1722104816196;
        Sat, 27 Jul 2024 11:26:56 -0700 (PDT)
Received: from lenb-intel-nuc8i7hvkva.. (h75-100-80-185.cntcnh.broadband.dynamic.tds.net. [75.100.80.185])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7093050a35fsm1314136a34.6.2024.07.27.11.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 11:26:55 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 11/18] tools/power turbostat: Move verbose counter messages to level 2
Date: Sat, 27 Jul 2024 14:23:37 -0400
Message-ID: <b2e4a5dfafcce87ed2b9aac0b2887f421cd2930a.1722019621.git.len.brown@intel.com>
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

Printing information about the source and value during initialization and
reading of the counter for each cpu, while useful when debugging,
results in too verbose output.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index cccd9f4311a0..86bbea7d8e57 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3797,7 +3797,7 @@ int get_rapl_counters(int cpu, unsigned int domain, struct core_data *c, struct
 	unsigned long long perf_data[NUM_RAPL_COUNTERS + 1];
 	struct rapl_counter_info_t *rci;
 
-	if (debug)
+	if (debug >= 2)
 		fprintf(stderr, "%s: cpu%d domain%d\n", __func__, cpu, domain);
 
 	assert(rapl_counter_info_perdomain);
@@ -3827,7 +3827,7 @@ int get_rapl_counters(int cpu, unsigned int domain, struct core_data *c, struct
 			assert(pi < ARRAY_SIZE(perf_data));
 			assert(rci->fd_perf != -1);
 
-			if (debug)
+			if (debug >= 2)
 				fprintf(stderr, "Reading rapl counter via perf at %u (%llu %e %lf)\n",
 					i, perf_data[pi], rci->scale[i], perf_data[pi] * rci->scale[i]);
 
@@ -3837,7 +3837,7 @@ int get_rapl_counters(int cpu, unsigned int domain, struct core_data *c, struct
 			break;
 
 		case COUNTER_SOURCE_MSR:
-			if (debug)
+			if (debug >= 2)
 				fprintf(stderr, "Reading rapl counter via msr at %u\n", i);
 
 			assert(!no_msr);
@@ -3895,7 +3895,7 @@ int get_cstate_counters(unsigned int cpu, struct thread_data *t, struct core_dat
 
 	struct cstate_counter_info_t *cci;
 
-	if (debug)
+	if (debug >= 2)
 		fprintf(stderr, "%s: cpu%d\n", __func__, cpu);
 
 	assert(ccstate_counter_info);
@@ -3965,9 +3965,8 @@ int get_cstate_counters(unsigned int cpu, struct thread_data *t, struct core_dat
 			assert(pi < ARRAY_SIZE(perf_data));
 			assert(cci->fd_perf_core != -1 || cci->fd_perf_pkg != -1);
 
-			if (debug) {
+			if (debug >= 2)
 				fprintf(stderr, "cstate via %s %u: %llu\n", "perf", i, perf_data[pi]);
-			}
 
 			cci->data[i] = perf_data[pi];
 
@@ -3979,9 +3978,8 @@ int get_cstate_counters(unsigned int cpu, struct thread_data *t, struct core_dat
 			if (get_msr(cpu, cci->msr[i], &cci->data[i]))
 				return -13 - i;
 
-			if (debug) {
+			if (debug >= 2)
 				fprintf(stderr, "cstate via %s0x%llx %u: %llu\n", "msr", cci->msr[i], i, cci->data[i]);
-			}
 
 			break;
 		}
@@ -4036,7 +4034,7 @@ int get_smi_aperf_mperf(unsigned int cpu, struct thread_data *t)
 
 	struct msr_counter_info_t *mci;
 
-	if (debug)
+	if (debug >= 2)
 		fprintf(stderr, "%s: cpu%d\n", __func__, cpu);
 
 	assert(msr_counter_info);
@@ -4066,7 +4064,7 @@ int get_smi_aperf_mperf(unsigned int cpu, struct thread_data *t)
 			assert(pi < ARRAY_SIZE(perf_data));
 			assert(mci->fd_perf != -1);
 
-			if (debug)
+			if (debug >= 2)
 				fprintf(stderr, "Reading msr counter via perf at %u: %llu\n", i, perf_data[pi]);
 
 			mci->data[i] = perf_data[pi];
@@ -4082,7 +4080,7 @@ int get_smi_aperf_mperf(unsigned int cpu, struct thread_data *t)
 
 			mci->data[i] &= mci->msr_mask[i];
 
-			if (debug)
+			if (debug >= 2)
 				fprintf(stderr, "Reading msr counter via msr at %u: %llu\n", i, mci->data[i]);
 
 			break;
@@ -7125,7 +7123,7 @@ int add_rapl_perf_counter(int cpu, struct rapl_counter_info_t *rci, const struct
 {
 	int ret = add_rapl_perf_counter_(cpu, rci, cai, scale, unit);
 
-	if (debug)
+	if (debug >= 2)
 		fprintf(stderr, "%s: %d (cpu: %d)\n", __func__, ret, cpu);
 
 	return ret;
@@ -7284,7 +7282,7 @@ int add_cstate_perf_counter(int cpu, struct cstate_counter_info_t *cci, const st
 {
 	int ret = add_cstate_perf_counter_(cpu, cci, cai);
 
-	if (debug)
+	if (debug >= 2)
 		fprintf(stderr, "%s: %d (cpu: %d)\n", __func__, ret, cpu);
 
 	return ret;
-- 
2.43.0


