Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0281378DA1A
	for <lists+linux-pm@lfdr.de>; Wed, 30 Aug 2023 20:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbjH3Sf2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Aug 2023 14:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245551AbjH3PdD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Aug 2023 11:33:03 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15771A4
        for <linux-pm@vger.kernel.org>; Wed, 30 Aug 2023 08:32:57 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52a5c0d949eso5375370a12.0
        for <linux-pm@vger.kernel.org>; Wed, 30 Aug 2023 08:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693409576; x=1694014376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FOkMhQZaIwST9Tftkc4xHZGF2ejBRi9KztfbwPpap1g=;
        b=s40XoOjir1wAK96uwJcWbx6714jbI8jGuoA9n01pj+422m+SUK3IYUeFmrYM32xxDq
         LSG/kYjiGDVueCoYp/oA4sNx+Az1nRTuhBcytjrDefZTZydWMERd9yDOFWyHj9w0RcIF
         nbvoG0/H6u7RQgL1XiSrn7MYBlKpcdGekAjMutP0MngGCeisi/LoH8AFD2Rv8ozceo6p
         B/Y8V5OjVponr7gg1tb4viY7VFTA6kEypmfhn6e0iMGjDKjZwutmCYqvue5Pn2hWQVnb
         /qt8fjMMnq1SjPqajHZ0xiBIjNPKrSPEXiHVQPbrLYyv3T5HteeEgkLamPt/OwkeYfTA
         jQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693409576; x=1694014376;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FOkMhQZaIwST9Tftkc4xHZGF2ejBRi9KztfbwPpap1g=;
        b=Q80A8jiRCDf7O9ArRVp3+qCtzX4S4cDjGMUgEnX0N3ufpbDgovwajP8W575Hrf1L3x
         wdVLACvCDKQAEkNUphRh5y4Sz10T7Vj2pbZMMrlsrg7CL7TXm5w2r/Xmw4W75hjR+tTn
         hehMS20qV0rYr1lTfw90nqhLhTH1ZtIiC7ZbZpZjOPYIwtupP2DPIm2aGLmXKClGerQ0
         MSyej4duY1NSmRrilWhGkRqdUsIhQlPRn6/Xf/amOyLU7OfHMwb2BRny7UHp3EClYbc5
         D3jQg5ELHDPkDcqet5ZJjxgLEBtREsH4oR+uEYD06Z3q4rLZGay2Vo+pKTiD2yEp9BgH
         E3lg==
X-Gm-Message-State: AOJu0YxiMXSaE0FR9OOXYkn0LjCSPuYq857P9naGy8riIkHUcyYnsv6m
        jnVXgZdyAyPtJL/b2Uq6BWbjFA==
X-Google-Smtp-Source: AGHT+IHvgqAAT2lDmKAAkG1+47jP15vPqePLQByCrpQX6yoApqzcX9TLeKVxU9mjQ9Ra1RY52Qw4ew==
X-Received: by 2002:a17:906:51c2:b0:991:d2a8:658a with SMTP id v2-20020a17090651c200b00991d2a8658amr2084051ejk.34.1693409576047;
        Wed, 30 Aug 2023 08:32:56 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id qq21-20020a17090720d500b0099329b3ab67sm7353678ejb.71.2023.08.30.08.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 08:32:55 -0700 (PDT)
Message-ID: <88f29c9a-3faf-1470-6865-27f88b135f87@linaro.org>
Date:   Wed, 30 Aug 2023 17:32:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 1/3] dt-bindings: thermal-zones: Document
 critical-action
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>, daniel.lezcano@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>
References: <20230829194200.1901988-1-festevam@gmail.com>
 <CAJZ5v0hZR3WD+wMA6c-Gt86hM5oCRZDcSsYF4SrYTvT2HtQ=fQ@mail.gmail.com>
 <c5d72559-4a97-c865-e51e-855d2bc1edee@linaro.org>
 <CAJZ5v0gexPEV2M5kfgCEUti=EE+_oR+wUjRboo0Rh=fPfNeDew@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAJZ5v0gexPEV2M5kfgCEUti=EE+_oR+wUjRboo0Rh=fPfNeDew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30/08/2023 15:54, Rafael J. Wysocki wrote:
> On Wed, Aug 30, 2023 at 3:07 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 30/08/2023 13:37, Rafael J. Wysocki wrote:
>>> On Tue, Aug 29, 2023 at 9:42 PM Fabio Estevam <festevam@gmail.com> wrote:
>>>>
>>>> From: Fabio Estevam <festevam@denx.de>
>>>>
>>>> Document the critical-action property to describe the thermal action
>>>> the OS should perform after the critical temperature is reached.
>>>>
>>>> The possible values are "shutdown" and "reboot".
>>>>
>>>> The motivation for introducing the critical-action property is that
>>>> different systems may need different thermal actions when the critical
>>>> temperature is reached.
>>>>
>>>> For example, a desktop PC may want the OS to trigger a shutdown
>>>> when the critical temperature is reached.
>>>>
>>>> However, in some embedded cases, such behavior does not suit well,
>>>> as the board may be unattended in the field and rebooting may be a
>>>> better approach.
>>>>
>>>> The bootloader may also benefit from this new property as it can check
>>>> the SoC temperature and in case the temperature is above the critical
>>>> point, it can trigger a shutdown or reboot accordingly.
>>>>
>>>> Signed-off-by: Fabio Estevam <festevam@denx.de>
>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> ---
>>>> Changes since v4:
>>>> - None.
>>>>
>>>>  .../devicetree/bindings/thermal/thermal-zones.yaml       | 9 +++++++++
>>>>  1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
>>>> index 4f3acdc4dec0..c2e4d28f885b 100644
>>>> --- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
>>>> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
>>>> @@ -75,6 +75,15 @@ patternProperties:
>>>>            framework and assumes that the thermal sensors in this zone
>>>>            support interrupts.
>>>>
>>>> +      critical-action:
>>>> +        $ref: /schemas/types.yaml#/definitions/string
>>>> +        description:
>>>> +          The action the OS should perform after the critical temperature is reached.
>>>> +
>>>> +        enum:
>>>> +          - shutdown
>>>> +          - reboot
>>>> +
>>>>        thermal-sensors:
>>>>          $ref: /schemas/types.yaml#/definitions/phandle-array
>>>>          maxItems: 1
>>>> --
>>>
>>> I'm wondering if this should be a bool property called
>>> "critical-reboot", say, which when present would mean to carry out a
>>> reboot instead of a shutdown in an emergency.
>>>
>>> As defined above, the "shutdown" value is simply redundant, because
>>> the code will effectively convert any other value to "shutdown"
>>> anyway.
>>
>> We covered this at v1. Bool does not allow this property to change in
>> the future, e.g. for a third mode. And how would you change the action
>> to shutdown if default action in the system was reboot?
> 
> Well, as a matter of fact, it isn't, so I'm not sure where this is going.

It isn't in which system and firmware? Maybe most, but how can you know
for sure. Bindings are independent of given OS implementation, thus
relying on default OS choice is shortsighted.

> 
> Bool definitely allows the property to be not present, which means
> that the default behavior is intended and this is all about overriding
> a known default behavior.
> 
> Anyway, if the maintainers of DT bindings are fine with the current
> definition, I'm not going to block this.  I just wanted to make a note
> that it wasn't looking particularly straightforward to me.

Sure. It has one DT's maintainer Ack (mine) and maybe also Rob will
comment on it.

Best regards,
Krzysztof

