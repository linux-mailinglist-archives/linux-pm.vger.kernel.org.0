Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE3D27D957
	for <lists+linux-pm@lfdr.de>; Tue, 29 Sep 2020 22:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbgI2Uz1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Sep 2020 16:55:27 -0400
Received: from foss.arm.com ([217.140.110.172]:51334 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729293AbgI2Uz1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 29 Sep 2020 16:55:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8AC612FC;
        Tue, 29 Sep 2020 13:55:26 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E2F313F85F;
        Tue, 29 Sep 2020 13:55:24 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org
Cc:     dietmar.eggemann@arm.com, qperret@google.com,
        valentin.schneider@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com
Subject: [PATCH v2 3/3] sched/topology: condition EAS enablement on FIE support
Date:   Tue, 29 Sep 2020 21:54:42 +0100
Message-Id: <20200929205442.24792-4-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929205442.24792-1-ionela.voinescu@arm.com>
References: <20200929205442.24792-1-ionela.voinescu@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to make accurate predictions across CPUs and for all performance
states, Energy Aware Scheduling (EAS) needs frequency-invariant load
tracking signals.

EAS task placement aims to minimize energy consumption, and does so in
part by limiting the search space to only CPUs with the highest spare
capacity (CPU capacity - CPU utilization) in their performance domain.
Those candidates are the placement choices that will keep frequency at
its lowest possible and therefore save the most energy.

But without frequency invariance, a CPU's utilization is relative to the
CPU's current performance level, and not relative to its maximum
performance level, which determines its capacity. As a result, it will
fail to correctly indicate any potential spare capacity obtained by an
increase in a CPU's performance level. Therefore, a non-invariant
utilization signal would render the EAS task placement logic invalid.

Now that we properly report support for the Frequency Invariance Engine
(FIE) through arch_scale_freq_invariant() for arm and arm64 systems,
while also ensuring a re-evaluation of the EAS use conditions for
possible invariance status change, we can assert this is the case when
initializing EAS. Warn and bail out otherwise.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Suggested-by: Quentin Perret <qperret@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/topology.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index e0a8e55e7df0..cbe88b896f93 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -328,6 +328,7 @@ static void sched_energy_set(bool has_eas)
  *    3. no SMT is detected.
  *    4. the EM complexity is low enough to keep scheduling overheads low;
  *    5. schedutil is driving the frequency of all CPUs of the rd;
+ *    6. frequency invariance support is present;
  *
  * The complexity of the Energy Model is defined as:
  *
@@ -376,6 +377,14 @@ static bool build_perf_domains(const struct cpumask *cpu_map)
 		goto free;
 	}
 
+	if (!arch_scale_freq_invariant()) {
+		if (sched_debug()) {
+			pr_warn("rd %*pbl: Disabling EAS: frequency-invariant load tracking not yet supported",
+				cpumask_pr_args(cpu_map));
+		}
+		goto free;
+	}
+
 	for_each_cpu(i, cpu_map) {
 		/* Skip already covered CPUs. */
 		if (find_pd(pd, i))
-- 
2.17.1

