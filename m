Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42D4F181B14
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 15:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbgCKOXG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 10:23:06 -0400
Received: from muru.com ([72.249.23.125]:59766 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729531AbgCKOXG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Mar 2020 10:23:06 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C9D0E80CD;
        Wed, 11 Mar 2020 14:23:50 +0000 (UTC)
Date:   Wed, 11 Mar 2020 07:23:01 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     "Arthur D." <spinal.by@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Merlijn Wajer <merlijn@wizzup.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 1/3] RFC: power: supply: cpcap-battery: Add helper for
 rough capacity
Message-ID: <20200311142301.GV37466@atomide.com>
References: <20200119201124.29620-1-tony@atomide.com>
 <20200121095712.GC6934@amd>
 <db73a651-afc4-5c3d-0610-ccb13b8cc0d3@wizzup.org>
 <20200121222547.GA17712@duo.ucw.cz>
 <20200123160257.GX5885@atomide.com>
 <op.0g8ykrhnhxa7s4@supervisor.net28>
 <20200310153951.GR37466@atomide.com>
 <op.0g90lfcdhxa7s4@supervisor.net28>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.0g90lfcdhxa7s4@supervisor.net28>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Arthur D. <spinal.by@gmail.com> [200310 18:36]:
> Hi.
> 
> > > 1) RFC: power: supply: cpcap-battery: Add helper for rough capacity
> > > 
> > > CPCAP_CAP(POWER_SUPPLY_CAPACITY_LEVEL_FULL, 4200000 - 18000, 100)
> > > 
> > > This line seems wrong, because Droid4 full battery is 4.35V, not 4.2V.
> > 
> > Hmm yeah this is now configurable and defaults to 4.2V so we
> > should use the confgured value. The reason we default to 4.2V
> > now is because we suspect that if left connected to the charger
> > at higher than 4.2V the battery ages faster.
> 
> 1. How to configure this value? I tried:
> echo 4350000 > /sys/class/power_supply/battery/constant_charge_voltage
> 
> ...but it didn't change the fully charged battery voltage.

If you really want to use it, first enable it for the battery in
/sys/class/power/supply/usb to allow it, then also enable it for the
charger in /sys/class/power/supply/usb to actually use it.

But as discussed earlier, it really seems the battery ages faster at
the higher charge rates. Especially if left connected to the charger
for longer times as also seen with Android earlier.

> 2. If the value is configurable, it probably shouldn't be hardcoded like
> this in the code:
> PCAP_CAP(POWER_SUPPLY_CAPACITY_LEVEL_FULL, 4200000 - 18000, 100)

Right, we should now use the configured voltage :)

> > > I think the kernel should return  -ENODATA
> > > for capacity values until the battery is "calibrated". By "calibration"
> > > I mean having high and low counter_uah values initialized with the data
> > > collected when the battery went a full charge or discharge cycle (from
> > > empty to full or vice versa).
> > 
> > Yes I like this idea. That leaves out the need for poor estimates
> > in the kernel.
> > 
> > I guess we should have the following new properties:
> > 
> > POWER_SUPPLY_PROP_CHARGE_COUNTER_FULL
> > POWER_SUPPLY_PROP_CHARGE_COUNTER_EMPTY
> > 
> > And these would be 0 on boot and then userspace can
> > update these based on battery data.
> 
> My idea is to only have one extra property which will store the delta of
> counter values for full and empty battery states. In this case, it's going
> to be more accurate than allowing the userspace to store/restore both full
> and empty counters.

Hmm OK. Sounds like you might have some patches coming then?

> Some users may have a dual boot setup. In this case restoring full & empty
> counters after reboot can make the kernel to report wrong battery
> percentage
> values.

Yeah no idea how that is handled. Also changing the battery can cause
issues with this. I was expecting the 1-wire EEPROM to contain some
battery specific data like a serial number, but it seems this data is
the same for all the same type batteries.

> Let's imagine the following situation:
> 
> 1. The user charges the battery to the full state and discharges it to be
> almost depleted, so the kernel has "calibrated" values for counter_full and
> counter_empty.
> 2. The user decides to reboot to another OS. Let's assume he has a fully
> charged battery before doing the reboot.
> For example the kernel provides the following values:
> POWER_SUPPLY_PROP_CHARGE_COUNTER_FULL = -250000
> POWER_SUPPLY_PROP_CHARGE_COUNTER_EMPTY = 950000
> /sys/class/power_supply/battery/charge_counter = -250000
> A daemon saves these values to a permanent storage.
> 3. The user boots another OS, works there for a while, the battery charge
> becomes 50%.
> 4. The user reboots back to our system, we restore the values:
> POWER_SUPPLY_PROP_CHARGE_COUNTER_FULL <- -250000
> POWER_SUPPLY_PROP_CHARGE_COUNTER_EMPTY <- 950000
> 5. /sys/class/power_supply/battery/charge_counter is initialized to 0 or
> -250000, it doesn't matter, because in both cases we will get the wrong
> battery percentage. We should report 50%, remember? In any case it can't
> be calculated to this value.

Maybe some charge counter offset limit can be used to validate
the saved data in the userspace before updating values for kernel?

> And here's how I suggest it to be implemented:
> 1. Same as above
> 2. Same as above, except the kernel provides a single value that the user
> should store between reboots (it's the delta I mentioned above):
> POWER_SUPPLY_PROP_CHARGE_FULL = 1200000
> 3. Same as above
> 4. The user reboots back to our system, we restore the value:
> POWER_SUPPLY_PROP_CHARGE_FULL <- 1200000
> 5. The kernel reports -ENODATA as battery capacity value until the battery
> goes to a reference point (fully charged or almost discharged state).
> When the battery is fully charged or discharged, the kernel can immediately
> calculate the opposite counter value. And no matter what was the initial
> value of /sys/class/power_supply/battery/charge_counter when the system
> booted.
> 
> Of course, the value of the delta will not be constant, it should be
> recalculated over time. The good news is that this value will be changed
> slowly over time. That is, it can vary from 2% to 10% per year.

Sounds good to me :)

Tony
