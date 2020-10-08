Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B8E287EBB
	for <lists+linux-pm@lfdr.de>; Fri,  9 Oct 2020 00:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbgJHWhU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 18:37:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729017AbgJHWhU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Oct 2020 18:37:20 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6A1422243;
        Thu,  8 Oct 2020 22:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602196639;
        bh=x1SmoSmcLC3AgO9NSV4YaBZZzQalnejPtKrdLuUbWmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fL72wgri135ejMGWb6DK4zUxZo/ZvnKwhwMqX1OjhUVKEayNRWnfouUPzLK6FNuFr
         kUW4UlC9X/dEL1NvzJuCmnUNPlzySuxXtGNVcvXOnS9k1XcDWReSVJTLTr/6DFtZ/c
         n6t949BySsNsNRX4J6S25Y9xGa4tXBvD5FKtJ7Uk=
Received: by earth.universe (Postfix, from userid 1000)
        id 8B7003C0C87; Fri,  9 Oct 2020 00:37:16 +0200 (CEST)
Date:   Fri, 9 Oct 2020 00:37:16 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Myungjoo Ham <myungjoo.ham@samsung.com>,
        linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] charger-manager: fix incorrect check on
 charging_duration_ms
Message-ID: <20201008223716.353rpnkvte7q3miv@earth.universe>
References: <20200902133117.108025-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wyfglm34rtjztloq"
Content-Disposition: inline
In-Reply-To: <20200902133117.108025-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--wyfglm34rtjztloq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Colin,

On Wed, Sep 02, 2020 at 02:31:17PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Currently the duration check on the discharging duration setting is
> checking the charging duration rather than the discharging duration
> due to a cut-n-paste coding error. Fix this by checking the value
> desc->charging_max_duration_ms.
>=20
> Addresses-Coverity: ("Copy-paste-error")
> Fixes: 8fcfe088e21a ("charger-manager: Support limit of maximum possible")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/charger-manager.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/suppl=
y/charger-manager.c
> index 07992821e252..44d919954e9e 100644
> --- a/drivers/power/supply/charger-manager.c
> +++ b/drivers/power/supply/charger-manager.c
> @@ -471,7 +471,7 @@ static int check_charging_duration(struct charger_man=
ager *cm)
>  	} else if (cm->battery_status =3D=3D POWER_SUPPLY_STATUS_NOT_CHARGING) {
>  		duration =3D curr - cm->charging_end_time;
> =20
> -		if (duration > desc->charging_max_duration_ms) {
> +		if (duration > desc->discharging_max_duration_ms) {
>  			dev_info(cm->dev, "Discharging duration exceed %ums\n",
>  				 desc->discharging_max_duration_ms);
>  			ret =3D true;
> --=20
> 2.27.0
>=20

--wyfglm34rtjztloq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9/lJwACgkQ2O7X88g7
+pozdQ//V0Z7wo7rb2YBOxWmUcpp1KjqM12cynFCTDgE7ydMT64gZKFnNjQBk9zg
Y/WesekfwYIDdqt/7/sXHzNitNZjn/WeyBIaJBx7L9eVpTYsQNHDdwgNEIzQByDP
9SlzveKeVDdxpGacfsrEsBVnIo70LKunZ0TUb5wZcpWzDWN1xBi6xnYAMPRrWhrp
HXIst3Jl8tAWQWCVu+kzY5SVUA2TmPAbNrtrJExpUcwX7/sajhgUv2g6qPPkOvaN
UM9DS+kS3GPPM7raHUmL4Ph1gzuFsXemUCnTuQUq0uQJSQzVWaR82kSUcGTearP9
lJXbbMFOx2eai6qHGaJnafJRNOsYW2xU8Lxqv/HfD/M0b9KZr71jy2NoQFMYR0Bm
/ZH2pczf2t70QqzpIo7ScZYXl6pwDmiyxbMLorybAyc9sSIErqa/qeX0vx9t30TK
uyLv+uqNoKziiQe+D5FfkH1Mc3be2iSZJ2G+z3Z2mGlPGQDDB4ETcCUudL2nVgjD
3z9Te0FqZ9QaslzTiZqiyd3tIt7gZbKp++DxdBcodwPkagI6D/4ZcVof5YKpLTYx
zzqa9fKWOdw8sYVQ2cUlcvgFsI9tA3cfE3+l6D2QckdKN5MTcEErHZKm6ISahgd2
2Y9nMid6NJ2psIG0ancF/o2D1p56G5B3D8lSNYLiyoDWhhOGQms=
=Cx8z
-----END PGP SIGNATURE-----

--wyfglm34rtjztloq--
