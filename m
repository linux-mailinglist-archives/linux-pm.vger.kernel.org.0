Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE59B7B48C2
	for <lists+linux-pm@lfdr.de>; Sun,  1 Oct 2023 19:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235242AbjJARJV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Oct 2023 13:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbjJARJU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Oct 2023 13:09:20 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D742A6
        for <linux-pm@vger.kernel.org>; Sun,  1 Oct 2023 10:09:16 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40652e570d9so35046465e9.1
        for <linux-pm@vger.kernel.org>; Sun, 01 Oct 2023 10:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696180155; x=1696784955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iGjxhc44hdrvQoM5w8Uq24pZZMJyLPViDXSpaz6LUOQ=;
        b=PIrWCK20VhQnRFhZLr8BJYgxF/9V0YAiFV+Hf2M42fFiU6i6NlNbUOIdhkBoA8GdsY
         zNOuW8IIgIgDl92FAjwa+W/NsPbj8PL4jYSQ3jomZJBb/e+DuBbVUGnu1ettlNDtYikY
         qfea85hn+jGHoDjtvsV42Pd/Cwu5ilujoGbwMN9R6/P3qm4HCes2B08UdRyDf7oZEdb5
         sZ8//Oj+0QhuFzJq/dvZ5M4jotszsWfndcgSE1TpCJqDyeR2v3YeB7U3YxojSWa8EPGb
         LfTVUmMCwTU/U/YietH9/fGzRxhC07vtnOqo/lUwBUo4xnbUNTaid11ktNK3eKKzOyFd
         A1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696180155; x=1696784955;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iGjxhc44hdrvQoM5w8Uq24pZZMJyLPViDXSpaz6LUOQ=;
        b=sIM3VwbsJT7YCJAYUwdburRlL/xctXsfswoF5FUOWFk4bJ6dOGxMqDEmH5lBCPpITS
         SiN3RXpLusah5nNL5lZKMeg5VJf21MfqEhIIUK5c2MQ515rjpZRKImyA98iusOLIM5MV
         YiSat+Zr1Etbyr3qnAbKJCxxrgbIqvIwT/T5JqkSjX3Rj29dXpm3OXDKLkTccSeXcQNl
         MtUQlvm4md/5WeaHh/KvvNIwQQ3uoNFfOKC0dMLi0UTC0fpaVhOKHyTGvn6AoEqOW9JJ
         s7CTm6hYARRVkozhdZ5opKGfNrWT/72QGw4UrT+oVUsfmsQCkcfaicfZmOZUOAMgTHgS
         pScg==
X-Gm-Message-State: AOJu0YzhdHgSI7Nc5GnmoFqk8+KjkVt34u1ed18HiVcbPE72N/qUgrUY
        oUWebUJCvAQt1mQv+YGteulu9Q==
X-Google-Smtp-Source: AGHT+IErXNESmLvpSluBTQaeEKIBaDfH+rb1+56PY8TrOtE//KDX39aZDf59DzicoUbwO7c7i7IrKA==
X-Received: by 2002:a1c:f717:0:b0:402:e68f:888e with SMTP id v23-20020a1cf717000000b00402e68f888emr8686832wmh.4.1696180154771;
        Sun, 01 Oct 2023 10:09:14 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id u5-20020a05600c00c500b004047ac770d1sm5631296wmm.8.2023.10.01.10.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Oct 2023 10:09:14 -0700 (PDT)
Message-ID: <958bad88-c36b-0003-c12f-223d5bc16448@linaro.org>
Date:   Sun, 1 Oct 2023 19:09:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v9 1/3] dt-bindings: thermal-zones: Document
 critical-action
Content-Language: en-US
To:     Fabio Estevam <festevam@gmail.com>
Cc:     rafael@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20231001030014.1244633-1-festevam@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20231001030014.1244633-1-festevam@gmail.com>
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
> Document the critical-action property to describe the thermal action
> the OS should perform after the critical temperature is reached.
> 
> The possible values are "shutdown" and "reboot".
> 
> The motivation for introducing the critical-action property is that
> different systems may need different thermal actions when the critical
> temperature is reached.
> 
> For example, a desktop PC may want the OS to trigger a shutdown
> when the critical temperature is reached.
> 
> However, in some embedded cases, such behavior does not suit well,
> as the board may be unattended in the field and rebooting may be a
> better approach.
> 
> The bootloader may also benefit from this new property as it can check
> the SoC temperature and in case the temperature is above the critical
> point, it can trigger a shutdown or reboot accordingly.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Changes since v8:
> - Go back to putting critical-action as a thermal-zone property. (Daniel)
> 
>   .../devicetree/bindings/thermal/thermal-zones.yaml       | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> index 4f3acdc4dec0..c2e4d28f885b 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> @@ -75,6 +75,15 @@ patternProperties:
>             framework and assumes that the thermal sensors in this zone
>             support interrupts.
>   
> +      critical-action:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        description:
> +          The action the OS should perform after the critical temperature is reached.
> +
> +        enum:
> +          - shutdown
> +          - reboot

This option is dangerous and should be more documented.

"The action the OS should perform after the critical temperature is 
reached. By default the system will shutdown as a safe action to prevent 
to damage the hardware if the property is not set. The shutdown action 
should be always the default. Choose carefully 'reboot' as the hardware 
may be in thermal stress, thus leading to infinite reboots damaging the 
hardware. Make sure the firmware will act as the last resort and take 
over the thermal control."

[ and more info if needed ]

(written with best effort with my non native language ;)

>         thermal-sensors:
>           $ref: /schemas/types.yaml#/definitions/phandle-array
>           maxItems: 1

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

