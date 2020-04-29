Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9C31BEC26
	for <lists+linux-pm@lfdr.de>; Thu, 30 Apr 2020 00:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgD2Wno (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 18:43:44 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39896 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgD2Wno (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 18:43:44 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 7690127ED0D
Received: by earth.universe (Postfix, from userid 1000)
        id 29DDB3C08C6; Thu, 30 Apr 2020 00:43:40 +0200 (CEST)
Date:   Thu, 30 Apr 2020 00:43:40 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Daniel =?utf-8?B?R29uesOhbGV6?= Cabanelas <dgcbueu@gmail.com>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: power: reset: add yaml bindings for
 LinkStation power off
Message-ID: <20200429224340.wneuw6h34mnxmxah@earth.universe>
References: <23544181.H47qXO15o3@tool>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xpwx22xwsztnrzjb"
Content-Disposition: inline
In-Reply-To: <23544181.H47qXO15o3@tool>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--xpwx22xwsztnrzjb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Apr 25, 2020 at 03:01:01AM +0200, Daniel Gonz=E1lez Cabanelas wrote:
> Add Linkstation poweroff bindings documentation.=20
>=20
> Signed-off-by: Daniel Gonz=E1lez Cabanelas <dgcbueu@gmail.com>
> ---

Thanks for the patch.

DT bindings need to be CC'd to devicetree@vger.kernel.org and to
Rob Herring. Also please Cc me (sre@kernel.org). I will not merge
this without an explicit Acked-by from Rob.

-- Sebastian

>  .../power/reset/linkstation-poweroff.yaml     | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/linksta=
tion-poweroff.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/power/reset/linkstation-po=
weroff.yaml b/Documentation/devicetree/bindings/power/reset/linkstation-pow=
eroff.yaml
> new file mode 100644
> index 0000000000..b647baecf3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/linkstation-poweroff.=
yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/reset/linkstation-poweroff.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Buffalo Linkstation poweroff driver
> +
> +maintainers:
> +  - Daniel Gonz=E1lez Cabanelas <dgcbueu@gmail.com>
> +
> +description: |
> +  This driver is used to add the power off function to some Buffalo=20
> +  LinkStations (ARM MVEBU boards). They use a LED output pin at the=20
> +  ethernet PHY to inform the board if the power off operation must be
> +  performed after restarting.
> +
> +  When the power-off handler is called, the ethernet PHY LED2 ouptut is
> +  set to OFF. If the restart command is executed then the PHY LED2 output
> +  is asserted to ON.
> +
> +properties:
> +  compatible:
> +    const: linkstation,power-off
> +
> +  phy-handle,led:
> +    description: Phandle to a node of the ethernet PHY used for the powe=
r=20
> +      function. If this optional property is not specified, then the fir=
st
> +      PHY found in the MDIO bus will be used.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    poweroff {
> +        compatible =3D "linkstation,power-off";
> +        phy-handle,led =3D <&ethphy0>;
> +    };
> --=20
> 2.26.2
>=20
>=20
>=20
>=20

--xpwx22xwsztnrzjb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6qAxcACgkQ2O7X88g7
+pqHzA/+IAT1/wvOW144s0OQ6sME7tZRJFqJboaBFrgT7hB+KAiqi3LRW5jCJz1G
HKRSMGYre9iYfm04ntZ5gfOhMNJW7DRW9L+OnBt+2hhRL+j/oUkVMnHfjJJp2lvL
7V1HHdkDx5Rq/3r/QGUK7I0EeqDOvooXmds2JbKBnlAFrU+8OsqCN3jvA5yObkPd
ZcNiaffaEYJ/cElJLINGSVTwWFTh9ADAC7wty8dX0bgcTd99fG2nV3rC/6YelxGY
l6v8DwPI8alqczTeYNbWXksMtLsh0c9d6j7stq0hH+uOOpLmwHDNyPfhcHGu+9wT
fHuH1tD4GwvpOQTId7dfQ+TZLWw+CnA6oeK0X/dw8e2BO/oaVhah8dxoutUDx9rZ
2jZ25HGTrm4+IFdVDj+Co5fGwDc0eNLJRSnbAop+y3QbA5WLhnglKchVD9B/9mID
3M5+z3I90A7P7EBw585tQ4fzRAuxEcCO+4R3BGfdls0Ex8wQ7/Vbm324+EkkM0As
8RUWfRymYoA0inJXRxjviohPniNK4aG6hmnKQ2bldOi2VnZ3BUUHhIwC3DYNnCXS
xr7LIIdTFPc83mSUA2Ilys0OfmlOzrv7oxCbzPqiXcppPXPA43LbS66tMscQ56E4
gVmIXuI0yuwcQYxmhPmJjMKeaCqgEWumBxvQUGkWThL9Ja8+YVs=
=vRCX
-----END PGP SIGNATURE-----

--xpwx22xwsztnrzjb--
