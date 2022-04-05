Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3626A4F48A6
	for <lists+linux-pm@lfdr.de>; Wed,  6 Apr 2022 02:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352998AbiDEVoj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Apr 2022 17:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444384AbiDEPlY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Apr 2022 11:41:24 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E33BBD8AC;
        Tue,  5 Apr 2022 07:04:31 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id r8so13500060oib.5;
        Tue, 05 Apr 2022 07:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VpRYCzUSFqQOsJnFa1HK3Picrp1UN0Dkk9U5InPoxS4=;
        b=FFI6YhzTevdQXQaC30yLc3wS4coQZw89BdSpxUTKS9vpRHiS38W+JXTO/Z08dZo7zW
         dn6YsD+XzciatZgdzaGb81gkwuEw/9IwfVGrp5mk7oseaE2XBhKM+sXSpEypSCYAcEGH
         LN6VuajiAViuJ0YhOw17EcH02SpvpwRFWSsmwaDb2IcdtrkuKi1fCbpsmlrxlpoLU52d
         XWV6WH9GjUC+iAoL3tJpJXIq/WGZfF6YEVA0P5BBR237kCTUJ2s233Pq0TuQ717XDEjJ
         HTS9BPk3cJZ3rIBpV5NaDutLWQjdmD37Y0I9lZbZUtq8AGffsXh9WnxX95/jsirkCg5V
         244w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VpRYCzUSFqQOsJnFa1HK3Picrp1UN0Dkk9U5InPoxS4=;
        b=P/FIv4wJ89DKzdg8vwUQoTM04Sdr0w0+5TRJyaA6LIaV30gYuE3EjiCkpvXjFk7Y7/
         lCKHRhgbcsw6SAQCkl6t6PL+NOXJ14UrcR9u4Eje4LVpEQ05DKYut1PT8QLnGmpjNggF
         tFtSk/NgbK6FZH7LU50MTVXh3jiDZXzT329KnwWYqi9IyJ540jkBoLzIJAxW+HiJ1h8F
         xxIUiYL2OsIKWyl+ZW7KpEREiJJbHAui0zG3k7ksrjtcO6XsSUsmf/53tzTRhHNkTrbs
         3gIScwHIoOi87/bTknMmLggZKN5limDaVxdoNurd0eIvmQS4Xwt7nwbt4eInqezIdZUN
         4WcQ==
X-Gm-Message-State: AOAM531ND3U7/5sy4js6rEUkhdMFi/HbZyK0egmVbGf+hkadVCcawHE7
        LNUDhPkBSwjGBjPk5k+WdA0=
X-Google-Smtp-Source: ABdhPJxLU9NGisraQHAUwA2Pfe7U78pnpsSsDiVtJieLXk0lONuMBGg9/PzdR4PxEbZAa2whm5sREg==
X-Received: by 2002:aca:2405:0:b0:2da:c44:bae3 with SMTP id n5-20020aca2405000000b002da0c44bae3mr1500868oic.173.1649167471115;
        Tue, 05 Apr 2022 07:04:31 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id e9-20020aca3709000000b002ed1930b253sm5352059oia.30.2022.04.05.07.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 07:04:30 -0700 (PDT)
Date:   Tue, 5 Apr 2022 09:04:28 -0500
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
Message-ID: <20220405140428.GA72@wintermute.localdomain>
References: <20220404215754.30126-1-macroalpha82@gmail.com>
 <20220404215754.30126-2-macroalpha82@gmail.com>
 <74f445c2-3194-80a6-6d52-21368eb6172a@linaro.org>
 <20220405131228.GA20@wintermute.localdomain>
 <ac2b29c2-b3ec-eb03-595f-b0328e40015c@linaro.org>
 <20220405135424.GA20@wintermute.localdomain>
 <b269be83-3e45-fb36-75ab-e1c20ad6906f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b269be83-3e45-fb36-75ab-e1c20ad6906f@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 05, 2022 at 04:00:09PM +0200, Krzysztof Kozlowski wrote:
