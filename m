Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C8C21638F
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jul 2020 03:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgGGBzS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jul 2020 21:55:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:61633 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbgGGBzS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 6 Jul 2020 21:55:18 -0400
IronPort-SDR: BXuyHJt6HMhWtEYRRS3VJDE7/IxHXDXSLGy3OOmDcj1t70W1DsvdINT2nk6naL2ZsstwnOF9uI
 489ceOyIdkQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="127119890"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="127119890"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 18:55:17 -0700
IronPort-SDR: Mz0eEDzXIa8wkrxQzz2iXT5nbDD+3WkPUGIY999o3lWGBEm3fkmcVUSqy9xH0feJ59kQk9cBoF
 F8hMki/plztg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="483334561"
Received: from zhexindu-mobl.ccr.corp.intel.com ([10.255.31.6])
  by fmsmga005.fm.intel.com with ESMTP; 06 Jul 2020 18:55:15 -0700
Message-ID: <45b8d8691ff5b4ffcc10cae7776d9e33eb873f2d.camel@intel.com>
Subject: Re: [PATCH v4 4/4] thermal: core: Add notifications call in the
 framework
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     srinivas.pandruvada@linux.intel.com, rkumbako@codeaurora.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Date:   Tue, 07 Jul 2020 09:55:14 +0800
In-Reply-To: <20200706105538.2159-4-daniel.lezcano@linaro.org>
References: <20200706105538.2159-1-daniel.lezcano@linaro.org>
         <20200706105538.2159-4-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2020-07-06 at 12:55 +0200, Daniel Lezcano wrote:
> The generic netlink protocol is implemented but the different
> notification functions are not yet connected to the core code.
> 
> These changes add the notification calls in the different
> corresponding places.
> 
> Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Zhang Rui <rui.zhang@intel.com>
> ---
>   v4:
>      - Fixed missing static declaration, reported by kbuild-bot
>      - Removed max state notification
> ---
>  drivers/thermal/thermal_core.c    | 21 +++++++++++++++++++++
>  drivers/thermal/thermal_helpers.c | 13 +++++++++++--
>  drivers/thermal/thermal_sysfs.c   | 15 ++++++++++++++-
>  3 files changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c
> b/drivers/thermal/thermal_core.c
> index 5fae1621fb01..25ef29123f72 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -215,6 +215,8 @@ int thermal_zone_device_set_policy(struct
> thermal_zone_device *tz,
>  	mutex_unlock(&tz->lock);
>  	mutex_unlock(&thermal_governor_lock);
>  
> +	thermal_notify_tz_gov_change(tz->id, policy);
> +
>  	return ret;
>  }
>  
> @@ -406,12 +408,25 @@ static void handle_critical_trips(struct
> thermal_zone_device *tz,
>  static void handle_thermal_trip(struct thermal_zone_device *tz, int
> trip)
>  {
>  	enum thermal_trip_type type;
> +	int trip_temp, hyst = 0;
>  
>  	/* Ignore disabled trip points */
>  	if (test_bit(trip, &tz->trips_disabled))
>  		return;
>  
> +	tz->ops->get_trip_temp(tz, trip, &trip_temp);
>  	tz->ops->get_trip_type(tz, trip, &type);
> +	if (tz->ops->get_trip_hyst)
> +		tz->ops->get_trip_hyst(tz, trip, &hyst);
> +
> +	if (tz->last_temperature != THERMAL_TEMP_INVALID) {
> +		if (tz->last_temperature < trip_temp &&
> +		    tz->temperature >= trip_temp)
> +			thermal_notify_tz_trip_up(tz->id, trip);
> +		if (tz->last_temperature >= trip_temp &&
> +		    tz->temperature < (trip_temp - hyst))
> +			thermal_notify_tz_trip_down(tz->id, trip);
> +	}
>  
>  	if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)
>  		handle_critical_trips(tz, trip, type);
> @@ -443,6 +458,8 @@ static void update_temperature(struct
> thermal_zone_device *tz)
>  	mutex_unlock(&tz->lock);
>  
>  	trace_thermal_temperature(tz);
> +
> +	thermal_genl_sampling_temp(tz->id, temp);
>  }
>  
>  static void thermal_zone_device_init(struct thermal_zone_device *tz)
> @@ -1405,6 +1422,8 @@ thermal_zone_device_register(const char *type,
> int trips, int mask,
>  	if (atomic_cmpxchg(&tz->need_update, 1, 0))
>  		thermal_zone_device_update(tz,
> THERMAL_EVENT_UNSPECIFIED);
>  
> +	thermal_notify_tz_create(tz->id, tz->type);
> +
>  	return tz;
>  
>  unregister:
> @@ -1476,6 +1495,8 @@ void thermal_zone_device_unregister(struct
> thermal_zone_device *tz)
>  	ida_destroy(&tz->ida);
>  	mutex_destroy(&tz->lock);
>  	device_unregister(&tz->device);
> +
> +	thermal_notify_tz_delete(tz->id);
>  }
>  EXPORT_SYMBOL_GPL(thermal_zone_device_unregister);
>  
> diff --git a/drivers/thermal/thermal_helpers.c
> b/drivers/thermal/thermal_helpers.c
> index 87b1256fa2f2..c94bc824e5d3 100644
> --- a/drivers/thermal/thermal_helpers.c
> +++ b/drivers/thermal/thermal_helpers.c
> @@ -175,6 +175,16 @@ void thermal_zone_set_trips(struct
> thermal_zone_device *tz)
>  	mutex_unlock(&tz->lock);
>  }
>  
> +static void thermal_cdev_set_cur_state(struct thermal_cooling_device
> *cdev,
> +				       int target)
> +{
> +	if (cdev->ops->set_cur_state(cdev, target))
> +		return;
> +
> +	thermal_notify_cdev_state_update(cdev->id, target);
> +	thermal_cooling_device_stats_update(cdev, target);
> +}
> +
>  void thermal_cdev_update(struct thermal_cooling_device *cdev)
>  {
>  	struct thermal_instance *instance;
> @@ -197,8 +207,7 @@ void thermal_cdev_update(struct
> thermal_cooling_device *cdev)
>  			target = instance->target;
>  	}
>  
> -	if (!cdev->ops->set_cur_state(cdev, target))
> -		thermal_cooling_device_stats_update(cdev, target);
> +	thermal_cdev_set_cur_state(cdev, target);
>  
>  	cdev->updated = true;
>  	mutex_unlock(&cdev->lock);
> diff --git a/drivers/thermal/thermal_sysfs.c
> b/drivers/thermal/thermal_sysfs.c
> index aa99edb4dff7..ff449943f757 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -124,7 +124,8 @@ trip_point_temp_store(struct device *dev, struct
> device_attribute *attr,
>  {
>  	struct thermal_zone_device *tz = to_thermal_zone(dev);
>  	int trip, ret;
> -	int temperature;
> +	int temperature, hyst = 0;
> +	enum thermal_trip_type type;
>  
>  	if (!tz->ops->set_trip_temp)
>  		return -EPERM;
> @@ -139,6 +140,18 @@ trip_point_temp_store(struct device *dev, struct
> device_attribute *attr,
>  	if (ret)
>  		return ret;
>  
> +	if (tz->ops->get_trip_hyst) {
> +		ret = tz->ops->get_trip_hyst(tz, trip, &hyst);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = tz->ops->get_trip_type(tz, trip, &type);
> +	if (ret)
> +		return ret;
> +
> +	thermal_notify_tz_trip_change(tz->id, trip, type, temperature,
> hyst);
> +
>  	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
>  
>  	return count;

