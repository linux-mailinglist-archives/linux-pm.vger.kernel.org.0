Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B176FDD7EE
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2019 12:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbfJSKI5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 19 Oct 2019 06:08:57 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:55093 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfJSKI5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 19 Oct 2019 06:08:57 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MYNeM-1iYKiy05tC-00VRj4; Sat, 19 Oct 2019 12:08:54 +0200
Received: by mail-qt1-f178.google.com with SMTP id o49so5087510qta.7;
        Sat, 19 Oct 2019 03:08:52 -0700 (PDT)
X-Gm-Message-State: APjAAAWq0NWMODCvCKKoRrJcY/xROCatDSgq6KWDVdw8kmm1tqupxvij
        aR1dAZRiDHReU9iKYIP0dXkqUsX3odTklIG2JjA=
X-Google-Smtp-Source: APXvYqx0KL/4UEXxK6gF6MT84x40msmTgoc3wUmUnzQ2wz5CAlnxhFheu9zzXtORTNxkRfpad8/dgIDVulcScXUuQ7U=
X-Received: by 2002:ac8:33d4:: with SMTP id d20mr14268876qtb.204.1571479731943;
 Sat, 19 Oct 2019 03:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20191018154052.1276506-1-arnd@arndb.de> <803f6fa5-b929-007c-5302-4a2d5042241c@roeck-us.net>
In-Reply-To: <803f6fa5-b929-007c-5302-4a2d5042241c@roeck-us.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 19 Oct 2019 12:08:35 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3gOn6qkvvKaBzqYUzZToMKv3E587_8fQHmaF2u7erd5w@mail.gmail.com>
Message-ID: <CAK8P3a3gOn6qkvvKaBzqYUzZToMKv3E587_8fQHmaF2u7erd5w@mail.gmail.com>
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
X-Provags-ID: V03:K1:FZS9JDtsgTvMyAvtTQLTKE7kn5paGDi0HxqdNrrd4gOc2eoZ/Z2
 fhSPM4tI72K4/B00X6YSoSQH7qIOx9a8fTZHZlpQ4k1k8FgHiB4ZVtWGgSFJI8gBQCBiT5E
 2ygk6PWUY4TfC8bGxwEhbmQbK+sKe6rq0vnZwNFubQcxQATFWsmhDC8qThHRz2skgs/Itqd
 f5aOytM1gFUEhp+xEku7g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mfjjeu6X63c=:idOfewmnr/3xCGPwUHNLfF
 9B27mgsqWAsMCRUn7Lb6AvPTlJxFpGJF+8LaS+wgMbQcESTIQSXIezszm7taCti8jyxUURItp
 JKLrCbBMPjm5kNckunFQ0Zc7tyRIgs/dwFlWEK/qtmB2sdjlWXZyyBGEiLjqtemgoBoH+oNZZ
 ilUmnapk2UZJ7Pq8Yui5T/glSBy4WWqRrVBs5agIMBTHBg5wckmqim4eMUhQIvEDUFYOUZQWl
 K9gbRcy1uhuK1OBT/F3fD+WGFV9rYXtQVytgy2CJDDO5ugHtVuQJPCAmUDZkAd/95XzGZbMvP
 sLcXyN9J4n7HB0v6K4timSvJT9o71OHTSIf3nKNEI6Svs18/WfO93UootFdGuWkTvZczNXkNG
 BtR4RqYVEFvI2WFtM39SZBhRqC4x+MDPwIvIl8Ea99J6BS0FuNwJ/otfeE0Lb3EduAuYtW7LR
 ivyg/+2El01fWGnGewKNtbF/gFCcflpfEYL8yrojAFmi6KrouahOduhlOtA8YL/qUAbkjUsoT
 uSr3VwPOFircEWYa4joZhdYBM78LTZ40AjgtYPzgSkRMidassP/Nkehhq7KxwUeKdhtIjZiQU
 C+X80LQ5wKgi7LbUjd+0AZktlbTywqTTQo48mLaS/ERk7IEgMFRDMSB8vyv+hK+7SOMgg+O0m
 TaWSL/H0NJ5s1wDMsEkTkdhtjkvBSvPD6Awpco4hzbti1UNSClmqoncvgyT7JbcyobIAMULwf
 GsphosJGED9vx+f9NwPl6bU5gSP21UjVPQOG7ZKnZb6aa4ELwNuAUf+4ywVoHiRq4x1nNYM3m
 sOmS3W5FtKHytXuFAhDuW8dbdcq9121LVQFiTPPgMz7T3LLqoSyeSxhTSHvpBDAx2dlBVJQya
 l5Jvr8dp+tU/iADO8uRQ==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Oct 19, 2019 at 3:03 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 10/18/19 8:40 AM, Arnd Bergmann wrote:
> >
> > Hi PXA maintainers,
> >
> > I'm in the process of getting the old ARM platforms to all build
> > in a single kernel. The largest part of that work is changing all
> > the device drivers to no longer require mach/*.h header files.
> >
> > This series does it for arch/pxa/.
> >
> > As with the omap1 and s3c24xx series I sent before, I don't
> > expect this all to be correct in the first version, though
> > a lot of the patches are fairly simple and I did exhaustive
> > compile-time testing on them.
> >
> > Please test if you have the hardware, or review!
> >
>
> I don't get very far.
>
> $ make-arm pxa_defconfig
> arch/arm/Kconfig:677: can't open file "arch/arm/plat-pxa/Kconfig"
> scripts/kconfig/Makefile:90: recipe for target 'pxa_defconfig' failed
> make[1]: *** [pxa_defconfig] Error 1
> Makefile:567: recipe for target 'pxa_defconfig' failed
> make: *** [pxa_defconfig] Error 2
> $ git describe
> v5.4-rc3-52-gfcc4181cd625
>
> Also:
>
> $ git grep plat-pxa
> Documentation/arm/marvel.rst:   arch/arm/plat-pxa
> Documentation/arm/marvel.rst:   arch/arm/plat-pxa
> Documentation/arm/marvel.rst:   directory. The plat-pxa/ would therefore disappear.
> arch/arm/Kconfig:source "arch/arm/plat-pxa/Kconfig"
> arch/arm/mach-mmp/Makefile:ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/plat-pxa/include
> drivers/gpio/gpio-pxa.c: *  linux/arch/arm/plat-pxa/gpio.c
> drivers/soc/pxa/mfp.c: * linux/arch/arm/plat-pxa/mfp.c
>
> Did I pick the wrong tree ?
>
> Guenter
