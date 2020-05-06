Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8869D1C7843
	for <lists+linux-pm@lfdr.de>; Wed,  6 May 2020 19:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbgEFRn7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 May 2020 13:43:59 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:60814 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbgEFRn7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 May 2020 13:43:59 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id B2315803078D;
        Wed,  6 May 2020 17:43:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id p502n0RRUOrS; Wed,  6 May 2020 20:43:53 +0300 (MSK)
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
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Alexander Lobakin <alobakin@dlink.ru>,
        Huacai Chen <chenhc@lemote.com>,
        Cedric Hombourger <Cedric_Hombourger@mentor.com>,
        =?UTF-8?q?Ren=C3=A9=20van=20Dorst?= <opensource@vdorst.com>,
        Ard Biesheuvel <ardb@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 07/20] mips: Add MIPS Warrior P5600 support
Date:   Wed, 6 May 2020 20:42:25 +0300
Message-ID: <20200506174238.15385-8-Sergey.Semin@baikalelectronics.ru>
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

This is a MIPS32 Release 5 based IP core with XPA, EVA, dual/quad issue
exec pipes, MMU with two-levels TLB, UCA, MSA, MDU core level features
and system level features like up to six P5600 calculation cores, CM2
with L2 cache, IOCU/IOMMU (though might be unused depending on the
system-specific IP core configuration), GIC, CPC, virtualisation module,
eJTAG and PDtrace.

As being MIPS32 Release 5 based core it provides all the features
available by the CPU_MIPS32_R5 config, while adding a few more like
UCA attribute support, availability of CPU-freq (by means of L2/CM
clock ratio setting), EI/VI GIC modes detection at runtime.

In addition to this if P5600 architecture is enabled modern GNU GCC
provides a specific tuning for P5600 processors with respect to the
classic MIPS32 Release 5. First of all branch-likely avoidance is
activated only when the code is compiled with the speed optimization
(avoidance is always enabled for the pure MIPS32 Release 5
architecture). Secondly the madd/msub avoidance is enabled since
madd/msub utilization isn't profitable due to overhead of getting the
result out of the HI/LO registers. Multiply-accumulate instructions are
activated and utilized together with the necessary code reorder when
multiply-add/multiply-subtract statements are met. Finally load/store
bonding is activated by default. All of these optimizations may make
the code relatively faster than if just MIP32 release 5 architecture
was requested.

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
 arch/mips/Kconfig                | 38 +++++++++++++++++++++++++++-----
 arch/mips/Makefile               |  1 +
 arch/mips/include/asm/vermagic.h |  2 ++
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 55c3dbfea336..e3b780a389a9 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1665,6 +1665,28 @@ config CPU_MIPS64_R6
 	  family, are based on a MIPS64r6 processor. If you own an older
 	  processor, you probably need to select MIPS64r1 or MIPS64r2 instead.
 
+config CPU_P5600
+	bool "MIPS Warrior P5600"
+	depends on SYS_HAS_CPU_P5600
+	select CPU_HAS_PREFETCH
+	select CPU_SUPPORTS_32BIT_KERNEL
+	select CPU_SUPPORTS_HIGHMEM
+	select CPU_SUPPORTS_MSA
+	select CPU_SUPPORTS_UNCACHED_ACCELERATED
+	select CPU_SUPPORTS_CPUFREQ
+	select CPU_MIPSR2_IRQ_VI
+	select CPU_MIPSR2_IRQ_EI
+	select HAVE_KVM
+	select MIPS_O32_FP64_SUPPORT
+	help
+	  Choose this option to build a kernel for MIPS Warrior P5600 CPU.
+	  It's based on MIPS32r5 ISA with XPA, EVA, dual/quad issue exec pipes,
+	  MMU with two-levels TLB, UCA, MSA, MDU core level features and system
+	  level features like up to six P5600 calculation cores, CM2 with L2
+	  cache, IOCU/IOMMU (though might be unused depending on the system-
+	  specific IP core configuration), GIC, CPC, virtualisation module,
+	  eJTAG and PDtrace.
+
 config CPU_R3000
 	bool "R3000"
 	depends on SYS_HAS_CPU_R3000
@@ -1841,7 +1863,8 @@ endchoice
 config CPU_MIPS32_3_5_FEATURES
 	bool "MIPS32 Release 3.5 Features"
 	depends on SYS_HAS_CPU_MIPS32_R3_5
