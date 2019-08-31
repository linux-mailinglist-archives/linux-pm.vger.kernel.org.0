Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAB65A45F3
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2019 21:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbfHaTfi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Aug 2019 15:35:38 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40851 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbfHaTfh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Aug 2019 15:35:37 -0400
Received: by mail-io1-f66.google.com with SMTP id h144so5755164iof.7
        for <linux-pm@vger.kernel.org>; Sat, 31 Aug 2019 12:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:reply-to:organization:content-transfer-encoding;
        bh=AUc8NEFTnhlWM3noPKwbR9TPdg7/y9VDPfoK01TXc1Y=;
        b=RhRO793uwXfHMpRIfMSS61BWK9LMw4eD/W1agPBaU0GfZRMctJsYuFS5JzOb1uuOfq
         ItOA4SW/eqNbqDlaWMKgYxMFlMX7lYLWTvdbYDYuVwXC+BRYQiXzn7Pc4H8jYvGLQ0RV
         qNUsl4Cl7UmLgSGJgL+pbg/+7Bhqpe5u7SpoAPl21uUu8mH/Io7Uu2t/Y2UJtY5ZF3hu
         p+tdP+FC3J+nm/xgOOY//SHawWqCoH+915CuYSWzMKRPZZ+nPDK617CaBhky054RUrQb
         EPRcrfiENNKGc9/G9YzvD+sgWQr6tevK2fPQs7HygHY9pOW3B/l/TCONXWW91oRNODNz
         8rYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:reply-to:organization
         :content-transfer-encoding;
        bh=AUc8NEFTnhlWM3noPKwbR9TPdg7/y9VDPfoK01TXc1Y=;
        b=cNqPhS1a9n4RXqruBxsbgEQXjCR6g2UGliJZWqDQhSCkTgGEzkmu968wGsDq70W9k1
         8Qo06ALkJpYm1me8QiXpRe9DuV8Adgwqk5/z4PGUtC1wRFKbqyuaBUcagHg6jINJspRu
         mjdIaG3UiewXM7Zs2Jg05jODP1FotcgYJmZ+tKplmiJWmYijxRBvhwTM3TBUxiX2HFhA
         AbLBuJI4AcEQ2iFJgqnlABSDpt+5QN99Ydy6CNz8j+gifKjlyxuYJ73UlGZWa7Hu9Bo6
         PN7aorWse5l7mCkwhBJ/a91R11NjicFWWi1XLXnY95cj0pi1muJGiVyjxmc3zsYhNzSc
         dRqQ==
X-Gm-Message-State: APjAAAWpPCneQDQn53vTjYSrv39pQeQ/cZSwGv44fFNs7LdxjDXDIGgZ
        ORU28dxM4hr7ZA0SYl9eLRvHnz3v
X-Google-Smtp-Source: APXvYqyPKfWM9r1pdUz4kuyUpmZ+UnV3xIhlSuj7rYqL7XuIS5ZWpNBp2vt5li7MG85Z1JxNOEteAA==
X-Received: by 2002:a02:495:: with SMTP id 143mr22977859jab.94.1567280136433;
        Sat, 31 Aug 2019 12:35:36 -0700 (PDT)
