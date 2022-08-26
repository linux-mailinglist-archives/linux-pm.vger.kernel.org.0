Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E645A207D
	for <lists+linux-pm@lfdr.de>; Fri, 26 Aug 2022 07:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbiHZFwv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Aug 2022 01:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiHZFwu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Aug 2022 01:52:50 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A40D0740;
        Thu, 25 Aug 2022 22:52:49 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id u24so638190lji.0;
        Thu, 25 Aug 2022 22:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc;
        bh=soNzPJc803GCe9GPBXw1nVU+W5AOpKPxh4/jGQ+1Ri8=;
        b=jTICFnG1dYKljHYsdyc856tvd+Ge1GvvnYz4Tp5//fEZip0XL88j2yTLuIwAE0kHpd
         HW5L6yJUp/7UX9bXenyFS4b/IOUl3VwWo+hBDBDcZEQQz/boBFzSzjmFvdWv+bm8Wrdq
         +7nKqfHawVhQ+ufUDxR5m/FS+gSIrMmOn1M7fph7JaVNzfxlanzCCkYxjveAiobqYo19
         mQ4ER441ttgVBBz9NoDOG8C1rRhU+UXY867kMDLTQuzZkxohjY8ufgb74Ui6lIMVBS+h
         TzQps8jtcSQGRnjiP7tM+2vZSm6X5CYZ6Ttxk5L7Tj6ZtWfTiC0i6M0byOBL7ZArf3nl
         gHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=soNzPJc803GCe9GPBXw1nVU+W5AOpKPxh4/jGQ+1Ri8=;
        b=c13xTyZAo/ps7BayU9oaZHKg/ri2ZuMsYrgAxI81I6Mw0CrmNff21+nGHXUIOYd88m
         w2x6/NNK2SabD+pLSRFt4rIzz7B+xv23XuklEaifPEJbrCiG7LPx3KOGpw6PM1CoVdeM
         FA83gNschIe18xaf6gXcBN+icYGJa0M67+DfbJxdD3lBizWiYBaDnbln9SbaegkI/Zr7
         Ab4SbWGScDxmdAkVLjHmI7Itf/rJ8zioHN2n1B8Vx8nHlGhP90ecy3yx1YEPCoyh2Y4M
         4zV4LS6PHcogZ2HtBQ4QyoFIujJ37EGKu2lZGaL+UdTcJku/b1n6AfdlMxwaypQG/ZEp
         th2w==
X-Gm-Message-State: ACgBeo27fB02gTg8qZ1f+4vJT95uKikeI7dYfm1drtY1JX2rocOzBmmZ
        CCIEaRpoyeSAFb24SVXTzz0=
X-Google-Smtp-Source: AA6agR60rUAvS3oKB5t6Bt5rbUoNsgMHxC772aH1AM4iKzSYzRRRRePlzJ0QmVgC31yLw8djU7cwMA==
X-Received: by 2002:a05:651c:1587:b0:261:b558:b6ab with SMTP id h7-20020a05651c158700b00261b558b6abmr1814889ljq.204.1661493167189;
        Thu, 25 Aug 2022 22:52:47 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id k9-20020ac24f09000000b0048a9a756763sm250591lfr.19.2022.08.25.22.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 22:52:46 -0700 (PDT)
Message-ID: <6e905128-0dd1-d3a8-09ad-2645c3e12625@gmail.com>
Date:   Fri, 26 Aug 2022 08:52:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Chris Morgan <macromorgan@hotmail.com>
Cc:     Chris Morgan <macroalpha82@gmail.com>,
        linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, zhangqing@rock-chips.com,
        zyw@rock-chips.com, jon.lin@rock-chips.com,
        maccraft123mc@gmail.com, sre@kernel.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lee@kernel.org
