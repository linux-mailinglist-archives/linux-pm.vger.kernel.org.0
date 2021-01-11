Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D57B2F242E
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jan 2021 01:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391731AbhALAZk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jan 2021 19:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403949AbhAKXQL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2021 18:16:11 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF34C061794
        for <linux-pm@vger.kernel.org>; Mon, 11 Jan 2021 15:15:30 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id q5so1010027ilc.10
        for <linux-pm@vger.kernel.org>; Mon, 11 Jan 2021 15:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FwCcHXIwvmfHyHokPaF3+kDwTlr3KIMrsOj6iB1l8/Q=;
        b=qL/hoG0x3VGuUVJz3XLblstAzv7RI+xZIW3smtXYnQRW4+8KdZGgHmfTh688qhpLeg
         iqg+P6k87I7DbzWA3juYgmQ9CrQLYfEoDydeKLUCRaxv6UX9bw4nzW8jjnEcSD63jde+
         kyGB0VQJgBHRWdCjUdFu08B1Sbs6YdmdHfe1/JB3b0H+Qa2xXiQRqZJq/4fuPSKbvO+o
         iUoQFhMzWrgfYsMJk7LmBGcYJHjr88tPPkAPogG21vpJ9CkTy/S5d3J/NAGfj+VWFm+v
         ehHacRctZyNAknOwDjjpOv8AbXcHVukwo+JPhEvA1OKyrhbTZ6qdjevI2PQpJQI2nPPZ
         U3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FwCcHXIwvmfHyHokPaF3+kDwTlr3KIMrsOj6iB1l8/Q=;
        b=SS5zfWfvRR4xgdL26WPZxRgsfLdSxTjYjykEzujjhTG/n+eNOHWBN9d8WVepOxLw2q
         snId7Qy7oqKjdfI+BKzJJx6ibVEYhgHVNOkqMjPer9DsZEx+5sGk3TPH54udPUhdhRRd
         ZbZmSS9zQiRuEYU8VdfkAhIjoT33rlqlhT9GAGyibrbLNsMl/ux75tmJBfQG2Y0qVEWm
         NbAVUPk/V77w9p5j7xF+bh6GgEUMGW5QamR0e+G2/mvO7sKnu6MvbltF+bho9iJWXvjh
         LtTwpG2TC2gYizQW7wFM1MaIAVZFg0/G6gXmdVD/EvdHnr0cHr1D3bbF6Il5K5BIs7sm
         Z9HQ==
X-Gm-Message-State: AOAM5318hPxLGdX2ZPG2NUbel3eLmGMVwFxHuXR0ChLGiFy+TyxiyDoG
        gorGB5H3r2aTw4LzxHShSsVpkSzrScJI1g==
X-Google-Smtp-Source: ABdhPJzE5u69CLhCljTsjOjdO9D9yYr3OMEAqnW01A3juxITd/peCCFGR8IZn1ZeYZKw+NT0vaCZhA==
X-Received: by 2002:a92:bbcb:: with SMTP id x72mr1315983ilk.104.1610406930122;
        Mon, 11 Jan 2021 15:15:30 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id y5sm867733ilh.24.2021.01.11.15.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 15:15:29 -0800 (PST)
Subject: Re: [PATCH 2/6] thermal/core: Remove unused functions rebind/unbind
 exception
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com
Cc:     mjg59@codon.org.uk, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, amitk@kernel.org
References: <20201214233811.485669-1-daniel.lezcano@linaro.org>
 <20201214233811.485669-2-daniel.lezcano@linaro.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <7aa8396e-9dab-09ad-0eb6-86b412fccd02@linaro.org>
Date:   Mon, 11 Jan 2021 18:15:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201214233811.485669-2-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 12/14/20 6:38 PM, Daniel Lezcano wrote:
> The functions thermal_zone_device_rebind_exception and
> thermal_zone_device_unbind_exception are not used from anywhere.
> 
> Remove that code.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>

> ---
>   drivers/thermal/thermal_core.c | 37 ----------------------------------
>   drivers/thermal/thermal_core.h |  4 ----
>   2 files changed, 41 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 567bc6f254c0..a0f0c33c8d9c 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -598,26 +598,6 @@ static void thermal_zone_device_check(struct work_struct *work)
>   	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
>   }
>   
> -void thermal_zone_device_rebind_exception(struct thermal_zone_device *tz,
> -					  const char *cdev_type, size_t size)
> -{
> -	struct thermal_cooling_device *cdev = NULL;
> -
> -	mutex_lock(&thermal_list_lock);
> -	list_for_each_entry(cdev, &thermal_cdev_list, node) {
> -		/* skip non matching cdevs */
> -		if (strncmp(cdev_type, cdev->type, size))
> -			continue;
> -
> -		/* re binding the exception matching the type pattern */
> -		thermal_zone_bind_cooling_device(tz, THERMAL_TRIPS_NONE, cdev,
> -						 THERMAL_NO_LIMIT,
> -						 THERMAL_NO_LIMIT,
> -						 THERMAL_WEIGHT_DEFAULT);
> -	}
> -	mutex_unlock(&thermal_list_lock);
> -}
> -
>   int for_each_thermal_governor(int (*cb)(struct thermal_governor *, void *),
>   			      void *data)
>   {
> @@ -685,23 +665,6 @@ struct thermal_zone_device *thermal_zone_get_by_id(int id)
>   	return match;
>   }
>   
> -void thermal_zone_device_unbind_exception(struct thermal_zone_device *tz,
> -					  const char *cdev_type, size_t size)
> -{
> -	struct thermal_cooling_device *cdev = NULL;
> -
> -	mutex_lock(&thermal_list_lock);
> -	list_for_each_entry(cdev, &thermal_cdev_list, node) {
> -		/* skip non matching cdevs */
> -		if (strncmp(cdev_type, cdev->type, size))
> -			continue;
> -		/* unbinding the exception matching the type pattern */
> -		thermal_zone_unbind_cooling_device(tz, THERMAL_TRIPS_NONE,
> -						   cdev);
> -	}
> -	mutex_unlock(&thermal_list_lock);
> -}
> -
>   /*
>    * Device management section: cooling devices, zones devices, and binding
>    *
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index 8df600fa7b79..e50c6b2909fe 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -118,10 +118,6 @@ struct thermal_instance {
>   
>   int thermal_register_governor(struct thermal_governor *);
>   void thermal_unregister_governor(struct thermal_governor *);
> -void thermal_zone_device_rebind_exception(struct thermal_zone_device *,
> -					  const char *, size_t);
> -void thermal_zone_device_unbind_exception(struct thermal_zone_device *,
> -					  const char *, size_t);
>   int thermal_zone_device_set_policy(struct thermal_zone_device *, char *);
>   int thermal_build_list_of_policies(char *buf);
>   
> 

-- 
Warm Regards
Thara
