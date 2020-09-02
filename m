Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9C825A69E
	for <lists+linux-pm@lfdr.de>; Wed,  2 Sep 2020 09:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgIBHZN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Sep 2020 03:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbgIBHZL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2020 03:25:11 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D41EC061244
        for <linux-pm@vger.kernel.org>; Wed,  2 Sep 2020 00:25:11 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id z15so1879198plo.7
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2020 00:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j9iUKTmxDCnsjI9D2FE0HYnpMw3U8pIfYBDaFqDjR3Y=;
        b=kQt3TjnH53yJTlq71MyV9vFyJS84thyJs1LOMPFhAgnL+ipFolq38cRsvGI+ZjULq6
         5RnEoMl2TA4mjX6LGAcMMZ+xeaxxju8XuJTzD1CGCxCqkU8arjVrqUbyNv4iIXIjJJ4L
         V+T0vFkFUw5dr65LdX/ot8oYoZp3hP4nYxIDStJr0Hs5q7Gp0k/IBsa7LwX3qI1pMVNd
         B3Z7lbgLwLX2twOpkdBrUkV7SrkZs8sSIOb55vdq/CCvueQrqpomorSlFMJKqnKx8no5
         rNlggaim9Pl0tkHcjliy+/zKU1KXD7FA2zpKIJuydPc3iUtlMKCdKiKGEkrI9yP57VB0
         cGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j9iUKTmxDCnsjI9D2FE0HYnpMw3U8pIfYBDaFqDjR3Y=;
        b=Eq2N+Ls3JlFypw8XOU5fv67j9U/Lu0VVKjBv2rwcTMRoH7uOkgr6BOzRUb97zPswL4
         Y8kVeqA7512qG5m7eMK7pCG4FedHEGKf1gMEud5FgO/q1UkgBIYF2MhugVprflWjuqfN
         hVUCGc1DClMLZz/bhEZu+6Dg5ucUyFIZkRvYJtTQ6yqPh8/E2W3JBqULn8xIz+lgqDk/
         8eKwiFxct1qXHzAn1qyTun7s9CfACvt1jH+hPlaiYPjdkrcNTBC4fCjHEWjyyatAipk5
         6hDaO8aE/p444VmmXptQxr4qatEkpJHEByBh86Z9oN2/pmAeAEaajGCFJeduQl5l8ces
         GFbQ==
X-Gm-Message-State: AOAM532r7gEfzLTQqSvCJz/I/CoC5Pe5NkFdJIn5S/DBZ/q0Lj68Q+1P
        nDHmAwAw4cr4svXVJQ3SZlBaYg==
X-Google-Smtp-Source: ABdhPJwlUDBlA85je2N0rYpc1CGOMjajYrsxaHJHdqZJ6B09t2Q9wkp3ArHnkaRPJTLULsUMJ58QEA==
X-Received: by 2002:a17:90a:d594:: with SMTP id v20mr1148478pju.227.1599031510786;
        Wed, 02 Sep 2020 00:25:10 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id y1sm4287781pgr.3.2020.09.02.00.25.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Sep 2020 00:25:10 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Cc:     linux-pm@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        cristian.marussi@arm.com, sudeep.holla@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] cpufreq: Move traces and update to policy->cur to cpufreq core
Date:   Wed,  2 Sep 2020 12:54:44 +0530
Message-Id: <3f76b8bb243d522be5d858cbdf7f676b0e1f9e96.1599031227.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1599031227.git.viresh.kumar@linaro.org>
References: <cover.1599031227.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cpufreq core handles the updates to policy->cur and recording of
cpufreq trace events for all the governors except schedutil's fast
switch case.

Move that as well to cpufreq core for consistency and readability.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c        | 14 ++++++++++++--
 kernel/sched/cpufreq_schedutil.c | 12 +-----------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d5fe64e96be9..bc930f6ecff6 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2056,11 +2056,21 @@ EXPORT_SYMBOL(cpufreq_unregister_notifier);
 unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
 					unsigned int target_freq)
 {
+	int cpu;
+
 	target_freq = clamp_val(target_freq, policy->min, policy->max);
 	target_freq = cpufreq_driver->fast_switch(policy, target_freq);
 
-	if (target_freq)
-		cpufreq_stats_record_transition(policy, target_freq);
+	if (!target_freq)
+		return 0;
+
+	policy->cur = target_freq;
+	cpufreq_stats_record_transition(policy, target_freq);
+
+	if (trace_cpu_frequency_enabled()) {
+		for_each_cpu(cpu, policy->cpus)
+			trace_cpu_frequency(target_freq, cpu);
+	}
 
 	return target_freq;
 }
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index e39008242cf4..28f6d1ad608b 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -115,21 +115,11 @@ static void sugov_fast_switch(struct sugov_policy *sg_policy, u64 time,
 			      unsigned int next_freq)
 {
 	struct cpufreq_policy *policy = sg_policy->policy;
-	int cpu;
 
 	if (!sugov_update_next_freq(sg_policy, time, next_freq))
 		return;
 
-	next_freq = cpufreq_driver_fast_switch(policy, next_freq);
-	if (!next_freq)
-		return;
-
-	policy->cur = next_freq;
-
-	if (trace_cpu_frequency_enabled()) {
-		for_each_cpu(cpu, policy->cpus)
-			trace_cpu_frequency(next_freq, cpu);
-	}
+	cpufreq_driver_fast_switch(policy, next_freq);
 }
 
 static void sugov_deferred_update(struct sugov_policy *sg_policy, u64 time,
-- 
2.25.0.rc1.19.g042ed3e048af

