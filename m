Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99BBB1A4E01
	for <lists+linux-pm@lfdr.de>; Sat, 11 Apr 2020 06:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbgDKElQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 Apr 2020 00:41:16 -0400
Received: from mga03.intel.com ([134.134.136.65]:55809 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbgDKElP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 11 Apr 2020 00:41:15 -0400
IronPort-SDR: XvaNCi8jvoaU5iBjxbbu0VlSJSxdTAQVEfEjXwmuwDrgut7GJ5JFiwZrGGZxgmZKjjbB4HOh4H
 ULauEW+G+9iw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2020 21:41:15 -0700
IronPort-SDR: 9MC8fK50hTCcg51QFiF65H6ibAZlHg8FYvV1LPstK0L+U2M5pvfx3YEbdHvu2ouoZznMuaONnF
 3+H591UlhPeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,368,1580803200"; 
   d="scan'208";a="452596428"
Received: from lzhao24-mobl.ccr.corp.intel.com ([10.255.29.254])
  by fmsmga005.fm.intel.com with ESMTP; 10 Apr 2020 21:41:13 -0700
Message-ID: <491698e05abba0f2f11488ae070a1b3cc6ec1750.camel@intel.com>
Subject: Re: [RFC PATCH 5/5] ACPI: processor: do update when maximum cooling
 state changed
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.de>,
        Viresh Kumar <viresh.kumar@linaro.org>
Date:   Sat, 11 Apr 2020 12:41:12 +0800
In-Reply-To: <CAJZ5v0hocQ8Y58hzf0qdW0F_E=c7TPBwL2SV3veAYL0x25d4Zg@mail.gmail.com>
References: <20200408041917.2329-1-rui.zhang@intel.com>
         <20200408041917.2329-5-rui.zhang@intel.com>
         <5cd80df7-775e-96bd-cec5-b14965de2a67@linaro.org>
         <2bef9553fcf7ccd7c9811ad1d572af2e5a811917.camel@intel.com>
         <CAJZ5v0hocQ8Y58hzf0qdW0F_E=c7TPBwL2SV3veAYL0x25d4Zg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2020-04-10 at 16:10 +0200, Rafael J. Wysocki wrote:
> On Fri, Apr 10, 2020 at 10:02 AM Zhang Rui <rui.zhang@intel.com>
> wrote:
> > 
> > On Thu, 2020-04-09 at 15:34 +0200, Daniel Lezcano wrote:
> > > Hi Rui,
> > > 
> > > 
> > > On 08/04/2020 06:19, Zhang Rui wrote:
> > > > ACPI processor cooling device supports 1 cooling state before
> > > > cpufreq
> > > > driver probed, and 4 cooling states after cpufreq driver
> > > > probed.
> > > 
> > > What is this one state ?
> > 
> > One state means its original state and we can not set it to others.
> > 
> > ACPI processor cooling states are combined of p-state cooling
> > states
> > and a couple of optional t-state cooling states.
> > 
> > Say, if we have a processor device supports 7 throttling states, it
> > actually supports 8 cooling states with cpufreq driver unprobed,
> > and 11
> > cooling states with cpufreq driver probed.
> > 
> > > 
> > > > Thus update the statistics table when the cpufeq driver is
> > > > probed/unprobed.
> > > 
> > > To be honest, the series seems to skirt a problem in the acpi
> > > processor.
> > > 
> > > If there is a new policy, then there is a new cooling device. Why
> > > not
> > > unregister the old one and register the new one ?
> > > 
> > 
> > Good point.
> > IMO, the real problem is that do we support dynamic
> > max_cooling_state
> > or not in the thermal framework.
> > Previously, I thought we don't have a hard rule of static
> > max_cooling_state because we always invoke .get_max_state()
> > callback
> > when we need it. But after a second thought, actually we do have
> > this
> > limitation. For example, when binding cooling devices to thermal
> > zones,
> > the upper limit is set based on the return value of
> > .get_max_state() at
> > the binding time, and we never update the upper limit later.
> > So this ACPI processor issue is not just about statistics table
> > update
> > issue, we actually lose some of its cooling states.
> > 
> > Thus, a new max_state means that all the previous setting of the
> > cooling_device, i.e. all the thermal instances of the cooling
> > device,
> > needs to get updated.
> > 
> > And to fix this, it's better to
> > a. unregister and re-register the cooling device as you suggested.
> > or
> > b. introduce an API that updates the cooling device entirely
> > instead of
> > statistics table only.
> > 
> > For either of the above solutions, we'd better to cleanup the code
> > to
> > invoke .get_max_state() during registration/max_state_reset phase,
> > once, and then always use cached value later.
> > And plus, if we want to follow solution a), it's better to remove
> > .get_max_state() callback and use an integer instead so that every
> > driver knows this limitation.
> > I'd vote for solution a) if there is no soc thermal driver that may
> > return dynamic max_states.
> 
> I believe I mentioned one more option, which would be to introduce an
> optional callback into struct thermal_cooling_device_ops to return
> the
> maximum possible return value of .get_max_state(), say
> .get_max_state_limit().  That would be used for the allocation of the
> stats table and the drivers where the .get_max_state() return value
> could not change might set the new callback to NULL.
> 

For a dynamic max_state cooling device, now the problem is not just
about the statistics table.
Take the ACPI processor cooling device for example, we set its internal
limit based on the return value of .get_max_state() during the cooling
device registration, thus if it returns 1, actually we can not use deep
cooling state later at all.

Plus, when a max_state changed, the meaning of each cooling state may
also actually changed. Say, for ACPI processor, cooling state 2 means
60% of max_freq with cpufreq driver, but means ACPI processor T2
throttle state with cpuferq driver unprobed.

That says, if we don't do a full unregistration and registration in
this case, at least we need to keep the device node but re-evaluate
.get_max_state() and update all its thermal instances, as long as the
statistics table change.

thanks,
rui
> Then, upon a change of the .get_max_state() return value, the driver
> providing it would be responsible for rearranging the stats to
> reflect
> the new set of available states.
> 
> Cheers!

