Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A93022F67E
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 19:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbgG0RXh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 13:23:37 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:59756 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgG0RXg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 13:23:36 -0400
Received: from 89-64-87-33.dynamic.chello.pl (89.64.87.33) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 52252b58e7e4f51e; Mon, 27 Jul 2020 19:23:33 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Francisco Jerez <currojerez@riseup.net>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>
Subject: Re: [PATCH] cpufreq: intel_pstate: Implement passive mode with HWP enabled
Date:   Mon, 27 Jul 2020 19:23:32 +0200
Message-ID: <1712943.Luj0Z5seXe@kreacher>
In-Reply-To: <87h7u0h34t.fsf@riseup.net>
References: <3955470.QvD6XneCf3@kreacher> <babeff29a60d3fadb5515eaf57f7bb42a1c9c792.camel@linux.intel.com> <87h7u0h34t.fsf@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, July 22, 2020 1:14:42 AM CEST Francisco Jerez wrote:
> 
> --==-=-=
> Content-Type: multipart/mixed; boundary="=-=-="
> 
> --=-=-=
> Content-Type: text/plain; charset=utf-8
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
> 
> Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> writes:
> 
> > On Mon, 2020-07-20 at 16:20 -0700, Francisco Jerez wrote:
> >> "Rafael J. Wysocki" <rafael@kernel.org> writes:
> >>=20
> >> > On Fri, Jul 17, 2020 at 2:21 AM Francisco Jerez <
> >> > currojerez@riseup.net> wrote:
> >> > > "Rafael J. Wysocki" <rafael@kernel.org> writes:
> >> > >=20
> > {...]
> >
> >> > Overall, so far, I'm seeing a claim that the CPU subsystem can be
> >> > made
> >> > use less energy and do as much work as before (which is what
> >> > improving
> >> > the energy-efficiency means in general) if the maximum frequency of
> >> > CPUs is limited in a clever way.
> >> >=20
> >> > I'm failing to see what that clever way is, though.
> >> Hopefully the clarifications above help some.
> >
> > To simplify:
> >
> > Suppose I called a function numpy.multiply() to multiply two big arrays
> > and thread is a pegged to a CPU. Let's say it is causing CPU to
> > finish the job in 10ms and it is using a P-State of 0x20. But the same
> > job could have been done in 10ms even if it was using P-state of 0x16.
> > So we are not energy efficient. To really know where is the bottle neck
> > there are numbers of perf counters, may be cache was the issue, we
> > could rather raise the uncore frequency a little. A simple APRF,MPERF
> > counters are not enough.=20
> 
> Yes, that's right, APERF and MPERF aren't sufficient to identify every
> kind of possible bottleneck, some visibility of the utilization of other
> subsystems is necessary in addition -- Like e.g the instrumentation
> introduced in my series to detect a GPU bottleneck.  A bottleneck
> condition in an IO device can be communicated to CPUFREQ

It generally is not sufficient to communicate it to cpufreq.  It needs to be
communicated to the CPU scheduler.

> by adjusting a
> PM QoS latency request (link [2] in my previous reply) that effectively
> gives the governor permission to rearrange CPU work arbitrarily within
> the specified time frame (which should be of the order of the natural
> latency of the IO device -- e.g. at least the rendering time of a frame
> for a GPU) in order to minimize energy usage.

OK, we need to talk more about this.

> > or we characterize the workload at different P-states and set limits.
> > I think this is not you want to say for energy efficiency with your
> > changes.=20
> >
> > The way you are trying to improve "performance" is by caller (device
> > driver) to say how important my job at hand. Here device driver suppose
> > offload this calculations to some GPU and can wait up to 10 ms, you
> > want to tell CPU to be slow. But the p-state driver at a movement
> > observes that there is a chance of overshoot of latency, it will
> > immediately ask for higher P-state. So you want P-state limits based on
> > the latency requirements of the caller. Since caller has more knowledge
> > of latency requirement, this allows other devices sharing the power
> > budget to get more or less power, and improve overall energy efficiency
> > as the combined performance of system is improved.
> > Is this correct?
> 
> Yes, pretty much.

OK



