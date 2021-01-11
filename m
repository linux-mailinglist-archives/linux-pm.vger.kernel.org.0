Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10ED72F242D
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jan 2021 01:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391732AbhALAZk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jan 2021 19:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403991AbhAKXSe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2021 18:18:34 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B56FC061794
        for <linux-pm@vger.kernel.org>; Mon, 11 Jan 2021 15:17:53 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id o6so310455iob.10
        for <linux-pm@vger.kernel.org>; Mon, 11 Jan 2021 15:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1SMcU2clwjDpXCJK5XGOPy9evEO2ZkmmmyeSpWnkqzo=;
        b=L1+RTzlS30PWKtGajGKUYzf3lYvzrFa1iZgpwC/oABOLEWItgwvmATS94OaMClPd08
         TTC4dSMWwmGHhi4/B70+FupsHB2TmG1UExGp61spGneY6lHm/lNVlwMbe6JM1mlJBFcW
         pGd3Fyf5uEywv8l5QQbeSHl7nJH60J5A0TdAvTHXR7qNpFYkvY4rBX5PgFnwZ6mf6fF0
         vXHGI15fPimZE/ROArLXwD6khBbCVRReOF/+jcA+tsBZlaQUGXG6JlE1gCwiYUS/YPXa
         crWLgPze3huQdHiou8ccnR8NaMisZDs6KBQXmyeeAMiH/wJf0tEm6goBpgQJCNCFzqUy
         xPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1SMcU2clwjDpXCJK5XGOPy9evEO2ZkmmmyeSpWnkqzo=;
        b=cMPdYWZIi+UOELRHVNyHv1Pol6vbSPNEeHdsqKOPxi6gEQjdqZPsHrDlkCf/U2jUyz
         9ibNWPw1pMzJL62Lh0Nft9xJqBFYmLV23xXxQlW8xxEWTcvz+qa/rfvg9p5tEg/yOlHj
         USp50V9x3YnZuAzLplRvpbA8wfxQYtz/yo7U0a9AXjp9MS1iMQOVv4ZgMPF+iHMLGIdL
         1eN4bAQrDjpLPndLNPpjOtevzLxPmhBrg7kCwzWBIH3T8JlCkAiI1gFYgHKHBk3nzAOr
         r1rcqYzscTq2jicg6AubDJFghdjuGR/UoJNdtPo/zYQj7REE8gEEYfiyqXh2/fUykTbT
         icEg==
X-Gm-Message-State: AOAM532uRja2cP01fEgBdvxGQgwvtI7CMcj7+NybFi5iJ6AOhYcJIJ9W
        Hu3PSott/8jirDwofDNegthNrw==
X-Google-Smtp-Source: ABdhPJwARI7XlKp+saf8vwkHa28PhErKDJFPLfMlYUrC90/EGDll/IMwejNtlaRVO2ODqOA73ccF3Q==
X-Received: by 2002:a02:6a0e:: with SMTP id l14mr1742689jac.58.1610407072636;
        Mon, 11 Jan 2021 15:17:52 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id o195sm876229ila.38.2021.01.11.15.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 15:17:52 -0800 (PST)
Subject: Re: [PATCH 3/6] thermal/core: Remove pointless test with the
 THERMAL_TRIPS_NONE macro
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com
Cc:     mjg59@codon.org.uk, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, amitk@kernel.org
References: <20201214233811.485669-1-daniel.lezcano@linaro.org>
 <20201214233811.485669-3-daniel.lezcano@linaro.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <8a7ca60c-8f94-b8e3-22d6-32ea2e00459a@linaro.org>
Date:   Mon, 11 Jan 2021 18:17:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201214233811.485669-3-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 12/14/20 6:38 PM, Daniel Lezcano wrote:
> The THERMAL_TRIPS_NONE is equal to -1, it is pointless to do a
> conversion in this function.

It is pointless because you have removed force_passive and
will be removing THERMAL_TRIPS_NONE in the following patches.
Maybe that should be mentioned in the commit message.
Otherwise,

Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>

> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/thermal/thermal_sysfs.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index 4e7f9e880d76..345917a58f2f 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -875,10 +875,7 @@ trip_point_show(struct device *dev, struct device_attribute *attr, char *buf)
>   	instance =
>   	    container_of(attr, struct thermal_instance, attr);
>   
> -	if (instance->trip == THERMAL_TRIPS_NONE)
> -		return sprintf(buf, "-1\n");
> -	else
> -		return sprintf(buf, "%d\n", instance->trip);
> +	return sprintf(buf, "%d\n", instance->trip);
>   }
>   
>   ssize_t
> 

-- 
Warm Regards
Thara
