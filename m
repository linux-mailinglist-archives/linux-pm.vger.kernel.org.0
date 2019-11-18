Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE46100F4B
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2019 00:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfKRXKJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 18:10:09 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:47618 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfKRXKF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 18:10:05 -0500
Received: from 79.184.253.244.ipv4.supernova.orange.pl (79.184.253.244) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id bde311d14881fd19; Tue, 19 Nov 2019 00:10:02 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Len Brown <lenb@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Doug Smythies <dsmythies@telus.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH 0/2] cpuidle: Allow states to be disabled by default (was: Re: [PATCH] cpuidle: Consolidate disabled state checks)
Date:   Tue, 19 Nov 2019 00:04:59 +0100
Message-ID: <1688511.GgkECGP1XA@kreacher>
In-Reply-To: <CAJZ5v0jsQG37VF3-tiSndE0pXX9jEfgucm0UyvpM0bsyoOcpuA@mail.gmail.com>
References: <2717750.dCEzHT3DVQ@kreacher> <CAJZ5v0ifOQaOm-8n5gUgud0sCn-Y1KQWWhzhtzdm+exvMLgL7Q@mail.gmail.com> <CAJZ5v0jsQG37VF3-tiSndE0pXX9jEfgucm0UyvpM0bsyoOcpuA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, November 18, 2019 12:26:57 PM CET Rafael J. Wysocki wrote:
> On Mon, Nov 18, 2019 at 10:22 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Mon, Nov 18, 2019 at 5:46 AM Len Brown <lenb@kernel.org> wrote:
> > >
> > > On Mon, Nov 4, 2019 at 6:16 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > >
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > There are two reasons why CPU idle states may be disabled: either
> > > > because the driver has disabled them or because they have been
> > > > disabled by user space via sysfs.
> > > >
> > > > In the former case, the state's "disabled" flag is set once during
> > > > the initialization of the driver and it is never cleared later (it
> > > > is read-only effectively).
> > >
> > > for x86 (intel_idle and acpi_idle), no states with disabled=1 are  registered
> > > with cpuidle.  Instead, intel_idle (currently) skips them in the loop
> > > that registers states.
> > > (and acpi_idle never touches the disabled field)
> > >
> > > And so for x86, governors checking for drv->states[i].disabled is a NOP,
> > > and the condition described by CPUIDLE_STATE_DISABLED_BY_DRIVER
> > > does not (yet) exist.
> >
> > OK
> >
> > > Looking at the ARM code, it seems that cpuidle-imx6q.c and cpuidle-tegra20.c
> > > reach into the cpuidle states at run time and toggle the
> > > drv->states[i].disabled.
> >
> > I might have overlooked that, let me check.
> >
> > > It seems that this patch takes the initial value of
> > > drv->states->disabled, and sets the (per cpu)
> > > usage.disable=..BY_DRIVER,
> > > but that subsequent run-time toggles in drv->states[i]disabled by
> > > these drivers would be missed,
> > > because you're removed the run-time checking of drv->states->disabled?
> >
> > If it is updated at run time, then yes, the updates will be missed, so
> > thanks for pointing that out.
> >
> > > Finally, I'd like to change intel_idle so that it *can* register a
> > > state that is disabled, by default.
> > > If I change the driver to NOT skip registering disabled states, and
> > > the cpuidle copy has cpuidle_state.disabled=1,
> > > then the state is indeed, unused at run-time.  But as you said,
> > > it is effectively read-only, and is not indicated in sysfs, and can
> > > not be changed via sysfs.
> > >
> > > One way to do this is to do what you do here and initialize
> > > usage.disabled to drv->state.disabled. (not distinguishing between
> > > DRIVER and USER)
> > > That way the user could later over-ride what a driver set, by clearing
> > > the disabled attribute.
> 
> I'd rather get rid of the "disabled" field from struct cpuidle_state
> entirely and introduce a new state flag to indicate the "disabled by
> default" status.
> 
> I also would expose that new flag in a new sysfs attribute of idle
> states, say "disable_default".
> 
> Then, the DISABLED_BY_DRIVER bit would be reserved for driver quirks
> (as per https://patchwork.kernel.org/patch/11249519/) and the
> DISABLED_BY_USER one could be used for all of the other purposes.

To that end, I have the following two experimental patches (on top of
https://patchwork.kernel.org/patch/11249519/) that IMO are simple
enough.

Please let me know what you think.



