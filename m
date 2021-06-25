Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF253B4694
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jun 2021 17:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhFYP3L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Jun 2021 11:29:11 -0400
Received: from foss.arm.com ([217.140.110.172]:58684 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhFYP3K (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 25 Jun 2021 11:29:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF19413A1;
        Fri, 25 Jun 2021 08:26:49 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.7.232])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 83E683F694;
        Fri, 25 Jun 2021 08:26:46 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris.Redpath@arm.com, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com, linux-pm@vger.kernel.org, peterz@infradead.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, mingo@redhat.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, segall@google.com,
        mgorman@suse.de, bristot@redhat.com, CCj.Yeh@mediatek.com
Subject: [PATCH 3/3] PM: EM: Increase energy calculation precision
Date:   Fri, 25 Jun 2021 16:26:03 +0100
Message-Id: <20210625152603.25960-4-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210625152603.25960-1-lukasz.luba@arm.com>
References: <20210625152603.25960-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Energy Model (EM) provides useful information about device power in
each performance state to other subsystems like: Energy Aware Scheduler
(EAS). The energy calculation in EAS does arithmetic operation based on
the EM em_cpu_energy(). Current implementation of that function uses
em_perf_state::cost as a pre-computed cost coefficient equal to:
cost = power * max_frequency / frequency.
The 'power' is expressed in milli-Watts (or in abstract scale).

There are corner cases then the EAS energy calculation for two Performance
Domains (PDs) return the same value, e.g. 10mW. The EAS compares these
values to choose smaller one. It might happen that this values are equal
due to rounding error. In such scenario, we need better precision, e.g.
10000 times better. To provide this possibility increase the precision on
the em_perf_state::cost.

This patch allows to avoid the rounding to milli-Watt errors, which might
occur in EAS energy estimation for each Performance Domains (PD). The
rounding error is common for small tasks which have small utilization
values.

The rest of the EM code doesn't change, em_perf_state::power is still
expressed in milli-Watts (or in abstract scale). Thus, all existing
platforms don't have to change their reported power. The same applies to
EM clients, like thermal or DTPM (they use em_perf_state::power).

Reported-by: CCJ Yeh <CCj.Yeh@mediatek.com>
Suggested-by: CCJ Yeh <CCj.Yeh@mediatek.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h | 5 ++++-
 kernel/power/energy_model.c  | 3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 2016f5a706e0..91037dd57e61 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -16,7 +16,10 @@
  * @power:	The power consumed at this level (by 1 CPU or by a registered
  *		device). It can be a total power: static and dynamic.
  * @cost:	The cost coefficient associated with this level, used during
- *		energy calculation. Equal to: power * max_frequency / frequency
+ *		energy calculation. Equal to:
+		power * 10000 * max_frequency / frequency
+ *		To increase the energy estimation presision use different
+ *		scale in this coefficient than in @power field.
  */
 struct em_perf_state {
 	unsigned long frequency;
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 0f4530b3a8cd..2724f0ac417d 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -170,7 +170,8 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 	/* Compute the cost of each performance state. */
 	fmax = (u64) table[nr_states - 1].frequency;
 	for (i = 0; i < nr_states; i++) {
-		table[i].cost = div64_u64(fmax * table[i].power,
+		u64 power_res = (u64)table[i].power * 10000;
+		table[i].cost = div64_u64(fmax * power_res,
 					  table[i].frequency);
 	}
 
-- 
2.17.1

