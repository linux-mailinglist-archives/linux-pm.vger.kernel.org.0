Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E944754CAEC
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jun 2022 16:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357457AbiFOOMP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jun 2022 10:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344753AbiFOOMO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2022 10:12:14 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622BD49C98
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2022 07:12:12 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id r1so10502402plo.10
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2022 07:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PSomTQVyd5zCOSWAzm7waWbc5IfqLdcXJ5U+xrQfg4Q=;
        b=JKOf4C3mU+7shCFVenrMS4Wj7l56t/FZ8+1fD+KZLyud9Gmhi1KVJLmx/yeVS4Z5qQ
         3ZfaTwMwieN6KHMfdOs+wULYba0VSwFb+Wtrl9TzX0ogKPumROJnMkhWDCRvaQssRO3C
         2hBAaf3YPunbsfgw3sEfW5R84IPWQFh8SCvWNYI564o+HAadpNKfbnE6vQ/0uh2Yj+Fo
         02+a4pGUnWVelGszUXVHdK+3Sb4LzGG+oXgkNLOKD0j95sKH1ux/Y+J+ApcZEFjxQYu/
         9prjMT4Rc7IXqPAcOsirAh6uVPaaNHtBuDnAt1Z49+foVtidvqXpOkBpO1QEsiRu5cOz
         dqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PSomTQVyd5zCOSWAzm7waWbc5IfqLdcXJ5U+xrQfg4Q=;
        b=f4J0nczUdFtQbiYzoGKY5UdW/91Dx59mNPSI1R99m/vanlHsmL+gZW21oOSC5HCcZf
         Ytac8eKszMGxek7JPgqwsG0mmhVpRyWU7sAioB6Zqx8VjO8IrQ7fE9tUI8cDfGNSGK5o
         4YrTf5RME1BidpiAj7eZGKQ399/BgnMIwsl+4dgMuVj6DQeNPg8Co50g3sLXGLwuYxBL
         s4j3CBWiuLZCGCHxxp5pevdh0of6VU1hzbJL0j1A69h1lHtf9J/2uXEPLjjlLD0r1kaw
         wAkCc13h0gQ0qR3eizY584WmXCUpWYIa042ip0W8KGGkyh3nmnkdVnQm+1N7RKrZLe4I
         p86Q==
X-Gm-Message-State: AJIora/zN77WHP/OrhWuk4z5rUqxR38555nhDjAqLsrZZOI4HELOQMbb
        qHuEMuMwj3JL0aOlDwDSFDHx6Q==
X-Google-Smtp-Source: AGRyM1t9yqcERxo31E4JOAQBo9v99YY2GKrNMpkjyDZISFSuX75m4TYnlJf5X4I9UYsCHexBw+Mw5g==
X-Received: by 2002:a17:902:d718:b0:168:d9df:4f1c with SMTP id w24-20020a170902d71800b00168d9df4f1cmr9773830ply.41.1655302331863;
        Wed, 15 Jun 2022 07:12:11 -0700 (PDT)
Received: from [172.20.0.255] ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id ix6-20020a170902f80600b001640e9f638esm9380498plb.51.2022.06.15.07.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 07:12:11 -0700 (PDT)
Message-ID: <5f30dbcc-cfc7-2620-43fe-6d41d5125f38@linaro.org>
Date:   Wed, 15 Jun 2022 07:12:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 01/14] arm64: dts: freescale: imx8qxp: Fix thermal zone
 name for cpu0
Content-Language: en-US
To:     Viorel Suman <viorel.suman@nxp.com>,
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
        Abel Vesa <abel.vesa@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Liu Ying <victor.liu@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Peng Fan <peng.fan@nxp.com>, Shijie Qin <shijie.qin@nxp.com>,
        Ming Qian <ming.qian@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     LnxNXP@nxp.com
References: <20220615105834.743045-1-viorel.suman@nxp.com>
 <20220615105834.743045-2-viorel.suman@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220615105834.743045-2-viorel.suman@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/06/2022 03:58, Viorel Suman wrote:
> From: Abel Vesa <abel.vesa@nxp.com>
> 
> The proper name is cpu0-thermal, not cpu-thermal0, so change it to that.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Your SoB is needed.


Best regards,
Krzysztof
