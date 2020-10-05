Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797D2283134
	for <lists+linux-pm@lfdr.de>; Mon,  5 Oct 2020 09:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgJEH4t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Oct 2020 03:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgJEH4t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2020 03:56:49 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A9CC0613A6
        for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2020 00:56:48 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t14so5477506pgl.10
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2020 00:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V24nFqUoLW4E3Th0MpyhsidyzVGENaV4KzeBs2bcktI=;
        b=IJH3N+4VTgKq/7yzzSibeAML3izyYdLrGuWTH3WTmV9f4KVaPgK8ma8n0pyl32oisR
         LMGx6FLS0wyiX4qm6cTxKwT1cEmZ6cyrhq2RrzcEfeg6ylmpwHzID2PoVLqdoMYO2OPW
         twbGV0dEeluBWu14lxxj9WinZIhNq6UsYMtnjb3+H7hAV5f+Xi/bkdqIgawWvQIhYERz
         sYTz1v8O1C1CbfV1FpUHhV1EzKttxLFjbybYVklM+p2jC8SxsrYSpI7X1ckPlnEaxxxi
         VbO2ogMSk//2i8lbwjBh4DQ+O9AQ0KcvXUy7I2RPyUDipux0iz0UX+PicwXWzxaYdyhu
         BK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V24nFqUoLW4E3Th0MpyhsidyzVGENaV4KzeBs2bcktI=;
        b=gMX1l9pKomL0cSHWG9m07o69iqoHd/gww/CQMKykNPGTYTQcKMP6/nmV8ey8r4oLrp
         1cfZlCQIVoIqxo8nnLWBJGPaZKT71tReDfLZn4nCw5dJerWUb1RihcSKs3nG1MRT5+iE
         aadxjM0wTorduXMI+hdLSravAezFPTMu/jTllmNRxXwz11TF/6CHiJHV+zqwC+nhKJrH
         qwrPdT4Zl8Od6CzrukxOCsUXk6v+Fy9yR5NiJhwtdB/PRDGI743uThFrx4hdxY8Ex7b2
         OOtRcERi42HzymVxTHb3TRx+hcPDvR7Q9DhktTcHvtY+nYoWDpmPs7bgLq8ivtUXlsT+
         tkRg==
X-Gm-Message-State: AOAM53005YwBWruVGF3oBqFR1ZQDSYLJxfDw76B6GB8qpvBDeBF+Jmos
        FRzr6szpMOaLWcwHHktbG293lQ==
X-Google-Smtp-Source: ABdhPJzEDI0+5SGijxUigKS4MKnFVsdoYLdCe5Hmr2YYhueCd/nXgFjF0qwlFmKyHaC0U8qepooiWQ==
X-Received: by 2002:a65:60d0:: with SMTP id r16mr13871777pgv.348.1601884607804;
        Mon, 05 Oct 2020 00:56:47 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id z20sm9480873pjq.1.2020.10.05.00.56.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2020 00:56:47 -0700 (PDT)
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
Subject: [PATCH V3 5/5] cpufreq: Move traces and update to policy->cur to cpufreq core
Date:   Mon,  5 Oct 2020 13:26:05 +0530
Message-Id: <b4d80430c640fceaf871d90a1ec39277a4de34e8.1601884370.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1601884370.git.viresh.kumar@linaro.org>
References: <cover.1601884370.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cpufreq core handles the updates to policy->cur and recording of
cpufreq trace events for all the governors except schedutil's fast
switch case.

Move that as well to cpufreq core for consistency and readability.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c        |  7 +++++++
 kernel/sched/cpufreq_schedutil.c | 12 +-----------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 2d0e2e464b14..db00693a586a 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2068,6 +2068,7 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
 					unsigned int target_freq)
 {
 	unsigned int freq;
+	int cpu;
 
 	target_freq = clamp_val(target_freq, policy->min, policy->max);
 	freq = cpufreq_driver->fast_switch(policy, target_freq);
@@ -2075,10 +2076,16 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
 	if (!freq)
 		return 0;
 
+	policy->cur = freq;
 	arch_set_freq_scale(policy->related_cpus, freq,
 			    policy->cpuinfo.max_freq);
 	cpufreq_stats_record_transition(policy, freq);
 
+	if (trace_cpu_frequency_enabled()) {
+		for_each_cpu(cpu, policy->cpus)
+			trace_cpu_frequency(freq, cpu);
+	}
+
 	return freq;
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
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

