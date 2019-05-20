Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEE3C231DE
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2019 13:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731353AbfETK7o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 May 2019 06:59:44 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:56389 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731332AbfETK7o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 May 2019 06:59:44 -0400
X-Originating-IP: 90.88.22.185
Received: from localhost (aaubervilliers-681-1-80-185.w90-88.abo.wanadoo.fr [90.88.22.185])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 561FC1C000A;
        Mon, 20 May 2019 10:59:32 +0000 (UTC)
Date:   Mon, 20 May 2019 12:59:31 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Frank Lee <tiny.windzz@gmail.com>, rui.zhang@intel.com,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, robh+dt@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
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
Message-ID: <20190520105931.5xa4j3hhxadtgxie@flea>
References: <20190512082614.9045-1-tiny.windzz@gmail.com>
 <20190512082614.9045-3-tiny.windzz@gmail.com>
 <20190512221612.ubmknvim4utnqpl4@core.my.home>
 <CAEExFWv5A5mhpV7afQT=AaYx2ko5QnfbM6HvfuTgT1Na=ssOcw@mail.gmail.com>
 <20190516182936.h6xdzp3gtg4ikave@core.my.home>
 <CAEExFWvDO3wJd6wp1hFudf3EGF0NixgKAwAd5-b1=VLF+7-jCw@mail.gmail.com>
 <20190519142239.eolisexp5mrdyafz@core.my.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cs6fqv7etllvtecf"
Content-Disposition: inline
In-Reply-To: <20190519142239.eolisexp5mrdyafz@core.my.home>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--cs6fqv7etllvtecf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 19, 2019 at 04:22:39PM +0200, Ond=C5=99ej Jirman wrote:
> On Sat, May 18, 2019 at 12:34:57AM +0800, Frank Lee wrote:
> > HI,
> >
> > On Fri, May 17, 2019 at 2:29 AM Ond=C5=99ej Jirman <megous@megous.com> =
wrote:
> > >
> > > Hi Yangtao,
> > >
> > > thank you for work on this driver.
> > >
> > > On Fri, May 17, 2019 at 02:06:53AM +0800, Frank Lee wrote:
> > > > HI Ond=C5=99ej,
> > > >
> > > > On Mon, May 13, 2019 at 6:16 AM Ond=C5=99ej Jirman <megous@megous.c=
om> wrote:
> > > > > > +
> > > > > > +/* Temp Unit: millidegree Celsius */
> > > > > > +static int tsens_reg2temp(struct tsens_device *tmdev,
> > > > > > +                           int reg)
> > > > >
> > > > > Please name all functions so that they are more clearly identifia=
ble
> > > > > in stack traces as belonging to this driver. For example:
> > > > >
> > > > >   sun8i_ths_reg2temp
> > > > >
> > > > > The same applies for all tsens_* functions below. tsens_* is too
> > > > > generic.
> > > >
> > > > Done but no sun8i_ths_reg2temp.
> > > >
> > > > ths_reg2tem() should be a generic func.
> > > > I think it should be suitable for all platforms=EF=BC=8C so no plat=
form prefix.
> > >
> > > You've missed my point. The driver name is sun8i_thermal and if you g=
et
> > > and oops from the kernel you'll get a stack trace where there are jus=
t function
> > > names. If you use too generic function names, it will not be clear wh=
ich
> > > driver is oopsing.
> > >
> > >   - sun8i_ths_reg2temp will tell you much more clearly where to searc=
h than
> > >   - ths_reg2temp
> > >
> > > Of course you can always grep, but most thermal drivers are thermal s=
ensor (ths)
> > > drivers, and if multiple of them used this too-generic naming scheme =
you'd
> > > have hard time debugging.
> > >
> > > Look at other thermal drivers. They usually encode driver name in the=
 function
> > > names to help with identification (even if these are static driver-lo=
cal
> > > functions).
> > >
> >
> > Can we change to sunxi_ths_ prefix?
>
> It should probably match the driver name, but yes, that's better.

Not really. This driver will not support all the Allwinner devices, so
sunxi is seriously misleading.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--cs6fqv7etllvtecf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXOKIjwAKCRDj7w1vZxhR
xTP8APwM6R/JGZlZh8LDRMjlyCgFBIRiGljCGv2QrzA5AEuMMQD+K7kvKFJY3y7e
kwh8XD4UChjl2L6sIApfpG0X2XN63Qc=
=BTfA
-----END PGP SIGNATURE-----

--cs6fqv7etllvtecf--
