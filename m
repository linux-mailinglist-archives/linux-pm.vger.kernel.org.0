Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5007723DD4A
	for <lists+linux-pm@lfdr.de>; Thu,  6 Aug 2020 19:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbgHFRHc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Aug 2020 13:07:32 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:63876 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729728AbgHFRGl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Aug 2020 13:06:41 -0400
Received: from 89-64-86-116.dynamic.chello.pl (89.64.86.116) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id a0952d0a893f35a5; Thu, 6 Aug 2020 13:39:54 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        'Linux Documentation' <linux-doc@vger.kernel.org>,
        'LKML' <linux-kernel@vger.kernel.org>,
        'Peter Zijlstra' <peterz@infradead.org>,
        'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>,
        'Giovanni Gherdovich' <ggherdovich@suse.cz>,
        'Francisco Jerez' <francisco.jerez.plata@intel.com>,
        'Linux PM' <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: intel_pstate: Implement passive mode with HWP enabled
Date:   Thu, 06 Aug 2020 13:39:53 +0200
Message-ID: <5275102.Ez0hqPNOlg@kreacher>
In-Reply-To: <004601d66bb6$199ce1a0$4cd6a4e0$@net>
References: <3955470.QvD6XneCf3@kreacher> <2418846.A4mPlhI7ni@kreacher> <004601d66bb6$199ce1a0$4cd6a4e0$@net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, August 6, 2020 7:54:47 AM CEST Doug Smythies wrote:
> On 2020.08.03 10:09 Rafael J. Wysocki wrote:
> > On Sunday, August 2, 2020 5:17:39 PM CEST Doug Smythies wrote:
> > > On 2020.07.19 04:43 Rafael J. Wysocki wrote:
> > > > On Fri, Jul 17, 2020 at 3:37 PM Doug Smythies <dsmythies@telus.net> wrote:
> > > > > On 2020.07.16 05:08 Rafael J. Wysocki wrote:
> > > > > > On Wed, Jul 15, 2020 at 10:39 PM Doug Smythies <dsmythies@telus.net> wrote:
> > > > > >> On 2020.07.14 11:16 Rafael J. Wysocki wrote:
> > > > > >> >
> > > > > >> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > >> ...
> > > > > >> > Since the passive mode hasn't worked with HWP at all, and it is not going to
> > > > > >> > the default for HWP systems anyway, I don't see any drawbacks related to making
> > > > > >> > this change, so I would consider this as 5.9 material unless there are any
> > > > > >> > serious objections.
> > > > > >>
> > > > > >> Good point.
> > > > >
> > > > > Actually, for those users that default to passive mode upon boot,
> > > > > this would mean they would find themselves using this.
> > > > > Also, it isn't obvious, from the typical "what driver and what governor"
> > > > > inquiry.
> > > >
> > > > So the change in behavior is that after this patch
> > > > intel_pstate=passive doesn't imply no_hwp any more.
> > > >
> > > > That's a very minor difference though and I'm not aware of any adverse
> > > > effects it can cause on HWP systems anyway.
> > >
> > > My point was, that it will now default to something where
> > > testing has not been completed.
> > >
> > > > The "what governor" is straightforward in the passive mode: that's
> > > > whatever cpufreq governor has been selected.
> > >
> > > I think you might have missed my point.
> > > From the normal methods of inquiry one does not know
> > > if HWP is being used or not. Why? Because with
> > > or without HWP one gets the same answers under:
> > >
> > > /sys/devices/system/cpu/cpu*/cpufreq/scaling_driver
> > > /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
> > 
> > Yes, but this is also the case in the active mode, isn't it?
> 
> Yes, fair enough.
> But we aren't changing what it means by default
> between kernel 5.8 and 5.9-rc1.

No, we aren't.

The only (expected) change is when booting with intel_pstate=passive and
without intel_pstate=no_hwp in the command line.

Which should be easy enough to address by adding intel_pstate=no_hwp to the
command line in 5.9-rc1 and later (to achieve the same behavior after a
fresh boot).

Cheers!



