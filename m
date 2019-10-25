Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1F1E48E5
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2019 12:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394503AbfJYKvJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Oct 2019 06:51:09 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:45981 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392198AbfJYKvJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Oct 2019 06:51:09 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mj831-1hlZxU1VH3-00fEqI; Fri, 25 Oct 2019 12:51:05 +0200
Received: by mail-qk1-f181.google.com with SMTP id q70so1261022qke.12;
        Fri, 25 Oct 2019 03:51:04 -0700 (PDT)
X-Gm-Message-State: APjAAAWA6fFViRcJqREnWWJ4XnLSnh9uc5TR3f3XkJRs4iop43nFUxmc
        NGQ8ccT6lVNGOrvmjR3QEB2RQ+274bWdUrVtGAM=
X-Google-Smtp-Source: APXvYqx2Oor6PcLHOX4Sy8TtHwX6a9dti7RuLVSJPm8RZ72aJo7WkeFnANJ7SePVIoWyJuP+ht+PknNC97FPJwMamtQ=
X-Received: by 2002:a37:58d:: with SMTP id 135mr2252602qkf.394.1572000663226;
 Fri, 25 Oct 2019 03:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191018154052.1276506-1-arnd@arndb.de> <87v9slg9k5.fsf@belgarion.home>
 <CAK8P3a1JDtHsOW=iaxEycbJ4TBkR9MHUyDMeJnwxCtb=tefnBQ@mail.gmail.com>
 <CAK8P3a0376Anmoc8VWXcEBg+z2B+1vcxJoywYYROBQNxpVmZuA@mail.gmail.com>
 <87r239f2g8.fsf@belgarion.home> <87eez1rhqo.fsf@belgarion.home>
In-Reply-To: <87eez1rhqo.fsf@belgarion.home>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 25 Oct 2019 12:50:46 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0L3_Hs48X5bh0UD2L_AaxLcUOQ_YS7ZpSd5W-8xcgAog@mail.gmail.com>
Message-ID: <CAK8P3a0L3_Hs48X5bh0UD2L_AaxLcUOQ_YS7ZpSd5W-8xcgAog@mail.gmail.com>
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
X-Provags-ID: V03:K1:bBFl5bX9BqXoDP8OrdvcfGlrYLRY5B1GUhWZJswEMUsHfqL7ZPS
 wNKiBQqI9J4lWaKwMKWpeuRP8Q7gNW1Huux28MpdQbLQHsG8keYqULuxokAyz8cXvUuDQNr
 Y4OmkYoxdwxMOhV/OoYmkmbTVaeZ1jGsBbuhOyjPDaixMEDPYwwWYKYrS8WnrToePTYktVe
 isgPlih4bJp7b5na0cbDg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+amIHTsvEsM=:wxrSdcXp8fCl0WvOtbji8T
 eiMYbEG4cst6pRKOmo34ky4eqFrbI9L+1xHjnaiY+H7o5c4AvretiveY6HsD/8Q4GCTo+d4EF
 6KHQlLX/3bCOUITQRQRqZXMcO8+d/5yBWQ4PLvO/++od9zW+FSeEXlBspQqZItGbvkewyaSgM
 V2RuqHgZsRHubh1xP1lsxIE2YLtSonVpvh2iNYDMLLKocefeURCWHULZHpLKqb637/1ILOFmh
 oY55eIQP5dCvyMde+02h4Sc41A/coK0VSMYnmjZbIdabokN8wJmd5BpuqN52whvBKMyQB7Drx
 +rJNk043np+L19CHym/KU1GD0+Jh/hYMmdbAesunIc/XFNfshrJppNPggA2jYuD+WHt0GoW0h
 vIRvBMeg6dWxtHSt5iN2OWe8YRwmJozAghx6eaxs/+mtKjhlwdb8pg8wgjMJTT4UVZPNck6ai
 ETIxAKLIg48ERY2PKPCwjHZWIF59mr9ihwrIm7/PoRVzhB2DgY1bXT+r0Xf1ifNLX95PYOB5M
 zAGClTyzoyjzTzKwNgwcV4nTh4Je81xIc8FEG8D5S5n2odlouWYtMUHvQkobX+2UgP+dk+Rdq
 Yf9piYlNy1SKL1OHQdycWsLTFQ3jMWeWKCJRb5PSzWdnYIqeBZU1jM0z+jjUqPYhNrA/3/oIY
 6RHI26+ovszi6E37l9e4YOUqQLgkyayuNJDsaLxUKkKdzoog8Z1n6LZPKD/u4+MRIXZCKCrGx
 pWVDvdMh6MitMHpzAZXm52z3k1A8T63a1CoAVUlqw1z/kLR1+hrsr4BnhFtpR4HNXe8FSWIge
 SE0Vg8VrS1FRrUX3m8HXrRagLwmAmfEk5PCq5WPOx/NjbgPEUnw5nqQ9HVCS9jOGnKIZvBw5Z
 /NMhJY+Zi7eyYSpPjOOA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 24, 2019 at 10:50 PM Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Robert Jarzmik <robert.jarzmik@free.fr> writes:
> >>> I've now pushed it to
> >>>
> >>> git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git
> >>> pxa-multiplatform
> >>
> >> Sorry for the duplication, I had some problems with email configuration
> >> so my reply got rejected, let's see if it goes through this time.
> > I have it now, thanks, I'll test and review as soon as I can.
> >
> > Cheers.
>
> Ok Arnd, I have a preliminary test report.
>
> I tested only the pxa27x (mioa701), which happens to have a lot of drivers, and
> only the platform_data flavor (ie. no device-tree test yet). Apart a panic in
> the regulator framework (which is a known issue [1]), your version seems
> equivalent so far in terms of runtime to Linux 5.4-rc3).
>
> The sound and RTC seem broken, but not by you ...
>
> I'll continue the test onwards for pxa3xx and pxa2xx when I'll gather a bit of
> time, and try to review as well the mach-pxa part.

Awesome, thanks for testing so far and for the report!

        Arnd
