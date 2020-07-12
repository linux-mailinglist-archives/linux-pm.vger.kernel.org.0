Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05CF21CA84
	for <lists+linux-pm@lfdr.de>; Sun, 12 Jul 2020 18:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbgGLQ7f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Jul 2020 12:59:35 -0400
Received: from foss.arm.com ([217.140.110.172]:47902 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728859AbgGLQ7e (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 12 Jul 2020 12:59:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A92E331B;
        Sun, 12 Jul 2020 09:59:33 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C7B683F7D8;
        Sun, 12 Jul 2020 09:59:31 -0700 (PDT)
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
Subject: [PATCH v2 1/3] arch_topology, sched/core: Cleanup thermal pressure definition
Date:   Sun, 12 Jul 2020 17:59:15 +0100
Message-Id: <20200712165917.9168-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200712165917.9168-1-valentin.schneider@arm.com>
References: <20200712165917.9168-1-valentin.schneider@arm.com>
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

On top of this, sched/core.c unconditionally defines
o The thermal_pressure percpu variable
o arch_set_thermal_pressure()

while arch_scale_thermal_pressure() does nothing unless redefined by the
architecture.

arch_*() functions are meant to be defined by architectures, so revert the
aforementioned commit and re-implement it in a way that keeps
arch_set_thermal_pressure() architecture-definable, and doesn't define the
thermal pressure percpu variable for kernels that don't need
it (CONFIG_SCHED_THERMAL_PRESSURE=n).

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 arch/arm/include/asm/topology.h   |  3 ++-
 arch/arm64/include/asm/topology.h |  3 ++-
 drivers/base/arch_topology.c      | 11 +++++++++++
 include/linux/arch_topology.h     |  4 ++--
 include/linux/sched/topology.h    |  7 +++++++
 kernel/sched/core.c               | 11 -----------
 6 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
index 435aba289fc5..e0593cf095d0 100644
--- a/arch/arm/include/asm/topology.h
+++ b/arch/arm/include/asm/topology.h
@@ -16,8 +16,9 @@
 /* Enable topology flag updates */
 #define arch_update_cpu_topology topology_update_cpu_topology
 
-/* Replace task scheduler's default thermal pressure retrieve API */
+/* Replace task scheduler's default thermal pressure API */
 #define arch_scale_thermal_pressure topology_get_thermal_pressure
+#define arch_set_thermal_pressure   topology_set_thermal_pressure
 
 #else
 
diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index 0cc835ddfcd1..e042f6527981 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -34,8 +34,9 @@ void topology_scale_freq_tick(void);
 /* Enable topology flag updates */
 #define arch_update_cpu_topology topology_update_cpu_topology
 
-/* Replace task scheduler's default thermal pressure retrieve API */
+/* Replace task scheduler's default thermal pressure API */
 #define arch_scale_thermal_pressure topology_get_thermal_pressure
+#define arch_set_thermal_pressure   topology_set_thermal_pressure
 
 #include <asm-generic/topology.h>
 
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
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 0566cb3314ef..69b1dabe39dc 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -39,8 +39,8 @@ static inline unsigned long topology_get_thermal_pressure(int cpu)
 	return per_cpu(thermal_pressure, cpu);
 }
 
-void arch_set_thermal_pressure(struct cpumask *cpus,
-			       unsigned long th_pressure);
+void topology_set_thermal_pressure(const struct cpumask *cpus,
+				   unsigned long th_pressure);
 
 struct cpu_topology {
 	int thread_id;
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index fb11091129b3..764222d637b7 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -232,6 +232,13 @@ unsigned long arch_scale_thermal_pressure(int cpu)
 }
 #endif
 
+#ifndef arch_set_thermal_pressure
+static __always_inline
+void arch_set_thermal_pressure(const struct cpumask *cpus,
+			       unsigned long th_pressure)
+{ }
+#endif
+
 static inline int task_node(const struct task_struct *p)
 {
 	return cpu_to_node(task_cpu(p));
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ff0519551188..90b44f3840e4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3731,17 +3731,6 @@ unsigned long long task_sched_runtime(struct task_struct *p)
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

