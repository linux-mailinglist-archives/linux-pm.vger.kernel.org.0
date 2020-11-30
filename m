Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325FB2C8949
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 17:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgK3QUt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 11:20:49 -0500
Received: from mga06.intel.com ([134.134.136.31]:2829 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728777AbgK3QUt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Nov 2020 11:20:49 -0500
IronPort-SDR: J03nhffHkvCe1Utx1HV+MCggcj6t2V/TwmNs34ZEF+NE224zoyZyzLqe2SJavGcNQUjbGQFG24
 KzGWB7jgumCg==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="234266660"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="234266660"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 08:19:07 -0800
IronPort-SDR: L0PQRAqSGYFpiLedealhnGJT1iDVIxcyAnwZlPAtbnfjVf9M8Ws3Qt5kkSKTH887shscwIYQhI
 2y6et7Nn7NRQ==
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="334714683"
Received: from nathanhs-mobl1.amr.corp.intel.com ([10.209.72.72])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 08:19:07 -0800
Message-ID: <fc67ad02826fb3adfd8457e1a0baf234a8fa3fce.camel@linux.intel.com>
Subject: Re: [PATCH 1/3] thermal: core: Add indication for userspace usage
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>, amitk@kernel.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Mon, 30 Nov 2020 08:19:07 -0800
In-Reply-To: <860126B8-1152-4EE3-B15E-B4E45EFE879F@canonical.com>
References: <20201128175450.12456-1-kai.heng.feng@canonical.com>
         <004fe225-1009-06d8-b297-c03a4c67550f@linaro.org>
         <860126B8-1152-4EE3-B15E-B4E45EFE879F@canonical.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2020-11-30 at 16:23 +0800, Kai-Heng Feng wrote:
> > On Nov 30, 2020, at 15:57, Daniel Lezcano <
> > daniel.lezcano@linaro.org> wrote:
> > 
> > 
> > [Added Srinivas]
> > 
> > On 28/11/2020 18:54, Kai-Heng Feng wrote:
> > > We are seeing thermal shutdown on Intel based mobile
> > > workstations, the
> > > shutdown happens during the first trip handle in
> > > thermal_zone_device_register():
> > > kernel: thermal thermal_zone15: critical temperature reached (101
> > > C), shutting down
> > > 
> > > However, we shouldn't do a thermal shutdown here, since
> > > 1) We may want to use a dedicated daemon, Intel's thermald in
> > > this case,
> > > to handle thermal shutdown.
> > > 
> > > 2) For ACPI based system, _CRT doesn't mean shutdown unless it's
> > > inside
> > > ThermalZone. ACPI Spec, 11.4.4 _CRT (Critical Temperature):
> > > "... If this object it present under a device, the device’s
> > > driver
> > > evaluates this object to determine the device’s critical cooling
> > > temperature trip point. This value may then be used by the
> > > device’s
> > > driver to program an internal device temperature sensor trip
> > > point."
> > > 
> > > So a "critical trip" here merely means we should take a more
> > > aggressive
> > > cooling method.
> > 
> > Well, actually it is stated before:
> > 
> > "This object, when defined under a thermal zone, returns the
> > critical
> > temperature at which OSPM must shutdown the system".
> 
> This means specifically for the ACPI ThermalZone in AML, e.g.:
> 
> ThermalZone (TZ0) {
> ....
>     Method(_CRT) { ... }
>  } // end of TZ0
> 
> However the device is not under any ACPI ThermalZone.
> 
> > That is what does the thermal subsystem, no ?
> > 
> > > So add an indication to let thermal core know it should leave
> > > thermal
> > > device to userspace to handle.
> > 
> > You may want to check the 'HOT' trip point and then use the
> > notification
> > mechanism to get notified in userspace and take action from there
> > (eg.
> > offline some CPUs).
> 
> For this particular issue we are facing, the thermal shutdown happens
> in thermal_zone_device_register() and userspace isn't up yet.

What about creating an new callback

enum thermal_trip_status {
	THERMAL_TRIP_DISABLED = 0,
	THERMAL_TRIP_ENABLED,
};

int get_trip_status(struct thermal_zone_device *, int trip, enum
thermal_trip_status *state);

Then in 
static void handle_thermal_trip(struct thermal_zone_device *tz, int
trip)
{

/* before tz->ops->get_trip_temp(tz, trip, &trip_temp); */
if (tz->ops->get_trip_status) {
	enum thermal_trip_status *status;

	if (!tz->ops->get_trip_status(tz, trip, &status)) {
		if (status == THERMAL_TRIP_DISABLED)
			return;	
	}
}
...
...

}


This callback will help the cases:
- Allows drivers to selectively disable certain trips during init state
or system resume where there can be spikes or always. int340x drivers
can disable always.
- Still give options for drivers to handle critical trip even if they
are bound to user space governors. User space process may be dead, so
still allow kernel to process graceful shutdown

Thanks,
Srinivas

> 
> Kai-Heng
> 
> > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > ---
> > > drivers/thermal/thermal_core.c | 3 +++
> > > include/linux/thermal.h        | 2 ++
> > > 2 files changed, 5 insertions(+)
> > > 
> > > diff --git a/drivers/thermal/thermal_core.c
> > > b/drivers/thermal/thermal_core.c
> > > index c6d74bc1c90b..6561e3767529 100644
> > > --- a/drivers/thermal/thermal_core.c
> > > +++ b/drivers/thermal/thermal_core.c
> > > @@ -1477,6 +1477,9 @@ thermal_zone_device_register(const char
> > > *type, int trips, int mask,
> > > 			goto unregister;
> > > 	}
> > > 
> > > +	if (tz->tzp && tz->tzp->userspace)
> > > +		thermal_zone_device_disable(tz);
> > > +
> > > 	mutex_lock(&thermal_list_lock);
> > > 	list_add_tail(&tz->node, &thermal_tz_list);
> > > 	mutex_unlock(&thermal_list_lock);
> > > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > > index d07ea27e72a9..e8e8fac78fc8 100644
> > > --- a/include/linux/thermal.h
> > > +++ b/include/linux/thermal.h
> > > @@ -247,6 +247,8 @@ struct thermal_zone_params {
> > > 	 */
> > > 	bool no_hwmon;
> > > 
> > > +	bool userspace;
> > > +
> > > 	int num_tbps;	/* Number of tbp entries */
> > > 	struct thermal_bind_params *tbp;
> > > 
> > > 
> > 
> > -- 
> > <http://www.linaro.org/> Linaro.org │ Open source software for ARM
> > SoCs
> > 
> > Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> > <http://twitter.com/#!/linaroorg> Twitter |
> > <http://www.linaro.org/linaro-blog/> Blog

