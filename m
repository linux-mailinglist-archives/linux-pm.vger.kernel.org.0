Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB2F58FE1D
	for <lists+linux-pm@lfdr.de>; Thu, 11 Aug 2022 16:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbiHKOMo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Aug 2022 10:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbiHKOMn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Aug 2022 10:12:43 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D42883C9
        for <linux-pm@vger.kernel.org>; Thu, 11 Aug 2022 07:12:42 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id x10so1839354ljq.4
        for <linux-pm@vger.kernel.org>; Thu, 11 Aug 2022 07:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Fy9PTke51Zg9523WNK0IhcOTzgepLlEhCDidUwNqgkc=;
        b=P95w+mFAwgJ0FxxXxzex66rQi6nyYIcEZJb2oYfGMSDpipqZAT0uLiwWDeD787QhM3
         KroYLUjytW1C9lXHIPVrP7YaPGllx695Qb4Trl32HZWcbW6ZbD9dcBBdjGCA+b5+5imc
         5Ao4r//YZVPdXrb4nQf1MWnvkTsFCvVBCkueiXtnB1XeC+/nI96TxdVQmaT25CRrCRy3
         Min1eLP45HkjmHH0lqRcBgFIhEPpiK60Iah0ya92rmjnXMJhZoIn0Nh+FwpOCAVX75lS
         QawDS5rhhX1aEOOV4ZzhcGhQwZtJMzK0zCqwTMy0RnHQJLq//f1izcx2AYFp/Qfwvr46
         WVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Fy9PTke51Zg9523WNK0IhcOTzgepLlEhCDidUwNqgkc=;
        b=cnsOBCFXIR73bIhSVNr4wqIucx2GyWpNWMJ5sOfsRPOvZ+gcuJr07yud+WWHB1Q7fX
         UpB/IkUd/eHnRSrnq+zDZVWNYLymFMVGpVrzsciOx0lX/Yulew9LCwXi5MzVYHQ4KYQp
         +N08aFwmEDY04O+VrTKdqxflGZSgfvUjjRQba7W+X1yDKRZSMDNOMZrqasCbr+r4iNQ2
         yuUyAh61cHilwuLxs2423jnPCqCJmPGJgHAIUVCPGV13PsAFuysNnnQC6P2fIv9ll+Ue
         a/WcmRGDKvxZR2P6OtKHrHRZ3lVZ92HNjPEybDDKfQrBEvwQYsXUjDTfriT0J6963QB4
         3GfQ==
X-Gm-Message-State: ACgBeo2J9krvRvPOJT352uoY9x8ohfiGwFCTKF3Rinw/GutgEmMBxikz
        ZrAE27/czA8+Mv9ZSu8WXLiEeQ==
X-Google-Smtp-Source: AA6agR6MmknBLMsVUHGH9/LrrAYp8zz2C+2v5BuMQmzCUIrbx148w42aUH1UDSV9iibiYHLOFLnd0Q==
X-Received: by 2002:a2e:be88:0:b0:25f:e9a8:44b8 with SMTP id a8-20020a2ebe88000000b0025fe9a844b8mr4932199ljr.92.1660227160351;
        Thu, 11 Aug 2022 07:12:40 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id g2-20020a19ac02000000b0048b2cde8c08sm712098lfc.244.2022.08.11.07.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 07:12:39 -0700 (PDT)
Message-ID: <3cae9d60-4012-1dfd-abd9-4d0b9379e6bb@linaro.org>
Date:   Thu, 11 Aug 2022 17:12:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: Add Richtek RT9471
 battery charger
Content-Language: en-US
To:     cy_huang <u0084500@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sre@kernel.org
Cc:     alina_yu@richtek.com, cy_huang@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1660225318-4063-1-git-send-email-u0084500@gmail.com>
 <1660225318-4063-2-git-send-email-u0084500@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1660225318-4063-2-git-send-email-u0084500@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/08/2022 16:41, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add bindings for the Richtek RT9471 I2C controlled battery charger.
> 

Thank you for your patch. There is something to discuss/improve.

> +properties:
> +  compatible:
> +    const: richtek,rt9471
> +
> +  reg:
> +    maxItems: 1
> +
> +  ceb-gpios:
> +    maxItems: 1

This looks not standard, so please provide a description.

> +
> +  wakeup-source: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 1

Why a charger driver is a interrupt-controller?

> +
> +  usb-otg-vbus-regulator:
> +    type: object
> +    unevaluatedProperties: false
> +    $ref: /schemas/regulator/regulator.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +  - wakeup-source
> +  - interrupts
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      charger@53 {
> +        compatible = "richtek,rt9471";
> +        reg = <0x53>;
> +        ceb-gpios = <&gpio26 1 0>;

Isn't the last value a GPIO flag? If yes, use appropriate define.



Best regards,
Krzysztof
