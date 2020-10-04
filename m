Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1864282DE1
	for <lists+linux-pm@lfdr.de>; Mon,  5 Oct 2020 00:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgJDWDG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Oct 2020 18:03:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbgJDWDG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 4 Oct 2020 18:03:06 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01CD5206DD;
        Sun,  4 Oct 2020 22:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601848985;
        bh=KWCH2wJsLdydHXf9KYTqMRIiOM9c4q18hCLJYIMjicA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rn6opjJzIbU9sRSjRzpoOyMVra1PDYiem7pA3dtSQpr/GtYwHS9ft8VzLK66/wTyf
         WAsQqiAjPiB2answIqUvOAhz52sK/itjcmI1pwHvczPK4/eVlvruQiMCUz6Q6AbaXx
         Tn54jMRCyUBtFr8zA+Kh/mHjEITVfaMqJbBGHgzw=
Received: by earth.universe (Postfix, from userid 1000)
        id 837003C0C87; Mon,  5 Oct 2020 00:03:02 +0200 (CEST)
Date:   Mon, 5 Oct 2020 00:03:02 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/3] power: supply: Constify static w1_family_ops structs
Message-ID: <20201004220302.vswyqayj5u5yxl5u@earth.universe>
References: <20201004193202.4044-1-rikard.falkeborn@gmail.com>
 <20201004193202.4044-4-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bbpxyhpt2vjyiffu"
Content-Disposition: inline
In-Reply-To: <20201004193202.4044-4-rikard.falkeborn@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--bbpxyhpt2vjyiffu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Oct 04, 2020 at 09:32:02PM +0200, Rikard Falkeborn wrote:
> The only usage of these structs is to assign their address to the fops
> field in the w1_family struct, which is a const pointer. Make them const
> to allow the compiler to put them in read-only memory.
>=20
> This was done with the following Coccinelle semantic patch
> (http://coccinelle.lip6.fr/):
>=20
> // <smpl>
> @r1 disable optional_qualifier @
> identifier i;
> position p;
> @@
> static struct w1_family_ops i@p =3D {...};
>=20
> @ok1@
> identifier r1.i;
> position p;
> identifier s;
> @@
> static struct w1_family s =3D {
> 	.fops=3D&i@p,
> };
>=20
> @bad1@
> position p!=3D{r1.p,ok1.p};
> identifier r1.i;
> @@
> i@p
>=20
> @depends on !bad1 disable optional_qualifier@
> identifier r1.i;
> @@
> static
> +const
> struct w1_family_ops i=3D{};
> // </smpl>
>=20
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---

I suggest that this simply goes through the w1 tree together
with the other patches:

Acked-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

>  drivers/power/supply/bq27xxx_battery_hdq.c | 2 +-
>  drivers/power/supply/ds2760_battery.c      | 2 +-
>  drivers/power/supply/max1721x_battery.c    | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery_hdq.c b/drivers/power/s=
upply/bq27xxx_battery_hdq.c
> index 12b10dad77d3..922759ab2e04 100644
> --- a/drivers/power/supply/bq27xxx_battery_hdq.c
> +++ b/drivers/power/supply/bq27xxx_battery_hdq.c
> @@ -97,7 +97,7 @@ static void bq27xxx_battery_hdq_remove_slave(struct w1_=
slave *sl)
>  	bq27xxx_battery_teardown(di);
>  }
> =20
> -static struct w1_family_ops bq27xxx_battery_hdq_fops =3D {
> +static const struct w1_family_ops bq27xxx_battery_hdq_fops =3D {
>  	.add_slave	=3D bq27xxx_battery_hdq_add_slave,
>  	.remove_slave	=3D bq27xxx_battery_hdq_remove_slave,
>  };
> diff --git a/drivers/power/supply/ds2760_battery.c b/drivers/power/supply=
/ds2760_battery.c
> index 11bed88a89fa..695bb6747400 100644
> --- a/drivers/power/supply/ds2760_battery.c
> +++ b/drivers/power/supply/ds2760_battery.c
> @@ -795,7 +795,7 @@ static const struct of_device_id w1_ds2760_of_ids[] =
=3D {
>  };
>  #endif
> =20
> -static struct w1_family_ops w1_ds2760_fops =3D {
> +static const struct w1_family_ops w1_ds2760_fops =3D {
>  	.add_slave	=3D w1_ds2760_add_slave,
>  	.remove_slave	=3D w1_ds2760_remove_slave,
>  	.groups		=3D w1_ds2760_groups,
> diff --git a/drivers/power/supply/max1721x_battery.c b/drivers/power/supp=
ly/max1721x_battery.c
> index 9ca895b0dabb..1b1a36f8e929 100644
> --- a/drivers/power/supply/max1721x_battery.c
> +++ b/drivers/power/supply/max1721x_battery.c
> @@ -431,7 +431,7 @@ static int devm_w1_max1721x_add_device(struct w1_slav=
e *sl)
>  	return 0;
>  }
> =20
> -static struct w1_family_ops w1_max1721x_fops =3D {
> +static const struct w1_family_ops w1_max1721x_fops =3D {
>  	.add_slave =3D devm_w1_max1721x_add_device,
>  };
> =20
> --=20
> 2.28.0
>=20

--bbpxyhpt2vjyiffu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl96RpYACgkQ2O7X88g7
+pqZZg/9E2d8vmKUUOMvpMHJcMCFqRZ5S3hqRbCKHcCHEgA1Dt3zK2lEILe/E4XJ
qBb2EdfLwbHfQjdrrXD/D8VGJtFFjSNfTTXNBs9E8kVYP2H69O7Nm6Yp4RsNvvV8
xT6X4tibWf/RokuP+ouj4dpYeN60qyfm7rcOImm//yhKUtfCXfoWhKum1JwIzcGm
K0TMLzjFz1ZfNC38nH7iek2oGVZxzxR21Y7Z2k+qBFLUvA80yKmUOXXbyRJnRvin
PXcL7+BoMJ0eG+D4LIlM2QBsele5iaZsln1zuE7tLJjJiWoYaYqQbVTtcSdo76Rx
eA8n6i+cN4J3yhPl8I4BcxIY7bbuWY4ZIPYGX2nD1QTK+Eu8Z6uYuH2Yp3sVl/mJ
nNO8osPdnCIrJD1bThGp+hQlzSs587NNrzHW1lhu3g4ZxP7ce7tfCEIoZFyKkxJI
Elrwt0cmTcNQQKa0FsbTPy5SFLEJ+FBa0mvosK3XNreKzCoHXd9L4MNHfAY5g/bc
zyDO81WHQoZp+C1zx+U0qVwZdx7rNEJqVS3DL79EqF5uBKp5kB9CsIsSECvYVo9m
cIUV5f5a8SeBIob4q8IRyg2HgQeewuQLL8gy16t/Re1qEPWwaG+8iPreXMVLM3W1
lj1UgX3keLHC84NMmOwxZSCfMdxeS6AaJ3wyBi5tV9quMEH5K34=
=0hQc
-----END PGP SIGNATURE-----

--bbpxyhpt2vjyiffu--
