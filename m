Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB79DCEF1
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 21:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437233AbfJRTEM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 15:04:12 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:46101 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439934AbfJRTEL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 15:04:11 -0400
Received: from belgarion ([90.76.41.223])
        by mwinf5d27 with ME
        id F73v210054otT8A03743BP; Fri, 18 Oct 2019 21:04:09 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Fri, 18 Oct 2019 21:04:09 +0200
X-ME-IP: 90.76.41.223
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-clk@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 00/46] ARM: pxa: towards multiplatform support
References: <20191018154052.1276506-1-arnd@arndb.de>
X-URL:  http://belgarath.falguerolles.org/
Date:   Fri, 18 Oct 2019 21:03:54 +0200
In-Reply-To: <20191018154052.1276506-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Fri, 18 Oct 2019 17:40:52 +0200")
Message-ID: <87v9slg9k5.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> Hi PXA maintainers,
>
> I'm in the process of getting the old ARM platforms to all build
> in a single kernel. The largest part of that work is changing all
> the device drivers to no longer require mach/*.h header files.
>
> This series does it for arch/pxa/.
>
> As with the omap1 and s3c24xx series I sent before, I don't
> expect this all to be correct in the first version, though
> a lot of the patches are fairly simple and I did exhaustive
> compile-time testing on them.
>
> Please test if you have the hardware, or review!

Hi Arnd,

Would you have a git tree I can pull from ?
That would make my life easier than applying manually 46 patches...

Cheers.

--
Robert
