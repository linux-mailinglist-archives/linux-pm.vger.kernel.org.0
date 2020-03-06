Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0B4B17C74A
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 21:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgCFUup (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 15:50:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:40850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgCFUup (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Mar 2020 15:50:45 -0500
Received: from earth.universe (unknown [185.62.205.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7727F206CC;
        Fri,  6 Mar 2020 20:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583527844;
        bh=VkUP9Q+Mn2o4gz47rGdxcY/6eRhZc0rNqE4IDaWv0vs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vXDjPFb4Xo/E20iCoeXFXnr/zM7AYG4epGw0pfkOPBqFbYhciP0Pr4YjcWcX696Te
         qrL7yCLMo8sqb45A0jSKJIOvC0/kRolJcu74YR7hDobFHT7qC+l4SkAO6E0mGyMREn
         98Q/lzF60jf4Xo3gMQ2dKUFIgWcksjhLXDzYEBwo=
Received: by earth.universe (Postfix, from userid 1000)
        id 115153C0C83; Fri,  6 Mar 2020 21:50:41 +0100 (CET)
Date:   Fri, 6 Mar 2020 21:50:41 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jeffery Miller <jmiller@neverware.com>, linux-pm@vger.kernel.org,
        jefferym@gmail.com
Subject: Re: [PATCH] power: supply: axp288_fuel_gauge: Broaden vendor check
 for Intel Compute Sticks.
Message-ID: <20200306205041.b33q6qsweyesx5nn@earth.universe>
References: <20200225225941.2038378-1-jmiller@neverware.com>
 <e0340a1c-a60e-a7de-e12f-66f363b77096@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7uq6ehenacyhsxho"
Content-Disposition: inline
In-Reply-To: <e0340a1c-a60e-a7de-e12f-66f363b77096@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--7uq6ehenacyhsxho
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 26, 2020 at 01:36:53PM +0100, Hans de Goede wrote:
> On 2/25/20 11:59 PM, Jeffery Miller wrote:
> > The Intel Compute Stick `STK1A32SC` can have a system vendor of
> > "Intel(R) Client Systems".
> > Broaden the Intel Compute Stick DMI checks so that they match "Intel
> > Corporation" as well as "Intel(R) Client Systems".
> >=20
> > This fixes an issue where the STK1A32SC compute sticks were still
> > exposing a battery with the existing blacklist entry.
> >=20
> > Signed-off-by: Jeffery Miller <jmiller@neverware.com>
>=20
> Thank you for the patch. The patch looks good to me:
>=20
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Thanks, queued.

-- Sebastian

> > ---
> >=20
> > I've tested this primarily with a 4.19 kernel on Intel Compute Sticks
> > with the "Intel(R) Client Systems" vendor.
> >=20
> >   drivers/power/supply/axp288_fuel_gauge.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/s=
upply/axp288_fuel_gauge.c
> > index e1bc4e6e6f30..f40fa0e63b6e 100644
> > --- a/drivers/power/supply/axp288_fuel_gauge.c
> > +++ b/drivers/power/supply/axp288_fuel_gauge.c
> > @@ -706,14 +706,14 @@ static const struct dmi_system_id axp288_fuel_gau=
ge_blacklist[] =3D {
> >   	{
> >   		/* Intel Cherry Trail Compute Stick, Windows version */
> >   		.matches =3D {
> > -			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Intel"),
> >   			DMI_MATCH(DMI_PRODUCT_NAME, "STK1AW32SC"),
> >   		},
> >   	},
> >   	{
> >   		/* Intel Cherry Trail Compute Stick, version without an OS */
> >   		.matches =3D {
> > -			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Intel"),
> >   			DMI_MATCH(DMI_PRODUCT_NAME, "STK1A32SC"),
> >   		},
> >   	},
> >=20
>=20

--7uq6ehenacyhsxho
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl5it6AACgkQ2O7X88g7
+pp8DQ//Tq0hUvKkhdw0s2eE5K/htvpayk1u13gtfTexyUJpspnJP0t3RHANYnc4
OE6y9LRGCO1dQt/+ADOXAjnEWEztts231fg7ZNz1Ripx/TN57evk+m/J8AITBrWS
oMcbQwJIZaopsTm1Da0nslxuOeD10ERbp1U9iEByYrJrYLciasznc2XIFbtCLftH
r/wLa4EF0EQWj8ncGWN+Ta02EI9bDeZlbMdtmAokc5HbaIsFHy9Y0Tubf0HUAy0w
aE+p2t2Bpzrja93DnzBZ7uF95UGn/xqGmGl2K9LrDKYO5NlqEgp8V5FtThZhJyc2
lvrWoU2EqyfSOlWxsH7eqFexxMbSOKMBoLxaTERsHmStuvGUnllyd/S3hAQkKI25
nDrnC0HrrwYn4zQ/g2emu00vi1e2JtVJVjKGmr0Uv3QxnW05gZeJG3KveMV1nXJV
r5LpgH80u6mEtyAcHZQrHf9a+lBDqRe+LJAVzN43vabLiQgCfzd0z9zwiY8fy2OA
0iDsbjOtAZZpriNc8Rkw4Ktbz+U2y4ItBTbEQySZOtQN6sZkCjd+JajbtCEBo9DI
NHahHhrsWntiLSjdCz09OkU1DCq2G1ziYBm6sg8WZDGvs3aj+gLq52PzJdYUXvKZ
fmWjqPboVguLXXIB85skeYHAGB0lzyLQj+KldsJJYj2Pew/rg0U=
=4XtT
-----END PGP SIGNATURE-----

--7uq6ehenacyhsxho--
