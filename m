Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0119D3F0A1C
	for <lists+linux-pm@lfdr.de>; Wed, 18 Aug 2021 19:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbhHRRR3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Aug 2021 13:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhHRRR1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Aug 2021 13:17:27 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B95C061764;
        Wed, 18 Aug 2021 10:16:52 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id i9so6086734lfg.10;
        Wed, 18 Aug 2021 10:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vgNL/YukxMg7bm55oBtvyONH8Uy1dCmXD+rKl0KJZ+4=;
        b=aWNGgcB8z2InDXr6LAdvdaoW2x8CYeUuWHd3AgCWJbOwgyDZbX1SSdtkZCd9LRZU1v
         IfB7jsJ5WNoNiPAd71m4tqa31eFIV1XWJVkfosfkA2c8iOpOAgHnxOP+Umk6tnLPaeuD
         zFTYiqQcf3UIWIFj2bsQWT3aHs/7ok0x1oWwrXbsCuJZ6+Dey8Y6WST/bdI/u6vAMVWp
         htf6YIaZFo8BnuwLljU/vOB2BDRZawuqyS/nEBvAZbttcyYj5o5xKI9Dqb+FfMPcy4Q4
         olMMp0EmD83m0Qh7UjqjOn1UF1IMJlXK3kbyDPrL8jwSvvrERW8PV9J+29gQn2e5QIgO
         hO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vgNL/YukxMg7bm55oBtvyONH8Uy1dCmXD+rKl0KJZ+4=;
        b=hwzznwZhPThSzmSn5dqPR4Ri1XwF3zOwUAzYe9KSP48nmTbOaOanrnWWCL9r/OdHO7
         bo699JH7Sdgb2kJ8VptxKn+k7MutgjD8yfufJIw78Q5sWx0oS10sJ2ojAflVvG030E+4
         xRXHx+PgpBfW6EbfTWSDVSW7BJAcsOmuMljZ1MITHIUD/OfUaI3QG1e2UjGmHNH4pjZb
         PQqfsF2qxIkjCNooQonf7VfDCk3Bu00HUgH/ElKnfPZt7O5/oaEx3QL6jZooHKE5ZIBk
         LNZI6DLgwqgV2dod5eAUMmMcYQXEiS9YyTygyDF1OPnx/4yl+lc/phpKaqIBEMaCLTay
         CHMA==
X-Gm-Message-State: AOAM530sny4Ywp6As+gnG/GzSXvf/jkqEeO5HC0V3M/9kmRlNRQs7gYO
        95ChHxq5tR8gWPfx2EkmbmCCFhVJvM0=
X-Google-Smtp-Source: ABdhPJwSW+uafqBwt0YKcEZ0LBXy3yeuH6y6xXlHWB8hnmrEnK92Pi4r+On9LLiAT6Vq9yxNJiR3Yg==
X-Received: by 2002:ac2:5105:: with SMTP id q5mr305235lfb.102.1629307010475;
        Wed, 18 Aug 2021 10:16:50 -0700 (PDT)
Received: from [192.168.2.145] (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.googlemail.com with ESMTPSA id d7sm46016ljq.112.2021.08.18.10.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 10:16:49 -0700 (PDT)
Subject: Re: [PATCH v8 06/34] dt-bindings: clock: tegra-car: Document new
 tegra-clocks sub-node
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-spi@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20210817012754.8710-1-digetx@gmail.com>
 <20210817012754.8710-7-digetx@gmail.com> <YR0SSz7KMh7TwaFW@orome.fritz.box>
 <eff5ef47-e6e0-3e03-cf1a-d931b0f2dc2a@gmail.com>
 <YR033zuYWWLCeYpM@orome.fritz.box>
 <a5b942cb-1611-9ae1-6e89-4b68fdaf03e3@gmail.com>
Message-ID: <a0222ddc-e83f-98d9-c9f1-8edb0ee47c03@gmail.com>
Date:   Wed, 18 Aug 2021 20:16:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <a5b942cb-1611-9ae1-6e89-4b68fdaf03e3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

18.08.2021 19:57, Dmitry Osipenko пишет:
>>>> Also, I don't think the tegra- prefix is necessary here. The parent node
>>>> is already identified as Tegra via the compatible string.
>>>>
>>>> In the case of CAR, I'd imagine something like:
>>>>
>>>> 	clocks {
>>>> 		sclk {
>>>> 			operating-points-v2 = <&opp_table>;
>>>> 			power-domains = <&domain>;
>>>> 		};
>>>> 	};
>>>>
>>>> Now you've only got the bare minimum in here that you actually add. All
>>>> the other data that you used to have is simply derived from the parent.
>>> 'clocks' is already a generic keyword in DT. It's probably not okay to
>>> redefine it.
>> "clocks" is not a generic keyword. It's the name of a property and given
>> that we're talking about the clock provider here, it doesn't need a
>> clocks property of its own, so it should be fine to use that for the
>> node.
> I'm curious what Rob thinks about it. Rob, does this sound okay to you?

I assume dt-schema won't be happy with a different meaning for the 'clocks'.
