Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3C344B39C
	for <lists+linux-pm@lfdr.de>; Tue,  9 Nov 2021 20:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244072AbhKIUAq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Nov 2021 15:00:46 -0500
Received: from foss.arm.com ([217.140.110.172]:38004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244049AbhKIUAn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Nov 2021 15:00:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 280B32B;
        Tue,  9 Nov 2021 11:57:57 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.26.224])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D3DDD3F7F5;
        Tue,  9 Nov 2021 11:57:52 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, steev@kali.org, lukasz.luba@arm.com,
        sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
        linux@armlinux.org.uk, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, amitk@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        thara.gopinath@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org
Subject: [PATCH v4 5/5] arch_topology: Remove unused topology_set_thermal_pressure() and related
Date:   Tue,  9 Nov 2021 19:57:14 +0000
Message-Id: <20211109195714.7750-6-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211109195714.7750-1-lukasz.luba@arm.com>
References: <20211109195714.7750-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no need of this function (and related) since code has been
converted to use the new arch_update_thermal_pressure() API. The old
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
index bed7d502c9a1..c5d866c5c344 100644
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
@@ -186,7 +176,7 @@ EXPORT_SYMBOL_GPL(topology_set_thermal_pressure);
 void topology_update_thermal_pressure(const struct cpumask *cpus,
 				      unsigned long capped_freq)
 {
-	unsigned long max_capacity, capacity;
+	unsigned long max_capacity, capacity, th_pressure;
 	u32 max_freq;
 	int cpu;
 
@@ -206,7 +196,10 @@ void topology_update_thermal_pressure(const struct cpumask *cpus,
 	else
 		capacity = mult_frac(max_capacity, capped_freq, max_freq);
 
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

