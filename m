Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E37F516852
	for <lists+linux-pm@lfdr.de>; Sun,  1 May 2022 23:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236187AbiEAVuY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 May 2022 17:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357562AbiEAVuU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 May 2022 17:50:20 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA7518B3B
        for <linux-pm@vger.kernel.org>; Sun,  1 May 2022 14:46:53 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id d12so23321272ybc.4
        for <linux-pm@vger.kernel.org>; Sun, 01 May 2022 14:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zq6K9saDLXhP7BxFMvj2X0QgCPUGvX8QgZ62vdX2sZo=;
        b=b56QSIAKajlp3SMBgHss1IzdehuBQLfOOUe4Tfk2wceg5aZOjhyzaAraZSsRsxoepB
         T8YTKh87idYcNsip2eky0LkWSFfYqfwW21PmXYM1S2L9+no2J2ueA//PZMIBEo+aPJtN
         1HuPxtMchjnz1+D/wg35eGRHOIgXhYznfLxLdDusr7/th/+x0czHh2iIS/fDbKmDbc3Q
         dobiOYYNRhRmCfl2HdzBFzUiAbktvGtKUiWDjWg7LMESnVhrwKPd5lAj0RCS85mNJsLv
         KuXCagsd5iWRaUpEEL7oM08GkKdfGS32T8WUWK4KU2O3dMa62pyQCJ13DoPOuiHI9xnu
         Os7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zq6K9saDLXhP7BxFMvj2X0QgCPUGvX8QgZ62vdX2sZo=;
        b=ltKq+koxAN83RhgJAXZQ0hinm1a6/Hme8GzSdXCcjMlY4ccqlDml7fv+X2qAPQr6kK
         cV03Jsnp6fxgjivE/NqB68LVnmTlr9RDeKJn3y2XY89jNN32ywEDfe6LLnoQs3Y97TEr
         yUezyoXccZHB3JeLxolbuff0zBhMrSlLQY7VhEPq5D1G5t5kq7sumammFrPe4vzF0ueu
         IfNFjnGv3J4fLTHqxFAtRwLJJrcCn1F8FKux/n9LoH1DXDpPBCMST2A6PXbqJTFZp6fy
         fpnyPR25Uyj7O86suPBYCpbh7zGn9qZyXg65bGlJWF2JH7K433RVLO8ltN/jbGtRm5In
         T4Og==
X-Gm-Message-State: AOAM530RIZrNAMeIz0cQou6/zpYReDtD/TU6eLp2exHXKD6MxBj9MZJI
        AlgiLg+DfN2CV4KxfpUEkh6ABwEQzfTsZ+IxDdOFhg==
X-Google-Smtp-Source: ABdhPJy2G1jdmYo0heXLaVkR+a7vuNFN5u4CZrDYPU1PhfEKz0BCtaze6Mx718uPeKKIvck5ypqKaqItjLfZ41hpEHc=
X-Received: by 2002:a5b:451:0:b0:648:2a28:973f with SMTP id
 s17-20020a5b0451000000b006482a28973fmr8652903ybp.291.1651441612710; Sun, 01
 May 2022 14:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220419163810.2118169-1-arnd@kernel.org> <20220419163810.2118169-24-arnd@kernel.org>
In-Reply-To: <20220419163810.2118169-24-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 1 May 2022 23:46:41 +0200
Message-ID: <CACRpkdZPgobmsrAggERHw9f0VJV__Q6TL+DdU6sFd-io8feYLQ@mail.gmail.com>
Subject: Re: [PATCH 23/48] ARM: pxa: magician: use platform driver for audio
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 19, 2022 at 6:41 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The magician audio driver creates a codec device and gets
> data from a board specific header file, both of which is
> a bit suspicious. Move these into the board file itself,
> using a gpio lookup table.
>
> Acked-by: Mark Brown <broonie@kernel.org>
> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks good to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
