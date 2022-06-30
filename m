Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7226B5621A2
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jun 2022 20:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236130AbiF3SBu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jun 2022 14:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235699AbiF3SBi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jun 2022 14:01:38 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7873338BE6
        for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2022 11:01:36 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z41so9051307ede.1
        for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2022 11:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oP65LAT/fd0C6OnRp3Ub9OQHA8VbKhPvXbniEJ3nVeM=;
        b=okhkRQ59JELGFs++y1bGscG5q+VXfKQlxDjG9RGRLYXwjDJN/mCw0UvDSDhJahe+lg
         kpEd0AdWlbeQcdPmXaBpHZztPo5tSKlkHwcZ9Om/U7Iv0l2AKOHwf7gBjJfy8Jm3CDOg
         8rdLIRAWUmria9z0tixF4TJb2UB/WJ0sL7nkFpkzp70XkHp0vtgpLLGmbUXSEbbQNsEl
         Q5wxyUrRxovbmuzBYy895n3/qV3cjBv6E7TfaV47hI1ctNj4KUoHX0+ZgIi5gGadU72h
         tVJ+P7eIPxKgVjTGnmuRJVRdvpAlvX4cLZhPcPpdaTE/srih/ygqYivQkaEXd87YGLnf
         E17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oP65LAT/fd0C6OnRp3Ub9OQHA8VbKhPvXbniEJ3nVeM=;
        b=o8htAF4lE7PmcpAyLfhXKRkAfshTb5+eVf97d9ZKJHWfgxHes9tx2jcRKjsmQPueGA
         QFeM8M5pPsVeiuUuEKkZ8o4S/rJs3WYIzIWlOoxqbe/zZICvz1WOGfn3bmaNe9yjclev
         g7JLYx85fCxsVv73/STc5zv+9+blAc2Prb/YEcDxVXzOuVOcIzadcBFRGM5l6kPfwCqP
         txOpVDvFts6m6E2h3dAmTzqnHtPsGvxZmg4XIRcypqG5DIkCr6tlDNEO9OKecKCv3TZV
         0E/oceCMAFzE5UyJ4y0OLqt+1KmmAGQKDlXr1Ek9/jH7D+S7dwtIcS6iBHzYt48LAnxq
         x//w==
X-Gm-Message-State: AJIora9i7gxAC2yHqK9meKBeurTwNtSiQH9uucKnM3/f/eQIDu1TSq/V
        616cnORsVgH+Z0fWFlU4cAzeAg==
X-Google-Smtp-Source: AGRyM1scmyht18TKC54qdhLFMpF/tV95/vYdn9nuKK0yCFXvLEMAhyAbNUUh6YAaGoMZvqq3eZSgKg==
X-Received: by 2002:a05:6402:2c4:b0:435:8ce0:aef8 with SMTP id b4-20020a05640202c400b004358ce0aef8mr13310561edx.140.1656612095033;
        Thu, 30 Jun 2022 11:01:35 -0700 (PDT)
Received: from [192.168.0.190] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id kt26-20020a170906aada00b00726dbb18b59sm3626737ejb.130.2022.06.30.11.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 11:01:34 -0700 (PDT)
Message-ID: <5d8b2044-5ca6-c90c-57b4-afbb2ae20dde@linaro.org>
Date:   Thu, 30 Jun 2022 20:01:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 10/14] arm64: dts: freescale: imx8qxp: Remove
 unnecessary clock related entries
Content-Language: en-US
To:     Viorel Suman <viorel.suman@nxp.com>
Cc:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>,
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
 <20220629164414.301813-11-viorel.suman@oss.nxp.com>
 <483d5115-4027-e811-8bce-15da6c7c660f@linaro.org>
 <20220630083636.2c7mclmbq3tjma2j@fsr-ub1664-116>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220630083636.2c7mclmbq3tjma2j@fsr-ub1664-116>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30/06/2022 10:36, Viorel Suman wrote:
> On 22-06-29 20:04:43, Krzysztof Kozlowski wrote:
>> On 29/06/2022 18:44, Viorel Suman (OSS) wrote:
>>> From: Viorel Suman <viorel.suman@nxp.com>
>>>
>>> "clocks" and "clock-names" are not used the driver, so
>>> remove them in order to match the yaml definition.
>>
>> So this explains the unexpected change in the bindings... but actually
>> it does not explain whether it is correct or not. Just because driver
>> does not use it, is not a proof that clocks are not there. In different
>> OS/implementation this DTS might break stuff, so basically it is ABI
>> break. DTS should describe the hardware fully, so if the clocks are
>> there, should be in DTS regardless of the driver.
> 
> Hi Krzysztof,
> 
> Both XTAL clocks - 24MHz and 32kHz - are still defined in DTSI files, see for instance in
> arch/arm64/boot/dts/freescale/imx8qxp.dtsi :
> ---------------
>         xtal32k: clock-xtal32k {
>                 compatible = "fixed-clock";
>                 #clock-cells = <0>;
>                 clock-frequency = <32768>;
>                 clock-output-names = "xtal_32KHz";
>         };
> 
>         xtal24m: clock-xtal24m {
>                 compatible = "fixed-clock";
>                 #clock-cells = <0>;
>                 clock-frequency = <24000000>;
>                 clock-output-names = "xtal_24MHz";
>         };
> ---------------
> Both can be seen in /sys/kernel/debug/clk/clk_summary once boot is complete, both can be referenced
> in any DTS node, so there is no ABI break.

ABI break is not relevant to the fixed clocks being or not being defined
in the DTS. You have a device which was taking the clock inputs, so the
clocks stayed enabled.

Now, you don't take these inputs, so for example the clocks are getting
disabled as not used.

> 
> "DTS should describe the hardware fully" - this is true in case the OS is supposed to controll the
> hardware fully. i.MX8 System Controller Unit concept implies resources being allocated and managed
> by SCU, there is no direct OS access to some hardware. SCU actually defines the hardware environment
> the OS is being able to see and run within. SCU is able to define several such isolated hardware
> environments, each having its own OS running. So, in this particular case - i.MX8 SCU concept -
> DTS should describe the hardware from the perspective of the hardware environment exposed by SCU to
> OS.

OK, that sounds good, but the question about these clocks remain - are
they inputs to the SCU or not.

Regardless whether they are actual input or not, you used not
appropriate argument here - that Linux OS implementation does not use
them. The proper argument is - whether the hardware environment has them
connected or not.

Best regards,
Krzysztof
