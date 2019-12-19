Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29B1A12592A
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 02:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfLSBWR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 20:22:17 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39482 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfLSBWR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 20:22:17 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id AEABD28B5FF
Received: by earth.universe (Postfix, from userid 1000)
        id 5AADC3C0C7B; Thu, 19 Dec 2019 02:22:13 +0100 (CET)
Date:   Thu, 19 Dec 2019 02:22:13 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH 7/7] dt-bindings: power: sbs-battery: add
 disable-charger-broadcasts doc
Message-ID: <20191219012213.miigcybtgvhwa7cx@earth.universe>
References: <20191101190705.13393-1-jeff.dagenais@gmail.com>
 <20191101190705.13393-7-jeff.dagenais@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="psh47eokbjxiuxwq"
Content-Disposition: inline
In-Reply-To: <20191101190705.13393-7-jeff.dagenais@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--psh47eokbjxiuxwq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

This is missing a long patch description and not CC'd to DT binding
maintainers.

-- Sebastian

On Fri, Nov 01, 2019 at 03:07:05PM -0400, Jean-Francois Dagenais wrote:
> Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
> ---
>  .../devicetree/bindings/power/supply/sbs_sbs-battery.txt        | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/sbs_sbs-batte=
ry.txt b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
> index 62ec842325b4..578643f49b0a 100644
> --- a/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
> @@ -17,6 +17,7 @@ Optional properties :
>     a flag specifying its polarity.
>   - sbs,force-load : Same as the module param, makes the probe skip the
>     detection of the battery and assume it is (or will be) present.
> + - sbs,disable-charger-broadcasts: for systems without sbs compliant cha=
rgers
> =20
>  Example:
> =20
> @@ -27,4 +28,5 @@ Example:
>  		sbs,poll-retry-count =3D <10>;
>  		sbs,battery-detect-gpios =3D <&gpio-controller 122 1>;
>  		sbs,force-load;
> +		sbs,disable-charger-broadcasts;
>  	}
> --=20
> 2.23.0
>=20

--psh47eokbjxiuxwq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl360MUACgkQ2O7X88g7
+pos2Q/+NSoG6eVlKVLlcTn/BGFagnqha7PErVhGjDIB7QZABXfm6+JzStIqEIRO
uxSmaJazSSnnIJ/t4C8gEEHjbyYDzSNBGkAAdWhdOL03HJblP2f17r8kqNZYaSn2
u0Emp57oJo/eW9qY2YbdOn25o/uvQqFZ5jjbkmoQzJGU9hycZ8uM2PO5m8yTSnx8
j3vieW6f/qurCM+ZS45EpxXHNBZgtnrSgbLFJEGPt7rlG3brYGVrkUjFYMUHXhVt
RcwUroZmlFYjBDDpzXlxc0bI5PuQc0FqbhB5QB8w3X0SZFIFz6i6etoqEIG03Fgb
AnsM05wxilEexsCyBQVakPzhWj2CxaPOG1iHhGqZ+ju+rSHwB6fMWefN69+X0SfF
0LcHyE3AWpbLmFhuO6NZBCwJLVbzZvGTY3l0Lw6iEi6cCVXBwYV1mZ2ZGPyUNqOt
mmnebjyL2op7G80gjo2AChXLjPtXSemRw5kkl3Xj8j3aqSDP6EgfLi6ZXTcqkSf5
/ORtzDAIiS5Nz+mQlqFbyRjcy++4akOniiCj63gUfa2NlqeYxi4RfmohobHmxnxf
/CRfJ73w7Zdj+sbzITpsWipzT1KHwN0baRmjct+Kj7Xs4XMiEdcbmvHQSWfBqvVK
xbIV0RaXsREAuEE6+7Tt7/SU1H+0Cu4MiDzKeXI3oiOHgtWlH20=
=w9bL
-----END PGP SIGNATURE-----

--psh47eokbjxiuxwq--
