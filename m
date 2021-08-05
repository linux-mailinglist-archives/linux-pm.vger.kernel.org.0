Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5033E190B
	for <lists+linux-pm@lfdr.de>; Thu,  5 Aug 2021 18:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242886AbhHEQEY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Aug 2021 12:04:24 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60304 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242904AbhHEQEL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Aug 2021 12:04:11 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 93F041F4421F
Received: by earth.universe (Postfix, from userid 1000)
        id 526623C0C9B; Thu,  5 Aug 2021 18:03:53 +0200 (CEST)
Date:   Thu, 5 Aug 2021 18:03:53 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marcus Cooper <codekipper@gmail.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] dt-bindings: power: Extend battery bindings with
 type
Message-ID: <20210805160353.syzqrzv2ucisoqfg@earth.universe>
References: <20210805085828.3451909-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oiyoqqtumybqrj3r"
Content-Disposition: inline
In-Reply-To: <20210805085828.3451909-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--oiyoqqtumybqrj3r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 05, 2021 at 10:58:27AM +0200, Linus Walleij wrote:
> This adds a battery-type property and bindings for the different
> "technologies" that are used in Linux. More types can be added.
>=20
> This is needed to convert the custom ST-Ericsson AB8500 battery
> properties over to the generic battery bindings.
>=20
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Add devicetree list to Cc
> - Use "device-chemistry" instead of "battery-type" as this
>   has precedence in standards.
> I need a bunch of new bindings for switch the STE AB8500 custom
> bindings out, but I need to start somewhere, this is as good as
> any place to start.
> ---

Waiting a bit to give Rob a chance to review this. From my side
it looks good.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  .../devicetree/bindings/power/supply/battery.yaml  | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/battery.yaml =
b/Documentation/devicetree/bindings/power/supply/battery.yaml
> index c3b4b7543591..d56ac484fec5 100644
> --- a/Documentation/devicetree/bindings/power/supply/battery.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/battery.yaml
> @@ -31,6 +31,20 @@ properties:
>    compatible:
>      const: simple-battery
> =20
> +  device-chemistry:
> +    description: This describes the chemical technology of the battery.
> +    oneOf:
> +      - const: nickel-cadmium
> +      - const: nickel-metal-hydride
> +      - const: lithium-ion
> +        description: This is a blanket type for all lithium-ion batterie=
s,
> +          including those below. If possible, a precise compatible string
> +          from below should be used, but sometimes it is unknown which s=
pecific
> +          lithium ion battery is employed and this wide compatible can b=
e used.
> +      - const: lithium-ion-polymer
> +      - const: lithium-ion-iron-phosphate
> +      - const: lithium-ion-manganese-oxide
> +
>    over-voltage-threshold-microvolt:
>      description: battery over-voltage limit
> =20
> --=20
> 2.31.1
>=20

--oiyoqqtumybqrj3r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmEMC+kACgkQ2O7X88g7
+popLA/+PNOpiLKC1qeVP6JTjpkWV8YRO8pDgUpjaR3lUP3gGMg5HnWkqk0h7FPG
WC53PP59Ba3JU8gD7kMBuAupxyMD1vwT82ZwoPDAmSlxZAS1PMYDK6FkFKCEfaHY
kFOQX/JxHfCPllUE9YBUUFddcZW4Ti4tXZgIuNCbC4ipf03HthTzTBJeslKkAjxX
i+TJdWWj8vKiQgXiACRw4ytYD5UbGQm9xBEqOQPYBM14t9obyV98HWmjTX7Knh8o
YF+szqYAWLHfzR+ub9/aZLiQrkNoYHPZgv17RTxPh9ea53MjHcMQk8FKSU6IJxrO
7EgfgLpAKeRTNUUUZFND8YEkkv8HIxN80DYXmgqx+CYdxrdRyYycOX9JrjcdvYG0
zzCIeh/Eb7NlijFa6g31MRguKK0BdpasG9sVPk9VRXFVOOjtmAjQ2eQyMgzTarx2
GZVmdjVbOHclv04TUBRURbeYz5EgngKYbUEoM8JIWpEHMqtXRHwvVEcCBwk4/gpP
2V0S4AAImjSNghFHWbodqP8a/CCfrEhr2jtiDK08Knr8yGXi4h5JDE3tfW44fXIX
iqP+jsQkfBjwE9tgmUkmo45QGUdgPzoM7uz28X8ri67lyJgSzB25vPA6UUgUZ2J2
LDLcKpT+hAiY0D2BsEPbnp8aQ1pleFIzQ9/VgV4BJMF8unK+dLw=
=ymCk
-----END PGP SIGNATURE-----

--oiyoqqtumybqrj3r--
