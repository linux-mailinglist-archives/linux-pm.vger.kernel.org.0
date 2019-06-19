Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E94E4B72E
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 13:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731693AbfFSLgD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 07:36:03 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35012 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731731AbfFSLgD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2019 07:36:03 -0400
Received: by mail-pf1-f194.google.com with SMTP id d126so9590348pfd.2
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2019 04:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TMflq8N+0gjwZQm7aaR4fEWjevpmJ2Km/I3/aGC/zcs=;
        b=FdhMZ5VF0ZlGiskIF3jgzAyN072YIAf8CvQqewDd0mnEaGbolSAhEnuX5Cq4LC5zRH
         aM31xTVnkg/TW7axh+cs9Fv1mqqGwLcliyaPdxkndf1u8/v1fc8dTAFuywqoCTp6QaLg
         1QC1rXXUqHbJzrxS/e1mHKXet73M40N7pRUVBDVWIPaXoveXLHOZlNtBQM9lLKigUjMi
         YJZQuUY8NO6X4y28v4rZ0+exHioxdYQBGU4gzqp1Rp5Bdv4BopUg/slx70RceyBLWPrl
         5pk8DEg5vDKH/ADqzJCnW0631EQGKVXqwnO41gTFGtOQJeZKB8RYvk26d89wm4YcT7gw
         Td4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TMflq8N+0gjwZQm7aaR4fEWjevpmJ2Km/I3/aGC/zcs=;
        b=sd3zYCjQFHR2J2Dy9RmPK3Z3GzyTa3GSuHALVrX4FbyymzrdjTh+WLwD7UFefNR0uA
         oHmtMWTWFmpYOR/oYI+a5snKfOg2bvzbPZjJGH7a4jutJDEIlfDkwWG+9RTlpp/+ZZE4
         FVrbucBxoJyQmKDgoLncRc5VhoKRzX5SeJeK5zxAtOQ4pfb76WGKpEk/PN5IWy+Hw/eU
         /vAFOAMGqyQ3kmbA7KGCnkxvA+eDdOjUg2Y1UsPjoT5LeaNzTF/ZPQwDiuX0yomZ4xtY
         BGlrBZqFNOuXXW4bHKo1nM+S77cHoVe4HJsqw3NmaT60Tyb1kw8fgTDPFDj7bmtlVWBr
         NYWw==
X-Gm-Message-State: APjAAAWtLqe9GIjahrr32oNh9WWqUPqsphiXXh1ch21PkKRatvUYnOON
        Cu8uJT1cfCoIpYC4VTiZOdpyYvVCWDE=
X-Google-Smtp-Source: APXvYqw46XBLHxHHEsp5ooy3Doj4uJCwAVI2cXDKT7xVJAkJ3J9LS5NUDpdMiLoqewYDPXY9xeJZHw==
X-Received: by 2002:aa7:9a8a:: with SMTP id w10mr9164646pfi.66.1560944162249;
        Wed, 19 Jun 2019 04:36:02 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id s24sm18124738pfh.133.2019.06.19.04.36.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 04:36:01 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] cpufreq: Reuse cpufreq_update_current_freq() in __cpufreq_get()
Date:   Wed, 19 Jun 2019 17:05:41 +0530
Message-Id: <3887524d339664c31b763963f1b34bda490cb1ac.1560944014.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1560944014.git.viresh.kumar@linaro.org>
References: <cover.1560944014.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Their implementations are quite similar, lets modify
cpufreq_update_current_freq() a little and use it from __cpufreq_get().

Also rename cpufreq_update_current_freq() to
cpufreq_verify_current_freq(), as that's what it is doing.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 70 ++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 42 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 5f5c7a516c74..4556a53fc764 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1547,6 +1547,30 @@ static void cpufreq_out_of_sync(struct cpufreq_policy *policy,
 	cpufreq_freq_transition_end(policy, &freqs, 0);
 }
 
+static unsigned int cpufreq_verify_current_freq(struct cpufreq_policy *policy, bool update)
+{
+	unsigned int new_freq;
+
+	new_freq = cpufreq_driver->get(policy->cpu);
+	if (!new_freq)
+		return 0;
+
+	/*
+	 * If fast frequency switching is used with the given policy, the check
+	 * against policy->cur is pointless, so skip it in that case.
+	 */
+	if (policy->fast_switch_enabled || !has_target())
+		return new_freq;
+
+	if (policy->cur != new_freq) {
+		cpufreq_out_of_sync(policy, new_freq);
+		if (update)
+			schedule_work(&policy->update);
+	}
+
+	return new_freq;
+}
+
 /**
  * cpufreq_quick_get - get the CPU frequency (in kHz) from policy->cur
  * @cpu: CPU number
@@ -1602,30 +1626,10 @@ EXPORT_SYMBOL(cpufreq_quick_get_max);
 
 static unsigned int __cpufreq_get(struct cpufreq_policy *policy)
 {
-	unsigned int ret_freq = 0;
-
 	if (unlikely(policy_is_inactive(policy)))
-		return ret_freq;
-
-	ret_freq = cpufreq_driver->get(policy->cpu);
-
-	/*
-	 * If fast frequency switching is used with the given policy, the check
-	 * against policy->cur is pointless, so skip it in that case too.
-	 */
-	if (policy->fast_switch_enabled)
-		return ret_freq;
-
-	if (has_target() && ret_freq && policy->cur) {
-		/* verify no discrepancy between actual and
-					saved value exists */
-		if (unlikely(ret_freq != policy->cur)) {
-			cpufreq_out_of_sync(policy, ret_freq);
-			schedule_work(&policy->update);
-		}
-	}
+		return 0;
 
-	return ret_freq;
+	return cpufreq_verify_current_freq(policy, true);
 }
 
 /**
@@ -1652,24 +1656,6 @@ unsigned int cpufreq_get(unsigned int cpu)
 }
 EXPORT_SYMBOL(cpufreq_get);
 
-static unsigned int cpufreq_update_current_freq(struct cpufreq_policy *policy)
-{
-	unsigned int new_freq;
-
-	new_freq = cpufreq_driver->get(policy->cpu);
-	if (!new_freq)
-		return 0;
-
-	if (!policy->cur) {
-		pr_debug("cpufreq: Driver did not initialize current freq\n");
-		policy->cur = new_freq;
-	} else if (policy->cur != new_freq && has_target()) {
-		cpufreq_out_of_sync(policy, new_freq);
-	}
-
-	return new_freq;
-}
-
 static struct subsys_interface cpufreq_interface = {
 	.name		= "cpufreq",
 	.subsys		= &cpu_subsys,
@@ -2151,7 +2137,7 @@ static int cpufreq_start_governor(struct cpufreq_policy *policy)
 	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
 
 	if (cpufreq_driver->get)
-		cpufreq_update_current_freq(policy);
+		cpufreq_verify_current_freq(policy, false);
 
 	if (policy->governor->start) {
 		ret = policy->governor->start(policy);
@@ -2402,7 +2388,7 @@ void cpufreq_update_policy(unsigned int cpu)
 	 * -> ask driver for current freq and notify governors about a change
 	 */
 	if (cpufreq_driver->get && has_target() &&
-	    (cpufreq_suspended || WARN_ON(!cpufreq_update_current_freq(policy))))
+	    (cpufreq_suspended || WARN_ON(!cpufreq_verify_current_freq(policy, false))))
 		goto unlock;
 
 	pr_debug("updating policy for CPU %u\n", cpu);
-- 
2.21.0.rc0.269.g1a574e7a288b

