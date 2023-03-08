Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135BD6B04DD
	for <lists+linux-pm@lfdr.de>; Wed,  8 Mar 2023 11:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjCHKo5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Mar 2023 05:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjCHKop (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Mar 2023 05:44:45 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD669CFC9
        for <linux-pm@vger.kernel.org>; Wed,  8 Mar 2023 02:44:43 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id x3so63781107edb.10
        for <linux-pm@vger.kernel.org>; Wed, 08 Mar 2023 02:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678272282;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1RqGWA9K+2jBP6sB1ByHxr6PzA5Hy7riHKaIEMmIdk4=;
        b=WWpHAqiFtgdf10Dc766TcgWxHtcclRW92e2HVXW2hWv15RnOwJQqVBv7a9CoWNil8Z
         p4q/EcbJqI6aMm7uU0U01iqUnfGihVZ5mjuUeVSx+LPxqrKUzcmanjrBR64RPB0E4dH+
         cDWuDWHg43z4zuqk70nQGV+IDOdA3yfzstCTCf8oSdBTpQTSqZj5bq3IpXR/MiUCRFAl
         dP3pRYeqslygZ4yD6ieXOAcwsNgsKbt1Z8HiYdjiOCExvX1sZZCC0PbJ3elslQCRwIxm
         cUDrwkeh0QNhxYoAiQMqh0Esj3/KKW9z8sA7msZfn32ppMKK0+8UHCqau1ciRyRatbdt
         J+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678272282;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1RqGWA9K+2jBP6sB1ByHxr6PzA5Hy7riHKaIEMmIdk4=;
        b=4dLFHWqNtSVE+Ut+D7DN/yoHNnMc460ytWgg3hP3TZZKRfmUN0Ec53WEmE5++bvnIK
         z0XOGezE0j8Zy1TmOgErRroItDm4JlSe8HtVLzks/4V7a4iheSr0sC+a7YWgG8M9Lacc
         Bw4lb/cN3xpN/v/Sjcdjo1qc69Tv1gbEk29XPg135JnXRgirze7eX9DWM3QSgmh3Gwoi
         JOGGvFyKIK90FX0kVJY6q14rlckVV7XUK6kG0cc5QmcjSm9uPe+2y5rVyh/XFG2D2FGU
         iGu+CRnH92XDTr1SdNQlSpy6jtMexSikP6bFQ0M19JX4H/UYPmDTgBZ82aNv+4W2McLH
         pLtA==
X-Gm-Message-State: AO0yUKX1hOsIcefC4DcsX0sxLD1lEwHAyQCAU2FGB69SJz/hDHGTGCnN
        o7OFi7xpgsBeZZTmtLg3+/uUsA==
X-Google-Smtp-Source: AK7set/AXCZdJPtIp0/bS4Uu70VE21JSzoAwX/MvmoD3gr2lnvNGdcmSMWvPSEZdW+DfMqMpIckvJA==
X-Received: by 2002:a17:907:a581:b0:913:f170:c0e with SMTP id vs1-20020a170907a58100b00913f1700c0emr8195054ejc.20.1678272282160;
        Wed, 08 Mar 2023 02:44:42 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:ff33:9b14:bdd2:a3da? ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id y7-20020a170906470700b008ef13127b5fsm7318561ejq.29.2023.03.08.02.44.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 02:44:41 -0800 (PST)
Message-ID: <bbc7c183-3f98-9ea4-d5e5-0d58dd65d416@linaro.org>
Date:   Wed, 8 Mar 2023 11:44:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 1/4] dt-bindings: power: supply: maxim,max17040: update
 properties
Content-Language: en-US
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Iskren Chernev <me@iskren.info>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230308084419.11934-1-clamor95@gmail.com>
 <20230308084419.11934-2-clamor95@gmail.com>
 <95fa5f0f-cf53-7a37-2170-98b81c0982f1@linaro.org>
 <CAPVz0n1QDFyHiGAa7UOuuwPiSH+ELiYNeO9-fxPWrOWkWqEuHg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAPVz0n1QDFyHiGAa7UOuuwPiSH+ELiYNeO9-fxPWrOWkWqEuHg@mail.gmail.com>
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

On 08/03/2023 10:15, Svyatoslav Ryhel wrote:

>> max17040 does not have ADC temperature input... so is it system
>> configuration?
>>
> 
> yes, I own a device (LG Optimus Vu P895) which uses max17043
> coupled with ADC thermal sensor
> 
>>> +
>>> +  io-channel-names:
>>> +    items:
>>> +      - const: temp
>>
>> Drop the names property, not needed for one item.
>>
> 
> Alright, but driver patch expects temp name. I will look if this
> is adjustable.

I think I saw cases without names.

> 
>>> +
>>>    wakeup-source:
>>>      type: boolean
>>>      description: |
>>> @@ -95,3 +109,26 @@ examples:
>>>          wakeup-source;
>>>        };
>>>      };
>>> +  - |
>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>> +    i2c0 {
>>> +      #address-cells = <1>;
>>> +      #size-cells = <0>;
>>> +
>>> +      fuel-gauge@36 {
>>> +        compatible = "maxim,max17043";
>>> +        reg = <0x36>;
>>> +
>>> +        interrupt-parent = <&gpio>;
>>> +        interrupts = <144 IRQ_TYPE_EDGE_FALLING>;
>>> +
>>> +        monitored-battery = <&battery>;
>>> +        power-supplies = <&charger>;
>>
>> But here you suggests something else than VDD... The hardware does not
>> take charger as input. It takes power supply - vdd.
>>
> 
> Power system allows passing properties from other power devices.
> In this case battery health and status are passed from charger.

So this is not an input to device? Then it does not really look like
property of this hardware. Fuel gauge does not control the charger, also
from system configuration point of view.

Best regards,
Krzysztof

