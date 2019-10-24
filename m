Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6D80E3D8C
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2019 22:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfJXUuG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Oct 2019 16:50:06 -0400
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:35935 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbfJXUuG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Oct 2019 16:50:06 -0400
Received: from belgarion ([90.76.41.223])
        by mwinf5d87 with ME
        id HYps210044otT8A03Ypz5w; Thu, 24 Oct 2019 22:50:03 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Thu, 24 Oct 2019 22:50:03 +0200
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
        <87r239f2g8.fsf@belgarion.home>
X-URL:  http://belgarath.falguerolles.org/
Date:   Thu, 24 Oct 2019 22:49:51 +0200
In-Reply-To: <87r239f2g8.fsf@belgarion.home> (Robert Jarzmik's message of
        "Sat, 19 Oct 2019 12:35:03 +0200")
Message-ID: <87eez1rhqo.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

>>> I've now pushed it to
>>>
>>> git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git
>>> pxa-multiplatform
>>
>> Sorry for the duplication, I had some problems with email configuration
>> so my reply got rejected, let's see if it goes through this time.
> I have it now, thanks, I'll test and review as soon as I can.
>
> Cheers.

Ok Arnd, I have a preliminary test report.

I tested only the pxa27x (mioa701), which happens to have a lot of drivers, and
only the platform_data flavor (ie. no device-tree test yet). Apart a panic in
the regulator framework (which is a known issue [1]), your version seems
equivalent so far in terms of runtime to Linux 5.4-rc3).

The sound and RTC seem broken, but not by you ...

I'll continue the test onwards for pxa3xx and pxa2xx when I'll gather a bit of
time, and try to review as well the mach-pxa part.

Cheers.

-- 
Robert

[1] https://lore.kernel.org/patchwork/patch/1130436/
