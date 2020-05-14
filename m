Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82D91D3D92
	for <lists+linux-pm@lfdr.de>; Thu, 14 May 2020 21:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgENTe5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 15:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726128AbgENTe4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 May 2020 15:34:56 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCB4C061A0C;
        Thu, 14 May 2020 12:34:56 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h4so4792828ljg.12;
        Thu, 14 May 2020 12:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=og+mFqkQ1CAe/czR3+TKiYrXrYEV1ucIAEKU/RyoNDU=;
        b=CZolF2DggsKTYh/lV2wyHaCyiHB7GdpzW6g/ZtAFXpginQWA/dcpxrrOZQN7GAq3Ue
         8zdhEQ1f//fiAMdlhLLQ9WqGSx/FouKUOmmRxTGAat8BhikOJpfiS79qRkg8S9neyS9p
         bKYRxmRxa0kRH7ZNCcu1yBLfMAmLjoxyNNzZwVcTDc6XcT/Wnw6z7NdKlmWP9xaxgI93
         F9JR+DvnTzhW6HBs4pLEg4DtNlD1nEoeO5CmRc63GIwhYw4UsMuejkrXmqv08YofzFUg
         s20cXrdibxukNV0TOQleiGRde2ZVH1xtygUSM2YCyDWwfClF7IGM9uOXOV61tuPCHY2X
         vqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=og+mFqkQ1CAe/czR3+TKiYrXrYEV1ucIAEKU/RyoNDU=;
        b=Pdz23X5p8SznJ0UV4lEV1aQvQryKgsrLmTY5JOnQgXcEQW9iGeuAQiNsN2MxBS6cNs
         j1AkquVLeYjCKdUm67GpRvgMGK0FKPikMbDstkhZr+BN9Bj0yiB9ci6nb6rFdUCYROBq
         MNIik8CzvKXGsohkz3gS7ZZ+XfVxspmDLafkfbvb20Zunkh0tPpKucGwrtNYocOTpSp0
         AZhxwL7+j4Sj9qtMojCxGzuqf9q/KXW6Wv6WL9RszWETh+FekgwfxTgVKsG8MUW5NjPo
         6cGXEuU6ynsh44N6swSHXat9pMX9cweDZ2CxgIUeW44gdWYFigkASHCeiSYvyRqZYqvz
         EtiQ==
X-Gm-Message-State: AOAM5331E38FW//1wv/4pbwlz9OUUgrlC3gBcJoK6z979yP3ujA8B8ea
        Klyc/m3iDmc96J/m4uxPIyWjqwpP
X-Google-Smtp-Source: ABdhPJxDflsh0HvwluZVujuFduHUZilb+GFF3x0ItuiZEaHP8qSiaL9YfMiDfg6H1ZW4TlRkFv1U/w==
X-Received: by 2002:a2e:9e97:: with SMTP id f23mr3698618ljk.228.1589484892987;
        Thu, 14 May 2020 12:34:52 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id w12sm53343ljj.55.2020.05.14.12.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 12:34:51 -0700 (PDT)
Subject: Re: [PATCH 4/9] dt-bindings: power: supply: Add device-tree binding
 for Summit SMB3xx
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Rob Herring <robh@kernel.org>, David Heidelberg <david@ixit.cz>,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Myungjoo Ham <myungjoo.ham@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ramakrishna.pallala@intel.com,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
References: <20200329161552.215075-1-david@ixit.cz>
 <20200329162128.218584-5-david@ixit.cz> <20200410164905.GA719@bogus>
 <8c4ab1ce-1947-ab38-3f8c-9055406428e4@gmail.com>
 <CAL_JsqJgZaQux04vdkShX4vkmOK5T-H6tOXt7Da19jgG0P76-Q@mail.gmail.com>
 <687db60d-fea9-f157-d4ce-907189bb3cc7@gmail.com>
 <20200509011406.hs7nj3g7f5pzetxp@earth.universe>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fea13673-9500-c34b-5b50-c4f8cef9c4d8@gmail.com>
