Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D892B840A
	for <lists+linux-pm@lfdr.de>; Wed, 18 Nov 2020 19:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbgKRSrP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 18 Nov 2020 13:47:15 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:56798 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgKRSrP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2020 13:47:15 -0500
Received: from 89-64-89-10.dynamic.chello.pl (89.64.89.10) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.520)
 id 676dcfafbaedb0a8; Wed, 18 Nov 2020 19:47:12 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Andrei Popa <andreipopad@gmail.com>, linux-kernel@vger.kernel.org,
        peterz@infradead.org, Linux PM <linux-pm@vger.kernel.org>
Subject: Re: high number of dropped packets/rx_missed_errors from 4.17 kernel
Date:   Wed, 18 Nov 2020 19:47:12 +0100
Message-ID: <18276301.3Z8BrWjNFq@kreacher>
In-Reply-To: <47586104-a816-1419-13c0-b1d297289fd5@intel.com>
References: <8EACE662-A291-4DB8-A5CB-BB0BD44B7AB0@gmail.com> <47586104-a816-1419-13c0-b1d297289fd5@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday, November 17, 2020 7:31:29 PM CET Rafael J. Wysocki wrote:
> On 11/16/2020 8:11 AM, Andrei Popa wrote:
> > Hello,
> >
> > After an update from vmlinuz-4.15.0-106-generic to vmlinuz-5.4.0-37-generic we experience, on a  number of servers, a very high number of rx_missed_errors and dropped packets only on the uplink 10G interface. We have another 10G downlink interface with no problems.
> >
> > The affected servers have the following mainboards:
> > S5520HC ver E26045-455
> > S5520UR ver E22554-751
> > S5520UR ver E22554-753
> > S5000VSA
> >
> > On other 30 servers with similar mainboards and/or configs there are no dropped packets with vmlinuz-5.4.0-37-generic.
> >
> > We’ve installed vanilla 4.16 and there were no dropped packets.
> > Vanilla 4.17 had a very high number of dropped packets like the following:
> >
> > root@shaper:~# cat test
> > #!/bin/bash
> > while true
> > do
> > ethtool -S ens6f1|grep "missed_errors"
> > ifconfig ens6f1|grep RX|grep dropped
> > sleep 1
> > done
> >
> > root@shaper:~# ./test
> >       rx_missed_errors: 2418845
> >          RX errors 0  dropped 2418888  overruns 0  frame 0
> >       rx_missed_errors: 2426175
> >          RX errors 0  dropped 2426218  overruns 0  frame 0
> >       rx_missed_errors: 2431910
> >          RX errors 0  dropped 2431953  overruns 0  frame 0
> >       rx_missed_errors: 2437266
> >          RX errors 0  dropped 2437309  overruns 0  frame 0
> >       rx_missed_errors: 2443305
> >          RX errors 0  dropped 2443348  overruns 0  frame 0
> >       rx_missed_errors: 2448357
> >          RX errors 0  dropped 2448400  overruns 0  frame 0
> >       rx_missed_errors: 2452539
> >          RX errors 0  dropped 2452582  overruns 0  frame 0
> >
> > We did a git bisect and we’ve found that the following commit generates the high number of dropped packets:
> >
> > Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com <mailto:rafael.j.wysocki@intel.com>>
> > Date:   Thu Apr 5 19:12:43 2018 +0200
> >      cpuidle: menu: Avoid selecting shallow states with stopped tick
> >      If the scheduler tick has been stopped already and the governor
> >      selects a shallow idle state, the CPU can spend a long time in that
> >      state if the selection is based on an inaccurate prediction of idle
> >      time.  That effect turns out to be relevant, so it needs to be
> >      mitigated.
> >      To that end, modify the menu governor to discard the result of the
> >      idle time prediction if the tick is stopped and the predicted idle
> >      time is less than the tick period length, unless the tick timer is
> >      going to expire soon.
> >      Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com <mailto:rafael.j.wysocki@intel.com>>
> >      Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org <mailto:peterz@infradead.org>>
> > diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> > index 267982e471e0..1bfe03ceb236 100644
> > --- a/drivers/cpuidle/governors/menu.c
> > +++ b/drivers/cpuidle/governors/menu.c
> > @@ -352,13 +352,28 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> >           */
> >          data->predicted_us = min(data->predicted_us, expected_interval);
> > -       /*
> > -        * Use the performance multiplier and the user-configurable
> > -        * latency_req to determine the maximum exit latency.
> > -        */
> > -       interactivity_req = data->predicted_us / performance_multiplier(nr_iowaiters, cpu_load);
> > -       if (latency_req > interactivity_req)
> > -               latency_req = interactivity_req;
> 
> The tick_nohz_tick_stopped() check may be done after the above and it 
> may be reworked a bit.
> 
> I'll send a test patch to you shortly.

The patch is appended, but please note that it has been rebased by hand and
not tested.

Please let me know if it makes any difference.

And in the future please avoid pasting the entire kernel config to your
reports, that's problematic.

---
 drivers/cpuidle/governors/menu.c |   23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -308,18 +308,18 @@ static int menu_select(struct cpuidle_dr
 				get_typical_interval(data, predicted_us)) *
 				NSEC_PER_USEC;
 
-	if (tick_nohz_tick_stopped()) {
-		/*
-		 * If the tick is already stopped, the cost of possible short
-		 * idle duration misprediction is much higher, because the CPU
-		 * may be stuck in a shallow idle state for a long time as a
-		 * result of it.  In that case say we might mispredict and use
-		 * the known time till the closest timer event for the idle
-		 * state selection.
-		 */
-		if (data->predicted_us < TICK_USEC)
-			data->predicted_us = min_t(unsigned int, TICK_USEC,
-						   ktime_to_us(delta_next));
+	/*
+	 * If the tick is already stopped, the cost of possible short idle
+	 * duration misprediction is much higher, because the CPU may be stuck
+	 * in a shallow idle state for a long time as a result of it.  In that
+	 * case, say we might mispredict and use the known time till the closest
+	 * timer event for the idle state selection, unless that event is going
+	 * to occur within the tick time frame (in which case the CPU will be
+	 * woken up from whatever idle state it gets into soon enough anyway).
+	 */
+	if (tick_nohz_tick_stopped() && data->predicted_us < TICK_USEC &&
+	    delta_next >= TICK_NSEC) {
+		data->predicted_us = ktime_to_us(delta_next);
 	} else {
 		/*
 		 * Use the performance multiplier and the user-configurable



