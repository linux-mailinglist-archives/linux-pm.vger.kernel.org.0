Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7748525C3D8
	for <lists+linux-pm@lfdr.de>; Thu,  3 Sep 2020 16:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgICO7p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Sep 2020 10:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729101AbgICOHH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Sep 2020 10:07:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4685C0610E3;
        Thu,  3 Sep 2020 06:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HMKdcBAh3Qfsb0YqV9KE1AdBeTa9W/Y2t3RJ7FugT60=; b=j+QW6nUzroNn72HmxKzqjWDO5S
        NWwyKermXl6fL1UShM1HWUPvHIV2VIC61NK+tJPlQRgbUknfX0vL45DhVcnFsWSUHk8HyK/8ECR1j
        8+8hm8yUaQRdj6wv2p+8RHIZ28gNkNG1iXSl0/vv0liO/UhJx2SDdQnywRYDUxMehPBrvx+dElVDu
        +G3fDh/zuuQs1ELn9WRIGouAYkJXP2cZI3UadK89ovYuIhezQzpPZp5Ik3CKgqCxrX0hXW08muef1
        0tTDaI96K+tEE1jjCVH5g6SluGC4xrhyijttNv08u4guRe3iaUCPcfKe47q1uJ6mgOrT/0lKotz6o
        4x4yk5pg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDpgU-0002gF-IL; Thu, 03 Sep 2020 13:53:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B8EFE300F7A;
        Thu,  3 Sep 2020 15:53:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9ABEA2BB8B563; Thu,  3 Sep 2020 15:53:47 +0200 (CEST)
Date:   Thu, 3 Sep 2020 15:53:47 +0200
From:   peterz@infradead.org
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Saravana Kannan <saravanak@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        lkft-triage@lists.linaro.org, rcu@vger.kernel.org,
        Linux PM <linux-pm@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        madhuparnabhowmik10@gmail.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC][PATCH] cpu_pm: Remove RCU abuse
Message-ID: <20200903135347.GC1362448@hirez.programming.kicks-ass.net>
References: <20200901104206.GU1362448@hirez.programming.kicks-ass.net>
 <CAPDyKFo0VkW-cgRSkvPQ0whpuJCo4OKcL1nmH7nz1tDEChOtVg@mail.gmail.com>
 <CAPDyKFrv+DTF8=twZZk_tenB-sLg6H-CFn9HVDVA5S2kK2=U5Q@mail.gmail.com>
 <20200901154417.GD20303@codeaurora.org>
 <20200901155014.GF2674@hirez.programming.kicks-ass.net>
 <20200901161340.GC29330@paulmck-ThinkPad-P72>
 <20200901174216.GJ29142@worktop.programming.kicks-ass.net>
 <CAPDyKFqPh7bg16AsitGv2QQHgwOPnWx9DiPPCMuD1EGA5TFFdg@mail.gmail.com>
 <20200902121355.GE1362448@hirez.programming.kicks-ass.net>
 <CAPDyKFrGj+8hOXi7sWxWNv2QP0=mx9pFKLG0JM-L5VNKUPDgeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrGj+8hOXi7sWxWNv2QP0=mx9pFKLG0JM-L5VNKUPDgeA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 02, 2020 at 05:58:55PM +0200, Ulf Hansson wrote:
> On Wed, 2 Sep 2020 at 14:14, <peterz@infradead.org> wrote:
> >
> > On Wed, Sep 02, 2020 at 09:03:37AM +0200, Ulf Hansson wrote:
> > > Lots of cpuidle drivers are using CPU_PM notifiers (grep for
> > > cpu_pm_enter and you will see) from their idlestates ->enter()
> > > callbacks. And for those we are already calling
> > > rcu_irq_enter_irqson|off() in cpu_pm_notify() when firing them.
> >
> > Yeah, that particular trainwreck is on my todo list already ... then
> > again, that list is forever overflowing.
> >
> > I'm thinking cpu_pm_unregister_notifier() is not a common thing? The few
> > I looked at seem to suggest 'never' is a good approximation.
> 
> The trend is that drivers are turning into regular modules that may
> also need to manage "->remove()", which may mean unregistering the
> notifier. Of course, I don't know for sure whether that becomes a
> problem, but it seems quite limiting.

