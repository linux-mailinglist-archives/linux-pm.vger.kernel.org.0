Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B957700DC9
	for <lists+linux-pm@lfdr.de>; Fri, 12 May 2023 19:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237312AbjELRWo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 May 2023 13:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237182AbjELRWn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 May 2023 13:22:43 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FD761AE
        for <linux-pm@vger.kernel.org>; Fri, 12 May 2023 10:22:41 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f423521b10so47809885e9.0
        for <linux-pm@vger.kernel.org>; Fri, 12 May 2023 10:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683912160; x=1686504160;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9UKhgFOsFOUm1i3OTVWLnAknbppUMdId4xzOBuxqB5g=;
        b=NsrIrh96sAJgzY3qNhe7YkUp9L64mLBlPEM+5iW8LDzk9I39y31DPewD3xCHMMaJQ2
         +YRAzGYFvh8cp6htC5NuIFlUear8IskmNx3hzXPDck6YDKpJbuyAUZ+55VRN1GVA9vcZ
         XzE3njXU2pJ+dQZ0354V9e1SvJEulycfaQQIJRW+TjlzkNseyXaj32NENUVT7gYYPR2X
         oBAQ2TVqgKo2QxMKIUzqZmvTQDL0bFDuVALPVYnj3YmXtoLstReyK58oAWWIWukdKWiW
         amIR1A03HrlUJA13claHV42EVuyQZTFrtuGB8GGqtzn/DoDviaIS8goShNVqNbZX2+Ez
         h8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683912160; x=1686504160;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9UKhgFOsFOUm1i3OTVWLnAknbppUMdId4xzOBuxqB5g=;
        b=GxDljQqlHQw8kQLyNhVM+wErkKqOGRVErAjF0Fhjt0veTgUej2wqXJw7U/XmY9tDFL
         xMPVlkqDzvchHIUu01tebGRSZZpEL81wQW1yS096CNdOjXiu49RpHxR1LsZCKyhCBD/b
         +15S/4Kcmi5lfxZ8OCijS2t+HM0Hm3GJuI6lxRDdk4fGrvonYvc4be4C07YIZUlivaWT
         TqBD0QJtMilMYt+BfjV912ltYQ8BqUdygaQOuBMg5QrwoUEuMAN4khn7MD+uyNoRyrfP
         eVh6BbxIALNRq/ZWQimXzZo5PwRDoxIEHUVTDtidnYBSiaYyXoIhAbp/BBPYyOpsKnlD
         V5mQ==
X-Gm-Message-State: AC+VfDxxyOeMKqMzrviUJaYaYXQmsMQtPSs5cJKHC7ifvfFGRPLD9dtg
        TI996FO+RUOzO1aw+cEEeIphbR5xbsU6aqJHRTc=
X-Google-Smtp-Source: ACHHUZ5s1/DQ3DjzrYlm5BwHrIhd9/mPvWxYqMo2RuhRNAGUtGs21KLLHUD50TpSIaoEUqJUZLveSQ==
X-Received: by 2002:a7b:c8d9:0:b0:3f4:2174:b284 with SMTP id f25-20020a7bc8d9000000b003f42174b284mr13833496wml.28.1683912159779;
        Fri, 12 May 2023 10:22:39 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:5efd:dba0:e7fa:b5bf? ([2a05:6e02:1041:c10:5efd:dba0:e7fa:b5bf])
        by smtp.googlemail.com with ESMTPSA id 10-20020a05600c024a00b003f423dfc686sm16512777wmj.45.2023.05.12.10.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 10:22:39 -0700 (PDT)
Message-ID: <b1237581-3ece-a358-f1ba-7a3ebb08d8d2@linaro.org>
Date:   Fri, 12 May 2023 19:22:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: power_supply cooling interface
Content-Language: en-US
To:     Pavel Machek <pavel@ucw.cz>,
        Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <164f2458-fb66-f238-7143-bdbe1e200870@linaro.org>
 <ZF5t5BWqLLEvDdfz@localhost>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <ZF5t5BWqLLEvDdfz@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/05/2023 18:48, Pavel Machek wrote:
> Hi!
> 
>> I've been working on a driver for the charger found in most Snapdragon
>> 845 phones (the OnePlus 6, SHIFT6mq, PocoPhone F1, etc). I wanted to
>> include support for the POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT
>> property.
>>
>> My understanding is that it exposes the current limit as a cooling
>> device so that userspace (or frameworks like DTPM) can optimise for
>> performance in a thermally constrained device by limiting the input
>> current and thus reducing the heat generated by the charger circuitry,
>> a similar idea was applied on the Pixel C:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a4496d52b3430cb3c4c16d03cdd5f4ee97ad1241
>>
>> However, reading through the sysfs docs for cooling devices, and
>> looking at the implementation in power_supply_core.c, it seems like the
>> behavior here is wrong in a few ways:
>>   1. The values should scale from 0: no cooling to max_state: max
>> cooling, but the power_supply docs and the only existing implementation
>> (the smbb driver) just export the current_limit, such that increasing
>> cur_state would increase the current limit, not decrease it.
>>   2. (unsure?)The scale is completely different to most other cooling
>> devices, most cooling devices don't seem to have a max state much
>> beyond the double digits, but CHARGE_CONTROL_LIMIT is on the scale of
>> uA, so approaches like incrementing the cooling state by 1 don't really
>> work.
> 
> Did this get solved somehow?

Thanks for resurrecting the discussion.

> Anyway, I am not sure mW will be useful here, as elsewhere it is mW
> thermal and here it is mW from charger. Most of that energy should be
> stored in battery, not converted to heat.

I'm not sure to understand the comment. The question is about decreasing 
the speed of the charge of the battery because the faster it charges the 
warmer it gets. Doing a fast charge is ok, if the phone is for instance 
on a table doing nothing. But if the environment is hot (a car, a 
pocket) or there are other sources of heat on the phone like a game, the 
temperature of the battery could be too high (or the skin temperature). 
In this case we have to balance the heat contribution of the different 
components by reducing their performances. The first knob to act on is 
to reduce the charge speed of the battery by reducing the delivered power.

For that we need a connection between the thermal framework which 
monitors the battery temperature and the power supply to reduce the 
charge speed when it is too hot. This connection is the cooling device.

The cooling devices have opaque values where the min and max cooling 
effect vary depending on the implementation (eg. a fan 0/1, a LCD light 
0/1023).

Here the power supply has yet another unit (uA) to act on and difficult 
to translate to a cooling device discrete numbers (that is my 
understanding).

My suggestion is adding to the power supply the power capping capability 
using the powercap framework and add it to the DTPM nomenclature.

With enough components in DTPM, it will be possible to create a generic 
power cooling device using the unified unit uW with the powercap API.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

