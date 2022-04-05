Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCB14F489D
	for <lists+linux-pm@lfdr.de>; Wed,  6 Apr 2022 02:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbiDEVnN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Apr 2022 17:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443826AbiDEPkU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Apr 2022 11:40:20 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE65CBB928
        for <linux-pm@vger.kernel.org>; Tue,  5 Apr 2022 07:00:12 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id c42so7581015edf.3
        for <linux-pm@vger.kernel.org>; Tue, 05 Apr 2022 07:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yssQkD7Do9xm8UR+YlTAdHUKXFIsMM4DyfogZGeGdwI=;
        b=ZkxMexE503Eff9aL8DCM5qBZDdllnLfsgdU8bEgtKsMA0FNvX8+exKDt8wSqv7O0cP
         qeWqstaDcKx9wgdTMOAtcq7iCVGOSXuDbSasBuerncoIzc6tbJ1Gyd8vmiRuURoqmPWz
         hROPZJYXqWEEblhiinEuLB0D0uGaZgdsuy88r1t/j7MEMBsMGYPNuCgrLozjilFWQ9gT
         wk1iv+EW18vEyz+Os1sxl3Qsnl8RIy61YU/zd3dUlQ7UxHwOtNxlywQE1T4TV5FMMdKt
         4SHQKSHmgPeG/b6l2oC+7WDAlzIHC0FNdlOgsa7JCUNVxz0s6uWX3CLd/FuT/wfTh/aC
         4IAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yssQkD7Do9xm8UR+YlTAdHUKXFIsMM4DyfogZGeGdwI=;
        b=GeGs3T0JwGfeOshD8ZOIvAw2sPEvwx3q462IFPsxt0WcLDXsToogayVG6bp8Ej5B/u
         vmyN3QzI4FKwnN35aQsUVK0IDxUvg2hBxRw+Xtsx3ytOr7WmUY+X1gmkcj4k0Hb+4RgL
         aGAv7SbbwwByja/cd74vW/M6ynD1C10jBgpMEWK1uNQ8bubkHmmxbsXiP+95FbV575z4
         nlRfcVptAKfCmThcV0l46cxGGn7tZ+sJsuYAuo/4in3KZQIG0TOE5HyK1/7so0ntI9xD
         5ZMPhf7P+ZTcxmXMeUw2VfstnoDxSWo2Rdy1pTgL8R71u8mTI+Y/2glaZ7QLbNoZdjrD
         Hesg==
X-Gm-Message-State: AOAM531fPm2EvZa0Yw/yKT8auDPBsapVvJlI03eRET9Tv248UODqu6G2
        7jwCFdrKI2tMRDPrdpqueFA6Ew==
X-Google-Smtp-Source: ABdhPJz1bWR2hBZu8gqH0382mWzhtYAnndbapb86xJpCSXunZFL73rVdqd6pzmIP0a/dTleS03+msQ==
X-Received: by 2002:a05:6402:5243:b0:419:4ce2:cb5c with SMTP id t3-20020a056402524300b004194ce2cb5cmr3773653edd.151.1649167211320;
        Tue, 05 Apr 2022 07:00:11 -0700 (PDT)
Received: from [192.168.0.182] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id n5-20020a1709065e0500b006e4dae9b1besm5150568eju.145.2022.04.05.07.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 07:00:10 -0700 (PDT)
Message-ID: <b269be83-3e45-fb36-75ab-e1c20ad6906f@linaro.org>
Date:   Tue, 5 Apr 2022 16:00:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/4 v5] dt-bindings: Add Rockchip rk817 battery charger
 support
Content-Language: en-US
To:     Chris Morgan <macroalpha82@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, zhangqing@rock-chips.com,
        zyw@rock-chips.com, jon.lin@rock-chips.com,
        maccraft123mc@gmail.com, sre@kernel.org, heiko@sntech.de,
        krzk+dt@kernel.org, robh+dt@kernel.org, lee.jones@linaro.org,
        Chris Morgan <macromorgan@hotmail.com>
