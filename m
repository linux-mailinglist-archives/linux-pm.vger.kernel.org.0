Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08594F48A2
	for <lists+linux-pm@lfdr.de>; Wed,  6 Apr 2022 02:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357270AbiDEVon (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Apr 2022 17:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388892AbiDEPUm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Apr 2022 11:20:42 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B1FC4E33
        for <linux-pm@vger.kernel.org>; Tue,  5 Apr 2022 06:35:07 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id d7so3016744edn.11
        for <linux-pm@vger.kernel.org>; Tue, 05 Apr 2022 06:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5dwM+wZpTO3dJm2C/zTXFC7RztJX3MC1/t/cmygFHpM=;
        b=U0esJs4rP0x+B/7le3KzQk0G9D9jf8luw+Lhb+RWPQ520F2Pkjzs3DVjaaHodh5Ejw
         K7bJwFQphX/lsr8r79a9uqQIcQUtCWuYFPYkehbagjXAt4reilNZRI6JcOroNXL3HSm1
         c1Dirae4HlQOeBoqs/mTgxhlSJw8YJjTlR92APx6zOXG6vyTCaqbTuliyVuR0CayEq60
         NXSZzvAYgfZSRp66eov4utbzned9N9+RHLZFEfRHkCARQSBTK5GeS4KDiIh3xIUtJ8h+
         vWME8qOzqa/NzEVS4/LMjrZG6mz8ojmpH5XjH38KhClsdBMdQuAdpllbk6spsPl8Fp6f
         IAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5dwM+wZpTO3dJm2C/zTXFC7RztJX3MC1/t/cmygFHpM=;
        b=bSYVe1snbNPhn1IzCpYsdCH7nWPKWa7BhoihpwQnPeuK4ix+YkCgeh1H18fS8MAeiL
         EmRRPV+K/7p+vAcgHTFmH2PWooLT/Ug5UIFE82DMF6497cuhk9yCrmEqWuQf8Azufs6E
         aRj+fnHcuZvgLPwOyGhBXrUDZ7n45hBKXENeJ1XaBn07M2BNxlys4pqg2FrYnb1EGL8e
         A0p8nS7X8PHXlOZ7CKKkmz2SdX4cxOGubFpPOGfwlG1flD9W5E7GRlNmgaqiSc7mdJBH
         CMljfxYBLzN5npJSi+8FLDOEnIfUnYkZ7U2p4pgm+uZMalBge1evnNJKBB8FNjcXjfY/
         3/tw==
X-Gm-Message-State: AOAM530uQhJmeZNQVFGOe/Tfo7HGrWnbReDlHx9CWFAuDFFaRskA5dqy
        bg99y3quoeubPJr663aOfytB1w==
X-Google-Smtp-Source: ABdhPJyMdghdEM2XuZgbpwldmrRTm3as2pia+nLSDQYWpSbi7EJHANLmyvBkobO5HTtK6Wvy1FRIPg==
X-Received: by 2002:a05:6402:3553:b0:419:6552:11b7 with SMTP id f19-20020a056402355300b00419655211b7mr3644088edd.286.1649165706043;
        Tue, 05 Apr 2022 06:35:06 -0700 (PDT)
Received: from [192.168.0.182] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id e3-20020a170906374300b006e7f060bf6asm2501343ejc.207.2022.04.05.06.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 06:35:05 -0700 (PDT)
Message-ID: <ac2b29c2-b3ec-eb03-595f-b0328e40015c@linaro.org>
Date:   Tue, 5 Apr 2022 15:35:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/4 v5] dt-bindings: Add Rockchip rk817 battery charger
 support
Content-Language: en-US
To:     Chris Morgan <macroalpha82@gmail.com>
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220405131228.GA20@wintermute.localdomain>
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

On 05/04/2022 15:12, Chris Morgan wrote:
> On Tue, Apr 05, 2022 at 01:16:55PM +0200, Krzysztof Kozlowski wrote:
>> On 04/04/2022 23:57, Chris Morgan wrote:
>>> From: Chris Morgan <macromorgan@hotmail.com>
>>>
>>> Create dt-binding documentation to document rk817 battery and charger
>>> usage. New device-tree properties have been added.
>>>
>>> - rockchip,resistor-sense-micro-ohms: The value in microohms of the
>>>                                       sample resistor.
>>> - rockchip,sleep-enter-current-microamp: The value in microamps of the
>>>                                          sleep enter current.
>>> - rockchip,sleep-filter-current: The value in microamps of the sleep
>>>                                  filter current.
>>>
>>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
>>> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
>>> ---
>>>  .../bindings/mfd/rockchip,rk817.yaml          | 48 +++++++++++++++++++
>>>  1 file changed, 48 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
>>> index bfc1720adc43..b949d406a487 100644
>>> --- a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
>>> +++ b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
>>> @@ -117,6 +117,47 @@ properties:
>>>          description:
>>>            Describes if the microphone uses differential mode.
>>>  
>>> +  battery:
>>
>> I wonder why do you call it a batter while it is a charger, isn't it?
> 
> It is a driver for both the battery and charger. I'd argue about 95% of
> it is battery functions and the other 5% is managing the IRQs for plug
> removal/insertion and capturing the incoming voltage and current. In
> the BSP kernel these were two seperate drivers, but there was so little
> that needed to be done for the charger (and users probably don't need
> plug IRQs if they aren't using a battery anyway since the system will
> shut off on a plug out event due to no power...).

What do you mean by driver for "battery"? Like some smart-battery
system? with embedded battery (RK817 comes with embedded battery) Or a
fuel gauge? Judging by power supply properties it looks like fuel gauge.

"Battery" should rather be used for the node referenced by
"monitored-battery"...

Best regards,
Krzysztof
