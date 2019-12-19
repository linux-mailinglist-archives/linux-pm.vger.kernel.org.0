Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43CDD125930
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 02:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfLSBX0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 20:23:26 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39522 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfLSBX0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 20:23:26 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 28403292930
Received: by earth.universe (Postfix, from userid 1000)
        id E49D33C0C7B; Thu, 19 Dec 2019 02:23:22 +0100 (CET)
Date:   Thu, 19 Dec 2019 02:23:22 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH 4/7] devicetree: bindings: sbs-battery: add
 sbs,force-load property
Message-ID: <20191219012322.2iii3g4yqnblun2x@earth.universe>
References: <20191101190705.13393-1-jeff.dagenais@gmail.com>
 <20191101190705.13393-4-jeff.dagenais@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6x3rkjgpaw7jsuwb"
Content-Disposition: inline
In-Reply-To: <20191101190705.13393-4-jeff.dagenais@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--6x3rkjgpaw7jsuwb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Kernel patches should always have a long description.

-- Sebastian

On Fri, Nov 01, 2019 at 03:07:02PM -0400, Jean-Francois Dagenais wrote:
> Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
> ---
>  .../devicetree/bindings/power/supply/sbs_sbs-battery.txt       | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/sbs_sbs-batte=
ry.txt b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
> index 4e78e51018eb..62ec842325b4 100644
> --- a/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
> @@ -15,6 +15,8 @@ Optional properties :
>     after an external change notification.
>   - sbs,battery-detect-gpios : The gpio which signals battery detection a=
nd
>     a flag specifying its polarity.
> + - sbs,force-load : Same as the module param, makes the probe skip the
> +   detection of the battery and assume it is (or will be) present.
> =20
>  Example:
> =20
> @@ -24,4 +26,5 @@ Example:
>  		sbs,i2c-retry-count =3D <2>;
>  		sbs,poll-retry-count =3D <10>;
>  		sbs,battery-detect-gpios =3D <&gpio-controller 122 1>;
> +		sbs,force-load;
>  	}
> --=20
> 2.23.0
>=20

--6x3rkjgpaw7jsuwb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl360QoACgkQ2O7X88g7
+prSHg/9GS8Bo8srUAv4SeiOxeWeb4Au0KPNU3Q+2Zk9XgWc14RfL/HmlwKnz1tY
h/V/DwM8898JFTEPx0FdirZswJZCJkhfR2NPb3XKckT8rEEr1WxAT8j6R9lD7+JJ
8pNzyJLsPB5TwUVFofIg7bcrjhkNSEQcM2IjZnuihlHouR/UjmoaoYPjAhJxjAR5
LgppPIHqWWmlPVFnWn7sxv4iAGUouvPq+1x5VykfdmvXCzTf0bgHj9WfzASA1dWr
22G3bjIsILFVvIFLkdxYRrY3ixEX4y/qqM35xZ1uyDyl2lHGTGSh6Lw2XB0dKwNA
UZgwRNJKkn8iMQq6GUvgEJAUUz1K3ug8oEWvnvqc8u+eXdoR0/fhw0Asnk1c+kh7
Z00BOA17ffBmyiIu6Stx5d6WdNChNkVQQbQzvHeGAwse3wXcaNX8cg0IVmCEUU0W
3SNNVPzMM1m9SK33PspAmQ++JHJQGR4biRQ7OuBKeL8boFn4D77J4cJrdGVA6fK3
b/U9DF8MLjZKIi7hZ6dmoD0sakjEQ71+Md4eKVbCaOQkeN8/pgDiag2wx3FJwLxm
JfGM7pQrEjBZwovNy9WtIlsg6uNVQfiqYAD0WryT/NwmoELvehMgrM+5VMwRwC1/
qcpuJI5lLaEpQMYvV0M5dpNgxCwSznitqZFHN3QmCmpcs80DHEc=
=hERp
-----END PGP SIGNATURE-----

--6x3rkjgpaw7jsuwb--
