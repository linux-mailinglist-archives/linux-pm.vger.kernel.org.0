Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12B5FA0211
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2019 14:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfH1MnQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Aug 2019 08:43:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37527 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfH1MnP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Aug 2019 08:43:15 -0400
Received: by mail-wm1-f67.google.com with SMTP id d16so2714830wme.2
        for <linux-pm@vger.kernel.org>; Wed, 28 Aug 2019 05:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GgZSFiFsRt1AU3MqF6l9POzUxc4G0n+3u20J9HvhKkQ=;
        b=TAh0bfCVMgzvAgbtWuq1MqB4fBqh2wuoQE3zqjztTbGFvyhZv4Uo2WYtYXbvs5TjFD
         KGhQZ/3DHd5dxiOaUzW4uAJLcBkPKe21SlWlxvLnWGGBJbahroi09eCh6UVC5QfyEx6i
         ze4VVXnugmIG10j17WXnCRHMUnKxpbAhV9yDqNLdvIzpftgDzlaGrTekBE8lC+jqb0TT
         tz8TJmMRIcWqhzElYYr26DmNGQKxE1cxtTNdUTyLG1vMIjJlqy8bYwu2kaA1w71Xx6mk
         MTI1BLhzqmX56V9DbwNZw2K7WyTkzfuBUlBDH5M0KUtR2wzGfQtzjv298ItcvgkHe5U/
         /nYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GgZSFiFsRt1AU3MqF6l9POzUxc4G0n+3u20J9HvhKkQ=;
        b=KRkxoPpRwFTIWXiu6Viojj/Kaa598QAWME+iYLDfZopGlau+F9NHZnUMZqPyhU0Ao2
         qWRrzqpaYyyMAw4ln0jRuC5JOS9EAjCtQmfJDZ6P+IZ/l+Td7OIE0gmUhvkg9ItSJbLf
         p2PXBiIgiVFLR2QQ6JOfrT7uG8lYG70nvuyQ1EzwTWqslufe2laeATZneBBbNbxsuUYl
         cGd9CR4z39wIGbIjEkiqJGKwgwRhpOwKn2Se7sC3Ej4jsfzEC1rNt3CNfPVZBoQ5eLVi
         RQ6lFninKxYGDlTytVciYw0TejF/OimyWCP2Outb5wO3Xiy+DqlANMb72a5tPBXmBwZp
         tPug==
X-Gm-Message-State: APjAAAXmQqe6fE2xu85f3AafvGcniaTtw1v1lraMTZtjQd3dzatE97ky
        WKEya23UGLZE+pjRhtUzWLEg0g==
X-Google-Smtp-Source: APXvYqxWlPhP1zINrdy3Q7L7t50UQfkgkvyLFjEPo2KVggVH8DEEQyFdbynWP2h36jr7+ghRytoIMA==
X-Received: by 2002:a1c:7606:: with SMTP id r6mr4838469wmc.78.1566996192510;
        Wed, 28 Aug 2019 05:43:12 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:d017:b064:99a0:3097? ([2a01:e34:ed2f:f020:d017:b064:99a0:3097])
        by smtp.googlemail.com with ESMTPSA id j17sm2651613wru.24.2019.08.28.05.43.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 05:43:11 -0700 (PDT)
Subject: Re: [PATCH 3/3 v3] thermal: db8500: Rewrite to be a pure OF sensor
To:     Linus Walleij <linus.walleij@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20190828122131.23547-1-linus.walleij@linaro.org>
 <20190828122131.23547-3-linus.walleij@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <93d6262c-26f8-8cf3-ff27-17dafc4f255a@linaro.org>
Date:   Wed, 28 Aug 2019 14:43:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828122131.23547-3-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/08/2019 14:21, Linus Walleij wrote:
> This patch rewrites the DB8500 thermal sensor to be a
> pure OF sensor, so that it can be used with thermal zones
> defined in the device tree.
> 
> This driver was initially merged before we had generic
> thermal zone device tree bindings, and now it gets
> modernized to the way we do things these days.
> 
> The old driver depended on a set of trigger points
> provided in the device tree or platform data to
> interpolate the current temperature between trigger
> points depending on whether the trend was rising or
> falling. This was bad because the trigger points should
> be used for defining temperature zone policies and
> bind to cooling devices.
> 
> As the PRCMU (power reset control management unit) can
> only issue IRQs when we pass temperature trigger points
> upward or downward We instead define a number of
> temperature points inside the driver ranging from
> 15 to 100 degrees celsius. The effect is that when
> we register the device we quickly trigger 15, 20 ... up
> to the room temperature in succession and then we
> get continous event IRQs also under normal operating
> conditions, and the temperature of the system is now
> reported more accurately (+/- 2.5 degrees celsius)
> while in the past the first trigger point was at 70
> degrees and the average temperature was simply reported
> as 35 degrees celsius (between 70 degrees and 0) until
> we passed 70 degrees which didn't accurately represent
> the temperature of the system.
> 
> As a result of dropping all the trigger points from the
> driver and reusing the core DT thermal zone management
> code we reduce the code footprint quite a bit.
> 
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Drop pointless mode in the state container
> - Drop pointless mutex
> ChangeLog v1->v2:
> - New patch as suggested by Daniel.
> ---
>  drivers/thermal/db8500_thermal.c | 480 ++++++++-----------------------
>  1 file changed, 125 insertions(+), 355 deletions(-)
> 

[ ... ]

>  static irqreturn_t prcmu_low_irq_handler(int irq, void *irq_data)
>  {
> -	struct db8500_thermal_zone *pzone = irq_data;
> -	struct db8500_thsens_platform_data *ptrips = pzone->trip_tab;
> -	unsigned int idx = pzone->cur_index;
> +	struct db8500_thermal_zone *th = irq_data;
> +	unsigned int idx = th->cur_index;
>  	unsigned long next_low, next_high;
>  
> -	if (unlikely(idx == 0))
> +	if (idx == 0)
>  		/* Meaningless for thermal management, ignoring it */
>  		return IRQ_HANDLED;
>  
>  	if (idx == 1) {
> -		next_high = ptrips->trip_points[0].temp;
> +		next_high = db8500_thermal_points[0];
>  		next_low = PRCMU_DEFAULT_LOW_TEMP;
>  	} else {
> -		next_high = ptrips->trip_points[idx-1].temp;
> -		next_low = ptrips->trip_points[idx-2].temp;
> +		next_high = db8500_thermal_points[idx - 1];
> +		next_low = db8500_thermal_points[idx - 2];
>  	}
>  	idx -= 1;
>  
> -	db8500_thermal_update_config(pzone, idx, THERMAL_TREND_DROPPING,
> -		next_low, next_high);
> -
> -	dev_dbg(&pzone->therm_dev->device,
> +	db8500_thermal_update_config(th, idx, THERMAL_TREND_DROPPING,
> +				     next_low, next_high);
> +	dev_dbg(&th->tz->device,
>  		"PRCMU set max %ld, min %ld\n", next_high, next_low);
>  
> -	schedule_work(&pzone->therm_work);
> +	schedule_work(&th->work);

We are already in the threaded environment, isn't possible to call
directly thermal_zone_device_update() and kill this workq ?

That what is done in the other drivers AFAICT.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/thermal/imx_thermal.c#n638

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/thermal/hisi_thermal.c#n477

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/thermal/rockchip_thermal.c#n1074

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/thermal/qcom/qcom-spmi-temp-alarm.c#n271

>  	return IRQ_HANDLED;
>  }
>  


[ ... ]


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

