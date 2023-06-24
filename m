Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8E473C97F
	for <lists+linux-pm@lfdr.de>; Sat, 24 Jun 2023 10:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjFXI2K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 24 Jun 2023 04:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbjFXI0v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Jun 2023 04:26:51 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E675C3AB2
        for <linux-pm@vger.kernel.org>; Sat, 24 Jun 2023 01:25:08 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-987accb4349so193958266b.0
        for <linux-pm@vger.kernel.org>; Sat, 24 Jun 2023 01:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687595085; x=1690187085;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3/1MyAMnY+Za4p1Z3b6q8vQY3JjDEV6jQ0tLk7ro11c=;
        b=vEp3OTxw3d1bxXmcrGbjPTZvGdATt4kPb7wTR8P+STWcYy+IGxBjmsrwXHlsdl+475
         D3HkXaVWkfKkJd8Y1v8mJIJNd7MKu+DSOBpGH1R/wozFufpVZ4WggR5v+D40MBe1DSSC
         xIxqP9drpnReATR6sXOtXazHadpPvVE4WXYIX8p8txCkuf3z8X9pyH76wlzCm+qOtyk4
         gvPYv/GZefHyoz4e7fucZIFONAUje8+rTmDzHlmEROrBOi8nsQuF66lLuDZBLi0jIYoP
         HsEXJZtaKyd0E+mlUCbFPj9PypWzwjLssl0KqaqVaVTXlEmAzs4cO8YEpP6UmKpo1O/B
         OPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687595085; x=1690187085;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3/1MyAMnY+Za4p1Z3b6q8vQY3JjDEV6jQ0tLk7ro11c=;
        b=NA/LDh0H8Vcb4MM4ORGLmKQQCEgNZBLDnAMKK5PRj8ti1v3yB9WeLkcaeRINYzqrtY
         BwSWhUTCjLOHIPG4g/+ya1K+gTezLeBAjaZvf6VXREuHEC8e6THJa0v3diW+xMJiw5zQ
         8M+1Plg75ZNb2Vtjpq/xyE0lV7gu9xSCP0zgMfYWT+wyAI+1av0TmccsmybM5IJvsf3Y
         3O0ZwigwpQeP1J3esY3pE8TSOoUA3kCwIbdhQUQ7hRqDRllqLbCcS1mg1fPT6Jyns2PL
         E17VRVvMrNcgIpvwgy39aCaGJMelRJlo2voirJe13Y1GWPrZWdNtOcCal59Z59aYjCPw
         VO7Q==
X-Gm-Message-State: AC+VfDyJlAXAjj3PsJzxCL2Fox/P0R2jsQyE0Kgg3jg0yfkln9wa/RGj
        aq1pmw9a5Ba10C9m8SVmrsFTFg==
X-Google-Smtp-Source: ACHHUZ6cYsMw0LIHQWddUSwohWm7hR0wZwIOc//Ha6WVz0kylI9t5vWz4f/hmDOCHTFgPVqzAQ5yVQ==
X-Received: by 2002:a17:907:3f87:b0:965:6075:d100 with SMTP id hr7-20020a1709073f8700b009656075d100mr20942422ejc.39.1687595085678;
        Sat, 24 Jun 2023 01:24:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id re3-20020a170906d8c300b00977ca5de275sm639460ejb.13.2023.06.24.01.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 01:24:45 -0700 (PDT)
Message-ID: <c9cbac9c-40dd-bb40-0d92-e25e767f486c@linaro.org>
Date:   Sat, 24 Jun 2023 10:24:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 26/45] dt-bindings: pinctrl: at91: add bindings for
 SAM9X7
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
 <20230623203056.689705-27-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230623203056.689705-27-varshini.rajendran@microchip.com>
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
> Add device tree binding for SAM9X7 pin controller.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  .../devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt         | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
> index e8abbdad7b5d..5a3be10dcbfb 100644
> --- a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
> @@ -20,6 +20,7 @@ such as pull-up, multi drive, etc.
>  Required properties for iomux controller:
>  - compatible: "atmel,at91rm9200-pinctrl" or "atmel,at91sam9x5-pinctrl"
>  		or "atmel,sama5d3-pinctrl" or "microchip,sam9x60-pinctrl"
> +		or "microchip,sam9x7-pinctrl"

That's not what your DTS is saying. NAK.

Best regards,
Krzysztof

