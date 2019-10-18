Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B234ADCF51
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 21:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437634AbfJRTc6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 15:32:58 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:37369 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394807AbfJRTc6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 15:32:58 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N5UoU-1hx1rB0p0k-016tR7; Fri, 18 Oct 2019 21:32:55 +0200
Received: by mail-qk1-f179.google.com with SMTP id u184so6377750qkd.4;
        Fri, 18 Oct 2019 12:32:54 -0700 (PDT)
X-Gm-Message-State: APjAAAWOMUseeQAnmf5ePLjWA4QTqPmO0TGTh8vzYVIg+mSZ45wpLuT4
        58u8s2senhYMMa3qH1GwOLEUY2VGgyDQeT6vYe0=
X-Google-Smtp-Source: APXvYqzndIi4+lrEFsQAJTvDSAykrBEjXYWBlihPsFokm/QiIqztK3NntxmM4iVAVoSe7PNdrIRvDpgwbQhfLS5cKrs=
X-Received: by 2002:a37:db0a:: with SMTP id e10mr10369877qki.3.1571427173049;
 Fri, 18 Oct 2019 12:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20191018154052.1276506-1-arnd@arndb.de> <87v9slg9k5.fsf@belgarion.home>
 <CAK8P3a1JDtHsOW=iaxEycbJ4TBkR9MHUyDMeJnwxCtb=tefnBQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1JDtHsOW=iaxEycbJ4TBkR9MHUyDMeJnwxCtb=tefnBQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 18 Oct 2019 21:32:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0376Anmoc8VWXcEBg+z2B+1vcxJoywYYROBQNxpVmZuA@mail.gmail.com>
Message-ID: <CAK8P3a0376Anmoc8VWXcEBg+z2B+1vcxJoywYYROBQNxpVmZuA@mail.gmail.com>
Subject: Re: [PATCH 00/46] ARM: pxa: towards multiplatform support
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
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
X-Provags-ID: V03:K1:x6rjh/SYhkhVXFY7sn38XpS2jNl7mZ+ZSAgBlTmeuBIEAqo8moQ
 ZloY0yHOr0VObCTuKLP4a+2rBvJkW653ZyzZa/eWVN3/Ovj/BNRg9Ewp1Qf7rCBMO8Hhk1D
 iwosZq0hvegBArF9MtuUzikr1dATmDPGh2GE3ojjjAh3L/xbOPWehNtgUykguhtLo25ub3e
 Gh9uYlRVvIqPMYEpjyOxg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xqW7pTXOCNI=:B+AiqXxm34TeJktaofJfOW
 XqUjplt4t0CUZ2O55g6B1bgZZacd+rT+JuPTFvuaVx1dQM1GrEbNii30aJz0qTY/9r2GHRVUi
 OvSlVnq3juFgtcY+5TmDRWP+EjFL1/t5QgjdUXDpsAc1iUjtxFwuDKrEFw+SMqJFj+Evb4M8L
 7wbYHomgQQY+uoWcF9O5DLciqMHlDIzbauOi8Lb8bts8RuWV8MWXNKV6pySMZBfkvYKfVY6Id
 dRjDuhZDsgP5jWCbtzO12OqzKnxMnZUkvtuNqE907owCD6DW0lhUjJdXJhyg1DtnUR53aLxXm
 uyT/qud2H90oWDD31hBeJ6MHXUOHppefVXVH9rJMm26ZRkgxdiioxTD1OTJ3EFcBSYEbMiSdD
 m5KrdOruT25lSFB4y/FukEE5zBpl7S+BgJvHFF6Lpzaci4tD8YF/Hro/LlSi2jylbMPpLzp0o
 KFXy7N7zXVPStE+nf8LQ+jE3PgkeG0V+cB2bFyTkuUjr3n3f0q/2MDNhY0CG1kmgrpZlzzT3C
 nFqWmIbnG7sOILmVeWRjrQKFkoHeOzeRBURJlkJHZ3Gutmq6dZJlxibBGXhwRR/y/DLzj1lOO
 nJSr90gM3rzdbOXgkUqkX6zqSQRolgGoHmR78xCiWTiTij+CXnBDpAbXF7ph7vNR8G4br9z3F
 7GSqCWBHVQSTXQR8mPCBUBGRHGWz00P0gLcFNQnu04PqT8bERSnbgL6kj6jQEO2gPIvxVswEo
 KaV2YTmOgsEA8o5SRMsZ1yI0YtaDQ+9tFZs7P8kssy4pBkyQoodTbi6OXh3O/ve4sCf1oXpS0
 hLIQTF7A215Fx0yevnxC4Wa+lLYgROb6ZPDKBCkqsk9/rn4KMZ6nxOo4JptuWrj4WMJY71M9w
 TgvMufS3940rCabHvzVQ==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 18, 2019 at 9:17 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Oct 18, 2019 at 9:04 PM Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> > Arnd Bergmann <arnd@arndb.de> writes:
> >
> > > Hi PXA maintainers,
> > >
> > > I'm in the process of getting the old ARM platforms to all build
> > > in a single kernel. The largest part of that work is changing all
> > > the device drivers to no longer require mach/*.h header files.
> > >
> > > This series does it for arch/pxa/.
> > >
> > > As with the omap1 and s3c24xx series I sent before, I don't
> > > expect this all to be correct in the first version, though
> > > a lot of the patches are fairly simple and I did exhaustive
> > > compile-time testing on them.
> > >
> > > Please test if you have the hardware, or review!
> >
> > Hi Arnd,
> >
> > Would you have a git tree I can pull from ?
> > That would make my life easier than applying manually 46 patches...
>
> I've now pushed it to
>
> git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git
> pxa-multiplatform

Sorry for the duplication, I had some problems with email configuration
so my reply got rejected, let's see if it goes through this time.

       Arnd
