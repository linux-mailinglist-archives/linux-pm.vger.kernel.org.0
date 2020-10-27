Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F05A29AB48
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 12:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439111AbgJ0Lze (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 07:55:34 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53228 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750346AbgJ0Lzd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 07:55:33 -0400
Received: by mail-pj1-f66.google.com with SMTP id o1so655280pjt.2;
        Tue, 27 Oct 2020 04:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HeJY28BQR39ubPE3upvvJihsd+e9UZsRU1A1Q1vQAqE=;
        b=XQ5Yyk7eg7PeAalKutARz4YDUL3b+aZEi9S3fTfeEq6ymjlXCQw5bf7d0wkkpBqmSz
         wLO+safY+a17yx21fzXVSDUmYz93UA7RV1pqYekvJu2ZZBZuXlxCC+TeQ3zNz/VJFdPs
         tXafPgmipGZCwpWWqm1YVTqR6j1xtclaT5vDCQR/KbYmG593i1Odw3jMXCrP0ZN4BNzZ
         HAldtsJnaNrD/Fd90HZX+GxA9aajvABcO/k6TVLAfHVAiNwZz75kCCuzAoxW2sxyGY+m
         v7iXrGW8PO6wITfrDhlCkLgi1pL7xC0QcK5PozQqMXDD5H8IOLocntnJ3VryQhzxMWQr
         RTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HeJY28BQR39ubPE3upvvJihsd+e9UZsRU1A1Q1vQAqE=;
        b=TYY7BWRC2uWjhOG4n1o8RGA1hfGjH62wqYBYCA/rROjlhOSkECXJ0dLiWV8pIYrX4a
         lxPIwE6+aRhKzNKmmKiRr5Pi3WDGix0ugWEetpXuDBfJsqbOnrR79qdqAgUcUZndQ9T3
         qaVRRsOmr4y26Aw4oG8OTQEO7vWmpS0LbUoXHx4bDdZBhFFIoCUBSWB9bm7jXkgnt+sI
         cM2IvKy6HZw2UCuZbAv69C95n0ynV1PV+e1Ymosis7itOY3OtiMGKJWTcZNgTvVTBVvI
         lE7E72Qm2I1YTBqT38RmqPFcTK4YARijj74RnnGidP2R47cJRFbpOLzAc4er+DfCuoBg
         aRXA==
X-Gm-Message-State: AOAM533R9fp6/y+YBjKUJYqZMrXv8QPIGA3/3ZHsZykU3q6qxzNKDG/5
        qIg6QaqhhhQ6vKTNl5pEDWM=
X-Google-Smtp-Source: ABdhPJxl5OtHcTzQDhtTMNxCcuwVAeUGerrHzZBfFoUfZ261kBXXX1sRcWR8t1gKZTRGjw+0YgK2qw==
X-Received: by 2002:a17:90a:aa90:: with SMTP id l16mr1697874pjq.0.1603799732527;
        Tue, 27 Oct 2020 04:55:32 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([209.9.72.215])
        by smtp.gmail.com with ESMTPSA id bx24sm1932897pjb.20.2020.10.27.04.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 04:55:31 -0700 (PDT)
From:   zhuguangqing83@gmail.com
To:     viresh.kumar@linaro.org, rjw@rjwysocki.net, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhuguangqing <zhuguangqing@xiaomi.com>
Subject: [PATCH] cpufreq: schedutil: set sg_policy->next_freq to the final cpufreq
Date:   Tue, 27 Oct 2020 19:54:59 +0800
Message-Id: <20201027115459.19318-1-zhuguangqing83@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: zhuguangqing <zhuguangqing@xiaomi.com>

In the following code path, next_freq is clamped between policy->min
and policy->max twice in functions cpufreq_driver_resolve_freq() and
cpufreq_driver_fast_switch(). For there is no update_lock in the code
path, policy->min and policy->max may be modified (one or more times),
so sg_policy->next_freq updated in function sugov_update_next_freq()
may be not the final cpufreq. Next time when we use
"if (sg_policy->next_freq == next_freq)" to judge whether to update
next_freq, we may get a wrong result.

-> sugov_update_single()
  -> get_next_freq()
    -> cpufreq_driver_resolve_freq()
  -> sugov_fast_switch()
    -> sugov_update_next_freq()
    -> cpufreq_driver_fast_switch()

For example, at first sg_policy->next_freq is 1 GHz, but the final
cpufreq is 1.2 GHz because policy->min is modified to 1.2 GHz when
we reached cpufreq_driver_fast_switch(). Then next time, policy->min
is changed before we reached cpufreq_driver_resolve_freq() and (assume)
next_freq is 1 GHz, we find "if (sg_policy->next_freq == next_freq)" is
satisfied so we don't change the cpufreq. Actually we should change
the cpufreq to 1.0 GHz this time.

Signed-off-by: zhuguangqing <zhuguangqing@xiaomi.com>
---
 drivers/cpufreq/cpufreq.c        |  6 +++---
 include/linux/cpufreq.h          |  2 +-
 kernel/sched/cpufreq_schedutil.c | 21 ++++++++++-----------
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index f4b60663efe6..7e8e03c7506b 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2057,13 +2057,13 @@ EXPORT_SYMBOL(cpufreq_unregister_notifier);
  * error condition, the hardware configuration must be preserved.
  */
 unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
-					unsigned int target_freq)
+					unsigned int *target_freq)
 {
 	unsigned int freq;
 	int cpu;
 
-	target_freq = clamp_val(target_freq, policy->min, policy->max);
-	freq = cpufreq_driver->fast_switch(policy, target_freq);
+	*target_freq = clamp_val(*target_freq, policy->min, policy->max);
+	freq = cpufreq_driver->fast_switch(policy, *target_freq);
 
 	if (!freq)
 		return 0;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index fa37b1c66443..790df38d48de 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -569,7 +569,7 @@ struct cpufreq_governor {
 
 /* Pass a target to the cpufreq driver */
 unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
-					unsigned int target_freq);
+					unsigned int *target_freq);
 int cpufreq_driver_target(struct cpufreq_policy *policy,
 				 unsigned int target_freq,
 				 unsigned int relation);
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index e254745a82cb..38d2dc55dd95 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -99,31 +99,30 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 	return delta_ns >= sg_policy->freq_update_delay_ns;
 }
 
