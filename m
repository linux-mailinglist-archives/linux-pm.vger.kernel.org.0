Return-Path: <linux-pm+bounces-16142-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 641E69A90A7
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 22:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20B62284C94
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 20:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842201D1506;
	Mon, 21 Oct 2024 20:09:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B5D192D66
	for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2024 20:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729541371; cv=none; b=ncItIaNG5VSvly1705u0wfAwe4Uf8JDJS4iFPpj1slIiuaQPyc7YnO7/Dj8J+R+PLVs4+ySH4fuhjQrwLh7GUoYdsg6BmEHCcW5a0NE3DrZ84A5ys058wKUzWvz7lEu1bEW/G0ex6SEeq9/B1bC/jMWquw4svzIR9BKnN9GksbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729541371; c=relaxed/simple;
	bh=aVSZj8esYT3Zrg3Hwii9fJl1Bn9tt0HZm/EN36wbZmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GlgiBBK2kIUkoAEGcx1eTDAuzA5E8dzappWHnScuq4kGZk0Ya34wVYPWXGHPUOV4K9j2fI/ZHF3r4GTIOI01Qt1HJO3I1h9g2LSN6NzBV8Lk5769MThBnwzcpH/I85fULo2q7lb2fK3oV+pjwAdhltJYtL44HFe48xnj4OvJqOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B47AF497;
	Mon, 21 Oct 2024 13:09:56 -0700 (PDT)
Received: from [10.57.65.103] (unknown [10.57.65.103])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35DF13F73B;
	Mon, 21 Oct 2024 13:09:26 -0700 (PDT)
Message-ID: <deacf57b-08b3-4b1b-85b2-98be78da8339@arm.com>
Date: Mon, 21 Oct 2024 21:10:36 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] tools/thermal/thermal-engine: Take into account
 the thresholds API
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, quic_manafm@quicinc.com, rafael@kernel.org
References: <20241014094309.1430126-1-daniel.lezcano@linaro.org>
 <20241014094309.1430126-5-daniel.lezcano@linaro.org>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20241014094309.1430126-5-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/14/24 10:43, Daniel Lezcano wrote:
