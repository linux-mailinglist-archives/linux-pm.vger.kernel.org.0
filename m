Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3B7721E29
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jun 2023 08:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjFEGfP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Jun 2023 02:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjFEGfO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jun 2023 02:35:14 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A345E9
        for <linux-pm@vger.kernel.org>; Sun,  4 Jun 2023 23:35:13 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5151934a4e3so6558681a12.1
        for <linux-pm@vger.kernel.org>; Sun, 04 Jun 2023 23:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685946912; x=1688538912;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HAkCrvHOWXDqwj1iMGZRedd16rhqvqKQgu07G0b3u+w=;
        b=e7E3JztSPDwCFOVrzxyEbVKg2EBeBOYgZaTU4BRpwJs1h7uHWXDo+l4Zk5OwWH3gxO
         EqYoWrI2nluRnjKjwdlqLEnBcCpOkMVsq/NL07i8ATGoappT2Y7Iu+bHCO+sxDx/d6PF
         m1yW2VgipEcnRLFaW68NCN+FFcFIJPbw/eYHR3Y07vtSoQ9V57ZsG/OrkuBfp0zcE7uO
         mUMJdZb3Ktm56WuGjYfV4znaUsZVjWccpeON3w72rzjU7HO+wQmcEKdi3vZPb9spMHEO
         MAxQO8sclY35BjwjlYS1iRkx51Kv62cQ0tFvY3zdkd4n9Jlo0VDzxWWtcb/m129XFaB6
         19jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685946912; x=1688538912;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HAkCrvHOWXDqwj1iMGZRedd16rhqvqKQgu07G0b3u+w=;
        b=Ru7t65CS+CJNJUWb7n4CigwmWfSLFQiq0H8G0oCE8pIMA6zb7wyNiYpPhuW1+VU2lZ
         3zcArAUsBu+XIuIz7L25zV9vwHtBEIQcVeWov9SMbTTqaf4jOfMkeTb6Ry8rgAXrPIUo
         6JYbRB7Nac9vPpGC7QP0Lc2vQFw8J5ZwCdFlsXSiEpynXZUxhraRREL2M3BfQlexkKDg
         /VhlPaoA23lw1Z8BDMloQ8jTANp2AqWeRPJY+0/et4l33F9JdbnbfPOPv9b63gZLta95
         XmI4s7kbgm+ouunzogTaNhaA5hlse2XGeviYoA16krRUJAiWsEAH4NmivDl/msddOUw0
         fX5g==
X-Gm-Message-State: AC+VfDxqLA51gTrL0eNGk8A4c1s50tgpuIKAq1QLotFE+wn+Y+mLeVTg
        ID+jXAGC+RPr/f5EmUXS6JOFoA==
X-Google-Smtp-Source: ACHHUZ4BgooRJqWw2thRF8QqkzdRcCJ+hGa1VmZ7YEgpaG6Ikj580m9cbKbqSO9oirFRyquUlSnLew==
X-Received: by 2002:aa7:cd10:0:b0:513:53f7:8ca2 with SMTP id b16-20020aa7cd10000000b0051353f78ca2mr6734317edw.9.1685946911857;
        Sun, 04 Jun 2023 23:35:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id v1-20020aa7dbc1000000b005163a0f84a1sm3636951edt.48.2023.06.04.23.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jun 2023 23:35:11 -0700 (PDT)
Message-ID: <c72f45ec-c185-8676-b31c-ec48cd46278c@linaro.org>
Date:   Mon, 5 Jun 2023 08:35:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 01/21] dt-bindings: microchip: atmel,at91rm9200-tcb: add
 sam9x60 compatible
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        tglx@linutronix.de, maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        gregkh@linuxfoundation.org, linux@armlinux.org.uk,
        mturquette@baylibre.com, sboyd@kernel.org, sre@kernel.org,
        broonie@kernel.org, arnd@arndb.de, gregory.clement@bootlin.com,
        sudeep.holla@arm.com, balamanikandan.gunasundar@microchip.com,
        mihai.sain@microchip.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Hari.PrasathGE@microchip.com, cristian.birsan@microchip.com,
        durai.manickamkr@microchip.com, manikandan.m@microchip.com,
        dharma.b@microchip.com, nayabbasha.sayed@microchip.com,
        balakrishnan.s@microchip.com
References: <20230603200243.243878-1-varshini.rajendran@microchip.com>
 <20230603200243.243878-2-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230603200243.243878-2-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03/06/2023 22:02, Varshini Rajendran wrote:
> Add sam9x60 compatible string support in the schema file
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  .../devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml  | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> index a46411149571..c70c77a5e8e5 100644
> --- a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> +++ b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> @@ -20,6 +20,7 @@ properties:
>            - atmel,at91rm9200-tcb
>            - atmel,at91sam9x5-tcb
>            - atmel,sama5d2-tcb
> +          - microchip,sam9x60-tcb

No wildcards.

Best regards,
Krzysztof

