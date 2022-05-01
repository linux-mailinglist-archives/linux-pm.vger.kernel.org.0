Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3E2516838
	for <lists+linux-pm@lfdr.de>; Sun,  1 May 2022 23:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356654AbiEAVsq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 May 2022 17:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243067AbiEAVsp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 May 2022 17:48:45 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E084BF6C
        for <linux-pm@vger.kernel.org>; Sun,  1 May 2022 14:45:18 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id s30so23317248ybi.8
        for <linux-pm@vger.kernel.org>; Sun, 01 May 2022 14:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Zs9ZXFuA5R/0ymMTjHB7/FZWKOdSvop8pXLfIOyulA=;
        b=jIUUFw/Dk0bJvSpV2KhChXMwtNlLYqsYYK4oY1ZrIaM5CwokwxvKI2nY/2x/UYhhSZ
         cnYvPcNR4I1+2mQEXOx+fTBIepxbMOgfBDYzGHDeV47Jl9VtWIb/nS+yTlzYid021q5y
         4rk1aenFHUTcFpOe8yZyA6PrfG7AdYTLzyJZCxoXrUBdmiOH7kD+EpptUWvO22jzMcIN
         xSCS+MFyhpSsWhXxvfUnHSHIueURSlmIpP3ceYNATHQiGd7mRdyumFBzg7HidVpGXR/K
         HmLBNFjobzv+Lfi/mc0Jdu1mADUOwm6Q+P8Sv4LOYfSplf9TRRKfiG/zS7FqqwYnszNe
         9g7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Zs9ZXFuA5R/0ymMTjHB7/FZWKOdSvop8pXLfIOyulA=;
        b=MijVC+R5Ggb7dSFUiPYr17LrrhEEVjKvcL+Jl5UeoeHMDFYl9AwvJ/pQTkYAbXe4Vv
         c2dTDIPI16qDfSoq3TOqlPDJc/kl7OeixdEuKsO947vlccm7cEHc6EGZxsAtH2mT1Nrt
         vARJ+0pEyaVJOj+Dggpw6ZyqFUJQhoewMUEWz2k3Xfru4ZFmUe1zo0n6srfn2SJQNaIT
         sv4emccuXsnkKi1e5K9B9F/zcUcqoF6+9uRhk6ZFuQM0lMQzXMQNz9RHYXv6KKE6jKsH
         BuXXlYTwZvdzGJyt6DDVXbDrg8TJPb20EAvZwWb+dfhyt+5Icj32QckBubZSAAknOVjK
         Mo7w==
X-Gm-Message-State: AOAM530MUIfWMmZrkKnU9QCRp0j+kVxdo8cpiEoOuOxw1lR5Xr7R6A1+
        VhZ+/VPETrPQbjIGJu81VxByxwzFOcG5Q4nzsNtLLA==
X-Google-Smtp-Source: ABdhPJz9eJE7cneK+kxH13EYMup9tW/2JAXx6cXKgLkzm/eVQ61nD3w0biIeuzEawWWGZ8vTkmgdM3jCm2iwQFey2JY=
X-Received: by 2002:a25:e684:0:b0:645:d429:78e9 with SMTP id
 d126-20020a25e684000000b00645d42978e9mr8658475ybh.369.1651441518148; Sun, 01
 May 2022 14:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220419163810.2118169-1-arnd@kernel.org> <20220419163810.2118169-22-arnd@kernel.org>
In-Reply-To: <20220419163810.2118169-22-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 1 May 2022 23:45:06 +0200
Message-ID: <CACRpkdZsSdOSq=sdxDZMb8QJCRsrxm280RvYzH2Ns9L5+RtU8g@mail.gmail.com>
Subject: Re: [PATCH 21/48] ARM: pxa: eseries: use gpio lookup for audio
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     robert.jarzmik@free.fr, linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Paul Parsons <lost.distance@yahoo.com>,
        Tomas Cech <sleep_walker@suse.com>,
        Sergey Lapin <slapin@ossfans.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Helge Deller <deller@gmx.de>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-input@vger.kernel.org,
        patches@opensource.cirrus.com, linux-leds@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 19, 2022 at 6:41 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The three eseries machines have very similar drivers for audio, all
> using the mach/eseries-gpio.h header for finding the gpio numbers.
>
> Change these to use gpio descriptors to avoid the header file
> dependency.
>
> I convert the _OFF gpio numbers into GPIO_ACTIVE_LOW ones for
> consistency here.
>
> Acked-by: Mark Brown <broonie@kernel.org>
> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Nice use of active low. Maybe I would simply have dropped
the _OFF suffix on these GPIO lines as it can be confusing now
that their active level is encoded but no big deal.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
