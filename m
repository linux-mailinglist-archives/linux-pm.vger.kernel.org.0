Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0F80DD807
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2019 12:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfJSKJz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 19 Oct 2019 06:09:55 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:57501 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfJSKJy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 19 Oct 2019 06:09:54 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Md66H-1hmA0q38lP-00aBTh; Sat, 19 Oct 2019 12:09:52 +0200
Received: by mail-qk1-f175.google.com with SMTP id u184so7726616qkd.4;
        Sat, 19 Oct 2019 03:09:50 -0700 (PDT)
X-Gm-Message-State: APjAAAV6BC7+dJNdNnbp0uBhqhWjVJbpXA0P+NWDqHRQrLjjeNPea+9O
        UsfK6mxzuQugSbt2MHqE8UxQN6gKkEIDC4IrnOw=
X-Google-Smtp-Source: APXvYqxDnkD1LGxVOqOKBA1bv73+2FIM7aUPofN3DdgTjR6MZneEs/uqd6EIDns9KMja9p9yGzmHvgB/h9FVcJa5zrw=
X-Received: by 2002:a37:a614:: with SMTP id p20mr4599817qke.352.1571479789607;
 Sat, 19 Oct 2019 03:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191018154052.1276506-1-arnd@arndb.de> <803f6fa5-b929-007c-5302-4a2d5042241c@roeck-us.net>
In-Reply-To: <803f6fa5-b929-007c-5302-4a2d5042241c@roeck-us.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 19 Oct 2019 12:09:33 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0t-P_w705z0BSXxzj8MmmKVCagLtidiP+NX51zGce0ag@mail.gmail.com>
Message-ID: <CAK8P3a0t-P_w705z0BSXxzj8MmmKVCagLtidiP+NX51zGce0ag@mail.gmail.com>
Subject: Re: [PATCH 00/46] ARM: pxa: towards multiplatform support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        IDE-ML <linux-ide@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        linux-leds@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-rtc@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:JoUK9zIsRwlckwxRsQPyrjTR+CJ+e1NzjrnywlpJZpvLQsrki/O
 6oqUixG3wGmHbC1gSpDeC2OejM6V4LXMb9u1x0OmYrMxGcagKms+P8T/tjhy15NahnZvLsx
 1gNVUhsGYzHMtoVbEaqcMjalLGwbYPFfNThqwVnR8BgbXGDhRMK7Adn2Vavriz2ulAIvmZU
 H5PZHrbqDUGaqIhXvsl4Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pA8x/njXmAI=:U9yaOvxfltjLDDMpfRuSsq
 3HS+Uk5OMnTj7jXsSqT09WlnY5kJE4lyndiUAbmRhkwH8a1mpWaZtSeNW5l9XHblbovqqlFen
 I2hdy64SanS7+hdxQClxrj9MOTCMH+jQ/guAzqyyIS+ZJghWWRA96XK07WeYTSksO3Z3wi4PL
 oeUQfeMOmonDkSFZQJSU0pUDf5ibRuBWvHgYEqc4ZFCtQoMh4HxHg4DcDHz0GcvNIW8zWcUi+
 kGvUwPLgDOL+yFjxr4/A3kz9Dyp14ontGslHGkjqxAOAVjxv5J33fiBooNoR5GvtvGscuR2lq
 suA01emt1k4nZL14WT/4N/ifAN322ft1kJa84NI7AHbBVjq+Ty7vVxQJynTFU9qV2TtVeePTh
 z6LuoYpDlFdSQRZE9ZHsyb7Zbahb2icMEExmeS1b+ZHYjPQQSvKmuopKiOnFdVjBzVpbAs7Sq
 OWKgo9HdQ3faFXmP1ql0IgKuQZAqcUuGMxzZ3qQRC6iZ+w6Fjnw74/gf6IBz3WfI6QsztRmxr
 IChwQdXXDBnXtNhHmN5s+cYfz3SB5+3akBzydwjYiFDmkVYlrVsdsXPNkFi5WLrKvEs+jRXnT
 7x949r2gXzMwOU6maKqn9s+IqzNassNQF5qaczd5/st4LlH7WfivxkcQH4ofJColsHPGPKZh8
 iktcGfmOnhb78/0TpIR8Pj7ulZJkGfkCzLvPJIWmyicG65izSidWtbu0o4peBVdS3AWBMLVL+
 RO1hs5zPp4BOBWIHL0DmrFqHNsNyUF9ne462ySkT6FJvnaVrgtoV5lzoQCIgWh5yfmbR3zfdh
 +cJJ58BOZyJDYKmZfk9jV62B7juGiiPu74mnB7POA41ONooMvzSSBTNUZFPGnif+VoMzuLyEz
 8oK7rdh0sSaKcju6RlWA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Oct 19, 2019 at 3:03 AM Guenter Roeck <linux@roeck-us.net> wrote:
> On 10/18/19 8:40 AM, Arnd Bergmann wrote:
>
> I don't get very far.
>
> $ make-arm pxa_defconfig
> arch/arm/Kconfig:677: can't open file "arch/arm/plat-pxa/Kconfig"
> scripts/kconfig/Makefile:90: recipe for target 'pxa_defconfig' failed

>
> Did I pick the wrong tree ?

It seems that one line got lost in a rebase and ended up in a different patch
that was not part of the series. I updated the git tree now.

        Arnd
