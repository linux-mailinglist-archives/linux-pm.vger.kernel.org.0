Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F0A454BAB
	for <lists+linux-pm@lfdr.de>; Wed, 17 Nov 2021 18:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239185AbhKQRNn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 12:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239180AbhKQRNl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 12:13:41 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CEAC061570
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 09:10:41 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id EB68C1F4637E
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637169040; bh=2HVh9Tqdf1v9cIJ6wfMqZOdoPerxWvzNw5C9kJOd7Dk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZTJycUVujlv8oVFB9fnCEjhk6kt+d10X2p9/ItE/d03sH1fXrfYoWaKWtuS+li1Q8
         ouzbgEfow7UHXaEpxx/SgGo88xgWCiFvNNkjfpX5O7A1Av1cQ93dB4TW432KH8Ro2f
         V0gnfPzXTCBYi0rOXyodu3vHZxECPVz4SBYszvZtXx0TytWV12El17SHh7la88F8nd
         gyXEd0FA8L6nqlcTvlA+jt5OsRZlQEcav/EcjDAtKNnPhubOSVMhkx/vs/YWIWD7H0
         NNO/bMqAcnRCOD5V/mFbZ/p85T+p0hh0Bw45NstoxHotIxS4j/hsF2WlRH5/uilKqF
         pGnLCg1PDRNcg==
Received: by earth.universe (Postfix, from userid 1000)
        id 25E963C0F9E; Wed, 17 Nov 2021 18:10:38 +0100 (CET)
Date:   Wed, 17 Nov 2021 18:10:38 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>, linux-pm@vger.kernel.org,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH v4] power: supply: core: Use library interpolation
Message-ID: <20211117171038.wo52dlrmefjdohot@earth.universe>
References: <20211116230233.2167104-1-linus.walleij@linaro.org>
 <6919ca6d-0952-fbef-bdfc-f9e93fa17707@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fesngtrrrtp56grc"
Content-Disposition: inline
In-Reply-To: <6919ca6d-0952-fbef-bdfc-f9e93fa17707@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--fesngtrrrtp56grc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 17, 2021 at 09:33:15AM +0800, Baolin Wang wrote:
> On 2021/11/17 7:02, Linus Walleij wrote:
> > The power supply core appears to contain two open coded
> > linear interpolations. Use the kernel fixpoint arithmetic
> > interpolation library function instead.
> >=20
> > Cc: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> LGTM. Thanks :)
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Thanks, queued.

-- Sebastian

