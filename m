Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B604020260E
	for <lists+linux-pm@lfdr.de>; Sat, 20 Jun 2020 20:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgFTS4Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 20 Jun 2020 14:56:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35351 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbgFTS4Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 20 Jun 2020 14:56:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id g21so7590143wmg.0;
        Sat, 20 Jun 2020 11:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=dUGfNi0JGg83YSyxuDLYdqdi5tiZCgq2XkK2gaGnDWA=;
        b=Q4WuwXdyOyytJFxW7hUULISpgqIIpwypY9sVBPPqHVyhbd1dOt1VWnBfP2O474/kPC
         O4zQm/GAb+sHI9nufXak40NNTmrqxQeGqH3wzaCDzs7S5IcovVGofIhuE3J0ll1MsR0W
         sLzoYKORhpbJ7joNR4o7WHs97ZUbkEVJsBGo/+smUynB65mZFoVSemZzzvKQXIsyKXay
         uSZRy5Y9DRZ6Ulqm6xJhVXUGoSzq399Md/n5o+mjrOuYc/y2kaZELttUSphHohNrzhcE
         RSc5qKbWa4gjBNUHIC29WY8+HdFMPGR9lGbv7ANdmrMso7xPF8jZDbxPQxtNnc5NElMv
         5GVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dUGfNi0JGg83YSyxuDLYdqdi5tiZCgq2XkK2gaGnDWA=;
        b=dypd3yCChjVJkUjnppv30AY9grg0uA413xlAjcTVSA6u7G1R62VtJDFfghAMh5mPsg
         yq0pnwtIKEzMcdRz2dc3O/Of6y+5SgaRWXrqHM7n8u4rGN07bLS0Oc7+9vNTxKazEPfM
         WTFb9rfV6XIDv+vwQLgtt0v694ByOLJXaYr5XMAGpOygjAA2lOMC7UH1vC6kMy4Rc4Td
         DteRDYKlXR7wawZZwDT8E9E02IsEy2tPrzCPmuahdgmyNSFVBZD99F3N8MrKxiCW8tkE
         P/rL48l4I3Op8mmNb6zL/AQ2kWGLgRHTKhhNNzuDTeBs9NbqCbSTgUDv9EKFDpBQswl2
         /Tmw==
X-Gm-Message-State: AOAM5307DYK0UM/jg0u5CBu6mp8A/WTLQuKw5mgqWt181jyD9a9eh+Po
        //pUwUitciP0rzVbuWiPqxQ=
X-Google-Smtp-Source: ABdhPJwQf+jLQmP44xOMq1BkFvQgJJV5c0uD9yeqBUkytFgA73GQQRZBXuO9pJprIAGLqlzEN/5bog==
X-Received: by 2002:a1c:b7d5:: with SMTP id h204mr10214079wmf.39.1592679321062;
        Sat, 20 Jun 2020 11:55:21 -0700 (PDT)
Received: from [192.168.86.31] ([213.191.183.145])
        by smtp.gmail.com with ESMTPSA id o6sm11332611wrp.3.2020.06.20.11.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2020 11:55:20 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] dt-bindings: power: supply: Document max17040
 extensions
To:     Sebastian Reichel <sre@kernel.org>
References: <20200618101340.2671020-1-iskren.chernev@gmail.com>
 <20200619155938.tpyeerqdn7dqcvw4@earth.universe>
 <e079df1e-297d-c3b9-d3e6-57758bfe0bb4@gmail.com>
 <20200619213122.crwlc7jckti6pxwm@earth.universe>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Bakker <xc-racer2@live.ca>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>
From:   Iskren Chernev <iskren.chernev@gmail.com>
Message-ID: <f02d9fa3-4717-b15b-9b84-a9cc26f4f009@gmail.com>
Date:   Sat, 20 Jun 2020 21:55:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200619213122.crwlc7jckti6pxwm@earth.universe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 6/20/20 12:31 AM, Sebastian Reichel wrote:
> Hi,
>
> On Fri, Jun 19, 2020 at 10:57:19PM +0300, Iskren Chernev wrote:
>> On 6/19/20 6:59 PM, Sebastian Reichel wrote:
>>> On Thu, Jun 18, 2020 at 01:13:39PM +0300, Iskren Chernev wrote:
>>>> Maxim max17040 is a fuel gauge from a larger family utilising the Model
>>>> Gauge technology. Document all different compatible strings that the
>>>> max17040 driver recognizes.
>>>>
>>>> Some devices in the wild report double the capacity. The
>>>> maxim,double-soc (from State-Of-Charge) property fixes that.
>>>>
>>>> Complete device reset might lead to very inaccurate readings. Specify
>>>> maxim,skip-reset to avoid that.
>>>>
>>>> To compensate for the battery chemistry and operating conditions the
>>>> chips support a compensation value. Specify one or two byte compensation
>>>> via the maxim,rcomp byte array.
>>>>
>>>> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
>>>> ---
>>>> v1: https://lkml.org/lkml/2020/6/8/682
>>>>
>>>> Changes in v2:
>>>> - add maxim,skip-reset
>>>> - remove 2 byte rcomp from example, the specified compat string supports 1 byte
>>>>    rcomp
>>>>
>>>>   .../power/supply/max17040_battery.txt         | 24 ++++++++++++++++++-
>>>>   1 file changed, 23 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
>>>> index 4e0186b8380fa..3ee91c295027f 100644
>>>> --- a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
>>>> +++ b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
>>>> @@ -2,7 +2,9 @@ max17040_battery
>>>>   ~~~~~~~~~~~~~~~~
>>>>
>>>>   Required properties :
>>>> - - compatible : "maxim,max17040" or "maxim,max77836-battery"
>>>> + - compatible : "maxim,max17040", "maxim,max17041", "maxim,max17043",
>>>> +         "maxim,max17044", "maxim,max17048", "maxim,max17049",
>>>> +        "maxim,max17058", "maxim,max17059" or "maxim,max77836-battery"
>>>>    - reg: i2c slave address
>>>>
>>>>   Optional properties :
>>>> @@ -11,6 +13,18 @@ Optional properties :
>>>>                  generated. Can be configured from 1 up to 32
>>>>                  (%). If skipped the power up default value of
>>>>                  4 (%) will be used.
>>>> +- maxim,double-soc :         Certain devices return double the capacity.
>>>> +                Specify this boolean property to divide the
>>>> +                reported value in 2 and thus normalize it.
>>>> +                SOC == State of Charge == Capacity.
>>>
>>> Can this be derived from the compatible?
>>
>> So far, I'm aware of 2 devices using max17048 that need this setting. That
>> would be 100% of the 17048 devices I know of [1]. At the same time, according to
>> the max17048 documentation this is not the case.
>>
>> [1] These are the Samsung Galaxy S5 (klte) and the LG Nexus 5 (hammerhead).
>
> Wouldn't be the first time, that documentation is wrong. Have you
> checked how its handled in the downstream Android kernel?

