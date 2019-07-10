Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8399164520
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2019 12:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfGJKWq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jul 2019 06:22:46 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:59446 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfGJKWq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jul 2019 06:22:46 -0400
Received: from 79.184.253.121.ipv4.supernova.orange.pl (79.184.253.121) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 7b98129f9fda85dd; Wed, 10 Jul 2019 12:22:43 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Thomas Lindroth <thomas.lindroth@gmail.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: The tick is active on idle adaptive-tick CPUs when /dev/cpu_dma_latency is used
Date:   Wed, 10 Jul 2019 12:22:43 +0200
Message-ID: <312565511.gEFFlSTcEG@kreacher>
In-Reply-To: <6ef6b96e-1772-6e80-60cf-eb57af618e99@gmail.com>
References: <79b247b3-e056-610e-9a07-e685dfdaa6c9@gmail.com> <7332404.L1nL2KBT3s@kreacher> <6ef6b96e-1772-6e80-60cf-eb57af618e99@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Saturday, July 6, 2019 3:02:11 PM CEST Thomas Lindroth wrote:
> On 7/6/19 1:06 PM, Rafael J. Wysocki wrote:
> > The patch is below, but note that it adds the tick stopping overhead to the idle loop
> > for CPUs that are not adaptive-tick and when PM QoS latency constraints are used
> > which is not desirable in general.
> > 
> > Please test it, but as I said above, the real solution appears to be to treat adaptive-tick
> > CPUs in a special way in the idle loop.
> > 
> > ---
> >   drivers/cpuidle/governors/menu.c |   16 +++++-----------
> >   1 file changed, 5 insertions(+), 11 deletions(-)
> > 
> > Index: linux-pm/drivers/cpuidle/governors/menu.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> > +++ linux-pm/drivers/cpuidle/governors/menu.c
> > @@ -302,9 +302,10 @@ static int menu_select(struct cpuidle_dr
> >   	     !drv->states[0].disabled && !dev->states_usage[0].disable)) {
> >   		/*
> >   		 * In this case state[0] will be used no matter what, so return
> > -		 * it right away and keep the tick running.
> > +		 * it right away and keep the tick running if state[0] is a
> > +		 * polling one.
> >   		 */
> > -		*stop_tick = false;
> > +		*stop_tick = !!(drv->states[0].flags & CPUIDLE_FLAG_POLLING);
> >   		return 0;
> >   	}
> >   
> > @@ -395,16 +396,9 @@ static int menu_select(struct cpuidle_dr
> >   
> >   			return idx;
> >   		}
> > -		if (s->exit_latency > latency_req) {
> > -			/*
> > -			 * If we break out of the loop for latency reasons, use
> > -			 * the target residency of the selected state as the
> > -			 * expected idle duration so that the tick is retained
> > -			 * as long as that target residency is low enough.
> > -			 */
> > -			predicted_us = drv->states[idx].target_residency;
> > +		if (s->exit_latency > latency_req)
> >   			break;
> > -		}
> > +
> >   		idx = i;
> >   	}
> 
> I tested the patch and it appears to work. Idle CPUs now have ticks disabled even
> when /dev/cpu_dma_latency is used.

OK, thanks, but as I said previously, you'd see the problem again with the PM QoS
latency constraint set to 0, which is somewhat inconsistent.  Also, this fix is
specific to the menu governor and the behavior should not depend on the
governor here IMO, so I have another patch to try (appended).

Please test it (instead of the previous one) and report back.

> I also want to thank you for your work on the idle loop redesign. Overall it works
> much better than before. I used to have a problem where idle CPUs would end up
> doing C0 polling for a long time resulting in a big performance drop on the HT
> sibling. When benchmarking I always had to offline siblings to get consistent
> results. That problem was fixed in the redesign.
> 

Thank you, much appreciated.

---
 kernel/sched/idle.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-pm/kernel/sched/idle.c
===================================================================
--- linux-pm.orig/kernel/sched/idle.c
+++ linux-pm/kernel/sched/idle.c
@@ -191,7 +191,8 @@ static void cpuidle_idle_call(void)
 		 */
 		next_state = cpuidle_select(drv, dev, &stop_tick);
 
-		if (stop_tick || tick_nohz_tick_stopped())
+		if (stop_tick || tick_nohz_tick_stopped() ||
+		    !housekeeping_cpu(dev->cpu, HK_FLAG_TICK))
 			tick_nohz_idle_stop_tick();
 		else
 			tick_nohz_idle_retain_tick();



