Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6064174CA
	for <lists+linux-pm@lfdr.de>; Fri, 24 Sep 2021 15:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346163AbhIXNKV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Sep 2021 09:10:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58224 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346939AbhIXNIX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Sep 2021 09:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632488809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XrpDYCkSGtlGl8BFk/fwvdAaXH43kLtO8EUnordZx+s=;
        b=NCd381ndzxhHruytkWuMK9JNxc36L8rAwUp+ZpuFTkqBTNqMaXncr3BBv0oQ6MvK5PHQHq
        yW3um7qaLyKBgyp+wLmhSKuIx0YyWiGW+EEwLcX3SRRaqCut7Wot8xjMQQX5PUfKfnLnGW
        6tvMz/b/q0vxz7Fuu4VrcvVTgUU0SIk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-jPSp8EfVMM6SaGGaGXKfjg-1; Fri, 24 Sep 2021 09:06:48 -0400
X-MC-Unique: jPSp8EfVMM6SaGGaGXKfjg-1
Received: by mail-ed1-f72.google.com with SMTP id r23-20020a50d697000000b003d824845066so10168985edi.8
        for <linux-pm@vger.kernel.org>; Fri, 24 Sep 2021 06:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XrpDYCkSGtlGl8BFk/fwvdAaXH43kLtO8EUnordZx+s=;
        b=m7dM5PeyqUb9JwGMsiExP1jEaQxR4DSjPuhNbW1ED9yKLX+grznFU4wq2EkeJH44MT
         pSzoIf1pyPwmyNFYMnWujgpZwurYbyg1Kf5Gxky7enFEqyAxip2ARP06MXoZY1b0sdT1
         MpJl7NQ0DDW7tMX3fCwwU6azerSrOkUrawAdIYIRWnztIJ5+ijZ2Ai1rWJm+je58kigk
         qDvb+K0ziOD7Tr4ACVf1SmdkrbICpqTH+h4mqnHbV0CxM9hKjXWonbbvnRRSJ8y4f7UH
         kSjwINGiVaT3cVLRMZoPZfaPIaxxOKoqKq3nVgvneHL4Ey/7C47kxq2y7zvFc1rDOwCA
         eeVQ==
X-Gm-Message-State: AOAM533BJjsC97k+nkEvBCWl1d9x1fRMQgqrqrr5eV+uaO2ueejiq8v0
        DGMG9Y5yfC/aTNOjgIPaMEFagl3Q0IJWIoVwBOWih2SGTcCtz8Ha+VSUCNL0x0L8UfsdgZWglEA
        jRwgJWFgNMK46v7uSPng=
X-Received: by 2002:a50:d8c5:: with SMTP id y5mr4923907edj.370.1632488807257;
        Fri, 24 Sep 2021 06:06:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkd2eTmm74wJYnrnmrY5ynC5skg2e8nOgj8Zx3cIjik+p5qGgZwU6/b4rVum1ZIWlUiMmUsw==
X-Received: by 2002:a50:d8c5:: with SMTP id y5mr4923888edj.370.1632488807064;
        Fri, 24 Sep 2021 06:06:47 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id d10sm5965847edx.57.2021.09.24.06.06.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 06:06:46 -0700 (PDT)
Subject: Re: [PATCH 1/2] power: supply: max17040: extend help/description
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210924122408.101323-1-krzysztof.kozlowski@canonical.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b71b75c7-966c-7452-907e-44ba0a56964b@redhat.com>
Date:   Fri, 24 Sep 2021 15:06:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210924122408.101323-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 9/24/21 2:24 PM, Krzysztof Kozlowski wrote:
> Reorganize the Kconfig driver description and mention all supported
> models.  This helps when choosing drivers for given system.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Thanks, series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

For the series.

Regards,

Hans

> ---
>  drivers/power/supply/Kconfig | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index fcc7534edcb2..6e4201922f59 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -366,18 +366,20 @@ config AXP288_FUEL_GAUGE
>  	  over/under temperature.
>  
>  config BATTERY_MAX17040
> -	tristate "Maxim MAX17040 Fuel Gauge"
> +	tristate "Maxim MAX17040/17041/17043 family Fuel Gauge"
>  	depends on I2C
>  	select REGMAP_I2C
>  	help
> -	  Maxim models with ModelGauge are fuel-gauge systems for lithium-ion
> -	  (Li+) batteries in handheld and portable equipment, including
> -	  max17040, max17041, max17043, max17044, max17048, max17049, max17058,
> -	  max17059. It is also included in some batteries like max77836.
> +	  Driver supports Maxim fuel-gauge systems for lithium-ion (Li+)
> +	  batteries used mainly in handheld and portable equipment.
> +	  Supported devices: max17040, max17041, max17043, max17044, max17048,
> +	  max17049, max17058, max17059, max77836.
>  
>  	  Driver supports reporting SOC (State of Charge, i.e capacity),
>  	  voltage and configurable low-SOC wakeup interrupt.
>  
> +	  Driver can be build as a module (max17040_battery).
> +
>  config BATTERY_MAX17042
>  	tristate "Maxim MAX17042/17047/17050/8997/8966 Fuel Gauge"
>  	depends on I2C
> 

