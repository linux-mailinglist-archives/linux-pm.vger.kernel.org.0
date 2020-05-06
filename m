Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1971C7856
	for <lists+linux-pm@lfdr.de>; Wed,  6 May 2020 19:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbgEFRo1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 May 2020 13:44:27 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:32814 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730263AbgEFRoW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 May 2020 13:44:22 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 948DE8000B81;
        Wed,  6 May 2020 17:44:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yB4vVyCw6pxE; Wed,  6 May 2020 20:44:19 +0300 (MSK)
From:   <Sergey.Semin@baikalelectronics.ru>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 14/20] mips: Use offset-sized IO-mem accessors in CPS debug printout
Date:   Wed, 6 May 2020 20:42:32 +0300
Message-ID: <20200506174238.15385-15-Sergey.Semin@baikalelectronics.ru>
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

Similar to commit 8e5c62e38a88 ("mips: early_printk_8250: Use offset-sized
IO-mem accessors") the IO-memory might require to use a proper load/store
instructions (like Bailal-T1 IO-memory). To fix the cps-vec UART debug
printout lets use the memory access instructions in accordance with the
UART registers offset config specified at boot time.

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
There might be another problem in cps-vec-ns16550.S connected with the
difference in CPU/devices endinanness on some platforms. But there is
no such for Baikal-T1 SoC.
---
 arch/mips/kernel/cps-vec-ns16550.S | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/cps-vec-ns16550.S b/arch/mips/kernel/cps-vec-ns16550.S
index d5a67b4ce9f6..2adb1c56c7c5 100644
--- a/arch/mips/kernel/cps-vec-ns16550.S
+++ b/arch/mips/kernel/cps-vec-ns16550.S
@@ -14,16 +14,30 @@
 #define UART_TX_OFS	(UART_TX << CONFIG_MIPS_CPS_NS16550_SHIFT)
 #define UART_LSR_OFS	(UART_LSR << CONFIG_MIPS_CPS_NS16550_SHIFT)
 
+#if CONFIG_MIPS_CPS_NS16550_SHIFT == 0
+# define UART_L		lb
+# define UART_S		sb
+#elif CONFIG_MIPS_CPS_NS16550_SHIFT == 1
+# define UART_L		lh
+# define UART_S		sh
+#elif CONFIG_MIPS_CPS_NS16550_SHIFT == 2
+# define UART_L		lw
+# define UART_S		sw
+#else
+# define UART_L		lw
+# define UART_S		sb
+#endif
+
 /**
  * _mips_cps_putc() - write a character to the UART
  * @a0: ASCII character to write
  * @t9: UART base address
  */
 LEAF(_mips_cps_putc)
-1:	lw		t0, UART_LSR_OFS(t9)
+1:	UART_L		t0, UART_LSR_OFS(t9)
 	andi		t0, t0, UART_LSR_TEMT
 	beqz		t0, 1b
-	sb		a0, UART_TX_OFS(t9)
+	UART_S		a0, UART_TX_OFS(t9)
 	jr		ra
 	END(_mips_cps_putc)
 
-- 
2.25.1

