Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D9C1C784A
	for <lists+linux-pm@lfdr.de>; Wed,  6 May 2020 19:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgEFRoK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 May 2020 13:44:10 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:60878 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730124AbgEFRoI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 May 2020 13:44:08 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 2CAAB8000803;
        Wed,  6 May 2020 17:44:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BPzMSrzlQXfu; Wed,  6 May 2020 20:44:03 +0300 (MSK)
From:   <Sergey.Semin@baikalelectronics.ru>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Huacai Chen <chenhc@lemote.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Zhou Yanjie <zhouyanjie@zoho.com>,
        =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>, Thomas Gleixner <tglx@linutronix.de>,
        <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 09/20] mips: Add CP0 Write Merge config support
Date:   Wed, 6 May 2020 20:42:27 +0300
Message-ID: <20200506174238.15385-10-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200506174238.15385-1-Sergey.Semin@baikalelectronics.ru>
References: <20200306124807.3596F80307C2@mail.baikalelectronics.ru>
 <20200506174238.15385-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

CP0 config register may indicate whether write-through merging
is allowed. Currently there are two types of the merging available:
SysAD Valid and Full modes. Whether each of them are supported by
the core is implementation dependent. Moreover whether the ability
to change the mode also depends on the chip family instance. Taking
into account all of this we created a dedicated mm_config() method
to detect and enable merging if it's supported. It is called for
MIPS-type processors at CPU-probe stage and attempts to detect whether
the write merging is available. If it's known to be supported and
switchable, then switch on the full mode. Otherwise just perform the
CP0.Config.MM field analysis.

In addition there are platforms like InterAptiv/ProAptiv, which do have
the MM bit field set by default, but having write-through cacheing
unsupported makes write-merging also unsupported. In this case we just
ignore the MM field value.

Co-developed-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org
---
 arch/mips/include/asm/cpu-features.h |  8 +++++
 arch/mips/include/asm/cpu.h          |  4 ++-
 arch/mips/include/asm/mipsregs.h     |  3 ++
 arch/mips/kernel/cpu-probe.c         | 48 ++++++++++++++++++++++++++++
 4 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 7e22b9c1e279..2b818f2036d0 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -630,6 +630,14 @@
 # endif
 #endif
 
+#ifndef cpu_has_mm_sysad
+# define cpu_has_mm_sysad	__opt(MIPS_CPU_MM_SYSAD)
+#endif
+
+#ifndef cpu_has_mm_full
+# define cpu_has_mm_full	__opt(MIPS_CPU_MM_FULL)
+#endif
+
 /*
  * Guest capabilities
  */
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 9bae99b568c9..191529ef0d05 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -417,7 +417,9 @@ enum cpu_type_enum {
 #define MIPS_CPU_MT_PER_TC_PERF_COUNTERS \
 				BIT_ULL(56)	/* CPU has perf counters implemented per TC (MIPSMT ASE) */
 #define MIPS_CPU_MMID		BIT_ULL(57)	/* CPU supports MemoryMapIDs */
-#define MIPS_CPU_MAC_2008_ONLY	BIT_ULL(58)	/* CPU Only support MAC2008 Fused multiply-add instruction */
+#define MIPS_CPU_MM_SYSAD	BIT_ULL(58)	/* CPU supports write-through SysAD Valid merge */
+#define MIPS_CPU_MM_FULL	BIT_ULL(59)	/* CPU supports write-through full merge */
+#define MIPS_CPU_MAC_2008_ONLY	BIT_ULL(60)	/* CPU Only support MAC2008 Fused multiply-add instruction */
 
 /*
  * CPU ASE encodings
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 796fe47cfd17..b1c761279b13 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -563,6 +563,9 @@
 #define MIPS_CONF_MT_FTLB	(_ULCAST_(4) <<  7)
 #define MIPS_CONF_AR		(_ULCAST_(7) << 10)
 #define MIPS_CONF_AT		(_ULCAST_(3) << 13)
+#define MIPS_CONF_MM		(_ULCAST_(3) << 17)
+#define MIPS_CONF_MM_SYSAD	(_ULCAST_(1) << 17)
+#define MIPS_CONF_MM_FULL	(_ULCAST_(2) << 17)
 #define MIPS_CONF_M		(_ULCAST_(1) << 31)
 
 /*
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index a2dafef2df45..ad298d34304f 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -667,6 +667,52 @@ static int set_ftlb_enable(struct cpuinfo_mips *c, enum ftlb_flags flags)
 	return 0;
 }
 
+static int mm_config(struct cpuinfo_mips *c)
+{
+	unsigned int config0, update, mm;
+
+	config0 = read_c0_config();
+	mm = config0 & MIPS_CONF_MM;
+
+	/*
+	 * It's implementation dependent what type of write-merge is supported
+	 * and whether it can be enabled/disabled. If it is settable lets make
+	 * the merging allowed by default. Some platforms might have
+	 * write-through caching unsupported. In this case just ignore the
+	 * CP0.Config.MM bit field value.
+	 */
+	switch (c->cputype) {
+	case CPU_24K:
+	case CPU_34K:
+	case CPU_74K:
+	case CPU_P5600:
+	case CPU_P6600:
+		c->options |= MIPS_CPU_MM_FULL;
+		update = MIPS_CONF_MM_FULL;
+		break;
+	case CPU_1004K:
+	case CPU_1074K:
+	case CPU_INTERAPTIV:
+	case CPU_PROAPTIV:
+		mm = 0;
+		/* fall through */
+	default:
+		update = 0;
+		break;
+	}
+
+	if (update) {
+		config0 = (config0 & ~MIPS_CONF_MM) | update;
+		write_c0_config(config0);
+	} else if (mm == MIPS_CONF_MM_SYSAD) {
+		c->options |= MIPS_CPU_MM_SYSAD;
+	} else if (mm == MIPS_CONF_MM_FULL) {
+		c->options |= MIPS_CPU_MM_FULL;
+	}
+
+	return 0;
+}
+
 static inline unsigned int decode_config0(struct cpuinfo_mips *c)
 {
 	unsigned int config0;
@@ -1758,6 +1804,8 @@ static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
 
 	spram_config();
 
+	mm_config(c);
+
 	switch (__get_cpu_type(c->cputype)) {
 	case CPU_M5150:
 	case CPU_P5600:
-- 
2.25.1

