Return-Path: <linux-pm+bounces-1099-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8208B81145E
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 15:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4C51F20FDD
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 14:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373E22E836;
	Wed, 13 Dec 2023 14:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NxdZqJE3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1246DD
	for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2023 06:12:43 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3363653e180so1324004f8f.0
        for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2023 06:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702476762; x=1703081562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=06FHqisy8Q874wPn0JJPGt4cD6Hfyyr+nGOhZNcN+cg=;
        b=NxdZqJE3ACIWpoCi5DPiABNPfFaUsrx1Kh5x4S1pPjxsiNoCPvyKhFzl036Wnpntqo
         R2R1ziz6/IDqSXLlmRa1ZnrHMokM2l3zcyXcCe48Y//D0Z8pxkP9Jlbevxk3wnzV2gUX
         80xtJzNDN5k7jpmJ3jXwXzEacPVs3d37nl118EvlCfErTIqSDI1IkIZU2kdtI8akZmnt
         Ilx0APvPjkWxqNY6Z2gZtghNufeUQeD0l3n66CH786YzBBYxiApY9cnDrURFAdyYO51s
         IYl94aXqwb0LMl5T9t7zV76M96iGzwnOPGOhcGn3u+jKK9jdVlcXwEWFHGGdfFZZtwBx
         PYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702476762; x=1703081562;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=06FHqisy8Q874wPn0JJPGt4cD6Hfyyr+nGOhZNcN+cg=;
        b=vEJ7w1fJ4ccOJOEEVWM74b0yzLqItI47ck2t/HQEJD7GOMih3Y0vQCD0y75XkNWHVY
         oVHEPSlH9Pq7QKEnPW815hYmLSX241HsQgUllXXOTXZDyNIXumExfV4WrNOh6fTe6gek
         UL6ra6ZnjajrdBGP/C0/OIXwPV9WaEY1I82ayZ7VHPJEULH+N4fc9A9iQt19ZU4JIBzK
         gr3VFYB38UV636ZVculClc5Q1G7j+4GP2mEIaI846AV+lgUvVdnVOQJuKcU08VDhZRRV
         PWgqACLGAXzy1o9Vjwv1KyetCrbB6TDEWWbgwGgspSeN2ccymd5xRdD2Nv+6Cs2ztPu/
         Wmeg==
X-Gm-Message-State: AOJu0YzXXmq9rMEV3a6u2wxbeMuQn3OtC4/WvlKPJianCl5JYUpfuQWo
	v3EfAq1/eTagJCNjPsZDVcxlbxyEl/j2Xdr/nug=
X-Google-Smtp-Source: AGHT+IFNYLcYw2g3H5xktn1x+on4mTJW+OofM3g1HpZSiD/dnbu76uzoI61YCIDggefX8rEoG94VCA==
X-Received: by 2002:a05:600c:1ca9:b0:40c:325b:6360 with SMTP id k41-20020a05600c1ca900b0040c325b6360mr3703319wms.130.1702476762047;
        Wed, 13 Dec 2023 06:12:42 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id bd19-20020a05600c1f1300b0040839fcb217sm20804513wmb.8.2023.12.13.06.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 06:12:41 -0800 (PST)
Message-ID: <0e4cee10-4aa4-4979-9841-f1dbd207e0b7@linaro.org>
Date: Wed, 13 Dec 2023 15:12:41 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] thermal: core: add initial support for cold and
 critical_cold trip point
Content-Language: en-US
To: Christian Marangi <ansuelsmth@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231212221301.12581-1-ansuelsmth@gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20231212221301.12581-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/12/2023 23:13, Christian Marangi wrote:
> Add initial support for cold and critical_cold trip point. Many if not
> all hwmon and thermal device have normally trip point for hot
> temperature and for cold temperature.
> 
> Till now only hot temperature were supported. Add support for also cold
> temperature to permit complete definition of cold trip point in DT.
> 
> Thermal driver may use these additional trip point to correctly set
> interrupt for cold temperature values and react based on that with
> various measure like enabling attached heater, forcing higher voltage
> and other specialaized peripherals.
> 
> For hwmon drivers this is needed as currently there is a problem with
> setting the full operating range of the device for thermal devices
> defined with hwmon. To better describe the problem, the following
> example is needed:
> 
> In the scenario of a simple hwmon with an active trip point declared
> and a cooling device attached, the hwmon subsystem currently set the
> min and max trip point based on the single active trip point.
> Thermal subsystem parse all the trip points and calculate the lowest and
> the highest trip point and calls the .set_trip of hwmon to setup the
> trip points.
> 
> The fact that we currently don't have a way to declare the cold/min
> temperature values, makes the thermal subsystem to set the low value as
> -INT_MAX.
> For hwmon drivers that doesn't use clamp_value and actually reject
> invalid values for the trip point, this results in the hwmon settings to
> be rejected.
> 
> To permit to pass the correct range of trip point, permit to set in DT
> also cold and critical_cold trip point.
> 
> Thermal driver may also define .cold and .critical_cold to act on these
> trip point tripped and apply the required measure.

Agree with the feature but we need to clarify the semantic of the trip 
points first. What actions do we expect for them in order to have like a 
mirror reflection of the existing hot trip points.

What action do you expect with:

  - 'cold' ?

  - 'critical_cold' ?



> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Why are there two different names for the same email address?

  - Christian Marangi <ansuelsmth@gmail.com>
  - Ansuel Smith <ansuelsmth@gmail.com>


