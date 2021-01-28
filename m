Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6334830686D
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jan 2021 01:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhA1AM4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 19:12:56 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36306 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbhA1ALv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2021 19:11:51 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id D5F161F4560D
Received: by earth.universe (Postfix, from userid 1000)
        id 7A29E3C0C97; Thu, 28 Jan 2021 01:10:57 +0100 (CET)
Date:   Thu, 28 Jan 2021 01:10:57 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Marcus Cooper <codekipper@gmail.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 05/10] power: supply: ab8500: Move to componentized
 binding
Message-ID: <20210128001057.urzxmx6f53qrek4o@earth.universe>
References: <20210123221908.2993388-1-linus.walleij@linaro.org>
 <20210123221908.2993388-6-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hn2idq3ef4spysyr"
Content-Disposition: inline
In-Reply-To: <20210123221908.2993388-6-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--hn2idq3ef4spysyr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jan 23, 2021 at 11:19:03PM +0100, Linus Walleij wrote:
> The driver has problems with the different components of
> the charging code racing with each other to probe().
>=20
> This results in all four subdrivers populating battery
> information to ascertain that it is populated for their
> own needs for example.
>=20
> Fix this by using component probing and thus expressing
> to the kernel that these are dependent components.
> The probes can happen in any order and will only acquire
> resources such as state container, regulators and
> interrupts and initialize the data structures, but no
> execution happens until the .bind() callback is called.
>=20
> The charging driver is the main component and binds
> first, then bind in order the three subcomponents:
> ab8500-fg, ab8500-btemp and ab8500-chargalg.
>=20
> Do some housekeeping while we are moving the code around.
> Like use devm_* for IRQs so as to cut down on some
> boilerplate.
>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

[...]

> +	ret =3D component_bind_all(dev, di);
> +        if (ret) {

^^^ typo (prefixed with space)

> +		dev_err(dev, "can't bind component devices\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +

[...]

> +	mutex_lock(&di->charger_attached_mutex);
> =20
> -	/* Register interrupts */
> -	for (i =3D 0; i < ARRAY_SIZE(ab8500_charger_irq); i++) {
> -		irq =3D platform_get_irq_byname(pdev, ab8500_charger_irq[i].name);
> -		if (irq < 0) {
> -			ret =3D irq;
> -			goto free_irq;
> -		}
> +	mutex_unlock(&di->charger_attached_mutex);

what's the purpose of this empty mutex lock/unlock?

-- Sebastian

--hn2idq3ef4spysyr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmASAREACgkQ2O7X88g7
+ppelxAAnijnHh+bolHeRIY1iqsV8I0FEb/CiiUJbUD6JA1XZerq+NIF859DRR5O
CR6AnMrMmKIOr2FhZ3aVJsdwwDEyB4tBK6sPBpj9ukEzRcXgeL8lk04A1Db7DIkz
ImMN/tg9MTee6B9gcHG8lyVDWjlsYyPxGhDiIgOJVOhMyCyKX/4b9j/NcD9uIO6e
YFZVYlkRxoxocGJQDRc7JgGZB0TnGBTLI5bXVJkDZ2LkQE55uhCFRyGdJHu8aPxE
nWSCK+dudVTKmP/D8o7DDdjRgpuQ84R10T08njrMzmPHvCbSolzcb+bj8DgFGDn4
HgBoEiG7aR9jQtEHiW1A+yof8iwfuoGVTQzAQNCIfm5jomPCz8hcFnzKf9+VS72G
DUoFOYMKYgyQa2KfrrDUn7n3KkKAUEl6cdwGSiMygX9j24Y2qRq24VJ5z9XO+G6N
GItjpBhu/teFCUPDZr7JhB1hrw3ZqZNEoq34gdbT6zmQb3SWs86Q6BMeNHr29zJq
CilDfHkGChPi6+3/xR5VaAasAJo0fKn920pX0pmq5Q63ZGBkWjYu0jrVjgj9SSbF
Tqvvx/71RUXS0a07tvHj0Ifikb4eXFpwtMl+nz1KUdVil1WHaFdjC9AT63+3UYtR
AZk7XxCraovNqxCMJ0IKGLbIewoABJ20y5NGqJUypvK5apfg2RE=
=vQiT
-----END PGP SIGNATURE-----

--hn2idq3ef4spysyr--
