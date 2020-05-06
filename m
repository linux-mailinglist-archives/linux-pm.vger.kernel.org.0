Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C451C785F
	for <lists+linux-pm@lfdr.de>; Wed,  6 May 2020 19:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbgEFRo1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 May 2020 13:44:27 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:32790 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729460AbgEFRoV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 May 2020 13:44:21 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 42D008000B82;
        Wed,  6 May 2020 17:44:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3dSIDd2UUX5J; Wed,  6 May 2020 20:44:17 +0300 (MSK)
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
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steve Winslow <swinslow@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 13/20] mips: early_printk_8250: Use offset-sized IO-mem accessors
Date:   Wed, 6 May 2020 20:42:31 +0300
Message-ID: <20200506174238.15385-14-Sergey.Semin@baikalelectronics.ru>
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

Some platforms may prohibit to access the IO-memory with instructions
of certain memory widths. For instance Bailal-T1 has devices placed
behind memory OCP port (which also the reason of DMA accesses being
incoherent) and can't be accessed through CCA uncacheable memory with
other than 4-bytes aligned (LW/SW) instructions. Ignoring this rule
will cause the APB EHB error with 0xFFs returned on read operations.
In order to fix the issue for this platform and for others, which may
have similar problems, lets recode serial_in()/serial_out() to call
a certain memory accessors in accordance with the UART registers shift
setting.

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
 arch/mips/kernel/early_printk_8250.c | 34 ++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/early_printk_8250.c b/arch/mips/kernel/early_printk_8250.c
index 567c6ec0cfae..e2c2405cff62 100644
--- a/arch/mips/kernel/early_printk_8250.c
+++ b/arch/mips/kernel/early_printk_8250.c
@@ -23,12 +23,42 @@ void setup_8250_early_printk_port(unsigned long base, unsigned int reg_shift,
 
 static inline u8 serial_in(int offset)
 {
-	return readb(serial8250_base + (offset << serial8250_reg_shift));
+	u8 ret = 0xFF;
+
+	offset <<= serial8250_reg_shift;
+	switch (serial8250_reg_shift) {
+	case 0:
+		ret = readb(serial8250_base + offset);
+		break;
+	case 1:
+		ret = readw(serial8250_base + offset);
+		break;
+	case 2:
+		ret = readl(serial8250_base + offset);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
 }
 
 static inline void serial_out(int offset, char value)
 {
-	writeb(value, serial8250_base + (offset << serial8250_reg_shift));
+	offset <<= serial8250_reg_shift;
+	switch (serial8250_reg_shift) {
+	case 0:
+		writeb(value, serial8250_base + offset);
+		break;
+	case 1:
+		writew(value, serial8250_base + offset);
+		break;
+	case 2:
+		writel(value, serial8250_base + offset);
+		break;
+	default:
+		break;
+	}
 }
 
 void prom_putchar(char c)
-- 
2.25.1

