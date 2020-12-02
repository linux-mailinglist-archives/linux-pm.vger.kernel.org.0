Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2904C2CBA78
	for <lists+linux-pm@lfdr.de>; Wed,  2 Dec 2020 11:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgLBKYB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Dec 2020 05:24:01 -0500
Received: from foss.arm.com ([217.140.110.172]:35382 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgLBKYA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Dec 2020 05:24:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C486F30E;
        Wed,  2 Dec 2020 02:23:14 -0800 (PST)
Received: from localhost (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62CD93F66B;
        Wed,  2 Dec 2020 02:23:14 -0800 (PST)
Date:   Wed, 2 Dec 2020 10:23:12 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, daniel.lezcano@linaro.org,
        orjan.eide@arm.com, robh@kernel.org,
        alyssa.rosenzweig@collabora.com, steven.price@arm.com,
        airlied@linux.ie, daniel@ffwll.ch
Subject: Re: [PATCH v2 1/5] thermal: devfreq_cooling: change tracing function
 and arguments
Message-ID: <20201202102312.GA9486@arm.com>
References: <20201118120358.17150-1-lukasz.luba@arm.com>
 <20201118120358.17150-2-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118120358.17150-2-lukasz.luba@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday 18 Nov 2020 at 12:03:54 (+0000), Lukasz Luba wrote:
> Prepare for deleting the static and dynamic power calculation and clean
> the trace function. These two fields are going to be removed in the next
> changes.
> 
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org> # for tracing code
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/devfreq_cooling.c |  3 +--
>  include/trace/events/thermal.h    | 19 +++++++++----------
>  2 files changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
> index dfab49a67252..659c0143c9f0 100644
> --- a/drivers/thermal/devfreq_cooling.c
> +++ b/drivers/thermal/devfreq_cooling.c
> @@ -277,8 +277,7 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
>  		*power = dyn_power + static_power;
>  	}
>  
> -	trace_thermal_power_devfreq_get_power(cdev, status, freq, dyn_power,
> -					      static_power, *power);
> +	trace_thermal_power_devfreq_get_power(cdev, status, freq, *power);
>  
>  	return 0;
>  fail:
> diff --git a/include/trace/events/thermal.h b/include/trace/events/thermal.h
> index 135e5421f003..8a5f04888abd 100644
> --- a/include/trace/events/thermal.h
> +++ b/include/trace/events/thermal.h
> @@ -153,31 +153,30 @@ TRACE_EVENT(thermal_power_cpu_limit,
>  TRACE_EVENT(thermal_power_devfreq_get_power,
>  	TP_PROTO(struct thermal_cooling_device *cdev,
>  		 struct devfreq_dev_status *status, unsigned long freq,
> -		u32 dynamic_power, u32 static_power, u32 power),
> +		u32 power),
>  
> -	TP_ARGS(cdev, status,  freq, dynamic_power, static_power, power),
> +	TP_ARGS(cdev, status,  freq, power),
>  
>  	TP_STRUCT__entry(
>  		__string(type,         cdev->type    )
>  		__field(unsigned long, freq          )
> -		__field(u32,           load          )
> -		__field(u32,           dynamic_power )
> -		__field(u32,           static_power  )
> +		__field(u32,           busy_time)
> +		__field(u32,           total_time)
>  		__field(u32,           power)
>  	),
>  
>  	TP_fast_assign(
>  		__assign_str(type, cdev->type);
>  		__entry->freq = freq;
> -		__entry->load = (100 * status->busy_time) / status->total_time;
> -		__entry->dynamic_power = dynamic_power;
> -		__entry->static_power = static_power;
> +		__entry->busy_time = status->busy_time;
> +		__entry->total_time = status->total_time;
>  		__entry->power = power;
>  	),
>  
> -	TP_printk("type=%s freq=%lu load=%u dynamic_power=%u static_power=%u power=%u",
> +	TP_printk("type=%s freq=%lu load=%u power=%u",
>  		__get_str(type), __entry->freq,
> -		__entry->load, __entry->dynamic_power, __entry->static_power,
> +		__entry->total_time == 0 ? 0 :
> +			(100 * __entry->busy_time) / __entry->total_time,
>  		__entry->power)
>  );
>  
> -- 
> 2.17.1
> 

Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>

Regards,
Ionela.
