Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C551CCC3C
	for <lists+linux-pm@lfdr.de>; Sun, 10 May 2020 18:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgEJQ2f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 May 2020 12:28:35 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40390 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgEJQ2e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 May 2020 12:28:34 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 5E3F1260136
Received: by earth.universe (Postfix, from userid 1000)
        id 7AFFE3C08C7; Sun, 10 May 2020 18:28:31 +0200 (CEST)
Date:   Sun, 10 May 2020 18:28:31 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     David Heidelberg <david@ixit.cz>
Cc:     Jonghwa Lee <jonghwa3.lee@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Myungjoo Ham <myungjoo.ham@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>,
        mika.westerberg@linux.intel.com, ramakrishna.pallala@intel.com,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] power: supply: smb347-charger: Add delay before
 getting IRQSTAT
Message-ID: <20200510162831.xworvkphco4df326@earth.universe>
References: <20200329161552.215075-1-david@ixit.cz>
 <20200329161552.215075-3-david@ixit.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2wdd4sxkkcvwutv5"
Content-Disposition: inline
In-Reply-To: <20200329161552.215075-3-david@ixit.cz>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--2wdd4sxkkcvwutv5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Mar 29, 2020 at 06:15:45PM +0200, David Heidelberg wrote:
> This delay-fix is picked up from downstream driver,
> we measured that 25 - 35 ms delay ensure that we get required data.
>=20
> Tested on SMB347 on Nexus 7 2012. Otherwise IRQSTAT_E fails to provide
> correct information.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/smb347-charger.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply=
/smb347-charger.c
> index d102921b3ab2..f99026d81f2a 100644
> --- a/drivers/power/supply/smb347-charger.c
> +++ b/drivers/power/supply/smb347-charger.c
> @@ -8,6 +8,7 @@
>   *          Mika Westerberg <mika.westerberg@linux.intel.com>
>   */
> =20
> +#include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/gpio.h>
>  #include <linux/kernel.h>
> @@ -708,6 +709,9 @@ static irqreturn_t smb347_interrupt(int irq, void *da=
ta)
>  	bool handled =3D false;
>  	int ret;
> =20
> +	/* SMB347 it needs at least 20ms for setting IRQSTAT_E_*IN_UV_IRQ */
> +	usleep_range(25000, 35000);
> +
>  	ret =3D regmap_read(smb->regmap, STAT_C, &stat_c);
>  	if (ret < 0) {
>  		dev_warn(smb->dev, "reading STAT_C failed\n");
> --=20
> 2.25.0
>=20

--2wdd4sxkkcvwutv5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl64K68ACgkQ2O7X88g7
+pqKGg/+LHZsCE36Y5brqIEr54mNIwAPP4z7p0sR+JPfI3JrhvmAtpmaqr4n4AyV
ltylvdd8FX3Z0YWEX4VSJxmCnWkaQo+hCXd1O1Ow/Zn+KLWbzlvMbDc77fuYWx2f
L6WrCEAzhNtrBjkfvx602ZWjmtu5PgiKujd1E5zUYFNm18w73OyCHYL1blrQvDgA
RkXYqx4y3bo4OrwtwCTgkfldcObhZEv7COkoQwxQZGh2tIn38AgvuF7u7P3tzZ7e
tzWQuGSuJGe2IptP0PB+tgNde3P4tDahc2j3te7JIjbQg92qC6BErfZSuR9uFgjS
UheMm476M/nFbIwm5lrtdEQeCWOaaYymPCpgk7zhxeN0RSISRrVnDZr3XEPtGe/m
AipUHx7+wx3YLXvScbNeIWC16SixBEOzsgaChX4jJKv1MKb6fHst4vTm68mUTg0W
NFI1wWguxLujfRBt+xKDF9op5HSsAT3T+HjOSmECUPUDHYbvgunANyrotApQ7KlK
EG4TNZWGGJJGsYRvCq3m/5cG7V/F9yRMaM9oLSQDgSq1lOpSNOxd91Ph/Vxj4ag6
bXWb2645Ujo39TnQCbs6yhgHn0Kmyvr+8GpyBIRzRJ05eqt9oN9RO6ofg7o6Onmc
8tN3ktllAEBUQ0ivbXZrhsvK1Ack//rpqQh8OSaPTGfwl4ek1GE=
=sbEF
-----END PGP SIGNATURE-----

--2wdd4sxkkcvwutv5--
