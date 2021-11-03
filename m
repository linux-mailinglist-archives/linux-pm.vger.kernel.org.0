Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D25444587
	for <lists+linux-pm@lfdr.de>; Wed,  3 Nov 2021 17:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbhKCQNk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Nov 2021 12:13:40 -0400
Received: from foss.arm.com ([217.140.110.172]:33072 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232788AbhKCQNi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Nov 2021 12:13:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E516ED1;
        Wed,  3 Nov 2021 09:11:01 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.26.226])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 219DB3F7D7;
        Wed,  3 Nov 2021 09:10:56 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, lukasz.luba@arm.com,
        sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
        linux@armlinux.org.uk, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, amitk@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        thara.gopinath@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org
Subject: [PATCH v3 5/5] arch_topology: Remove unused topology_set_thermal_pressure() and related
Date:   Wed,  3 Nov 2021 16:10:20 +0000
Message-Id: <20211103161020.26714-6-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211103161020.26714-1-lukasz.luba@arm.com>
References: <20211103161020.26714-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no need of this function (and related) since code has been
converted to use the new arch_thermal_pressure_update() API. The old
code can be removed.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 arch/arm/include/asm/topology.h   |  1 -
 arch/arm64/include/asm/topology.h |  1 -
 drivers/base/arch_topology.c      | 17 +++++------------
 include/linux/arch_topology.h     |  3 ---
 include/linux/sched/topology.h    |  7 -------
 init/Kconfig                      |  2 +-
 6 files changed, 6 insertions(+), 25 deletions(-)

diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
index f1eafacc9a30..c7d2510e5a78 100644
--- a/arch/arm/include/asm/topology.h
+++ b/arch/arm/include/asm/topology.h
@@ -23,7 +23,6 @@
 
 /* Replace task scheduler's default thermal pressure API */
 #define arch_scale_thermal_pressure topology_get_thermal_pressure
-#define arch_set_thermal_pressure   topology_set_thermal_pressure
 #define arch_update_thermal_pressure	topology_update_thermal_pressure
 
 #else
diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index 7a421cbc99ed..f386b90a79c8 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -32,7 +32,6 @@ void update_freq_counters_refs(void);
 
 /* Replace task scheduler's default thermal pressure API */
 #define arch_scale_thermal_pressure topology_get_thermal_pressure
-#define arch_set_thermal_pressure   topology_set_thermal_pressure
 #define arch_update_thermal_pressure	topology_update_thermal_pressure
 
 #include <asm-generic/topology.h>
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index d66aa46b7e1a..db18d79065fe 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -159,16 +159,6 @@ void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
 
 DEFINE_PER_CPU(unsigned long, thermal_pressure);
 
-void topology_set_thermal_pressure(const struct cpumask *cpus,
-			       unsigned long th_pressure)
-{
-	int cpu;
-
-	for_each_cpu(cpu, cpus)
-		WRITE_ONCE(per_cpu(thermal_pressure, cpu), th_pressure);
-}
-EXPORT_SYMBOL_GPL(topology_set_thermal_pressure);
-
 /**
  * topology_update_thermal_pressure() - Update thermal pressure for CPUs
  * @cpus        : The related CPUs for which capacity has been reduced
@@ -184,7 +174,7 @@ EXPORT_SYMBOL_GPL(topology_set_thermal_pressure);
 void topology_update_thermal_pressure(const struct cpumask *cpus,
 				      unsigned long capped_freq)
 {
-	unsigned long max_capacity, capacity;
+	unsigned long max_capacity, capacity, th_pressure;
 	u32 max_freq;
 	int cpu;
 
@@ -200,7 +190,10 @@ void topology_update_thermal_pressure(const struct cpumask *cpus,
 
 	capacity = mult_frac(capped_freq, max_capacity, max_freq);
 
-	arch_set_thermal_pressure(cpus, max_capacity - capacity);
+	th_pressure = max_capacity - capacity;
+
+	for_each_cpu(cpu, cpus)
+		WRITE_ONCE(per_cpu(thermal_pressure, cpu), th_pressure);
 }
 EXPORT_SYMBOL_GPL(topology_update_thermal_pressure);
 
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index ace1e5dcf773..cce6136b300a 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -56,9 +56,6 @@ static inline unsigned long topology_get_thermal_pressure(int cpu)
 	return per_cpu(thermal_pressure, cpu);
 }
 
-void topology_set_thermal_pressure(const struct cpumask *cpus,
-				   unsigned long th_pressure);
-
 void topology_update_thermal_pressure(const struct cpumask *cpus,
 				      unsigned long capped_freq);
 
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 6e89a8e43aa7..8054641c0a7b 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -266,13 +266,6 @@ unsigned long arch_scale_thermal_pressure(int cpu)
 }
 #endif
 
-#ifndef arch_set_thermal_pressure
-static __always_inline
-void arch_set_thermal_pressure(const struct cpumask *cpus,
-			       unsigned long th_pressure)
-{ }
-#endif
-
 #ifndef arch_update_thermal_pressure
 static __always_inline
 void arch_update_thermal_pressure(const struct cpumask *cpus,
diff --git a/init/Kconfig b/init/Kconfig
index 11f8a845f259..b5d6eeb86275 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -550,7 +550,7 @@ config SCHED_THERMAL_PRESSURE
 	  i.e. put less load on throttled CPUs than on non/less throttled ones.
 
 	  This requires the architecture to implement
-	  arch_set_thermal_pressure() and arch_scale_thermal_pressure().
+	  arch_update_thermal_pressure() and arch_scale_thermal_pressure().
 
 config BSD_PROCESS_ACCT
 	bool "BSD Process Accounting"
-- 
2.17.1