References: <20220823193015.10229-1-macroalpha82@gmail.com>
 <20220823193015.10229-4-macroalpha82@gmail.com>
 <66b99ce4-752a-17e7-3213-26a898abd4a8@gmail.com>
 <SN6PR06MB5342ACD1362403FC9FE38627A5729@SN6PR06MB5342.namprd06.prod.outlook.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH V9 3/4] power: supply: Add charger driver for Rockchip
 RK817
In-Reply-To: <SN6PR06MB5342ACD1362403FC9FE38627A5729@SN6PR06MB5342.namprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/25/22 18:37, Chris Morgan wrote:
> On Thu, Aug 25, 2022 at 03:54:06PM +0300, Matti Vaittinen wrote:
>> On 8/23/22 22:30, Chris Morgan wrote:
>>> From: Chris Morgan <macromorgan@hotmail.com>
>>>
>>> Add support for the Rockchip rk817 battery charger integrated into the
>>> rk817 PMIC.
>>>
>>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
>>> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
>>> ---
>>>    drivers/power/supply/Kconfig         |    6 +
>>>    drivers/power/supply/Makefile        |    1 +
>>>    drivers/power/supply/rk817_charger.c | 1157 ++++++++++++++++++++++++++
>>>    3 files changed, 1164 insertions(+)
>>>    create mode 100644 drivers/power/supply/rk817_charger.c
>>>
>>> +
>>> +static void rk817_charging_monitor(struct work_struct *work)
>>> +{
>>> +	struct rk817_charger *charger;
>>> +
>>> +	charger = container_of(work, struct rk817_charger, work.work);
>>> +
>>> +	rk817_read_props(charger);
>>> +
>>> +	/* Run every 8 seconds like the BSP driver did. */
>>> +	queue_delayed_work(system_wq, &charger->work, msecs_to_jiffies(8000));
>>> +}
>>
>> I really think we would benefit from some more framework code which could
>> handle the periodic polling tasks and the coulomb counter drift corrections
>> when battery is full/relaxed. I think I might revive the simple-gauge patch
>> series...
> 
> Possibly, does such exist or is that a future endeavor?

No. Such a feature does not exist upstream. It was just some babbling I 
did here :) I started drafting something "generic" that would do polling 
of coulomb counter / battery state (full/relaxed) and then perform some 
'CC resetting' to correct drifitng error and compute the SOC based on CC 
values. That would obviously just be a machinery that calls driver 
callbacks. I did support for two ROHM chargers using this concept but I 
had to switch to some urgent tasks before I managed to do proper 
testing. Might get back to that later though (depending on the other 
duties).

> I'm only really
> doing the polling because that's how the BSP driver was set up (and I
> think it makes sense to not repeatedly check for teeny-tiny changes all
> the time). 

I am far from being and expert on the chargers so I can't say if this is 
the "de-facto" way of doing things. I just have a feeling this (this 
meaning periodic reading from HW and then returning the 'cached' values 
to user-space) is quite common (I may be wrong though, many others 
including Sebastian and Linus W have _much_ more insight into how 
chargers/charger drivers/user-space operate). Caching/polling sounds 
like a task that could be implemented in the framework code rather than 
in many individual drivers. (This comment does not mean I would expect 
You to write such a framework for this driver - as I said, I am just 
pondering aloud and waiting to see how others think of this :] )

> If there's an existing framework let me know, otherwise I'll
> keep my eye out in the future and revise this if I can when it's live.

So no existing framework and please, don't hold your breath waiting for 
one ;) It's still great to know that you can be pinged if I manage to 
cook-up something.

