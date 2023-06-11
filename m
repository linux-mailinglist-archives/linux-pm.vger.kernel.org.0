Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CADA72B13A
	for <lists+linux-pm@lfdr.de>; Sun, 11 Jun 2023 11:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbjFKJr0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Jun 2023 05:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbjFKJr0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Jun 2023 05:47:26 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955A8E75
        for <linux-pm@vger.kernel.org>; Sun, 11 Jun 2023 02:47:24 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5147f4bbfdaso4627104a12.0
        for <linux-pm@vger.kernel.org>; Sun, 11 Jun 2023 02:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686476843; x=1689068843;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IntEEcMbVJXLbajRNOwZboTq/1i67BALysa6LjImK+s=;
        b=aBYnS+VThRez9lznNmoyJRFgygrq8pGrQtYTP/2GSODlt++DFrf7QTtCV1GdBevEvj
         DqvDObSCdV/2fD4UyafoyrBFjfP3Ryj1C99E18MCyqA8g46ZoiruZwhi2Z+3PtLIIhbX
         cofRXISLK6gF3HEjLKFOdYxqnTFNe5OUveppumV9AWEwdvXwHoT45DP9dRhaHg6WlNNF
         yATbwjNlWE1Ys9fOtfczxaLCiYqRfuOVOtEbx7FPhX/yWM0dZsT7kaLTCQcouA9jod0W
         NOcy8JRNWESNDbj1q6JLTK+++II9rL8G1zpcbhrJAa903x3QJgodNE6yuC4jog6xWPl/
         +hOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686476843; x=1689068843;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IntEEcMbVJXLbajRNOwZboTq/1i67BALysa6LjImK+s=;
        b=UFl5vSef6BUuvXhHDH8MJqU2jE6VE416FmHmhnDyJ3mLZyuLjfIBg41XVjeFsYuJfR
         /2Xns9m39wVG36rfbxorisR06dTRtCqmTr3IinDwTejyIPjnyWuEC0sMe0JAG3NeebKv
         meve6BM4t74hzcL5m2dXmZ1dN+RKpzZYIPDPspXXRYLzLId++3sjFT3rIq7A3Mxr8hMo
         BQDM7G5fnw08MPkXvBSJJfzPPwNOYc0iAgI7WbLFUfJgcAthScB7pzMyphb4Jz1AxwZu
         Udj+7Sj2mZKhmfGm3mV5w+tqcKKxwMhRRtgFSmmdLOgEmdT6+c69d92KxxD8Wzt3cuO3
         zXOA==
X-Gm-Message-State: AC+VfDxF1TDavkwXEv6foAP/6uGV3qX5TW7DGS9QyFXYGLc6HULi0giX
        Bc6ZtB2xrvxveo9eL8OCX1PbAw==
X-Google-Smtp-Source: ACHHUZ5lJ/s3LKjtd4cT7LjyGksIdUWZcHMOoBQ9KT88hyWBydYv1BVEo+MbrlPqC8iBaXlZBZlkZA==
X-Received: by 2002:aa7:dcc8:0:b0:50c:2215:317e with SMTP id w8-20020aa7dcc8000000b0050c2215317emr2727440edu.15.1686476843126;
        Sun, 11 Jun 2023 02:47:23 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id f9-20020a056402068900b0051495ce23absm3696998edy.10.2023.06.11.02.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 02:47:22 -0700 (PDT)
Message-ID: <7e1c9011-241c-71e2-7318-499114d66218@linaro.org>
Date:   Sun, 11 Jun 2023 11:47:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 1/3] dt-bindings: thermal: sun8i: Add binding for
 D1/T113s THS controller
Content-Language: en-US
To:     Maksim Kiselev <bigunclemax@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
References: <20230610204225.1133473-1-bigunclemax@gmail.com>
 <20230610204225.1133473-2-bigunclemax@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230610204225.1133473-2-bigunclemax@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/06/2023 22:42, Maksim Kiselev wrote:
> From: Maxim Kiselev <bigunclemax@gmail.com>
> 
> Add a binding for D1/T113s thermal sensor controller.
> 
> Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>

One patchset per day, not multiple within 15 minutes.

> ---
>  .../thermal/allwinner,sun8i-a83t-ths.yaml     | 20 ++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> index fbd4212285e2..001faa37fc27 100644
> --- a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> +++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> @@ -16,6 +16,7 @@ properties:
>        - allwinner,sun8i-a83t-ths
>        - allwinner,sun8i-h3-ths
>        - allwinner,sun8i-r40-ths
> +      - allwinner,sun20i-d1-ths
>        - allwinner,sun50i-a64-ths
>        - allwinner,sun50i-a100-ths
>        - allwinner,sun50i-h5-ths
> @@ -61,6 +62,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - allwinner,sun20i-d1-ths
>                - allwinner,sun50i-a100-ths
>                - allwinner,sun50i-h6-ths
>  
> @@ -84,7 +86,9 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: allwinner,sun8i-h3-ths
> +            enum:
> +              - allwinner,sun8i-h3-ths
> +              - allwinner,sun20i-d1-ths
>  
>      then:
>        properties:
> @@ -103,6 +107,7 @@ allOf:
>              enum:
>                - allwinner,sun8i-h3-ths
>                - allwinner,sun8i-r40-ths
> +              - allwinner,sun20i-d1-ths
>                - allwinner,sun50i-a64-ths
>                - allwinner,sun50i-a100-ths
>                - allwinner,sun50i-h5-ths
> @@ -159,4 +164,17 @@ examples:
>           #thermal-sensor-cells = <1>;
>      };
>  
> +  - |
> +    thermal-sensor@2009400 {
> +          compatible = "allwinner,sun20i-d1-ths";


New compatible does not warrant new example. It's the same as previous.
Drop it.

Best regards,
Krzysztof