> ---
>   drivers/thermal/thermal_core.c  | 13 +++++++++++++
>   drivers/thermal/thermal_of.c    |  2 ++
>   drivers/thermal/thermal_sysfs.c |  4 ++++
>   drivers/thermal/thermal_trace.h |  4 ++++
>   include/linux/thermal.h         |  2 ++
>   include/uapi/linux/thermal.h    |  2 ++
>   6 files changed, 27 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 9c17d35ccbbd..3c5ab560e72f 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -344,6 +344,17 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
>   		tz->ops->hot(tz);
>   }
>   
> +static void handle_critical_cold_trips(struct thermal_zone_device *tz,
> +				       const struct thermal_trip *trip)
> +{
> +	trace_thermal_zone_trip(tz, thermal_zone_trip_id(tz, trip), trip->type);
> +
> +	if (trip->type == THERMAL_TRIP_CRITICAL_COLD && tz->ops->critical_cold)
> +		tz->ops->critical_cold(tz);
> +	else if (trip->type == THERMAL_TRIP_COLD && tz->ops->cold)
> +		tz->ops->cold(tz);
> +}
> +
>   static void handle_thermal_trip(struct thermal_zone_device *tz,
>   				const struct thermal_trip *trip)
>   {
> @@ -365,6 +376,8 @@ static void handle_thermal_trip(struct thermal_zone_device *tz,
>   
>   	if (trip->type == THERMAL_TRIP_CRITICAL || trip->type == THERMAL_TRIP_HOT)
>   		handle_critical_trips(tz, trip);
> +	else if (trip->type == THERMAL_TRIP_CRITICAL_COLD || trip->type == THERMAL_TRIP_COLD)
> +		handle_critical_cold_trips(tz, trip);
>   	else
>   		handle_non_critical_trips(tz, trip);
>   }
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 1e0655b63259..95bc600bb4b8 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -60,6 +60,8 @@ static const char * const trip_types[] = {
>   	[THERMAL_TRIP_PASSIVE]	= "passive",
>   	[THERMAL_TRIP_HOT]	= "hot",
>   	[THERMAL_TRIP_CRITICAL]	= "critical",
> +	[THERMAL_TRIP_COLD]	= "cold",
> +	[THERMAL_TRIP_CRITICAL_COLD] = "critical_cold",
>   };
>   
>   /**
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index eef40d4f3063..e1e69e0991c2 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -106,6 +106,10 @@ trip_point_type_show(struct device *dev, struct device_attribute *attr,
>   		return sprintf(buf, "critical\n");
>   	case THERMAL_TRIP_HOT:
>   		return sprintf(buf, "hot\n");
> +	case THERMAL_TRIP_COLD:
> +		return sprintf(buf, "cold\n");
> +	case THERMAL_TRIP_CRITICAL_COLD:
> +		return sprintf(buf, "critical_cold\n");
>   	case THERMAL_TRIP_PASSIVE:
>   		return sprintf(buf, "passive\n");
>   	case THERMAL_TRIP_ACTIVE:
> diff --git a/drivers/thermal/thermal_trace.h b/drivers/thermal/thermal_trace.h
> index 459c8ce6cf3b..0a4f96075d7d 100644
> --- a/drivers/thermal/thermal_trace.h
> +++ b/drivers/thermal/thermal_trace.h
> @@ -11,6 +11,8 @@
>   
>   TRACE_DEFINE_ENUM(THERMAL_TRIP_CRITICAL);
>   TRACE_DEFINE_ENUM(THERMAL_TRIP_HOT);
> +TRACE_DEFINE_ENUM(THERMAL_TRIP_COLD);
> +TRACE_DEFINE_ENUM(THERMAL_TRIP_CRITICAL_COLD);
>   TRACE_DEFINE_ENUM(THERMAL_TRIP_PASSIVE);
>   TRACE_DEFINE_ENUM(THERMAL_TRIP_ACTIVE);
>   
> @@ -18,6 +20,8 @@ TRACE_DEFINE_ENUM(THERMAL_TRIP_ACTIVE);
>   	__print_symbolic(type,					\
>   			 { THERMAL_TRIP_CRITICAL, "CRITICAL"},	\
>   			 { THERMAL_TRIP_HOT,      "HOT"},	\
> +			 { THERMAL_TRIP_COLD,      "COLD"},	\
> +			 { THERMAL_TRIP_CRITICAL_COLD, "CRITICAL_COLD"}, \
>   			 { THERMAL_TRIP_PASSIVE,  "PASSIVE"},	\
>   			 { THERMAL_TRIP_ACTIVE,   "ACTIVE"})
>   
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index cee814d5d1ac..d6345c9ec50d 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -84,6 +84,8 @@ struct thermal_zone_device_ops {
>   			  const struct thermal_trip *, enum thermal_trend *);
>   	void (*hot)(struct thermal_zone_device *);
>   	void (*critical)(struct thermal_zone_device *);
> +	void (*cold)(struct thermal_zone_device *);
> +	void (*critical_cold)(struct thermal_zone_device *);
>   };
>   
>   struct thermal_cooling_device_ops {
> diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
> index fc78bf3aead7..7fa1ba0dff05 100644
> --- a/include/uapi/linux/thermal.h
> +++ b/include/uapi/linux/thermal.h
> @@ -14,6 +14,8 @@ enum thermal_trip_type {
>   	THERMAL_TRIP_PASSIVE,
>   	THERMAL_TRIP_HOT,
>   	THERMAL_TRIP_CRITICAL,
> +	THERMAL_TRIP_COLD,
> +	THERMAL_TRIP_CRITICAL_COLD,
>   };
>   
>   /* Adding event notification support elements */

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