-	depends on CPU_MIPS32_R2 || CPU_MIPS32_R5 || CPU_MIPS32_R6
+	depends on CPU_MIPS32_R2 || CPU_MIPS32_R5 || CPU_MIPS32_R6 || \
+		   CPU_P5600
 	help
 	  Choose this option to build a kernel for release 2 or later of the
 	  MIPS32 architecture including features from the 3.5 release such as
@@ -1861,7 +1884,7 @@ config CPU_MIPS32_3_5_EVA
 config CPU_MIPS32_R5_FEATURES
 	bool "MIPS32 Release 5 Features"
 	depends on SYS_HAS_CPU_MIPS32_R5
-	depends on CPU_MIPS32_R2 || CPU_MIPS32_R5
+	depends on CPU_MIPS32_R2 || CPU_MIPS32_R5 || CPU_P5600
 	help
 	  Choose this option to build a kernel for release 2 or later of the
 	  MIPS32 architecture including features from release 5 such as
@@ -2016,6 +2039,10 @@ config SYS_HAS_CPU_MIPS64_R6
 	bool
 	select ARCH_HAS_SYNC_DMA_FOR_CPU if DMA_NONCOHERENT
 
+config SYS_HAS_CPU_P5600
+	bool
+	select ARCH_HAS_SYNC_DMA_FOR_CPU if DMA_NONCOHERENT
+
 config SYS_HAS_CPU_R3000
 	bool
 
@@ -2100,7 +2127,7 @@ endmenu
 config CPU_MIPS32
 	bool
 	default y if CPU_MIPS32_R1 || CPU_MIPS32_R2 || CPU_MIPS32_R5 || \
-		     CPU_MIPS32_R6
+		     CPU_MIPS32_R6 || CPU_P5600
 
 config CPU_MIPS64
 	bool
@@ -2122,7 +2149,7 @@ config CPU_MIPSR2
 
 config CPU_MIPSR5
 	bool
-	default y if CPU_MIPS32_R5
+	default y if CPU_MIPS32_R5 || CPU_P5600
 	select CPU_HAS_RIXI
 	select CPU_HAS_DIEI if !CPU_DIEI_BROKEN
 	select MIPS_SPRAM
@@ -2733,7 +2760,8 @@ config RELOCATABLE
 	bool "Relocatable kernel"
 	depends on SYS_SUPPORTS_RELOCATABLE
 	depends on CPU_MIPS32_R2 || CPU_MIPS64_R2 || CPU_MIPS32_R5 || \
-		   CPU_MIPS32_R6 || CPU_MIPS64_R6 || CAVIUM_OCTEON_SOC
+		   CPU_MIPS32_R6 || CPU_MIPS64_R6 || CPU_P5600 || \
+		   CAVIUM_OCTEON_SOC
 	help
 	  This builds a kernel image that retains relocation information
 	  so it can be loaded someplace besides the default 1MB.
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 9172fb0f630b..264dead560f4 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -176,6 +176,7 @@ cflags-$(CONFIG_CPU_MIPS32_R6)	+= -march=mips32r6 -Wa,--trap -modd-spreg
 cflags-$(CONFIG_CPU_MIPS64_R1)	+= -march=mips64 -Wa,--trap
 cflags-$(CONFIG_CPU_MIPS64_R2)	+= -march=mips64r2 -Wa,--trap
 cflags-$(CONFIG_CPU_MIPS64_R6)	+= -march=mips64r6 -Wa,--trap
+cflags-$(CONFIG_CPU_P5600)	+= -march=p5600 -Wa,--trap -modd-spreg
 cflags-$(CONFIG_CPU_R5000)	+= -march=r5000 -Wa,--trap
 cflags-$(CONFIG_CPU_R5500)	+= $(call cc-option,-march=r5500,-march=r5000) \
 			-Wa,--trap
diff --git a/arch/mips/include/asm/vermagic.h b/arch/mips/include/asm/vermagic.h
index 5a0e739f597a..d03f97350f91 100644
--- a/arch/mips/include/asm/vermagic.h
+++ b/arch/mips/include/asm/vermagic.h
@@ -48,6 +48,8 @@
 #define MODULE_PROC_FAMILY "LOONGSON64 "
 #elif defined CONFIG_CPU_CAVIUM_OCTEON
 #define MODULE_PROC_FAMILY "OCTEON "
+#elif defined CONFIG_CPU_P5600
+#define MODULE_PROC_FAMILY "P5600 "
 #elif defined CONFIG_CPU_XLR
 #define MODULE_PROC_FAMILY "XLR "
 #elif defined CONFIG_CPU_XLP
-- 
2.25.1

