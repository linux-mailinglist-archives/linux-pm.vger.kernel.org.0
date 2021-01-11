Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC322F242B
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jan 2021 01:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388391AbhALAZl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jan 2021 19:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404011AbhAKXTN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2021 18:19:13 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89FFC061795
        for <linux-pm@vger.kernel.org>; Mon, 11 Jan 2021 15:18:32 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id q5so1017524ilc.10
        for <linux-pm@vger.kernel.org>; Mon, 11 Jan 2021 15:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aUUZwHzjsRYlgS0NeBcgamHcfmVNx8VRCg6rcyz29Ew=;
        b=JOmh6HLIkJ9lOpv74pzfRyhuDr03MiEHvX/RCjvThgjrpvgVp90RYHFCR0sOTKeKmv
         MSRmnPa/jurKPJIrVi4fb848glclEjyoe2BO7biC7i7YPd1X8RpkyM34x73w8bZwShEi
         V6UB+/qGpJZah5ihPnoY8Fb8Vh3/VS+OXhLM717MlZSBhP6inNdXxWv0b8CjVCO79KN0
         Sk1zjoxY9JuEWTOYq3HRJjeFNFllzS2Il7GtRgp+Aid/FtZktKXZTA3cOEHRgLV/xTMq
         y9w3fu7p/h2uCD92au2hdM52RfXuQz//UtEr87He/JM9lBVXSXEG+SS/YJO5kKGPrHkj
         SjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aUUZwHzjsRYlgS0NeBcgamHcfmVNx8VRCg6rcyz29Ew=;
        b=oLktDBO9hI5CFIV6kYJ6U7uXjSOUuYqP41QkA2BJFcbv/fHJjh38Z7Bq7KtSDTNvO8
         w8pVCq2XLWe+FwhrT/7OF2nx/CJJy1iDhtuGs0EYbf7EqHm/pNRpb54gB8MlFCrClGpP
         jrgRCToVsLaT568GbW7DPjd7nbARP2/w/NnT7T8fp8O5OzNKOKfnz4WfgFN0VGPe4HZL
         w86D7E6yTTYn2f4gBOwGqGtJY0Daj3Y9/HBr1NetLg+X26cLlKfVfYcjpmFmC7dH6Pwr
         EE4fkdPoorxlPpA5ORxwTSDuEWCzvXj7PwEB2J6aveF+N23jT1jDke9Tq3gOA3Mp/jCs
         OkSw==
X-Gm-Message-State: AOAM533ynuujmjcr/zeh7C1j6rJSz9lMmnP7ia82hRCATYnKvVjCQzf2
        UfTobjADf7s1WGQhmO1qY26DOA==
X-Google-Smtp-Source: ABdhPJyU/ftyqly4VUye4FW0Xp/hyN7hsyGsYakMBkzkvhlCZo4F7n22Hmjf2SP0tboQmAEvWTPo2w==
X-Received: by 2002:a05:6e02:f93:: with SMTP id v19mr1305913ilo.154.1610407112352;
        Mon, 11 Jan 2021 15:18:32 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id p19sm835661ili.84.2021.01.11.15.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 15:18:31 -0800 (PST)
Subject: Re: [PATCH 5/6] thermal/core: Remove THERMAL_TRIPS_NONE test
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com
Cc:     mjg59@codon.org.uk, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, amitk@kernel.org
References: <20201214233811.485669-1-daniel.lezcano@linaro.org>
 <20201214233811.485669-5-daniel.lezcano@linaro.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <6d1a9bc5-e124-b6ee-41f8-b7042c093c1a@linaro.org>
Date:   Mon, 11 Jan 2021 18:18:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201214233811.485669-5-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 12/14/20 6:38 PM, Daniel Lezcano wrote:
> The last site calling the thermal_zone_bind_cooling_device() function
> with the THERMAL_TRIPS_NONE parameter was removed.
> 
> We can get rid of this test as no user of this function is calling
> this function with this parameter.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>

>   drivers/thermal/thermal_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index a0f0c33c8d9c..bcc2ea4f5482 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -710,7 +710,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
>   	unsigned long max_state;
>   	int result, ret;
>   
> -	if (trip >= tz->trips || (trip < 0 && trip != THERMAL_TRIPS_NONE))
> +	if (trip >= tz->trips || trip < 0)
>   		return -EINVAL;
>   
>   	list_for_each_entry(pos1, &thermal_tz_list, node) {
> 

-- 
Warm Regards
Thara
