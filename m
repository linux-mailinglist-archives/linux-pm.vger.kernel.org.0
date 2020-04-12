Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C801E1A5C33
	for <lists+linux-pm@lfdr.de>; Sun, 12 Apr 2020 05:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgDLDcX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 Apr 2020 23:32:23 -0400
Received: from vultr.net.flygoat.com ([149.28.68.211]:55206 "EHLO
        vultr.net.flygoat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgDLDcW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 11 Apr 2020 23:32:22 -0400
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 0DA9720D0B;
        Sun, 12 Apr 2020 03:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1586661874; bh=oPTnJfivkM+8UlbJ6/9gGwXtkpRxLwi4xWE4eb0+CaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xdkAAkVhE9cLmt4b8+PYZ1ceY8j4cfNtQsYRsYkA3LvMmiJ3R6r25w7aD/QGgISKZ
         I359nv7efhU2PI4KSVasEJ3dlYoYnMIipUwgLqmtXSooV2Gx/2n6J8zZbdhUh2E9eR
         M7Yad4QLQbyjs2ZVh3QUJs6tatPMqCzxN1QRWDpTKj63tM5EkheRe4Xen1pIT/Gt+I
         eKKZ/8eAAfqKopirzq3cc3dzFL3uwX+0IlxNtyAta/z9Y+Y3RvcUaIHQXX+cili6fg
         PCXwe49oAs+nYA+EukxPtqkc1hdEv5BoIhFmRTU3C0mDE9eTKLvx3Q6VyAHr6PVR7o
         ZNXGTUaVyXG2Q==
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
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Richard Fontana <rfontana@redhat.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Zhou Yanjie <zhouyanjie@zoho.com>,
        =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>, YunQiang Su <syq@debian.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Steve Winslow <swinslow@gmail.com>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        Peter Xu <peterx@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, oprofile-list@lists.sf.net,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 02/11] MIPS: prom: Add helper to parse CPU node in dt
Date:   Sun, 12 Apr 2020 11:20:32 +0800
Message-Id: <20200412032123.3896114-3-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200412032123.3896114-1-jiaxun.yang@flygoat.com>
References: <20200412032123.3896114-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Mostly identical with arm one. The only difference is that we allow
to mark a CPU Node as status = "disabled" in dt, which means the core
is physicaly present, but not possible for the kernel. It will occupy
a bit in cpumask as well.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

--
v2: Exclude non-SMP config.
---
 arch/mips/include/asm/prom.h |  6 +++
 arch/mips/kernel/prom.c      | 97 ++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)

diff --git a/arch/mips/include/asm/prom.h b/arch/mips/include/asm/prom.h
index c42e07671934..84802c70e426 100644
--- a/arch/mips/include/asm/prom.h
+++ b/arch/mips/include/asm/prom.h
@@ -24,6 +24,12 @@ extern int __dt_register_buses(const char *bus0, const char *bus1);
 static inline void device_tree_init(void) { }
 #endif /* CONFIG_OF */
 
+#if defined(CONFIG_OF) && defined(CONFIG_SMP)
+extern void mips_dt_init_cpu_maps(void);
+#else
+static inline void mips_dt_init_cpu_maps(void) { }
+#endif
+
 extern char *mips_get_machine_name(void);
 extern void mips_set_machine_name(const char *name);
 
diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
index 9e50dc8df2f6..deb5cc0a0eb5 100644
--- a/arch/mips/kernel/prom.c
+++ b/arch/mips/kernel/prom.c
@@ -89,4 +89,101 @@ int __init __dt_register_buses(const char *bus0, const char *bus1)
 	return 0;
 }
 
+#ifdef CONFIG_SMP
+void __init mips_dt_init_cpu_maps(void)
+{
+	struct device_node *cpu, *cpus;
+	u32 i, j, cpuidx = 1;
+	u32 cpunum;
+	u32 tmp_map[NR_CPUS] = { [0 ... NR_CPUS-1] = U32_MAX };
+	bool cpu_possible[NR_CPUS] = { [0 ... NR_CPUS-1] = false };
+	bool bootcpu_valid = false;
+
+	cpus = of_find_node_by_path("/cpus");
+	if (!cpus)
+		return;
+
+	if (cpu_has_mips_r2_r6)
+		cpunum = get_ebase_cpunum();
+	else
+		cpunum = 0; /* For legacy system we assume boot from CPU 0 */
+
+	for_each_of_cpu_node(cpu) {
+		u32 hwid;
+
+		pr_debug(" * %pOF...\n", cpu);
+		/*
+		 * A device tree containing CPU nodes with missing "reg"
+		 * properties is considered invalid to build the
+		 * cpu_logical_map.
+		 */
+
+		if (of_property_read_u32(cpu, "reg", &hwid)) {
+			pr_debug(" * %pOF missing reg property\n", cpu);
+			of_node_put(cpu);
+			return;
+		}
+
+		/*
+		 * Duplicate hwid are a recipe for disaster.
+		 * Scan all initialized entries and check for
+		 * duplicates. If any is found just bail out.
+		 */
+		for (j = 0; j < cpuidx; j++)
+			if (WARN(tmp_map[j] == hwid,
+				 "Duplicate /cpu reg properties in the DT\n")) {
+				of_node_put(cpu);
+				return;
+			}
+
+		/*
+		 * Build a stashed array of hwid values. Numbering scheme
+		 * requires that if detected the boot CPU must be assigned
+		 * logical id 0. Other CPUs get sequential indexes starting
+		 * from 1. If a CPU node with a reg property matching the
+		 * boot CPU hwid is detected, this is recorded so that the
+		 * logical map built from DT is validated.
+		 */
+		if (hwid == cpunum) {
+			i = 0;
+			if (of_device_is_available(cpu))
+				bootcpu_valid = true;
+		} else {
+			i = cpuidx++;
+		}
+
+		if (WARN(cpuidx > nr_cpu_ids, "DT /cpu %u nodes greater than "
+						   "max cores %u, capping them\n",
+						   cpuidx, nr_cpu_ids)) {
+			cpuidx = nr_cpu_ids;
+			of_node_put(cpu);
+			break;
+		}
+
+		tmp_map[i] = hwid;
+
+		if (of_device_is_available(cpu))
+			cpu_possible[i] = true;
+	}
+
+	if (!bootcpu_valid) {
+		pr_warn("DT missing boot CPU, fall back to default cpu_logical_map\n");
+		return;
+	}
+
+	init_cpu_possible(cpu_none_mask);
+	init_cpu_present(cpu_none_mask);
+
+	for (i = 0; i < cpuidx; i++) {
+		set_cpu_possible(i, cpu_possible[i]);
+		cpu_logical_map(i) = tmp_map[i];
+		pr_debug("cpu logical map 0x%x\n", cpu_logical_map(i));
+	}
+}
+
+bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
+{
+	return phys_id == cpu_logical_map(cpu);
+}
+#endif /* CONFIG_SMP */
 #endif
-- 
2.26.0.rc2

