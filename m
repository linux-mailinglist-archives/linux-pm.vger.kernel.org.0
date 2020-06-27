Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C7020BDFE
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jun 2020 05:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgF0Dol (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jun 2020 23:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgF0Dol (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2020 23:44:41 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CBEC03E979
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2020 20:44:41 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 9so12335029ljc.8
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2020 20:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1ipeOLnzim9RHH3BR3oeo43dwwGRCZWcLxW7Zyfmk7Y=;
        b=THoSiAlK5eFDbai50iadIqNqkP44jtQtez7MXzb9hWGyhDNZCBAuC+9jtQXhs3RNik
         PG1MbrFl5veM1OIWiwYJhz0jmCHRKAn12MZlX6Pcb1+hNX30AEq9wDsw0vmQMxSZr6eQ
         20Wn/p3XYvpGrb18SYdnR2CioNhuFYRwAQs8yGPIPQpLFaxwTvWm78qKuISjsRFOTFRP
         JxhMKrdb8JGHkZWhoW31tfMxk/wLnkT881LDDOaIQ+obXEY66/EZK5CokutetPJrLkLH
         97NREqKjCk6CAwlMUR6qO+IhmsIySrSHRXy7UL7eFGc8w4RB8WKExHNcz8A6ZuA9EvIH
         gN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1ipeOLnzim9RHH3BR3oeo43dwwGRCZWcLxW7Zyfmk7Y=;
        b=ZOXYZ2BHtwIWXWAbSb+y2DzHbrCeEnFQ9XXiAjSU0XxRf9x9dTJ44lLvxQDRy3+XBH
         YZTlk445BjF/1f3lC1tklpQavv5ExNcg26J+fRfpufVVmDVlXY+XOIQUnx6TsT19SAja
         gArQ52sMzYXLTpPXd1ixFG6Z8d7caYvSODw6dwnFuu5p8FDe7YwvWwW4fgh+EK/Y/QQO
         q53RAoCpHeUQMnSfI8AhRrC+8YRKmaKq0x3BukYCwbjMLINDbrUokjAhdDod48+Izn0m
         8qhBE74yG/637JM10SUhxRlBN3g50jZKT3juCQ0Mlq6al4fc7esiX/z41dwNMKuNWkjr
         C5Tw==
X-Gm-Message-State: AOAM530+Gv5XBgFb1K4MZGwkYoM79he6dhfqzvYT2LYuBhQ/iTYhBwtU
        QZap++5xpdRdk/AKY0+T/2Nt3Q==
X-Google-Smtp-Source: ABdhPJwDH6i2sGxqmAkQdk5LPxNBL+PLHXK7LTjxbbqZwgwZZ5LuW2NANlXVYdsHGx6CpKtKt3Tmxg==
X-Received: by 2002:a2e:6f08:: with SMTP id k8mr2520189ljc.384.1593229479463;
        Fri, 26 Jun 2020 20:44:39 -0700 (PDT)
Received: from localhost (h-209-203.A463.priv.bahnhof.se. [155.4.209.203])
        by smtp.gmail.com with ESMTPSA id j4sm4925954lfb.94.2020.06.26.20.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 20:44:38 -0700 (PDT)
Date:   Sat, 27 Jun 2020 05:44:38 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: thermal: rcar-thermal: Improve schema
 validation
Message-ID: <20200627034438.GA911447@oden.dyn.berto.se>
References: <20200619151541.15069-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200619151541.15069-1-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Geert,

Thanks for your work.

On 2020-06-19 17:15:41 +0200, Geert Uytterhoeven wrote:
>   - Document missing "#thermal-sensor-cells",
>   - Factor out common required properties,
>   - "interrupts", "clocks", and "power-domains" are required on R-Mobile
>     APE6, too,
>   - Invert logic to simplify descriptions,
>   - Add "additionalProperties: false".
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Niklas Söderlund <niklas.soderlund@ragnatech.se>

> ---
>  .../bindings/thermal/rcar-thermal.yaml        | 53 ++++++++++++-------
>  1 file changed, 34 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml b/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
> index 0994693d240f9ff4..88787b98992fe7c9 100644
> --- a/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
> @@ -59,25 +59,40 @@ properties:
>    resets:
>      maxItems: 1
>  
> -if:
> -  properties:
> -    compatible:
> -      contains:
> -        enum:
> -          - renesas,thermal-r8a73a4 # R-Mobile APE6
> -          - renesas,thermal-r8a7779 # R-Car H1
> -then:
> -  required:
> -    - compatible
> -    - reg
> -else:
> -  required:
> -    - compatible
> -    - reg
> -    - interrupts
> -    - clocks
> -    - power-domains
> -    - resets
> +  '#thermal-sensor-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              enum:
> +                - renesas,thermal-r8a73a4 # R-Mobile APE6
> +                - renesas,thermal-r8a7779 # R-Car H1
> +    then:
> +      required:
> +        - resets
> +        - '#thermal-sensor-cells'
> +
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              const: renesas,thermal-r8a7779 # R-Car H1
> +    then:
> +      required:
> +        - interrupts
> +        - clocks
> +        - power-domains
> +
> +additionalProperties: false
>  
>  examples:
>    # Example (non interrupt support)
> -- 
> 2.17.1
> 

-- 
Regards,
Niklas Söderlund
