Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829393A2EF3
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jun 2021 17:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhFJPFh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Jun 2021 11:05:37 -0400
Received: from foss.arm.com ([217.140.110.172]:33974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230410AbhFJPFg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Jun 2021 11:05:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4077C1396;
        Thu, 10 Jun 2021 08:03:40 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.4.220])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 87FBB3F719;
        Thu, 10 Jun 2021 08:03:36 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, vincent.guittot@linaro.org,
        qperret@google.com, dietmar.eggemann@arm.com,
        vincent.donnefort@arm.com, lukasz.luba@arm.com,
        Beata.Michalska@arm.com, mingo@redhat.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, segall@google.com, mgorman@suse.de,
        bristot@redhat.com, thara.gopinath@linaro.org,
        amit.kachhap@gmail.com, amitk@kernel.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org
Subject: [PATCH v3 1/3] thermal: cpufreq_cooling: Update also offline CPUs per-cpu thermal_pressure
Date:   Thu, 10 Jun 2021 16:03:22 +0100
Message-Id: <20210610150324.22919-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210610150324.22919-1-lukasz.luba@arm.com>
References: <20210610150324.22919-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal pressure signal gives information to the scheduler about
reduced CPU capacity due to thermal. It is based on a value stored in a
per-cpu 'thermal_pressure' variable. The online CPUs will get the new
value there, while the offline won't. Unfortunately, when the CPU is back
online, the value read from per-cpu variable might be wrong (stale data).
This might affect the scheduler decisions, since it sees the CPU capacity
differently than what is actually available.

Fix it by making sure that all online+offline CPUs would get the proper
value in their per-cpu variable when thermal framework sets capping.

Fixes: f12e4f66ab6a3 ("thermal/cpu-cooling: Update thermal pressure in case of a maximum frequency capping")
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/cpufreq_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index eeb4e4b76c0b..43b1ae8a7789 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -478,7 +478,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 	ret = freq_qos_update_request(&cpufreq_cdev->qos_req, frequency);
 	if (ret >= 0) {
 		cpufreq_cdev->cpufreq_state = state;
-		cpus = cpufreq_cdev->policy->cpus;
+		cpus = cpufreq_cdev->policy->related_cpus;
 		max_capacity = arch_scale_cpu_capacity(cpumask_first(cpus));
 		capacity = frequency * max_capacity;
 		capacity /= cpufreq_cdev->policy->cpuinfo.max_freq;
-- 
2.17.1

