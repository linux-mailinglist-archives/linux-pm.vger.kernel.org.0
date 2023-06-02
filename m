Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39FF7204FC
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jun 2023 16:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbjFBO41 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Jun 2023 10:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbjFBO4V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jun 2023 10:56:21 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EDE123
        for <linux-pm@vger.kernel.org>; Fri,  2 Jun 2023 07:56:19 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-96f5685f902so306295166b.2
        for <linux-pm@vger.kernel.org>; Fri, 02 Jun 2023 07:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685717778; x=1688309778;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wnzl+oKBQQYlv+ufXrrOrmqqiDIhBJ9gKxeDwPiop2U=;
        b=GMxQutQqOI2tYKBtzZAaqKIUqU7r+PbwrkxhgYgJ/iORGQqWjNUT689CDWDrVKPob9
         XKn5G6+X4YG/uBUk6V3WDG1ZKe1Pihx+25lJWj/bIiP3047DfEbvgkYd1qbcubV4u9wP
         i3yIPb66r8f6GAu5D18gRLF4cz1zhO0XOg1Qw9MZJAfbdhK7B9tMCYXg230OYF/1VcFG
         nnTG22QXULPNj4Qvx+OSyRySFNN04gaYx34Ll+kkFTbJ/VYPc7oTiL5+fyStGEfvUdmI
         DaiY0eTy39o/0NEEYBq+Ap7jZICjSb/Ih38Gx/hIYnDufYAWV5NolWjtuMPijXaBDM9O
         Ub5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685717778; x=1688309778;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wnzl+oKBQQYlv+ufXrrOrmqqiDIhBJ9gKxeDwPiop2U=;
        b=I5uVw2PK8cam0L+MrMNWVfarXah8xG+rYhFxD8iK2UP3yKcUSvSoRulITPqGOgi8/y
         kdAZX7Epfci4pO+RZDDKeYOOMKteJN12kMevTDATj3CBmuibE0Xf8FF5U/E+L6vTs8kq
         t+d0UKqdxR2k86ZM8a3SKtsuihogH1Y/gVBfdZfSJgzl8ftFF0+gC8ByfvMviVd/tO/m
         Dluy8fv+k5LQ2d2NO82yGLywUUh+o60dq45uB9MNuXvaYUNUYzelp8KZw0/aRGwmJCzy
         nvl6ehpulZ+Y80jmPWSGiWAOuiNdjev5n67lTJna043L/pJBOAC58YBq5Zm8U1ljZ5wq
         6dXw==
X-Gm-Message-State: AC+VfDxz0sTNI49xFxo+GWKpNo0mRsOozD/+fVg5impyNr6ezCmrQ+rT
        X60R7QNmGWvCMVtwtBZiMJ8R9w==
X-Google-Smtp-Source: ACHHUZ4hcWFfF0FCaSfbTI+lzp2kZljSmf3H9Wn8b8Dj2qTDyDNjHbvmC3SaZv9TvGPuinNqTX/0LA==
X-Received: by 2002:a17:907:8a22:b0:969:7739:2eb7 with SMTP id sc34-20020a1709078a2200b0096977392eb7mr11905326ejc.4.1685717778140;
        Fri, 02 Jun 2023 07:56:18 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id a24-20020a170906245800b009745ecf5438sm839680ejb.193.2023.06.02.07.56.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 07:56:17 -0700 (PDT)
Message-ID: <c0c0dba2-2d93-9b30-7106-7bf7826844b2@linaro.org>
Date:   Fri, 2 Jun 2023 16:56:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 2/4] dt-bindings: power: reset:
 atmel,at91sam9260-shdwc: convert to yaml
Content-Language: en-US
To:     Claudiu Beznea <claudiu.beznea@microchip.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230524123528.439082-1-claudiu.beznea@microchip.com>
 <20230524123528.439082-3-claudiu.beznea@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230524123528.439082-3-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24/05/2023 14:35, Claudiu Beznea wrote:
> Convert Atmel shutdown controller to YAML.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---


> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - atmel,at91sam9260-shdwc
> +              - atmel,at91sam9rl-shdwc
> +    then:
> +      properties:
> +        atmel,wakeup-rtt-timer:
> +          description: enable real-time timer wake-up
> +          type: boolean

No, don't define properties in allOf.

> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - atmel,at91sam9rl-shdwc
> +              - atmel,at91sam9x5-shdwc
> +    then:
> +      properties:
> +        atmel,wakeup-rtc-timer:
> +          description: enable real-time clock wake-up
> +          type: boolean

Same problem.

> +
> +unevaluatedProperties: false

This should be additionalProperties: false.
> +
> +examples:
> +  - |
> +    shdwc: poweroff@fffffd10 {
> +        compatible = "atmel,at91sam9260-shdwc";
> +        reg = <0xfffffd10 0x10>;
> +        clocks = <&clk32k>;
> +    };
> +
> +...

Best regards,
Krzysztof

