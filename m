Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E089C569EEB
	for <lists+linux-pm@lfdr.de>; Thu,  7 Jul 2022 11:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbiGGJ4B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Jul 2022 05:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiGGJz7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jul 2022 05:55:59 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD0E186E7
        for <linux-pm@vger.kernel.org>; Thu,  7 Jul 2022 02:55:58 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a5so10850286wrx.12
        for <linux-pm@vger.kernel.org>; Thu, 07 Jul 2022 02:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PdHmBoaTnbvwszukklgM1rwSJtbJC9ovrHsF6ELtpy0=;
        b=Qz3JtbQET6tdYqy6ZiCQpSPCH3h3AhGpRojbmf1ehmUKyyDf4z1VuEQxPpy0ChXRDZ
         8sRvOwZjQ1gl/WlWfKIEN3AHKcaCUCd+jJ821w44HSq9rxNvpX7wBAZ4+XqzNOil52KX
         RAP7miEwSayclz/BfS6qMXE4+cPKUD+oI/WNQCdth+h51jMBw9X4hntpMgd39xd3Fyil
         6IqNNYH7GFG4dYtVBuSyZUr+4Ee3nuJwYEXaXShpQIH/+fzMRg4wEgoH/KP8VrDosEUo
         vtErsinKBGMdg6b4xPYPwvm6q4AIrqVjnXHebf+1PiTxSPGxGP+ceXWMlFHb/0/I0qEe
         XaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PdHmBoaTnbvwszukklgM1rwSJtbJC9ovrHsF6ELtpy0=;
        b=r5onD+Sv/VsyY3jC0eYsVIyA+IobsqDch+kWI6BcPAoGoMvsGRSlvkt2y6CTLREmTP
         7UizRoPGBWzTUXk7SDrMPYZsMYHhaXc0uHxMy6ABvpp+50nJDy2xzgWeiDHc8blaAXER
         egQkDlX4YrdvG0wUbsi8D6Ojl/J/MTgGqRy3OvLU9hoaVAWbX1Xa08tE4G/XwcgMCSzA
         VDua1xTLyznUX1voLrr3IBDsWypxDAOtzUjEyC8CzuEnPgNsFVAE4ofGl88so8LXUVg6
         cey/KEpw5DrUJ6ej+N+h6r2dOi9pXyC3OkdTtDC72KRrQ1H4bfKpeGerb/xxN6NWuzxw
         EOSg==
X-Gm-Message-State: AJIora+bLXea+IqNnTL9eRwWU/eVU3UdnpXs8SkZ8D3CP/QwLXBwenbe
        B7USbOGHNvhrSP5KKLXwqn3L4w==
X-Google-Smtp-Source: AGRyM1thXqvUYudCwo6be1Kb6zddnDHVOcmUm5cxc5X0jWe28PKuqHXQgArbNLi3D8IH+/63B+kkmA==
X-Received: by 2002:a5d:47a4:0:b0:21d:859c:4bd9 with SMTP id 4-20020a5d47a4000000b0021d859c4bd9mr2561459wrb.681.1657187756879;
        Thu, 07 Jul 2022 02:55:56 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id l34-20020a05600c1d2200b003a03e63e428sm31917786wms.36.2022.07.07.02.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 02:55:56 -0700 (PDT)
Message-ID: <2605a591-abf9-01ca-015c-efc3978803b8@linaro.org>
Date:   Thu, 7 Jul 2022 11:55:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/2] thermal: rcar_gen3_thermal: Add support for
 hardware trip points
Content-Language: en-US
To:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20210804091818.2196806-1-niklas.soderlund+renesas@ragnatech.se>
 <20210804091818.2196806-2-niklas.soderlund+renesas@ragnatech.se>
 <40b2b8d1-f86c-4788-767c-22e60283e458@linaro.org>
 <YsasmbJotSd/aIu/@oden.dyn.berto.se>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <YsasmbJotSd/aIu/@oden.dyn.berto.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Niklas,


On 07/07/2022 11:51, Niklas Söderlund wrote:
> Hi Daniel,
> 
> On 2022-07-06 13:13:44 +0200, Daniel Lezcano wrote:
>>
>> Hi Niklas,
>>
>>
>> On 04/08/2021 11:18, Niklas Söderlund wrote:
>>> All supported hardware except V3U is capable of generating interrupts
>>> to the CPU when the temperature go below or above a set value. Use this
>>> to implement support for the set_trip() feature of the thermal core on
>>> supported hardware.
>>>
>>> The V3U have its interrupts routed to the ECM module and therefore can
>>> not be used to implement set_trip() as the driver can't be made aware of
>>> when the interrupt triggers.
>>>
>>> Each TSC is capable of tracking up-to three different temperatures while
>>> only two are needed to implement the tracking of the thermal window.
>>>
>>> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
>>> ---
>>> * Changes since v1
>>> - Remove the 'have_irq' flag from the OF match data and auto-detect if
>>>     interrupts are available using platform_get_irq_optional().
>>> - Have a non-static thermal_zone_of_device_ops and clear the .set_trips
>>>     if interrupts are unavailable.
>>> ---
>>
>> [ ... ]
>>
>>> @@ -401,8 +492,12 @@ static int __maybe_unused rcar_gen3_thermal_resume(struct device *dev)
>>>    	for (i = 0; i < priv->num_tscs; i++) {
>>>    		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
>>> +		struct thermal_zone_device *zone = tsc->zone;
>>>    		priv->thermal_init(tsc);
>>> +		if (zone->ops->set_trips)
>>> +			rcar_gen3_thermal_set_trips(tsc, zone->prev_low_trip,
>>> +						    zone->prev_high_trip);
>>>    	}
>>
>> While doing a cleanup I lately noticed this change and I've concerns about
>> it:
>>
>>   - it uses the thermal zone internals
>>
>>   - is it really needed ?
>>
>> At resume time we have:
>>
>> thermal_pm_notify()
>>    --> PM_POST_RESTORE
>>      --> thermal_zone_device_update()
>>        --> thermal_zone_set_trips()
>>
>> In addition, I believe this later call is consistent as it sets the trip
>> point based on the last temperature update, while the
>> rcar_gen3_thermal_resume() does not.
>>
>> Was this function added on purpose because some there is an issue when
>> resuming the board or just put there assuming it is doing the right thing ?
>>
>> I would be happy if we can remove this portion of code because it is the
>> only users of prev_*_trip I would like to replace by prev_trip id.
> 
> 
> This looks like something that should never have been submitted
> upstream. The usage for this was to restore the trip points in the
> hardware registers *after* the hardware have been initialized. However
> as far as I can tell from the code this is already done by the thermal
> core so no need for the driver to deal with this.
> 
> I did a test on a Gen3 board (M3-N) with this code removed and the core
> appears to do the right thing so this code in the driver can be removed.
> Will you write up a patch as part of your cleanup work or would you
> prefer I do it?

Thanks for double checking and confirming. I've a patch removing this 
code, no need to send one. I'll submit it along with other changes 
around this. Perhaps, I'll try a revert before, it would make more sense.

Do you think the 'revert' should be backported ?

   -- Daniel



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
