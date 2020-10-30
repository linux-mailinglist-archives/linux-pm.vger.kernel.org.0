Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE3129FE77
	for <lists+linux-pm@lfdr.de>; Fri, 30 Oct 2020 08:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgJ3HbF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Oct 2020 03:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgJ3HbE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2020 03:31:04 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80276C0613D2
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2020 00:21:15 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 133so4481508pfx.11
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2020 00:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FKffrVOQX7anjwx1MfdXS1XL/Tw95pOKF2Q6qrmVHDE=;
        b=hBoHo5nv0l5AXDe0dorVGfDWr4y1RVEy4vrUnJXlMep3X8WWcdiu2KQ24MeBpkT5E6
         Yn7Gc5Nd839ZswOuefX+h6OgXwVL6AgJ/DewfHXqrRhXuoJxwKEu9IAH/vJfC6SlxU11
         lDtnkGl5EjjFkXyIouXEyyNEBfcU0eFx0mQBO4fqD79yEnd2kT8umR8lV14TOzILs3NN
         uv2gRxmgv5p0m6oQMKgU2eSerYdv32qi5UzHRNf9nMp1dj8PWcKnfR21OENDaxMEYQwu
         wKByzuPCi9GKwDznCzl9KTABGmL+d3aTwfvBe8R0adaVlDiODhFL3/gD6Q1tZGxp5NHU
         sDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FKffrVOQX7anjwx1MfdXS1XL/Tw95pOKF2Q6qrmVHDE=;
        b=kzT5Gkvzltl4Z0mWAcEm06JqHjYra1ttZa1ELUWV/3BWh8U8UFCkBDE0xHxgKRvhuC
         tDJqX8cDawGzNiezZJ70xQXkLzCe5pJ6i+yHgOAnVs/ViIIw9P5C+ozDE/US2CS6aA++
         UlPWPpm9wsvQNP8QsVwhsAC5Z/4VXkjx8YztyK3gZN3qMXoydBVZBeZHuf+Ckxv03bn6
         4LqCUN94zd5vLU041rVJyPB1KwPV9GBQHd5jWeDsMx5joX5SyPHV+PLdR6lV5zdB+DtH
         k41JoEGDZYXfA39UlM2k7wT8VDQmbFEC4uzXqczNtPP/zQLgB19sHOaC8rrK7eYJ0Jp2
         +QAA==
X-Gm-Message-State: AOAM531c05q8Qz63m+GTUCut25VqT/TmzK9Xdo3+X1gKgsN49T8IR1lE
        2UocgMoBt4BXljtITke/yf4yNFlRMGntZw==
X-Google-Smtp-Source: ABdhPJzxtkLCcvB3IIC01eRZtq7WVSgCMxuhOXw/XpBpz6w2AhlGXOpCoZZTJ7was9xa0tSYWnHl2w==
X-Received: by 2002:a62:216:0:b029:164:bdf3:2cbf with SMTP id 22-20020a6202160000b0290164bdf32cbfmr5943609pfc.33.1604042474765;
        Fri, 30 Oct 2020 00:21:14 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id kk14sm2004031pjb.47.2020.10.30.00.21.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2020 00:21:13 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-pm@vger.kernel.org, zhuguangqing <zhuguangqing@xiaomi.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: schedutil: Don't skip freq update if need_freq_update is set
Date:   Fri, 30 Oct 2020 12:51:08 +0530
Message-Id: <207ae817a778d79a99c30cb48f2ea1f527416519.1604042421.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <2954009.kBar6x9KXa@kreacher>
References: <2954009.kBar6x9KXa@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cpufreq policy's frequency limits (min/max) can get changed at any
point of time, while schedutil is trying to update the next frequency.
Though the schedutil governor has necessary locking and support in place
to make sure we don't miss any of those updates, there is a corner case
where the governor will find that the CPU is already running at the
desired frequency and so may skip an update.