You can pin modules, once they're loaded they can never be removed
again.

Anyway, the below should 'work', I think.

---
diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
index f7e1d0eccdbc..72804e0883d5 100644
--- a/kernel/cpu_pm.c
+++ b/kernel/cpu_pm.c
@@ -12,21 +12,18 @@
 #include <linux/notifier.h>
 #include <linux/spinlock.h>
 #include <linux/syscore_ops.h>
+#include <linux/cpu.h>
+#include <linux/smp.h>
 
-static ATOMIC_NOTIFIER_HEAD(cpu_pm_notifier_chain);
+static RAW_NOTIFIER_HEAD(cpu_pm_notifier_chain);
+static DEFINE_SPINLOCK(cpu_pm_lock);
 
 static int cpu_pm_notify(enum cpu_pm_event event)
 {
 	int ret;
 
-	/*
-	 * atomic_notifier_call_chain has a RCU read critical section, which
-	 * could be disfunctional in cpu idle. Copy RCU_NONIDLE code to let
-	 * RCU know this.
-	 */
-	rcu_irq_enter_irqson();
-	ret = atomic_notifier_call_chain(&cpu_pm_notifier_chain, event, NULL);
-	rcu_irq_exit_irqson();
+	lockdep_assert_irqs_disabled();
+	ret = raw_notifier_call_chain(&cpu_pm_notifier_chain, event, NULL);
 
 	return notifier_to_errno(ret);
 }
@@ -35,9 +32,8 @@ static int cpu_pm_notify_robust(enum cpu_pm_event event_up, enum cpu_pm_event ev
 {
 	int ret;
 
-	rcu_irq_enter_irqson();
-	ret = atomic_notifier_call_chain_robust(&cpu_pm_notifier_chain, event_up, event_down, NULL);
-	rcu_irq_exit_irqson();
+	lockdep_assert_irqs_disabled();
+	ret = raw_notifier_call_chain_robust(&cpu_pm_notifier_chain, event_up, event_down, NULL);
 
 	return notifier_to_errno(ret);
 }
@@ -54,10 +50,28 @@ static int cpu_pm_notify_robust(enum cpu_pm_event event_up, enum cpu_pm_event ev
  */
 int cpu_pm_register_notifier(struct notifier_block *nb)
 {
-	return atomic_notifier_chain_register(&cpu_pm_notifier_chain, nb);
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&cpu_pm_lock, flags);
+	ret = raw_notifier_chain_register(&cpu_pm_notifier_chain, nb);
+	spin_unlock_irqrestore(&cpu_pm_lock, flags);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(cpu_pm_register_notifier);
 
+static bool __is_idle_cpu(int cpu, void *info)
+{
+	/*
+	 * Racy as heck, however if we fail to see an idle task, it must be
+	 * after we removed our element, so all is fine.
+	 */
+	return is_idle_task(curr_task(cpu));
+}
+
+static void __nop_func(void *arg) { }
+
 /**
  * cpu_pm_unregister_notifier - unregister a driver with cpu_pm
  * @nb: notifier block to be unregistered
@@ -69,7 +83,30 @@ EXPORT_SYMBOL_GPL(cpu_pm_register_notifier);
  */
 int cpu_pm_unregister_notifier(struct notifier_block *nb)
 {
-	return atomic_notifier_chain_unregister(&cpu_pm_notifier_chain, nb);
+	unsigned long flags;
+	int ret, cpu;
+
+	spin_lock_irqsave(&cpu_pm_lock, flags);
+	ret = raw_notifier_chain_unregister(&cpu_pm_notifier_chain, nb);
+	spin_unlock_irqrestore(&cpu_pm_lock, flags);
+
+	/*
+	 * Orders the removal above vs the __is_idle_cpu() test below. Matches
+	 * schedule() switching to the idle task.
+	 *
+	 * Ensures that if we miss an idle task, it must be after the removal.
+	 */
+	smp_mb();
+
+	/*
+	 * IPI all idle CPUs, this guarantees that no CPU is currently
+	 * iterating the notifier list.
+	 */
+	cpus_read_lock();
+	on_each_cpu_cond(__is_idle_cpu, __nop_func, NULL, 1);
+	cpus_read_unlock();
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(cpu_pm_unregister_notifier);
 