> On 05/04/2022 15:54, Chris Morgan wrote:
> > On Tue, Apr 05, 2022 at 03:35:04PM +0200, Krzysztof Kozlowski wrote:
> >> On 05/04/2022 15:12, Chris Morgan wrote:
> >>> On Tue, Apr 05, 2022 at 01:16:55PM +0200, Krzysztof Kozlowski wrote:
> >>>> On 04/04/2022 23:57, Chris Morgan wrote:
> >>>>> From: Chris Morgan <macromorgan@hotmail.com>
> >>>>>
> >>>>> Create dt-binding documentation to document rk817 battery and charger
> >>>>> usage. New device-tree properties have been added.
> >>>>>
> >>>>> - rockchip,resistor-sense-micro-ohms: The value in microohms of the
> >>>>>                                       sample resistor.
> >>>>> - rockchip,sleep-enter-current-microamp: The value in microamps of the
> >>>>>                                          sleep enter current.
> >>>>> - rockchip,sleep-filter-current: The value in microamps of the sleep
> >>>>>                                  filter current.
> >>>>>
> >>>>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> >>>>> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> >>>>> ---
> >>>>>  .../bindings/mfd/rockchip,rk817.yaml          | 48 +++++++++++++++++++
> >>>>>  1 file changed, 48 insertions(+)
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
> >>>>> index bfc1720adc43..b949d406a487 100644
> >>>>> --- a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
> >>>>> +++ b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
> >>>>> @@ -117,6 +117,47 @@ properties:
> >>>>>          description:
> >>>>>            Describes if the microphone uses differential mode.
> >>>>>  
> >>>>> +  battery:
> >>>>
> >>>> I wonder why do you call it a batter while it is a charger, isn't it?
> >>>
> >>> It is a driver for both the battery and charger. I'd argue about 95% of
> >>> it is battery functions and the other 5% is managing the IRQs for plug
> >>> removal/insertion and capturing the incoming voltage and current. In
> >>> the BSP kernel these were two seperate drivers, but there was so little
> >>> that needed to be done for the charger (and users probably don't need
> >>> plug IRQs if they aren't using a battery anyway since the system will
> >>> shut off on a plug out event due to no power...).
> >>
> >> What do you mean by driver for "battery"? Like some smart-battery
> >> system? with embedded battery (RK817 comes with embedded battery) Or a
> >> fuel gauge? Judging by power supply properties it looks like fuel gauge.
> > 
> > It's basically just additional registers in the rk817 PMIC. The PMIC is
> > controlled via I2C and contains multiple regulators, an audio codec,
> > an RTC, some GPIO, some nvram, a columb counter for the battery, and an
> > ADC for measuring input current/voltage/temperature (for battery or
> > charger). 
> 
> Actually you mentioned it in the cover letter - it's a PMIC, not a
> battery. I doubt that it's embedded with a battery. :)
> 
> > This driver deals with the columb counter, the ADC, and a few
> > bits of nvram for storing battery values to retain backwards
> > compatibility with the BSP kernel and bootloader, and handling IRQs
> > related to inserting or removing the charger (curiously my
> > implementation ALSO has a charger sense GPIO in addition to the PMIC
> > being able to sense that).
> > 
> > The driver itself is named rk817_charger. If you think I should change
> > this from battery to "fuel gauge" or "charger" let me know and I can
> > resubmit. Whatever makes it clearer for everyone.
> 
> Yeah, the property name and bindings should describe the hardware, so in
> such case the hardware is rather a "charger" or "fuel-gauge". Your
> "battery-cell" from DTS is probably just a "battery" (unless you expect
> multiple cells?).
> 
> Best regards,
> Krzysztof

Okay, when v6 comes around I'll change it to be "charger" instead of
"battery" to make it more clear. There should only be a single battery
instead of multiple cells, and according to the documentation I should
be okay with describing the battery in the devicetree since it's not
something easy for the end-user to change.

I'd like to get someone to look at the meat and potatoes of the series
before I submit a v6... I did a fairly substantial rewrite of the
actual rk817_charger.c to solve for several problems and fix several
bugs I found in extended testing. One of the major changes was to
mirror the BSP in that I poll the PMIC every 8 seconds for updates
and then store it in the driver struct rather than pull each value
on demand as requested. I see other drivers doing this but I want
to make sure that's acceptable upstream.

Thank you.
