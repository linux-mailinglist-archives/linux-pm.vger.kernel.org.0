Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C7356867E
	for <lists+linux-pm@lfdr.de>; Wed,  6 Jul 2022 13:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbiGFLNt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Jul 2022 07:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbiGFLNs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jul 2022 07:13:48 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE39527CFA
        for <linux-pm@vger.kernel.org>; Wed,  6 Jul 2022 04:13:47 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d16so15247567wrv.10
        for <linux-pm@vger.kernel.org>; Wed, 06 Jul 2022 04:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hxajPjZjIIJo4Uw5JtvbzfkD5YwE8zFfsd2Za5sspF8=;
        b=wGRsgClpjHUfBd208DANmZuE+CScB4xVvQpKhG7Ci7o0PR663OotMa16WuZiMgVyq/
         hwSBDr1Y5tNEg86svtzs7tvCXHk+izl8tIC72tTdkjOCK55UpzaZLr6RUX9rHVkBgNQx
         N3Oyf9iVVOYhuyCCRREKOcnnYie+ff1jB/GqFvPFufknFTZjiLjFQTo/jYkD1HtIa17K
         s6s7gMCs4btjAgsj9pvIYw2H841SPADZsoqT17UK1lhedQ7v2/GSPtnH6kqjzZobydpp
         Zzx0rC6GC7DGai1lKSMHx8ZyLiA87w7CDC3ET036cnbFVl/DdcMmPxeQUgoYKcoQtGHe
         t88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hxajPjZjIIJo4Uw5JtvbzfkD5YwE8zFfsd2Za5sspF8=;
        b=LPSJYwYvwq+982EUGBAg6LcmgWtAObm/sDycl0rZ6zuSYQeGd2VLhLlzwEVjVWPY90
         KtI4tByNxzwDMSnEr8+IOzjkCobVDxvNO7GoHFOPH/rM0slzE4Ptv7IdERAeJsmxI6jx
         VU+kkN3xfYXPgmJe/a3igyPsVT5G5Dppj7qWqb9J5yyMshNdJVwY7CIzV1Q6e1HudrOY
         453osABo04bYkC5jcqvlguTQR31L7C/bfaQN+s2YYk7t5LPpQUzR9yjhzJSAcPyHTgSg
         YidlnDwfe86oQ2/IGJ0FgOGoxBloa27laZYfwfwt1FhAkdMlQNH2fxayvgz4NbvOuEGH
         hv5A==
X-Gm-Message-State: AJIora8LwkCKp2Qts/nLHWLWeHgcWD6wY4j20m7cyeJYKIPYfP2pVPSL
        98hMZEEljXSBA301mB6NZ6id3A==
X-Google-Smtp-Source: AGRyM1tRfASnXiQBIRBnvAskiX+ntjbs9MqsDP8H55AKWzrB2UaraDmSlvlqsfRcqUrl5S073OOUfg==
X-Received: by 2002:a05:6000:10a:b0:21d:6c43:d2b with SMTP id o10-20020a056000010a00b0021d6c430d2bmr13889813wrx.46.1657106026292;
        Wed, 06 Jul 2022 04:13:46 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id g34-20020a05600c4ca200b0039c7dbafa7asm19848465wmp.19.2022.07.06.04.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 04:13:45 -0700 (PDT)
Message-ID: <40b2b8d1-f86c-4788-767c-22e60283e458@linaro.org>
Date:   Wed, 6 Jul 2022 13:13:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/2] thermal: rcar_gen3_thermal: Add support for
 hardware trip points
Content-Language: en-US
To:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-pm@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org
References: <20210804091818.2196806-1-niklas.soderlund+renesas@ragnatech.se>
 <20210804091818.2196806-2-niklas.soderlund+renesas@ragnatech.se>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20210804091818.2196806-2-niklas.soderlund+renesas@ragnatech.se>
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


On 04/08/2021 11:18, Niklas Söderlund wrote:
> All supported hardware except V3U is capable of generating interrupts
> to the CPU when the temperature go below or above a set value. Use this
> to implement support for the set_trip() feature of the thermal core on
> supported hardware.
> 
> The V3U have its interrupts routed to the ECM module and therefore can
> not be used to implement set_trip() as the driver can't be made aware of
> when the interrupt triggers.
> 
> Each TSC is capable of tracking up-to three different temperatures while
> only two are needed to implement the tracking of the thermal window.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> ---
> * Changes since v1
> - Remove the 'have_irq' flag from the OF match data and auto-detect if
>    interrupts are available using platform_get_irq_optional().
> - Have a non-static thermal_zone_of_device_ops and clear the .set_trips
>    if interrupts are unavailable.
> ---

[ ... ]

> @@ -401,8 +492,12 @@ static int __maybe_unused rcar_gen3_thermal_resume(struct device *dev)
>   
>   	for (i = 0; i < priv->num_tscs; i++) {
>   		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
> +		struct thermal_zone_device *zone = tsc->zone;
>   
>   		priv->thermal_init(tsc);
> +		if (zone->ops->set_trips)
> +			rcar_gen3_thermal_set_trips(tsc, zone->prev_low_trip,
> +						    zone->prev_high_trip);
>   	}

While doing a cleanup I lately noticed this change and I've concerns 
about it:

  - it uses the thermal zone internals

  - is it really needed ?

At resume time we have:

thermal_pm_notify()
   --> PM_POST_RESTORE
     --> thermal_zone_device_update()
       --> thermal_zone_set_trips()

In addition, I believe this later call is consistent as it sets the trip 
point based on the last temperature update, while the 
rcar_gen3_thermal_resume() does not.

Was this function added on purpose because some there is an issue when 
resuming the board or just put there assuming it is doing the right thing ?

I would be happy if we can remove this portion of code because it is the 
only users of prev_*_trip I would like to replace by prev_trip id.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
