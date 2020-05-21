Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367911DDA33
	for <lists+linux-pm@lfdr.de>; Fri, 22 May 2020 00:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbgEUW0Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 May 2020 18:26:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:2767 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730381AbgEUW0P (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 21 May 2020 18:26:15 -0400
IronPort-SDR: mXppxR+o1pIIF+7uwP2cZyoXkhot2UJfE3eadQdON8bIbImSVUSrfLQkdWKYf+/qbo7wF5Mlhg
 waOpF5GUBxUg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 15:26:15 -0700
IronPort-SDR: 2mTeLmnU3/Kfnrn+4Xc/jiPTqnzmxEh1PYS/rDfrOfCo2vLWZaQXAdXO/hlBAk8F/jwtO1er++
 ltPXcl6+M1Jg==
X-IronPort-AV: E=Sophos;i="5.73,419,1583222400"; 
   d="scan'208";a="255431509"
Received: from spandruv-mobl.amr.corp.intel.com ([10.254.97.114])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 15:26:13 -0700
Message-ID: <939d1f9031fc4be6c0a8745938322d2722d977f1.camel@linux.intel.com>
Subject: Re: [RFC][PATCH 4/5] thermal: Add support for setting polling
 interval
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
        amit.kucheria@verdurent.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Date:   Thu, 21 May 2020 15:26:11 -0700
In-Reply-To: <3898cf1a-8e4c-def4-73f7-9ef4954e88b8@linaro.org>
References: <20200504181616.175477-1-srinivas.pandruvada@linux.intel.com>
         <20200504181616.175477-5-srinivas.pandruvada@linux.intel.com>
         <c2aad548-32c2-f008-5ce4-97b76a19271d@linaro.org>
         <b74767964b028c297840aefc166e2384333afd3b.camel@linux.intel.com>
         <3898cf1a-8e4c-def4-73f7-9ef4954e88b8@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2020-05-19 at 12:25 +0200, Daniel Lezcano wrote:
> On 19/05/2020 01:46, Srinivas Pandruvada wrote:
> > On Mon, 2020-05-18 at 18:51 +0200, Daniel Lezcano wrote:
> > > On 04/05/2020 20:16, Srinivas Pandruvada wrote:
> > > > Add new attribute in the thermal syfs for setting temperature
> > > > sampling
> > > > interval when CONFIG_THERMAL_USER_EVENT_INTERFACE is defined.
> > > > The
> > > > default
> > > > value is 0, which means no polling.
> > > > 
> > > > At this interval user space will get an event
> > > > THERMAL_TEMP_SAMPLE
> > > > with
> > > > temperature sample. This reuses existing polling mecahnism when
> > > > polling
> > > > or passive delay is specified during zone registry. To avoid
> > > > interference
> > > > with passive and polling delay, this new polling attribute
> > > > can't be
> > > > used
> > > > for those zones.
> > > 
> > > The userspace can get the temperature whenever it wants via the
> > > temperature file. The polling is designed for a specific hardware
> > > and
> > > the slope of the temperature graphic.
> > > 
> > > The userspace has the alternative of reading the temperature
> > > based on
> > > its own timer or wait for (and stick to) the thermal framework
> > > sampling
> > > rate. Adding a notification in the update is enough IMO.
> > > 
> > The problem with this approach is that the user can't change
> > sampling
> > interval. Those polling intervals are fixed during thermal-zone
> > register. Is there any way to change those defaults from user
> > space?
> 
> No, we can't but the userspace can decide when to read the
> temperature
> (via sysfs or netlink) and thus decide its own sampling rate.

Yes, if we poll for temperature from user space, no change is required
neighter netlink nor kfifo.

The average time to read CPU temperature and convert to int from sysfs
takes 45us vs 7us for push via Kfifo. I haven't looked at your patches
and checked this time. If it is comparable then netlink is better.


> 
> Otherwise, we are talking about an userspace governor, so the
> platform
> is setup with the desired sampling rate + userspace governor.
> 
> > Kernel can start with some long polling interval and user space can
> > change close to some trip.
> 
> Ok, let me rephrase it. This (big) comment encompass also patch 3/5.
> 
> I understood now the initial need of adding user trip points.
> 
> There are platforms where the interrupt mode does not exist so
> setting
> an user trip point does not set the interrupt for the closer
> temperature, hence we end up with a kernel sampling rate and in this
> case adding a trip point + new user sampling rate is pointless as the
> userspace can poll the temperature at its convenient rate.
> 
> If we summarize the different combinations we have:
> 
> 1. monitoring : interrupt mode, mitigation : interrupt mode
> 
> There are no thermal zone update until an interrupt fires. The
> mitigation is based on trip point crossed.

Yes. Basically daemon sleeps, till it gets a netlink notification
currently.

> 
> 2. monitoring : interrupt mode, mitigation : polling
> 
> There are no thermal zone update until an interrupt fires. The
> mitigation happens with a sampling rate specified with the polling
> rate.
> 
More complex than this. interrupt fires but it will fire flood for any
change (+/- around threshold) so after the first trigger, just disable
interrupt for an interval and start polling from user space as this is
more efficient.

> 3. monitoring : polling, mitigation : polling
> 
> The thermal zone is updated at the polling rate, the mitigation
> occurs
> with an update at the second polling rate.
> 
Yes.

> IIUC, the RFC proposes to add a new type of temperature threshold,
> followed a new polling rate to update the userspace.
> 
> IMHO, it is not a good thing to delegate to the kernel what the
> userspace can handle easily.
> 
> I suggest:
> 
>  - Not add another polling rate. If the thermal zone has a polling
> rate
> or supports the interrupt mode, then the user trip point setup
> succeed
> otherwise it fails and up to the userspace to read the temperature at
> its convenient rate. (Note multiple process may want to get
> temperature,
> so one should not set the rate of others).

Fine.

> 
>  - Not add another temp threshold structure but add a new trip type
> "user" and keep using the existing trip structures, so the
> notification
> can happen in the handle_trip_point function. The sysfs only reflects
> the setup via the "trip_point_x_hyst", "trip_point_0_temp",
> "trip_point_x_type"

Fine. It is better than what we re-purpose a passive trip currently.

> 
>  - Do not use sysfs for setup but rely on the genetlink for one
> message
> setup instead of multiple sysfs file writing. Adding a trip point
> will

Fine.

> 
> 
> What do you think?
Looks good.

Thanks,
Srinivas

> 
> 

