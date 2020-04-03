Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5790619D94C
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 16:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403911AbgDCOkM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 10:40:12 -0400
Received: from smtp1.axis.com ([195.60.68.17]:47636 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728066AbgDCOkM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Apr 2020 10:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=3375; q=dns/txt; s=axis-central1;
  t=1585924811; x=1617460811;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+zXmvQ71wuVL3YLxRdG+cyS3KAA4sDvpKKdNeB9bCq8=;
  b=OwERzdbT1UdVAiUUw9vHOJcronkCh0CcT/mYA9pFYH+H2qRRP3eDnKgu
   0ub7jffCpCq7UDCV5KXZrgEUWAYqHrd83BBS+ZgzEm4X8o0i6+a6YneD8
   3HedzAK79FTj71GzXOB9LTeRuQ31NIeu7StTlUK03l/qZ6DiWb7kBPGCI
   GoS3YDUshbik7Il+eTUH9vsOHL4RnLNlkwYedO9L7/qoK2h/fP6GHcDde
   2RyO3yFcxm0KXP1PzIcc4WvfVa0QAaZIXptzIpqTNDGESgITCzn3IopxH
   6mdGdAglVUIudvCoRZfBw50F1MnqOSdshqdb6f2HrYmrH/0DNyNdyeCzc
   A==;
IronPort-SDR: uB+hmrX6WHbLrkXUv7Y6CMpJNYKKlANXcwQzCh+0+yXc/ZJa/1JC4QM038i0kzKea+x2XCuzm2
 EiD/xGz3phOKwdwH2/rCbN7AKTLDsIugW95xWBUHNN0swfRVigSFOGvJ8dcG/PqxUIHrs1/PyG
 PgWo79hFBouSYre9+iust2LC9FB8o7+bedX41vSyz9Jr4J33GoNbGOZbsdpu0VenFiAJzGtfeI
 FYydH+pq6hnOPE2ptPTldHGt0ePWddz4Z827iUNboNtKo7cqex2QNCM/gI1XDWjZXau6M/Pru1
 Jpk=
X-IronPort-AV: E=Sophos;i="5.72,340,1580770800"; 
   d="scan'208";a="7290918"
Date:   Fri, 3 Apr 2020 16:40:09 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] thermal: core: Send a sysfs notification on trip points
Message-ID: <20200403144009.szjoss5ecleisg2f@axis.com>
References: <a7e8287d-72be-7ab0-697a-9de40eb3f81f@linaro.org>
 <20200402142116.22869-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200402142116.22869-1-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 02, 2020 at 04:21:15PM +0200, Daniel Lezcano wrote:
> Currently the userspace has no easy way to get notified when a
> specific trip point was crossed. There are a couple of approaches:
> 
> - the userspace polls the sysfs temperature with usually an
>   unacceptable delay between the trip temperature point crossing and
>   the moment it is detected, or a high polling rate with an
>   unacceptable number of wakeup events.
> 
> - the thermal zone is set to be managed by an userspace governor in
>   order to receive the uevent even if the thermal zone needs to be
>   managed by another governor.
> 
> These changes allow to send a sysfs notification on the
> trip_point_*_temp when the temperature is getting higher than the trip
> point temperature. By this way, the userspace can be notified
> everytime when the trip point is crossed, this is useful for the
> thermal Android HAL or for notification to be sent via d-bus.
> 
> That allows the userspace to manage the applications based on specific
> alerts on different thermal zones to mitigate the skin temperature,
> letting the kernel governors handle the high temperature for hardware
> like the CPU, the GPU or the modem.
> 
> The temperature can be oscillating around a trip point and the event
> will be sent multiple times. It is up to the userspace to deal with
> this situation.

The actual temperature value would also be interesting.  Is there a way
for userspace to obtain it in a race-free manner when it is notified
that the trip point has been crossed?

> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index c06550930979..3cbdd20252ab 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -407,6 +407,19 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
>  	}
>  }
>  
> +static int thermal_trip_crossed(struct thermal_zone_device *tz, int trip)
> +{
> +	int trip_temp;
> +
> +	tz->ops->get_trip_temp(tz, trip, &trip_temp);
> +
> +	if (tz->last_temperature == THERMAL_TEMP_INVALID)
> +		return 0;
> +
> +	return ((tz->last_temperature < trip_temp)) &&
> +		(tz->temperature >= trip_temp));

 drivers/thermal/thermal_core.c: In function ‘thermal_trip_crossed’:
 drivers/thermal/thermal_core.c:425:33: error: expected ‘;’ before ‘)’ token
    (tz->temperature >= trip_temp));
                                  ^
 drivers/thermal/thermal_core.c:425:33: error: expected statement before ‘)’ token

> +}
> +
>  static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
>  {
>  	enum thermal_trip_type type;
> @@ -417,6 +430,16 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
>  
>  	tz->ops->get_trip_type(tz, trip, &type);
>  
> +	/*
> +	 * This condition will be true everytime the temperature is
> +	 * greater than the trip point and the previous temperature
> +	 * was below. In this case notify the userspace via a sysfs
> +	 * event on the trip point.
> +	 */
> +	if (thermal_trip_crossed(tz, trip))
> +		sysfs_notify(&tz->device.kobj, NULL,
> +			     tz->trip_temp_attrs[trip].attr.attr.name);

Normally sysfs_notify() is used to notify userspace that the value of
the sysfs file has changed, but in this case it's being used on a sysfs
file whose value never changes.  I don't know if there are other drivers
that do something similar.
