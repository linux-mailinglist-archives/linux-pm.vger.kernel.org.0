Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61AF8A45E9
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2019 21:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfHaTf0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Aug 2019 15:35:26 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43926 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbfHaTf0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Aug 2019 15:35:26 -0400
Received: by mail-io1-f66.google.com with SMTP id u185so17282144iod.10
        for <linux-pm@vger.kernel.org>; Sat, 31 Aug 2019 12:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:reply-to:organization:content-transfer-encoding;
        bh=q4Zs/UJMkBwDNYS4GmBE0C8tk0RrfjDvpeBJ36dOl/k=;
        b=hyIvdzsfKiFKAwi2/yro6+Bj/oMar5IceicR4zrVQzj/LOKPPxeK21bbn/CX4FtWk5
         13gnNVWy7AUomill3UQ8BPlwnuTAyxVDxNU8TBpC84l6ER0vkHFHa8xM4ncMYO0c6sNw
         cixvMC6nSpwBBNyQXkuRF3lwBDR85U6XkkyYXluZNcvJ/MOlhBKhAwnw4qa+aOPF9MP9
         SVz3wWB2kVfY9L0g+E+W9/YHW6y9fxkYShHtSBnzlYzuAAksHDpmej2ySWfoHPbQDyPj
         UFh0WYAvb5HpmSMSUPtmdR6eRX4T9HhxQD37bty2oe3N5H0Bve1/rjIDzQE72u478YYY
         DspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:reply-to:organization
         :content-transfer-encoding;
        bh=q4Zs/UJMkBwDNYS4GmBE0C8tk0RrfjDvpeBJ36dOl/k=;
        b=nRmUJcySD6YxU8RmIru/T9r3nfsdXh9fIc6EmNMHf9UFXIImO3bw03gZWjTjaHxh30
         AEFL8yqkge+HuaWY2IEJYwaB1KuDIRpDxF482uNthYN5GrVfq27aFG1nObkFZuAlIla0
         QVGKw60w+J+FOh6ztdrfgC27BCOtW0PAS688Tx7tnr+ndjuifhymnqy2GYp0vu9wwbJK
         CX7MCs81urFPJkbQnn02GkhuIZrsiUEaM/5/5S20Vk3w8ybaJ+HwR3+Ec15hyD2sinWv
         ynPYgKFqL3Z0YfF8jNpqEhBMulW0LcI4FJvd3+YQzuHAcNpzk/Vx4AGzldGmLkIhEM4Y
         RK+Q==
X-Gm-Message-State: APjAAAXt4LZJ6DUtcvaWXnpN5b2YSYyVWRsMVHVrZ7FnCQLmPnztJVG8
        AKcmHChTScIrrebKa4riLrfpxvRI
X-Google-Smtp-Source: APXvYqzOlx58S5EQqgNx6cTgqPHWyfmHu/6DatRAGUG5RsVP0b9WCoOZFwm2vxiEj/nnV05xqYxy6A==
X-Received: by 2002:a5d:9c08:: with SMTP id 8mr19724985ioe.9.1567280125168;
        Sat, 31 Aug 2019 12:35:25 -0700 (PDT)
Received: from nuc8.tds (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id r2sm6937376ioh.61.2019.08.31.12.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 12:35:24 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     linux-pm@vger.kernel.org
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Len Brown <len.brown@intel.com>
Subject: [PATCH 06/19] tools/power turbostat: Make interval calculation per thread to reduce jitter
Date:   Sat, 31 Aug 2019 15:34:45 -0400
Message-Id: <d4794f25f122aa1a8a073be51112edaa723ffff4.1567277326.git.len.brown@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <adb8049097a9ec4acd09fbd3aa8636199a78df8a.1567277326.git.len.brown@intel.com>
References: <adb8049097a9ec4acd09fbd3aa8636199a78df8a.1567277326.git.len.brown@intel.com>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Turbostat currently normalizes TSC and other values by dividing by an
interval. This interval is the delta between the start of one global
(all counters on all CPUs) sampling and the start of another. However,
this introduces a lot of jitter into the data.

In order to reduce jitter, the interval calculation should be based on
timestamps taken per thread and close to the start of the thread's
sampling.

Define a per thread time value to hold the delta between samples taken
on the thread.

Use the timestamp taken at the beginning of sampling to calculate the
delta.

Move the thread's beginning timestamp to after the CPU migration to
avoid jitter due to the migration.

Use the global time delta for the average time delta.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 90f7e8b4d4d4..02813a2a8ffd 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -166,6 +166,7 @@ size_t cpu_present_setsize, cpu_affinity_setsize, cpu_subset_size;
 struct thread_data {
 	struct timeval tv_begin;
 	struct timeval tv_end;
+	struct timeval tv_delta;
 	unsigned long long tsc;
 	unsigned long long aperf;
 	unsigned long long mperf;
@@ -910,7 +911,7 @@ int format_counters(struct thread_data *t, struct core_data *c,
 	if (DO_BIC(BIC_TOD))
 		outp += sprintf(outp, "%10ld.%06ld\t", t->tv_end.tv_sec, t->tv_end.tv_usec);
 
-	interval_float = tv_delta.tv_sec + tv_delta.tv_usec/1000000.0;
+	interval_float = t->tv_delta.tv_sec + t->tv_delta.tv_usec/1000000.0;
 
 	tsc = t->tsc * tsc_tweak;
 
@@ -1308,6 +1309,7 @@ delta_thread(struct thread_data *new, struct thread_data *old,
 	 * over-write old w/ new so we can print end of interval values
 	 */
 
+	timersub(&new->tv_begin, &old->tv_begin, &old->tv_delta);
 	old->tv_begin = new->tv_begin;
 	old->tv_end = new->tv_end;
 
@@ -1403,6 +1405,8 @@ void clear_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 	t->tv_begin.tv_usec = 0;
 	t->tv_end.tv_sec = 0;
 	t->tv_end.tv_usec = 0;
+	t->tv_delta.tv_sec = 0;
+	t->tv_delta.tv_usec = 0;
 
 	t->tsc = 0;
 	t->aperf = 0;
@@ -1572,6 +1576,9 @@ void compute_average(struct thread_data *t, struct core_data *c,
 
 	for_all_cpus(sum_counters, t, c, p);
 
+	/* Use the global time delta for the average. */
+	average.threads.tv_delta = tv_delta;
+
 	average.threads.tsc /= topo.num_cpus;
 	average.threads.aperf /= topo.num_cpus;
 	average.threads.mperf /= topo.num_cpus;
@@ -1761,13 +1768,13 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	struct msr_counter *mp;
 	int i;
 
-	gettimeofday(&t->tv_begin, (struct timezone *)NULL);
-
 	if (cpu_migrate(cpu)) {
 		fprintf(outf, "Could not migrate to CPU %d\n", cpu);
 		return -1;
 	}
 
+	gettimeofday(&t->tv_begin, (struct timezone *)NULL);
+
 	if (first_counter_read)
 		get_apic_id(t);
 retry:
-- 
2.20.1

