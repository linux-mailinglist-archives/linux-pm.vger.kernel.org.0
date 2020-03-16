Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEC88186388
	for <lists+linux-pm@lfdr.de>; Mon, 16 Mar 2020 04:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbgCPDIA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Mar 2020 23:08:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729384AbgCPDIA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 15 Mar 2020 23:08:00 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B83B420409;
        Mon, 16 Mar 2020 03:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584328079;
        bh=Ta/7YQGMbWyIGTwkBfx9j6N2DjoHmcD3pjam5ZHomYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YuPz9BDeEmfsDued5suhi+F0CzjEaeD6rv51BFRYQ1JaiZD34V1qqxHrXeYsPG8zj
         XJXVKJ1sBrjUt3Ir53ZsoMrcqk/HSbkX4EXZp3wKxeD2iUNhqlSKLac+Dt3aXcpzLA
         Kjjwq/qCLJvbt4xwZRgKKwRuuvh3evpEwRSh3zWY=
Date:   Mon, 16 Mar 2020 11:07:45 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Anson Huang <anson.huang@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "ronald@innovation.ch" <ronald@innovation.ch>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V3 1/7] firmware: imx: Add stubs for !CONFIG_IMX_SCU case
Message-ID: <20200316030744.GC17221@dragon>
References: <1583714300-19085-1-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB4481F087AC3CDA691300710288FE0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20200316005219.GD17221@dragon>
 <AM0PR04MB44819E4A9E027F1555C33D0B88F90@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB44819E4A9E027F1555C33D0B88F90@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 16, 2020 at 02:51:47AM +0000, Peng Fan wrote:
> Hi Shawn,
> 
> > Subject: Re: [PATCH V3 1/7] firmware: imx: Add stubs for !CONFIG_IMX_SCU
> > case
> > 
> > On Mon, Mar 09, 2020 at 01:40:18PM +0000, Peng Fan wrote:
> > > > Subject: [PATCH V3 1/7] firmware: imx: Add stubs for !CONFIG_IMX_SCU
> > > > case
> > >
> > > I have one patch pending reviewing.
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatc
> > >
> > hwork.kernel.org%2Fpatch%2F11395247%2F&amp;data=02%7C01%7Cpeng.f
> > an%40n
> > >
> > xp.com%7C995815002e2b490791e008d7c9445133%7C686ea1d3bc2b4c6fa9
> > 2cd99c5c
> > >
> > 301635%7C0%7C0%7C637199167574579419&amp;sdata=RM4Mtwl8LZ3ft9
> > 3uL3FQPcHT
> > > 9lPHSqBOgugozkcLvag%3D&amp;reserved=0
> > 
> > I dropped that patch from my queue and picked patch #2 from this series as
> > the favor.
> 
> I think dropping that patch might cause Linux-next build fail as previously showed,
> because IMX_SCU_SOC depends on COMPILE_TEST. If you drop that patch,
> also need to drop COMPILE_TEST from IMX_SCU_SOC.
> 
>  ld: drivers/soc/imx/soc-imx-scu.o: in function `.imx_scu_soc_probe':
>  soc-imx-scu.c:(.text.imx_scu_soc_probe+0x44): undefined reference to 
> `.imx_scu_get_handle'
>  ld: soc-imx-scu.c:(.text.imx_scu_soc_probe+0x134): undefined reference 
>  to `.imx_scu_call_rpc'
>  ld: soc-imx-scu.c:(.text.imx_scu_soc_probe+0x20c): undefined reference 
>  to `.imx_scu_call_rpc'
>  
>  Caused by commit
>  
>    68c189e3a93c ("soc: imx: increase build coverage for imx8m soc 
>  driver")
> 
> What do you prefer? I personally think dummy functions would be good.

I would rather drop COMPILE_TEST from IMX_SCU_SOC.  Could you send a
patch for that shortly?

Shawn
