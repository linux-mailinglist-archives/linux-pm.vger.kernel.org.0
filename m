Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4B63CB881
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jul 2021 16:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240100AbhGPOM7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Jul 2021 10:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbhGPOM6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jul 2021 10:12:58 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C88C06175F
        for <linux-pm@vger.kernel.org>; Fri, 16 Jul 2021 07:10:03 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 8AD171F4413B
Received: by earth.universe (Postfix, from userid 1000)
        id EC0643C0C97; Fri, 16 Jul 2021 16:09:59 +0200 (CEST)
Date:   Fri, 16 Jul 2021 16:09:59 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marcus Cooper <codekipper@gmail.com>, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: power: Extend battery bindings with type
Message-ID: <20210716140959.4ajgyiwtwq3iq2wc@earth.universe>
References: <20210627234515.3057935-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bzs7s42bwaq2vzrl"
Content-Disposition: inline
In-Reply-To: <20210627234515.3057935-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--bzs7s42bwaq2vzrl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 28, 2021 at 01:45:14AM +0200, Linus Walleij wrote:
> This adds a battery-type property and bindings for the different
> "technologies" that are used in Linux. More types can be added.

Makes sense to have this.

> This is needed to convert the custom ST-Ericsson AB8500 battery
> properties over to the generic battery bindings.

Great :)

> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> I need a bunch of new bindings for switch the STE AB8500 custom
> bindings out, but I need to start somewhere, this is as good as
> any place to start.
> ---
>  .../devicetree/bindings/power/supply/battery.yaml  | 14 ++++++++++++++

This should be CC'd to Rob Herring.

>  1 file changed, 14 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/battery.yaml =
b/Documentation/devicetree/bindings/power/supply/battery.yaml
> index c3b4b7543591..3561ae2c1d58 100644
> --- a/Documentation/devicetree/bindings/power/supply/battery.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/battery.yaml
> @@ -31,6 +31,20 @@ properties:
>    compatible:
>      const: simple-battery
> =20
> +  battery-type:

The smart battery standard names the property storing this information
"DeviceChemistry", which (as a non-native speaker) seems like a
better fitting name. Thoughts?

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

The values look good to me.

-- Sebastian

>    over-voltage-threshold-microvolt:
>      description: battery over-voltage limit
> =20
> --=20
> 2.31.1
>=20

--bzs7s42bwaq2vzrl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmDxkzcACgkQ2O7X88g7
+ppelw/5Ad9NDbcWC6PeLINNkXYZnF/+noFgNwC86NfrlHu4RD2PQBqyBEf2q0Cq
4UbSUVQqAXRS6/2h2a9jgc6zesgiOGuaGBAhuCWAhitWL0ctg4+1UfsI8e6aTftV
ex8zIJUwLRbSH+ekgk8bwvepvJJYzmxMm+RKe7QX7b7k9IkfbQPE6X+kfNTARzGI
+1jO40PagX3q5jI7eu4KjG0Z3B6rPV2EAuPkmSyZb/R5jRFd+6v0e7hp9F31v2mp
IwarLtOJh0ptQJFKyqLmvrLsuYeJSHFOsFXJaSVVarscRTvgRbeB33cU+jdxf1Pj
pVpxCRTwk/ct0RwG880Toefcxw55WNkTIveSO2UUkk11Mj9AH+L4JK5ZIO2NpN73
in0tfdO+jDdC4tc8Q2KxX0PdCzE3wj5739gl10kSpH6+mSKMwv8D3xvMOUN6pR9d
oyIPm26VA8MBy/b3V6G+/yYKiOQXYryVEJJyku7XAwdKx5wqFUmTo5E++QWGQ3BP
xdPavCL9IRaoFK+SHQYD6Sos2w/2EjoBX8Rd+VMyR3K8/eHGiOVzhrdbbvmAQPej
mDQw4jip+5N+T64HzEY7tOzdeArW6EBeOMV8PWfjDzTniRPibHMVVG7Vm9YOE/5h
5AYMmrLaJX8VhUneWzV8YURUUlKnJVUONbPJ5iWMVjTC+G0nGWg=
=f5ez
-----END PGP SIGNATURE-----

--bzs7s42bwaq2vzrl--
