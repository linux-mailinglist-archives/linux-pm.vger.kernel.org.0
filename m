Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCF73D340D
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2019 00:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfJJWol (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Oct 2019 18:44:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbfJJWol (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Oct 2019 18:44:41 -0400
Received: from earth.universe (unknown [185.62.205.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ECE82067B;
        Thu, 10 Oct 2019 22:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570747479;
        bh=aUY+2G6kw97wxWvRNj1wmuIasli7uRNKLfj987xjrJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t2wzh37US8FDUoIZ+weJd1nfSJpeQ6euxNPQpUSQ8xARX4Z6GRdippaRKdLUgC/r6
         inne3V2YM0oNlAQ3zkqvVccRTdpgVSPkEgQMDSRAK2FFuWJ/f+OKMC8m+qed6Wmv3w
         rUBHZji9sEdCAyQZkPg+66BMXFjpxS1aLIBfQEeY=
Received: by earth.universe (Postfix, from userid 1000)
        id 586633C0CA1; Fri, 11 Oct 2019 00:44:36 +0200 (CEST)
Date:   Fri, 11 Oct 2019 00:44:36 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-input@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 15/36] ARM: s3c: adc: move header to linux/soc/samsung
Message-ID: <20191010224436.t6gwb5fassr2dymp@earth.universe>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-15-arnd@arndb.de>
 <da32e8a3-cbb3-ea08-1c55-55980b3dc53e@roeck-us.net>
 <20191010222955.GB229325@dtor-ws>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mopqc6x4c2h7s3hb"
Content-Disposition: inline
In-Reply-To: <20191010222955.GB229325@dtor-ws>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--mopqc6x4c2h7s3hb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 10, 2019 at 03:29:55PM -0700, Dmitry Torokhov wrote:
> On Thu, Oct 10, 2019 at 03:20:32PM -0700, Guenter Roeck wrote:
> > On 10/10/19 1:29 PM, Arnd Bergmann wrote:
> > > There are multiple drivers using the private adc interface.
> > > It seems unlikely that they would ever get converted to iio,
> > > so make the current state official by making the header file
> > > global.
> > >=20
> > > The s3c2410_ts driver needs a couple of register definitions
> > > as well.
> > >=20
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >=20
> > For hwmon:
> >=20
> > Acked-by: Guenter Roeck <linux@roeck-us.net>
>=20
> For input:
>=20
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

For power-supply:

Acked-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

> > > ---
> > >   arch/arm/mach-s3c64xx/mach-crag6410.c         |  2 +-
> > >   arch/arm/mach-s3c64xx/mach-mini6410.c         |  2 +-
> > >   arch/arm/mach-s3c64xx/mach-real6410.c         |  2 +-
> > >   arch/arm/mach-s3c64xx/mach-smdk6410.c         |  2 +-
> > >   arch/arm/plat-samsung/adc.c                   |  2 +-
> > >   arch/arm/plat-samsung/devs.c                  |  2 +-
> > >   drivers/hwmon/s3c-hwmon.c                     |  2 +-
> > >   drivers/input/touchscreen/s3c2410_ts.c        | 37 ++++++++++++++++=
++-
> > >   drivers/power/supply/s3c_adc_battery.c        |  2 +-
> > >   .../linux/soc/samsung/s3c-adc.h               |  0
> > >   10 files changed, 43 insertions(+), 10 deletions(-)
> > >   rename arch/arm/plat-samsung/include/plat/adc.h =3D> include/linux/=
soc/samsung/s3c-adc.h (100%)
> > >=20
> > > diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3=
c64xx/mach-crag6410.c
> > > index da5b50981a14..133453562d23 100644
> > > --- a/arch/arm/mach-s3c64xx/mach-crag6410.c
> > > +++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
> > > @@ -57,7 +57,7 @@
> > >   #include <plat/keypad.h>
> > >   #include <plat/devs.h>
> > >   #include <plat/cpu.h>
> > > -#include <plat/adc.h>
> > > +#include <linux/soc/samsung/s3c-adc.h>
> > >   #include <linux/platform_data/i2c-s3c2410.h>
> > >   #include <plat/pm.h>
> > >   #include <plat/samsung-time.h>
> > > diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3=
c64xx/mach-mini6410.c
> > > index 0dd36ae49e6a..c7140300bd3f 100644
> > > --- a/arch/arm/mach-s3c64xx/mach-mini6410.c
> > > +++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
> > > @@ -27,7 +27,7 @@
> > >   #include <mach/regs-gpio.h>
> > >   #include <mach/gpio-samsung.h>
> > > -#include <plat/adc.h>
> > > +#include <linux/soc/samsung/s3c-adc.h>
> > >   #include <plat/cpu.h>
> > >   #include <plat/devs.h>
> > >   #include <plat/fb.h>
> > > diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3=
c64xx/mach-real6410.c
> > > index 0ff88b6859c4..f55097fde94c 100644
> > > --- a/arch/arm/mach-s3c64xx/mach-real6410.c
> > > +++ b/arch/arm/mach-s3c64xx/mach-real6410.c
> > > @@ -29,7 +29,7 @@
> > >   #include <mach/gpio-samsung.h>
> > >   #include <mach/irqs.h>
> > > -#include <plat/adc.h>
> > > +#include <linux/soc/samsung/s3c-adc.h>
> > >   #include <plat/cpu.h>
> > >   #include <plat/devs.h>
> > >   #include <plat/fb.h>
> > > diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3=
c64xx/mach-smdk6410.c
> > > index 95bdcfe95a53..3042f6cbffd9 100644
> > > --- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
> > > +++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
> > > @@ -60,7 +60,7 @@
> > >   #include <plat/devs.h>
> > >   #include <plat/cpu.h>
> > > -#include <plat/adc.h>
> > > +#include <linux/soc/samsung/s3c-adc.h>
> > >   #include <linux/platform_data/touchscreen-s3c2410.h>
> > >   #include <plat/keypad.h>
> > >   #include <plat/samsung-time.h>
> > > diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
> > > index ee3d5c989a76..623a9774cc52 100644
> > > --- a/arch/arm/plat-samsung/adc.c
> > > +++ b/arch/arm/plat-samsung/adc.c
> > > @@ -20,7 +20,7 @@
> > >   #include <linux/regulator/consumer.h>
> > >   #include <plat/regs-adc.h>
> > > -#include <plat/adc.h>
> > > +#include <linux/soc/samsung/s3c-adc.h>
> > >   /* This driver is designed to control the usage of the ADC block be=
tween
> > >    * the touchscreen and any other drivers that may need to use it, s=
uch as
> > > diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/dev=
s.c
> > > index fd94a35e22f8..ddd90f0bb380 100644
> > > --- a/arch/arm/plat-samsung/devs.c
> > > +++ b/arch/arm/plat-samsung/devs.c
> > > @@ -44,7 +44,7 @@
> > >   #include <plat/cpu.h>
> > >   #include <plat/devs.h>
> > > -#include <plat/adc.h>
> > > +#include <linux/soc/samsung/s3c-adc.h>
> > >   #include <linux/platform_data/ata-samsung_cf.h>
> > >   #include <plat/fb.h>
> > >   #include <plat/fb-s3c2410.h>
> > > diff --git a/drivers/hwmon/s3c-hwmon.c b/drivers/hwmon/s3c-hwmon.c
> > > index b490fe3d2ee8..f2703c5460d0 100644
> > > --- a/drivers/hwmon/s3c-hwmon.c
> > > +++ b/drivers/hwmon/s3c-hwmon.c
> > > @@ -20,7 +20,7 @@
> > >   #include <linux/hwmon.h>
> > >   #include <linux/hwmon-sysfs.h>
> > > -#include <plat/adc.h>
> > > +#include <linux/soc/samsung/s3c-adc.h>
> > >   #include <linux/platform_data/hwmon-s3c.h>
> > >   struct s3c_hwmon_attr {
> > > diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/t=
ouchscreen/s3c2410_ts.c
> > > index b346e7cafd62..1a5a178ea286 100644
> > > --- a/drivers/input/touchscreen/s3c2410_ts.c
> > > +++ b/drivers/input/touchscreen/s3c2410_ts.c
> > > @@ -21,10 +21,43 @@
> > >   #include <linux/clk.h>
> > >   #include <linux/io.h>
> > > -#include <plat/adc.h>
> > > -#include <plat/regs-adc.h>
> > > +#include <linux/soc/samsung/s3c-adc.h>
> > >   #include <linux/platform_data/touchscreen-s3c2410.h>
> > > +#define	S3C2410_ADCCON			(0x00)
> > > +#define	S3C2410_ADCTSC			(0x04)
> > > +#define	S3C2410_ADCDLY			(0x08)
> > > +#define	S3C2410_ADCDAT0			(0x0C)
> > > +#define	S3C2410_ADCDAT1			(0x10)
> > > +#define	S3C64XX_ADCUPDN			(0x14)
> > > +#define	S3C2443_ADCMUX			(0x18)
> > > +#define	S3C64XX_ADCCLRINT		(0x18)
> > > +#define	S5P_ADCMUX			(0x1C)
> > > +#define	S3C64XX_ADCCLRINTPNDNUP		(0x20)
> > > +
> > > +/* ADCTSC Register Bits */
> > > +#define S3C2443_ADCTSC_UD_SEN		(1 << 8)
> > > +#define S3C2410_ADCTSC_YM_SEN		(1<<7)
> > > +#define S3C2410_ADCTSC_YP_SEN		(1<<6)
> > > +#define S3C2410_ADCTSC_XM_SEN		(1<<5)
> > > +#define S3C2410_ADCTSC_XP_SEN		(1<<4)
> > > +#define S3C2410_ADCTSC_PULL_UP_DISABLE	(1<<3)
> > > +#define S3C2410_ADCTSC_AUTO_PST		(1<<2)
> > > +#define S3C2410_ADCTSC_XY_PST(x)	(((x)&0x3)<<0)
> > > +
> > > +/* ADCDAT0 Bits */
> > > +#define S3C2410_ADCDAT0_UPDOWN		(1<<15)
> > > +#define S3C2410_ADCDAT0_AUTO_PST	(1<<14)
> > > +#define S3C2410_ADCDAT0_XY_PST		(0x3<<12)
> > > +#define S3C2410_ADCDAT0_XPDATA_MASK	(0x03FF)
> > > +
> > > +/* ADCDAT1 Bits */
> > > +#define S3C2410_ADCDAT1_UPDOWN		(1<<15)
> > > +#define S3C2410_ADCDAT1_AUTO_PST	(1<<14)
> > > +#define S3C2410_ADCDAT1_XY_PST		(0x3<<12)
> > > +#define S3C2410_ADCDAT1_YPDATA_MASK	(0x03FF)
> > > +
> > > +
> > >   #define TSC_SLEEP  (S3C2410_ADCTSC_PULL_UP_DISABLE | S3C2410_ADCTSC=
_XY_PST(0))
> > >   #define INT_DOWN	(0)
> > > diff --git a/drivers/power/supply/s3c_adc_battery.c b/drivers/power/s=
upply/s3c_adc_battery.c
> > > index 3d00b35cafc9..60b7f41ab063 100644
> > > --- a/drivers/power/supply/s3c_adc_battery.c
> > > +++ b/drivers/power/supply/s3c_adc_battery.c
> > > @@ -22,7 +22,7 @@
> > >   #include <linux/init.h>
> > >   #include <linux/module.h>
> > > -#include <plat/adc.h>
> > > +#include <linux/soc/samsung/s3c-adc.h>
> > >   #define BAT_POLL_INTERVAL		10000 /* ms */
> > >   #define JITTER_DELAY			500 /* ms */
> > > diff --git a/arch/arm/plat-samsung/include/plat/adc.h b/include/linux=
/soc/samsung/s3c-adc.h
> > > similarity index 100%
> > > rename from arch/arm/plat-samsung/include/plat/adc.h
> > > rename to include/linux/soc/samsung/s3c-adc.h
> > >=20
> >=20
>=20
> --=20
> Dmitry

--mopqc6x4c2h7s3hb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2ftFAACgkQ2O7X88g7
+ppCxxAAn15YlBwsqaGwUaYchBuBq14qU4EobExBzZbw8oYHQL4I5oAbH2t+3oOa
UrhNrvHnWWftmlq/2ycEzWRk4NOQ8ZES1AD/4r7q56i4QxyV/zk/cRiAjRjcCm5w
IRJEAVVSxyADbMTxK0omr0GW2cIqUlJcRmW5JyqQvXKC5wOXVz3+0C613tQCm0o2
JBSC+HqZkoDAlcBF/6IDcDfy1K+3FEhCEYkvFTPNeh+7I48u7qdLFS6Xf66+kLPW
ccKaSTBw6WV9KLrwf4+sEukRP5QfA0ehVuaV447SiH2n1uzSQlju4w5pRleAwlps
umOd1n1rFcrxBf+TEQS0XsRJ7Oa/h11DXkkLWPtCtA84FXO1IvHGLmkSx3yxRxSz
JIszIsYHyTWwJJNKorhB2PjpSGZoaciwgOE/lt8mgPc5I64MZXvHosV2nlAMsFhJ
LMKyxh69aShi8ylCFBy+ukiC8yXM4CzRNh1chazvB2cjNNB1p6BS/4zAxlTmIvGo
9lUxde12J325Z9peeP6OInu1h1/v+fRfrg2wxsblwCQmdC6eQoWTPTynH9t+WADr
ka6XkZvcoAEoaPji8fyGfY6DUkhiRwSkDpn3bk1zg7nmm5jAlH1MCoMBVrUOKylv
Xp2bULDZLS6KD5LBn+s3bsZ1hatAJpU2746uE4Afal2lgcAnqb4=
=0aUK
-----END PGP SIGNATURE-----

--mopqc6x4c2h7s3hb--
