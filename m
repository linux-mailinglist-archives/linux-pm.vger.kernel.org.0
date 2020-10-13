Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804B828CB7D
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 12:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387810AbgJMKVN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Oct 2020 06:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgJMKVM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2020 06:21:12 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8093BC0613D2
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 03:21:12 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e2so21191157wme.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 03:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Isdnj7ywPpyzw3VK2rGw/3l/B3KgvYFYumf7odl6w+M=;
        b=baX5WSZ6fBfa7WhogUTvoq9WWCzoYmgCcoy0Yw+jDc9uqWaEzi0Oqi+0AJx+HZSrLB
         p88a/dAOpu/O1U/CffNSGmz1leN8bJwEFeYA2LcVEd/SzE9bxuTCfgyw/pQzFOuC+eBE
         7dg1eRq58tto5/pJQeJO+gupOcltXnAbelSA+XR9mFipWzE5U83w0JluYz073g9zUXx9
         ZfJzzlE3EOSBfuiJMTTQAK3WBtA+Chpu5f48+C8iqBTszDnxjhCDp0t6UFxTyeuYy5Pj
         ++RZSEVeYSYq5JFZ5qBRxSDAwd39kUYpbTsLe4b/0iUFwWGkuhYlGfRsA/Mpj+cbc87d
         qgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Isdnj7ywPpyzw3VK2rGw/3l/B3KgvYFYumf7odl6w+M=;
        b=pMeSviIqjjlkmPtXPo+JoJq5XXjwnzPt1nbRbyYtm2aWzqgLLwB3h3WfWUWJdi7ex9
         cGnhv5zKZFnrw5U4M4Sznnu8OlNzHEvGTl3qUYY57OAgdil/0nYQbtmVBzoTmooE+ZO4
         oqrPbSWHZqV8SymyoV02BI0KI1rUvCkeEC1FFgpV2no4BicLxXMMzTM2KUgONwpA1RE4
         LTOUCPCPjDjzBDlyqj24SqImxcPSz2eIC7fCcpoC8VfvpgmC3e7p/OYb4SY0P9yJ52e/
         ByKoWXTJCg7XbWr7Sju7J+WrtUwxg9FmyfQJHJ14Rqu93VSBh2UgDa8wYWXhkgomWLvJ
         wJiQ==
X-Gm-Message-State: AOAM530nibyLIO4wTeHLHiqXrlUtUaYhuSBHKTREZMGf/w73M1UAFoYl
        jjz46UEd37T8jz9l9kp9Fw1Iew==
X-Google-Smtp-Source: ABdhPJzU95PX4mPOUpPLXrtgK2LFOdkKKBEgDELP6aMUt94N+q30VRUZnT7qA/qS1JJ3E9zIu96vcg==
X-Received: by 2002:a1c:87:: with SMTP id 129mr14651577wma.103.1602584471014;
        Tue, 13 Oct 2020 03:21:11 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:8dea:c7dd:5d0e:51e6? ([2a01:e34:ed2f:f020:8dea:c7dd:5d0e:51e6])
        by smtp.googlemail.com with ESMTPSA id h16sm30010895wre.87.2020.10.13.03.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 03:21:10 -0700 (PDT)
Subject: Re: [PATCH 1/2] thermal: power allocator: change the 'k_i'
 coefficient estimation
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     amitk@kernel.org, Dietmar.Eggemann@arm.com
References: <20201002122416.13659-1-lukasz.luba@arm.com>
 <20201002122416.13659-2-lukasz.luba@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <cc0e6d85-28ad-3cfc-e5b8-75820552b716@linaro.org>
Date:   Tue, 13 Oct 2020 12:21:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002122416.13659-2-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Lukasz,

On 02/10/2020 14:24, Lukasz Luba wrote:
> Intelligent Power Allocation (IPA) is built around the PID controller
> concept. The initialization code tries to setup the environment based on
> the information available in DT or estimate the value based on minimum
> power reported by each of the cooling device. The estimation will have an
> impact on the PID controller behaviour via the related 'k_po', 'k_pu',
> 'k_i' coefficients and also on the power budget calculation.
> 
> This change prevents the situation when 'k_i' is relatively big compared
> to 'k_po' and 'k_pu' values. This might happen when the estimation for
> 'sustainable_power' returned small value, thus 'k_po' and 'k_pu' are
> small.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/gov_power_allocator.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index 5cb518d8f156..f69fafe486a5 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -131,6 +131,7 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
>  	int ret;
>  	int switch_on_temp;
>  	u32 temperature_threshold;
> +	s32 k_i;
>  
>  	ret = tz->ops->get_trip_temp(tz, trip_switch_on, &switch_on_temp);
>  	if (ret)
> @@ -156,8 +157,11 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
>  		tz->tzp->k_pu = int_to_frac(2 * sustainable_power) /
>  			temperature_threshold;
>  
> -	if (!tz->tzp->k_i || force)
> -		tz->tzp->k_i = int_to_frac(10) / 1000;
> +	if (!tz->tzp->k_i || force) {
> +		k_i = tz->tzp->k_pu / 10;
> +		tz->tzp->k_i = k_i > 0 ? k_i : 1;
> +	}

I do not understand the rational behind this change.

Do you have some values to share describing what would be the impact of
this change?

Depending on the thermal behavior of a board, these coefficients could
be very different, no ?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
