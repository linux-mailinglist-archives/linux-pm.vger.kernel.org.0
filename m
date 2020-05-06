Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74AB41C786B
	for <lists+linux-pm@lfdr.de>; Wed,  6 May 2020 19:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgEFRov (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 May 2020 13:44:51 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:32958 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730349AbgEFRob (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 May 2020 13:44:31 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 6D5E08000BB3;
        Wed,  6 May 2020 17:44:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DyI7IDSfg4EM; Wed,  6 May 2020 20:44:26 +0300 (MSK)
From:   <Sergey.Semin@baikalelectronics.ru>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 19/20] mips: cevt-r4k: Update the r4k-clockevent frequency in sync with CPU
Date:   Wed, 6 May 2020 20:42:37 +0300
Message-ID: <20200506174238.15385-20-Sergey.Semin@baikalelectronics.ru>
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

Due to being embedded into the CPU cores MIPS count/compare timer
frequency is changed together with the CPU clocks alteration.
In case if frequency really changes the kernel clockevent framework
must be notified, otherwise the kernel timers won't work correctly.
Fix this by calling clockevents_update_freq() for each r4k clockevent
handlers registered per available CPUs.

Traditionally MIPS r4k-clock are clocked with CPU frequency divided by 2.
But this isn't true for some of the platforms. Due to this we have to save
the basic CPU frequency, so then use it to scale the initial timer
frequency (mips_hpt_frequency) and pass the updated value further to the
clockevent framework.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org
---
 arch/mips/kernel/cevt-r4k.c | 44 +++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index 17a9cbb8b3df..f5b72fb7d5ee 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -8,6 +8,7 @@
  */
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
+#include <linux/cpufreq.h>
 #include <linux/percpu.h>
 #include <linux/smp.h>
 #include <linux/irq.h>
@@ -250,6 +251,49 @@ unsigned int __weak get_c0_compare_int(void)
 	return MIPS_CPU_IRQ_BASE + cp0_compare_irq;
 }
 
+#ifdef CONFIG_CPU_FREQ
+
+static unsigned long mips_ref_freq;
+
+static int cpufreq_callback(struct notifier_block *nb,
+			    unsigned long val, void *data)
+{
+	struct cpufreq_freqs *freq = data;
+	struct clock_event_device *cd;
+	unsigned long rate;
+	int cpu;
+
+	if (!mips_ref_freq)
+		mips_ref_freq = freq->old;
+
+	if (val == CPUFREQ_POSTCHANGE) {
+		rate = cpufreq_scale(mips_hpt_frequency, mips_ref_freq,
+				     freq->new);
+
+		for_each_cpu(cpu, freq->policy->cpus) {
+			cd = &per_cpu(mips_clockevent_device, cpu);
+
+			clockevents_update_freq(cd, rate);
+		}
+	}
+
+	return 0;
+}
+
+static struct notifier_block cpufreq_notifier = {
+	.notifier_call  = cpufreq_callback,
+};
+
+static int __init register_cpufreq_notifier(void)
+{
+	return cpufreq_register_notifier(&cpufreq_notifier,
+					 CPUFREQ_TRANSITION_NOTIFIER);
+
+}
+core_initcall(register_cpufreq_notifier);
+
+#endif /* !CONFIG_CPU_FREQ */
+
 int r4k_clockevent_init(void)
 {
 	unsigned long flags = IRQF_PERCPU | IRQF_TIMER | IRQF_SHARED;
-- 
2.25.1

