Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9782773C7FF
	for <lists+linux-pm@lfdr.de>; Sat, 24 Jun 2023 10:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjFXH77 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 24 Jun 2023 03:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjFXH7x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Jun 2023 03:59:53 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19C72960
        for <linux-pm@vger.kernel.org>; Sat, 24 Jun 2023 00:59:44 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-98bcc533490so162448566b.0
        for <linux-pm@vger.kernel.org>; Sat, 24 Jun 2023 00:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687593583; x=1690185583;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FTjB3MUThuy0fH56tPu8r2SapKpsQyQgWZ4G2iu3Iz8=;
        b=HEwevcjVQu+8yO3NUrkkTGxP0CcIpGsLiEQXCTRo3UkbkAEAAtNC0UlY9ftejwavbS
         WPfQTRQVl1GcrgXT/jwnimlNGGTxk1BasUFrZ0+zaXN90t4zsCJHF8eP/rzPh9y7q75O
         DrmxzN2V5bro/a7Yjn2JaR+shcHxeMnMBPEOsxKHS90sJWabsHm/pELi2kj5UnO7u9RD
         LnX93Xk9EYFZE7c3mDCbNFjt6xfev1h30nRmSxtXhBhzhBmUqIahBD/KcUlZwriKT34w
         oFkzPzPGaxAQxWKiI+DomOOYGd+hKHvLudnuiUccthDx082FzhV3uj+CPG6toFmF8/Bz
         rhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687593583; x=1690185583;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FTjB3MUThuy0fH56tPu8r2SapKpsQyQgWZ4G2iu3Iz8=;
        b=ZhYadrM3+LrgT+htTpBp2V4YqAQI7ICqqC0ekTyaTk8/JjKHz03P7s/W8EwlJhe4GC
         cTdxZvgfYTq3RBBZSuPW8j0VXFXxxCz2OQdtBkclYxDQMZuVW6p4oyErdpWDG9zEdRgc
         BpRMIkwDfmMdir/HJGzddtWbYcMSPEf2iu21IoyRK0IsZzqas0Vvjj4AGda1HhTUrXS/
         rHk/UiCxW505O7/sRvVZo0p0ro2gNcfKNSiZQLhplwrSlM/wM6P/0HaUb6mBj2WC4Igc
         9AC6g17o5w/kv1JnGXUX66gi6kpzbA0SQopV9CO7bVT05T4H1eVj2x4eSwDsLx5ZcFNJ
         DwIA==
X-Gm-Message-State: AC+VfDzW17/r/yViardR9AA5Nx+IaI6JOvveWdqiBZmcHAfl2zhESAs6
        ZnZIQG1XF7NOfCeziD8wqeaFRQ==
X-Google-Smtp-Source: ACHHUZ5pRd8UNSYc52Q0vkUp3nRCIrlMv+cEYLJxjAGxSYuFwmJusDkYkiVv0idqnJteffrCHMZ8Sg==
X-Received: by 2002:a17:907:783:b0:988:dced:f339 with SMTP id xd3-20020a170907078300b00988dcedf339mr12750156ejb.31.1687593583035;
        Sat, 24 Jun 2023 00:59:43 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id t23-20020a170906179700b00987f64b84afsm597458eje.39.2023.06.24.00.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 00:59:42 -0700 (PDT)
Message-ID: <7c0025cc-ed36-f4e1-d48d-d09326756d89@linaro.org>
Date:   Sat, 24 Jun 2023 09:59:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 16/45] dt-bindings: crypto: add bindings for sam9x7 in
 Atmel TDES
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net, vkoul@kernel.org,
        tglx@linutronix.de, maz@kernel.org, lee@kernel.org,
        ulf.hansson@linaro.org, tudor.ambarus@linaro.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linus.walleij@linaro.org, p.zabel@pengutronix.de,
        olivia@selenic.com, a.zummo@towertech.it,
        radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com,
        broonie@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, sre@kernel.org, jerry.ray@microchip.com,
        horatiu.vultur@microchip.com, durai.manickamkr@microchip.com,
        andrew@lunn.ch, alain.volmat@foss.st.com,
        neil.armstrong@linaro.org, mihai.sain@microchip.com,
        eugen.hristev@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Hari.PrasathGE@microchip.com, cristian.birsan@microchip.com,
        balamanikandan.gunasundar@microchip.com,
        manikandan.m@microchip.com, dharma.b@microchip.com,
        nayabbasha.sayed@microchip.com, balakrishnan.s@microchip.com
References: <20230623203056.689705-1-varshini.rajendran@microchip.com>
 <20230623203056.689705-17-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230623203056.689705-17-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23/06/2023 22:30, Varshini Rajendran wrote:
> Add DT bindings for atmel TDES.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  .../devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml   | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml
> index 3d6ed24b1b00..0e71bfd32a1c 100644
> --- a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml
> +++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml
> @@ -12,7 +12,10 @@ maintainers:
>  
>  properties:
>    compatible:
> -    const: atmel,at91sam9g46-tdes
> +    oneOf:
> +      - items:
> +          - const: atmel,at91sam9g46-tdes
> +          - const: microchip,sam9x7-tdes

Same as in other cases, so just to avoid applying by submaintainer: not
tested, broken.


Best regards,
Krzysztof

