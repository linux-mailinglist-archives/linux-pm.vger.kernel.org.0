Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDE04F460F
	for <lists+linux-pm@lfdr.de>; Wed,  6 Apr 2022 00:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238046AbiDEMzZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Apr 2022 08:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359361AbiDEL5A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Apr 2022 07:57:00 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1E82D1DD
        for <linux-pm@vger.kernel.org>; Tue,  5 Apr 2022 04:16:58 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id r13so25963171ejd.5
        for <linux-pm@vger.kernel.org>; Tue, 05 Apr 2022 04:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VLCfd5gEQwSYDmFlX++Ka+tNB+2J3sKkmSRyIFOs0t8=;
        b=q9Tk6+va4ukpHeIc9rTzRiwjVytHuN/9MuIQYH/OU+CdtVK+UTfBB6jKAXjiORr0Nl
         s0Wo1xhQjI2ttk2/XmUFWVoAQkjxAELmLhuFUkApOW+KPj9P+c2J8Lx2mdWKdedENkB5
         mbwsC7HuyFLsR7pHrbwdzuQap5rF50Rc4er9Yaz/T9xsZdDLhko9uQ6+fdpVmOo/K2vS
         sif/5cX4C9kAL3BT/z0ihsLAtDtsibi5DMwKh88fjDM8O804K2tBWjZ8OmIEvLSt4jrr
         ktNlgdK4CL8/Ya3kajJ/niz6GktI1p4+OEG4sz7V17S5RyLqayftOsyNiAz05xT+pTm1
         zI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VLCfd5gEQwSYDmFlX++Ka+tNB+2J3sKkmSRyIFOs0t8=;
        b=5gbBJgMyoquGoIPkxfuOp1Uf5xHlzmwKDuzz9hSHKzDNFezpJVUozYzrLZXXeO4R88
         Yx7nG+TFKkHbROB/WsAHdy73LMUiU/xZ6ovDZgZ4HWxCo2cUamyF1ZKNwv+xi9e1wlSx
         Wr8KKX37pK74KFI1jAkpxPaKGCh351zaVq5EYcpN/ONppo86I9aY6m024iiuvoYlGkrg
         ACC5J/ShsvNFIE54zFNNn5kOA7aMC8mciJf5NVMd9J79uorAQi3P95guzjq3ieJw3CtA
         kTQ7A5tR0ys+5P6crBpIATS5lQxpWC1klPTc/sOk5rhXUi1yEj4hh3iHkosC722zcGHJ
         ZT3w==
X-Gm-Message-State: AOAM5323tldlLkv44a79oCxXWFaq703LXIE9RzfaAW9lKPSmXKf2jnAv
        VS4RsZhcGvflbMBNRayBn94dkw==
X-Google-Smtp-Source: ABdhPJz9IWhsYACZjpPimb853praVUEzxUy0bcLvEo4PaomjnNF3kExH+nnCvdqfWR5GHaRFAzNamw==
X-Received: by 2002:a17:906:2991:b0:6cc:fc18:f10c with SMTP id x17-20020a170906299100b006ccfc18f10cmr2994829eje.744.1649157417291;
        Tue, 05 Apr 2022 04:16:57 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id ep16-20020a1709069b5000b006daa26de2fbsm5358975ejc.153.2022.04.05.04.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 04:16:56 -0700 (PDT)
Message-ID: <74f445c2-3194-80a6-6d52-21368eb6172a@linaro.org>
Date:   Tue, 5 Apr 2022 13:16:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/4 v5] dt-bindings: Add Rockchip rk817 battery charger
 support
Content-Language: en-US
To:     Chris Morgan <macroalpha82@gmail.com>, linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        zhangqing@rock-chips.com, zyw@rock-chips.com,
        jon.lin@rock-chips.com, maccraft123mc@gmail.com, sre@kernel.org,
        heiko@sntech.de, krzk+dt@kernel.org, robh+dt@kernel.org,
        lee.jones@linaro.org, Chris Morgan <macromorgan@hotmail.com>
References: <20220404215754.30126-1-macroalpha82@gmail.com>
 <20220404215754.30126-2-macroalpha82@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220404215754.30126-2-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04/04/2022 23:57, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Create dt-binding documentation to document rk817 battery and charger
> usage. New device-tree properties have been added.
> 
> - rockchip,resistor-sense-micro-ohms: The value in microohms of the
>                                       sample resistor.
> - rockchip,sleep-enter-current-microamp: The value in microamps of the
>                                          sleep enter current.
> - rockchip,sleep-filter-current: The value in microamps of the sleep
>                                  filter current.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> ---
>  .../bindings/mfd/rockchip,rk817.yaml          | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
> index bfc1720adc43..b949d406a487 100644
> --- a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
> +++ b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
> @@ -117,6 +117,47 @@ properties:
>          description:
>            Describes if the microphone uses differential mode.
>  
> +  battery:

I wonder why do you call it a batter while it is a charger, isn't it?

> +    description: |
> +      The child node for the charger to hold additional properties. If a
> +      battery is not in use, this node can be omitted.
> +    type: object
> +    properties:
> +      monitored-battery:
> +        description: |
> +          A phandle to a monitored battery node that contains a valid
> +          value for:
> +          charge-full-design-microamp-hours,
> +          charge-term-current-microamp,
> +          constant-charge-current-max-microamp,
> +          constant-charge-voltage-max-microvolt,
> +          voltage-max-design-microvolt,
> +          voltage-min-design-microvolt,
> +          and a valid ocv-capacity table.
> +
> +      rockchip,resistor-sense-micro-ohms:
> +        description: |
> +          Value in microohms of the battery sense resistor. This value is
> +          used by the driver to set the correct divisor value to translate
> +          ADC readings into the proper units of measure.
> +        enum: [10000, 20000]
> +
> +      rockchip,sleep-enter-current-microamp:
> +        description: |
> +          Value in microamps of the sleep enter current for the charger.
> +          Value is used by the driver to calibrate the relax threshold.
> +
> +      rockchip,sleep-filter-current-microamp:
> +        description:
> +          Value in microamps of the sleep filter current for the charger.
> +          Value is used by the driver to derive the sleep sample current.
> +
> +    required:
> +      - monitored-battery
> +      - rockchip,resistor-sense-micro-ohms
> +      - rockchip,sleep-enter-current-microamp
> +      - rockchip,sleep-filter-current-microamp
> +
>  allOf:
>    - if:
>        properties:
> @@ -323,6 +364,13 @@ examples:
>                  };
>              };
>  
> +            rk817_battery: battery {

The same.

> +                monitored-battery = <&battery_cell>;
> +                rockchip,resistor-sense-micro-ohms = <10000>;
> +                rockchip,sleep-enter-current-microamp = <300000>;
> +                rockchip,sleep-filter-current-microamp = <100000>;
> +            };
> +
>              rk817_codec: codec {
>                  rockchip,mic-in-differential;
>              };


Best regards,
Krzysztof
