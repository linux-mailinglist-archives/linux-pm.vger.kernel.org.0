Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790D273C78E
	for <lists+linux-pm@lfdr.de>; Sat, 24 Jun 2023 09:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjFXHxU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 24 Jun 2023 03:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjFXHxR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Jun 2023 03:53:17 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14FF2940
        for <linux-pm@vger.kernel.org>; Sat, 24 Jun 2023 00:53:14 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51d80d81d6eso194057a12.1
        for <linux-pm@vger.kernel.org>; Sat, 24 Jun 2023 00:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687593192; x=1690185192;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hr9nrGlYrxN00jEwRxs6PYBUQxgnGyvMLv6d+S+IyFk=;
        b=LQEc0yoJm0GslpUZYCjcHtwoTCvu+59CHRYP/sGpmh7IIEWYyKbcmwOTWkHIAk5amo
         GW/7Gpe870PqzwscCvwhvS2tRdD4lIO92N5a+9t0YvyTUExmCh3G/ey+cNZCCGzcBTPJ
         6yPMwkjqsKsodsXDqWTZBNezjTKe+7X8fdEpM8mYCN9NPvWn/peXOWQ5kyvKsBiKcO44
         1nn5gapVl7Ro8gQLfw1L+9piaUTX+p6FPVZZ1/ijnscvD92eH3mJCbstLfuZt0gY2UUX
         +QldvphwJQ8glfg3JyKVOgSk3y2EQry5UIdVnMeV03t88wxPGoe0khhNc6S3VhqB4zja
         Bt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687593192; x=1690185192;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hr9nrGlYrxN00jEwRxs6PYBUQxgnGyvMLv6d+S+IyFk=;
        b=PsXCCRJlYPg/rCPqPt85ymNxBsRu3+2Cyz4b7DCxUesO61H42DT7ikvjGSGXMNF13C
         lLysVt2WTKsZ14ooqf779y5XJ8tlcOGc1L5gwIUdplKls0P1NQiuiayk+7qxArhk4xt2
         C2ZYBqKEa95K1g1+Lxv7slvtPfHiOYGYog9X8YdeYpuOOrtg2GIZY1xiLI5FSMHbjXzo
         qmrgtC4xhQYf/PTJv8JH+n8GOnYmreazrBsIXks5T88UY07j3F3v+p3ytLq116kmuh7U
         fNKO1nhX/YL9tS0mr3vkYr8vCQI1RS//vDpfl3kWTe2D87/RLeSNbpgb+GzVVcCv+GNr
         je9w==
X-Gm-Message-State: AC+VfDyfjCn8j1qqxhlPNhGJ6r4W3hi2bBJEU78p7l4qq9JfoB/USljG
        LblVQV30vviuASZwd7t1wirG9A==
X-Google-Smtp-Source: ACHHUZ522CJYVOfO8kVotsUuEt+wtHkNFHrIi0PS6ACNcKvYFOPHzOCYWLySAcxpXgHfsNodLNJqrA==
X-Received: by 2002:a50:ef12:0:b0:51a:f6de:bb81 with SMTP id m18-20020a50ef12000000b0051af6debb81mr10804337eds.28.1687593192613;
        Sat, 24 Jun 2023 00:53:12 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id m5-20020aa7d345000000b0051495ce23absm404938edr.10.2023.06.24.00.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 00:53:12 -0700 (PDT)
Message-ID: <074048a2-5153-e013-3562-b5cad2ba0954@linaro.org>
Date:   Sat, 24 Jun 2023 09:53:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 01/45] dt-bindings: microchip: atmel,at91rm9200-tcb:
 add sam9x60, sam9x7 compatible
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
 <20230623203056.689705-2-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230623203056.689705-2-varshini.rajendran@microchip.com>
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
> Add sam9x60, sam9x7 compatible string support in the schema file.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  .../devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml | 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

