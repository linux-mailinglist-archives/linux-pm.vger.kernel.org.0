Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09D91A6F91
	for <lists+linux-pm@lfdr.de>; Tue, 14 Apr 2020 01:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389817AbgDMXAy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Apr 2020 19:00:54 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35000 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbgDMXAy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2020 19:00:54 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 6D8E02A0BF3
Received: by earth.universe (Postfix, from userid 1000)
        id 81F083C08C7; Tue, 14 Apr 2020 01:00:50 +0200 (CEST)
Date:   Tue, 14 Apr 2020 01:00:50 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     rafirafi <rafirafi.at@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: axp288_fuel_gauge: Add the Meegopad T02
 to the blacklist.
Message-ID: <20200413230050.e2litrlcvbs6hpar@earth.universe>
References: <20200406140538.11894-1-rafirafi.at@gmail.com>
 <eff57daf-6f71-1f6f-e4f9-5b5b1ed974cd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oazyorwjlp4634pg"
Content-Disposition: inline
In-Reply-To: <eff57daf-6f71-1f6f-e4f9-5b5b1ed974cd@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--oazyorwjlp4634pg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 06, 2020 at 05:44:04PM +0200, Hans de Goede wrote:
> Hi,
>=20
> On 4/6/20 4:05 PM, rafirafi wrote:
> > From: Rafael Gandolfi <rafirafi.at@gmail.com>
> >=20
> >      The Meegopad T02 is a PC in stick format and doesn't have a batter=
y,
> >      it is reported with a random and constant battery charge but as
> >      discharging to userspace.
> >=20
> >      Add it to the blacklist to avoid the bogus battery status reportin=
g.
> >=20
> > Signed-off-by: Rafael Gandolfi <rafirafi.at@gmail.com>
>=20
> Patch looks good to me:
>=20
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Thanks, queued.

-- Sebastian

> > ---
> >   drivers/power/supply/axp288_fuel_gauge.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >=20
> > diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/s=
upply/axp288_fuel_gauge.c
> > index e1bc4e6e6f30..0bc548865a61 100644
> > --- a/drivers/power/supply/axp288_fuel_gauge.c
> > +++ b/drivers/power/supply/axp288_fuel_gauge.c
> > @@ -717,6 +717,12 @@ static const struct dmi_system_id axp288_fuel_gaug=
e_blacklist[] =3D {
> >   			DMI_MATCH(DMI_PRODUCT_NAME, "STK1A32SC"),
> >   		},
> >   	},
> > +	{
> > +		/* Meegopad T02 */
> > +		.matches =3D {
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "MEEGOPAD T02"),
> > +		},
> > +	},
> >   	{
> >   		/* Meegopad T08 */
> >   		.matches =3D {
> >=20
>=20

--oazyorwjlp4634pg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6U7xgACgkQ2O7X88g7
+pp7HA//Yu4Ne8/Ua1k0TUlgQSbJ+4xeJxNMgp+7GEciyHSLQ6pXwqALU/2trs5J
ExFZcox4MID0CAYGgNLdwZ+zSkVqUiUZBUUsxHdvtH7aHv+IC3bNGUvFAOkuQxMP
V0CqgE7Pl2VC6I0gtZtdj8Ni8Di0q/om2WjYap1qOLIiu/WalpH1XCmRWWpMdhPB
e/LTIHljqMp9v1ZUFtwE/fu/1ZH9p0U/AMzml18hbmnkJwQDStb8jF3T0TzlbKSA
sv8tG/PhZt6qwzDrQ8AO5sEJ+QUQ2PyWp4Sys7dgUZq6Pt08SoOabLbyOo8WuctO
t1t87oUKkVRbbfirqntqcj/Tmkk2TWrlsXVsq9YA44CYK0SllMoawv6xFa9hI/yH
ow3cM1zPXfqYNbSnKyZukfEIM4gCSU0POJbryxaLHk+cDbThO0hPouZ8Q0ngr+ay
M5ucr1mitaabPUAl7gMgSXVLqQ3NRlkHVBXaNU+Y7k81QCwxdjdcB7qoJzGXacBd
snp1h+Kt6ZyW50OO8MOtaKWjOkJ7NSVULilRgPZTff8sRCWCI4+6a8fWuyyLVMSn
3rZApyibT39DZ2gBu4lYmwRlRN6156DtWY1AcXv/NNEScz+oNdGPM5tZeCgsxGso
XNOlPXmSCFN3HjbAwEabQFpVbeZ4lI0C4i5ISPW4FKy2HnQXe9o=
=2Okk
-----END PGP SIGNATURE-----

--oazyorwjlp4634pg--
