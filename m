Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894723BD794
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jul 2021 15:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbhGFNVX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Jul 2021 09:21:23 -0400
Received: from foss.arm.com ([217.140.110.172]:42132 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231794AbhGFNVX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Jul 2021 09:21:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 943D71042;
        Tue,  6 Jul 2021 06:18:44 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.7.228])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 670D03F73B;
        Tue,  6 Jul 2021 06:18:42 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        Chris.Redpath@arm.com, Beata.Michalska@arm.com,
        viresh.kumar@linaro.org, rjw@rjwysocki.net, amit.kachhap@gmail.com
Subject: [RFC PATCH v2 2/6] cpuidle: Add Active Stats calls tracking idle entry/exit
Date:   Tue,  6 Jul 2021 14:18:24 +0100
Message-Id: <20210706131828.22309-3-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210706131828.22309-1-lukasz.luba@arm.com>
References: <20210706131828.22309-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Active Stats framework tracks and accounts the activity of the CPU
for each performance level. It accounts the real residency, when the CPU
was not idle, at a given performance level. This patch adds needed calls
which provide the CPU idle entry/exit events to the Active Stats
framework.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/cpuidle/cpuidle.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index ef2ea1b12cd8..24a33c6c4a62 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -8,6 +8,7 @@
  * This code is licenced under the GPL.
  */
 
+#include <linux/active_stats.h>
 #include <linux/clockchips.h>
 #include <linux/kernel.h>
 #include <linux/mutex.h>
@@ -231,6 +232,8 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	trace_cpu_idle(index, dev->cpu);
 	time_start = ns_to_ktime(local_clock());
 
+	active_stats_cpu_idle_enter(time_start);
+
 	stop_critical_timings();
 	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
 		rcu_idle_enter();
@@ -243,6 +246,8 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	time_end = ns_to_ktime(local_clock());
 	trace_cpu_idle(PWR_EVENT_EXIT, dev->cpu);
 
+	active_stats_cpu_idle_exit(time_end);
+
 	/* The cpu is no longer idle or about to enter idle. */
 	sched_idle_set_state(NULL);
 
-- 
2.17.1