> Enhance the thermal-engine skeleton with the thresholds added in the
> kernel and use the API exported by the thermal library.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   tools/thermal/thermal-engine/thermal-engine.c | 105 +++++++++++++++---
>   1 file changed, 92 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/thermal/thermal-engine/thermal-engine.c b/tools/thermal/thermal-engine/thermal-engine.c
> index 9b1476a2680f..0764dc754771 100644
> --- a/tools/thermal/thermal-engine/thermal-engine.c
> +++ b/tools/thermal/thermal-engine/thermal-engine.c
> @@ -38,6 +38,14 @@ struct thermal_data {
>   	struct thermal_handler *th;
>   };
>   
> +static int show_threshold(struct thermal_threshold *th, __maybe_unused void *arg)
> +{
> +	INFO("threshold temp=%d, direction=%d\n",
> +	     th->temperature, th->direction);
> +
> +	return 0;
> +}
> +
>   static int show_trip(struct thermal_trip *tt, __maybe_unused void *arg)
>   {
>   	INFO("trip id=%d, type=%d, temp=%d, hyst=%d\n",
> @@ -70,6 +78,8 @@ static int show_tz(struct thermal_zone *tz, __maybe_unused void *arg)
>   
>   	for_each_thermal_trip(tz->trip, show_trip, NULL);
>   
> +	for_each_thermal_threshold(tz->thresholds, show_threshold, NULL);
> +
>   	show_temp(tz, arg);
>   
>   	show_governor(tz, arg);
> @@ -77,6 +87,30 @@ static int show_tz(struct thermal_zone *tz, __maybe_unused void *arg)
>   	return 0;
>   }
>   
> +static int set_threshold(struct thermal_zone *tz, __maybe_unused void *arg)
> +{
> +	struct thermal_handler *th = arg;
> +	int thresholds[] = { 43000, 65000, 49000, 55000, 57000 };
> +	size_t i;

minor: I would just make it normal 'int'.

> +
> +	INFO("Setting threshold for thermal zone '%s', id=%d\n", tz->name, tz->id);
> +
> +	if (thermal_cmd_threshold_flush(th, tz)) {
> +		ERROR("Failed to flush all previous thresholds\n");
> +		return -1;
> +	}
> +
> +	for (i = 0; i < sizeof(thresholds) / sizeof(thresholds[0]); i++)
> +		if (thermal_cmd_threshold_add(th, tz, thresholds[i],
> +					      THERMAL_THRESHOLD_WAY_UP |
> +					      THERMAL_THRESHOLD_WAY_DOWN)) {
> +			ERROR("Failed to set threshold\n");
> +			return -1;
> +		}
> +
> +	return 0;
> +}
> +
>   static int tz_create(const char *name, int tz_id, __maybe_unused void *arg)
>   {
>   	INFO("Thermal zone '%s'/%d created\n", name, tz_id);
> @@ -197,20 +231,62 @@ static int gov_change(int tz_id, const char *name, __maybe_unused void *arg)
>   	return 0;
>   }
>   
> +static int threshold_add(int tz_id, int temp, int direction, __maybe_unused void *arg)
> +{
> +	INFO("Threshold added tz_id=%d: temp=%d, direction=%d\n", tz_id, temp, direction);
> +
> +	return 0;
> +}
> +
> +static int threshold_delete(int tz_id, int temp, int direction, __maybe_unused void *arg)
> +{
> +	INFO("Threshold deleted tz_id=%d: temp=%d, direction=%d\n", tz_id, temp, direction);
> +
> +	return 0;
> +}
> +
> +static int threshold_flush(int tz_id, __maybe_unused void *arg)
> +{
> +	INFO("Thresholds flushed tz_id=%d\n", tz_id);
> +
> +	return 0;
> +}
> +
> +static int threshold_up(int tz_id, int temp, int prev_temp, __maybe_unused void *arg)
> +{
> +	INFO("Threshold crossed way up tz_id=%d: temp=%d, prev_temp=%d\n",
> +	     tz_id, temp, prev_temp);
> +
> +	return 0;
> +}
> +
> +static int threshold_down(int tz_id, int temp, int prev_temp, __maybe_unused void *arg)
> +{
> +	INFO("Threshold crossed way down tz_id=%d: temp=%d, prev_temp=%d\n",
> +	     tz_id, temp, prev_temp);
> +
> +	return 0;
> +}
> +
>   static struct thermal_ops ops = {
> -	.events.tz_create	= tz_create,
> -	.events.tz_delete	= tz_delete,
> -	.events.tz_disable	= tz_disable,
> -	.events.tz_enable	= tz_enable,
> -	.events.trip_high	= trip_high,
> -	.events.trip_low	= trip_low,
> -	.events.trip_add	= trip_add,
> -	.events.trip_delete	= trip_delete,
> -	.events.trip_change	= trip_change,
> -	.events.cdev_add	= cdev_add,
> -	.events.cdev_delete	= cdev_delete,
> -	.events.cdev_update	= cdev_update,
> -	.events.gov_change	= gov_change
> +	.events.tz_create		= tz_create,
> +	.events.tz_delete		= tz_delete,
> +	.events.tz_disable		= tz_disable,
> +	.events.tz_enable		= tz_enable,
> +	.events.trip_high		= trip_high,
> +	.events.trip_low		= trip_low,
> +	.events.trip_add		= trip_add,
> +	.events.trip_delete		= trip_delete,
> +	.events.trip_change		= trip_change,
> +	.events.cdev_add		= cdev_add,
> +	.events.cdev_delete		= cdev_delete,
> +	.events.cdev_update		= cdev_update,
> +	.events.gov_change		= gov_change,
> +	.events.threshold_add		= threshold_add,
> +	.events.threshold_delete	= threshold_delete,
> +	.events.threshold_flush		= threshold_flush,
> +	.events.threshold_up		= threshold_up,
> +	.events.threshold_down		= threshold_down,
>   };
>   
>   static int thermal_event(__maybe_unused int fd, __maybe_unused void *arg)
> @@ -280,6 +356,7 @@ enum {
>   	THERMAL_ENGINE_DAEMON_ERROR,
>   	THERMAL_ENGINE_LOG_ERROR,
>   	THERMAL_ENGINE_THERMAL_ERROR,
> +	THERMAL_ENGINE_THRESHOLD_ERROR,
>   	THERMAL_ENGINE_MAINLOOP_ERROR,
>   };
>   
> @@ -318,6 +395,8 @@ int main(int argc, char *argv[])
>   		return THERMAL_ENGINE_THERMAL_ERROR;
>   	}
>   
> +	for_each_thermal_zone(td.tz, set_threshold, td.th);
> +
>   	for_each_thermal_zone(td.tz, show_tz, td.th);
>   
>   	if (mainloop_init()) {

LGTM,

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

