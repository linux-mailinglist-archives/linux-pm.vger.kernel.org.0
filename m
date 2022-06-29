Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50F756089B
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jun 2022 20:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbiF2SGj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jun 2022 14:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbiF2SGW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jun 2022 14:06:22 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC16740E78
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 11:05:03 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id h23so34096225ejj.12
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 11:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=QSfgLXgFfiGaok0lJdcTWMoQDlToXF+BRlTaDwPiloE=;
        b=MeoRgOZVtDqrD1BXTHuzWUgHKg59UHeJcfZILwn01ko3si8mEmIRSF7PZGoMYFnpSe
         UPsJMrSHsVVgvuYWA0BkwQVKseCCL7fdZVk7qASBp2fBqik35D7ADK09VSAG4NXgTMMd
         Fn7MvZjStPJVT/IB0yqIlKwG2m8zdfi3lBLCMd2c70R/w3jeikg5+J0oxqeNIgv9J0SK
         FzEBOO4wjBzWSc18UAp+xZ6uusQZYAb7snw/6MCIznSFGO0tPrjNxAoB4fM4KMLT/8NI
         ohW/Jc+N5MWrwvDMCsUcl81gFhKH/4lI/zzm34r2TWSmE+LzbeEPWfJBwPsGyTN7jlEN
         XeLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QSfgLXgFfiGaok0lJdcTWMoQDlToXF+BRlTaDwPiloE=;
        b=dBYmoysIvrfh6eEkqHjUEDg1tUZ8PK34Oioon/dAnyIEmDvv/ns3VL7Xmd8M4804YY
         mX2SfDy9tQxozhsnMeVJKXQZC6ksZP1htTjaKcWUknxTw2cVFiwy9qQqnaS5tBnNbJxo
         CVWVtJAmPd7bur6CbKGMq0RGipPk4BRe/k4KJSJziuO0mFycFS8eTsax9yd7nh3q69iW
         oxzD+dEy48FHR+gbhQaRC48Lst1p0gEpp//JXX1b1bknHfM2q/V2FKmpyt7neQoCt5hU
         Fa+9hz94fZOIsgJenVWrprP6vXlBtxzH+1iu/xEcVvaH4mfUmW3NPpmVOtae2k+HXtrG
         ZAXQ==
X-Gm-Message-State: AJIora9geAMDP0YJRwAVRUDXP1ZN4bILiwG93mx4A1KMch3zH5cmE/ih
        9rSCQ864h0neWmzJpmCMIpLkxw==
X-Google-Smtp-Source: AGRyM1uveF1FWSHXgBj8uURIFKTL+sgiRu8h6GV4IGO4002y0D6+mokBlHcmA5uQEoUy6sKdGRLgwg==
X-Received: by 2002:a17:907:3f82:b0:726:3732:961c with SMTP id hr2-20020a1709073f8200b007263732961cmr4751329ejc.727.1656525902194;
        Wed, 29 Jun 2022 11:05:02 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n6-20020a509346000000b004319b12371asm11957216eda.47.2022.06.29.11.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 11:05:01 -0700 (PDT)
Message-ID: <392186b6-d5cd-ec6a-ca98-c02a824eaa7c@linaro.org>
Date:   Wed, 29 Jun 2022 20:05:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 11/14] arm64: dts: freescale: imx8: Fix power
 controller name
Content-Language: en-US
To:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Liu Ying <victor.liu@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220629164414.301813-1-viorel.suman@oss.nxp.com>
 <20220629164414.301813-12-viorel.suman@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220629164414.301813-12-viorel.suman@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29/06/2022 18:44, Viorel Suman (OSS) wrote:
> From: Abel Vesa <abel.vesa@nxp.com>
> 
> The proper name is power-controller, not imx8qx-pd.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
