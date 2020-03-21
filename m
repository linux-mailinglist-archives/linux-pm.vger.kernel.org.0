Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A67118E51D
	for <lists+linux-pm@lfdr.de>; Sat, 21 Mar 2020 23:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgCUWVN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 21 Mar 2020 18:21:13 -0400
Received: from muru.com ([72.249.23.125]:32912 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727258AbgCUWVN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 21 Mar 2020 18:21:13 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 953FC810E;
        Sat, 21 Mar 2020 22:21:58 +0000 (UTC)
Date:   Sat, 21 Mar 2020 15:21:08 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     "Arthur D." <spinal.by@gmail.com>
Cc:     Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>,
        sre@kernel.org, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 06/15] power: supply: cpcap-battery: Initialize with user
 provided data
Message-ID: <20200321222108.GX37466@atomide.com>
References: <20200315151206.30909-1-spinal.by@gmail.com>
 <20200315151206.30909-6-spinal.by@gmail.com>
 <20200321145405.GW37466@atomide.com>
 <op.0huns9h5hxa7s4@supervisor.net28>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.0huns9h5hxa7s4@supervisor.net28>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Arthur D. <spinal.by@gmail.com> [200321 22:09]:
> Hi.
> 
> > Hmm I'm getting -EINVAL when I do echo 1600000 > charge_now but yet the
> > value does get updated?
> 
> Hm. I'm getting "Permission denied" when trying to do this.
> Anyway, charge_now value is not supposed to be initialized by the user.
> Only charge_full should be writable.

Sorry I meant writing to charge_full :) Anyways, looks like echo -n works
with no errors:

# echo 1305000 > charge_full
bash: echo: write error: Invalid argument
# echo -n 1305000 > charge_full

> > And I'm still not seeing capacity show up after that though even with
> > full battery.. I think we should be able to calculate it if either a
> > high or
> > low value has been seen?
> 
> There are two steps needed to calibrate the battery: to hit the "fully
> charged"
> state and to hit "battery empty" state. When the both states were hit the
> driver
> will initialize charge_full value. And it will start reporting correct
> charge_now
> and capacity (battery charge percentage) values.

Hmm OK. So far no luck triggering that though.

> Once the charge_full value is calculated it's recommended to be saved by the
> user
> to a permanent storage between reboots.
> 
> Saving/restoring the value can be done in init scripts.
> 
> For saving the calibration value just use the command like:
> cat /sys/class/power_supply/battery/charge_full > /battery_cf
> 
> To restore (after device reboot or power on):
> cat /battery_cf > /sys/class/power_supply/battery/charge_full

OK

> This will allow the kernel to do fast calibration. I.e. you will
> only need to fully charge _OR_ fully discharge the battery to start
> seeing correct charge_now and capacity values.

OK

> > Also, we should have the driver default to using the charge_full_design
> > value if nothing is written from userspace and we see a high or low
> > value.
> 
> I'd prefer to have charge_full value undefined until the battery is
> calibrated.
> This way the userspace can estimate current battery capacity using voltage
> as a
> fallback for uncalibrated battery. The voltage estimation will be  way more
> accurate than having charge_full = charge_full_design on pretty old Droid 4
> batteries. For example, my battery after calibration has about 1000 mAh,
> while charge_full_design is 1740000.

OK

> > Maybe some pessimistic estimate could be used instead of just using
> > charge_full_design if no value is initialized from the userspace?
> > Something like (charge_full_design / 4) * 3 maybe?
> 
> It's better to rely on voltage estimated percentage.
> In Maemo Leste we patched upower to use the following formula, which gives
> pretty
> good results:
> 
> percentage = (voltage - voltage_empty) / (voltage_full - voltage_empty) *
> 100
> 
> Actually, the formula we use is a bit more complicated.

OK

> If you're curious, here's how it's actually done:
> https://github.com/maemo-leste/upower/blob/master/src/linux/up-device-supply.c#L756

Thanks, I'll give the calibration another try. Maybe I did not wait low
enough, I think I went down to 3.3V.

Regards,

Tony
