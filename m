Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8939717CB5F
	for <lists+linux-pm@lfdr.de>; Sat,  7 Mar 2020 03:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgCGC51 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 21:57:27 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:46129 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgCGC51 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Mar 2020 21:57:27 -0500
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id E1D1F200002;
        Sat,  7 Mar 2020 02:57:20 +0000 (UTC)
Date:   Sat, 7 Mar 2020 03:57:20 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
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
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 3/5] input: keyboard: add COMPILE_TEST support for
 KEYBOARD_IMX_SC_KEY
Message-ID: <20200307025720.GA52231@piout.net>
References: <1583509356-8265-1-git-send-email-Anson.Huang@nxp.com>
 <1583509356-8265-3-git-send-email-Anson.Huang@nxp.com>
 <20200306193310.GI217608@dtor-ws>
 <CAKdAkRRhXE6Hviqx90_5hWmP7YQnKO2QLJgDYnzt_CPjeH7D0A@mail.gmail.com>
 <20200306211538.GA8060@piout.net>
 <DB3PR0402MB39164192146D17327A45DA6CF5E00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB39164192146D17327A45DA6CF5E00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/03/2020 01:36:39+0000, Anson Huang wrote:
> Hi, Alexandre
> 
> > Subject: Re: [PATCH 3/5] input: keyboard: add COMPILE_TEST support for
> > KEYBOARD_IMX_SC_KEY
> > 
> > On 06/03/2020 12:05:42-0800, Dmitry Torokhov wrote:
> > > On Fri, Mar 6, 2020 at 11:33 AM Dmitry Torokhov
> > > <dmitry.torokhov@gmail.com> wrote:
> > > >
> > > > On Fri, Mar 06, 2020 at 11:42:34PM +0800, Anson Huang wrote:
> > > > > Add COMPILE_TEST support to i.MX SC keyboard driver for better
> > > > > compile testing coverage.
> > > > >
> > > > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > >
> > > > Applied, thank you.
> > >
> > > Actually, not:
> > >
> > > ERROR: "imx_scu_irq_register_notifier"
> > > [drivers/input/keyboard/imx_sc_key.ko] undefined!
> > > ERROR: "imx_scu_get_handle" [drivers/input/keyboard/imx_sc_key.ko]
> > undefined!
> > > ERROR: "imx_scu_call_rpc" [drivers/input/keyboard/imx_sc_key.ko]
> > undefined!
> > > ERROR: "imx_scu_irq_unregister_notifier"
> > > [drivers/input/keyboard/imx_sc_key.ko] undefined!
> > > ERROR: "imx_scu_irq_group_enable"
> > > [drivers/input/keyboard/imx_sc_key.ko] undefined!
> > > make[1]: *** [scripts/Makefile.modpost:94: __modpost] Error 1
> > > make: *** [Makefile:1282: modules] Error 2
> > >
> > > If you want to enable compile test coverage you need to provide stubs
> > > for the above functions.
> > >
> > 
> > or select IMX_SCU
> > 
> > or leave out COMPILE_TEST from the individual drivers as having
> > COMPILE_TEST for IMX_SCU is enough to be able to select the drivers.
> 
> Thanks, I already added the COMPILE_TEST for IMX_SCU which is in this same patch series,
> without that IMX_SCU COMPILE_TEST patch, the build will failed, so in V2, I also added
> the stubs into those IMX SCU APIs to make sure even IMX_SCU is NOT enabled, modules
> with COMPILE_TEST can still pass build, please help review V2 patch set.
> 

My point is that there is no need for the stubs. Simply have
COMPILE_TEST for IMX_SCU as this is enough to extend coverage to all the
drivers and significantly reduces the code size versus what you did in
v2.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
