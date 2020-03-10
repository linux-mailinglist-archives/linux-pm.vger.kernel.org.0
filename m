Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57A6618020D
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 16:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgCJPjz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 11:39:55 -0400
Received: from muru.com ([72.249.23.125]:59498 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgCJPjz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Mar 2020 11:39:55 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id BA38D810A;
        Tue, 10 Mar 2020 15:40:40 +0000 (UTC)
Date:   Tue, 10 Mar 2020 08:39:51 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     "Arthur D." <spinal.by@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Merlijn Wajer <merlijn@wizzup.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 1/3] RFC: power: supply: cpcap-battery: Add helper for
 rough capacity
Message-ID: <20200310153951.GR37466@atomide.com>
References: <20200119201124.29620-1-tony@atomide.com>
 <20200121095712.GC6934@amd>
 <db73a651-afc4-5c3d-0610-ccb13b8cc0d3@wizzup.org>
 <20200121222547.GA17712@duo.ucw.cz>
 <20200123160257.GX5885@atomide.com>
 <op.0g8ykrhnhxa7s4@supervisor.net28>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.0g8ykrhnhxa7s4@supervisor.net28>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Arthur D. <spinal.by@gmail.com> [200310 04:55]:
> Hi, Tony.
> 
> I used the kernel with the patch serieas applied for a while.
> 
> What I expected from the userspace perspective was having
> /sys/class/power_supply/battery/capacity undefined until
> kernel calculates more or less accurate values for it.
> 
> Until then, the userspace should estimate percentage on its own
> using voltage and current values provided by the kernel.
> Like it's already done with bq27200 on Nokia N900.
> 
> Right now the values which the kernel provides with
> /sys/class/power_supply/battery/capacity after a system boot
> are confusing.

OK yeah I like the idea of not showing anything until userspace
as configured estimated high and low values.

> The user can see the battery plugin doesn't change its gauge
> gradually like it was done with previous kernel versions.
> Sometimes it gets suddenly empty, sometimes it changes from empty
> to half full. And it always reports "battery full" in advance -
> when the battery is being charged with relatively high current.
> 
> The following part of mail dedicated to what I think should be fixed
> in the commits.
> 
> 1) RFC: power: supply: cpcap-battery: Add helper for rough capacity
> 
> CPCAP_CAP(POWER_SUPPLY_CAPACITY_LEVEL_FULL, 4200000 - 18000, 100)
>
> This line seems wrong, because Droid4 full battery is 4.35V, not 4.2V.

Hmm yeah this is now configurable and defaults to 4.2V so we
should use the confgured value. The reason we default to 4.2V
now is because we suspect that if left connected to the charger
at higher than 4.2V the battery ages faster.

> 2.1) RFC: power: supply: cpcap-battery: Implement capacity percentage
> 
> val->intval = (ddata->config.info.charge_full_design - delta) * 100;
> val->intval /= ddata->config.info.charge_full_design;
> 
> IMHO, charge_full_design should never be used in battery charge
> percentage calculations. Li-ion batteries loose their capacity
> with age. Therefore such calculations are likely to always be wrong.
> 
> I'd prefer to have the full charge value to be dynamically calculated by
> the kernel with a formula like this:
> charge_full = high->counter_uah - low->counter_uah;

OK makes sense. I guess we can assuem if both are set to the
the same number like 0 on boot, there's no estimate available.

> This which will give us accurate estimation for the battery charge, esti-
> mated time left on the battery and so on. It would be good, if we allow
> the userspace to store the full charge value between reboots and to feed
> it to the kernel after, so it could start providing accurated data faster:
> the battery should only go full or empty once and we are ready.

Yes userspace is the only place that can eventually generate accurate
estimate based on battery wear, temperature etc.

> I'd like to mention explicitly: I think the kernel should return -ENODATA
> for capacity values until the battery is "calibrated". By "calibration"
> I mean having high and low counter_uah values initialized with the data
> collected when the battery went a full charge or discharge cycle (from
> empty to full or vice versa).

Yes I like this idea. That leaves out the need for poor estimates
in the kernel.

I guess we should have the following new properties:

POWER_SUPPLY_PROP_CHARGE_COUNTER_FULL
POWER_SUPPLY_PROP_CHARGE_COUNTER_EMPTY

And these would be 0 on boot and then userspace can
update these based on battery data.

Regards,

Tony
