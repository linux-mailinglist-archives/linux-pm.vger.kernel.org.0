Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF7660EAE8
	for <lists+linux-pm@lfdr.de>; Wed, 26 Oct 2022 23:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiJZVkb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Oct 2022 17:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJZVk3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Oct 2022 17:40:29 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5933402FA
        for <linux-pm@vger.kernel.org>; Wed, 26 Oct 2022 14:40:27 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h9so17599502wrt.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Oct 2022 14:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwNsTTHURgLKh1yzrfJmsvrLjDlMLsHVhYFq55x7IQw=;
        b=kBXKvkT9uhSkFnS920jsjAGIEyNb8LsD4LCnYYkb9ko5md1J4ZNLClGIA/JlFdEYmD
         5vJtCwxLw7yjiXPxXlJkLd9kDAI+B8cM4QOC/2XF3MMUY9+1TlaHIxgvIX7atn3471x7
         bjpoiR3B8WlldTNhtauz6hoR+7nziwPN9ged4M+hOF6L3luIcq7VmNjcTUZStFvOItg5
         oa5krI7qB0EqKR1k14xsLYDM5Pdo/cG6v0rbX0nXXwWJyuZuFcfJ6Fv9F5mbK94YJrXq
         8GPKmPQR3fgtP4xuiLzINHNWlwRjXhzu9NcTpA8MnE+ItywNzLok1UrcC5JU3nFI+S1Y
         GJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwNsTTHURgLKh1yzrfJmsvrLjDlMLsHVhYFq55x7IQw=;
        b=4Gl1OqkeHHyU1uIZsSZnPifjC8AjMzgPGqoF2Wm9McSmnl9QqTT2k3nPPgJRfY0z51
         uU1m6ZIIuBkiDYL35bJneoCe83hTTIVHIUTaV+suU94ms3L2sqFTefUyLjteecnfzbhF
         HIn2ISa+EV6KbuNkdSvoM03w0YOdwcuw3JbTOPTwaUXWbzDGh+INi3MBqFDH/HSOcRLE
         DaHx+xTfQ7ocJXZAp37JBU96DuvOrroO3b2SO0xqPgAX3UOVdS4wpnY+YAuV4kN/n8yh
         rKDV2nMyEnE+U2cw3Vd7exfSCuQfvCM75SYsVAgwPAEdn1GwS+XO46iSKBSecEndvis2
         x9kg==
X-Gm-Message-State: ACrzQf0vpD+v16IhmKsYMYl+ctLHEVqHbWwdreXoyzeias368wFMuQJz
        dDwu93Okrp2xx6FysiBzsTBcEw==
X-Google-Smtp-Source: AMsMyM5eltNal8ZWcghIGGfcdTmo5/xb13hUZbFhwKbSacJ5LZ+4HZLEOzOfJR2PEnnOuvix+qqRZQ==
X-Received: by 2002:a5d:59a4:0:b0:230:eaa4:88d7 with SMTP id p4-20020a5d59a4000000b00230eaa488d7mr30926262wrr.35.1666820426034;
        Wed, 26 Oct 2022 14:40:26 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:3f3f:ad57:c99f:65a2? ([2a05:6e02:1041:c10:3f3f:ad57:c99f:65a2])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c351100b003c7087f6c9asm3045152wmq.32.2022.10.26.14.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 14:40:25 -0700 (PDT)
Message-ID: <4817aeca-4fb1-cb99-8df5-7df22a77ea3f@linexp.org>
Date:   Wed, 26 Oct 2022 23:40:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
References: <CACRpkdbB5hgkrPZVb-+9tuKErvwjTKNaBQ1LvH1==fR7bndjSQ@mail.gmail.com>
 <CAL_JsqKQM4oSxrbhA4_ST8O0ieek9sGQQ9p55AXjhqmVx=rUrw@mail.gmail.com>
 <CAJZ5v0i76X0TiaOhPa3a5440fRb7vA1z1mFKJibso8G6wYz7HQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
