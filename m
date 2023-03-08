Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D236B026E
	for <lists+linux-pm@lfdr.de>; Wed,  8 Mar 2023 10:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjCHJKB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Mar 2023 04:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjCHJJS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Mar 2023 04:09:18 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB9DB5FE6
        for <linux-pm@vger.kernel.org>; Wed,  8 Mar 2023 01:08:38 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id i34so62823682eda.7
        for <linux-pm@vger.kernel.org>; Wed, 08 Mar 2023 01:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678266517;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y24Ykwkv97HFDt8eai42TYISOmR0ZU7vtQ9YWiXtTfk=;
        b=wZBUXSVrnXvp1MXRDy00+hzHbT4U3mblM0bISrnMWQqdnsCZBVp/4yEVElO8zy84I3
         nQ59vniQ26fdsjTx+GSeQA2WCicAxAKBpTfAKuf3IrLqoCvMvVm/5nMA4ec0fQETSTuu
         EDd5+eWHzaEgfvaXk1yhaBuO5IjPd2FtzQln5RRid2sD8OW36tV0vWrk1gIxdyZbbZtE
         9Po/KtzsoruH93Sxv6CDm2HSEBC2A29F7FJK3PvUI1tNu1wjlUaRPqPWiWMdpWmjNs5h
         f853bHbMfFEMJBTxRbelbm1mgXdJSRHIuXyrUD+NsOkE4x1qQ6dZFwyaqCVHAMmFelpb
         b5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678266517;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y24Ykwkv97HFDt8eai42TYISOmR0ZU7vtQ9YWiXtTfk=;
        b=LWuWRtUL7N19MMoCC/Jj7mmy8IOQEytajX+eyaYFhjrltSbIpYowE8Gv1Z2vZ6p6b4
         sUuQMgINQov7pi956s+hHnXeibO+E2Gh2z+upAr7NuEBs1MEJECmG025LuE4EDZS0CWy
         E4RQCh4ZhV1VVRo5nnwnzbL2LobTYqLzr7rSUOyTosnQTYE+2aia6qZ4f2Y7mF7mNEAu
         KXU+cAxF0MX0i/zwOUgSedg32IcWCmpIHHCqXvR8nl0a1QQJ+3v9QNxUbdGcdMZg4LpM
         XEnzZkkVcidb4JdwrpLYAiLd/UTIWOCw5TIqvpvERaF9KX2FPbbpdrQ9WXJ9i9AKd68q
         8oWw==
X-Gm-Message-State: AO0yUKV7rsNpQ47whWjUg3x7gVfpQZ0MXuJAYYNKoRqP2/HuIqFO2wN5
        z6F4ABu92HsdDmfzHlVC5UK9Zw==
X-Google-Smtp-Source: AK7set9/MsIXlWmLU6Q6FB0uz9Fc0F3Jwt8Zhj3GLREP5f/y1fLLhbf5cce7IhYca0dyA2QLdK+IWw==
X-Received: by 2002:aa7:da15:0:b0:4ac:c72b:5eb5 with SMTP id r21-20020aa7da15000000b004acc72b5eb5mr15479970eds.40.1678266517348;
        Wed, 08 Mar 2023 01:08:37 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:bba:fbfa:8aec:a133? ([2a02:810d:15c0:828:bba:fbfa:8aec:a133])
        by smtp.gmail.com with ESMTPSA id 20-20020a508e54000000b004d8d2735251sm5832239edx.43.2023.03.08.01.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 01:08:37 -0800 (PST)
Message-ID: <c04d4306-de81-363c-2d2e-60f5283a5249@linaro.org>
Date:   Wed, 8 Mar 2023 10:08:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 4/4] power: max17040: get thermal data from adc if
 available
Content-Language: en-US
To:     Svyatoslav Ryhel <clamor95@gmail.com>,
        Iskren Chernev <me@iskren.info>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230308084419.11934-1-clamor95@gmail.com>
 <20230308084419.11934-5-clamor95@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230308084419.11934-5-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/03/2023 09:44, Svyatoslav Ryhel wrote:
> Since fuel gauge does not support thermal monitoring,
> some vendors may couple this fuel gauge with thermal/adc
> sensor to monitor battery cell exact temperature.
> 
> Add this feature by adding optional iio thermal channel.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/power/supply/max17040_battery.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
> index 6dfce7b1309e..8c743c26dc6e 100644
> --- a/drivers/power/supply/max17040_battery.c
> +++ b/drivers/power/supply/max17040_battery.c
> @@ -18,6 +18,7 @@
>  #include <linux/of_device.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> +#include <linux/iio/consumer.h>
>  
>  #define MAX17040_VCELL	0x02
>  #define MAX17040_SOC	0x04
> @@ -143,6 +144,7 @@ struct max17040_chip {
>  	struct power_supply		*battery;
>  	struct power_supply_battery_info	*batt_info;
>  	struct chip_data		data;
> +	struct iio_channel		*channel_temp;
>  
>  	/* battery capacity */
>  	int soc;
> @@ -416,6 +418,11 @@ static int max17040_get_property(struct power_supply *psy,
>  	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
>  		val->intval = chip->batt_info->charge_full_design_uah;
>  		break;
> +	case POWER_SUPPLY_PROP_TEMP:
> +		iio_read_channel_raw(chip->channel_temp,
> +				     &val->intval);
> +		val->intval *= 10;

I am not convinced this is needed at all. You basically chain two
subsystems only to report to user-space via power supply, but it is
already reported via IIO. I would understand it if you use the value for
something, e.g. control the charger. Here, it's just feeding different
user-space interface. Therefore:
1. IO channels are not a hardware property of the fuel gauge,
2. I have doubts this should be even exposed via power supply interface.


Best regards,
Krzysztof

