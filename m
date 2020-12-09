Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC6F2D467F
	for <lists+linux-pm@lfdr.de>; Wed,  9 Dec 2020 17:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbgLIQM1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Dec 2020 11:12:27 -0500
Received: from mga05.intel.com ([192.55.52.43]:30298 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730081AbgLIQM0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 9 Dec 2020 11:12:26 -0500
IronPort-SDR: ZUZhSwBj58owCjspooXt/wBA5BfbA/5Zo7jzDbCCRD8yuKf/8x1qmLi6qT7w9B03Y87UMONLbs
 SGKdj5DdtIPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="258810056"
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="258810056"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 08:10:36 -0800
IronPort-SDR: ww9NHfQf5V6acgeqJE3kUaCu4k84aFN82QRBbyDjam1rF/czIY8BAH/SfQzx1nOkv5Rh00zvKG
 AvFvLRlWOBhQ==
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="542442728"
Received: from jtholmen-mobl2.amr.corp.intel.com ([10.212.122.32])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 08:10:35 -0800
Message-ID: <5dc6ca9bf2bcb887ca21041bad60f5e9c461df88.camel@linux.intel.com>
Subject: Re: [PATCH 1/3] thermal: core: Add indication for userspace usage
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Zhang Rui <rui.zhang@intel.com>, amitk@kernel.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Wed, 09 Dec 2020 08:10:35 -0800
In-Reply-To: <4767b493-fa24-e294-66df-3989b72bfb01@linaro.org>
References: <20201128175450.12456-1-kai.heng.feng@canonical.com>
         <004fe225-1009-06d8-b297-c03a4c67550f@linaro.org>
         <860126B8-1152-4EE3-B15E-B4E45EFE879F@canonical.com>
         <fc67ad02826fb3adfd8457e1a0baf234a8fa3fce.camel@linux.intel.com>
         <34348B03-5E27-49A0-A704-6332BAC00758@canonical.com>
         <585bb5d3ee5bea063795682108576c3464ba72b6.camel@linux.intel.com>
         <D53454A1-5ED0-4B4D-B22F-8663C9970ECD@canonical.com>
         <f863f2e1e322a8819c660f5eefbbc4acf7522990.camel@linux.intel.com>
         <FCFE1F21-2EC6-4D3A-8B2E-32C653816D58@canonical.com>
         <4767b493-fa24-e294-66df-3989b72bfb01@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2020-12-09 at 10:30 +0100, Daniel Lezcano wrote:
> On 07/12/2020 06:36, Kai-Heng Feng wrote:
> > 
> > > On Dec 1, 2020, at 02:39, Srinivas Pandruvada <
> > > srinivas.pandruvada@linux.intel.com> wrote:
> > > 
> > > On Tue, 2020-12-01 at 02:22 +0800, Kai-Heng Feng wrote:
> > > > > On Dec 1, 2020, at 02:13, Srinivas Pandruvada <
> > > > > srinivas.pandruvada@linux.intel.com> wrote:
> > > > 
> > > > [snipped] 
> > > > 
> > > > > > > What about creating an new callback
> > > > > > > 
> > > > > > > enum thermal_trip_status {
> > > > > > > 	THERMAL_TRIP_DISABLED = 0,
> > > > > > > 	THERMAL_TRIP_ENABLED,
> > > > > > > };
> > > > > > > 
> > > > > > > int get_trip_status(struct thermal_zone_device *, int
> > > > > > > trip,
> > > > > > > enum
> > > > > > > thermal_trip_status *state);
> > > > > > > 
> > > > > > > Then in 
> > > > > > > static void handle_thermal_trip(struct
> > > > > > > thermal_zone_device *tz,
> > > > > > > int
> > > > > > > trip)
> > > > > > > {
> > > > > > > 
> > > > > > > /* before tz->ops->get_trip_temp(tz, trip, &trip_temp);
> > > > > > > */
> > > > > > > if (tz->ops->get_trip_status) {
> > > > > > > 	enum thermal_trip_status *status;
> > > > > > > 
> > > > > > > 	if (!tz->ops->get_trip_status(tz, trip, &status)) {
> > > > > > > 		if (status == THERMAL_TRIP_DISABLED)
> > > > > > > 			return;	
> > > > > > > 	}
> > > > > > > }
> > > > > > > ...
> > > > > > > ...
> > > > > > > 
> > > > > > > }
> > > > > > > 
> > > > > > > 
> > > > > > > This callback will help the cases:
> > > > > > > - Allows drivers to selectively disable certain trips
> > > > > > > during
> > > > > > > init
> > > > > > > state
> > > > > > > or system resume where there can be spikes or always.
> > > > > > > int340x
> > > > > > > drivers
> > > > > > > can disable always.
> > > > > > 
> > > > > > This sounds really great. This is indeed can happen on
> > > > > > system
> > > > > > resume,
> > > > > > before userspace process thaw.
> > > > > > 
> > > > > > > - Still give options for drivers to handle critical trip
> > > > > > > even
> > > > > > > if
> > > > > > > they
> > > > > > > are bound to user space governors. User space process may
> > > > > > > be
> > > > > > > dead,
> > > > > > > so
> > > > > > > still allow kernel to process graceful shutdown
> > > > > > 
> > > > > > To make the scenario happen, do we need a new sysfs to let
> > > > > > usespace
> > > > > > enable it with THERMAL_TRIP_ENABLED?
> > > > > This should be drivers call not user space.
> > > > 
> > > > Understood. So after thermal_zone_device_register(), the driver
> > > > can
> > > > decide to what to return on get_trip_temp().
> > > get_trip_status()
> > > 
> > > > Let me work on a new patch if there's no other concern.
> > > Better to wait for confirmation from Daniel and others.
> > 
> > Daniel,
> > 
> > Do you like Srinivas' proposed solution?
> > 
> > I hope we can find a solution in upstream kernel soon.
> 
> (just trying to figure out the full context)
> 
> If the device is enumerated outside of a thermal zone, the sensor
> should
> not register in the thermal zone no ?

Other trips are fine, so sensor registry is still required for passive
and active control. We just need to ignore critical trip. These table
are tested by OEM on Windows, where critical trip doesn't result in
immediate shutdown.

Thanks,
Srinivas

> 
> 
> 

