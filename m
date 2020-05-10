Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D121CCC6F
	for <lists+linux-pm@lfdr.de>; Sun, 10 May 2020 18:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgEJQyw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 May 2020 12:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728681AbgEJQyw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 May 2020 12:54:52 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BEEC061A0C;
        Sun, 10 May 2020 09:54:52 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 092F12A0A58
Received: by earth.universe (Postfix, from userid 1000)
        id 1DC893C08C7; Sun, 10 May 2020 18:54:49 +0200 (CEST)
Date:   Sun, 10 May 2020 18:54:49 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] power: charger: max14577: Add proper dt-compatible
 strings
Message-ID: <20200510165449.d5vuqzo4fgkxu4re@earth.universe>
References: <20200220145127.21273-1-m.szyprowski@samsung.com>
 <CGME20200220145135eucas1p1ba181cef65c7a4f91a254ee35e022f08@eucas1p1.samsung.com>
 <20200220145127.21273-3-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ut7sdpq7tngbdbjc"
Content-Disposition: inline
In-Reply-To: <20200220145127.21273-3-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ut7sdpq7tngbdbjc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 20, 2020 at 03:51:27PM +0100, Marek Szyprowski wrote:
> Add device tree compatible strings and create proper modalias structures
> to let this driver load automatically if compiled as module, because
> max14577 MFD driver creates MFD cells with such compatible strings.
>=20
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/power/supply/max14577_charger.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/power/supply/max14577_charger.c b/drivers/power/supp=
ly/max14577_charger.c
> index 8a59feac6468..891ba9f6f295 100644
> --- a/drivers/power/supply/max14577_charger.c
> +++ b/drivers/power/supply/max14577_charger.c
> @@ -623,6 +623,15 @@ static const struct platform_device_id max14577_char=
ger_id[] =3D {
>  };
>  MODULE_DEVICE_TABLE(platform, max14577_charger_id);
> =20
> +static const struct of_device_id of_max14577_charger_dt_match[] =3D {
> +	{ .compatible =3D "maxim,max77836-charger",
> +	  .data =3D (void *)MAXIM_DEVICE_TYPE_MAX77836, },
> +	{ .compatible =3D "maxim,max14577-charger",
> +	  .data =3D (void *)MAXIM_DEVICE_TYPE_MAX14577, },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, of_max14577_charger_dt_match);
> +
>  static struct platform_driver max14577_charger_driver =3D {
>  	.driver =3D {
>  		.name	=3D "max14577-charger",

Independently of the discussion in patch 1 this is missing the link
to the of table in platform_driver->driver->of_match_table.

-- Sebastian

--ut7sdpq7tngbdbjc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl64MdQACgkQ2O7X88g7
+pon5BAAgLSR2GaiG7ZcwcUyWL3Fl65dPuLl45Xbr3fPQykYwbzUvVmJ6jwDc8yo
lwbJzAxW7L/USAYQ/gLKW1Cs+sEE035GA9V0MdxaasuIUFqc2KIoU2mw/TCvt/CN
fNOCwpavTbNpMtWHuyBlY2Z1qMJPOb29ji9W4Rd8w1pSy75gmGtkZ+Lrm7//Y8wb
tX/eNqMl/3mrYWLk8ft/yFVWdsEdkmA9+b4t9SZ5hqba9sR9tEfOshiKw7rhoEec
9Zzxd8LbMZziN3KuUGd5UuG9IqRa7hn0Mslkmk4l7Zq6Y9Q6j6RgJMSB6iB8fqNz
gZqvZm9VJ0xxcxziO0keFOylw80JaxFOzJGbE5knf2vhpuPUnHRJwunoEajdUVR2
1auNHy1Gc8Q1dQadowuoubnWm9bNdxekccWZne59cUXVCAPT8wtgx4BfjfOqKt0n
hXd0LT9KoSUVtiY7o+P+z6BS3iHRegv2wGRd1nResH+ZVPbk46AFlHJQPreT/1XH
NZPPGD3zW3Z+sIiV5U5NjiyxNVAwXTNj8PDChgubj32cw2vjL8bppmBoYZWFYGoD
oTbU/1b6FrfkZ49CPcj4T+n3se2kmCSF7QyT7A/M/uCT6hOOQNW+40bFowcevkrk
YY2kUgTcPX+YWNddNMUdNtLU1wz+jVahr/1oWCDHhE55qJOUtJE=
=aaxC
-----END PGP SIGNATURE-----

--ut7sdpq7tngbdbjc--
