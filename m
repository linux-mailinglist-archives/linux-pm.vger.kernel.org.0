Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C85201BD4
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jun 2020 22:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388692AbgFSUBh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jun 2020 16:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbgFSUBh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jun 2020 16:01:37 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF09C06174E;
        Fri, 19 Jun 2020 13:01:36 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l10so10833303wrr.10;
        Fri, 19 Jun 2020 13:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Cxjci5St9eZYx3yplpvSM+3ebTUiAn7Gy/G5e/Xp384=;
        b=ViIqqV0q/KAoiUTv/wUitJGoyF0Pui9iukheMkIQ2AoxhdlqPrh4SXqjzkvJM4oiwg
         1FwXdU8ZchjAhZa0TlBMnYbW6mgWNpXkxjP0P0aZOOmC+NGP8Qut8qwcbSa9Wb2bE8eu
         /zM8Os/tZR814i3DS/Rx2HTlQkbTwJ/iTcwshUcxn8rV+QabNmrke30l9J6Zklot/MIX
         OYGu7LvOc3MWtBAQuHqEihMry6guSZZJJaLNU9G7hgFuUpc6RTMNXHRD+r4jJpj40pZJ
         LxmU2MNiomhHZLANPTt+udo51UCNGR0NZNkK6SB1LFg63tL3qUxiyrIqqIofetuyDgKA
         3rbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Cxjci5St9eZYx3yplpvSM+3ebTUiAn7Gy/G5e/Xp384=;
        b=ukje1MMBm+9zAyJYA6xsoNLAg+rglEINu6UPw61lB3NtGS0iKSeC/M8BJG/Wxlk/KB
         vZ9SIuBtYmhYnrYLK4j7dljJw5U2zpP0bCnDqCRoP13odZTnsblFGwG+KzT76z7C4WtW
         CL7DNaQncpBsIXmg7nq/GK8dx3ESdOxEvVCysosGMAiA6UGbOBrAhuVkLUVqr7TZPILR
         x4Hngcpx8HeZv2fAF5YBCLIArdNY2kmOXgchzT+aZgqC0nna2sxzC4psIp5m1rT5DZM8
         hKvXktCcdkH/tPZ41bBqy64wf/JD2H3J9XSSJ9idgnMptCa4BJm814vkgEE1zRbcIvvA
         FRCQ==
X-Gm-Message-State: AOAM532zWBmU2iIQj3zLFXzputOH4em3xfN5z3tT/2Uln/TKnkjXkA3u
        MzHDjlzdM54WdSUwuakHFenlRdawaB4=
X-Google-Smtp-Source: ABdhPJwr3duP5ZBRsQVrYNR2c1YeKqfjG+Wr3p6A9ERqKimXd82YSECM/mCW/K2eGe+S01ykbvUCUg==
X-Received: by 2002:adf:eec2:: with SMTP id a2mr5571390wrp.136.1592596895411;
        Fri, 19 Jun 2020 13:01:35 -0700 (PDT)
Received: from [192.168.86.31] ([213.191.183.145])
        by smtp.gmail.com with ESMTPSA id g3sm9225078wrb.46.2020.06.19.13.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 13:01:34 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] dt-bindings: power: supply: Document max17040
 extensions
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Bakker <xc-racer2@live.ca>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>
References: <20200618101340.2671020-1-iskren.chernev@gmail.com>
 <20200619155938.tpyeerqdn7dqcvw4@earth.universe>
