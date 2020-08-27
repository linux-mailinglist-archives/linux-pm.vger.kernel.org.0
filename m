Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42FF2550E4
	for <lists+linux-pm@lfdr.de>; Fri, 28 Aug 2020 00:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgH0WDZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Aug 2020 18:03:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbgH0WDW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 Aug 2020 18:03:22 -0400
Received: from earth.universe (dyndsl-037-138-189-082.ewe-ip-backbone.de [37.138.189.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32C0620848;
        Thu, 27 Aug 2020 22:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598565802;
        bh=yC6+oS9RFVrj0OBPN3ZF3rWZlKGqyG9tt4kU0LcHUD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o91fyr/0lApJAHUbF3zB1D+/YLQqIscVtzv3WPOBTcub/sBnLWEJ6mrUVd0kelScG
         bg7RbXIYIZ8VbsLnmCeKaBuO2WtwZMCdzPS2jmL1J2lY0FDuvySeLbSvxNMSKydfbN
         POLI42LY4pEsJ+pc1FK8QNlOGYXamjt+C2MbK+I8=
Received: by earth.universe (Postfix, from userid 1000)
        id 8F5A93C0C82; Fri, 28 Aug 2020 00:03:20 +0200 (CEST)
Date:   Fri, 28 Aug 2020 00:03:20 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: pm2301_charger: fix spelling mistake "chargind"
 -> "charging"
Message-ID: <20200827220320.emd326ges4xvmh57@earth.universe>
References: <20200805103857.15725-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="irgerrldmpxdwxr5"
Content-Disposition: inline
In-Reply-To: <20200805103857.15725-1-colin.king@canonical.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--irgerrldmpxdwxr5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 05, 2020 at 11:38:57AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> There is a spelling mistake in a dev_dbg message. Fix it.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/pm2301_charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/pm2301_charger.c b/drivers/power/supply=
/pm2301_charger.c
> index 17749fc90e16..787867805944 100644
> --- a/drivers/power/supply/pm2301_charger.c
> +++ b/drivers/power/supply/pm2301_charger.c
> @@ -396,7 +396,7 @@ static int pm2_int_reg3(void *pm2_data, int val)
> =20
>  	if (val & (PM2XXX_INT4_ITCHARGINGON)) {
>  		dev_dbg(pm2->dev ,
> -			"chargind operation has started\n");
> +			"charging operation has started\n");
>  	}
> =20
>  	if (val & (PM2XXX_INT4_ITVRESUME)) {
> --=20
> 2.27.0
>=20

--irgerrldmpxdwxr5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9ILagACgkQ2O7X88g7
+poolg//QUkPRykffzY0baeQLXfefP7obgkkjTBU5f2BsgVEKU4AJFEGKVf30srg
nJRXNGfdka6mikKDiWDXEzo7BhwxdYs+pyno0EaIQKnI5rbWaoqeLoUKlGOjrAoO
/3pgc/HU6wmkTRgkcw2KW1DCbIcP+xsaNXZenlLQDMamHDwT7zQJtaW7LsCufVsz
fFwkJX0WCn0EzEX+OHHo4eyCWM1xib/a8creF7kmohspXlgiBFq1HvMZbH3mLm5R
ryU+QoXFht1ViJkwOJ2egChd8rDnOMyfj3AgvFpZbPsYK/arbC1jelMYJX+JELUE
/4VfJLl2WcM/Vx4KeVql7nwIbkn8aGFWZl5ZLFkNaicq6aUTaRdl9YTm7VUWKZkF
75yHqAoXDSCb+yAvjVkcOiidu/tnI02nIW/ZbJHCWiwI2/uNX7bPQp2sAXKS1t9O
MQkTv7Lf+6DT0rFrti3xh9/MbsunusIoARKiz5yipNkqAUW284rrH3lq9GRpK2bU
upC6hfUGo4k++LHc38zscH5SO1QGaQxo7zaHoYm6FzPF6qfIbfWMG0koLi1QSww4
3xD/xzufgftvo51LU3CkUpiAcpgTweQtattoEcgzsl0NJr4fNI3d9X7VGUrTX1xJ
GadXsz25HD4pZu1A4H7cPD7nj8jM4TlvRLx4kPS6ga/MjjgOrUI=
=0Lqn
-----END PGP SIGNATURE-----

--irgerrldmpxdwxr5--