References: <20220404215754.30126-1-macroalpha82@gmail.com>
 <20220404215754.30126-2-macroalpha82@gmail.com>
 <74f445c2-3194-80a6-6d52-21368eb6172a@linaro.org>
 <20220405131228.GA20@wintermute.localdomain>
 <ac2b29c2-b3ec-eb03-595f-b0328e40015c@linaro.org>
 <20220405135424.GA20@wintermute.localdomain>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220405135424.GA20@wintermute.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05/04/2022 15:54, Chris Morgan wrote:
> On Tue, Apr 05, 2022 at 03:35:04PM +0200, Krzysztof Kozlowski wrote:
>> On 05/04/2022 15:12, Chris Morgan wrote:
>>> On Tue, Apr 05, 2022 at 01:16:55PM +0200, Krzysztof Kozlowski wrote:
>>>> On 04/04/2022 23:57, Chris Morgan wrote:
>>>>> From: Chris Morgan <macromorgan@hotmail.com>
>>>>>
>>>>> Create dt-binding documentation to document rk817 battery and charger
>>>>> usage. New device-tree properties have been added.
>>>>>
>>>>> - rockchip,resistor-sense-micro-ohms: The value in microohms of the
>>>>>                                       sample resistor.
>>>>> - rockchip,sleep-enter-current-microamp: The value in microamps of the
>>>>>                                          sleep enter current.
>>>>> - rockchip,sleep-filter-current: The value in microamps of the sleep
>>>>>                                  filter current.
>>>>>
>>>>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
>>>>> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
>>>>> ---
>>>>>  .../bindings/mfd/rockchip,rk817.yaml          | 48 +++++++++++++++++++
>>>>>  1 file changed, 48 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
>>>>> index bfc1720adc43..b949d406a487 100644
>>>>> --- a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
>>>>> +++ b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
>>>>> @@ -117,6 +117,47 @@ properties:
>>>>>          description:
>>>>>            Describes if the microphone uses differential mode.
>>>>>  
>>>>> +  battery:
>>>>
>>>> I wonder why do you call it a batter while it is a charger, isn't it?
>>>
>>> It is a driver for both the battery and charger. I'd argue about 95% of
>>> it is battery functions and the other 5% is managing the IRQs for plug
>>> removal/insertion and capturing the incoming voltage and current. In
>>> the BSP kernel these were two seperate drivers, but there was so little
>>> that needed to be done for the charger (and users probably don't need
>>> plug IRQs if they aren't using a battery anyway since the system will
>>> shut off on a plug out event due to no power...).
>>
>> What do you mean by driver for "battery"? Like some smart-battery
>> system? with embedded battery (RK817 comes with embedded battery) Or a
>> fuel gauge? Judging by power supply properties it looks like fuel gauge.
> 
> It's basically just additional registers in the rk817 PMIC. The PMIC is
> controlled via I2C and contains multiple regulators, an audio codec,
> an RTC, some GPIO, some nvram, a columb counter for the battery, and an
> ADC for measuring input current/voltage/temperature (for battery or
> charger). 

Actually you mentioned it in the cover letter - it's a PMIC, not a
battery. I doubt that it's embedded with a battery. :)

> This driver deals with the columb counter, the ADC, and a few
> bits of nvram for storing battery values to retain backwards
> compatibility with the BSP kernel and bootloader, and handling IRQs
> related to inserting or removing the charger (curiously my
> implementation ALSO has a charger sense GPIO in addition to the PMIC
> being able to sense that).
> 
> The driver itself is named rk817_charger. If you think I should change
> this from battery to "fuel gauge" or "charger" let me know and I can
> resubmit. Whatever makes it clearer for everyone.

Yeah, the property name and bindings should describe the hardware, so in
such case the hardware is rather a "charger" or "fuel-gauge". Your
"battery-cell" from DTS is probably just a "battery" (unless you expect
multiple cells?).

Best regards,
Krzysztof
