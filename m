Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27187B1E20
	for <lists+linux-pm@lfdr.de>; Thu, 28 Sep 2023 15:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjI1NZI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Sep 2023 09:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjI1NY5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Sep 2023 09:24:57 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C69358E
        for <linux-pm@vger.kernel.org>; Thu, 28 Sep 2023 06:23:20 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3247cefa13aso2477513f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 28 Sep 2023 06:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695907399; x=1696512199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WumchtKkos+S+wxd4AjzKbSnNzsmwP2thY8yEvpwMVE=;
        b=IKuza3+mAkCShCaeBrblhKVUaXPVwusnqKSjCVxkFUYFAgfN5us+FMJnq71vw+n8lY
         9V+GkamfFYXgNYRkwAhFsJYEace6/roBtxmhoA6EFUruP9W/bxqvCqMMnfZN5ovT2oeY
         lcOsTUF17lYsTddoEetL4MfiH5yG7SRwohhifeIR2ky5mOsBN+haUOTjTVtCQLvdc4A8
         OucHnDI7OUu248zd9twPBH3ql+8D3t7G6nofUXsQ3HOPqKncJ3+SO0dGYzMbsZSxvIUZ
         MINXZrKhpOfcUyZX04IBfZ2MOBc/g+BZ+iC2wTdMyn3FKomvNy91LZpaotv0msxHAbMr
         ixfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695907399; x=1696512199;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WumchtKkos+S+wxd4AjzKbSnNzsmwP2thY8yEvpwMVE=;
        b=vroeJPb++zMC8J8UmeJth/M6J6LGSBZwZgQNrvjAKL1QosvNQbS2UyttY0zOYmua81
         WjmuJ5Q/hxnJB435yxUfT5QAn3fgWmp6wk52RetzWps3fyyb7lljzAoPvFgYWxXQ5ZtL
         SOkpK58zl4ia1p5sElQ0XKJrKkAd0iLBjhRMms6GhwMHJEsEIhxBcSIE4Q92uyV8augI
         avz/Cd3VIugoSZNFzU0bHHjP4/ssW9S46nZzDp5pckzJdNUCEugu6mkaRgh2K966W4kW
         SUYSfmM2pzgo3+yi2FPZuTYPaPS8g7sVZrreOB+/0mRWtL/H1Vvc5ic+xgZ3S11aBP++
         c2yA==
X-Gm-Message-State: AOJu0YyP33u8KsY3c4hBYkGmSNsT/BehLw5v/BA2r2A+cHIXU6YnvdFo
        EFjQL7wuQgcPa80dJuIonD3Byg==
X-Google-Smtp-Source: AGHT+IGRJ7TolrskiDdSR2JOTQd5921ScgfEtFfaDVIS7JF9sZ68tN+AMEJnqpdSNEuk1Y8W/wUN+w==
X-Received: by 2002:adf:f085:0:b0:320:77f:a97c with SMTP id n5-20020adff085000000b00320077fa97cmr1232478wro.63.1695907398871;
        Thu, 28 Sep 2023 06:23:18 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id w10-20020adfd4ca000000b0031762e89f94sm19280144wrk.117.2023.09.28.06.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 06:23:18 -0700 (PDT)
Message-ID: <90c4e025-6f55-994f-b51d-9c1274873104@linaro.org>
Date:   Thu, 28 Sep 2023 15:23:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 1/3] dt-bindings: thermal-zones: Document
 critical-action
Content-Language: en-US
To:     Fabio Estevam <festevam@gmail.com>, rafael@kernel.org
Cc:     amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20230916014928.2848737-1-festevam@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230916014928.2848737-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/09/2023 03:49, Fabio Estevam wrote:
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
> Changes since v7:
> - Made critical-action a property of the top-level thermal-zone node. (Rafael)
> 
>   .../devicetree/bindings/thermal/thermal-zones.yaml        | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> index 4f3acdc4dec0..d28f3fe1045d 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> @@ -48,6 +48,14 @@ properties:
>         platform-data regarding temperature thresholds and the mitigation actions
>         to take when the temperature crosses those thresholds.
>   
> +  critical-action:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      The action the OS should perform after the critical temperature is reached.
> +    enum:
> +      - shutdown
> +      - reboot

Given I'm catching up the versions, I'll directly comment this series 
instead of the previous versions.

 From my POV, the critical action to be done is not per system, but per 
critical trip point, which is per thermal zone.

Putting the critical action at the thermal zone device level is 
inconsistent with the fact the thermal zone may not have a critical trip 
point described.

So, the property should be either:

  - In the critical trip point description as optional

Or

  - At the thermal zone level if there is a critical trip point 
described (I don't know how this dependency can be described)

>   patternProperties:
>     "^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$":
>       type: object

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

