Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A059D4F4250
	for <lists+linux-pm@lfdr.de>; Tue,  5 Apr 2022 23:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238677AbiDEOr1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Apr 2022 10:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387145AbiDEOaP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Apr 2022 10:30:15 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FC8114FD8;
        Tue,  5 Apr 2022 06:12:31 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id d15-20020a9d72cf000000b005cda54187c3so9356149otk.2;
        Tue, 05 Apr 2022 06:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gybD8KNj/W/HoWbum2MjlytMZOz7rVdftOjd7CjfOfk=;
        b=p2dW8JNDfG+wR/AcRAu+yec5t2wkejU1hmZnEb1UPOyUwpvbpSZA19xel29YXnx5YV
         yh8xsbRCxTKGNq5lbQ5ysRHU4YyW+rH0qQ2Wc7uVYk2RRlIaRma/j0y9ZkMOBwJh68DE
         /lenTj03J17b8diAei5OJvnA/7MnHNXUhRhZjcGglE2YYnGWO29v3wy7LImYpE+Z6YUj
         z+gPU/+BRFoM3yHhWFBxMgMZ5O/2MofNljDL0vyuxB24BLx/Vgm4izJHjNy3qdikDH1N
         cTlEyMIfZMh+mP2LI6NMOJtuJ91kC16jXml1+BSzGhzzGAsrPv6SvMGYGWZUh1SUPJND
         j0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gybD8KNj/W/HoWbum2MjlytMZOz7rVdftOjd7CjfOfk=;
        b=tOtGWqSG21YUt5794fKc9VtNzICMGLZ1X5iJnzXJRYx8XRDwZautGCPagWceCtYiSV
         WoTAerRTLbLEQaG1ZdnzElAOoj+vweLZrs/AQ6uMmQEpzRVslQkSVe6vUJpB3KZelidr
         fENcpougTLk0f8iAsLyYZC/pS+oJwkXWL81HudLuzbca0zwVyLxAX6D6aQWgFbtyv4HJ
         wKy4miEO5aeQfzI51o88IiWIY+GV85m0q6ZZVulaI+2Hnwi22rfSY0z5bgXTeZzM7flU
         OzY5vAQ3dr7JfTye6pQR9J/A7MlZJzZh/KPleoUtWt8OV0AHEOwU1I5kMl0OMQ8spX9P
         PsmQ==
X-Gm-Message-State: AOAM532TngbmVTtUHz3kTXRtmeaZ5kiGTqdv1WtnhMbQD6Z/vmyboAEN
        yr/KtPAoAveej+P976y/hXA=
X-Google-Smtp-Source: ABdhPJygfCMsG2GUugJSWbcoi7r4FK8hnjS9pfBgI6aqCzi6pvBrzjDHoCfUviralTU5vm9EL9lXCQ==
X-Received: by 2002:a9d:7414:0:b0:5b2:4a00:fc7 with SMTP id n20-20020a9d7414000000b005b24a000fc7mr1171719otk.100.1649164350737;
        Tue, 05 Apr 2022 06:12:30 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id v21-20020a4ade95000000b00320f814c73bsm4950672oou.47.2022.04.05.06.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 06:12:30 -0700 (PDT)
Date:   Tue, 5 Apr 2022 08:12:28 -0500
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
Message-ID: <20220405131228.GA20@wintermute.localdomain>
References: <20220404215754.30126-1-macroalpha82@gmail.com>
 <20220404215754.30126-2-macroalpha82@gmail.com>
 <74f445c2-3194-80a6-6d52-21368eb6172a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74f445c2-3194-80a6-6d52-21368eb6172a@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 05, 2022 at 01:16:55PM +0200, Krzysztof Kozlowski wrote:
> On 04/04/2022 23:57, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Create dt-binding documentation to document rk817 battery and charger
> > usage. New device-tree properties have been added.
> > 
> > - rockchip,resistor-sense-micro-ohms: The value in microohms of the
> >                                       sample resistor.
> > - rockchip,sleep-enter-current-microamp: The value in microamps of the
> >                                          sleep enter current.
> > - rockchip,sleep-filter-current: The value in microamps of the sleep
> >                                  filter current.
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> > ---
> >  .../bindings/mfd/rockchip,rk817.yaml          | 48 +++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
> > index bfc1720adc43..b949d406a487 100644
> > --- a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
> > @@ -117,6 +117,47 @@ properties:
> >          description:
> >            Describes if the microphone uses differential mode.
> >  
> > +  battery:
> 
> I wonder why do you call it a batter while it is a charger, isn't it?

It is a driver for both the battery and charger. I'd argue about 95% of
it is battery functions and the other 5% is managing the IRQs for plug
removal/insertion and capturing the incoming voltage and current. In
the BSP kernel these were two seperate drivers, but there was so little
that needed to be done for the charger (and users probably don't need
plug IRQs if they aren't using a battery anyway since the system will
shut off on a plug out event due to no power...).

> 
> > +    description: |
> > +      The child node for the charger to hold additional properties. If a
> > +      battery is not in use, this node can be omitted.
> > +    type: object
> > +    properties:
> > +      monitored-battery:
> > +        description: |
> > +          A phandle to a monitored battery node that contains a valid
> > +          value for:
> > +          charge-full-design-microamp-hours,
> > +          charge-term-current-microamp,
> > +          constant-charge-current-max-microamp,
> > +          constant-charge-voltage-max-microvolt,
> > +          voltage-max-design-microvolt,
> > +          voltage-min-design-microvolt,
> > +          and a valid ocv-capacity table.
> > +
> > +      rockchip,resistor-sense-micro-ohms:
> > +        description: |
> > +          Value in microohms of the battery sense resistor. This value is
> > +          used by the driver to set the correct divisor value to translate
> > +          ADC readings into the proper units of measure.
> > +        enum: [10000, 20000]
> > +
> > +      rockchip,sleep-enter-current-microamp:
> > +        description: |
> > +          Value in microamps of the sleep enter current for the charger.
> > +          Value is used by the driver to calibrate the relax threshold.
> > +
> > +      rockchip,sleep-filter-current-microamp:
> > +        description:
> > +          Value in microamps of the sleep filter current for the charger.
> > +          Value is used by the driver to derive the sleep sample current.
> > +
> > +    required:
> > +      - monitored-battery
> > +      - rockchip,resistor-sense-micro-ohms
> > +      - rockchip,sleep-enter-current-microamp
> > +      - rockchip,sleep-filter-current-microamp
> > +
> >  allOf:
> >    - if:
> >        properties:
> > @@ -323,6 +364,13 @@ examples:
> >                  };
> >              };
> >  
> > +            rk817_battery: battery {
> 
> The same.
> 
> > +                monitored-battery = <&battery_cell>;
> > +                rockchip,resistor-sense-micro-ohms = <10000>;
> > +                rockchip,sleep-enter-current-microamp = <300000>;
> > +                rockchip,sleep-filter-current-microamp = <100000>;
> > +            };
> > +
> >              rk817_codec: codec {
> >                  rockchip,mic-in-differential;
> >              };
> 
> 
> Best regards,
> Krzysztof

Thank you.

I forgot to note in my patch notes that this relies on this series
being upstreamed to convert the rockchip rk808 bindings from txt into
yaml:
https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20220404215754.30126-2-macroalpha82@gmail.com/

That series is mostly upstreamed (the patches fixing issues in various
devicetrees). All that remains is the main one switching to yaml.
