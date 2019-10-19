Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12783DD824
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2019 12:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbfJSKfN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 19 Oct 2019 06:35:13 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:45129 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfJSKfM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 19 Oct 2019 06:35:12 -0400
Received: from belgarion ([90.76.41.223])
        by mwinf5d17 with ME
        id FNb42100B4otT8A03Nb44m; Sat, 19 Oct 2019 12:35:10 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sat, 19 Oct 2019 12:35:10 +0200
X-ME-IP: 90.76.41.223
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        IDE-ML <linux-ide@vger.kernel.org>,
        "open list\:HID CORE LAYER" <linux-input@vger.kernel.org>,
        linux-leds@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-rtc@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH 00/46] ARM: pxa: towards multiplatform support
References: <20191018154052.1276506-1-arnd@arndb.de>
        <87v9slg9k5.fsf@belgarion.home>
        <CAK8P3a1JDtHsOW=iaxEycbJ4TBkR9MHUyDMeJnwxCtb=tefnBQ@mail.gmail.com>
        <CAK8P3a0376Anmoc8VWXcEBg+z2B+1vcxJoywYYROBQNxpVmZuA@mail.gmail.com>
X-URL:  http://belgarath.falguerolles.org/
Date:   Sat, 19 Oct 2019 12:35:03 +0200
In-Reply-To: <CAK8P3a0376Anmoc8VWXcEBg+z2B+1vcxJoywYYROBQNxpVmZuA@mail.gmail.com>
        (Arnd Bergmann's message of "Fri, 18 Oct 2019 21:32:36 +0200")
Message-ID: <87r239f2g8.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Fri, Oct 18, 2019 at 9:17 PM Arnd Bergmann <arnd@arndb.de> wrote:
>> On Fri, Oct 18, 2019 at 9:04 PM Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>> > Arnd Bergmann <arnd@arndb.de> writes:
>> >
>> > > Hi PXA maintainers,
>> > >
>> > > I'm in the process of getting the old ARM platforms to all build
>> > > in a single kernel. The largest part of that work is changing all
>> > > the device drivers to no longer require mach/*.h header files.
>> > >
>> > > This series does it for arch/pxa/.
>> > >
>> > > As with the omap1 and s3c24xx series I sent before, I don't
>> > > expect this all to be correct in the first version, though
>> > > a lot of the patches are fairly simple and I did exhaustive
>> > > compile-time testing on them.
>> > >
>> > > Please test if you have the hardware, or review!
>> >
>> > Hi Arnd,
>> >
>> > Would you have a git tree I can pull from ?
>> > That would make my life easier than applying manually 46 patches...
>>
>> I've now pushed it to
>>
>> git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git
>> pxa-multiplatform
>
> Sorry for the duplication, I had some problems with email configuration
> so my reply got rejected, let's see if it goes through this time.
I have it now, thanks, I'll test and review as soon as I can.

Cheers.

-- 
Robert
