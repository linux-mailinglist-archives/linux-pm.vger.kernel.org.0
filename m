Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4321A5C2F
	for <lists+linux-pm@lfdr.de>; Sun, 12 Apr 2020 05:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgDLDb7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 Apr 2020 23:31:59 -0400
Received: from vultr.net.flygoat.com ([149.28.68.211]:55160 "EHLO
        vultr.net.flygoat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgDLDb7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 11 Apr 2020 23:31:59 -0400
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 620A320D2F;
        Sun, 12 Apr 2020 03:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1586662319; bh=GNiO8NpbsZIQ1ef9HBb53eMl+oqmvusfYXjRpJzyMrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TR4jBpFW/bSc8nY54KdLEzy08OdLxNizV+H1QqlnjFfDMncihdg5Cdiqgg92EjSNP
         g8iyKJgIA68vaWhPKljTMUPcgzg6eISoQx5m7sOwARSgCLlu7VqanhbGgXJcpFGrU/
         i/LFsYXncft53843fmBwGDl2v+ZcNgc8MN8OwdY3ra2iErr/UrV4kGcbmsYz+zBgvZ
         QXimsKQqofCNHaOh3cMYxVaxeOIF8yIu7qRPgu/94hWchJHGHaOQsGNYtkS40tv5lc
         S9Qu+pgnCJoM7opU0XJscSJlnknQeThG66epsaSnbtN4wz5D/Br6fRr03vfc6NNGFt
         6+YpLhViVBhBg==
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
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Zhou Yanjie <zhouyanjie@zoho.com>,
        =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>, YunQiang Su <syq@debian.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Enrico Weigelt <info@metux.net>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Richard Fontana <rfontana@redhat.com>,
        Steve Winslow <swinslow@gmail.com>,
        Peter Xu <peterx@redhat.com>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, oprofile-list@lists.sf.net,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 11/11] MIPS: Loongson64: Switch to new topology interface
Date:   Sun, 12 Apr 2020 11:20:41 +0800
Message-Id: <20200412032123.3896114-12-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200412032123.3896114-1-jiaxun.yang@flygoat.com>
References: <20200412032123.3896114-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use the new interface to setup topology information.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 .../include/asm/mach-loongson64/topology.h    |  2 ++
 arch/mips/loongson64/smp.c                    | 20 +++++++++----------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson64/topology.h b/arch/mips/include/asm/mach-loongson64/topology.h
index 3414a1fd1783..999464ed0c20 100644
--- a/arch/mips/include/asm/mach-loongson64/topology.h
+++ b/arch/mips/include/asm/mach-loongson64/topology.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_MACH_TOPOLOGY_H
 #define _ASM_MACH_TOPOLOGY_H
 
+#include <linux/numa.h>
+
 #ifdef CONFIG_NUMA
 
 #define cpu_to_node(cpu)	(cpu_logical_map(cpu) >> 2)
diff --git a/arch/mips/loongson64/smp.c b/arch/mips/loongson64/smp.c
index e1fe8bbb377d..bb37d0a7e79c 100644
--- a/arch/mips/loongson64/smp.c
+++ b/arch/mips/loongson64/smp.c
@@ -353,10 +353,10 @@ static void loongson3_init_secondary(void)
 		loongson3_ipi_write32(0xffffffff, ipi_en0_regs[cpu_logical_map(i)]);
 
 	per_cpu(cpu_state, cpu) = CPU_ONLINE;
-	cpu_set_core(&cpu_data[cpu],
+	cpu_set_core(cpu,
 		     cpu_logical_map(cpu) % loongson_sysconf.cores_per_package);
-	cpu_data[cpu].package =
-		cpu_logical_map(cpu) / loongson_sysconf.cores_per_package;
+	cpu_set_cluster(cpu,
+			cpu_logical_map(cpu) / loongson_sysconf.cores_per_package);
 
 	i = 0;
 	core0_c0count[cpu] = 0;
@@ -368,7 +368,7 @@ static void loongson3_init_secondary(void)
 
 	if (i > MAX_LOOPS)
 		i = MAX_LOOPS;
-	if (cpu_data[cpu].package)
+	if (cpu_cluster(cpu))
 		initcount = core0_c0count[cpu] + i;
 	else /* Local access is faster for loops */
 		initcount = core0_c0count[cpu] + i/2;
@@ -421,9 +421,9 @@ static void __init loongson3_smp_setup(void)
 	ipi_status0_regs_init();
 	ipi_en0_regs_init();
 	ipi_mailbox_buf_init();
-	cpu_set_core(&cpu_data[0],
+	cpu_set_core(0,
 		     cpu_logical_map(0) % loongson_sysconf.cores_per_package);
-	cpu_data[0].package = cpu_logical_map(0) / loongson_sysconf.cores_per_package;
+	cpu_set_cluster(0, cpu_logical_map(0) / loongson_sysconf.cores_per_package);
 }
 
 static void __init loongson3_prepare_cpus(unsigned int max_cpus)
@@ -752,8 +752,8 @@ void play_dead(void)
 
 static int loongson3_disable_clock(unsigned int cpu)
 {
-	uint64_t core_id = cpu_core(&cpu_data[cpu]);
-	uint64_t package_id = cpu_data[cpu].package;
+	uint64_t core_id = cpu_core(cpu);
+	uint64_t package_id = cpu_cluster(cpu);
 
 	if ((read_c0_prid() & PRID_REV_MASK) == PRID_REV_LOONGSON3A_R1) {
 		LOONGSON_CHIPCFG(package_id) &= ~(1 << (12 + core_id));
@@ -766,8 +766,8 @@ static int loongson3_disable_clock(unsigned int cpu)
 
 static int loongson3_enable_clock(unsigned int cpu)
 {
-	uint64_t core_id = cpu_core(&cpu_data[cpu]);
-	uint64_t package_id = cpu_data[cpu].package;
+	uint64_t core_id = cpu_core(cpu);
+	uint64_t package_id = cpu_cluster(cpu);
 
 	if ((read_c0_prid() & PRID_REV_MASK) == PRID_REV_LOONGSON3A_R1) {
 		LOONGSON_CHIPCFG(package_id) |= 1 << (12 + core_id);
-- 
2.26.0.rc2

