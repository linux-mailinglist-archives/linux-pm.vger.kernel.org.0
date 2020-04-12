Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB6F01A5C32
	for <lists+linux-pm@lfdr.de>; Sun, 12 Apr 2020 05:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgDLDcX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 Apr 2020 23:32:23 -0400
Received: from vultr.net.flygoat.com ([149.28.68.211]:55198 "EHLO
        vultr.net.flygoat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgDLDcW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 11 Apr 2020 23:32:22 -0400
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 7C0B620D14;
        Sun, 12 Apr 2020 03:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1586661923; bh=lW3H17njgy5+F3MBeH473cWUr39gwQNfiozOltaAlZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nq1yaboi2b8euWQTuffYuLwxu9gm+0wXpG8eAUt872HD3R/G1zamY0v3SrarEoeW+
         k0VHnJvkjtoHWMBTefrlzC4SRnwpI/Y0EcyNmhIaapMjN8HJt42EIJq4WmuF7naiY/
         s/UBP+yxWVlQSGsamLniRPwr0vnuNKXu1VThSOSx+7vTUXdaDX9vUKK61IYiqs6ow5
         n2dbaWXl9T0rWwnoT7vJTa2TIDkqQ5OG7Otu+ZUcB0myOGqO59py/0+nUZC8oTrsC2
         JtirU1WhtdHYUioNWoDSOHEKYz5Pv0NYrg6FIXK6NC5f4wpMTwCKN7OyFxEPm24GGe
         VCx84vG7PUong==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     dietmar.eggemann@arm.com, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robert Richter <rric@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Zhou Yanjie <zhouyanjie@zoho.com>,
        =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>, YunQiang Su <syq@debian.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Richard Fontana <rfontana@redhat.com>,
        Steve Winslow <swinslow@gmail.com>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        Peter Xu <peterx@redhat.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, oprofile-list@lists.sf.net,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 03/11] arch_topology: Make it avilable for MIPS
Date:   Sun, 12 Apr 2020 11:20:33 +0800
Message-Id: <20200412032123.3896114-4-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200412032123.3896114-1-jiaxun.yang@flygoat.com>
References: <20200412032123.3896114-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Simply drop unnecessary archtecture limitions and add dummy
function for platforms without OF support.
As some of the functions are conflicting with Arm's platform
implementations, we mark them as weak.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
--
v2: Use weak instead of ifdef to exclude functions for Arm.
---
 drivers/base/arch_topology.c | 116 ++++++++++++++++++-----------------
 1 file changed, 60 insertions(+), 56 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 4d0a0038b476..13dc4fbf043f 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -143,57 +143,6 @@ void topology_normalize_cpu_scale(void)
 	}
 }
 
-bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
-{
-	struct clk *cpu_clk;
-	static bool cap_parsing_failed;
-	int ret;
-	u32 cpu_capacity;
-
-	if (cap_parsing_failed)
-		return false;
-
-	ret = of_property_read_u32(cpu_node, "capacity-dmips-mhz",
-				   &cpu_capacity);
-	if (!ret) {
-		if (!raw_capacity) {
-			raw_capacity = kcalloc(num_possible_cpus(),
-					       sizeof(*raw_capacity),
-					       GFP_KERNEL);
-			if (!raw_capacity) {
-				cap_parsing_failed = true;
-				return false;
-			}
-		}
-		raw_capacity[cpu] = cpu_capacity;
-		pr_debug("cpu_capacity: %pOF cpu_capacity=%u (raw)\n",
-			cpu_node, raw_capacity[cpu]);
-
-		/*
-		 * Update freq_factor for calculating early boot cpu capacities.
-		 * For non-clk CPU DVFS mechanism, there's no way to get the
-		 * frequency value now, assuming they are running at the same
-		 * frequency (by keeping the initial freq_factor value).
-		 */
-		cpu_clk = of_clk_get(cpu_node, 0);
-		if (!PTR_ERR_OR_ZERO(cpu_clk)) {
-			per_cpu(freq_factor, cpu) =
-				clk_get_rate(cpu_clk) / 1000;
-			clk_put(cpu_clk);
-		}
-	} else {
-		if (raw_capacity) {
-			pr_err("cpu_capacity: missing %pOF raw capacity\n",
-				cpu_node);
-			pr_err("cpu_capacity: partial information: fallback to 1024 for all CPUs\n");
-		}
-		cap_parsing_failed = true;
-		free_raw_capacity();
-	}
-
-	return !ret;
-}
-
 #ifdef CONFIG_CPU_FREQ
 static cpumask_var_t cpus_to_visit;
 static void parsing_done_workfn(struct work_struct *work);
@@ -275,7 +224,58 @@ static void parsing_done_workfn(struct work_struct *work)
 core_initcall(free_raw_capacity);
 #endif
 
-#if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
+#if defined(CONFIG_OF)
+bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
+{
+	struct clk *cpu_clk;
+	static bool cap_parsing_failed;
+	int ret;
+	u32 cpu_capacity;
+
+	if (cap_parsing_failed)
+		return false;
+
+	ret = of_property_read_u32(cpu_node, "capacity-dmips-mhz",
+				   &cpu_capacity);
+	if (!ret) {
+		if (!raw_capacity) {
+			raw_capacity = kcalloc(num_possible_cpus(),
+					       sizeof(*raw_capacity),
+					       GFP_KERNEL);
+			if (!raw_capacity) {
+				cap_parsing_failed = true;
+				return false;
+			}
+		}
+		raw_capacity[cpu] = cpu_capacity;
+		pr_debug("cpu_capacity: %pOF cpu_capacity=%u (raw)\n",
+			cpu_node, raw_capacity[cpu]);
+
+		/*
+		 * Update freq_factor for calculating early boot cpu capacities.
+		 * For non-clk CPU DVFS mechanism, there's no way to get the
+		 * frequency value now, assuming they are running at the same
+		 * frequency (by keeping the initial freq_factor value).
+		 */
+		cpu_clk = of_clk_get(cpu_node, 0);
+		if (!PTR_ERR_OR_ZERO(cpu_clk)) {
+			per_cpu(freq_factor, cpu) =
+				clk_get_rate(cpu_clk) / 1000;
+			clk_put(cpu_clk);
+		}
+	} else {
+		if (raw_capacity) {
+			pr_err("cpu_capacity: missing %pOF raw capacity\n",
+				cpu_node);
+			pr_err("cpu_capacity: partial information: fallback to 1024 for all CPUs\n");
+		}
+		cap_parsing_failed = true;
+		free_raw_capacity();
+	}
+
+	return !ret;
+}
+
 /*
  * This function returns the logic cpu number of the node.
  * There are basically three kinds of return values:
@@ -461,7 +461,12 @@ static int __init parse_dt_topology(void)
 	of_node_put(cn);
 	return ret;
 }
-#endif
+#else
+static int __init parse_dt_topology(void)
+{
+	return 0;
+}
+#endif /* CONFIG_OF */
 
 /*
  * cpu topology table
@@ -562,8 +567,8 @@ __weak int __init parse_acpi_topology(void)
 	return 0;
 }
 
-#if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
-void __init init_cpu_topology(void)
+
+__weak void __init init_cpu_topology(void)
 {
 	reset_cpu_topology();
 
@@ -576,4 +581,3 @@ void __init init_cpu_topology(void)
 	else if (of_have_populated_dt() && parse_dt_topology())
 		reset_cpu_topology();
 }
-#endif
-- 
2.26.0.rc2

