Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8CE3E3126
	for <lists+linux-pm@lfdr.de>; Fri,  6 Aug 2021 23:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242180AbhHFVeW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Aug 2021 17:34:22 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52438 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241353AbhHFVeV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Aug 2021 17:34:21 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id D3E421F410D4
Received: by earth.universe (Postfix, from userid 1000)
        id 9A8203C0C99; Fri,  6 Aug 2021 23:34:02 +0200 (CEST)
Date:   Fri, 6 Aug 2021 23:34:02 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 29/54] dt-bindings: power: supply: axp20x-battery: Add
 AXP209 compatible
Message-ID: <20210806213402.xvp7oucjio7xmq6c@earth.universe>
References: <20210721140424.725744-1-maxime@cerno.tech>
 <20210721140424.725744-30-maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hjjkku4jwm5csdpa"
Content-Disposition: inline
In-Reply-To: <20210721140424.725744-30-maxime@cerno.tech>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--hjjkku4jwm5csdpa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 21, 2021 at 04:03:59PM +0200, Maxime Ripard wrote:
> The AXP209 compatible was used in Device Trees and the driver, but it
> was never documented.
>=20
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: linux-pm@vger.kernel.org
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Thanks, queued.

-- Sebastian

>  .../power/supply/x-powers,axp20x-battery-power-supply.yaml       | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp2=
0x-battery-power-supply.yaml b/Documentation/devicetree/bindings/power/supp=
ly/x-powers,axp20x-battery-power-supply.yaml
> index d1f0df123a5a..d055428ae39f 100644
> --- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-batt=
ery-power-supply.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-batt=
ery-power-supply.yaml
> @@ -21,6 +21,7 @@ properties:
>    compatible:
>      oneOf:
>        - const: x-powers,axp202-battery-power-supply
> +      - const: x-powers,axp209-battery-power-supply
>        - const: x-powers,axp221-battery-power-supply
>        - items:
>            - const: x-powers,axp803-battery-power-supply
> --=20
> 2.31.1
>=20

--hjjkku4jwm5csdpa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmENqsoACgkQ2O7X88g7
+ppdXA/+OzX85KTiIKpd0ZUsoGKaGmWdEK461TIU+FJNFz92goip5A6mbAPH7cVp
OoAb9rDQG6X9kz3Lqm0hqB2SICMQ77H+4W49X4GETnMTS/4ews3kzJtUlVX/6yWD
wzZ2XpaVx9Qs+oAOvLQpk29rRVf0A26z4SEluqqo8QGbVqPbdPzl6YAzOX2M+f9Y
cKFYvRsHQNnJoSZkkNPHc7vXSpeu0B6ptRDG92ICoMDzcxaiAd3VdWvw4F4B3akZ
cnHX5NZalaActgtDCiY0XUUVyowzAWFcJfLYCf5sDTC1R7Gn5y9BZBzKsO5lNxHc
go4QtinY8HPMKhTDHsHGMaMK9QMq+c2eBlydhUlx3A3+QDDocclY+1jOXJQJfBRo
WKtkhanicetP0qolvku/GWfr34CGZcMP3jFcdYjvWIAdti2t6Da6ZE29nNcFfJgO
vnoiNTSgIyxUxU/l3wk6eXURDzQ0v7jrdIYv35CXSAPCRSozwtUy+CFyV+iL41x9
VeWfkPSAzrPwr2zdWElBPVX3lW/ILzKDMxrbI7rs1YloZrVtSHnuZkaagm04Gy+/
WUqDXZ6yeVHa62tDaer4jmqgGUznI++UhN+q6ms4Yjq7AjG4QhIa1SLGmB4K96iU
vDE6IXe8J2+hMKHuEIVwbImaVOdnwbLs+m0T7sWvZZsnrMPcWJI=
=87C9
-----END PGP SIGNATURE-----

--hjjkku4jwm5csdpa--
