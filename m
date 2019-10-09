Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5BED1045
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2019 15:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731328AbfJINgw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Oct 2019 09:36:52 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:45237 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731234AbfJINgw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Oct 2019 09:36:52 -0400
Received: from 79.184.255.36.ipv4.supernova.orange.pl (79.184.255.36) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 2ff32cca8bb795f2; Wed, 9 Oct 2019 15:36:47 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Chen, Hu" <hu1.chen@intel.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: Re: [RFC/RFT][PATCH v8] cpuidle: New timer events oriented governor for tickless systems
Date:   Wed, 09 Oct 2019 15:36:47 +0200
Message-ID: <3490479.2dnHFFeJIp@kreacher>
In-Reply-To: <1574317.FFykgJKpNH@kreacher>
References: <001601d57487$e1029ef0$a307dcd0$@net> <CAJZ5v0jvusVBcKECBueDHk5KQGda=GGuSGPO3F4wCvk3cro56A@mail.gmail.com> <1574317.FFykgJKpNH@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, October 9, 2019 1:19:51 AM CEST Rafael J. Wysocki wrote:
> On Tuesday, October 8, 2019 12:49:01 PM CEST Rafael J. Wysocki wrote:
> > On Tue, Oct 8, 2019 at 11:51 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Tue, Oct 8, 2019 at 8:20 AM Doug Smythies <dsmythies@telus.net> wrote:
> > > >
> > > > On 2019.10.06 08:34 Rafael J. Wysocki wrote:
> > > > > On Sun, Oct 6, 2019 at 4:46 PM Doug Smythies <dsmythies@telus.net> wrote:
> > > > >> On 2019.10.01 02:32 Rafael J. Wysocki wrote:
> > > > >>> On Sun, Sep 29, 2019 at 6:05 PM Doug Smythies <dsmythies@telus.net> wrote:
> > > > >>>> On 2019.09.26 09:32 Doug Smythies wrote:
> > > > >>>>
> > > > >>>>> If the deepest idle state is disabled, the system
> > > > >>>>> can become somewhat unstable, with anywhere between no problem
> > > > >>>>> at all, to the occasional temporary jump using a lot more
> > > > >>>>> power for a few seconds, to a permanent jump using a lot more
> > > > >>>>> power continuously. I have been unable to isolate the exact
> > > > >>>>> test load conditions under which this will occur. However,
> > > > >>>>> temporarily disabling and then enabling other idle states
> > > > >>>>> seems to make for a somewhat repeatable test. It is important
> > > > >>>>> to note that the issue occurs with only ever disabling the deepest
> > > > >>>>> idle state, just not reliably.
> > > > >>>>>
> > > > >>>>> I want to know how you want to proceed before I do a bunch of
> > > > >>>>> regression testing.
> > > > >>>>
> > > > >> I do not think I stated it clearly before: The problem here is that some CPUs
> > > > >> seem to get stuck in idle state 0, and when they do power consumption spikes,
> > > > >> often by several hundred % and often indefinitely.
> > > > >
> > > > > That indeed has not been clear to me, thanks for the clarification!
> > > >
> > > > >
> > > > >> I made a hack job automated test:
> > > > >> Kernel  tests                 fail rate
> > > > >> 5.4-rc1                6616           13.45%
> > > > >> 5.3              2376            4.50%
> > > > >> 5.3-teov7       12136            0.00%  <<< teo.c reverted and teov7 put in its place.
> > > > >> 5.4-rc1-ds      11168        0.00%  <<< [old] proposed patch (> 7 hours test time)
> > > >
> > > >
> > > >    5.4-rc1-ds12   4224          0.005 <<< new proposed patch
> > > >
> > > > >>
> > > > >> [old] Proposed patch (on top of kernel 5.4-rc1): [deleted]
> > > >
> > > > > This change may cause the deepest state to be selected even if its
> > > > > "hits" metric is less than the "misses" one AFAICS, in which case the
> > > > > max_early_index state should be selected instead.
> > > > >
> > > > > It looks like the max_early_index computation is broken when the
> > > > > deepest state is disabled.
> > > >
> > > > O.K. Thanks for your quick reply, and insight.
> > > >
> > > > I think long durations always need to be counted, but currently if
> > > > the deepest idle state is disabled, they are not.
> > > > How about this?:
> > > > (test results added above, more tests pending if this might be a path forward.)
> > > >
> > > > diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
> > > > index b5a0e49..a970d2c 100644
> > > > --- a/drivers/cpuidle/governors/teo.c
> > > > +++ b/drivers/cpuidle/governors/teo.c
> > > > @@ -155,10 +155,12 @@ static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
> > > >
> > > >                 cpu_data->states[i].early_hits -= early_hits >> DECAY_SHIFT;
> > > >
> > > > -               if (drv->states[i].target_residency <= sleep_length_us) {
> > > > -                       idx_timer = i;
> > > > -                       if (drv->states[i].target_residency <= measured_us)
> > > > -                               idx_hit = i;
> > > > +               if (!(drv->states[i].disabled || dev->states_usage[i].disable)){
> > > > +                       if (drv->states[i].target_residency <= sleep_length_us) {
> > > > +                               idx_timer = i;
> > > > +                               if (drv->states[i].target_residency <= measured_us)
> > > > +                                       idx_hit = i;
> > > > +                       }
> > >
> > > What if the state is enabled again after some time?
> > 
> > Actually, the states are treated as "bins" here, so for the metrics it
> > doesn't matter whether or not they are enabled at the moment.
> > 
> > > >                 }
> > > >         }
> > > >
> > > > @@ -256,39 +258,25 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> > > >                 struct cpuidle_state *s = &drv->states[i];
> > > >                 struct cpuidle_state_usage *su = &dev->states_usage[i];
> > > >
> > > > -               if (s->disabled || su->disable) {
> > > > -                       /*
> > > > -                        * If the "early hits" metric of a disabled state is
> > > > -                        * greater than the current maximum, it should be taken
> > > > -                        * into account, because it would be a mistake to select
> > > > -                        * a deeper state with lower "early hits" metric.  The
> > > > -                        * index cannot be changed to point to it, however, so
> > > > -                        * just increase the max count alone and let the index
> > > > -                        * still point to a shallower idle state.
> > > > -                        */
> > > > -                       if (max_early_idx >= 0 &&
> > > > -                           count < cpu_data->states[i].early_hits)
> > > > -                               count = cpu_data->states[i].early_hits;
> > > > -
> > > > -                       continue;
> > >
> > > AFAICS, adding early_hits to count is not a mistake if there are still
> > > enabled states deeper than the current one.
> > 
> > And the mistake appears to be that the "hits" and "misses" metrics
> > aren't handled in analogy with the "early_hits" one when the current
> > state is disabled.
> > 
> > Let me try to cut a patch to address that.
> 
> Appended below, not tested.
> 
> It is meant to address two problems, one of which is that the "hits" and
> "misses" metrics of disabled states need to be taken into account too in
> some cases, and the other is an issue with the handling of "early hits"
> which may lead to suboptimal state selection if some states are disabled.

Well, it still misses a couple of points.

First, disable states that are too deep should not be taken into consideration
at all.

Second, the "hits" and "misses" metrics of disabled states need to be used for
idle duration ranges corresponding to them regardless of whether or not the
"hits" value is greater than the "misses" one.

Updated patch is below (still not tested), but it tries to do too much in one
go, so I need to split it into a series of smaller changes.

---
 drivers/cpuidle/governors/teo.c |   78 ++++++++++++++++++++++++++++++----------
 1 file changed, 59 insertions(+), 19 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/teo.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/teo.c
+++ linux-pm/drivers/cpuidle/governors/teo.c
@@ -233,7 +233,7 @@ static int teo_select(struct cpuidle_dri
 {
 	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
 	int latency_req = cpuidle_governor_latency_req(dev->cpu);
-	unsigned int duration_us, count;
+	unsigned int duration_us, hits, misses, early_hits;
 	int max_early_idx, constraint_idx, idx, i;
 	ktime_t delta_tick;
 
@@ -247,7 +247,9 @@ static int teo_select(struct cpuidle_dri
 	cpu_data->sleep_length_ns = tick_nohz_get_sleep_length(&delta_tick);
 	duration_us = ktime_to_us(cpu_data->sleep_length_ns);
 
-	count = 0;
+	hits = 0;
+	misses = 0;
+	early_hits = 0;
 	max_early_idx = -1;
 	constraint_idx = drv->state_count;
 	idx = -1;
@@ -258,23 +260,61 @@ static int teo_select(struct cpuidle_dri
 
 		if (s->disabled || su->disable) {
 			/*
-			 * If the "early hits" metric of a disabled state is
-			 * greater than the current maximum, it should be taken
-			 * into account, because it would be a mistake to select
-			 * a deeper state with lower "early hits" metric.  The
-			 * index cannot be changed to point to it, however, so
-			 * just increase the max count alone and let the index
-			 * still point to a shallower idle state.
+			 * Ignore disabled states with target residencies beyond
+			 * the anticipated idle duration.
 			 */
-			if (max_early_idx >= 0 &&
-			    count < cpu_data->states[i].early_hits)
-				count = cpu_data->states[i].early_hits;
+			if (s->target_residency > duration_us)
+				continue;
+
+			/*
+			 * This state is disabled, so the range of idle duration
+			 * values corresponding to it is covered by the current
+			 * candidate state, but still the "hits" and "misses"
+			 * metrics of the disabled state need to be used to
+			 * decide whether or not the state covering the range in
+			 * question is good enough.
+			 */
+			hits = cpu_data->states[i].hits;
+			misses = cpu_data->states[i].misses;
+
+			if (early_hits >= cpu_data->states[i].early_hits ||
+			    idx < 0)
+				continue;
+
+			/*
+			 * If the current candidate state has been the one with
+			 * the maximum "early hits" metric so far, the "early
+			 * hits" metric of the disabled state replaces the
+			 * current "early hits" count to avoid selecting a
+			 * deeper state with lower "early hits" metric.
+			 */
+			if (max_early_idx == idx) {
+				early_hits = cpu_data->states[i].early_hits;
+				continue;
+			}
+
+			/*
+			 * The current candidate state is closer to the disabled
+			 * one than the current maximum "early hits" state, so
+			 * replace the latter with it, but in case the maximum
+			 * "early hits" state index has not been set so far,
+			 * check if the current candidate state is not too
+			 * shallow for that role.
+			 */
+			if (!(tick_nohz_tick_stopped() &&
+			      drv->states[idx].target_residency < TICK_USEC)) {
+				early_hits = cpu_data->states[i].early_hits;
+				max_early_idx = idx;
+			}
 
 			continue;
 		}
 
-		if (idx < 0)
+		if (idx < 0) {
 			idx = i; /* first enabled state */
+			hits = cpu_data->states[i].hits;
+			misses = cpu_data->states[i].misses;
+		}
 
 		if (s->target_residency > duration_us)
 			break;
@@ -283,11 +323,13 @@ static int teo_select(struct cpuidle_dri
 			constraint_idx = i;
 
 		idx = i;
+		hits = cpu_data->states[i].hits;
+		misses = cpu_data->states[i].misses;
 
-		if (count < cpu_data->states[i].early_hits &&
+		if (early_hits < cpu_data->states[i].early_hits &&
 		    !(tick_nohz_tick_stopped() &&
 		      drv->states[i].target_residency < TICK_USEC)) {
-			count = cpu_data->states[i].early_hits;
+			early_hits = cpu_data->states[i].early_hits;
 			max_early_idx = i;
 		}
 	}
@@ -300,8 +342,7 @@ static int teo_select(struct cpuidle_dri
 	 * "early hits" metric, but if that cannot be determined, just use the
 	 * state selected so far.
 	 */
-	if (cpu_data->states[idx].hits <= cpu_data->states[idx].misses &&
-	    max_early_idx >= 0) {
+	if (hits <= misses && max_early_idx >= 0) {
 		idx = max_early_idx;
 		duration_us = drv->states[idx].target_residency;
 	}
@@ -316,10 +357,9 @@ static int teo_select(struct cpuidle_dri
 	if (idx < 0) {
 		idx = 0; /* No states enabled. Must use 0. */
 	} else if (idx > 0) {
+		unsigned int count = 0;
 		u64 sum = 0;
 
-		count = 0;
-
 		/*
 		 * Count and sum the most recent idle duration values less than
 		 * the current expected idle duration value.



