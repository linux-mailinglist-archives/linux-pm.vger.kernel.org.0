Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19B50E7910
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2019 20:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbfJ1TO1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 15:14:27 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:43325 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730056AbfJ1TO1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2019 15:14:27 -0400
Received: from belgarion ([90.55.204.252])
        by mwinf5d17 with ME
        id K7EJ2100B5TFNlm037EJ4o; Mon, 28 Oct 2019 20:14:24 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Mon, 28 Oct 2019 20:14:24 +0100
X-ME-IP: 90.55.204.252
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@arm.linux.org.uk>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Brown <broonie@kernel.org>, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-rtc@vger.kernel.org,
        linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-watchdog@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 05/46] ARM: pxa: split up mach/hardware.h
References: <20191018154052.1276506-1-arnd@arndb.de>
        <20191018154201.1276638-5-arnd@arndb.de>
X-URL:  http://belgarath.falguerolles.org/
Date:   Mon, 28 Oct 2019 20:14:18 +0100
In-Reply-To: <20191018154201.1276638-5-arnd@arndb.de> (Arnd Bergmann's message
        of "Fri, 18 Oct 2019 17:41:20 +0200")
Message-ID: <87d0egof79.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> The mach/hardware.h is included in lots of places, and it provides
> three different things on pxa:
>
> - the cpu_is_pxa* macros
> - an indirect inclusion of mach/addr-map.h
> - the __REG() and io_pv2() helper macros
>
> Split it up into separate <linux/soc/pxa/cpu.h> and mach/pxa-regs.h
> headers, then change all the files that use mach/hardware.h to
> include the exact set of those three headers that they actually
> need, allowing for further more targeted cleanup.
>
> linux/soc/pxa/cpu.h can remain permanently exported and is now in
> a global location along with similar headers. pxa-regs.h and
> addr-map.h are only used in a very small number of drivers now
> and can be moved to arch/arm/mach-pxa/ directly when those drivers
> are to pass the necessary data as resources.

For the pxa part, that looks fine to me.
I'd like to focus a bit of Russell's attention to the sa11xx part (reminder in
[1]), and more specifically :

 - the change to drivers/pcmcia/soc_common.c
 - the change to drivers/pcmcia/sa1111_generic.c

I must admit my knowledge of PCMCIA is relatively poor, and even if the patch
looks harmless, one never knows if Assebet will ever by same after ...

Cheers.

--
Robert

[1] Extract of the patch for Russell's scrutiny
> diff --git a/drivers/pcmcia/sa1111_generic.c b/drivers/pcmcia/sa1111_generic.c
> index 11783410223b..2f556fa37c43 100644
> --- a/drivers/pcmcia/sa1111_generic.c
> +++ b/drivers/pcmcia/sa1111_generic.c
> @@ -17,7 +17,6 @@
>  
>  #include <pcmcia/ss.h>
>  
> -#include <mach/hardware.h>
>  #include <asm/hardware/sa1111.h>
>  #include <asm/mach-types.h>
>  #include <asm/irq.h>
... zip ...

> diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
> index 3a8c84bb174d..9276a628473d 100644
> --- a/drivers/pcmcia/soc_common.c
> +++ b/drivers/pcmcia/soc_common.c
> @@ -47,8 +47,6 @@
>  #include <linux/spinlock.h>
>  #include <linux/timer.h>
>  
> -#include <mach/hardware.h>
> -
>  #include "soc_common.h"
>  
>  static irqreturn_t soc_common_pcmcia_interrupt(int irq, void *dev);
