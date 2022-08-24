Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDCF5A01A8
	for <lists+linux-pm@lfdr.de>; Wed, 24 Aug 2022 21:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiHXTAF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Aug 2022 15:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237076AbiHXTAE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Aug 2022 15:00:04 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8596D266D;
        Wed, 24 Aug 2022 12:00:02 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-11cb3c811d9so20341885fac.1;
        Wed, 24 Aug 2022 12:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=81l0urtAdm0422pnKoKdlCLZ2vzf1mvmJMvLVoU13lg=;
        b=xAypobFnfiKofCtwLpOKR49rC6sprOsygrsEEjV8i1/hZG+ZhxAK6Gqe+rlbnurFZf
         hpmCtpWe/bvgZiueZauXtNEMpxQwsl5HCYMx0mjWVqPB7NJ8z7Ha//gipV5G8p706sgJ
         KygE7FgAZO0bdXLUSnu4CF6PcrZ+a1uVHmswqoOw9MPK01l1ndO/B8GHKS/gIXvoZNf0
         KbM9nFc5E428TNhSu8bjVWWQfmzdBjk/p+yR+/RxkNHR3X7ElGNjNYy/YMtvLE7Cs5uE
         8Led/rQBrnnr24nQdZ6VOczpWU4NJSdbJymjq84JsAeqm6bXwSb041djnOIdvp5vLKeX
         NoPg==
X-Gm-Message-State: ACgBeo0j7mSvsEkO+lhYNop+i5/vLt6G6SuGG/LRHEidKf0umEykwl2L
        JLJ4MyBauvjWWOLMZL1rpg==
X-Google-Smtp-Source: AA6agR6gq3odLONnxn7ScxB+V2o8PveOUtauGIp5PDlneckDi2uJ7Qp0CsDQVTyW8ZtEB9eX0Fhn4Q==
X-Received: by 2002:a05:6870:3321:b0:11c:b8f5:e57a with SMTP id x33-20020a056870332100b0011cb8f5e57amr250189oae.100.1661367601746;
        Wed, 24 Aug 2022 12:00:01 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h17-20020a056808015100b0032f0fd7e1f8sm4208742oie.39.2022.08.24.12.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 12:00:01 -0700 (PDT)
Received: (nullmailer pid 2700641 invoked by uid 1000);
        Wed, 24 Aug 2022 18:59:59 -0000
Date:   Wed, 24 Aug 2022 13:59:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, zhangqing@rock-chips.com,
        zyw@rock-chips.com, jon.lin@rock-chips.com,
        maccraft123mc@gmail.com, sre@kernel.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        Chris Morgan <macromorgan@hotmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH V9 1/4] dt-bindings: Add Rockchip rk817 battery charger
 support
Message-ID: <20220824185959.GA2699257-robh@kernel.org>
References: <20220823193015.10229-1-macroalpha82@gmail.com>
 <20220823193015.10229-2-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823193015.10229-2-macroalpha82@gmail.com>
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

On Tue, Aug 23, 2022 at 02:30:12PM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Create dt-binding documentation to document rk817 battery and charger
> usage. New device-tree properties have been added.
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
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

       additionalProperties: false

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
