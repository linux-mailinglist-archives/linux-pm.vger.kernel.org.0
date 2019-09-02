Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB014A508C
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 10:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbfIBIA3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 04:00:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729535AbfIBIA3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Sep 2019 04:00:29 -0400
Received: from earth.universe (dyndsl-091-096-044-124.ewe-ip-backbone.de [91.96.44.124])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF1DE22CF7;
        Mon,  2 Sep 2019 08:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567411228;
        bh=3xg+BS+Ou6uDWkRUrnwy0vuxGcEtICkUPRmjrR/l0cQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n66uzcwdNKpKnzEO0vt0So/yOQTeuKtCZiDp/mO7gQKJpQlSegs779e4kXENQMOmB
         5Zi0L9Y2TQRwyybsnFZ6NgER4sbFIwNeVbpr6831nP+KSkCbJFM650hnReZ4fBZ4aD
         OlNI9IPO+JFmxWTylSAIpY4QhV5yTKM0eGsUVntY=
Received: by earth.universe (Postfix, from userid 1000)
        id 22E653C0B7F; Mon,  2 Sep 2019 10:00:25 +0200 (CEST)
Date:   Mon, 2 Sep 2019 10:00:25 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: ab8500_charger: Mark expected switch
 fall-through
Message-ID: <20190902080025.n3kxmjax2avbg3if@earth.universe>
References: <20190805194418.GA14438@embeddedor>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2fdd54solnguvrgu"
Content-Disposition: inline
In-Reply-To: <20190805194418.GA14438@embeddedor>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--2fdd54solnguvrgu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 05, 2019 at 02:44:18PM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
>=20
> This patch fixes the following warning (Building: allmodconfig arm):
>=20
> drivers/power/supply/ab8500_charger.c:738:6: warning: this statement may =
fall through [-Wimplicit-fallthrough=3D]
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/ab8500_charger.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply=
/ab8500_charger.c
> index 30de448de802..1be75a2fed9b 100644
> --- a/drivers/power/supply/ab8500_charger.c
> +++ b/drivers/power/supply/ab8500_charger.c
> @@ -742,6 +742,7 @@ static int ab8500_charger_max_usb_curr(struct ab8500_=
charger *di,
>  						USB_CH_IP_CUR_LVL_1P5;
>  			break;
>  		}
> +		/* else, fall through */
>  	case USB_STAT_HM_IDGND:
>  		dev_err(di->dev, "USB Type - Charging not allowed\n");
>  		di->max_usb_in_curr.usb_type_max =3D USB_CH_IP_CUR_LVL_0P05;
> --=20
> 2.22.0
>=20

--2fdd54solnguvrgu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl1szBgACgkQ2O7X88g7
+pr1sxAApGaVyXkqbtG+fBYAj/J1LDcgxIz4t8uBYiC0CgsvDtSD1GB9X6A5pbg6
WuZGNuMB+blbr+DcB3a07OxFj1j78ifbFWpTWgUZlWumtG1Ziam8SXCAFxKm8uPR
mvC1xFD2ztUKD4P/iHcBBStVfbs5BMQc/VPM7/GPnnIM4tZkBbX2pUBVJEaX9IRX
WNBhcdbS/c6CVUSwGMozeoFmpOghGR+OZ5dX5w0hh0lLWwgNrrEH29FreIoqvbCw
WDXOaEqjp0w7C4S7QjSUxWiG4ijLaPkeXWLkjJRMLLeo2q5/u2z7v0/vkddVveqz
1p3ZlolU0xUt1LgJXXMim7+FXy7ujVVPDVIrK7tefxhujhgTMsrYsDcHozUjBRpO
/bMCipogB4z+5UM7yGGcKVMVYAEGGYvbFAG/DRWCx+bpGQ8PCWFyipxZBiRoTgdv
iUSOr4l/u7sKnrtLaDeC+RnSyzsiaLOOINPsm931HUz/Prh1S+wS2/fCoIf7P/Xz
OZCiRhnrVYWyk0hquGgINXRw6DkaqUdf8yUHRhk3rzif1Bw/DP1JWScfqwO0FMS4
wPcrQW5vGjoI0zxgAY8S/sLLlSaS8u9u/68z0mJe2xSLzhhdSjt12t/WCP8Ye4lH
G80YVHpwfZ5TfT7WS/vP8fk4SoXwSzAEZP7jimBI+IjA3riqimU=
=E+WI
-----END PGP SIGNATURE-----

--2fdd54solnguvrgu--