From:   Iskren Chernev <iskren.chernev@gmail.com>
Message-ID: <c7747c37-58c0-79ee-0416-71bb460d168d@gmail.com>
Date:   Fri, 19 Jun 2020 23:01:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200619155938.tpyeerqdn7dqcvw4@earth.universe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 6/19/20 6:59 PM, Sebastian Reichel wrote:
> Hi,
>
> On Thu, Jun 18, 2020 at 01:13:39PM +0300, Iskren Chernev wrote:
>> Maxim max17040 is a fuel gauge from a larger family utilising the Model
>> Gauge technology. Document all different compatible strings that the
>> max17040 driver recognizes.
>>
>> Some devices in the wild report double the capacity. The
>> maxim,double-soc (from State-Of-Charge) property fixes that.
>>
>> Complete device reset might lead to very inaccurate readings. Specify
>> maxim,skip-reset to avoid that.
>>
>> To compensate for the battery chemistry and operating conditions the
>> chips support a compensation value. Specify one or two byte compensation
>> via the maxim,rcomp byte array.
>>
>> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
>> ---
>> v1: https://lkml.org/lkml/2020/6/8/682
>>
>> Changes in v2:
>> - add maxim,skip-reset
>> - remove 2 byte rcomp from example, the specified compat string supports 1 byte
>>   rcomp
>>
>>  .../power/supply/max17040_battery.txt         | 24 ++++++++++++++++++-
>>  1 file changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
>> index 4e0186b8380fa..3ee91c295027f 100644
>> --- a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
>> +++ b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
>> @@ -2,7 +2,9 @@ max17040_battery
>>  ~~~~~~~~~~~~~~~~
>>
>>  Required properties :
>> - - compatible : "maxim,max17040" or "maxim,max77836-battery"
>> + - compatible : "maxim,max17040", "maxim,max17041", "maxim,max17043",
>> +         "maxim,max17044", "maxim,max17048", "maxim,max17049",
>> +        "maxim,max17058", "maxim,max17059" or "maxim,max77836-battery"
>>   - reg: i2c slave address
>>
>>  Optional properties :
>> @@ -11,6 +13,18 @@ Optional properties :
>>                  generated. Can be configured from 1 up to 32
>>                  (%). If skipped the power up default value of
>>                  4 (%) will be used.
>> +- maxim,double-soc :         Certain devices return double the capacity.
>> +                Specify this boolean property to divide the
>> +                reported value in 2 and thus normalize it.
>> +                SOC == State of Charge == Capacity.
>
> Can this be derived from the compatible?
>

So far, I'm aware of 2 devices using max17048 that need this setting. That
would be 100% of the 17048 devices I know of [1]. At the same time, according to
the max17048 documentation this is not the case.

[1] These are the Samsung Galaxy S5 (klte) and the LG Nexus 5 (hammerhead).

>> +- maxim,skip-reset :        Do not reset device on driver initialization.
>> +                Some devices report extremely inaccurately after
>> +                a hard reset.
>
> Same question.
>
> -- Sebastian
>

This is even weirder. There is no mention in the documentation about whether
the device should be reset on boot (because the fuelgauge is on even during
device off times). Testing on 17040 and 17043 reveals no issues with resetting
on boot, but on the 17048 I have; the readings are up to 2x wrong if you do
reset on boot. Not doing a reset *might* leave the device in a state that is
not 100% known by the driver, but I don't know of any real world problems
stemming from that.

So in a sense, I can apply both of these quirks for 17048, and it will work for
all devices I have tested on, but it won't follow the spec. That is why
I decided to mark them as special behavior needing configuration per use case.
On the other hand, I can incorporate them in 17048, and if someone complains
the bindings can be introduced later (because they are stable API and
introducing them now is a bit over engineered).

>> +- maxim,rcomp :            A value to compensate readings for various
>> +                battery chemistries and operating temperatures.
>> +                max17040,41 have 2 byte rcomp, default to
>> +                0x97 0x00. All other devices have one byte
>> +                rcomp, default to 0x97.
>>  - interrupts :             Interrupt line see Documentation/devicetree/
>>                  bindings/interrupt-controller/interrupts.txt
>>  - wakeup-source :        This device has wakeup capabilities. Use this
>> @@ -31,3 +45,11 @@ Example:
>>          interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
>>          wakeup-source;
>>      };
>> +
>> +    battery-fuel-gauge@36 {
>> +        compatible = "maxim,max17048";
>> +        reg = <0x36>;
>> +        maxim,rcomp = /bits/ 8 <0x97>;
>> +        maxim,alert-low-soc-level = <10>;
>> +        maxim,double-soc;
>> +    };
>>
>> base-commit: 1713116fa907cc7290020f0d8632ec646d2936f8
>> --
>> 2.27.0
>>

P.S sorry for the double email, forgot reply-all

