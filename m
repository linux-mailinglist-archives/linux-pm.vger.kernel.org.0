Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A4C4F4893
	for <lists+linux-pm@lfdr.de>; Wed,  6 Apr 2022 02:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245614AbiDEVmW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Apr 2022 17:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443076AbiDEPiy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Apr 2022 11:38:54 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63666F4AC;
        Tue,  5 Apr 2022 06:54:27 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id z9-20020a05683020c900b005b22bf41872so9387439otq.13;
        Tue, 05 Apr 2022 06:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dy5LYcTnNJiWRcwV1Fieefr8N5kpvaI50G2mfB2TW0o=;
        b=oRTrTtkF+q1BBVG9AVVedAYu2e0LMKRUmPSsMtS5WJOU4jsLSjzLhQC0+c1n44OAaR
         Mds/oqlV9GozohD+5RC2ju1JsRWssPc8L3EZTDKNhDrGcvYhHw2lZvwvvQ9Aiyx8MaEb
         FSUPyH6/Ias/QrL+DA7NXXw2ktQSrw3QIKU8CRNtGWd7X8ey3Lrr3AAkHCrhKcjIlK5i
         Lwd/mEAPoiWVq/Lb+1kKAWZFTrQ04Kn3I1xbKpT6wo8iFB4WI9LjczYc/hUS8UlZTwRR
         Z9Vj8XF4SWPK42ns1ChpQvBiEpYDjEhcTLd8hLgf8FKtytj7qdHPQ7+X0kNVhl/AxS7+
         Ph1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dy5LYcTnNJiWRcwV1Fieefr8N5kpvaI50G2mfB2TW0o=;
        b=CkMhFkhHOlbxnPF9dlc3eRkhIABwr9QaIMqesyRJFgjareu9U3wCAA1gv0QWU7e06O
         pHAha75JevINLJCr5EuOamL8jVKNpcLunzRvK4R3T28FKw9zmxhejcKfwkwR4jXJFvPg
         AxlB2b0eilixnxfvr7gSN5kspJrtszUDrxE2F8izztbeSBETJMSZm5A78ZuGwIszQZUj
         8cjC1spmdGJdUxx68trdwecN7kBBS0ciIZZ2Y4wmb8jSWa7jL64hq9evcSt/fRQaxHSP
         9HoZg4qU4HVQH5S5DDF/iHawulKlWexMUvJVoSM8H3Z1Xj7LSFoBOeMCcfVu1ML2vSRf
         Mg4w==
X-Gm-Message-State: AOAM531bt8BjhGFFc2bT/S9XOLX8q+CbjJHjHqO93+S5T/w+pG5SGefF
        yMRAQCFlE+NICi5OioG0WLI=
X-Google-Smtp-Source: ABdhPJz2dllJO+XzcLvJiX1uF5tdKyc02gu0lc7wYaLLYy5qUIm3967isqwJ+g8yoWhmKIJAmYPmKw==
X-Received: by 2002:a05:6830:1041:b0:5cd:b09b:2164 with SMTP id b1-20020a056830104100b005cdb09b2164mr1232172otp.186.1649166867183;
        Tue, 05 Apr 2022 06:54:27 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id r129-20020acac187000000b002ef358c6e0esm5282906oif.49.2022.04.05.06.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 06:54:26 -0700 (PDT)
Date:   Tue, 5 Apr 2022 08:54:24 -0500
From:   Chris Morgan <macroalpha82@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, zhangqing@rock-chips.com,
        zyw@rock-chips.com, jon.lin@rock-chips.com,
        maccraft123mc@gmail.com, sre@kernel.org, heiko@sntech.de,
        krzk+dt@kernel.org, robh+dt@kernel.org, lee.jones@linaro.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 1/4 v5] dt-bindings: Add Rockchip rk817 battery charger
 support
Message-ID: <20220405135424.GA20@wintermute.localdomain>
References: <20220404215754.30126-1-macroalpha82@gmail.com>
 <20220404215754.30126-2-macroalpha82@gmail.com>
 <74f445c2-3194-80a6-6d52-21368eb6172a@linaro.org>
 <20220405131228.GA20@wintermute.localdomain>
 <ac2b29c2-b3ec-eb03-595f-b0328e40015c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac2b29c2-b3ec-eb03-595f-b0328e40015c@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 05, 2022 at 03:35:04PM +0200, Krzysztof Kozlowski wrote:
> On 05/04/2022 15:12, Chris Morgan wrote:
> > On Tue, Apr 05, 2022 at 01:16:55PM +0200, Krzysztof Kozlowski wrote:
> >> On 04/04/2022 23:57, Chris Morgan wrote:
> >>> From: Chris Morgan <macromorgan@hotmail.com>
> >>>
> >>> Create dt-binding documentation to document rk817 battery and charger
> >>> usage. New device-tree properties have been added.
> >>>
> >>> - rockchip,resistor-sense-micro-ohms: The value in microohms of the
> >>>                                       sample resistor.
> >>> - rockchip,sleep-enter-current-microamp: The value in microamps of the
> >>>                                          sleep enter current.
> >>> - rockchip,sleep-filter-current: The value in microamps of the sleep
> >>>                                  filter current.
> >>>
> >>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> >>> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> >>> ---
> >>>  .../bindings/mfd/rockchip,rk817.yaml          | 48 +++++++++++++++++++
> >>>  1 file changed, 48 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
> >>> index bfc1720adc43..b949d406a487 100644
> >>> --- a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
> >>> +++ b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
> >>> @@ -117,6 +117,47 @@ properties:
> >>>          description:
> >>>            Describes if the microphone uses differential mode.
> >>>  
> >>> +  battery:
> >>
> >> I wonder why do you call it a batter while it is a charger, isn't it?
> > 
> > It is a driver for both the battery and charger. I'd argue about 95% of
> > it is battery functions and the other 5% is managing the IRQs for plug
> > removal/insertion and capturing the incoming voltage and current. In
> > the BSP kernel these were two seperate drivers, but there was so little
> > that needed to be done for the charger (and users probably don't need
> > plug IRQs if they aren't using a battery anyway since the system will
> > shut off on a plug out event due to no power...).
> 
> What do you mean by driver for "battery"? Like some smart-battery
> system? with embedded battery (RK817 comes with embedded battery) Or a
> fuel gauge? Judging by power supply properties it looks like fuel gauge.

It's basically just additional registers in the rk817 PMIC. The PMIC is
controlled via I2C and contains multiple regulators, an audio codec,
an RTC, some GPIO, some nvram, a columb counter for the battery, and an
ADC for measuring input current/voltage/temperature (for battery or
charger). This driver deals with the columb counter, the ADC, and a few
bits of nvram for storing battery values to retain backwards
compatibility with the BSP kernel and bootloader, and handling IRQs
related to inserting or removing the charger (curiously my
implementation ALSO has a charger sense GPIO in addition to the PMIC
being able to sense that).

The driver itself is named rk817_charger. If you think I should change
this from battery to "fuel gauge" or "charger" let me know and I can
resubmit. Whatever makes it clearer for everyone.

Thank you.

> 
> "Battery" should rather be used for the node referenced by
> "monitored-battery"...
> 
> Best regards,
> Krzysztof
