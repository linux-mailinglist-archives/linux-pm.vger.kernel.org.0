Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E217A5A111D
	for <lists+linux-pm@lfdr.de>; Thu, 25 Aug 2022 14:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiHYMyM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Aug 2022 08:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237099AbiHYMyL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Aug 2022 08:54:11 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE2C58080;
        Thu, 25 Aug 2022 05:54:10 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bt10so15131197lfb.1;
        Thu, 25 Aug 2022 05:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc;
        bh=jxnsfnBGG5VdB1lVE8fH5s5A95cPwiONxnAdHX4wr9E=;
        b=klwh1VXiA5wDmk/YAhXp+jeLzscceYd/KnNYYrIaoLUP/n4pB+7vjTNlVP87H84vtg
         omexKvtVBswab1oB7uhQlVWE68k12W1KTU6UfZa7gZdvHZF1uGq7S/vUQnF3kEIMW5O1
         NCr4/kn51J0eFpYYS6S6QY/BVwGt7LfHsuy2XcYbtnXbm1uZlLFjhFpbX9X4uQVUw4Zb
         OreVCVPUkr2d2z8xnkj0CEoXwKzkxfgDMFb1plzMTvKvRcihZpvnJLv0uleSvXgJ2FHt
         66SQA+Sd1ZEXoo5wOwVwD+dGBy82BvemWfw+4dINocqZhxXi1Y6KO3F+0CnNhsSfl+9R
         GKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=jxnsfnBGG5VdB1lVE8fH5s5A95cPwiONxnAdHX4wr9E=;
        b=hF9HmON0h+MtSWgJRqryduaUWGJszOFY6XW59Rivs94J5OFGSHh8P3lnO38PHiNPeF
         8G7reW+eTQaPQe7nH2jyrsQAAwVdR1AkiF2qmvs4iTF4zcpsLogGE5rUNP/oahpl/J0H
         JoXEWWQUzLedH8ap1TqX73l21Jydqv24AXhGvGzdyuJSpLzbZmcOAOtpjwmQk4mDgzUe
         S8H1R3mSfW4T0uRyE3FwC5h9N2spLHk427nxKP0vtRiPs4cCRSEVvho1YjfGwr7/xFo5
         yuX72iNZaSQ8G9wykqzen8ALreXaWGL9v4Y17/iwiTEYdcnBGvTnlV83KjrkKZ4xdjt7
         wFtw==
X-Gm-Message-State: ACgBeo0nyYI6wEkiet4QPsUk4CHjrCoXHLAfUtjbCFm+qzqwZGLsGHRP
        y6bRStb73wB2QmsvN5sU+2yTk7ljDG0QkA==
X-Google-Smtp-Source: AA6agR66kK7+dDe6VMrnf/smOFnmyCX9KsjAqm/QN0PsFuXucy+qetKfTjxkAsbjQFftWAmWKT7PaA==
X-Received: by 2002:a05:6512:c11:b0:492:f0b1:1628 with SMTP id z17-20020a0565120c1100b00492f0b11628mr1052778lfu.682.1661432048414;
        Thu, 25 Aug 2022 05:54:08 -0700 (PDT)
Received: from [172.16.194.42] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id x10-20020a056512078a00b0048a757d1303sm477008lfr.217.2022.08.25.05.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 05:54:07 -0700 (PDT)
Message-ID: <66b99ce4-752a-17e7-3213-26a898abd4a8@gmail.com>
Date:   Thu, 25 Aug 2022 15:54:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Chris Morgan <macroalpha82@gmail.com>,
        linux-rockchip@lists.infradead.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        zhangqing@rock-chips.com, zyw@rock-chips.com,
        jon.lin@rock-chips.com, maccraft123mc@gmail.com, sre@kernel.org,
        heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, lee@kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
References: <20220823193015.10229-1-macroalpha82@gmail.com>
 <20220823193015.10229-4-macroalpha82@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH V9 3/4] power: supply: Add charger driver for Rockchip
 RK817
In-Reply-To: <20220823193015.10229-4-macroalpha82@gmail.com>
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

On 8/23/22 22:30, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add support for the Rockchip rk817 battery charger integrated into the
> rk817 PMIC.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> ---
>   drivers/power/supply/Kconfig         |    6 +
>   drivers/power/supply/Makefile        |    1 +
>   drivers/power/supply/rk817_charger.c | 1157 ++++++++++++++++++++++++++
>   3 files changed, 1164 insertions(+)
>   create mode 100644 drivers/power/supply/rk817_charger.c
> 
> +
> +static void rk817_charging_monitor(struct work_struct *work)
> +{
> +	struct rk817_charger *charger;
> +
> +	charger = container_of(work, struct rk817_charger, work.work);
> +
> +	rk817_read_props(charger);
> +
> +	/* Run every 8 seconds like the BSP driver did. */
> +	queue_delayed_work(system_wq, &charger->work, msecs_to_jiffies(8000));
> +}

I really think we would benefit from some more framework code which 
could handle the periodic polling tasks and the coulomb counter drift 
corrections when battery is full/relaxed. I think I might revive the 
simple-gauge patch series...

> +
> +static int rk817_charger_probe(struct platform_device *pdev)
> +{
> +
> +	charger->sleep_filter_current_ua = of_value;
> +
> +	charger->bat_ps = devm_power_supply_register(&pdev->dev,
> +						     &rk817_bat_desc, &pscfg);
> +
> +	charger->chg_ps = devm_power_supply_register(&pdev->dev,
> +						     &rk817_chg_desc, &pscfg);

Hmm. I think I should respin the patch which added interface for getting 
the battery info w/o psy-device. Now we need to take into account the 
situation where the psy-core accesses the driver after the registration 
- and prior filling the battery details from the battery node (below) :/

> +
> +	if (IS_ERR(charger->chg_ps))
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Battery failed to probe\n");
> +
> +	if (IS_ERR(charger->chg_ps))
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Charger failed to probe\n");
> +
> +	ret = power_supply_get_battery_info(charger->bat_ps,
> +					    &bat_info);
> +	if (ret) {
> +		return dev_err_probe(dev, ret,
> +				     "Unable to get battery info: %d\n", ret);
> +	} > +
> +	if ((!bat_info->charge_full_design_uah) ||
> +	    (!bat_info->voltage_min_design_uv) ||
> +	    (!bat_info->voltage_max_design_uv) ||
> +	    (!bat_info->constant_charge_voltage_max_uv) ||
> +	    (!bat_info->constant_charge_current_max_ua) ||
> +	    (!bat_info->charge_term_current_ua)) {
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Required battery info missing.\n");
> +	}

Just a question - should the values be compared to -EINVAL (I think the 
power_supply_get_battery_info() did internally initialize many of the 
fields to -EINVAL and not to 0?). Maybe I am wrong...

> +
> +	charger->bat_charge_full_design_uah = bat_info->charge_full_design_uah;
> +	charger->bat_voltage_min_design_uv = bat_info->voltage_min_design_uv;
> +	charger->bat_voltage_max_design_uv = bat_info->voltage_max_design_uv;
> +

Generally, I did _really_ like the proper commenting/documenting of the 
driver. In my eyes this looked like one nice piece of a driver.

When the error checking of values returned by the 
power_supply_get_battery_info() is checked - FWIW:
Reviewed-By: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

Yours
   -- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
