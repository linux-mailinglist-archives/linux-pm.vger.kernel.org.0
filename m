Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48ABF4D1F8D
	for <lists+linux-pm@lfdr.de>; Tue,  8 Mar 2022 18:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348966AbiCHR7S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Mar 2022 12:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348855AbiCHR7S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2022 12:59:18 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C372C134
        for <linux-pm@vger.kernel.org>; Tue,  8 Mar 2022 09:58:21 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id r10so29834225wrp.3
        for <linux-pm@vger.kernel.org>; Tue, 08 Mar 2022 09:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iVgT/lEpt+HT1m7k16bXsNag2nWmHNb7sF0hyEVH5MI=;
        b=mG1cEnyozlb1eSoY4W/KY3M3+ckmtRaS6y+C8q8rQfdIjlukAfk6TM822Vb5+F9CLp
         804h1F3SuBCGzHzRLWG31UInyQx7Cpj4YeUlRynuag0E/rXF9/lZEUia+jEYRi+ak11V
         deFPqNCi4cmtfsIvEwMd0cN695bDjSJkDnx0qxcETYN8IAg23QtoijwyDgcm/eNO5qXJ
         nA6vDdwMof6h+sL9589HHmDtTDj17pMmHRxb8vbT4/sX8PxRZB10gSPoDZAyWEPh+d47
         BcXJ0jT4TCOLCWV8FmRMiQjZ83CJGuOpKiqGSzTtRnsiWA3JrzrxOjI6P4EKjZomNX8W
         vxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iVgT/lEpt+HT1m7k16bXsNag2nWmHNb7sF0hyEVH5MI=;
        b=uam77uoVJVWtKZH9bQx3L9+wayhIrfJeJcZA8Onk1qeErvnmMyXD3Y5F0ffavMNwSW
         9aGuHREONwsRHYNG1Vswa/5LG3qb2WxEgjepvOvZ/ooYHI1/HjV5Vfnptrd//wendbGM
         HXCsFqt8CN76BWP1fsFuJ2CUqutUfUXEMO//bbaMIAFIL+jTc2RHuA8jM79dewV9Q4Yk
         uxvm2ly63D8E6JS6GnwPaTfZQfKuAOh64XC/ht9IxtlTCifq35P+kdQrygvRtO2o7NBv
         cNbQ+rUbCkQhZicUTCOmKgHLTZaBIgbJBip9EIKhMlhkFAxIbJCY26N9aHxf63i/do0o
         HhYQ==
X-Gm-Message-State: AOAM532agF5PTlKNmkIUXvlECsSFknd4rnuzymf14Wts2ho5twM3B+/d
        u0igM6TfKgvyHV4XjjUr25hVUg==
X-Google-Smtp-Source: ABdhPJx47DHEBVNcPDo6vDwgYx6FVCCtJKmihpsvxZqtW+E520kDSJ/bMlJYvbRNJU9yUmCiZ+MU2g==
X-Received: by 2002:adf:a302:0:b0:1ed:bf30:40e3 with SMTP id c2-20020adfa302000000b001edbf3040e3mr13382632wrb.270.1646762299669;
        Tue, 08 Mar 2022 09:58:19 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:1ffc:39b4:7538:de29? ([2a01:e34:ed2f:f020:1ffc:39b4:7538:de29])
        by smtp.googlemail.com with ESMTPSA id bi6-20020a05600c3d8600b00381590dbb25sm2835428wmb.3.2022.03.08.09.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 09:58:19 -0800 (PST)
Message-ID: <c1a0576b-89fa-6e91-b80e-f2aa20dc7c77@linaro.org>
Date:   Tue, 8 Mar 2022 18:58:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drivers/thermal/thermal_of: Add change_mode ops support
 for thermal_of sensor
Content-Language: en-US
To:     Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1646752834-25043-1-git-send-email-quic_manafm@quicinc.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1646752834-25043-1-git-send-email-quic_manafm@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/03/2022 16:20, Manaf Meethalavalappu Pallikunhi wrote:
> The sensor driver which register through thermal_of interface doesn't
> have an option to get thermal zone mode change notification from
> thermal core.
> 
> Add support for change_mode ops in thermal_of interface so that sensor
> driver can use this ops for mode change notification.
> 
> Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
> ---
>   drivers/thermal/thermal_of.c | 14 ++++++++++++++
>   include/linux/thermal.h      |  3 +++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 9233f7e..a4e3820 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -203,6 +203,17 @@ static int of_thermal_get_trend(struct thermal_zone_device *tz, int trip,
>   	return data->ops->get_trend(data->sensor_data, trip, trend);
>   }
>   
> +static int of_thermal_change_mode(struct thermal_zone_device *tz,
> +				enum thermal_device_mode mode)
> +{
> +	struct __thermal_zone *data = tz->devdata;
> +
> +	if (!data->ops || !data->ops->change_mode)
> +		return -EINVAL;


If this function is called it is because below in the bind function 
ops->change_mode was true, so the condition above is always true, no ?


> +	return data->ops->change_mode(data->sensor_data, mode);
> +}
> +
>   static int of_thermal_bind(struct thermal_zone_device *thermal,
>   			   struct thermal_cooling_device *cdev)
>   {
> @@ -408,6 +419,9 @@ thermal_zone_of_add_sensor(struct device_node *zone,
>   	if (ops->set_emul_temp)
>   		tzd->ops->set_emul_temp = of_thermal_set_emul_temp;
>   
> +	if (ops->change_mode)
> +		tzd->ops->change_mode = of_thermal_change_mode;
> +
>   	mutex_unlock(&tzd->lock);
>   
>   	return tzd;
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index c3148939..365733b 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -299,6 +299,8 @@ struct thermal_zone_params {
>    *		   temperature.
>    * @set_trip_temp: a pointer to a function that sets the trip temperature on
>    *		   hardware.
> + * @change_mode: a pointer to a function that notifies the thermal zone
> + *		   mode change.
>    */
>   struct thermal_zone_of_device_ops {
>   	int (*get_temp)(void *, int *);
> @@ -306,6 +308,7 @@ struct thermal_zone_of_device_ops {
>   	int (*set_trips)(void *, int, int);
>   	int (*set_emul_temp)(void *, int);
>   	int (*set_trip_temp)(void *, int, int);
> +	int (*change_mode) (void *, enum thermal_device_mode);
>   };
>   
>   /* Function declarations */


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
