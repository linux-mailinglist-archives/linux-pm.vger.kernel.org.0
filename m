Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA40F3BD796
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jul 2021 15:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbhGFNVa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Jul 2021 09:21:30 -0400
Received: from foss.arm.com ([217.140.110.172]:42148 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231464AbhGFNVZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Jul 2021 09:21:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 175861FB;
        Tue,  6 Jul 2021 06:18:47 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.7.228])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DE3603F73B;
        Tue,  6 Jul 2021 06:18:44 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        Chris.Redpath@arm.com, Beata.Michalska@arm.com,
        viresh.kumar@linaro.org, rjw@rjwysocki.net, amit.kachhap@gmail.com
Subject: [RFC PATCH v2 3/6] cpufreq: Add Active Stats calls tracking frequency changes
Date:   Tue,  6 Jul 2021 14:18:25 +0100
Message-Id: <20210706131828.22309-4-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210706131828.22309-1-lukasz.luba@arm.com>
References: <20210706131828.22309-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Active Stats framework tracks and accounts the activity of the CPU
for each performance level. It accounts the real residency, when the CPU
was not idle, at a given performance level. This patch adds needed calls
which provide the CPU frequency transition events to the Active Stats
framework.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/cpufreq/cpufreq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 802abc925b2a..d79cb9310572 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -14,6 +14,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/active_stats.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/cpu_cooling.h>
@@ -387,6 +388,8 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
 
 		cpufreq_stats_record_transition(policy, freqs->new);
 		policy->cur = freqs->new;
+
+		active_stats_cpu_freq_change(policy->cpu, freqs->new);
 	}
 }
 
@@ -2085,6 +2088,8 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
 			    policy->cpuinfo.max_freq);
 	cpufreq_stats_record_transition(policy, freq);
 
+	active_stats_cpu_freq_fast_change(policy->cpu, freq);
+
 	if (trace_cpu_frequency_enabled()) {
 		for_each_cpu(cpu, policy->cpus)
 			trace_cpu_frequency(freq, cpu);
-- 
2.17.1

