Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB6D2D8AAC
	for <lists+linux-pm@lfdr.de>; Sun, 13 Dec 2020 00:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439905AbgLLXm2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 12 Dec 2020 18:42:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:59866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgLLXmU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 12 Dec 2020 18:42:20 -0500
Date:   Sun, 13 Dec 2020 00:41:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607816499;
        bh=ld6WI/WbyYmPRfnJouXU9CfxjM3Dou47ngCdq5kAuTo=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=p/qq1/cUzMMwE5CNU9VJYm2X9EJpJMiNI7elHxhV7TpKOvaSFHxBhqiU4dFyY5w5T
         Kdqx7rDxkzgLJJS9GZu+d5C312Zezu/CNCiGlLlozSZfTUJIC5iVyEaqltre51f65J
         bxGKkxGfWhL82bDpHmzbGjA5qevRlBi9Rk52zO+RYVCkZKJy0D46skX/fkE7PC4wPF
         QOcn3K5hY7Bqroyw6qKiZHNYBeUBemtb1n/pxJdMNnmMUT7Sj5oPrzaN7xt8JC9k+c
         elsrwMpLlSiACRXV1wYg+201Hjl0o43/7EpplmVLUduX04npu1z5pQ+zPzxPVlwSM+
         /wPwpJfoz2Cmw==
From:   Sebastian Reichel <sre@kernel.org>
To:     Michael Klein <michael@fossekall.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 2/3] Documentation: DT: binding documentation for
 regulator-poweroff
Message-ID: <20201212234137.xnh2vtqbmxqnkj3c@earth.universe>
References: <20201211151445.115943-1-michael@fossekall.de>
 <20201211151445.115943-3-michael@fossekall.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="erqydbu4j5uxkufn"
Content-Disposition: inline
In-Reply-To: <20201211151445.115943-3-michael@fossekall.de>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--erqydbu4j5uxkufn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 11, 2020 at 04:14:44PM +0100, Michael Klein wrote:
> Add devicetree binding documentation for regulator-poweroff driver.
>=20
> Signed-off-by: Michael Klein <michael@fossekall.de>
> ---

Thanks, queued.

-- Sebastian

>  .../power/reset/regulator-poweroff.yaml       | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/regulat=
or-poweroff.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/power/reset/regulator-powe=
roff.yaml b/Documentation/devicetree/bindings/power/reset/regulator-powerof=
f.yaml
> new file mode 100644
> index 000000000000..03bd1fa5a623
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/regulator-poweroff.ya=
ml
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/reset/regulator-poweroff.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Force-disable power regulator to turn the power off.
> +
> +maintainers:
> +  - Michael Klein <michael@fossekall.de>
> +
> +description: |
> +  When the power-off handler is called, a power regulator is disabled by
> +  calling regulator_force_disable(). If the power is still on and the
> +  CPU still running after a 3000ms delay, a warning is emitted.
> +
> +properties:
> +  compatible:
> +    const: "regulator-poweroff"
> +
> +  cpu-supply:
> +    description:
> +      regulator to disable on power-down
> +
> +required:
> +  - compatible
> +  - cpu-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    regulator-poweroff {
> +        compatible =3D "regulator-poweroff";
> +        cpu-supply =3D <&reg_vcc1v2>;
> +    };
> +...
> --=20
> 2.29.2
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--erqydbu4j5uxkufn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl/VVTEACgkQ2O7X88g7
+poXLg//Y5j/lacOZTPsiDqIHt6dE74UstQENqnz3/rgDBswnVBxSlW/85Md14/a
j3GLRYe/fqUEO8o2t7CtMxzOQlnmFe80aCpKNfpGj50FKgt1HSaUqN+9rxRDnnhq
IIvAP1SpdSG2X8ZP031XyRHFYdUsxo2dOJu6W1BSEXAarm0tVqR/AVKohiXuDDYV
ILotynHjtXgHXN9onhu3s0APz5mHZCQyge/wtPshkE/+ssvbC0l8HFrd6eMarW75
AS/J1pkQk9vnLgQBOpItUxEtGU79DHkbe+DUKe2DmKA07Q3ZPwnpq69mrJ1MN8yd
7aO9PZ9ZIae0qUWC59ZDR0wivXLmUc2ROzwvnGfQL7bQedyLPWspE50PVtnydzGb
9T4jAHctik2i5YnhO6NkbqGmIZueSYl5VCMBx3U+0iOg7QNP1ZiigucMOmZQBGeI
UNamgXvss4q4izyeGqreH7UAqXmDdPD4qMVfcpgQGf7aiUfRmI0oENtobQ9S2rXq
Gs1nLgeOUW1xnSnMwebjrzhjGCWuvT0oQPr+d/Iqv0nWN+rIk1AtxiLiNnc4LHEP
NAznxc7QzQYDseEX4sn7O1rDGtRbJdbcZcJ4i7yXslkQCx6I9DPKhBKRyAMk+MAp
er+UTH0mHpcuE5fk9hBT85qMletm9b6b8jGuA/d4UJ+ky4Y5WHU=
=4jjv
-----END PGP SIGNATURE-----

--erqydbu4j5uxkufn--
