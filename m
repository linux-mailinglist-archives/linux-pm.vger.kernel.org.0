Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFFC22077B
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 10:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbgGOIfo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 04:35:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:19841 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729192AbgGOIfn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Jul 2020 04:35:43 -0400
IronPort-SDR: EjSidi9PFwBEqBOegvAGd8+vAoSfnYhIRlN3ZwzT3ASs3RCJ/n2SmC5Iwmm2jlNGaw34CaHKg0
 TaunBsvrGUIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="137234837"
X-IronPort-AV: E=Sophos;i="5.75,354,1589266800"; 
   d="scan'208";a="137234837"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 01:35:43 -0700
IronPort-SDR: wom4Vga3jcrql6t16qwoyNREtupcp1VXNFk8PTdDNTWT21FlEY3nuBl3p7s93G5W0Or1lhgm1D
 gc5c3v+2bDrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,354,1589266800"; 
   d="scan'208";a="459992091"
Received: from yren3-mobl.ccr.corp.intel.com ([10.249.174.224])
  by orsmga005.jf.intel.com with ESMTP; 15 Jul 2020 01:35:40 -0700
Message-ID: <d2eeca29328a87433a46c35947ffb490d49c168a.camel@intel.com>
Subject: Re: [RFC PATCH 4/4] thermal: Modify thermal governors to do nothing
 for "cold" trip points
From:   Zhang Rui <rui.zhang@intel.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>,
        daniel.lezcano@linaro.org, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 15 Jul 2020 16:35:39 +0800
In-Reply-To: <20200710135154.181454-5-thara.gopinath@linaro.org>
References: <20200710135154.181454-1-thara.gopinath@linaro.org>
         <20200710135154.181454-5-thara.gopinath@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2020-07-10 at 09:51 -0400, Thara Gopinath wrote:
> For now, thermal governors do not support monitoring of falling
> temperature. Hence, in case of calls to the governor for trip points
> marked
> as cold, return doing nothing.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  drivers/thermal/gov_bang_bang.c       | 8 ++++++++
>  drivers/thermal/gov_fair_share.c      | 8 ++++++++
>  drivers/thermal/gov_power_allocator.c | 8 ++++++++
>  drivers/thermal/gov_step_wise.c       | 8 ++++++++
>  4 files changed, 32 insertions(+)

userspace governor does not support cold trip point neither.

So how about adding the check in handle_non_critical_trips first, and
remove the check later, after all the governors support cold trip?

thanks,
rui
> 
> diff --git a/drivers/thermal/gov_bang_bang.c
> b/drivers/thermal/gov_bang_bang.c
> index 991a1c54296d..8324d13de1e7 100644
> --- a/drivers/thermal/gov_bang_bang.c
> +++ b/drivers/thermal/gov_bang_bang.c
> @@ -99,6 +99,14 @@ static void thermal_zone_trip_update(struct
> thermal_zone_device *tz, int trip)
>  static int bang_bang_control(struct thermal_zone_device *tz, int
> trip)
>  {
>  	struct thermal_instance *instance;
> +	enum thermal_trip_type trip_type;
> +
> +	/* Return doing nothing in case of cold trip point */
> +	if (trip != THERMAL_TRIPS_NONE) {
> +		tz->ops->get_trip_type(tz, trip, &trip_type);
> +		if (trip_type == THERMAL_TRIP_COLD)
> +			return 0;
> +	}
>  
>  	thermal_zone_trip_update(tz, trip);
>  
> diff --git a/drivers/thermal/gov_fair_share.c
> b/drivers/thermal/gov_fair_share.c
> index aaa07180ab48..c0adce525faa 100644
> --- a/drivers/thermal/gov_fair_share.c
> +++ b/drivers/thermal/gov_fair_share.c
> @@ -81,6 +81,14 @@ static int fair_share_throttle(struct
> thermal_zone_device *tz, int trip)
>  	int total_weight = 0;
>  	int total_instance = 0;
>  	int cur_trip_level = get_trip_level(tz);
> +	enum thermal_trip_type trip_type;
> +
> +	/* Return doing nothing in case of cold trip point */
> +	if (trip != THERMAL_TRIPS_NONE) {
> +		tz->ops->get_trip_type(tz, trip, &trip_type);
> +		if (trip_type == THERMAL_TRIP_COLD)
> +			return 0;
> +	}
>  
>  	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
> {
>  		if (instance->trip != trip)
> diff --git a/drivers/thermal/gov_power_allocator.c
> b/drivers/thermal/gov_power_allocator.c
> index 44636475b2a3..2644ad4d4032 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -613,8 +613,16 @@ static int power_allocator_throttle(struct
> thermal_zone_device *tz, int trip)
>  {
>  	int ret;
>  	int switch_on_temp, control_temp;
> +	enum thermal_trip_type trip_type;
>  	struct power_allocator_params *params = tz->governor_data;
>  
> +	/* Return doing nothing in case of cold trip point */
> +	if (trip != THERMAL_TRIPS_NONE) {
> +		tz->ops->get_trip_type(tz, trip, &trip_type);
> +		if (trip_type == THERMAL_TRIP_COLD)
> +			return 0;
> +	}
> +
>  	/*
>  	 * We get called for every trip point but we only need to do
>  	 * our calculations once
> diff --git a/drivers/thermal/gov_step_wise.c
> b/drivers/thermal/gov_step_wise.c
> index 2ae7198d3067..009aefda0441 100644
> --- a/drivers/thermal/gov_step_wise.c
> +++ b/drivers/thermal/gov_step_wise.c
> @@ -186,6 +186,14 @@ static void thermal_zone_trip_update(struct
> thermal_zone_device *tz, int trip)
>  static int step_wise_throttle(struct thermal_zone_device *tz, int
> trip)
>  {
>  	struct thermal_instance *instance;
> +	enum thermal_trip_type trip_type;
> +
> +	/* For now, return doing nothing in case of cold trip point */
> +	if (trip != THERMAL_TRIPS_NONE) {
> +		tz->ops->get_trip_type(tz, trip, &trip_type);
> +		if (trip_type == THERMAL_TRIP_COLD)
> +			return 0;
> +	}
>  
>  	thermal_zone_trip_update(tz, trip);
>  

