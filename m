Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE23F1F8614
	for <lists+linux-pm@lfdr.de>; Sun, 14 Jun 2020 03:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgFNBKY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Jun 2020 21:10:24 -0400
Received: from foss.arm.com ([217.140.110.172]:53270 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbgFNBKY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 13 Jun 2020 21:10:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70A9CC0A;
        Sat, 13 Jun 2020 18:10:23 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8AB853F73C;
        Sat, 13 Jun 2020 18:10:21 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [PATCH 1/3] thermal/cpu-cooling, sched/core: Cleanup thermal pressure definition
Date:   Sun, 14 Jun 2020 02:07:53 +0100
Message-Id: <20200614010755.9129-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200614010755.9129-1-valentin.schneider@arm.com>
References: <20200614010755.9129-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit:

  14533a16c46d ("thermal/cpu-cooling, sched/core: Move the arch_set_thermal_pressure() API to generic scheduler code")

moved the definition of arch_set_thermal_pressure() to sched/core.c, but
kept its declaration in linux/arch_topology.h. When building e.g. an x86
kernel with CONFIG_SCHED_THERMAL_PRESSURE=y, cpufreq_cooling.c ends up
getting the declaration of arch_set_thermal_pressure() from
include/linux/arch_topology.h, which is somewhat awkward.

On top of this, the public setter, arch_set_thermal_pressure(), is defined
unconditionally in sched/core.c while the public getter,
arch_scale_thermal_pressure(), is hardcoded to return 0 unless it has been
redefined by the architecture. arch_*() functions are meant to be defined
by architectures, so revert the aforementioned commit and re-implement it
in a way that keeps arch_set_thermal_pressure() architecture-definable.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 drivers/base/arch_topology.c      | 11 +++++++++++
 drivers/thermal/cpufreq_cooling.c |  5 +++++
 include/linux/arch_topology.h     |  3 ---
 kernel/sched/core.c               | 11 -----------
 4 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 4d0a0038b476..d14cab7dfa3c 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -54,6 +54,17 @@ void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
 	per_cpu(cpu_scale, cpu) = capacity;
 }
 
+DEFINE_PER_CPU(unsigned long, thermal_pressure);
+
+void arch_set_thermal_pressure(const struct cpumask *cpus,
+			       unsigned long th_pressure)
+{
+	int cpu;
+
+	for_each_cpu(cpu, cpus)
+		WRITE_ONCE(per_cpu(thermal_pressure, cpu), th_pressure);
+}
+
 static ssize_t cpu_capacity_show(struct device *dev,
 				 struct device_attribute *attr,
 				 char *buf)
diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index e297e135c031..a1efd379b683 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -417,6 +417,11 @@ static int cpufreq_get_cur_state(struct thermal_cooling_device *cdev,
 	return 0;
 }
 
+__weak void
+arch_set_thermal_pressure(const struct cpumask *cpus, unsigned long th_pressure)
+{
+}
+
 /**
  * cpufreq_set_cur_state - callback function to set the current cooling state.
  * @cdev: thermal cooling device pointer.
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 0566cb3314ef..81bd1c627195 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -39,9 +39,6 @@ static inline unsigned long topology_get_thermal_pressure(int cpu)
 	return per_cpu(thermal_pressure, cpu);
 }
 
-void arch_set_thermal_pressure(struct cpumask *cpus,
-			       unsigned long th_pressure);
-
 struct cpu_topology {
 	int thread_id;
 	int core_id;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 43ba2d4a8eca..7861d21f3c2b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3628,17 +3628,6 @@ unsigned long long task_sched_runtime(struct task_struct *p)
 	return ns;
 }
 
-DEFINE_PER_CPU(unsigned long, thermal_pressure);
-
-void arch_set_thermal_pressure(struct cpumask *cpus,
-			       unsigned long th_pressure)
-{
-	int cpu;
-
-	for_each_cpu(cpu, cpus)
-		WRITE_ONCE(per_cpu(thermal_pressure, cpu), th_pressure);
-}
-
 /*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
-- 
2.27.0