Date:   Thu, 14 May 2020 22:34:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200509011406.hs7nj3g7f5pzetxp@earth.universe>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.05.2020 04:14, Sebastian Reichel пишет:
> Hi,
> 
> On Wed, Apr 15, 2020 at 06:30:02PM +0300, Dmitry Osipenko wrote:
>> 15.04.2020 17:27, Rob Herring пишет:
>>> On Fri, Apr 10, 2020 at 2:02 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>
>>>> 10.04.2020 19:49, Rob Herring пишет:
>>>> ...
>>>>>> +  summit,max-chg-curr:
>>>>>> +    description: Maximum current for charging (in uA)
>>>>>> +    allOf:
>>>>>> +      - $ref: /schemas/types.yaml#/definitions/uint32
>>>>>> +
>>>>>> +  summit,max-chg-volt:
>>>>>> +    description: Maximum voltage for charging (in uV)
>>>>>> +    allOf:
>>>>>> +      - $ref: /schemas/types.yaml#/definitions/uint32
>>>>>> +    minimum: 3500000
>>>>>> +    maximum: 4500000
>>>>>> +
>>>>>> +  summit,pre-chg-curr:
>>>>>> +    description: Pre-charging current for charging (in uA)
>>>>>> +    allOf:
>>>>>> +      - $ref: /schemas/types.yaml#/definitions/uint32
>>>>>> +
>>>>>> +  summit,term-curr:
>>>>>> +    description: Charging cycle termination current (in uA)
>>>>>> +    allOf:
>>>>>> +      - $ref: /schemas/types.yaml#/definitions/uint32
>>>> ...
>>>>> These are all properties of the battery attached and we have standard
>>>>> properties for some/all of these.
>>>>
>>>> Looks like only four properties seem to be matching the properties of
>>>> the battery.txt binding.
>>>>
>>>> Are you suggesting that these matching properties should be renamed
>>>> after the properties in battery.txt?
>>>
>>> Yes, and that there should be a battery node.
>>
>> Usually, it's a battery that has a phandle to the power-supply. Isn't it?
> 
> There are two things: The infrastructure described by 
> Documentation/devicetree/bindings/power/supply/power-supply.yaml is
> used for telling the operating system, that a battery is charged
> by some charger. This is done by adding a power-supplies = <&phandle>
> in the battery fuel gauge node referencing the charger and probably
> what you mean here.
> 
> Then we have the infrastructure described by 
> Documentation/devicetree/bindings/power/supply/battery.txt, which
> provides data about the battery cell. In an ideal world we would
> have only smart batteries providing this data, but we don't live
> in such a world. So what we currently have is a binding looking
> like this:
> 
> bat: dumb-battery {
>     compatible = "simple-battery";
> 
>     // data about battery cell(s)
> };
> 
> fuel-gauge {
>     // fuel-gauge specific data
> 
>     supplies = <&charger>;
>     monitored-battery = <&bat>;
> };
> 
> charger: charger {
>     // charger specific data
> 
>     monitored-battery = <&bat>;
> };
> 
> In an ideal world, charger should possibly reference fuel-gauge
> node, which could provide combined data. Right now we do not have
> the infrastructure for that, so it needs to directly reference
> the simple-battery node.
> 
>>> Possibly you should add
>>> new properties battery.txt. It's curious that different properties are
>>> needed.
>>
>> I guess it should be possible to make all these properties generic.
>>
>> Sebastian, will you be okay if we will add all the required properties
>> to the power_supply_core?
> 
> Extending battery.txt is possible when something is missing. As Rob
> mentioned quite a few are already described, though:
> 
> summit,max-chg-curr => constant-charge-current-max-microamp
> summit,max-chg-volt => constant-charge-voltage-max-microvolt
> summit,pre-chg-curr => precharge-current-microamp
> summit,term-curr => charge-term-current-microamp
> 
> I think at least the battery temperature limits are something, that
> should be added to the generic code.
> 
>>> Ultimately, for a given battery technology I would expect
>>> there's a fixed set of properties needed to describe how to charge
>>> them.
>>
>> Please notice that the charger doesn't "only charge" the battery,
>> usually it also supplies power to the whole device.
>>
>> For example, when battery is fully-charged and charger is connected to
>> the power source (USB or mains), then battery may not draw any current
>> at all.
> 
> It is also a question of how good the charging process should be.
> Technically I can charge a single cell Li-ion battery without
> knowing much, but it can reduce battery life and/or be very slow.
> It might even be dangerous, if charging is done at high
> temperatures. Also some of the properties in the battery binding
> are not about charging, but about gauging. Some devices basically
> have only options to measure voltage and voltage drop over a
> resistor and everything else must be done by the operating system.
> 
>>> Perhaps some of these properties can just be derived from other
>>> properties and folks are just picking what a specific charger wants.
>>
>> Could be so, but I don't know for sure.
> 
> I don't think we have things, that can be derived with a reasonable
> amount of effort in the existing simple-battery binding, except for
> energy-full-design-microwatt-hours & charge-full-design-microamp-hours.
> 
>> Even if some properties could be derived from the others, it won't hurt
>> if we will specify everything explicitly in the device-tree.
>>
>>> Unfortunately, we have just a mess of stuff made up for each charger
>>> out there. I don't have the time nor the experience in this area to do
>>> much more than say do better.
>>
>> I don't think it's a mess in the kernel. For example, it's common that
>> embedded controllers are exposed to the system as "just a battery",
>> while in fact it's a combined charger + battery controller and the
>> charger parameters just couldn't be changed by SW.
> 
> A good EC driver exposes a charger and a battery device, so that
> userspace can easily identify if a charger is connected.
> 
>> In a case of the Nexus 7 devices, the battery controller and charger
>> controller are two separate entities in the system. The battery
>> controller (bq27541) only monitors status of the battery (charge level,
>> temperature and etc).

Hello Sebastian,

Thank you very much for the comments! We'll prepare the v2.

