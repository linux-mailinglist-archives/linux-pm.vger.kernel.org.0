Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD83FA5C3A
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 20:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfIBSX6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 14:23:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbfIBSX6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Sep 2019 14:23:58 -0400
Received: from earth.universe (unknown [185.62.205.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F03D3208E4;
        Mon,  2 Sep 2019 18:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567448637;
        bh=mW5nf+1HLE19vezXKFXZ5fGbtvNwUx214Bc6vuyN+XQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2lRKi/DYQ1enqibPmCSg9L2FuAxsP8jQ6ZqevbwzCQggmhKMaD2EkSkhYwD1LVclL
         rEuRiVlo5PiIrcPAfH7RTG+sgWJzA9JCV/TeR/ADbQxFNywLye6/VyYYiiKHAM1A6/
         0emN/s4cyN+YGMjmWzFA5P5PfUsaqp060NIGGYls=
Received: by earth.universe (Postfix, from userid 1000)
        id 97B813C0B7F; Mon,  2 Sep 2019 20:23:54 +0200 (CEST)
Date:   Mon, 2 Sep 2019 20:23:54 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Richard Tresidder <rtresidd@electromag.com.au>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        tglx@linutronix.de, rfontana@redhat.com, allison@lohutok.net,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND v2 1/2] dt-binding docs: sbs_sbs-battery: Addition of
 force_load binding
Message-ID: <20190902182354.p2o6pb4wy7bggywz@earth.universe>
References: <1564481404-39505-1-git-send-email-rtresidd@electromag.com.au>
 <1564481404-39505-2-git-send-email-rtresidd@electromag.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kxy72r42udvqwqdq"
Content-Disposition: inline
In-Reply-To: <1564481404-39505-2-git-send-email-rtresidd@electromag.com.au>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--kxy72r42udvqwqdq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 30, 2019 at 06:10:03PM +0800, Richard Tresidder wrote:
> Add device tree binding documentation for addition of force_load boolean =
value
> to allow loading a battery during boot even if notpresent at that time.
>=20
> Signed-off-by: Richard Tresidder <rtresidd@electromag.com.au>
> ---
>  Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt | 4 +=
++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/sbs_sbs-batte=
ry.txt b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
> index 4e78e51..187d7bb 100644
> --- a/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
> @@ -15,7 +15,8 @@ Optional properties :
>     after an external change notification.
>   - sbs,battery-detect-gpios : The gpio which signals battery detection a=
nd
>     a flag specifying its polarity.
> -
> + - sbs,force-load : Allow loading of a hot-pluggable battery when there =
is no
> +   GPIO detect available and the module is statically built.

This does not describe hardware configuration and is not an
acceptable DT property.

-- Sebastian

>  Example:
> =20
>  	battery@b {
> @@ -24,4 +25,5 @@ Example:
>  		sbs,i2c-retry-count =3D <2>;
>  		sbs,poll-retry-count =3D <10>;
>  		sbs,battery-detect-gpios =3D <&gpio-controller 122 1>;
> +		sbs,force-load;
>  	}
> --=20
> 1.8.3.1
>=20

--kxy72r42udvqwqdq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl1tXjcACgkQ2O7X88g7
+potIhAAh3upX8+LvEe6Q2MDNqs1lToaIapy6jXTBI9HHhb0i78GbnqV/dducdPJ
TpZo7N4G8+3/jz8h8wPOZtOZuAUm1RE44+aqP39CHE1wfrzuNGa7Q2JVPijT2xAN
6dmeIWCz1qkK6cskT3MngTcUNHwul1RMHuhdrlzZ8I+BxvfjQXo7VBjK8oMhGys/
sKZ1ZMv4IQx37iEfbFibTo8HhcJJKsy1Qg2qwoizyQytuu8axlg+PYh4sS+oEcbf
1DAWUh+KeHX5IG6BKJFkWth17HGPvJUVpFqm/Wx6SWAQ76k9j4lL3jRnhZPWRuLF
B9Oq8ikQCgCk2Blt1oNPVSpHv39r6vQFLPuUXYAA1ZCPEISYRFu63ACeA354eddL
r0IDU+l1aMVumX9Flrj2pY5+tWEKtZER9ieuHsERyA9JNZetuvz3Um3CzP964wut
WRERDWcJhxl6Hwv7YvWTx0lQgT7hO9yvAa9dzXux8UYX53lAGvlq5PXf2I9AHPlo
z7jlCokUtjG195B36QvZLZoiGDEZ7p+kfFRTFIhTKc4c/dsbQX/gKB99TeVAp6TB
2Kc6Ge3sRkqHaVKqmNc4B5/56YmSDTAttxZQGEY0c4wAdvLz7DTDPQdcDxF792Ap
BDji1wHRt9323nXptnhzPE+IF2qnvfvJ/jV5MIncVst+EmAxnx0=
=tOBC
-----END PGP SIGNATURE-----

--kxy72r42udvqwqdq--
