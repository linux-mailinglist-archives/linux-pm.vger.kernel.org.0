Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB02E612E3
	for <lists+linux-pm@lfdr.de>; Sat,  6 Jul 2019 22:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfGFUEa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 6 Jul 2019 16:04:30 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:40343 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfGFUEa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 6 Jul 2019 16:04:30 -0400
X-Originating-IP: 90.65.161.137
Received: from localhost (lfbn-1-1545-137.w90-65.abo.wanadoo.fr [90.65.161.137])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 4B50AE0003;
        Sat,  6 Jul 2019 20:04:20 +0000 (UTC)
Date:   Sat, 6 Jul 2019 22:04:20 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        Eddie Huang <eddie.huang@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Josef Friedl <josef.friedl@speed.at>
Subject: Re: Re: Re: [PATCH v2 3/7] rtc: mt6397: improvements of rtc driver
Message-ID: <20190706200420.GE12409@piout.net>
References: <20190703164822.17924-1-frank-w@public-files.de>
 <20190703164822.17924-4-frank-w@public-files.de>
 <20190704204336.GJ3692@piout.net>
 <trinity-7b1977bd-252b-4482-b708-cf704a9d3da1-1562340946396@3c-app-gmx-bs68>
 <20190705212448.GB12409@piout.net>
 <trinity-a4e5f99f-00bc-4e90-9a48-64dbc6ba9c08-1562429720701@3c-app-gmx-bs42>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-a4e5f99f-00bc-4e90-9a48-64dbc6ba9c08-1562429720701@3c-app-gmx-bs42>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/07/2019 18:15:20+0200, Frank Wunderlich wrote:
> > Gesendet: Freitag, 05. Juli 2019 um 23:24 Uhr
> > Von: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
> 
> > Let's say the RTC has been used to start your platform, then the irq
> > handler will be called as soon as the irq is requested, leading to a
> > null pointer dereference.
> 
> i cannot test this with my platform, but i have changed it in my repo
> 
> https://github.com/frank-w/BPI-R2-4.14/commits/5.2-poweroff-mainline
> 
> > Yes and IIRC, I did comment that the rtc change also had to be separated
> > from 1/7.
> 
> also this is put in separate commit, can you take a look before i post v3?
> 
> > Also, I really doubt this new compatible is necessary at all as you
> > could simply directly use mediatek,mt6397-rtc.
> 
> imho this can confuse because the wrong chip-name is used in dts
> 

This is not true, we do that all the time and the immediate benefit of
using the mt6397 compatible is that then there is no need to
synchronize between subsystems. If you want to be absolutely
conservative, you could use

compatible = "mediatek,mt6323-rtc", "mediatek,mt6397-rtc";

in your DT.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
