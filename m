Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E915B610D50
	for <lists+linux-pm@lfdr.de>; Fri, 28 Oct 2022 11:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiJ1Jb7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Oct 2022 05:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiJ1Jbp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Oct 2022 05:31:45 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5E21C6BFD
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 02:31:43 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso6122201wma.1
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 02:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WaKNgqEgoF6Zx2JfcPmTHiX+wsh3k8+Xy+QiK1kLIG0=;
        b=CAcoDivo3WyhJ0Jjxv3r+aLVyYnLbkY3IfmhpKwoDxGd1lWxYCq3m7P3ACmf/9Ov5d
         veOfzx7QFbLHU4V+55xY0OUdu6Ym5WrSS5PzPmIR7tZ/MbWSGYE8s/F1+B/iL6xqW05p
         +L+UW0AAIJ03ExtJiTcitNCjlBZCrPsYPZy4Gidz3YJEaPjLPsB/DlFL3cLcd+BHqat+
         P44S7DjYFQa2L+9eyaQOxF8VmWbSY9F17LPIsJYyjp/q9ZOp0HDIqen4aJ7OMtOlqZ6L
         pQB3utkt8P4rD3DipmA3wUrPEohgxI6N/ecroBXiK7QJ3XgTR0kdv2nId/1jYYIyt0Xo
         u59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WaKNgqEgoF6Zx2JfcPmTHiX+wsh3k8+Xy+QiK1kLIG0=;
        b=fvxsYin0dWt5/SNRJtiHHRoigj3op7RvnqCDRDGiRPQIICr3EkIQ1jrGavef0gsfVZ
         YwOb72W/fqXzeWWBehb5ZWoVVlMC6UwM4k093iRlEZKXWINSEmiKtmEoyiYb0XCYlsAg
         5G5xJ/ECkhlJakVmPa3sEvH4wCokhahItDWEcB6m/Hpw1sLw/MJYPLxLXRrYzh9gUzlM
         DA+/S34xkanG/sWy/n7K6Dq2s1WmkdLnpU7GhEMBLRiOwNg5PfamPWkslNfdqrfHUzz7
         Zbtd8KpOPC5hmO64+QwmFCJ+YSjUcPSC9mQvoh3G3PKj7Gk9LFBbX+WMPNRv+W1xBorE
         5UeQ==
X-Gm-Message-State: ACrzQf18DLuzwtnqt+3HTaSdevJSp9kWcCo32BHpgZo0K85vACE+cui9
        kAyfW3I+GZqwEQY5hcl6MlgBHrHolNUR+g==
X-Google-Smtp-Source: AMsMyM7ucYn+qC1RoU1d90Qtg8VE+vUiGHrCKAhLjrYNfbGkmKQxa8joA1i4c7BrB592Lb7oQkvXaw==
X-Received: by 2002:a05:600c:3d92:b0:3cf:3921:d8ad with SMTP id bi18-20020a05600c3d9200b003cf3921d8admr8716490wmb.15.1666949502244;
        Fri, 28 Oct 2022 02:31:42 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:973f:a8b:7c4d:b6c4? ([2a05:6e02:1041:c10:973f:a8b:7c4d:b6c4])
        by smtp.gmail.com with ESMTPSA id u11-20020adfdd4b000000b00236883f2f5csm3260322wrm.94.2022.10.28.02.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 02:31:41 -0700 (PDT)
Message-ID: <c98486ac-0a32-f650-0084-96cc5c255df9@linexp.org>
Date:   Fri, 28 Oct 2022 11:31:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
References: <CACRpkdbB5hgkrPZVb-+9tuKErvwjTKNaBQ1LvH1==fR7bndjSQ@mail.gmail.com>
 <CAL_JsqKQM4oSxrbhA4_ST8O0ieek9sGQQ9p55AXjhqmVx=rUrw@mail.gmail.com>
 <CAJZ5v0i76X0TiaOhPa3a5440fRb7vA1z1mFKJibso8G6wYz7HQ@mail.gmail.com>
 <4817aeca-4fb1-cb99-8df5-7df22a77ea3f@linexp.org>
 <CACRpkdb=WX5XO1YDB04uLzv=tNfpmr+ORN+LkAiZTE6gSris_g@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
Subject: Re: Regression after recent changes to drivers/thermal/thermal_of.c
In-Reply-To: <CACRpkdb=WX5XO1YDB04uLzv=tNfpmr+ORN+LkAiZTE6gSris_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Linus,

