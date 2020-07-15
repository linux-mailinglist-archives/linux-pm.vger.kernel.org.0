Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8132207B7
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 10:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbgGOIq5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 04:46:57 -0400
Received: from mga11.intel.com ([192.55.52.93]:61786 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729377AbgGOIq4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Jul 2020 04:46:56 -0400
IronPort-SDR: AVBd4w/lewG8wnDfAgIeB6mv+zgzyBqn7bjk41JbB9qb2ClgbQ0Vnh8G3dNZXONfW7HAGLrRwh
 QmrTP2vASdHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="147113218"
X-IronPort-AV: E=Sophos;i="5.75,354,1589266800"; 
   d="scan'208";a="147113218"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 01:46:56 -0700
IronPort-SDR: DXexAs8H1P9V9yOFnm7lrcgiUiXuzWp57mJFBrWKsRwwIaSGj+DcHhlB7ITlgE7qWM2rj3LQsj
 K6bIgPBigxIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,354,1589266800"; 
   d="scan'208";a="299819931"
Received: from yren3-mobl.ccr.corp.intel.com ([10.249.174.224])
  by orsmga002.jf.intel.com with ESMTP; 15 Jul 2020 01:46:54 -0700
Message-ID: <746420e6b213985518d8b314018e32dc3438e9af.camel@intel.com>
Subject: Re: [RFC PATCH 3/4] thermal:core:Add genetlink notifications for
 monitoring falling temperature
From:   Zhang Rui <rui.zhang@intel.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>,
        daniel.lezcano@linaro.org, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 15 Jul 2020 16:46:53 +0800
In-Reply-To: <20200710135154.181454-4-thara.gopinath@linaro.org>
References: <20200710135154.181454-1-thara.gopinath@linaro.org>
         <20200710135154.181454-4-thara.gopinath@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2020-07-10 at 09:51 -0400, Thara Gopinath wrote:
> Add notification calls for trip type THERMAL_TRIP_COLD when
> temperature
> crosses the trip point in either direction.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  drivers/thermal/thermal_core.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c
> b/drivers/thermal/thermal_core.c
> index 750a89f0c20a..e2302ca1cd3b 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -429,12 +429,21 @@ static void handle_thermal_trip(struct
> thermal_zone_device *tz, int trip)
>  		tz->ops->get_trip_hyst(tz, trip, &hyst);
>  
>  	if (tz->last_temperature != THERMAL_TEMP_INVALID) {
> -		if (tz->last_temperature < trip_temp &&
> -		    tz->temperature >= trip_temp)
> -			thermal_notify_tz_trip_up(tz->id, trip);
> -		if (tz->last_temperature >= trip_temp &&
> -		    tz->temperature < (trip_temp - hyst))
> -			thermal_notify_tz_trip_down(tz->id, trip);
> +		if (type == THERMAL_TRIP_COLD) {
> +			if (tz->last_temperature > trip_temp &&
> +			    tz->temperature <= trip_temp)
> +				thermal_notify_tz_trip_down(tz->id,
> trip);

trip_type should also be part of the event because trip_down/trip_up
for hot trip and cold trip have different meanings.
Or can we use some more generic names like trip_on/trip_off? trip_on
means the trip point is violated or actions need to be taken for the
specific trip points, for both hot and cold trips. I know
trip_on/trip_off doesn't represent what I mean clearly, but surely you
can find a better name.

thanks,
rui

> +			if (tz->last_temperature <= trip_temp &&
> +			    tz->temperature > (trip_temp + hyst))
> +				thermal_notify_tz_trip_up(tz->id,
> trip);
> +		} else {
> +			if (tz->last_temperature < trip_temp &&
> +			    tz->temperature >= trip_temp)
> +				thermal_notify_tz_trip_up(tz->id,
> trip);
> +			if (tz->last_temperature >= trip_temp &&
> +			    tz->temperature < (trip_temp - hyst))
> +				thermal_notify_tz_trip_down(tz->id,
> trip);
> +		}
>  	}
>  
>  	if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)

