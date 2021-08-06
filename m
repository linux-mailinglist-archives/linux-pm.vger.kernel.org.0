Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0454F3E3124
	for <lists+linux-pm@lfdr.de>; Fri,  6 Aug 2021 23:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243305AbhHFVeE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Aug 2021 17:34:04 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52426 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243571AbhHFVeD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Aug 2021 17:34:03 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 982CF1F41A90
Received: by earth.universe (Postfix, from userid 1000)
        id 4C3EF3C0C99; Fri,  6 Aug 2021 23:33:43 +0200 (CEST)
Date:   Fri, 6 Aug 2021 23:33:43 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 28/54] dt-bindings: power: supply: axp20x: Add AXP803
 compatible
Message-ID: <20210806213343.ha2jvludgengcp2m@earth.universe>
References: <20210721140424.725744-1-maxime@cerno.tech>
 <20210721140424.725744-29-maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="clmdbbr4y7qn5y76"
Content-Disposition: inline
In-Reply-To: <20210721140424.725744-29-maxime@cerno.tech>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--clmdbbr4y7qn5y76
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 21, 2021 at 04:03:58PM +0200, Maxime Ripard wrote:
> The AXP803 compatible was introduced recently with a fallback to the
> AXP813, but it was never documented.
>=20
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: linux-pm@vger.kernel.org
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Thanks, queued.

-- Sebastian

>  .../supply/x-powers,axp20x-ac-power-supply.yaml    | 11 +++++++----
>  .../x-powers,axp20x-battery-power-supply.yaml      | 11 +++++++----
>  .../supply/x-powers,axp20x-usb-power-supply.yaml   | 14 +++++++++-----
>  3 files changed, 23 insertions(+), 13 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp2=
0x-ac-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-=
powers,axp20x-ac-power-supply.yaml
> index dcda6660b8ed..de6a23aee977 100644
> --- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-ac-p=
ower-supply.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-ac-p=
ower-supply.yaml
> @@ -21,10 +21,13 @@ allOf:
> =20
>  properties:
>    compatible:
> -    enum:
> -      - x-powers,axp202-ac-power-supply
> -      - x-powers,axp221-ac-power-supply
> -      - x-powers,axp813-ac-power-supply
> +    oneOf:
> +      - const: x-powers,axp202-ac-power-supply
> +      - const: x-powers,axp221-ac-power-supply
> +      - items:
> +          - const: x-powers,axp803-ac-power-supply
> +          - const: x-powers,axp813-ac-power-supply
> +      - const: x-powers,axp813-ac-power-supply
> =20
>  required:
>    - compatible
> diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp2=
0x-battery-power-supply.yaml b/Documentation/devicetree/bindings/power/supp=
ly/x-powers,axp20x-battery-power-supply.yaml
> index 86e8a713d4e2..d1f0df123a5a 100644
> --- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-batt=
ery-power-supply.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-batt=
ery-power-supply.yaml
> @@ -19,10 +19,13 @@ allOf:
> =20
>  properties:
>    compatible:
> -    enum:
> -      - x-powers,axp209-battery-power-supply
> -      - x-powers,axp221-battery-power-supply
> -      - x-powers,axp813-battery-power-supply
> +    oneOf:
> +      - const: x-powers,axp202-battery-power-supply
> +      - const: x-powers,axp221-battery-power-supply
> +      - items:
> +          - const: x-powers,axp803-battery-power-supply
> +          - const: x-powers,axp813-battery-power-supply
> +      - const: x-powers,axp813-battery-power-supply
> =20
>  required:
>    - compatible
> diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp2=
0x-usb-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x=
-powers,axp20x-usb-power-supply.yaml
> index 61f1b320c157..0c371b55c9e1 100644
> --- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-=
power-supply.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-=
power-supply.yaml
> @@ -20,11 +20,15 @@ allOf:
> =20
>  properties:
>    compatible:
> -    enum:
> -      - x-powers,axp202-usb-power-supply
> -      - x-powers,axp221-usb-power-supply
> -      - x-powers,axp223-usb-power-supply
> -      - x-powers,axp813-usb-power-supply
> +    oneOf:
> +      - enum:
> +          - x-powers,axp202-usb-power-supply
> +          - x-powers,axp221-usb-power-supply
> +          - x-powers,axp223-usb-power-supply
> +          - x-powers,axp813-usb-power-supply
> +      - items:
> +          - const: x-powers,axp803-usb-power-supply
> +          - const: x-powers,axp813-usb-power-supply
> =20
> =20
>  required:
> --=20
> 2.31.1
>=20

--clmdbbr4y7qn5y76
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmENqrcACgkQ2O7X88g7
+pq70hAAgJe1YjoZXWY0Zla1eaIbpq5VB4C4yNXKNOBW5CZokBBzZwTGCKyol9aa
gAH2Oc4IB54JrYKE275ffpU1l+iBtj2Z5kNOtIktzoFb0IoaKDq6THBBcXL/xBxo
5vc63SBUCrpRNxPuB0TWVRMXrckqiAbmujb8HDioPhjrZIGOgb+8Z7HPRns5ORTA
/28Rl44+AytF3Txs5FVEltepedsTF7id5BvUUkMVPOCnwwnJ+2vTRZJbJC0X8Mia
Qj5YHps/1p+ggx3aVUArBzDxDbOGH8hz67qcgNk8lmnOHG4KLaB508oECrMLMK75
0sw4tn7vxY3/jMsW7WwP78murwG2fw22hbEF0Y9/NOlC+talFFEVkWftaUFZOhGd
ftciWBgYTpBu19Y3cGkvzL5rn7nsUuAM6X5/suIdt4K1g93jed6XOKBB1YqJrSl/
eDT5tI4eS5ZsMog0y40+uJveL19ppvQB6LDax9jbhoF9rPQ1X1rOulCFh1H6oVCL
fobrAmNj1lNhIgKFvtK0d9CBlZriRIEsRmVuDLN1kGflomcObg6uTvE+USH5BRD0
SBjOn9LQNfPYNbrCiIcz8rCkh0ZB5DbIS16J5Y6bqEbWLbZRQamtpWCRfILDou13
ut0++Jv9gDiozNdh4KrhAcRAQTU7IX4CM3g2hPMLo93y5+vB76Q=
=t8aw
-----END PGP SIGNATURE-----

--clmdbbr4y7qn5y76--