>>> +
>>> +static int rk817_charger_probe(struct platform_device *pdev)
>>> +{
>>> +
>>> +	charger->sleep_filter_current_ua = of_value;
>>> +
>>> +	charger->bat_ps = devm_power_supply_register(&pdev->dev,
>>> +						     &rk817_bat_desc, &pscfg);
>>> +
>>> +	charger->chg_ps = devm_power_supply_register(&pdev->dev,
>>> +						     &rk817_chg_desc, &pscfg);
>>
>> Hmm. I think I should respin the patch which added interface for getting the
>> battery info w/o psy-device. Now we need to take into account the situation
>> where the psy-core accesses the driver after the registration - and prior
>> filling the battery details from the battery node (below) :/
> 
> I used the AXP209 battery driver to help me fill in some of the gaps in
> my understanding, that driver gets the battery details after
> registration (ditto for the ingenic battery driver, which I also looked
> at.
> 

Sure. I think the current battery_info API requires a psy-device so 
registration needs to be done prior calling it. This was one of the 
things I changed while I was twiddling with the simple-gauge RFC series 
(which is not in-tree). So this was also not a request to change your 
driver but a generic note that it would be beneficial to decouple the 
battery-info API from psy-device.

>>
>>> +
>>> +	if (IS_ERR(charger->chg_ps))
>>> +		return dev_err_probe(dev, -EINVAL,
>>> +				     "Battery failed to probe\n");
>>> +
>>> +	if (IS_ERR(charger->chg_ps))
>>> +		return dev_err_probe(dev, -EINVAL,
>>> +				     "Charger failed to probe\n");
>>> +
>>> +	ret = power_supply_get_battery_info(charger->bat_ps,
>>> +					    &bat_info);
>>> +	if (ret) {
>>> +		return dev_err_probe(dev, ret,
>>> +				     "Unable to get battery info: %d\n", ret);
>>> +	} > +
>>> +	if ((!bat_info->charge_full_design_uah) ||
>>> +	    (!bat_info->voltage_min_design_uv) ||
>>> +	    (!bat_info->voltage_max_design_uv) ||
>>> +	    (!bat_info->constant_charge_voltage_max_uv) ||
>>> +	    (!bat_info->constant_charge_current_max_ua) ||
>>> +	    (!bat_info->charge_term_current_ua)) {
>>> +		return dev_err_probe(dev, -EINVAL,
>>> +				     "Required battery info missing.\n");
>>> +	}
>>
>> Just a question - should the values be compared to -EINVAL (I think the
>> power_supply_get_battery_info() did internally initialize many of the fields
>> to -EINVAL and not to 0?). Maybe I am wrong...
> 
> No, you're not wrong. The power_supply_get_battery_info does set the
> values to -EINVAL, but it also then sets them based on the devicetree
> without checking the return values.

You might want to check whether the device-tree APIs update the value if 
property is not found - or if some error occurs. AFAIR they do not.

> I'm not entirely clear if in the
> event of an error it could set it to another value though or null,
> so do you think performing a check to see if the value is less than or
> equal to 0 would be sufficient?

I'd say this depends on the property. Some properties may have valid 
negative values but I guess you know what to expect. In any case, I 
assume that the value being non-zero does not guarantee it is valid so 
the check should probably be improved.

> 
>>
>>> +
>>> +	charger->bat_charge_full_design_uah = bat_info->charge_full_design_uah;
>>> +	charger->bat_voltage_min_design_uv = bat_info->voltage_min_design_uv;
>>> +	charger->bat_voltage_max_design_uv = bat_info->voltage_max_design_uv;
>>> +
>>
>> Generally, I did _really_ like the proper commenting/documenting of the
>> driver. In my eyes this looked like one nice piece of a driver.
> 
> It's confusing as hell (my first battery driver, so the comments
> hopefully help everyone else as much as they helped me).

I think the fuel-gauging can be complex topic. Hence comments help a 
lot. I do definitely like the comments in charger / fuel gauge drivers.

> There was
> also a bunch of weird errata like resetting the max charge current
> when the plug-in IRQ fires that I felt needed to be documented.

Yes.

> 
> Thanks for looking at this, I value your input and will make the
> changes once you let me know about the -EINVAL check.

The v9 was caught by my mail-filters :D Probably due to addition of the 
autocancel work-queue. It was actually good for me to be pinged by 
power-supply patches as I might find some time to continue fuel-gauge 
work during the autumn/winter.

-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
