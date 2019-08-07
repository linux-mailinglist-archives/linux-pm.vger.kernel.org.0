Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD5C084FF6
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2019 17:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388590AbfHGPeF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Aug 2019 11:34:05 -0400
Received: from foss.arm.com ([217.140.110.172]:50374 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387543AbfHGPeE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Aug 2019 11:34:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E333344;
        Wed,  7 Aug 2019 08:34:04 -0700 (PDT)
Received: from e107049-lin.arm.com (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 56C783F706;
        Wed,  7 Aug 2019 08:34:03 -0700 (PDT)
From:   Douglas RAILLARD <douglas.raillard@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org
Subject: [PATCH] sched/cpufreq: Align trace event behavior of fast switching
Date:   Wed,  7 Aug 2019 16:33:40 +0100
Message-Id: <20190807153340.11516-1-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fast switching path only emits an event for the CPU of interest, whereas the
regular path emits an event for all the CPUs that had their frequency changed,
i.e. all the CPUs sharing the same policy.

With the current behavior, looking at cpu_frequency event for a given CPU that
is using the fast switching path will not give the correct frequency signal.

Signed-off-by: Douglas RAILLARD <douglas.raillard@arm.com>
---
 kernel/sched/cpufreq_schedutil.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 1f82ab108bab..975ccc3de807 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -153,6 +153,7 @@ static void sugov_fast_switch(struct sugov_policy *sg_policy, u64 time,
 			      unsigned int next_freq)
 {
 	struct cpufreq_policy *policy = sg_policy->policy;
+	int cpu;
 
 	if (!sugov_update_next_freq(sg_policy, time, next_freq))
 		return;
@@ -162,7 +163,11 @@ static void sugov_fast_switch(struct sugov_policy *sg_policy, u64 time,
 		return;
 
 	policy->cur = next_freq;
-	trace_cpu_frequency(next_freq, smp_processor_id());
+
+	if (trace_cpu_frequency_enabled()) {
+		for_each_cpu(cpu, policy->cpus)
+			trace_cpu_frequency(next_freq, cpu);
+	}
 }
 
 static void sugov_deferred_update(struct sugov_policy *sg_policy, u64 time,
-- 
2.22.0