> > ---
> > ChangeLog v3->v4:
> > - Fix the code to really provide the same x index for both
> >    datapoints at the end of the table. Thanks again Baolin!
> > ChangeLog v2->v3:
> > - Actually implement the code as I say. Missed one occurence.
> > ChangeLog v1->v2:
> > - Break the table loop at table_len - 1 so we don't index
> >    past the end of the table. (Thanks Baolin!)
> >=20
> > Chunyan: The sc27xx fuel gauge seems to be the only driver
> > using this, so it'd be great if you could test this to make
> > sure it works as intended.
> > ---
> >   drivers/power/supply/power_supply_core.c | 61 ++++++++++++------------
> >   1 file changed, 31 insertions(+), 30 deletions(-)
> >=20
> > diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/s=
upply/power_supply_core.c
> > index fc12a4f407f4..2907b84ceea9 100644
> > --- a/drivers/power/supply/power_supply_core.c
> > +++ b/drivers/power/supply/power_supply_core.c
> > @@ -21,6 +21,7 @@
> >   #include <linux/power_supply.h>
> >   #include <linux/property.h>
> >   #include <linux/thermal.h>
> > +#include <linux/fixp-arith.h>
> >   #include "power_supply.h"
> >   /* exported for the APM Power driver, APM emulation */
> > @@ -783,26 +784,25 @@ EXPORT_SYMBOL_GPL(power_supply_put_battery_info);
> >   int power_supply_temp2resist_simple(struct power_supply_resistance_te=
mp_table *table,
> >   				    int table_len, int temp)
> >   {
> > -	int i, resist;
> > +	int i, high, low;
> > -	for (i =3D 0; i < table_len; i++)
> > +	/* Break loop at table_len - 1 because that is the highest index */
> > +	for (i =3D 0; i < table_len - 1; i++)
> >   		if (temp > table[i].temp)
> >   			break;
> > -	if (i > 0 && i < table_len) {
> > -		int tmp;
> > -
> > -		tmp =3D (table[i - 1].resistance - table[i].resistance) *
> > -			(temp - table[i].temp);
> > -		tmp /=3D table[i - 1].temp - table[i].temp;
> > -		resist =3D tmp + table[i].resistance;
> > -	} else if (i =3D=3D 0) {
> > -		resist =3D table[0].resistance;
> > -	} else {
> > -		resist =3D table[table_len - 1].resistance;
> > -	}
> > -
> > -	return resist;
> > +	/* The library function will deal with high =3D=3D low */
> > +	if ((i =3D=3D 0) || (i =3D=3D (table_len - 1)))
> > +		high =3D i;
> > +	else
> > +		high =3D i - 1;
> > +	low =3D i;
> > +
> > +	return fixp_linear_interpolate(table[low].temp,
> > +				       table[low].resistance,
> > +				       table[high].temp,
> > +				       table[high].resistance,
> > +				       temp);
> >   }
> >   EXPORT_SYMBOL_GPL(power_supply_temp2resist_simple);
> > @@ -821,24 +821,25 @@ EXPORT_SYMBOL_GPL(power_supply_temp2resist_simple=
);
> >   int power_supply_ocv2cap_simple(struct power_supply_battery_ocv_table=
 *table,
> >   				int table_len, int ocv)
> >   {
> > -	int i, cap, tmp;
> > +	int i, high, low;
> > -	for (i =3D 0; i < table_len; i++)
> > +	/* Break loop at table_len - 1 because that is the highest index */
> > +	for (i =3D 0; i < table_len - 1; i++)
> >   		if (ocv > table[i].ocv)
> >   			break;
> > -	if (i > 0 && i < table_len) {
> > -		tmp =3D (table[i - 1].capacity - table[i].capacity) *
> > -			(ocv - table[i].ocv);
> > -		tmp /=3D table[i - 1].ocv - table[i].ocv;
> > -		cap =3D tmp + table[i].capacity;
> > -	} else if (i =3D=3D 0) {
> > -		cap =3D table[0].capacity;
> > -	} else {
> > -		cap =3D table[table_len - 1].capacity;
> > -	}
> > -
> > -	return cap;
> > +	/* The library function will deal with high =3D=3D low */
> > +	if ((i =3D=3D 0) || (i =3D=3D (table_len - 1)))
> > +		high =3D i - 1;
> > +	else
> > +		high =3D i; /* i.e. i =3D=3D 0 */
> > +	low =3D i;
> > +
> > +	return fixp_linear_interpolate(table[low].ocv,
> > +				       table[low].capacity,
> > +				       table[high].ocv,
> > +				       table[high].capacity,
> > +				       ocv);
> >   }
> >   EXPORT_SYMBOL_GPL(power_supply_ocv2cap_simple);
> >=20

--fesngtrrrtp56grc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmGVN4YACgkQ2O7X88g7
+ppwUA/6AqjsltflNsL75fE1k2+Gksfizbf7MNqmNHUR84zJXqu4HxS0aNss0rG0
+HNhNYHXzVSPJdRUnGKHTWRQ0OU+WLU53yoPmIvACrzxPxNcP5mROfXuXg4psgvy
Qqume5b1Z5fPaIm1f1KbsVeaypxEjdVeR/Bi9Zldp0NHyFqPdNNhJ6uifT/rg+/0
7RDKvL9iDrwUPHVG447tXiIPw9pVb5xzPxQTucvkdMBTuNIkQC4fpAcigaMBMthc
oQqO6UBObScTmYU4SG+JAIDkr+DSaeHApeW9lvMCSMUD0dpWPbP7xH2OQfMQ4Riu
2BVVKN8XNZJiGZz6FlF0JSkpJDC1lemypm2yoX+HKzOcqVERBXPUuHiOHNKjsu6i
MjDvR4peZjYccly058Mk+yIrv0noKxRYaADa+bmOjeSmTXtwFN5uo4Dm6GdNyjiX
2HPxrtfSxTnu3fWhtl4JPHJtvxMEjtXHufvKp8mxIkkBS7s+B1lamAiwuIy3GXZ7
uUC+VW+JBvt1SivfqNgJ5cVTmktmvpzqlDEyaEipva4gn/nqzcfGGDCdf3KAThN/
JL2qLJmjfQ8yyq+XR5pZ2n0qqQWqt20AivSYDKGqkLuUgbh8FoSpIP22zBE62GQH
pSLRH3nfsnPH2+RvNF4PpxNSAILPkvnD4oz+tDsmenjFJQym0rk=
=NR9n
-----END PGP SIGNATURE-----

--fesngtrrrtp56grc--
