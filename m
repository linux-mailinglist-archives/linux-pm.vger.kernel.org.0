Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06DE11A5D00
	for <lists+linux-pm@lfdr.de>; Sun, 12 Apr 2020 08:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgDLGNz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Apr 2020 02:13:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:51445 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgDLGNz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 12 Apr 2020 02:13:55 -0400
IronPort-SDR: jLg5m848YJMNeL9nmPXnkw56qoCwn+dChfOXgBO5dmjQGuRURKtAwM0AoFHK+Sv2geDQ76QsUn
 nYHbw1t1cvAw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2020 23:13:55 -0700
IronPort-SDR: nXrO0ceQg8CdXZRzHi6uO7d0ZKiJMyl3YPMynmeQvnXDMPnt1yhKK2IN4A40srpYushslUXMXd
 JyICsmnoJHMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,373,1580803200"; 
   d="scan'208";a="399313178"
Received: from mengling-mobl.ccr.corp.intel.com ([10.255.29.65])
  by orsmga004.jf.intel.com with ESMTP; 11 Apr 2020 23:13:53 -0700
Message-ID: <fee68438572796c71089571e0ff0add6cbbd3e0c.camel@intel.com>
Subject: Re: [RFC PATCH 5/5] ACPI: processor: do update when maximum cooling
 state changed
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     tiwai@suse.de, viresh.kumar@linaro.org
Date:   Sun, 12 Apr 2020 14:13:52 +0800
In-Reply-To: <a15dee60-8d20-0f56-0037-276830c613cd@linaro.org>
References: <20200408041917.2329-1-rui.zhang@intel.com>
         <20200408041917.2329-5-rui.zhang@intel.com>
         <5cd80df7-775e-96bd-cec5-b14965de2a67@linaro.org>
         <2bef9553fcf7ccd7c9811ad1d572af2e5a811917.camel@intel.com>
         <a15dee60-8d20-0f56-0037-276830c613cd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2020-04-10 at 14:10 +0200, Daniel Lezcano wrote:
> On 10/04/2020 10:02, Zhang Rui wrote:
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
> > 
> > Do I still miss something?
> 
> I agree for the a) solution too.
> 
> But regarding the get_max_state() callback being converted to a
> integer,
> the driver int3406_thermal.c computes the upper and lower limits
> which
> are updated on a INT3406_BRIGHTNESS_LIMITS_CHANGED notification and
> get_max_state() does uppper - lower.

Right, this is another case shows that it's better to support dynamic
max_state.
IMO, this is not difficult to do. We just need to introduce a new API,
which reuses the current cdev device, and reset its every thermal
instance, and update all the thermal zones the cdev is involved.
what do you think?

thanks,
rui

