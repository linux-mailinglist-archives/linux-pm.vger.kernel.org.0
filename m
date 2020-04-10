Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9A4D1A4509
	for <lists+linux-pm@lfdr.de>; Fri, 10 Apr 2020 12:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgDJKOL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Apr 2020 06:14:11 -0400
Received: from mga02.intel.com ([134.134.136.20]:35404 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgDJKOL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Apr 2020 06:14:11 -0400
IronPort-SDR: lEAAHwxNYLaVaWCPPSMq63WM/1ghUIAhBnoOJFhfyHCPMklvbFQ+311Ioh9yqqWLcHEIbOaQTa
 +X/iECOtrvgg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2020 03:14:10 -0700
IronPort-SDR: znwmLGqGF7fBrxbjOQHuDL9fIjHD9nBDwbGOgyLlWixbox6ihlAJtbZRPT8E9bvFR1EixwvFk2
 MGfV9tIeJbrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,366,1580803200"; 
   d="scan'208";a="255435504"
Received: from qjbian-mobl.amr.corp.intel.com ([10.255.31.146])
  by orsmga006.jf.intel.com with ESMTP; 10 Apr 2020 03:14:09 -0700
Message-ID: <8e4c2825d71e5bf5602b92937a49c04187c68e17.camel@intel.com>
Subject: Re: [PATCH 1/2] thermal: core: Move thermal_cdev_update next to
 updated=false
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, amit.kucheria@verdurent.com,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Date:   Fri, 10 Apr 2020 18:14:08 +0800
In-Reply-To: <20200409151515.6607-1-daniel.lezcano@linaro.org>
References: <20200409151515.6607-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi, Daniel,

On Thu, 2020-04-09 at 17:15 +0200, Daniel Lezcano wrote:
> The call to the thermal_cdev_update() function is done after browsing
> the thermal instances which sets the updated flag by browsing them
> again.
> 
> Instead of doing this, let's move the call right after setting the
> cooling device 'updated' flag as it is done in the other governors.

The reason we do this in two steps is that we want to avoid redundant
cooling device state changes.

Further more, I think it is better to move the thermal_cdev_update out
of .throllte() callback, to thermal_zone_device_update(). So that we do
not need to update the cooling device for each trip point.

is there any specific reason we need to do thermal_cdev_update() for
every potential change?

thanks,
rui
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/gov_bang_bang.c | 10 +---------
>  drivers/thermal/step_wise.c     | 10 +---------
>  2 files changed, 2 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/thermal/gov_bang_bang.c
> b/drivers/thermal/gov_bang_bang.c
> index 991a1c54296d..c292a69845bb 100644
> --- a/drivers/thermal/gov_bang_bang.c
> +++ b/drivers/thermal/gov_bang_bang.c
> @@ -64,6 +64,7 @@ static void thermal_zone_trip_update(struct
> thermal_zone_device *tz, int trip)
>  		mutex_lock(&instance->cdev->lock);
>  		instance->cdev->updated = false; /* cdev needs update
> */
>  		mutex_unlock(&instance->cdev->lock);
> +		thermal_cdev_update(instance->cdev);
>  	}
>  
>  	mutex_unlock(&tz->lock);
> @@ -98,17 +99,8 @@ static void thermal_zone_trip_update(struct
> thermal_zone_device *tz, int trip)
>   */
>  static int bang_bang_control(struct thermal_zone_device *tz, int
> trip)
>  {
> -	struct thermal_instance *instance;
> -
>  	thermal_zone_trip_update(tz, trip);
>  
> -	mutex_lock(&tz->lock);
> -
> -	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
> -		thermal_cdev_update(instance->cdev);
> -
> -	mutex_unlock(&tz->lock);
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/thermal/step_wise.c
> b/drivers/thermal/step_wise.c
> index 2ae7198d3067..298eedac0293 100644
> --- a/drivers/thermal/step_wise.c
> +++ b/drivers/thermal/step_wise.c
> @@ -167,6 +167,7 @@ static void thermal_zone_trip_update(struct
> thermal_zone_device *tz, int trip)
>  		mutex_lock(&instance->cdev->lock);
>  		instance->cdev->updated = false; /* cdev needs update
> */
>  		mutex_unlock(&instance->cdev->lock);
> +		thermal_cdev_update(instance->cdev);
>  	}
>  
>  	mutex_unlock(&tz->lock);
> @@ -185,20 +186,11 @@ static void thermal_zone_trip_update(struct
> thermal_zone_device *tz, int trip)
>   */
>  static int step_wise_throttle(struct thermal_zone_device *tz, int
> trip)
>  {
> -	struct thermal_instance *instance;
> -
>  	thermal_zone_trip_update(tz, trip);
>  
>  	if (tz->forced_passive)
>  		thermal_zone_trip_update(tz, THERMAL_TRIPS_NONE);
>  
> -	mutex_lock(&tz->lock);
> -
> -	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
> -		thermal_cdev_update(instance->cdev);
> -
> -	mutex_unlock(&tz->lock);
> -
>  	return 0;
>  }
>  

