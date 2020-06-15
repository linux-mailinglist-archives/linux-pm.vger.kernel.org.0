Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C43B1F9EE8
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jun 2020 19:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbgFOR6s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jun 2020 13:58:48 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36971 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgFOR6s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2020 13:58:48 -0400
Received: by mail-io1-f68.google.com with SMTP id r2so402376ioo.4;
        Mon, 15 Jun 2020 10:58:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/74HbfroHB61O/mrzbKJJjBB8AZlHWxP2oBPibXkxY8=;
        b=mEgiCputIv51F50IjHmQC8XZwZ8fj4Q4luzIMPsv+iK089LhJSYdoghMjWXQg7KqZl
         gEMoWfTz4B4gF46PkYZFNGllU06G60VstN65se6rcSusM1nekabIDKh3lcb4yJ2wHyOD
         nnZhjCd8K0J6XVf5BexXdYdvgZGRssAxUnqqBZ2Kk6leOQf43KcPkKlJNfbSQS4/q0b8
         b3tgECBbErdrc2vAu6Tc4kZsnFuOa5Rlxdcv7uatiZUUStYjeqV8YwkNgjmhUPDr6tHD
         wJBlNEweoGSakYc54I6hda3g7BaqLJi6qPegNgDlXEvyhKy4Y96bDIEGLqJ1Ld+gD7en
         HxSg==
X-Gm-Message-State: AOAM533U0kTQYx5U3qIspnDcxM5Gh19nTC93Ayntkspnp61qTyty5w5U
        0HsgJoBKXBxdaHCZjSmFsA==
X-Google-Smtp-Source: ABdhPJzHHZp4+2D2CPnREtsOrP4HU0FKnjC7ZBKz9hcq/Ll5x38zJ+ihu5f8fyhIDgmwsspw8rJWgw==
X-Received: by 2002:a6b:91d4:: with SMTP id t203mr28373543iod.149.1592243927188;
        Mon, 15 Jun 2020 10:58:47 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id p9sm8303940ile.87.2020.06.15.10.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 10:58:46 -0700 (PDT)
Received: (nullmailer pid 2044691 invoked by uid 1000);
        Mon, 15 Jun 2020 17:58:44 -0000
Date:   Mon, 15 Jun 2020 11:58:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Emil Velikov <emil.velikov@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv2 3/6] power: supply: gpio-charger: add
 charge-current-limit feature
Message-ID: <20200615175844.GA2032047@bogus>
References: <20200605224403.181015-1-sebastian.reichel@collabora.com>
 <20200605224403.181015-4-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605224403.181015-4-sebastian.reichel@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jun 06, 2020 at 12:44:00AM +0200, Sebastian Reichel wrote:
> Add new charge-current-limit feature to gpio-charger.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/power/supply/gpio-charger.yaml   |  31 ++++
>  drivers/power/supply/gpio-charger.c           | 140 ++++++++++++++++++
>  2 files changed, 171 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
> index 30eabbb14ef3..e11cfdc68a51 100644
> --- a/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
> @@ -39,6 +39,25 @@ properties:
>      maxItems: 1
>      description: GPIO indicating the charging status
>  
> +  charge-current-limit-gpios:
> +    minItems: 1
> +    maxItems: 32
> +    description: GPIOs used for current limiting
> +
> +  charge-current-limit-mapping:
> +    description: List of touples with current in uA and a GPIO bitmap (in

s/touples/tuples/

> +      this order). The touples must be provided in descending order of the

and here.

> +      current limit.
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    items:
> +      items:
> +        - description:
> +            Current limit in uA
> +        - description:
> +            Encoded GPIO setting. Bit 0 represents last GPIO from the
> +            charge-current-limit-gpios property. Bit 1 second to last
> +            GPIO and so on.

Seems a bit odd that bit N doesn't represent index N of the gpios.

> +
>  required:
>    - compatible
>  
> @@ -47,6 +66,12 @@ anyOf:
>      - gpios
>    - required:
>      - charge-status-gpios
> +  - required:
> +    - charge-current-limit-gpios
> +
> +dependencies:
> +  charge-current-limit-gpios: [ charge-current-limit-mapping ]
> +  charge-current-limit-mapping: [ charge-current-limit-gpios ]
>  
>  additionalProperties: false
>  
> @@ -60,4 +85,10 @@ examples:
>  
>        gpios = <&gpd 28 GPIO_ACTIVE_LOW>;
>        charge-status-gpios = <&gpc 27 GPIO_ACTIVE_LOW>;
> +
> +      charge-current-limit-gpios = <&gpioA 11 GPIO_ACTIVE_HIGH>,
> +                                   <&gpioA 12 GPIO_ACTIVE_HIGH>;
> +      charge-current-limit-mapping = <2500000 0x00>, // 2.5 A => both GPIOs low
> +                                     <700000 0x01>, // 700 mA => GPIO A.12 high
> +                                     <0 0x02>; // 0 mA => GPIO A.11 high
>      };
