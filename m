Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCDC21C784D
	for <lists+linux-pm@lfdr.de>; Wed,  6 May 2020 19:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbgEFRoO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 May 2020 13:44:14 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:60928 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730153AbgEFRoL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 May 2020 13:44:11 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 4909E8000AFD;
        Wed,  6 May 2020 17:44:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9711_w53AziR; Wed,  6 May 2020 20:44:06 +0300 (MSK)
From:   <Sergey.Semin@baikalelectronics.ru>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Zhou Yanjie <zhouyanjie@zoho.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 10/20] mips: Add CONFIG/CONFIG6/Cause reg fields macro
Date:   Wed, 6 May 2020 20:42:28 +0300
Message-ID: <20200506174238.15385-11-Sergey.Semin@baikalelectronics.ru>
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

There are bit fields which persist in the MIPS CONFIG and CONFIG6
registers, but haven't been described in the generic mipsregs.h
header so far. In particular, the generic CONFIG bitfields are
BE - endian mode, BM - burst mode, SB - SimpleBE, OCP interface mode
indicator, UDI - user-defined "CorExtend" instructions, DSP - data
scratch pad RAM present, ISP - instruction scratch pad RAM present,
etc. The core-specific CONFIG6 bitfields are JRCD - jump register
cache prediction disable, R6 - MIPSr6 extensions enable, IFUPerfCtl -
IFU performance control, SPCD - sleep state performance counter, DLSB -
disable load/store bonding. A new exception code reported in the
ExcCode field of the Cause register: 30 - Parity/ECC error exception
happened on either fetch, load or cache refill. Lets add them to the
mipsregs.h header to be used in future platform code, which have them
utilized.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org
---
 arch/mips/include/asm/mipsregs.h | 19 +++++++++++++++++++
 arch/mips/kernel/spram.c         |  4 ++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index b1c761279b13..039ebd913f00 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -468,6 +468,7 @@
 #define EXCCODE_THREAD		25	/* Thread exceptions (MT) */
 #define EXCCODE_DSPDIS		26	/* DSP disabled exception */
 #define EXCCODE_GE		27	/* Virtualized guest exception (VZ) */
+#define EXCCODE_CACHEERR	30	/* Parity/ECC occured on a core */
 
 /* Implementation specific trap codes used by MIPS cores */
 #define MIPS_EXCCODE_TLBPAR	16	/* TLB parity error exception */
@@ -563,9 +564,17 @@
 #define MIPS_CONF_MT_FTLB	(_ULCAST_(4) <<  7)
 #define MIPS_CONF_AR		(_ULCAST_(7) << 10)
 #define MIPS_CONF_AT		(_ULCAST_(3) << 13)
+#define MIPS_CONF_BE		(_ULCAST_(1) << 15)
+#define MIPS_CONF_BM		(_ULCAST_(1) << 16)
 #define MIPS_CONF_MM		(_ULCAST_(3) << 17)
 #define MIPS_CONF_MM_SYSAD	(_ULCAST_(1) << 17)
 #define MIPS_CONF_MM_FULL	(_ULCAST_(2) << 17)
+#define MIPS_CONF_SB		(_ULCAST_(1) << 21)
+#define MIPS_CONF_UDI		(_ULCAST_(1) << 22)
+#define MIPS_CONF_DSP		(_ULCAST_(1) << 23)
+#define MIPS_CONF_ISP		(_ULCAST_(1) << 24)
+#define MIPS_CONF_KU		(_ULCAST_(3) << 25)
+#define MIPS_CONF_K23		(_ULCAST_(3) << 28)
 #define MIPS_CONF_M		(_ULCAST_(1) << 31)
 
 /*
@@ -677,9 +686,19 @@
 #define MIPS_CONF5_CV		(_ULCAST_(1) << 29)
 #define MIPS_CONF5_K		(_ULCAST_(1) << 30)
 
+/* Jump register cache prediction disable */
+#define MIPS_CONF6_JRCD		(_ULCAST_(1) << 0)
+/* MIPSr6 extensions enable */
+#define MIPS_CONF6_R6		(_ULCAST_(1) << 2)
+/* IFU Performance Control */
+#define MIPS_CONF6_IFUPERFCTL	(_ULCAST_(3) << 10)
 #define MIPS_CONF6_SYND		(_ULCAST_(1) << 13)
+/* Sleep state performance counter disable */
+#define MIPS_CONF6_SPCD		(_ULCAST_(1) << 14)
 /* proAptiv FTLB on/off bit */
 #define MIPS_CONF6_FTLBEN	(_ULCAST_(1) << 15)
+/* Disable load/store bonding */
+#define MIPS_CONF6_DLSB		(_ULCAST_(1) << 21)
 /* Loongson-3 FTLB on/off bit */
 #define MIPS_CONF6_FTLBDIS	(_ULCAST_(1) << 22)
 /* FTLB probability bits */
diff --git a/arch/mips/kernel/spram.c b/arch/mips/kernel/spram.c
index 26d355462ace..d5d96214cce5 100644
--- a/arch/mips/kernel/spram.c
+++ b/arch/mips/kernel/spram.c
@@ -209,11 +209,11 @@ void spram_config(void)
 	case CPU_P6600:
 		config0 = read_c0_config();
 		/* FIXME: addresses are Malta specific */
-		if (config0 & (1<<24)) {
+		if (config0 & MIPS_CONF_ISP) {
 			probe_spram("ISPRAM", 0x1c000000,
 				    &ispram_load_tag, &ispram_store_tag);
 		}
-		if (config0 & (1<<23))
+		if (config0 & MIPS_CONF_DSP)
 			probe_spram("DSPRAM", 0x1c100000,
 				    &dspram_load_tag, &dspram_store_tag);
 	}
-- 
2.25.1

