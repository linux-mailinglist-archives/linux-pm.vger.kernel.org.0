Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5704468A1
	for <lists+linux-pm@lfdr.de>; Fri,  5 Nov 2021 19:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhKESvq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Nov 2021 14:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbhKESvf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Nov 2021 14:51:35 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A3AC061714
        for <linux-pm@vger.kernel.org>; Fri,  5 Nov 2021 11:48:55 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id v2so7870874qve.11
        for <linux-pm@vger.kernel.org>; Fri, 05 Nov 2021 11:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Yw+xYYZxJY7aqJNmLJZqOSvkSUnGIUGzQbrZ89NrdYY=;
        b=IUvwPhlHPqszZsAvbv+dcliHFp/WpGdH694upHpX58UFOvrraajf4xRiPtUEESlFVC
         Tq5AxF3WsE9/hDfFLWirPsNthoPGxbxmDfSKT0kmKviloXLurGTpV7iTtQ47h3sSOpuf
         M/W1GQOyFFfU4W3pO1SWfg6Mn2XvzrsiZDUmHtv3KxdiJXWzXdPpNZr/Xw0y6ngmDgnB
         3OgCDZig9jBlo9Ms7oZVP7U96m/LEkBXz0lUDzGRAIHQkX8YnK/BXPBrz8ZU+lypsk7b
         owtsnIU69/4e8emMtvgs40ce9w1+K7jp8Ea8JJ3yzzYSE6oOu+d+r9SS17GDUDAxMPHZ
         mmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yw+xYYZxJY7aqJNmLJZqOSvkSUnGIUGzQbrZ89NrdYY=;
        b=kUJ6BXynen0Igo7F4GrKJdcHKMWYrqCV7jr5HVDrGNwcrmrLqkZZGGgVU5R0CthHtJ
         o+Y8maZIbR1ig/QC2FhCohiBhmWgUmcwho2LiE1qIyaBrKp7M8fqi5tDYluM0nM9piRb
         IFX+/PK4/vXJ7kNmG1bMpYYvUJq/6codJyKiiR8oBivI7P0TFNRpTr0YWdYUut7ypZYB
         lrXin4QP//XlSQ9hjaC9TQ9/GOgG4eq3aRdDt45VBX/rg21pSe187DPgKI3zTgULwP1D
         aGF2Mt1zLGvuRzcoTCCP/XpZrMuQAE3jIehcXC30WyoRVWc8qjVFkU/xFAfnn7giC3j7
         tPOQ==
X-Gm-Message-State: AOAM532rg36i/yoJLZa4L+yb5a/yOC7oSFFxap6jeW92MmEDEKBlnH5t
        jwCpZ8D9b18BQ3WX/s14jJLF/Vc51qCttQ==
X-Google-Smtp-Source: ABdhPJxGYWjCLEtLuovCaU8pO2vakxfS89lE+CcanM5jT+pZM72mN3wyu/fpt4pc0r8+TvzyQ4Q7/w==
X-Received: by 2002:ad4:5747:: with SMTP id q7mr935708qvx.19.1636138134991;
        Fri, 05 Nov 2021 11:48:54 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id s14sm724536qkg.115.2021.11.05.11.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 11:48:54 -0700 (PDT)
Subject: Re: [PATCH] drivers: thermal: Reset previous low and high trip during
 thermal zone init
To:     Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1635883240-24293-1-git-send-email-manafm@codeaurora.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <51de966a-9c9e-88a8-5c2c-96773a64d527@linaro.org>
Date:   Fri, 5 Nov 2021 14:48:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1635883240-24293-1-git-send-email-manafm@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/2/21 4:00 PM, Manaf Meethalavalappu Pallikunhi wrote:
> During the suspend is in process, thermal_zone_device_update bails out
> thermal zone re-evaluation for any sensor trip violation without
> setting next valid trip to that sensor. It assumes during resume
> it will re-evaluate same thermal zone and update trip. But when it is
> in suspend temperature goes down and on resume path while updating
> thermal zone if temperature is less than previously violated trip,
> thermal zone set trip function evaluates the same previous high and
> previous low trip as new high and low trip. Since there is no change
> in high/low trip, it bails out from thermal zone set trip API without
> setting any trip. It leads to a case where sensor high trip or low
> trip is disabled forever even though thermal zone has a valid high
> or low trip.
> 
> During thermal zone device init, reset thermal zone previous high
> and low trip. It resolves above mentioned scenario.
> 
> Signed-off-by: Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>

Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>

-- 
Warm Regards
Thara (She/Her/Hers)

> ---
>   drivers/thermal/thermal_core.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 21db445..2b7a0b4 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -477,6 +477,8 @@ static void thermal_zone_device_init(struct thermal_zone_device *tz)
>   {
>   	struct thermal_instance *pos;
>   	tz->temperature = THERMAL_TEMP_INVALID;
> +	tz->prev_low_trip = -INT_MAX;
> +	tz->prev_high_trip = INT_MAX;
>   	list_for_each_entry(pos, &tz->thermal_instances, tz_node)
>   		pos->initialized = false;
>   }
> 


