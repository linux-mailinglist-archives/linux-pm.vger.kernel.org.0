Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FDD4FE4C5
	for <lists+linux-pm@lfdr.de>; Tue, 12 Apr 2022 17:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349430AbiDLPdn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Apr 2022 11:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354138AbiDLPdl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Apr 2022 11:33:41 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8252A393E7;
        Tue, 12 Apr 2022 08:31:23 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-df02f7e2c9so21088949fac.10;
        Tue, 12 Apr 2022 08:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yeK0Qe+bcNo2GUyRc1iqCE2CyXcGcUyGjHEO/3zFmvk=;
        b=3FTEqBE96ruZ5XbZT1DPLXGBTwXm5fHBDuEXu3Tq73SySydioPPnMAvqju7rpPtBJz
         AjjklTHbEPccg6rqPAU1/BuATGxdEM1W7Qwym+H5NATNteAcpTkVc1gD1HQEUYlfTMHM
         oiXh+nrRXFhBTCBrq2Bq+H0qAcEukwjx7o8aP9+e+Wozx6zebVKDQCwWI2hgjA3S6GKb
         Yh9NptaGOSN9zCWNjAc7r19434E01zwcLkEWUchUPHZiw8v1NruIGNzU6xCdXSXh/M/G
         QGdrWKIftpczKPanplXBTuZ4jBVQ+ec8IlICKuqdmoMWeLBhnP/Hk1I2hrqOd/lyPpow
         hHsg==
X-Gm-Message-State: AOAM530tHj8mylu8v4gcemTDVSi2lki+aO1o9dYmDSDznmGXF3P7/Ftv
        rpRN/eQWANGtPMDy+m1MhA==
X-Google-Smtp-Source: ABdhPJwOCUZU4bnvPcvVgrHK6g0K4py1kZ3fwcKrN2HvUM4sYaNp/OmKe9UXC96ctEZzG4/wSby/mw==
X-Received: by 2002:a05:6870:8929:b0:db:1bf5:3b8f with SMTP id i41-20020a056870892900b000db1bf53b8fmr2363662oao.285.1649777482749;
        Tue, 12 Apr 2022 08:31:22 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v3-20020a05683011c300b005e6e4a5bd35sm2766016otq.79.2022.04.12.08.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 08:31:22 -0700 (PDT)
Received: (nullmailer pid 275870 invoked by uid 1000);
        Tue, 12 Apr 2022 15:31:21 -0000
Date:   Tue, 12 Apr 2022 10:31:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, zhangqing@rock-chips.com,
        zyw@rock-chips.com, maccraft123mc@gmail.com,
        jon.lin@rock-chips.com, sre@kernel.org, heiko@sntech.de,
        krzk+dt@kernel.org, lee.jones@linaro.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 1/4 v6] dt-bindings: Add Rockchip rk817 battery charger
 support
Message-ID: <YlWbSd0mPpzfLkPd@robh.at.kernel.org>
References: <20220408212121.9368-1-macroalpha82@gmail.com>
 <20220408212121.9368-2-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408212121.9368-2-macroalpha82@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 08, 2022 at 04:21:18PM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Create dt-binding documentation to document rk817 battery and charger
> usage. New device-tree properties have been added. Note that this
> patch requires the following commit (still pending):
> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20220404215754.30126-2-macroalpha82@gmail.com/

Thanks for adding this, but it should be below the '---' as this will 
not be relevant once committed. Note that any links to patches that we 
do want preserved should be lore.kernel.org links.

> 
> - rockchip,resistor-sense-micro-ohms: The value in microohms of the
>                                       sample resistor.
> - rockchip,sleep-enter-current-microamp: The value in microamps of the
>                                          sleep enter current.
> - rockchip,sleep-filter-current: The value in microamps of the sleep
>                                  filter current.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> ---
>  .../bindings/mfd/rockchip,rk817.yaml          | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
> index bfc1720adc43..d0dccb1aaf4c 100644
> --- a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
> +++ b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
> @@ -117,6 +117,47 @@ properties:
>          description:
>            Describes if the microphone uses differential mode.
>  
> +  charger:
> +    description: |
> +      The child node for the charger to hold additional properties. If a
> +      battery is not in use, this node can be omitted.
> +    type: object
> +    properties:
> +      monitored-battery:
> +        description: |
> +          A phandle to a monitored battery node that contains a valid
> +          value for:
> +          charge-full-design-microamp-hours,
> +          charge-term-current-microamp,
> +          constant-charge-current-max-microamp,
> +          constant-charge-voltage-max-microvolt,
> +          voltage-max-design-microvolt,
> +          voltage-min-design-microvolt,
> +          and a valid ocv-capacity table.
> +
> +      rockchip,resistor-sense-micro-ohms:
> +        description: |
> +          Value in microohms of the battery sense resistor. This value is
> +          used by the driver to set the correct divisor value to translate
> +          ADC readings into the proper units of measure.
> +        enum: [10000, 20000]
> +
> +      rockchip,sleep-enter-current-microamp:
> +        description: |
> +          Value in microamps of the sleep enter current for the charger.
> +          Value is used by the driver to calibrate the relax threshold.
> +
> +      rockchip,sleep-filter-current-microamp:
> +        description:
> +          Value in microamps of the sleep filter current for the charger.
> +          Value is used by the driver to derive the sleep sample current.
> +
> +    required:
> +      - monitored-battery
> +      - rockchip,resistor-sense-micro-ohms
> +      - rockchip,sleep-enter-current-microamp
> +      - rockchip,sleep-filter-current-microamp
> +
>  allOf:
>    - if:
>        properties:
> @@ -323,6 +364,13 @@ examples:
>                  };
>              };
>  
> +            rk817_charger: charger {
> +                monitored-battery = <&battery>;
> +                rockchip,resistor-sense-micro-ohms = <10000>;
> +                rockchip,sleep-enter-current-microamp = <300000>;
> +                rockchip,sleep-filter-current-microamp = <100000>;
> +            };
> +
>              rk817_codec: codec {
>                  rockchip,mic-in-differential;
>              };
> -- 
> 2.25.1
> 
> 