Yes, I have checked both klte[1] and hammerhead[2] downstream. About the state
of charge -- the klte has the spec formula and the double formula, and the
hammerhead has provisions in it's DTS to configure max/min raw values,
effectively enabling arbitrary scaling of the value.

About the reset on start, klte does a quick-start (0x4000 to MODE reg).
Hammerhead resets the RI status bit (which in itself does not reset anything).

I now also looked at downstream implementation of the other fuelgauges.
Here are examples of 17040[3], 17043[4], 17058[5].  It looks like most of the
family (except 17040) is prone to this doubling. [4] and [5] have both formulas
toggleable with a macro. So I think leaving double-soc as an option in DTS is
the right choice.

About the reset -- looks like only 17040 is reset on start. The newer ones are
either quick-started or nothing. So hard-resetting only the 17040 might be
a good choice.

[1] https://github.com/LineageOS/android_kernel_samsung_msm8974/blob/5dddbe776631650086c4491ec4037fbe73fa5795/drivers/battery/max17048_fuelgauge.c#L135
[2] https://github.com/LineageOS/android_kernel_lge_hammerhead/blob/62154f7111663d42655400f83c3c9d10a965571c/drivers/power/max17048_battery.c#L834
[3] https://github.com/LineageOS/android_kernel_lenovo_msm8916/blob/9a4a2ca2832653c90af7fae7503fc64687968700/drivers/power/max17040_battery.c
[4] https://github.com/LineageOS/android_kernel_lge_v500/blob/b4fe00e1f8f09c173a6c28a42ca69ff9529cc13b/drivers/power/max17043_fuelgauge.c#L343
[5] https://github.com/LineageOS/android_kernel_asus_moorefield/blob/c3eae894ce8092c2a9a51f9a4924c8df714d6b3c/drivers/power/ASUS_BATTERY/max17058_battery.c#L551

>>>> +- maxim,skip-reset :        Do not reset device on driver initialization.
>>>> +                Some devices report extremely inaccurately after
>>>> +                a hard reset.
>>>
>>> Same question.
>>>
>>> -- Sebastian
>>>
>>
>> This is even weirder. There is no mention in the documentation about whether
>> the device should be reset on boot (because the fuelgauge is on even during
>> device off times). Testing on 17040 and 17043 reveals no issues with resetting
>> on boot, but on the 17048 I have; the readings are up to 2x wrong if you do
>> reset on boot. Not doing a reset *might* leave the device in a state that is
>> not 100% known by the driver, but I don't know of any real world problems
>> stemming from that.
>>
>> So in a sense, I can apply both of these quirks for 17048, and it will work for
>> all devices I have tested on, but it won't follow the spec. That is why
>> I decided to mark them as special behavior needing configuration per use case.
>> On the other hand, I can incorporate them in 17048, and if someone complains
>> the bindings can be introduced later (because they are stable API and
>> introducing them now is a bit over engineered).
>
> Yes, just apply the quirks for 17048.

As I mentioned in the previous paragraph, double-soc could benefit most of the
family (excluding 17040), so I suggest we keep it, whereas doing a reset could
remain for the 17040 only (removing the need for a flag in bindings).

> -- Sebastian
>
>>>> +- maxim,rcomp :            A value to compensate readings for various
>>>> +                battery chemistries and operating temperatures.
>>>> +                max17040,41 have 2 byte rcomp, default to
>>>> +                0x97 0x00. All other devices have one byte
>>>> +                rcomp, default to 0x97.
>>>>   - interrupts :             Interrupt line see Documentation/devicetree/
>>>>                  bindings/interrupt-controller/interrupts.txt
>>>>   - wakeup-source :        This device has wakeup capabilities. Use this
>>>> @@ -31,3 +45,11 @@ Example:
>>>>          interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
>>>>          wakeup-source;
>>>>      };
>>>> +
>>>> +    battery-fuel-gauge@36 {
>>>> +        compatible = "maxim,max17048";
>>>> +        reg = <0x36>;
>>>> +        maxim,rcomp = /bits/ 8 <0x97>;
>>>> +        maxim,alert-low-soc-level = <10>;
>>>> +        maxim,double-soc;
>>>> +    };
>>>>
>>>> base-commit: 1713116fa907cc7290020f0d8632ec646d2936f8
>>>> --
>>>> 2.27.0
>>>>
>>

