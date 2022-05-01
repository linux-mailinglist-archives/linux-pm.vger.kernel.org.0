Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203C7516809
	for <lists+linux-pm@lfdr.de>; Sun,  1 May 2022 23:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355155AbiEAVhy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 May 2022 17:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbiEAVhx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 May 2022 17:37:53 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8473C726
        for <linux-pm@vger.kernel.org>; Sun,  1 May 2022 14:34:26 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id w17so23282455ybh.9
        for <linux-pm@vger.kernel.org>; Sun, 01 May 2022 14:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XHDe8NwwI9SjN9yPCfdFZVh4P/kcPQDXEmbvi28Ry+g=;
        b=UhniDGJRP7jnhKBKyFEU7Wm1oj19NfJgHgLTwiUZocIMzFuZcy6/C6VzBVOL++cBvj
         LrIdaNUAfF6A3gJNASrFvHnAKvQMpgaI3a+ALVbDTJ8eikxSpYzLlQUmI4nPbtXjDg4D
         61l+wu6AHbkliq+H0f8Ajl6wMDIrIDWbHXSKpPcelWQXQMMNGkpdczkhdkUi7iNKqqom
         f4kY22N5GzwsoRBTgxLB4z0sMMH1XkpdSeUqQXDWgVrNldazzOzczD605y1f7K81V1C4
         4ugAXmyrIfWO1yaViycscWtZgLZGrFY+/HbQHeYpwIpBVHoKMccEQ7oDjW2RE/A2D6ol
         0zew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XHDe8NwwI9SjN9yPCfdFZVh4P/kcPQDXEmbvi28Ry+g=;
        b=SGF/+SFgVSGY7VJ/V6m6rAmZ6jtSLeekWMD4xFx7m+5QmwcSoNDCzg4VCuKdkBiuCd
         PKfMp1d7FYnvWOFTbe5dULxlfguVe2z9fnsduVzlszfk8fmn+sMXBgtzUNH9mdtF6vlY
         ntjBX49V4yEDc1naOx603Y5gGbSQCqDo7qaXNcUP6kDTCHVVIQ1MtsR80sCt8a5fsR+6
         4ZKQ+Jf+I0FiH73nQCJtX/LifBoi3MbOsi0ptrRbgM5qbrmrfQqPqJe1HQqVnZ3WU6nH
         E9N99+sfkwsO7cuUeXfkFV6vMb2V3JRwFEN14jgGRrIHAD2zLsa1DkXqp+LxQtrsTfeq
         faqw==
X-Gm-Message-State: AOAM533uG6PiUWMHjqF+THZU2g5jUFxMjP0dRARJH69K85aqXsxPZnKd
        ++i5LyKX945IpqXGhoyR4xGdlWMO5jXo73S4TuX8eg==
X-Google-Smtp-Source: ABdhPJwyu4GO9ZTopFM1Qtp9g0AYWW/G2gCL2Rkf2k0emOIuL58PKSUnjfCPuXZtMMqa2spe4DyjerPL+kd11/8NfmU=
X-Received: by 2002:a25:aa94:0:b0:648:62f2:ef4e with SMTP id
 t20-20020a25aa94000000b0064862f2ef4emr8160978ybi.626.1651440865094; Sun, 01
 May 2022 14:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220419163810.2118169-1-arnd@kernel.org> <20220419163810.2118169-16-arnd@kernel.org>
In-Reply-To: <20220419163810.2118169-16-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 1 May 2022 23:34:13 +0200
Message-ID: <CACRpkdbdCzeWgLOhQfEPVz6fYMqDeTYtqQ3uunj1MK+RGcZZKA@mail.gmail.com>
Subject: Re: [PATCH 15/48] ARM: pxa: tosa: use gpio descriptor for audio
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

On Tue, Apr 19, 2022 at 6:40 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The audio driver should not use a hardwired gpio number
> from the header. Change it to use a lookup table.
>
> Acked-by: Mark Brown <broonie@kernel.org>
> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks good to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
