Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0376726BD78
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 08:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgIPGqI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 02:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgIPGp5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2020 02:45:57 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62581C061797
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 23:45:56 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j34so3338030pgi.7
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 23:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j9iUKTmxDCnsjI9D2FE0HYnpMw3U8pIfYBDaFqDjR3Y=;
        b=uRZlRFdFIqJ1hKepe6TwTT1ejfn2sNcY6FUbnxA60wp4fHk8d8BMKOGYFiKtliEDU7
         nYTypBc7qrLNtqkCMI5Z2uC/fYXMqw9JwIc/ZGtKT6Jr2g6BzWabwwv05AJGDL75/z4G
         jdeMhtb9vgaumuOQlCfMAj/HHO0euaF6sNXj1azlUmDyirVJf6ZshZdrv5KkDVor80cX
         o9tucm5tMCET1BAjVyTBZEmjXfbG96qvgsxMxXCbzM/oM9C9ZobC3F3z4UeAABqjTPUf
         qCk3Lh8YBaiPeG3B5tIp2q6lovw5DshTPexPdgJqkzsyijV2X7LEb2OU6DcJepFIKOs9
         6GcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j9iUKTmxDCnsjI9D2FE0HYnpMw3U8pIfYBDaFqDjR3Y=;
        b=ncwozEgf9XrM9M7/hK/+YODeiZL0WZP3c3s0jlqBQknrq5/siaF0VVE51cAPdpJ5Dl
         WfT5UC+fR/VSYE9FD0dnD9ANSrMZMD5NVUVRig79X7ww604RO37zEnMrApO7XGRyTgJ3
         YGLTGzNDDHdqEcXAE03/bBq40E7QUxv+sfCevXrvjF+5i67bXeDDW4XGDBlPCrOmM535
         JxgOuXtMZmcsi7ypbJ4fvsruCn6eoTpqnLDbNwDaI1E/r2Dd7J84/mlESF+c5+V9KTzP
         yOnED3vRFeikJ6GKgG+guyTa6INqx2CBBPtKI7uEl2cClMoW7qqaPh3vdjNNAs2PEP8/
         WuBg==
X-Gm-Message-State: AOAM530SEIL1gwkXTkAAiOn+tFvSdxoI1AEIE4daM2VGPfyboLRqjJOs
        Vn/hHZcMYtxXkq+amQxPu1kVtg==
X-Google-Smtp-Source: ABdhPJwVMC2jV/RcJgnKKvnmqAu/+6fc/ErIlkFTDy2DRiHDhLQKMYj8C8Fvlw3g0vYlro33ZEceNQ==
X-Received: by 2002:a63:e741:: with SMTP id j1mr17532251pgk.422.1600238755679;
        Tue, 15 Sep 2020 23:45:55 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id 143sm15783270pfc.66.2020.09.15.23.45.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 23:45:55 -0700 (PDT)
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
Subject: [PATCH V2 4/4] cpufreq: Move traces and update to policy->cur to cpufreq core
Date:   Wed, 16 Sep 2020 12:15:31 +0530
Message-Id: <875fc2c8d800f075c2faf925b04461b85362887a.1600238586.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1600238586.git.viresh.kumar@linaro.org>
References: <cover.1600238586.git.viresh.kumar@linaro.org>
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

