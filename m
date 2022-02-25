Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9034D4C43DB
	for <lists+linux-pm@lfdr.de>; Fri, 25 Feb 2022 12:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbiBYLrP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Feb 2022 06:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240253AbiBYLrO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Feb 2022 06:47:14 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B241CB855
        for <linux-pm@vger.kernel.org>; Fri, 25 Feb 2022 03:46:35 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c18-20020a7bc852000000b003806ce86c6dso1506333wml.5
        for <linux-pm@vger.kernel.org>; Fri, 25 Feb 2022 03:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NK/LzwUva0Lkr32qtgOj2yS2vQ6HzLDYt6awzfuVPIw=;
        b=ptQ69NYEkWgoJSQxryIG7Mez4hxuXVxNWO6LIDIXpbsP9lxpyFCQp6nFEMpzZ8Ne7P
         5CE7UQYO9TtATFK4sNokxCArE3tPx02ZckvHJekle7QWJxYK+9iVKyT5xnHCMfOOMQFZ
         3vN/SgNtzaDhAu96lJJvcyOmwANR92iNMpq4vk7mmk2c86sys5QBXaACP8EwZlGEnoMG
         BelatBwgucNdC0sZESxOZ2cPZ5ulj3rxHv9ohxdmuOHccdS8hqt0+EEYkGIx467vgXAx
         3B/RYVpiFnVOCn/FIxxHavgN0l345TlnDlkjS/JSl2xlHrBiiiEYL5bxhVhyTS9gI1rE
         0BJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NK/LzwUva0Lkr32qtgOj2yS2vQ6HzLDYt6awzfuVPIw=;
        b=uDugQ+Ad1wRQ053kweFrCYnmJEErok5G4P+e2FfW1+TIvZjekgYDlY/ZIZqZo3wcAZ
         ITjS8kcGHIs6GVVl7y42Pbqy6i5N+Zfr2I+XDjg0sxg4ZO00K8LlBYX8q+Rd8svNUpSe
         TEXYpDIOB3HOQoJ4ivrgFRWwDLJd9pzz1LjjNYvFoy2TFvBdjRQ2vlXNYrYvsfAWXwtD
         sc+5Z3JZWCXI4e1E3zwXcPHxk8bdMoByr8BrTAbiqa65DdeLLwwazzoEZF61plvCjzYg
         8NxWsVBP8objKbhBSbkqNWz8o/iq0jz/UuBY+1TCy4xFR0ZmGDUcdmOSHqL8c4iCFx1s
         3t8Q==
X-Gm-Message-State: AOAM532iMUAVMRrXQEmPi1UWHi8GkL9Tso6te/XAHgKgQKyF3D0vs7Zz
        /QkQhQHlsnjtGS8zBs29n3X/qw==
X-Google-Smtp-Source: ABdhPJz3TyYDkpSSB0/EXBpY4m7TRQh0Wp8kjUatWyQZJ+KB1tyNYztQ1QI7/GvQgleuwoBy9PhpYA==
X-Received: by 2002:a05:600c:4e89:b0:37b:bc9a:4618 with SMTP id f9-20020a05600c4e8900b0037bbc9a4618mr2290607wmq.160.1645789593745;
        Fri, 25 Feb 2022 03:46:33 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:25a:d4d2:9383:c638? ([2a01:e34:ed2f:f020:25a:d4d2:9383:c638])
        by smtp.googlemail.com with ESMTPSA id p11-20020adfce0b000000b001e7026150besm2030922wrn.31.2022.02.25.03.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 03:46:33 -0800 (PST)
Message-ID: <c6b8e5fd-4315-859f-b4a2-a3a055143ddf@linaro.org>
Date:   Fri, 25 Feb 2022 12:46:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drivers/thermal/ti-soc-thermal: Add hwmon support
Content-Language: en-US
To:     Romain Naour <romain.naour@smile.fr>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org
Cc:     j-keerthy@ti.com, edubezval@gmail.com
References: <20220218104725.2718904-1-romain.naour@smile.fr>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220218104725.2718904-1-romain.naour@smile.fr>
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


Hi Romain,

I'll apply the patch.

In the future, use the scripts/get_maintainer.pl -f <file> to get the 
recipients of your patch if you have a doubt about who to send it to.

Thanks

   -- Daniel

On 18/02/2022 11:47, Romain Naour wrote:
> Expose ti-soc-thermal thermal sensors as HWMON devices.
> 
>    # sensors
>    cpu_thermal-virtual-0
>    Adapter: Virtual device
>    temp1:        +54.2 C  (crit = +105.0 C)
> 
>    dspeve_thermal-virtual-0
>    Adapter: Virtual device
>    temp1:        +51.4 C  (crit = +105.0 C)
> 
>    gpu_thermal-virtual-0
>    Adapter: Virtual device
>    temp1:        +54.2 C  (crit = +105.0 C)
> 
>    iva_thermal-virtual-0
>    Adapter: Virtual device
>    temp1:        +54.6 C  (crit = +105.0 C)
> 
>    core_thermal-virtual-0
>    Adapter: Virtual device
>    temp1:        +52.6 C  (crit = +105.0 C)
> 
> Similar to imx_sc_thermal d2bc4dd91da6095a769fdc9bc519d3be7ad5f97a.
> 
> No need to take care of thermal_remove_hwmon_sysfs() since
> devm_thermal_add_hwmon_sysfs() (a wrapper around devres) is
> used. See c7fc403e40b0ea18976a59e968c23439a80809e8.
> 
> Signed-off-by: Romain Naour <romain.naour@smile.fr>
> ---
>   drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> index f84375865c97..0959632b2170 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> @@ -21,6 +21,7 @@
>   
>   #include "ti-thermal.h"
>   #include "ti-bandgap.h"
> +#include "../thermal_hwmon.h"
>   
>   /* common data structures */
>   struct ti_thermal_data {
> @@ -189,6 +190,9 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
>   	ti_bandgap_set_sensor_data(bgp, id, data);
>   	ti_bandgap_write_update_interval(bgp, data->sensor_id, interval);
>   
> +	if (devm_thermal_add_hwmon_sysfs(data->ti_thermal))
> +		dev_warn(bgp->dev, "failed to add hwmon sysfs attributes\n");
> +
>   	return 0;
>   }
>   


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
