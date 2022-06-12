Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DC5547CB6
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jun 2022 00:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbiFLWRm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Jun 2022 18:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237290AbiFLWQp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Jun 2022 18:16:45 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7485C522DE
        for <linux-pm@vger.kernel.org>; Sun, 12 Jun 2022 15:16:43 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id y15so4468115ljc.0
        for <linux-pm@vger.kernel.org>; Sun, 12 Jun 2022 15:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=sunDVi/ticftrmGFGD0ymqsOh72W45vWbx1D2LbSq4s=;
        b=asLN9hjKyM34whmshERovu7s3c3BhM+F7MTfEN9BXMNwm1aDR0HpuRBlKYUTUT4uS9
         egeaexlIXxY7Pgglt35XChh8Q/5MDS6Z3frnxjAHtGBhFJGIF+ZMgGspG/NxBw3mc2HO
         rEd0Jafy0ABL8PJYkhUXHSy+IpekdZIb+DwejUuxiW6DfKyvC/iJUT/5kKtZImgYn3G1
         uCJ2nhmt8p6buatbjH+gbDaDx2h847+C+G7mivFkULwRwatyRMNMMRp0zzhKUhTzIVLc
         IDZVCiOxGzvDqpNEkmtHc+HcO+F2nK4RcN6XCeAQP4rWHCEvVi8bAprDmngpmZ0M4dmo
         RB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sunDVi/ticftrmGFGD0ymqsOh72W45vWbx1D2LbSq4s=;
        b=Xjbj9P2C90vZXy6s6TgLJwzJ0rrzqOUbRl4qDrP4bim/SVGwJ0GUB/yTD7iI2lR1bT
         bHA8A83ld2eAhIw6/AGz60B94+001INAAX41m6JnEkRRfGS+zKtOTYzBY6W6GHTT53Nj
         iy4bkVj25e+2oZSsk0IraLTab4zN3AQOMCl/ghJXQ5U+1elg3tzc48Jsn0Oj2bcEIVgl
         7TPz3A1H9BqX1ZCF53y5c7UWF8+v90c175IQ/kgVzM+TSWxrxfd00UxFxBG5iirB6rmj
         9xij1PP0JU4m8Z0tqNzYMELiy0zwWRiuoYnsE5PxZM76B+lP/Avv978AZF/1TZc4Mw5i
         LY7w==
X-Gm-Message-State: AOAM531LTC2/ZNNJQgUiyESSPfaphjzLVkO0EvGKb+4vWn4QJCoui8IY
        v+HIzhwulNxrdGrnz3Mdk3XN2Q==
X-Google-Smtp-Source: ABdhPJyiW858OSRKNb3DyVbWavm4PLqO5MZ0BncdZxJ3DWEye/I3ZGfWCBKVqmVWhgfOznBLaDYK2w==
X-Received: by 2002:a2e:6a0d:0:b0:255:7341:145 with SMTP id f13-20020a2e6a0d000000b0025573410145mr28908880ljc.360.1655072201580;
        Sun, 12 Jun 2022 15:16:41 -0700 (PDT)
Received: from localhost (h-85-24-188-65.A463.priv.bahnhof.se. [85.24.188.65])
        by smtp.gmail.com with ESMTPSA id z10-20020a0565120c0a00b00477cc59e376sm741820lfu.161.2022.06.12.15.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 15:16:41 -0700 (PDT)
Date:   Mon, 13 Jun 2022 00:16:40 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: thermal: rcar-gen3-thermal: use
 positive logic
Message-ID: <YqZlyBH349VIdQDI@oden.dyn.berto.se>
References: <20220610201701.7946-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220610201701.7946-1-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Wolfram,

Thanks for your patch.

On 2022-06-10 22:17:00 +0200, Wolfram Sang wrote:
> When handling the V3U/r8a779a0 exception, avoid using 'not:' because
> then its subschemas are far away in the 'else:' branch. Keep them
> together using positive logic.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> 
> Changes since v2:
> * new patch
> 
> Tested with:
> make dtbs_check DT_SCHEMA_FILES=thermal/rcar-gen3-thermal.yaml
> 
>  .../bindings/thermal/rcar-gen3-thermal.yaml   | 21 +++++++++----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
> index 1368d90da0e8..72dc7eb27f8d 100644
> --- a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
> @@ -57,31 +57,30 @@ required:
>    - "#thermal-sensor-cells"
>  
>  if:
> -  not:
> -    properties:
> -      compatible:
> -        contains:
> -          enum:
> -            - renesas,r8a779a0-thermal
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - renesas,r8a779a0-thermal
>  then:
>    properties:
>      reg:
> -      minItems: 2
>        items:
> +        - description: TSC0 registers
>          - description: TSC1 registers
>          - description: TSC2 registers
>          - description: TSC3 registers
> -  required:
> -    - interrupts
> +        - description: TSC4 registers
>  else:
>    properties:
>      reg:
> +      minItems: 2
>        items:
> -        - description: TSC0 registers
>          - description: TSC1 registers
>          - description: TSC2 registers
>          - description: TSC3 registers
> -        - description: TSC4 registers
> +  required:
> +    - interrupts
>  
>  additionalProperties: false
>  
> -- 
> 2.35.1
> 

-- 
Kind Regards,
Niklas Söderlund
