Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC5D516868
	for <lists+linux-pm@lfdr.de>; Sun,  1 May 2022 23:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376532AbiEAVxx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 May 2022 17:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355509AbiEAVxu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 May 2022 17:53:50 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAE3A1BF
        for <linux-pm@vger.kernel.org>; Sun,  1 May 2022 14:50:23 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2f16645872fso131618457b3.4
        for <linux-pm@vger.kernel.org>; Sun, 01 May 2022 14:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DrYFNF6XiUDLRQ8BG/sFtx3Ph/Zfoke+tXA+P2uLssI=;
        b=d2nReteaB3Jz4i06NpIM6gnz5B8hQwBBjiPEVsw+epXirApSHuit8G+1KpGNH0E41i
         zxQnSRyQRoC4LRDvTTpNQXXWsgzjSg9lPXQ+2R5TERxPbgFoJ0rO3XT8c3m0Yq0HNGg1
         xoDglp5RLj9nKgfEQ74i2SHqKwgwMdRpEEtiYG/Om0Qpux5sR/mLSHSOL9gM6Vj1gMWz
         VoIYgx1rBx+zz3z7FpvoE8zQGdfABxOi+Ob8Z9KwW9nuJHZuBF/shpRDF0nV/UEdNxMy
         YZNy+kAfKoMJQflpdXIk7n78QiZxl/VYBhTpXLO/UC9d4n5NKuo5I3ZCPC4z1lrBlf8C
         mZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DrYFNF6XiUDLRQ8BG/sFtx3Ph/Zfoke+tXA+P2uLssI=;
        b=r3FaE3w1mtCC2YZcbDvvxLIltSqKWlV5s0hshFMyliABvUWNwCIqM8igdxvDq6HYGB
         EnBbyYZxB6GZMLTn4w54CIj/6z85hAYCEqprKpckDoXD9VZJ5ChchNWFsFM3kZ90YBCG
         Qp4P5PCgEkEaiD/SJZMHaFj88Op/g6e0CYsG4RpIN/SS5aV1brZ0rQAyyn7J7sKQ/Zif
         NVv/D7NpGSQT4dAsVUzJE2Gi51WxPzvo+6BrQ1wLxA8fMCcIzghioj5KQYw0hx35BQi4
         4RuagY8vosHvvDYIhl1jGOeqxumvnJjaQlTjQkz1oM5rLGy1ESiJl9kB8N9l3ycz8cUM
         hqKw==
X-Gm-Message-State: AOAM5315dW2docL3UjCJAFxhoVQanRHAk4JCY/N/sijp2CUBNgR+okuy
        mIwXLy/E1SXVoCk7vy42SJEct1c3lCRstpVwtjTwIQ==
X-Google-Smtp-Source: ABdhPJy78P6hUpCS1kUYg8tICBMpcOG7ZelV2yx+uOWLM+IsGmklihAlHCtdjke+EOaf0s2Ys/opvH6nxxiY8Y3Ggaw=
X-Received: by 2002:a0d:e5c6:0:b0:2f8:c866:7af9 with SMTP id
 o189-20020a0de5c6000000b002f8c8667af9mr9181281ywe.268.1651441822394; Sun, 01
 May 2022 14:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220419163810.2118169-1-arnd@kernel.org> <20220419163810.2118169-26-arnd@kernel.org>
In-Reply-To: <20220419163810.2118169-26-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 1 May 2022 23:50:10 +0200
Message-ID: <CACRpkdYs+0OdHfXGXwX3hdwV+BLi=V6FUkJEkm_ckbuR6QHToQ@mail.gmail.com>
Subject: Re: [PATCH 25/48] ARM: pxa: zylonite: use gpio lookup instead mfp header
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

On Tue, Apr 19, 2022 at 6:42 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The mach/mfp.h header is only used by this one driver
> for hardcoded gpio numbers. Change that to use a lookup
> table instead.
>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks good to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
