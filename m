Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A352745A95
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jul 2023 12:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjGCKts (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Jul 2023 06:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGCKtr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jul 2023 06:49:47 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2D5C9
        for <linux-pm@vger.kernel.org>; Mon,  3 Jul 2023 03:49:45 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3142ee41fd2so1698411f8f.3
        for <linux-pm@vger.kernel.org>; Mon, 03 Jul 2023 03:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688381384; x=1690973384;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zMW2KHTH1k0saqLVq/PnPXDqIo/Gx/E/p4VUDDJ1U6I=;
        b=xQz8HMvpLJVieB4c9yZXE+Rye0x0kYj33cRkcKT6vgt7AvsEHPs8dYp7I+qHygHRzk
         UefOUx6ZcnvS/QAH8zpOZzcAqIrxsp1OMjt9JAT98ZXYPJYkO1jsOOpZuMmbQ156iLCz
         ybEybLHXiiB7S9pshS5axn//NaIapIDZQnkUcfIazZQ95/bGG1cI7+f/5Pg2gZzQGVbk
         D+q0MGfCZnfc3CF1xJ9at5kod8QdcGnWGeq6Ece3WU7/PcMCiui2SF/Bm6WLvIPoZ+xd
         aWKjNzLAPhQ8aXTqtzzwP31GjqSxdPnpLQJpQUI4UZ2G5aa/2mrdV3Nu4DZukGrZTFA4
         8HBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688381384; x=1690973384;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zMW2KHTH1k0saqLVq/PnPXDqIo/Gx/E/p4VUDDJ1U6I=;
        b=GDSFX/hFTfv24Xt7+gjINdy4L9rKml59mylQzuP9vAoItl+zwARxJiN3s0jFIJIN/q
         HQsDl3mzUzD+O/sIF+Jc9zs8bJzqieGzWwMRRuzk8XD6JWygIa9gZ5+Gc0gPIDxUOjkg
         Y79Zz+EIUNeP/6FbmUtTwZ4NhfIG+XnIzgsm1U3A8eb8wIH5LAyL3jC6+ZGCktg1LDJG
         lPUY/fNZeRbeFqX41feLsarNVVWK+FxGJhL5b0DWyWR8e/B0BDGKtYkPa7ffs+mRF/Ph
         PToeZ1huR4VJndIX/eekT/40hVCeOPN/vdXREMQ1CXYG7kMikt2eH5GrQUszSeJ87QKd
         7Dpw==
X-Gm-Message-State: ABy/qLaqJj6juB46UvSlQL68zG2Ao1k5oyoXIruh1ezDEk/z45v4cBEQ
        LdGnlV22DoacHcMudPSK99w45g==
X-Google-Smtp-Source: APBJJlHh1kEDO3WvQRwg3cckAYEOuNmTZgbNy8OPVJ7dqdRYLMFr56tfQYYhCFk91HcsV2nV9M+gdQ==
X-Received: by 2002:adf:f0d2:0:b0:314:1ddc:ecbd with SMTP id x18-20020adff0d2000000b003141ddcecbdmr7234708wro.18.1688381384261;
        Mon, 03 Jul 2023 03:49:44 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id x5-20020adff645000000b0031432f1528csm3856060wrp.45.2023.07.03.03.49.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 03:49:43 -0700 (PDT)
Message-ID: <ab892878-9c66-f94f-cf4c-9961723411d2@linaro.org>
Date:   Mon, 3 Jul 2023 12:49:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5/8] thermal/drivers/int3400: Use thermal zone device
 wrappers
Content-Language: en-US
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     linux-pm@vger.kernel.org, thierry.reding@gmail.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        open list <linux-kernel@vger.kernel.org>, rafael@kernel.org
References: <20230525140135.3589917-1-daniel.lezcano@linaro.org>
 <20230525140135.3589917-6-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230525140135.3589917-6-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Srinivas,

do you agree with the changes in patches 5 and 6 ?

Thanks

   -- Daniel


On 25/05/2023 16:01, Daniel Lezcano wrote:
> The driver is accessing the thermal zone device structure but the
> accessors are already existing and we want to consolidate the thermal
> core code by preventing accesses to the internals from the drivers.
> 
> Let's use these accessors.
> 
> On the other side, the code is getting directly the temperature from
> tz->temperature, but the temperature is a faked on, so we can replace
> this access by the fake temp and remove the thermal zone device
> structure access.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   .../thermal/intel/int340x_thermal/int3400_thermal.c  | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index 810231b59dcd..66e34241b33a 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -15,6 +15,7 @@
>   #define INT3400_THERMAL_TABLE_CHANGED 0x83
>   #define INT3400_ODVP_CHANGED 0x88
>   #define INT3400_KEEP_ALIVE 0xA0
> +#define INT3400_FAKE_TEMP (20 * 1000) /* faked temp sensor with 20C */
>   
>   enum int3400_thermal_uuid {
>   	INT3400_THERMAL_ACTIVE = 0,
> @@ -453,6 +454,7 @@ static void int3400_notify(acpi_handle handle,
>   			void *data)
>   {
>   	struct int3400_thermal_priv *priv = data;
> +	struct device *dev;
>   	char *thermal_prop[5];
>   	int therm_event;
>   
> @@ -475,12 +477,14 @@ static void int3400_notify(acpi_handle handle,
>   		return;
>   	}
>   
> -	thermal_prop[0] = kasprintf(GFP_KERNEL, "NAME=%s", priv->thermal->type);
> -	thermal_prop[1] = kasprintf(GFP_KERNEL, "TEMP=%d", priv->thermal->temperature);
> +	dev = thermal_zone_device(priv->thermal);
> +	
> +	thermal_prop[0] = kasprintf(GFP_KERNEL, "NAME=%s", thermal_zone_device_type(priv->thermal));
> +	thermal_prop[1] = kasprintf(GFP_KERNEL, "TEMP=%d", INT3400_FAKE_TEMP);
>   	thermal_prop[2] = kasprintf(GFP_KERNEL, "TRIP=");
>   	thermal_prop[3] = kasprintf(GFP_KERNEL, "EVENT=%d", therm_event);
>   	thermal_prop[4] = NULL;
> -	kobject_uevent_env(&priv->thermal->device.kobj, KOBJ_CHANGE, thermal_prop);
> +	kobject_uevent_env(&dev->kobj, KOBJ_CHANGE, thermal_prop);
>   	kfree(thermal_prop[0]);
>   	kfree(thermal_prop[1]);
>   	kfree(thermal_prop[2]);
> @@ -490,7 +494,7 @@ static void int3400_notify(acpi_handle handle,
>   static int int3400_thermal_get_temp(struct thermal_zone_device *thermal,
>   			int *temp)
>   {
> -	*temp = 20 * 1000; /* faked temp sensor with 20C */
> +	*temp = INT3400_FAKE_TEMP;
>   	return 0;
>   }
>   

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

