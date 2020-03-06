Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D18D617C7AB
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 22:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgCFVPp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 16:15:45 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:8137 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgCFVPp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Mar 2020 16:15:45 -0500
X-Originating-IP: 86.202.105.35
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id BAEA6240006;
        Fri,  6 Mar 2020 21:15:38 +0000 (UTC)
Date:   Fri, 6 Mar 2020 22:15:38 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Anson Huang <Anson.Huang@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        amit.kucheria@verdurent.com, wim@linux-watchdog.org,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        linux-rtc@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Subject: Re: [PATCH 3/5] input: keyboard: add COMPILE_TEST support for
 KEYBOARD_IMX_SC_KEY
Message-ID: <20200306211538.GA8060@piout.net>
References: <1583509356-8265-1-git-send-email-Anson.Huang@nxp.com>
 <1583509356-8265-3-git-send-email-Anson.Huang@nxp.com>
 <20200306193310.GI217608@dtor-ws>
 <CAKdAkRRhXE6Hviqx90_5hWmP7YQnKO2QLJgDYnzt_CPjeH7D0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKdAkRRhXE6Hviqx90_5hWmP7YQnKO2QLJgDYnzt_CPjeH7D0A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/03/2020 12:05:42-0800, Dmitry Torokhov wrote:
> On Fri, Mar 6, 2020 at 11:33 AM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > On Fri, Mar 06, 2020 at 11:42:34PM +0800, Anson Huang wrote:
> > > Add COMPILE_TEST support to i.MX SC keyboard driver for better compile
> > > testing coverage.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> >
> > Applied, thank you.
> 
> Actually, not:
> 
> ERROR: "imx_scu_irq_register_notifier"
> [drivers/input/keyboard/imx_sc_key.ko] undefined!
> ERROR: "imx_scu_get_handle" [drivers/input/keyboard/imx_sc_key.ko] undefined!
> ERROR: "imx_scu_call_rpc" [drivers/input/keyboard/imx_sc_key.ko] undefined!
> ERROR: "imx_scu_irq_unregister_notifier"
> [drivers/input/keyboard/imx_sc_key.ko] undefined!
> ERROR: "imx_scu_irq_group_enable"
> [drivers/input/keyboard/imx_sc_key.ko] undefined!
> make[1]: *** [scripts/Makefile.modpost:94: __modpost] Error 1
> make: *** [Makefile:1282: modules] Error 2
> 
> If you want to enable compile test coverage you need to provide stubs
> for the above functions.
> 

or select IMX_SCU

or leave out COMPILE_TEST from the individual drivers as having
COMPILE_TEST for IMX_SCU is enough to be able to select the drivers.

> Thanks.
> 
> -- 
> Dmitry

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