On 28/10/2022 10:04, Linus Walleij wrote:
> On Wed, Oct 26, 2022 at 11:40 PM Daniel Lezcano
> <daniel.lezcano@linexp.org> wrote:
>> On 26/10/2022 19:06, Rafael J. Wysocki wrote:
> 
>>> This is Daniel's work, so I'm still hoping that he'll chime in
>>> shortly,
>>
>> Yep, I'm in sick leave ATM, I broke my arm (without wordplay).
> 
> Yeah I heard, get well soon!

Thanks

>> I took sometime to read the code, so from my POV we should keep the
>> required property patch because the DT was defined that as required
>> property. The conversion to yaml obviously spotted the DT not conforming
>> with the bindings.
> 
> So I guess you mean I should add some trip points to my device
> trees then so they pass validation?

May be a critical trip point? (but a monitoring delay will be needed 
implying additional wake ups if the interrupt mode is not supported)

> It's fine with me, I can just put some absolute maximum temperatures
> around the batteries, I am more worrying if there are other users
> out there that might get upset.

If you put an active or passive trip point without a cooling device, 
that trip point won't do anything except sending a notification to the 
userspace when it is crossed (if monitored).

It is always useful to have a passive trip, so when the writable trip 
option is enabled, the userspace can set the temperature and get notified.

> I have a problem to add a trip point like this:
> 
>                  battery-crit-lo {
>                      temperature = <-50000>;
>                      hysteresis = <2000>;
>                      type = "critical";
>                  };
> 
> Despite it is legal to the schema:
> 
>              properties:
>                temperature:
>                  $ref: /schemas/types.yaml#/definitions/int32
>                  minimum: -273000
>                  maximum: 200000
>                  description:
>                    An integer expressing the trip temperature in millicelsius.
> 
> I get this error:
> 
>    DTC     arch/arm/boot/dts/ste-ux500-samsung-golden.dtb
> Error: ../arch/arm/boot/dts/ste-ux500-samsung-golden.dts:50.21-22 syntax error
> 
> Does anyone know how to put a negative number in a
> property?

I don't know but the thermal framework does not support the cold trip 
points (yet). That means here, the battery will be in temperature 
violation if the temperature is above -50°C


>>   From an implementation POV, that was not spotted initially because of
>> the old OF code design IMO (but I'm not sure).
>>
>> We can continue registering the thermal with no trip points but then
>> still raise a message.
>>
>> However, a thermal zone without trip point does not really make sense
>> IMO. If I'm correct, the ACPI at least defines the critical temperature
>> as a non optional object.
> 
> I don't know about that, this is from one of my laptops, output
> from "sensors" command:
> 
> acpitz-acpi-0
> Adapter: ACPI interface
> temp1:        +46.0°C  (crit = +99.0°C)
> temp2:        +46.0°C
> 
> This temp2 looks like a temperature zone without trip point...

Yeah, ACPI ...

Mine is:

acpi -tci
Thermal 0: ok, 16.8 degrees C
Thermal 0: trip point 0 switches to mode critical at temperature 20.8 
degrees C
Thermal 0: trip point 1 switches to mode hot at temperature 19.8 degrees C
Thermal 1: ok, 16.8 degrees C
Thermal 1: trip point 0 switches to mode critical at temperature 20.8 
degrees C
Thermal 1: trip point 1 switches to mode hot at temperature 19.8 degrees C

:)

> I guess Rafael might know for sure what is out there?
> 
> But if the idea is that DT want to mimic what ACPI is doing
> then it seems to me that ACPI has thermal zones without
> trip points.
> 
>> Did you consider using hwmon instead of a thermal zone ?
> 
> The concept of "thermal zone" actually makes much more
> sense for a battery since the thermistor is often not mounted
> in the battery (at least not in this case) and is measuring
> the proximity of the battery, not the battery per se.

IMO, you are reinventing the wheel in the battery code.

Why not use the cooling device psy_register_cooler()? And let the 
thermal framework deal with the monitoring and the mitigation ?

(cold trip point handling will have to stay in the current code)

>> Below a patch (not tested): one hand writing is painful
> 
> This works!
> I can sign off the patch and send it if you like.

Sure, no problem. May be see if that could be done more elegantly?

> I would probably alter the warning text "please add trip
> points to your DTS..."

Ok

