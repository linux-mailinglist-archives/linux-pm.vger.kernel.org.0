Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1467C1AABEC
	for <lists+linux-pm@lfdr.de>; Wed, 15 Apr 2020 17:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393140AbgDOPaT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Apr 2020 11:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2636915AbgDOPaI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Apr 2020 11:30:08 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD5CC061A0C;
        Wed, 15 Apr 2020 08:30:07 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id h6so2999010lfc.0;
        Wed, 15 Apr 2020 08:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DPb8+Nlpt6o6yna8tbp3FRUHgnKxP8jckYKTvBj50iI=;
        b=ApJldMkkCVVKxU6kq1SAxFv5PDRfiNyfKpgmK2Vd0uJdBj+w8iIYutz4KrSB2/Cq45
         OE5JHyvfvfFKhfQajnrIP36sjB47tMiNXafcn/5YtAdaLpZ4Vu9a8eXCVHx1ESZ4ju9P
         DT7ftWHICKujchkQaa6az3Sompeb8MWtUSaY65+NfLy+zPgC8+LtKyTVggVf7nC9idbC
         IB0g0u5QY5ktrF4cRmeTtsumj463JYVTwZj7GrEjoBJT6il3z38oEjrgP8ctZxmAKAF9
         MWobJP+tDedOmalmze7ZNCMET/GmLE1dxyXIurzf6B1qAxVQ2gUlWRkecbMZf5oIZICX
         gs6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DPb8+Nlpt6o6yna8tbp3FRUHgnKxP8jckYKTvBj50iI=;
        b=YKQPvr47bcNuxtqf+WRSrvdysHY3K2ziPBYqUtIo++xuGqba1Ce63CTT3J7Ggz2OVd
         C+7CnXykoftgmMt9mzsSbg0juqYi6W8MMZyKq6dtMWjhITNLv48r8AtXanFq1mH6RMrC
         0klLHxezpon8y/+ycp3pcqjioxdqkFV7qDCvXDOcuzJUg9gLtC/dSuXxKIs2JaqH6BnW
         N/Sr4/z5ZyEmRsCR29l8Qv1uO3RdSTfpmFHua4EdZsv39RK+GJ0R5fkkmpUJR1ZhVsfZ
         KaE5PQfffkiURenmRDTuEkEhKSWkDKZwg89KXUbHGVC4oV8xFLtat0b0WWpCl1QLNr88
         l8gw==
X-Gm-Message-State: AGi0PuZgFzx7+VAA/i4AOTNhCu+KPCyGTPWh3RyECMuHLUWezsbyDgOG
        U+nodaMpJ1SsKtz72BJCA/lZGoF2
X-Google-Smtp-Source: APiQypLpFlA7IaDBDoJ9pTmc16n06mw9a2eJURsaHUuckGt8BSsHfTaDsETXroXxN4JjYGwHqKgpwg==
X-Received: by 2002:ac2:4c39:: with SMTP id u25mr3472297lfq.54.1586964605024;
        Wed, 15 Apr 2020 08:30:05 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id k18sm16579906lfg.81.2020.04.15.08.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 08:30:03 -0700 (PDT)
Subject: Re: [PATCH 4/9] dt-bindings: power: supply: Add device-tree binding
 for Summit SMB3xx
To:     Rob Herring <robh@kernel.org>, David Heidelberg <david@ixit.cz>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Jonghwa Lee <jonghwa3.lee@samsung.com>,
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <687db60d-fea9-f157-d4ce-907189bb3cc7@gmail.com>
Date:   Wed, 15 Apr 2020 18:30:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJgZaQux04vdkShX4vkmOK5T-H6tOXt7Da19jgG0P76-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

15.04.2020 17:27, Rob Herring пишет:
> On Fri, Apr 10, 2020 at 2:02 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 10.04.2020 19:49, Rob Herring пишет:
>> ...
>>>> +  summit,max-chg-curr:
>>>> +    description: Maximum current for charging (in uA)
>>>> +    allOf:
>>>> +      - $ref: /schemas/types.yaml#/definitions/uint32
>>>> +
>>>> +  summit,max-chg-volt:
>>>> +    description: Maximum voltage for charging (in uV)
>>>> +    allOf:
>>>> +      - $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    minimum: 3500000
>>>> +    maximum: 4500000
>>>> +
>>>> +  summit,pre-chg-curr:
>>>> +    description: Pre-charging current for charging (in uA)
>>>> +    allOf:
>>>> +      - $ref: /schemas/types.yaml#/definitions/uint32
>>>> +
>>>> +  summit,term-curr:
>>>> +    description: Charging cycle termination current (in uA)
>>>> +    allOf:
>>>> +      - $ref: /schemas/types.yaml#/definitions/uint32
>> ...
>>> These are all properties of the battery attached and we have standard
>>> properties for some/all of these.
>>
>> Looks like only four properties seem to be matching the properties of
>> the battery.txt binding.
>>
>> Are you suggesting that these matching properties should be renamed
>> after the properties in battery.txt?
> 
> Yes, and that there should be a battery node.

Usually, it's a battery that has a phandle to the power-supply. Isn't it?

> Possibly you should add
> new properties battery.txt. It's curious that different properties are
> needed.

I guess it should be possible to make all these properties generic.

Sebastian, will you be okay if we will add all the required properties
to the power_supply_core?

> Ultimately, for a given battery technology I would expect
> there's a fixed set of properties needed to describe how to charge
> them.

Please notice that the charger doesn't "only charge" the battery,
usually it also supplies power to the whole device.

For example, when battery is fully-charged and charger is connected to
the power source (USB or mains), then battery may not draw any current
at all.

> Perhaps some of these properties can just be derived from other
> properties and folks are just picking what a specific charger wants.

Could be so, but I don't know for sure.

Even if some properties could be derived from the others, it won't hurt
if we will specify everything explicitly in the device-tree.

> Unfortunately, we have just a mess of stuff made up for each charger
> out there. I don't have the time nor the experience in this area to do
> much more than say do better.

I don't think it's a mess in the kernel. For example, it's common that
embedded controllers are exposed to the system as "just a battery",
while in fact it's a combined charger + battery controller and the
charger parameters just couldn't be changed by SW.

In a case of the Nexus 7 devices, the battery controller and charger
controller are two separate entities in the system. The battery
controller (bq27541) only monitors status of the battery (charge level,
temperature and etc).
