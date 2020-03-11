Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 290E31824BA
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 23:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbgCKWXK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 18:23:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729506AbgCKWXK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Mar 2020 18:23:10 -0400
Received: from jupiter.universe (dyndsl-037-138-186-138.ewe-ip-backbone.de [37.138.186.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 575762074F;
        Wed, 11 Mar 2020 22:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583965389;
        bh=kYAYe7rvFYpsfEZhSQulLoAH7GNlApiSAp32ZQAPNws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ua3j/5yQYxywGt4+z+NzcnktKXxTHcwQmvZ2o8AJFXy3XxrVRi5cWJL6RoqLHkIIU
         iVXF9b1mq7Uy6mbNa9S4Ep1u5UGFE0yhAx/BTI/24yDZQtjCf1Dqh9y9YL1RnPQX6b
         PknAq++W1R3wMFU2trebjPgwlYiEW+fPOk2Cs2z8=
Received: by jupiter.universe (Postfix, from userid 1000)
        id 82A714800FC; Wed, 11 Mar 2020 23:23:07 +0100 (CET)
Date:   Wed, 11 Mar 2020 23:23:07 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: twl4030: Use scnprintf() for avoiding potential
 buffer overflow
Message-ID: <20200311222307.bmj7e5fzxmhfvzp5@jupiter.universe>
References: <20200311090818.20797-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jwmb5qa3gisdthfp"
Content-Disposition: inline
In-Reply-To: <20200311090818.20797-1-tiwai@suse.de>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--jwmb5qa3gisdthfp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 11, 2020 at 10:08:18AM +0100, Takashi Iwai wrote:
> Since snprintf() returns the would-be-output size instead of the
> actual output size, the succeeding calls may go beyond the given
> buffer limit.  Fix it by replacing with scnprintf().
>=20
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/twl4030_charger.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/suppl=
y/twl4030_charger.c
> index 648ab80288c9..1bc49b2e12e8 100644
> --- a/drivers/power/supply/twl4030_charger.c
> +++ b/drivers/power/supply/twl4030_charger.c
> @@ -726,10 +726,10 @@ twl4030_bci_mode_show(struct device *dev,
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(modes); i++)
>  		if (mode =3D=3D i)
> -			len +=3D snprintf(buf+len, PAGE_SIZE-len,
> +			len +=3D scnprintf(buf+len, PAGE_SIZE-len,
>  					"[%s] ", modes[i]);
>  		else
> -			len +=3D snprintf(buf+len, PAGE_SIZE-len,
> +			len +=3D scnprintf(buf+len, PAGE_SIZE-len,
>  					"%s ", modes[i]);
>  	buf[len-1] =3D '\n';
>  	return len;
> --=20
> 2.16.4
>=20

--jwmb5qa3gisdthfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl5pZMsACgkQ2O7X88g7
+prUBg//ZswrDd49Xt1D0oK0sII4SWX616u7e6jeYH/JK54wYeCX3vu2gRS2YdfD
z4rjThWvEFnKRh/qhmjC0mlT2s4OkC80IAbX6kSEc/svo8/jsHX7rP1JUqkhrply
rl62jhX6ffi7ZbcwT0i9Zl7wBUHDitSkJGv6UXGIZfzyI9Y/IW3rtJOKVCSpdvKO
QGj2tEmEQb1+EDlIRAv4YA+gK1bHRpKrvRWJQD9xXBPBuwPBd+duB4DaA7ULOZAi
fwdR+w5f/9yMpp2s7oCi4I44d3U8s0rBp5FuDfKASAIQQU4WwnO1V0FR2mlrpc0O
ei6KDjMtQHSpFK+VPKt4Faa1p9r3Vrl8xl3/F9+MFtkStpEM7r2pqtRIREl8sAQg
VQbwT8+Wnw/ryza5JUAzs9/WXwO4GtEiD4ErHT+SbLh/EDFMEq6E5XYeUK1jjU6k
vtNwVyiX8waJTmcUXZSZzd0F14IFVNWw3Yprthc7tS9ChrRFynrMK3azksBCkUJH
iYwYnILdpg6WHCWhZiCcXdM0Tp/8EiWThJyVsOOnXCXT+fR4fc0y4RtUX4iUHf8X
maweABHXLg654VrJTUO/Y4g8OrbaLyzbF/5s4y+lxMVd/kwS8YmbawORdsWPKKs0
hdc2hCviBfGFFgluY49OgoDkgaeJGpX1/8+9UndXqRUHRQs0c0k=
=ij59
-----END PGP SIGNATURE-----

--jwmb5qa3gisdthfp--