For example, consider that the CPU can run at 1 GHz, 1.2 GHz and 1.4 GHz
and is running at 1 GHz currently. Schedutil tries to update the
frequency to 1.2 GHz, during this time the policy limits get changed as
policy->min = 1.4 GHz. As schedutil (and cpufreq core) does clamp the
frequency at various instances, we will eventually set the frequency to
1.4 GHz, while we will save 1.2 GHz in sg_policy->next_freq.

Now lets say the policy limits get changed back at this time with
policy->min as 1 GHz. The next time schedutil is invoked by the
scheduler, we will reevaluate the next frequency (because
need_freq_update will get set due to limits change event) and lets say
we want to set the frequency to 1.2 GHz again. At this point
sugov_update_next_freq() will find the next_freq == current_freq and
will abort the update, while the CPU actually runs at 1.4 GHz.

Until now need_freq_update was used as a flag to indicate that the
policy's frequency limits have changed, and that we should consider the
new limits while reevaluating the next frequency.

This patch fixes the above mentioned issue by extending the purpose of
the need_freq_update flag. If this flag is set now, the schedutil
governor will not try to abort a frequency change even if next_freq ==
current_freq.

As similar behavior is required in the case of
CPUFREQ_NEED_UPDATE_LIMITS flag as well, need_freq_update will never be
set to false if that flag is set for the driver.

We also don't need to consider the need_freq_update flag in
sugov_update_single() anymore to handle the special case of busy CPU, as
we won't abort a frequency update anymore.

Reported-by: zhuguangqing <zhuguangqing@xiaomi.com>
Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index c03a5775d019..c6861be02c86 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -102,9 +102,12 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
 				   unsigned int next_freq)
 {
-	if (sg_policy->next_freq == next_freq &&
-	    !cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
-		return false;
+	if (!sg_policy->need_freq_update) {
+		if (sg_policy->next_freq == next_freq)
+			return false;
+	} else if (!cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS)) {
+		sg_policy->need_freq_update = false;
+	}
 
 	sg_policy->next_freq = next_freq;
 	sg_policy->last_freq_update_time = time;
@@ -162,11 +165,9 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 
 	freq = map_util_freq(util, freq, max);
 
-	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update &&
-	    !cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
+	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
 		return sg_policy->next_freq;
 
-	sg_policy->need_freq_update = false;
 	sg_policy->cached_raw_freq = freq;
 	return cpufreq_driver_resolve_freq(policy, freq);
 }
@@ -442,7 +443,6 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	unsigned long util, max;
 	unsigned int next_f;
-	bool busy;
 	unsigned int cached_freq = sg_policy->cached_raw_freq;
 
 	sugov_iowait_boost(sg_cpu, time, flags);
@@ -453,9 +453,6 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	if (!sugov_should_update_freq(sg_policy, time))
 		return;
 
-	/* Limits may have changed, don't skip frequency update */
-	busy = !sg_policy->need_freq_update && sugov_cpu_is_busy(sg_cpu);
-
 	util = sugov_get_util(sg_cpu);
 	max = sg_cpu->max;
 	util = sugov_iowait_apply(sg_cpu, time, util, max);
@@ -464,7 +461,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	 * Do not reduce the frequency if the CPU has not been idle
 	 * recently, as the reduction is likely to be premature then.
 	 */
-	if (busy && next_f < sg_policy->next_freq) {
+	if (sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq) {
 		next_f = sg_policy->next_freq;
 
 		/* Restore cached freq as next_freq has changed */
@@ -829,9 +826,10 @@ static int sugov_start(struct cpufreq_policy *policy)
 	sg_policy->next_freq			= 0;
 	sg_policy->work_in_progress		= false;
 	sg_policy->limits_changed		= false;
-	sg_policy->need_freq_update		= false;
 	sg_policy->cached_raw_freq		= 0;
 
+	sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
+
 	for_each_cpu(cpu, policy->cpus) {
 		struct sugov_cpu *sg_cpu = &per_cpu(sugov_cpu, cpu);
 
-- 
2.25.0.rc1.19.g042ed3e048af

