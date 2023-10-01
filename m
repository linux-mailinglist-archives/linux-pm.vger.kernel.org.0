Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED537B48DD
	for <lists+linux-pm@lfdr.de>; Sun,  1 Oct 2023 19:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbjJARZc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Oct 2023 13:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbjJARZb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Oct 2023 13:25:31 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B48DDA
        for <linux-pm@vger.kernel.org>; Sun,  1 Oct 2023 10:25:29 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40666aa674fso11168655e9.0
        for <linux-pm@vger.kernel.org>; Sun, 01 Oct 2023 10:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696181127; x=1696785927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q0LkkpQjrn6eJhxNp5lGODoZfg5LRJ818kW+fRmI0ys=;
        b=BOMkvk2tMPVLR87NBc9ZBwh1oRSuE/wkfMRAGKwMzLkC1urRsAdw/wJfuPJsSH+KXO
         JVRlfOoCKlD9rdZg5sNgYnIuSImz3vrT/9urPT7159nE8+bj7k2JK07RWwaXD0/h7ewS
         XuPmRAgF3qLOy8739ee5OfeyYBt4xv770CZuuvuMdvJI6X2P1UX5AIbRxFk2f5HI3Lm8
         Wy8QwLsSatSmTzsGkxjIxdhyxQMnlCWOh5KP5we3lmUQIkZNpZ79/nnldwu92fH0GipF
         f0+oOOur6j8eithfsH7jGiV3UOOnfckUcm6S0P9tJcMAx3tU496gavpEPObSX60VGazy
         vYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696181127; x=1696785927;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q0LkkpQjrn6eJhxNp5lGODoZfg5LRJ818kW+fRmI0ys=;
        b=uzX3FrsDLE8VAVskrR7smildZDr0rbHbAJ94jDAHjPDddPDAtgpPH6aMQPzeInvUQx
         Jl4/2YwUEvP64JshP4HCcrLb699T/Eh8/+njGSTuiaGfM6lfWqnxvCNcHUgvGYPV9wiy
         gHV3wy/007r9UPqhQwUWbP6TTf8VWVKkbji7RG5ieUl99s4Gku08qjjg0nKwoR0znFJ2
         Owll7318sfAqPWj2MBLgIVuUvU8QuzuHXRtUh8HjGUjjjKPcTom9smMIxZdZTehv8wbv
         ZCSFLfEpY+4bsj2ZwDloHTsWgQ6WQ/O3xPEvjr+kN77ZbFICJzdjT8Xbap1KJtAXJMEo
         G9eg==
X-Gm-Message-State: AOJu0Yxkbqd+t7XgCJA3J7W0G6A3y/inngYfgeX8/pPppY27wqrUe40v
        2kNGsnIk9nN2lvKwDimIUDU7cA==
X-Google-Smtp-Source: AGHT+IGYHakqFMaViMMURrFGAKEgD1Qxlpso/sSjIQ2nORM7MODmEZmMRzopyncWwAHsIf01+IC4XQ==
X-Received: by 2002:a7b:c7d5:0:b0:404:fc51:4e9f with SMTP id z21-20020a7bc7d5000000b00404fc514e9fmr9206615wmk.38.1696181127383;
        Sun, 01 Oct 2023 10:25:27 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id o11-20020a056000010b00b0031c52e81490sm26296984wrx.72.2023.10.01.10.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Oct 2023 10:25:27 -0700 (PDT)
Message-ID: <3d1c6755-6a8b-d82d-d31d-3a71f83fba96@linaro.org>
Date:   Sun, 1 Oct 2023 19:25:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v9 3/3] thermal: thermal_core: Allow rebooting after
 critical temp
Content-Language: en-US
To:     Fabio Estevam <festevam@gmail.com>
Cc:     rafael@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
References: <20231001030014.1244633-1-festevam@gmail.com>
 <20231001030014.1244633-3-festevam@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20231001030014.1244633-3-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01/10/2023 05:00, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Currently, the default mechanism is to trigger a shutdown after the
> critical temperature is reached.
> 
> In some embedded cases, such behavior does not suit well, as the board may
> be unattended in the field and rebooting may be a better approach.
> 
> The bootloader may also check the temperature and only allow the boot to
> proceed when the temperature is below a certain threshold.
> 
> Introduce support for allowing a reboot to be triggered after the
> critical temperature is reached.
> 
> If the "critical-action" devicetree property is not found, fall back to
> the shutdown action to preserve the existing default behavior.
> 
> If a custom ops->critical exists, then it takes preference over
> critical-actions.
> 
> Tested on a i.MX8MM board with the following devicetree changes:
> 
> 	thermal-zones {
> 		cpu-thermal {
> 			critical-action = "reboot";
> 		};
> 	};
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---

Sounds good to me


> Changes since v8:
> - Simplify the logic for calling thermal_zone_device_critical_reboot(). (Daniel).
> 
>   drivers/thermal/thermal_of.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 1e0655b63259..4d6c22e0ed85 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -475,6 +475,7 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
>   	struct thermal_zone_params tzp = {};
>   	struct thermal_zone_device_ops *of_ops;
>   	struct device_node *np;
> +	const char *action;
>   	int delay, pdelay;
>   	int ntrips, mask;
>   	int ret;
> @@ -511,6 +512,11 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
>   
>   	mask = GENMASK_ULL((ntrips) - 1, 0);
>   
> +	ret = of_property_read_string(np, "critical-action", &action);
> +	if (!ret)
> +		if (!of_ops->critical && !strcasecmp(action, "reboot"))
> +			of_ops->critical = thermal_zone_device_critical_reboot;
> +
>   	tz = thermal_zone_device_register_with_trips(np->name, trips, ntrips,
>   						     mask, data, of_ops, &tzp,
>   						     pdelay, delay);

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