-static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
+static inline bool sugov_update_next_freq(struct sugov_policy *sg_policy,
 				   unsigned int next_freq)
 {
-	if (sg_policy->next_freq == next_freq)
-		return false;
-
-	sg_policy->next_freq = next_freq;
-	sg_policy->last_freq_update_time = time;
-
-	return true;
+	return sg_policy->next_freq == next_freq ? false : true;
 }
 
 static void sugov_fast_switch(struct sugov_policy *sg_policy, u64 time,
 			      unsigned int next_freq)
 {
-	if (sugov_update_next_freq(sg_policy, time, next_freq))
-		cpufreq_driver_fast_switch(sg_policy->policy, next_freq);
+	if (sugov_update_next_freq(sg_policy, next_freq)) {
+		cpufreq_driver_fast_switch(sg_policy->policy, &next_freq);
+		sg_policy->next_freq = next_freq;
+		sg_policy->last_freq_update_time = time;
+	}
 }
 
 static void sugov_deferred_update(struct sugov_policy *sg_policy, u64 time,
 				  unsigned int next_freq)
 {
-	if (!sugov_update_next_freq(sg_policy, time, next_freq))
+	if (!sugov_update_next_freq(sg_policy, next_freq))
 		return;
 
+	sg_policy->next_freq = next_freq;
+	sg_policy->last_freq_update_time = time;
 	if (!sg_policy->work_in_progress) {
 		sg_policy->work_in_progress = true;
 		irq_work_queue(&sg_policy->irq_work);
-- 
2.17.1