Received: from nuc8.tds (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id r2sm6937376ioh.61.2019.08.31.12.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 12:35:35 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     linux-pm@vger.kernel.org
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <len.brown@intel.com>
Subject: [PATCH 16/19] tools/power turbostat: Fix CPU%C1 display value
Date:   Sat, 31 Aug 2019 15:34:55 -0400
Message-Id: <1e9042b9c8d46ada9ee7b3339a31f50d12e5d291.1567277326.git.len.brown@intel.com>
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

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

In some case C1% will be wrong value, when platform doesn't have MSR for
C1 residency.

For example:
Core    CPU     CPU%c1
-       -       100.00
0       0       100.00
0       2       100.00
1       1       100.00
1       3       100.00

But adding Busy% will fix this
Core    CPU     Busy%   CPU%c1
-       -       99.77   0.23
0       0       99.77   0.23
0       2       99.77   0.23
1       1       99.77   0.23
1       3       99.77   0.23

This issue can be reproduced on most of the recent systems including
Broadwell, Skylake and later.

This is because if we don't select Busy% or Avg_MHz or Bzy_MHz then
mperf value will not be read from MSR, so it will be 0. But this
is required for C1% calculation when MSR for C1 residency is not present.
Same is true for C3, C6 and C7 column selection.

So add another define DO_BIC_READ(), which doesn't depend on user
column selection and use for mperf, C3, C6 and C7 related counters.
So when there is no platform support for C1 residency counters,
we still read these counters, if the CPU has support and user selected
display of CPU%c1.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 7d72268e546d..f57c4023231e 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -507,6 +507,7 @@ unsigned long long bic_enabled = (0xFFFFFFFFFFFFFFFFULL & ~BIC_DISABLED_BY_DEFAU
 unsigned long long bic_present = BIC_USEC | BIC_TOD | BIC_sysfs | BIC_APIC | BIC_X2APIC;
 
 #define DO_BIC(COUNTER_NAME) (bic_enabled & bic_present & COUNTER_NAME)
+#define DO_BIC_READ(COUNTER_NAME) (bic_present & COUNTER_NAME)
 #define ENABLE_BIC(COUNTER_NAME) (bic_enabled |= COUNTER_NAME)
 #define BIC_PRESENT(COUNTER_BIT) (bic_present |= COUNTER_BIT)
 #define BIC_NOT_PRESENT(COUNTER_BIT) (bic_present &= ~COUNTER_BIT)
@@ -1287,6 +1288,14 @@ delta_core(struct core_data *new, struct core_data *old)
 	}
 }
 
+int soft_c1_residency_display(int bic)
+{
+	if (!DO_BIC(BIC_CPU_c1) || use_c1_residency_msr)
+		return 0;
+
+	return DO_BIC_READ(bic);
+}
+
 /*
  * old = new - old
  */
@@ -1323,7 +1332,8 @@ delta_thread(struct thread_data *new, struct thread_data *old,
 
 	old->c1 = new->c1 - old->c1;
 
-	if (DO_BIC(BIC_Avg_MHz) || DO_BIC(BIC_Busy) || DO_BIC(BIC_Bzy_MHz)) {
+	if (DO_BIC(BIC_Avg_MHz) || DO_BIC(BIC_Busy) || DO_BIC(BIC_Bzy_MHz) ||
+	    soft_c1_residency_display(BIC_Avg_MHz)) {
 		if ((new->aperf > old->aperf) && (new->mperf > old->mperf)) {
 			old->aperf = new->aperf - old->aperf;
 			old->mperf = new->mperf - old->mperf;
@@ -1780,7 +1790,8 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 retry:
 	t->tsc = rdtsc();	/* we are running on local CPU of interest */
 
-	if (DO_BIC(BIC_Avg_MHz) || DO_BIC(BIC_Busy) || DO_BIC(BIC_Bzy_MHz)) {
+	if (DO_BIC(BIC_Avg_MHz) || DO_BIC(BIC_Busy) || DO_BIC(BIC_Bzy_MHz) ||
+	    soft_c1_residency_display(BIC_Avg_MHz)) {
 		unsigned long long tsc_before, tsc_between, tsc_after, aperf_time, mperf_time;
 
 		/*
@@ -1857,20 +1868,20 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	if (!(t->flags & CPU_IS_FIRST_THREAD_IN_CORE))
 		goto done;
 
-	if (DO_BIC(BIC_CPU_c3)) {
+	if (DO_BIC(BIC_CPU_c3) || soft_c1_residency_display(BIC_CPU_c3)) {
 		if (get_msr(cpu, MSR_CORE_C3_RESIDENCY, &c->c3))
 			return -6;
 	}
 
-	if (DO_BIC(BIC_CPU_c6) && !do_knl_cstates) {
+	if ((DO_BIC(BIC_CPU_c6) || soft_c1_residency_display(BIC_CPU_c6)) && !do_knl_cstates) {
 		if (get_msr(cpu, MSR_CORE_C6_RESIDENCY, &c->c6))
 			return -7;
-	} else if (do_knl_cstates) {
+	} else if (do_knl_cstates || soft_c1_residency_display(BIC_CPU_c6)) {
 		if (get_msr(cpu, MSR_KNL_CORE_C6_RESIDENCY, &c->c6))
 			return -7;
 	}
 
-	if (DO_BIC(BIC_CPU_c7))
+	if (DO_BIC(BIC_CPU_c7) || soft_c1_residency_display(BIC_CPU_c7))
 		if (get_msr(cpu, MSR_CORE_C7_RESIDENCY, &c->c7))
 			return -8;
 
-- 
2.20.1