Subject: Re: Regression after recent changes to drivers/thermal/thermal_of.c
In-Reply-To: <CAJZ5v0i76X0TiaOhPa3a5440fRb7vA1z1mFKJibso8G6wYz7HQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26/10/2022 19:06, Rafael J. Wysocki wrote:
> On Wed, Oct 26, 2022 at 5:47 PM Rob Herring <robh+dt@kernel.org> wrote:
>>
>> On Tue, Oct 25, 2022 at 4:13 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>>>
>>> Hi Folks,
>>>
>>> I have this in my dmesg in v6.1-rc1:
>>>
>>> [    3.879229] ab8500-fg ab8500-fg.0: line impedance: 36000 uOhm
>>> [    3.892793] power_supply ab8500_usb: Samsung SDI EB-L1M7FLU battery 1500 mAh
>>> [    3.901663] thermal_sys: Failed to find 'trips' node
>>> [    3.906635] thermal_sys: Failed to find trip points for thermistor id=0
>>> [    3.913427] ntc-thermistor thermistor: unable to register as hwmon device.
>>> [    3.920350] ntc-thermistor: probe of thermistor failed with error -22
>>>
>>> The device tree looks like this
>>> (arch/arm/boot/dts/ste-ux500-samsung-golden.dts):
>>>
>>>          thermal-zones {
>>>                  battery-thermal {
>>>                          /* This zone will be polled by the battery
>>> temperature code */
>>>                          polling-delay = <0>;
>>>                          polling-delay-passive = <0>;
>>>                          thermal-sensors = <&bat_therm>;
>>>                  };
>>>          };
>>>
>>> This is a thermal zone without trip points, which it seems like the new
>>> code does not allow, also the bindings were patched to not allow this,
>>> in commit 8c596324232d22e19f8df59ba03410b9b5b0f3d7
>>> "dt-bindings: thermal: Fix missing required property"
>>> but this broke my systems. The requirement to have trip points also
>>> broke my device trees.
>>>
>>> The reason why I have this is that the thermal zone is not managed
>>> by the OF thermal core, but by the battery charging algorithm which
>>> just retrieves the thermal zone and use it to read the temperature, see
>>> commit 2b0e7ac0841b3906aeecf432567b02af683a596c
>>> "power: supply: ab8500: Integrate thermal zone".
>>>
>>> The code is using
>>> thermal_zone_get_zone_by_name()
>>> thermal_zone_get_temp()
>>> and applying its own policy on the thermal zone in order to not
>>> dulicate code.
>>>
>>> I understand from the code and changes to the bindings that the
>>> authors assume that no zones without trips exist but... well they
>>> exist.
>>>
>>> I understand that the bindings always said that trips are required
>>> but ... thermal zones without trip points make a bit of sense.
>>> It's just a zone without a policy. It can be observed even if it can't
>>> be acted on.
>>>
>>> How do you want to solve this? Can we make trips non-compulsory
>>> again or shall I add dummy trip points to the device trees?
>>>
>>> This:
>>>
>>> diff --git a/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
>>> b/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
>>> index b0dce91aff4b..d00e9e6ebbf7 100644
>>> --- a/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
>>> +++ b/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
>>> @@ -35,6 +35,15 @@ battery-thermal {
>>>                          polling-delay = <0>;
>>>                          polling-delay-passive = <0>;
>>>                          thermal-sensors = <&bat_therm>;
>>> +
>>> +                       trips {
>>> +                               /* Unused trip point to please the framework */
>>> +                               dummy {
>>> +                                       temperature = <700000>;
>>> +                                       hysteresis = <2000>;
>>> +                                       type = "passive";
>>> +                               };
>>> +                       };
>>
>> That's ugly and requiring a DT update breaks the ABI. So the
>> requirement for 'trips' should be reverted. (Well the schema should, I
>> imagine the code change is not just a revert.)
> 
> I agree and the code change is not just a revert AFAICS.
> 
> This is Daniel's work, so I'm still hoping that he'll chime in
> shortly,

Yep, I'm in sick leave ATM, I broke my arm (without wordplay).

I took sometime to read the code, so from my POV we should keep the 
required property patch because the DT was defined that as required 
property. The conversion to yaml obviously spotted the DT not conforming 
with the bindings.

 From an implementation POV, that was not spotted initially because of 
the old OF code design IMO (but I'm not sure).

We can continue registering the thermal with no trip points but then 
still raise a message.

However, a thermal zone without trip point does not really make sense 
IMO. If I'm correct, the ACPI at least defines the critical temperature 
as a non optional object.

Did you consider using hwmon instead of a thermal zone ?

Below a patch (not tested): one hand writing is painful

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index ff4d12ef51bc..51f7dc5b8d18 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -481,8 +481,8 @@ struct thermal_zone_device 
*thermal_of_zone_register(struct device_node *sensor,
  	struct thermal_zone_params *tzp;
  	struct thermal_zone_device_ops *of_ops;
  	struct device_node *np;
-	int delay, pdelay;
-	int ntrips, mask;
+	int delay = 0, pdelay = 0;
+	int ntrips = 0, mask = 0;
  	int ret;

  	of_ops = kmemdup(ops, sizeof(*ops), GFP_KERNEL);
@@ -500,8 +500,8 @@ struct thermal_zone_device 
*thermal_of_zone_register(struct device_node *sensor,
  	trips = thermal_of_trips_init(np, &ntrips);
  	if (IS_ERR(trips)) {
  		pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
-		ret = PTR_ERR(trips);
-		goto out_kfree_of_ops;
+		trips = NULL;
+		goto out_register;
  	}

  	ret = thermal_of_monitor_init(np, &delay, &pdelay);
@@ -522,6 +522,7 @@ struct thermal_zone_device 
*thermal_of_zone_register(struct device_node *sensor,

  	mask = GENMASK_ULL((ntrips) - 1, 0);

+out_register:
  	tz = thermal_zone_device_register_with_trips(np->name, trips, ntrips,
  						     mask, data, of_ops, tzp,
  						     pdelay, delay);




