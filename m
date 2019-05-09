Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37FF619305
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2019 21:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfEITpA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 May 2019 15:45:00 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55794 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfEITpA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 May 2019 15:45:00 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 88D9026D20C
Received: by earth.universe (Postfix, from userid 1000)
        id 4D2273C0CBC; Thu,  9 May 2019 21:44:55 +0200 (CEST)
Date:   Thu, 9 May 2019 21:44:55 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Axel Lin <axel.lin@ingics.com>,
        Enric Balletbo Serra <enric.balletbo@collabora.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] power: supply: ucs1002: Fix wrong return value checking
Message-ID: <20190509194455.xmtp3h2p5suht3e6@earth.universe>
References: <20190509125614.28921-1-axel.lin@ingics.com>
 <CAHQ1cqH6E9zf_GuW5qx8+PAPE6LxOc4_HGXSNmLeDni4Q=pXRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e4egf6jqg64joklw"
Content-Disposition: inline
In-Reply-To: <CAHQ1cqH6E9zf_GuW5qx8+PAPE6LxOc4_HGXSNmLeDni4Q=pXRQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--e4egf6jqg64joklw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 09, 2019 at 12:14:24PM -0700, Andrey Smirnov wrote:
> On Thu, May 9, 2019 at 5:56 AM Axel Lin <axel.lin@ingics.com> wrote:
> >
> > Fix wrong return value checking for devm_regulator_register and
> > devm_regmap_init_i2c. This looks like a copy-n-paste mistake.
> >
> > Fixes: 9a2688e42638 ("power: supply: Add driver for Microchip UCS1002")
> > Signed-off-by: Axel Lin <axel.lin@ingics.com>
> > Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>=20
> Ugh, sorry about that.
>=20
> Reviewed-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Thanks, queued.

-- Sebastian

--e4egf6jqg64joklw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlzUgzMACgkQ2O7X88g7
+ppw2g/9GRbF4sG+1liEuTW4u/oFVz7QN7gGWucNWuFmv+jP+tU59AEcCNod15n3
SFbwq2K9AKdQ9K3T5JeUSauvHTOy0Tt/IiT+WPMu4dpRvGPgrSEZfK5qvI92SqYP
0Zt0VHkbAHBHW1gDmCjAyuQqusSzcZxePqWBiSfRuaOZVqAuNP5bSdw6IB+zqtxh
ltdhyW2XHTTqeVsvUwvEoYXFyuOg6FmIIjYEpJ9z7de7HXpFf357vLFnUeVKG0Hm
MW60LNs/DDjqEjWIm8W+2T5xxsrpQp7WxoYVSkN8BTJ4TViPdOBDs2Ya4NFaTJh9
ZEd62aYrCCggnYkJGNWGZzaJGK6kC+zN7Hbu0P/rXqy5CllDbXT6EYRhmpbRQq1Y
WFwdDub/FOfz1cuNjIZIshSiUVavY79KonrcK54MfGqtUzuKBtmkcdkQ/N2hDDvb
wmlu1dPJs5D0xHL2IZtjrV1a5AQ5twMD8koZgo7DpFl/ZsnISOWptuZ6iNAgRPhN
zuB9NhsC1I93eFNymb5HWOInHz/YXHCncHmSq9VJhZa33Ib9eCRQ3qDd5ypm+R8p
fZRPuMGLapHdGBD2+gdif/ltTOoAs6X0eOZgv9DOGqV2h8tz/DpUOWuyndR7YoU2
n5OjmVx7RB+v0qkJYKoYnhGT/xuI9ArfUCsmM8p563obEYJdy1o=
=PenA
-----END PGP SIGNATURE-----

--e4egf6jqg64joklw--
