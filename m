Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7206A312B4A
	for <lists+linux-pm@lfdr.de>; Mon,  8 Feb 2021 08:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhBHHz2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Feb 2021 02:55:28 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:47484 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhBHHz2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2021 02:55:28 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id ADFD21C0B76; Mon,  8 Feb 2021 08:54:43 +0100 (CET)
Date:   Mon, 8 Feb 2021 08:54:43 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Colin King <colin.king@canonical.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Titinger <mtitinger+renesas@baylibre.com>,
        Lina Iyer <lina.iyer@linaro.org>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM / Domains: Fix integer overflows on u32 bit multiplies
Message-ID: <20210208075442.GA13982@amd>
References: <20210207224648.8137-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <20210207224648.8137-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2021-02-07 22:46:48, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> There are three occurrances of u32 variables being multiplied by
> 1000 using 32 bit multiplies and the result being assigned to a
> 64 bit signed integer.  These can potentially lead to a 32 bit
> overflows, so fix this by casting 1000 to a UL first to force
> a 64 bit multiply hence avoiding the overflow.

Ummm. No?

a) Can you imagine any situation where they result in overflow?

b) How does casting to UL help on 32 bit system?

Best regards,

								Pavel

> Addresses-Coverity: ("Unintentional integer overflow")
> Fixes: 30f604283e05 ("PM / Domains: Allow domain power states to be read =
=66rom DT")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/base/power/domain.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index aaf6c83b5cf6..ddeff69126ff 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2831,10 +2831,10 @@ static int genpd_parse_state(struct genpd_power_s=
tate *genpd_state,
> =20
>  	err =3D of_property_read_u32(state_node, "min-residency-us", &residency=
);
>  	if (!err)
> -		genpd_state->residency_ns =3D 1000 * residency;
> +		genpd_state->residency_ns =3D 1000UL * residency;
> =20
> -	genpd_state->power_on_latency_ns =3D 1000 * exit_latency;
> -	genpd_state->power_off_latency_ns =3D 1000 * entry_latency;
> +	genpd_state->power_on_latency_ns =3D 1000UL * exit_latency;
> +	genpd_state->power_off_latency_ns =3D 1000UL * entry_latency;
>  	genpd_state->fwnode =3D &state_node->fwnode;
> =20
>  	return 0;

--=20
http://www.livejournal.com/~pavelmachek

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmAg7kIACgkQMOfwapXb+vKDiQCgkJZyxGlRaw1dIv7Thley0C+0
qkIAn3HsqdmQXesDf9whJPhztRMkU4lx
=WTDB
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
