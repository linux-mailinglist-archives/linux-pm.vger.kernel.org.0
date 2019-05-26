Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD1A2A794
	for <lists+linux-pm@lfdr.de>; Sun, 26 May 2019 03:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfEZBYs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 25 May 2019 21:24:48 -0400
Received: from vps.xff.cz ([195.181.215.36]:53546 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727474AbfEZBYr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 25 May 2019 21:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1558833885; bh=vvKWkGbp9K2vIliSPzvDEraQISpPMpRwGfH6Zi4LJd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oxb0w8/z/TFyS6ZmcEarY5+TIxaVwuNA6TUXSEQ3SiFSPdI/nMZGijsppYnTUG/M/
         lJ2b9JECtdxy4o8UojXPuIIlNXC6gmmHHJ+vdmvGbF86+mefO7jPQKGGlcyjWBodep
         cXx0Gle207O0oDNP0DPNyf+RzVduWqxpfr9U+FJI=
Date:   Sun, 26 May 2019 03:24:44 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, robh+dt@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, catalin.marinas@arm.com,
        will.deacon@arm.com, David Miller <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan.Cameron@huawei.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        paulmck@linux.ibm.com, Andy Gross <andy.gross@linaro.org>,
        olof@lixom.net, bjorn.andersson@linaro.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        marc.w.gonzalez@free.fr, stefan.wahren@i2se.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 2/3] thermal: sun50i: add thermal driver for h6
Message-ID: <20190526012444.yrcellg3xdrt3bo5@core.my.home>
Mail-Followup-To: Frank Lee <tiny.windzz@gmail.com>, rui.zhang@intel.com,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, robh+dt@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, catalin.marinas@arm.com,
        will.deacon@arm.com, David Miller <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan.Cameron@huawei.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>, paulmck@linux.ibm.com,
        Andy Gross <andy.gross@linaro.org>, olof@lixom.net,
        bjorn.andersson@linaro.org, Jagan Teki <jagan@amarulasolutions.com>,
        marc.w.gonzalez@free.fr, stefan.wahren@i2se.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20190512082614.9045-1-tiny.windzz@gmail.com>
 <20190512082614.9045-3-tiny.windzz@gmail.com>
 <20190512221612.ubmknvim4utnqpl4@core.my.home>
 <CAEExFWv5A5mhpV7afQT=AaYx2ko5QnfbM6HvfuTgT1Na=ssOcw@mail.gmail.com>
 <20190516182936.h6xdzp3gtg4ikave@core.my.home>
 <CAEExFWvDO3wJd6wp1hFudf3EGF0NixgKAwAd5-b1=VLF+7-jCw@mail.gmail.com>
 <20190519142239.eolisexp5mrdyafz@core.my.home>
 <CAEExFWsc_YB8NORW4ULfuoicL=xr_oAdtHSaxz4ELv53qvCAsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEExFWsc_YB8NORW4ULfuoicL=xr_oAdtHSaxz4ELv53qvCAsQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Yangtao,

On Sun, May 26, 2019 at 02:48:13AM +0800, Frank Lee wrote:
> On Sun, May 19, 2019 at 10:22 PM Ondřej Jirman <megous@megous.com> wrote:
> >
> > I know, I don't think it needs to be per-soc. These actions are all shared by
> > all SoCs. Maybe with an exception that some SoCs may need one more clock, but
> > that can be made optionally-required by some flag in struct sunxi_thermal_chip.
> >
> > Only highly SoC specific thing is configuring the THS registers for sampling
> > frequency/averaging/enabling interrupts. The reset/clock enable is generic, and
> > already abstracted by the clock/reset framework.
> >
> > So what I suggest is having:
> >
> > sunxi_ths_enable()
> >         reset deassert
> >         bus clock prepare enable
> >         optionally module clock prepare enable (in the future)
> >         call per-soc calibration
> >         call per-soc setup callback
> >
> > sunxi_ths_disable()
> >         reset assert
> >         bus clock unprepare disable
> >         optionally module clock unprepare disable
> >
> > And if you could move devm_nvmem_cell_get to probe that should make per-SoC
> > calibration callback also less repetitive and could avoid undoing the enable
> > in case it returns EPROBE_DEFER (which is possible).
> >
> > All this should make it easier to support PM in the future and add less
> > cumbersome to add support for A83T and H3/H5.
> >
> > BTW, what are your plans for more SoC support? I'd like to add support for
> > A83T and H3/H5, maybe even during the 5.3 cycle if this driver happens to land
> > early enough. If you don't have any plans I'll take it on.
> >
> 
> I plan to support h3 and a33 later.
> Can you support other platforms?

Yes, I can do A83T. H5 is similar (the same?) as H3.

thank you and regards,
	o.

> Cheers,
> Yangtao
> 
> > thank you and regards,
> >         o.
> >
> > > >
> > > > thank you and regards,
> > > >         o.
> > > >
> > > > > Regards,
> > > > > Yangtao
> > >
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
