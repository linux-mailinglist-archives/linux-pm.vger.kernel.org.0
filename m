Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A60A21182C9
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 09:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfLJIuh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 03:50:37 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:61915 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbfLJIug (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 03:50:36 -0500
Received: from 79.184.255.117.ipv4.supernova.orange.pl (79.184.255.117) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id b9c8827cb86f8bf1; Tue, 10 Dec 2019 09:50:33 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
Date:   Tue, 10 Dec 2019 09:50:33 +0100
Message-ID: <40413247.HltoIgKm8r@kreacher>
In-Reply-To: <DB3PR0402MB3916781D19ECB96C530B410DF55B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <DB3PR0402MB39165E1B832597ADBAB241AAF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com> <CAJZ5v0hmaCPNX3O=Yvwh6zt13F9-sFApZn1Rnqx=_xzPde34Pw@mail.gmail.com> <DB3PR0402MB3916781D19ECB96C530B410DF55B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday, December 10, 2019 9:45:09 AM CET Anson Huang wrote:
> 
> > -----Original Message-----
> > From: Rafael J. Wysocki <rafael@kernel.org>
> > Sent: Tuesday, December 10, 2019 4:38 PM
> > To: Anson Huang <anson.huang@nxp.com>
> > Cc: Rafael J. Wysocki <rafael@kernel.org>; Viresh Kumar
> > <viresh.kumar@linaro.org>; Peng Fan <peng.fan@nxp.com>; Rafael J.
> > Wysocki <rjw@rjwysocki.net>; Jacky Bai <ping.bai@nxp.com>; linux-
> > pm@vger.kernel.org; Vincent Guittot <vincent.guittot@linaro.org>; Peter
> > Zijlstra <peterz@infradead.org>; Paul McKenney
> > <paulmck@linux.vnet.ibm.com>
> > Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
> > 
> > On Tue, Dec 10, 2019 at 9:29 AM Anson Huang <anson.huang@nxp.com>
> > wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Rafael J. Wysocki <rafael@kernel.org>
> > > > Sent: Tuesday, December 10, 2019 4:22 PM
> > > > To: Viresh Kumar <viresh.kumar@linaro.org>
> > > > Cc: Peng Fan <peng.fan@nxp.com>; Rafael J. Wysocki
> > > > <rafael@kernel.org>; Anson Huang <anson.huang@nxp.com>; Rafael J.
> > > > Wysocki <rjw@rjwysocki.net>; Jacky Bai <ping.bai@nxp.com>; linux-
> > > > pm@vger.kernel.org; Vincent Guittot <vincent.guittot@linaro.org>;
> > > > Peter Zijlstra <peterz@infradead.org>; Paul McKenney
> > > > <paulmck@linux.vnet.ibm.com>
> > > > Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
> > > >
> > > > On Tue, Dec 10, 2019 at 8:05 AM Viresh Kumar
> > > > <viresh.kumar@linaro.org>
> > > > wrote:
> > > > >
> > > > > +few more guys
> > > > >
> > > > > On 10-12-19, 05:53, Peng Fan wrote:
> > > > > > But per
> > > > > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%
> > > > > > 2Fel
> > > > > > ixir.bootlin.com%2Flinux%2Fv5.5-
> > > > rc1%2Fsource%2Fkernel%2Fsched%2Fsche
> > > > > >
> > > >
> > d.h%23L2293&amp;data=02%7C01%7Canson.huang%40nxp.com%7C6f44900
> > > > be3404
> > > > > >
> > > >
> > e7d355708d77d4a16fa%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%
> > > > 7C637
> > > > > >
> > > >
> > 115629475456329&amp;sdata=XXhwvuTOBb3TLmerwkr1zKbaWNA8xA%2Bl
> > > > W%2Faw31
> > > > > > 0AYcM%3D&amp;reserved=0
> > > > > > cpu_of(rq) and smp_processor_id() is possible to not the same,
> > > > > >
> > > > > > When cpu_of(rq) is not equal to smp_processor_id(),
> > > > > > dbs_update_util_handler will use irq_work_queue to
> > > > > > smp_processor_id(), not cpu_of(rq). Is this expected?
> > > > > > Or should the irq_work be queued to cpu_of(rq)?
> > > > >
> > > > > Okay, sorry for the long weekend where I couldn't get time to reply at
> > all.
> > > >
> > > > No worries. :-)
> > > >
> > > > > First of all, lets try to understand dvfs_possible_from_any_cpu.
> > > > >
> > > > > Who can update the frequency of a CPU ? For many
> > > > > architectures/platforms the eventual code that writes to some
> > > > > register to change the frequency should only run on the local CPU,
> > > > > as these registers are per-cpu registers and not something shared
> > between CPUs.
> > > > >
> > > > > But for the ARM architecture, we have a PLL and then some more
> > > > > registers to play with the clk provided to the CPU blocks and
> > > > > these registers (which are updated as a result of clk_set_rate())
> > > > > are part of a
> > > > block outside of the CPU blocks.
> > > > > And so any CPU (even if it is not part of the same cpufreq policy)
> > > > > can update it. Setting this flag allows that and eventually we may
> > > > > end up updating the frequency sooner, instead of later (which may
> > > > > be less effective). That was the idea of the remote-wakeup series.
> > > > > This stuff is absolutely correct and so cpufreq-dt does it for everyone.
> > > > >
> > > > > This also means that the normal work and irq-work both can run on
> > > > > any CPU for your platform and it should be okay to do that.
> > > >
> > > > And it the failing case all of the CPUs in the system are in the
> > > > same policy anyway, so dvfs_possible_from_any_cpu is a red herring.
> > > >
> > > > > Now, we have necessary measures in place to make sure that after
> > > > > stopping and before starting a governor, the scheduler hooks to
> > > > > save the cpufreq governor pointer and updates to policy->cpus are
> > > > > made properly, to make sure that we never ever schedule a work or
> > > > > irq-work on a CPU which is offline. Now it looks like this isn't
> > > > > working as expected and we need to find what exactly is broken here.
> > > > >
> > > > > And yes, I did the testing on Hikey 620, an octa-core ARM platform
> > > > > which has a single cpufreq policy which has all the 8 CPUs. And
> > > > > yes, I am using cpufreq-dt only and I wasn't able to reproduce the
> > > > > problem with mainline kernel as I explained earlier.
> > > > >
> > > > > The problem is somewhere between the scheduler's governor hook
> > > > running
> > > > > or queuing work on a CPU which is in the middle of getting
> > > > > offline/online and there is some race around that. The problem
> > > > > hence may not be related to just cpufreq, but a wider variety of clients.
> > > >
> > > > The problem is that a CPU is running a governor hook which it
> > > > shouldn't be running at all.
> > > >
> > > > The observation that dvfs_possible_from_any_cpu makes a difference
> > > > only means that the governor hook is running on a CPU that is not
> > > > present in the
> > > > policy->cpus mask.  On the platform(s) in question this cannot
> > > > policy->happen as
> > > > long as RCU works as expected.
> > >
> > > If I understand correctly, the governor hook ONLY be clear on the CPU
> > > being offline and after governor stopped, but the CPU being offline
> > > could still run into below function to help other CPU update the util,
> > > and it ONLY checks the cpu_of(rq)'s governor hook which is valid as that
> > CPU is online.
> > >
> > > So the question is how to avoid the CPU being offline and already
> > > finish the governor stop flow be scheduled to help other CPU update the
> > util.
> > >
> > >  static inline void cpufreq_update_util(struct rq *rq, unsigned int
> > > flags)  {
> > >          struct update_util_data *data;
> > >
> > >          data =
> > rcu_dereference_sched(*per_cpu_ptr(&cpufreq_update_util_data,
> > >                                                    cpu_of(rq)));
> > >          if (data)
> > >                  data->func(data, rq_clock(rq), flags);  }
> > 
> > OK, so that's where the problem is, good catch!
> > 
> > So what happens is that a CPU going offline runs some scheduler code that
> > invokes cpufreq_update_util().  Incidentally, it is not the cpu_of(rq), but that
> > CPU is still online, so the callback is invoked and then policy->cpus test is
> > bypassed because of dvfs_possible_from_any_cpu.
> 
> If this is the issue, add another check here for the current CPU's governor hook?
> Or any other better place to make sure the CPU being offline NOT to be queued to irq work?

Generally, yes.

Something like the patch below should help if I'm not mistaken:

---
 include/linux/cpufreq.h |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -599,11 +599,13 @@ static inline bool cpufreq_this_cpu_can_
 {
 	/*
 	 * Allow remote callbacks if:
-	 * - dvfs_possible_from_any_cpu flag is set
 	 * - the local and remote CPUs share cpufreq policy
+	 * - dvfs_possible_from_any_cpu flag is set and the CPU running the
+	 *   code is not going offline.
 	 */
-	return policy->dvfs_possible_from_any_cpu ||
-		cpumask_test_cpu(smp_processor_id(), policy->cpus);
+	return cpumask_test_cpu(smp_processor_id(), policy->cpus) ||
+		(policy->dvfs_possible_from_any_cpu &&
+		 !cpumask_test_cpu(smp_processor_id(), policy->related_cpus));
 }
 
 /*********************************************************************



