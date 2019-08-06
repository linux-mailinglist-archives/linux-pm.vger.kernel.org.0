Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7AE882FB0
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2019 12:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732418AbfHFK0X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Aug 2019 06:26:23 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52929 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732290AbfHFK0X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Aug 2019 06:26:23 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so77615034wms.2
        for <linux-pm@vger.kernel.org>; Tue, 06 Aug 2019 03:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ddWdfKYx3//ILp8RsAy94otcPisiGAr731JZJSdCXN4=;
        b=ds3CrbM9sKfayehciGMuSfj/k851WunzNDYI3ThCa9N5xHNmcJCe6RYPtEpBx9X5eB
         I9Fq0gcqMVZr/WZzdM6O1zRaXnI9Uc3gNgRU3hPFHXZlfQJE5/MJZHII7ljx9Rwdp8qk
         VQ+6d/Jl6TDLOfKKvvx+hBGXe5PoxFYc4aBgQTtMXFXvck/MPP34aHIP+9iHWcLQCJkA
         6xkr26e34TgCkZdqlOHB5rSrJmn5u4qP+NJi+T8ipIWso00E6+ZwpHr6Wap0UVsWH75e
         d0GELfp8m4bUnKTUtTJfhD0HK4z60FPNVln4atERGmQPzWx38AmSZ58tY8C8PU9E80AG
         GQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ddWdfKYx3//ILp8RsAy94otcPisiGAr731JZJSdCXN4=;
        b=DA0RO2W+/i7LC1WRRX+hiT7rTD0BsWcNe057rl6lBmS4eIuhBtOUnAxdoK58BxsLDi
         K/hE/cKk1TDE7iROdB08xmFTcChlUotc4w4svIgdVKzarPIM1BG0JF/JkmYaScWLMdNM
         9SS3/s14rJ0Xo70jgbUtx1Tij1m3NQPZ+JMNi9EFKlcUMNFj+R3kM0qZLNbR6oCQ/t5g
         4I+HBHIB3iWroPZrW/RkQ/xqHXwFqLHLJqyexXkpk7hkNvJlZbDlzKRlDBCdALoMlmsl
         ritgN3Bw8WMUE3fmCMaWuZutJoE+PFROODGOCW0Irh+vH0A8XOP1n4a88vpLwNXfVolm
         DLKA==
X-Gm-Message-State: APjAAAXbPfmJ3DuFkMA4+nZdUSUM3RuJ5ng9aJXwNl8FW6eMBhrnSFzk
        QVa8LV5H/sAmMLghEMZ5pJIlUg==
X-Google-Smtp-Source: APXvYqwCYOXYH6t+kS4bd1UZmMi3RBbPzVpO8KiPOOQzHzTl+f3ME7AuvDu+L9cAPdP0Id/RqSNZqA==
X-Received: by 2002:a1c:751a:: with SMTP id o26mr3955986wmc.13.1565087180301;
        Tue, 06 Aug 2019 03:26:20 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:5d72:314c:4797:d781? ([2a01:e34:ed2f:f020:5d72:314c:4797:d781])
        by smtp.googlemail.com with ESMTPSA id p18sm91164774wrm.16.2019.08.06.03.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 03:26:19 -0700 (PDT)
Subject: Re: [PATCH RESEND] thermal/drivers/core: Use put_device() if
 device_register() fails
To:     Yue Hu <zbestahu@gmail.com>, rui.zhang@intel.com,
        edubezval@gmail.com
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-pm@vger.kernel.org, huyue2@yulong.com
References: <20190806020221.8504-1-zbestahu@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6135a0d0-9dc5-7b85-b014-6131f67332fc@linaro.org>
Date:   Tue, 6 Aug 2019 12:26:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806020221.8504-1-zbestahu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/08/2019 04:02, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Never directly free @dev after calling device_register(), even if it
> returned an error! Always use put_device() to give up the reference
> initialized.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---

Thanks for catching this. Instead of adding a new rollback block, can
you do a cleanup in the rollback routine and then add this patch with
the proper label at the end of the function?

eg.

unregister:
	device_unregister(&tz->device);
release_device:
	put_device(&tz->device);
...

remove_id:
	ida_simple_remove(&thermal_tz_ida, tz->id);
free_tz:
	kfree(tz);
	return ERR_PTR(result);


>  drivers/thermal/thermal_core.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 6bab66e..ffe5d8e 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -985,7 +985,7 @@ static void bind_cdev(struct thermal_cooling_device *cdev)
>  	result = device_register(&cdev->device);
>  	if (result) {
>  		ida_simple_remove(&thermal_cdev_ida, cdev->id);
> -		kfree(cdev);
> +		put_device(&cdev->device);
>  		return ERR_PTR(result);
>  	}
>  
> @@ -1292,7 +1292,7 @@ struct thermal_zone_device *
>  	dev_set_name(&tz->device, "thermal_zone%d", tz->id);
>  	result = device_register(&tz->device);
>  	if (result)
> -		goto remove_device_groups;
> +		goto release_device;
>  
>  	for (count = 0; count < trips; count++) {
>  		if (tz->ops->get_trip_type(tz, count, &trip_type))
> @@ -1347,8 +1347,11 @@ struct thermal_zone_device *
>  	device_unregister(&tz->device);
>  	return ERR_PTR(result);
>  
> -remove_device_groups:
> -	thermal_zone_destroy_device_groups(tz);
> +release_device:
> +	ida_simple_remove(&thermal_tz_ida, tz->id);
> +	put_device(&tz->device);
> +	return ERR_PTR(result);
> +
>  remove_id:
>  	ida_simple_remove(&thermal_tz_ida, tz->id);
>  free_tz:
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

