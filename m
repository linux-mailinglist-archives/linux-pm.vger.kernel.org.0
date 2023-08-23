Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8EF785531
	for <lists+linux-pm@lfdr.de>; Wed, 23 Aug 2023 12:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjHWKR2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Aug 2023 06:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbjHWKR0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Aug 2023 06:17:26 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2868210F3
        for <linux-pm@vger.kernel.org>; Wed, 23 Aug 2023 03:16:56 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-523d2ef19e4so7009284a12.2
        for <linux-pm@vger.kernel.org>; Wed, 23 Aug 2023 03:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692785793; x=1693390593;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PkhmhhTWHkeRQp2PPUUxTCXWp1T0OTe7aVdp4fg5upo=;
        b=LO6EWlz79jJJ9v/UQCg4OZKmPJO9+j6QHM1tngs1xZjP73VY2yTNyozqbCEjmHkgOJ
         /I25kU9siRPAlFrz9dpUhrfTb7C4hK1nJcapsvmczx4ZFMRu+Id4skeNROqiKQ5j7fC1
         ZyyN0rEkpFnovXZ/Y9YFpI+20NzFPUlKW8oib55lhQS8AfgOyDR1cSStWeGIk4mOE/f8
         e8jk+ITZo8/vSFO72g6rBQt9NS7/HQQrfF/hlcYS6bEX+Ay7j17UK9K0sHHCYLh/aFQD
         moxfheS5gy+jsjw+9CZRAFxsIYJOD76OVSKpIkrcpc8QGv+VCkZ89LVZ+6AtV/ge1cjC
         e99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692785793; x=1693390593;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PkhmhhTWHkeRQp2PPUUxTCXWp1T0OTe7aVdp4fg5upo=;
        b=haUVlj9tkd03CUD5ps9Vz1HU7aTSyY8x2b8vrDuWhnc5iEbzAI7OxCWv+gF5VGT0Zq
         eaawqj2GJ8v2sE7XpG+r1JZA26igUrhco9e6L2kd1MBG3NVw/6LWuasN/g3RfXL6bgWl
         1lAAwXROOavLTFmfAa1Ig+n8EaTYLcZMTBJuMdTt49fSvSx3yUETmAjC9yD8+pjXkMRS
         C5sZQCk5Q+5uL7J5VqV3BdlK6DvPCVJj87r+xS2S1sFrw5TAG1Hbe210+UeOam9kSHlr
         Rg9znDkk6vLSEguWWyzoLdY5km8s6sT1a4CrXvFdMXoaMYWk1ctQYfFdm1ism5Xgn7EL
         fRpw==
X-Gm-Message-State: AOJu0Yykv/oQDQjyqQjF8YHYghHouluUwzQUWVaa0ArXQbICIBARA9AY
        bPvPNvJKwtj7KWKPy1mTwFYxsg==
X-Google-Smtp-Source: AGHT+IG4cl/3Fz/QSS2cl3WXZt2VKfaSb/kNTKY6FTxfUyaMgKaOK/vEjbIWyu1Ae6CwwBgVchcQyg==
X-Received: by 2002:a05:6402:1614:b0:522:1e2f:fa36 with SMTP id f20-20020a056402161400b005221e2ffa36mr8763754edv.28.1692785793520;
        Wed, 23 Aug 2023 03:16:33 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id i15-20020a50fc0f000000b0051e1660a34esm9063699edr.51.2023.08.23.03.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 03:16:32 -0700 (PDT)
Message-ID: <61b9e036-7864-65c6-d43b-463fff896ddc@linaro.org>
Date:   Wed, 23 Aug 2023 12:16:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 29/42] dt-bindings: rtc: Add ST M48T86
Content-Language: en-US
To:     nikita.shubin@maquefel.me,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Lennert Buytenhek <kernel@wantstofly.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Lukasz Majewski <lukma@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
        netdev@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-input@vger.kernel.org, alsa-devel@alsa-project.org
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
 <20230605-ep93xx-v3-29-3d63a5f1103e@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230605-ep93xx-v3-29-3d63a5f1103e@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20/07/2023 13:29, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> Add YAML bindings for ST M48T86 / Dallas DS12887 RTC.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

