Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470842C8D08
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 19:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbgK3SlN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 13:41:13 -0500
Received: from mga04.intel.com ([192.55.52.120]:50761 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbgK3SlN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Nov 2020 13:41:13 -0500
IronPort-SDR: fHZTW5Cr+3BVT1mMo++LBjAAL2lEndh8GVZwc9V6BmyVKJ2vfrjFCh4Li+7z+PAxK+5sx6SgRo
 3aShGJ0BgIhw==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="170124485"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="170124485"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 10:39:18 -0800
IronPort-SDR: msdywq7HqrNzT1Hb5ew0nb3WdQsbUFcBqRZZnlMw0NTddmC3lKbUAR/NXDbqIhHPtnwNK9ZcVY
 6UAXf2JmV+2g==
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="364356541"
Received: from nathanhs-mobl1.amr.corp.intel.com ([10.209.72.72])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 10:39:18 -0800
Message-ID: <f863f2e1e322a8819c660f5eefbbc4acf7522990.camel@linux.intel.com>
Subject: Re: [PATCH 1/3] thermal: core: Add indication for userspace usage
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, amitk@kernel.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Mon, 30 Nov 2020 10:39:17 -0800
In-Reply-To: <D53454A1-5ED0-4B4D-B22F-8663C9970ECD@canonical.com>
References: <20201128175450.12456-1-kai.heng.feng@canonical.com>
         <004fe225-1009-06d8-b297-c03a4c67550f@linaro.org>
         <860126B8-1152-4EE3-B15E-B4E45EFE879F@canonical.com>
         <fc67ad02826fb3adfd8457e1a0baf234a8fa3fce.camel@linux.intel.com>
         <34348B03-5E27-49A0-A704-6332BAC00758@canonical.com>
         <585bb5d3ee5bea063795682108576c3464ba72b6.camel@linux.intel.com>
         <D53454A1-5ED0-4B4D-B22F-8663C9970ECD@canonical.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2020-12-01 at 02:22 +0800, Kai-Heng Feng wrote:
> > On Dec 1, 2020, at 02:13, Srinivas Pandruvada <
> > srinivas.pandruvada@linux.intel.com> wrote:
> 
> [snipped] 
> 
> > > > What about creating an new callback
> > > > 
> > > > enum thermal_trip_status {
> > > > 	THERMAL_TRIP_DISABLED = 0,
> > > > 	THERMAL_TRIP_ENABLED,
> > > > };
> > > > 
> > > > int get_trip_status(struct thermal_zone_device *, int trip,
> > > > enum
> > > > thermal_trip_status *state);
> > > > 
> > > > Then in 
> > > > static void handle_thermal_trip(struct thermal_zone_device *tz,
> > > > int
> > > > trip)
> > > > {
> > > > 
> > > > /* before tz->ops->get_trip_temp(tz, trip, &trip_temp); */
> > > > if (tz->ops->get_trip_status) {
> > > > 	enum thermal_trip_status *status;
> > > > 
> > > > 	if (!tz->ops->get_trip_status(tz, trip, &status)) {
> > > > 		if (status == THERMAL_TRIP_DISABLED)
> > > > 			return;	
> > > > 	}
> > > > }
> > > > ...
> > > > ...
> > > > 
> > > > }
> > > > 
> > > > 
> > > > This callback will help the cases:
> > > > - Allows drivers to selectively disable certain trips during
> > > > init
> > > > state
> > > > or system resume where there can be spikes or always. int340x
> > > > drivers
> > > > can disable always.
> > > 
> > > This sounds really great. This is indeed can happen on system
> > > resume,
> > > before userspace process thaw.
> > > 
> > > > - Still give options for drivers to handle critical trip even
> > > > if
> > > > they
> > > > are bound to user space governors. User space process may be
> > > > dead,
> > > > so
> > > > still allow kernel to process graceful shutdown
> > > 
> > > To make the scenario happen, do we need a new sysfs to let
> > > usespace
> > > enable it with THERMAL_TRIP_ENABLED?
> > This should be drivers call not user space.
> 
> Understood. So after thermal_zone_device_register(), the driver can
> decide to what to return on get_trip_temp().
get_trip_status()

> Let me work on a new patch if there's no other concern.
Better to wait for confirmation from Daniel and others.

Thanks,
Srinivas

> 
> Kai-Heng
> 
> > Thanks,
> > Srinivas

