Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D76D361042
	for <lists+linux-pm@lfdr.de>; Sat,  6 Jul 2019 13:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfGFLGl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 6 Jul 2019 07:06:41 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50140 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfGFLGk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 6 Jul 2019 07:06:40 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 510b43685b18b9f3; Sat, 6 Jul 2019 13:06:37 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Thomas Lindroth <thomas.lindroth@gmail.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: The tick is active on idle adaptive-tick CPUs when /dev/cpu_dma_latency is used
Date:   Sat, 06 Jul 2019 13:06:37 +0200
Message-ID: <7332404.L1nL2KBT3s@kreacher>
In-Reply-To: <CAJZ5v0grOas+Wh0h09fKZmUnOJ3PRX2Fc=2fv7=zCFJiZ09-Bg@mail.gmail.com>
References: <79b247b3-e056-610e-9a07-e685dfdaa6c9@gmail.com> <CAJZ5v0grOas+Wh0h09fKZmUnOJ3PRX2Fc=2fv7=zCFJiZ09-Bg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Saturday, July 6, 2019 10:17:15 AM CEST Rafael J. Wysocki wrote:
> On Fri, Jul 5, 2019 at 7:22 PM Thomas Lindroth
> <thomas.lindroth@gmail.com> wrote:
> >
> > On recent kernels the tick remains active on idle adaptive-tick CPUs when a small
> > value is written to /dev/cpu_dma_latency to restrict the highest C-state. Before the
> > idle loop redesign in 4.17 idle CPUs had the tick disabled even when C-state were
> > restricted. Is this change intentional or a regression?
> 
> It was intentional, but this kind of is a gray area.
> 
> At least for the menu governor you may argue that the decision on
> whether or not to stop the tick should be based on the predicted idle
> duration.

But also see below.

> > I use an x86_64 system built with CONFIG_NO_HZ_FULL that I recently upgraded to the 4.19 series from the 4.14 series.
> > I noticed that adaptive-tick CPUs (nohz_full=1-7) still fire timer interrupts about 1000 times/s (CONFIG_HZ_1000=y) even
> > when they are mostly idle. Some debugging showed that this only happens when a program is writing to
> > /dev/cpu_dma_latency to restrict C-states. The old 4.14 kernel only have around 10 timer interrupts per second on idle
> > adaptive-tick CPU even when C-states are restricted that way.
> >
> > I would expect an adaptive-tick CPU to turn off the tick when it has 0 or 1 processes to run and enable the tick for >2
> > processes. Kernels after 4.17 instead have the tick on when 0 or >2 processes are running and the tick off in the 1 process
> > case. Since the tick is off when a single process is running that workload isn't directly harmed by the change but if the CPU
> > use hyperthreading the constant wakeups on an idle HT sibling will reduce performance on the other sibling.

So it looks like the idle loop needs a special case for adaptive-tick CPUs.

> >
> > They way I look for timer interrupts is by comparing the LOC line in /proc/interrupts or using the hrtimer_expire_entry
> > tracepoint when function=tick_sched_timer. Both methods seem to give the same results.
> >
> > I can reproduce the problem using an i7-4790K CPU with /sys/devices/system/cpu/cpuidle/current_driver:intel_idle. I can
> > also reproduce the problem on an old core2duo laptop with current_driver:acpi_idle but I can't reproduce the problem
> > in a virtual machine where current_driver:none. I also can't reproduce the problem if C-states are restricted using the
> > intel_idle.max_cstate=1 kernel argument instead of /dev/cpu_dma_latency.
> >
> > The commit that introduced the change is 554c8aa8ec "sched: idle: Select idle state before stopping the tick" in v4.17
> > and the problem exists at least up to kernel 5.1 using the menu cpuidle governor.
> 
> Restoring the previous behavior in this case should be relatively
> straightforward.  I'll send you a patch to do that later.

The patch is below, but note that it adds the tick stopping overhead to the idle loop
for CPUs that are not adaptive-tick and when PM QoS latency constraints are used
which is not desirable in general.

Please test it, but as I said above, the real solution appears to be to treat adaptive-tick
CPUs in a special way in the idle loop.

---
 drivers/cpuidle/governors/menu.c |   16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -302,9 +302,10 @@ static int menu_select(struct cpuidle_dr
 	     !drv->states[0].disabled && !dev->states_usage[0].disable)) {
 		/*
 		 * In this case state[0] will be used no matter what, so return
-		 * it right away and keep the tick running.
+		 * it right away and keep the tick running if state[0] is a
+		 * polling one.
 		 */
-		*stop_tick = false;
+		*stop_tick = !!(drv->states[0].flags & CPUIDLE_FLAG_POLLING);
 		return 0;
 	}
 
@@ -395,16 +396,9 @@ static int menu_select(struct cpuidle_dr
 
 			return idx;
 		}
-		if (s->exit_latency > latency_req) {
-			/*
-			 * If we break out of the loop for latency reasons, use
-			 * the target residency of the selected state as the
-			 * expected idle duration so that the tick is retained
-			 * as long as that target residency is low enough.
-			 */
-			predicted_us = drv->states[idx].target_residency;
+		if (s->exit_latency > latency_req)
 			break;
-		}
+
 		idx = i;
 	}
 



