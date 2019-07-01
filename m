Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 979775BA9D
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2019 13:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbfGAL0n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jul 2019 07:26:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40761 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbfGAL0m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jul 2019 07:26:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so6430863pfp.7
        for <linux-pm@vger.kernel.org>; Mon, 01 Jul 2019 04:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YRWeVW4p/qldJNkKTR6o7SUC4e45+GXMXjYNi3OfnwU=;
        b=Hsn6sfygmZ5FO1B898kaMm55vMC5QRAPoqINN4vDEHrpzmav792D9MAFcMOYEKcCr8
         61KKGQKwR1ypYa7srp2wsbEczuZfcgfnHEVD89JRlYVgQas+FjTHxjiEq67EivMqk7fl
         QBAY1fQXmeh8b3gvlvkMhxb0GBX66dybYq89L3TcvqbKh2kKaW+dvywqhHqOT9PAXXD/
         w4LqJx8OUtGo74kV+AcqQX5SB7epcnE3iTdl/QwXmygYcxB3EBecDrDQZChvNTCWuAuo
         thgEWb4W6j7cy8RKNXMeOev/iJlRmStmJXI0GNrBVtP08XfEh60aGU1P6Nlr7H+jj8v4
         fJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YRWeVW4p/qldJNkKTR6o7SUC4e45+GXMXjYNi3OfnwU=;
        b=F9v+nBdI6e/WCGkGpOGmJ8QxRomLsRLZuHoSZiJiRHThgQ/E7cpFa/0c/Rtz44eG7o
         jTksq2rmiqi9R5N4lu0kOTthrR57g90yhTpkWQNZzl19D4kQmEK1HECHN8IVslPPcaa3
         PuJrJ1wexENTBFiIcRGEaysGvW1apPZCEgljVnRa74WsK9YnnkyPj6mrKmfwT6nEehbz
         zlozj3Xf1IK3Rhjw7LjLPkH23yWTTvBSQrGNdKp4t9fkEkhjQNjHRrHnj3oKe2LzRB9M
         5so/tJERK51hyK0FhHuEHLACASvn6cbVNEvYRvvFcR1H0FISpAMoJFm2HzwoNivqJXhK
         hf6A==
X-Gm-Message-State: APjAAAXJwFg0Axj2K7TwE7CgV+XMUrRbCG2yQCmJxn+G1OgcpeDBf6kN
        qzfnbk3NIfX7BmF7CUJbrC7k6A==
X-Google-Smtp-Source: APXvYqw68+fIxGAIKOjW7PhnUTlJERGR0BoRWVYEtHgEdcL9oo8xCFHPmdimixkyUEDrUuXdEfH54w==
X-Received: by 2002:a63:c24d:: with SMTP id l13mr15194332pgg.330.1561980401775;
        Mon, 01 Jul 2019 04:26:41 -0700 (PDT)
Received: from localhost ([122.172.21.205])
        by smtp.gmail.com with ESMTPSA id h14sm11138160pfq.22.2019.07.01.04.26.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 04:26:41 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, mka@chromium.org, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 6/7] cpufreq: intel_pstate: Reuse refresh_frequency_limits()
Date:   Mon,  1 Jul 2019 16:56:14 +0530
Message-Id: <76b40f45a13ea8c27afdf218f38f0c54a1100300.1561979715.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1561979715.git.viresh.kumar@linaro.org>
References: <cover.1561979715.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The implementation of intel_pstate_update_max_freq() is quite similar to
refresh_frequency_limits(), lets reuse it.

Finding minimum of policy->user_policy.max and policy->cpuinfo.max_freq
in intel_pstate_update_max_freq() is redundant as cpufreq_set_policy()
will call the ->verify() callback of intel-pstate driver, which will do
this comparison anyway and so dropping it from
intel_pstate_update_max_freq() doesn't harm.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c      | 3 ++-
 drivers/cpufreq/intel_pstate.c | 7 +------
 include/linux/cpufreq.h        | 1 +
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 81117e4d43cc..091789e868ee 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1116,7 +1116,7 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy, unsigned int cp
 	return ret;
 }
 
-static void refresh_frequency_limits(struct cpufreq_policy *policy)
+void refresh_frequency_limits(struct cpufreq_policy *policy)
 {
 	struct cpufreq_policy new_policy;
 
@@ -1133,6 +1133,7 @@ static void refresh_frequency_limits(struct cpufreq_policy *policy)
 
 	up_write(&policy->rwsem);
 }
+EXPORT_SYMBOL(refresh_frequency_limits);
 
 static void handle_update(struct work_struct *work)
 {
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index f2ff5de988c1..cc27d4c59dca 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -898,7 +898,6 @@ static void intel_pstate_update_policies(void)
 static void intel_pstate_update_max_freq(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpu);
-	struct cpufreq_policy new_policy;
 	struct cpudata *cpudata;
 
 	if (!policy)
@@ -908,11 +907,7 @@ static void intel_pstate_update_max_freq(unsigned int cpu)
 	policy->cpuinfo.max_freq = global.turbo_disabled_mf ?
 			cpudata->pstate.max_freq : cpudata->pstate.turbo_freq;
 
-	memcpy(&new_policy, policy, sizeof(*policy));
-	new_policy.max = min(policy->user_policy.max, policy->cpuinfo.max_freq);
-	new_policy.min = min(policy->user_policy.min, new_policy.max);
-
-	cpufreq_set_policy(policy, &new_policy);
+	refresh_frequency_limits(policy);
 
 	cpufreq_cpu_release(policy);
 }
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 95425941f46d..1fa37b675a80 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -207,6 +207,7 @@ void cpufreq_cpu_release(struct cpufreq_policy *policy);
 int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu);
 int cpufreq_set_policy(struct cpufreq_policy *policy,
 		       struct cpufreq_policy *new_policy);
+void refresh_frequency_limits(struct cpufreq_policy *policy);
 void cpufreq_update_policy(unsigned int cpu);
 void cpufreq_update_limits(unsigned int cpu);
 bool have_governor_per_policy(void);
-- 
2.21.0.rc0.269.g1a574e7a288b

