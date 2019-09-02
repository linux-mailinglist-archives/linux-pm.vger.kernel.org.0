Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC7BA5C91
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 21:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfIBTKl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 15:10:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbfIBTKl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Sep 2019 15:10:41 -0400
Received: from earth.universe (unknown [185.62.205.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 286D021881;
        Mon,  2 Sep 2019 19:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567451440;
        bh=o6TcG03YBUB4jhK8VmhqyfAVlClgI8++mjZPPQ7PPEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yy1Bfhx5i1y36CLDTFjYmL11+cZygxG8NsTihXVcBSUkZMDPeYvxtbETzjFZEpAzW
         fHH1heLaABKOgvVRjZUcMc/dNRwmvJDkHBKkgxIiRmMgzFgGHKh5AKGQ63Sy+/XLYu
         SglACDPpwCarrRLBBbCKdxSRjc7/VyQkWF684Q3Q=
Received: by earth.universe (Postfix, from userid 1000)
        id EDFD33C0B7F; Mon,  2 Sep 2019 21:10:37 +0200 (CEST)
Date:   Mon, 2 Sep 2019 21:10:37 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/14] power: supply: sc27xx: Replace devm_add_action()
 followed by failure action with devm_add_action_or_reset()
Message-ID: <20190902191037.hjm7ppaq5npkkkur@earth.universe>
References: <20190708123259.11805-1-huangfq.daxian@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6wqikcdinrumvx6s"
Content-Disposition: inline
In-Reply-To: <20190708123259.11805-1-huangfq.daxian@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--6wqikcdinrumvx6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 08, 2019 at 08:32:59PM +0800, Fuqian Huang wrote:
> devm_add_action_or_reset() is introduced as a helper function which=20
> internally calls devm_add_action(). If devm_add_action() fails=20
> then it will execute the action mentioned and return the error code.
> This reduce source code size (avoid writing the action twice)=20
> and reduce the likelyhood of bugs.
>=20
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/sc27xx_fuel_gauge.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/sup=
ply/sc27xx_fuel_gauge.c
> index 9c184d80088b..58b2970cd359 100644
> --- a/drivers/power/supply/sc27xx_fuel_gauge.c
> +++ b/drivers/power/supply/sc27xx_fuel_gauge.c
> @@ -1023,9 +1023,8 @@ static int sc27xx_fgu_probe(struct platform_device =
*pdev)
>  		return ret;
>  	}
> =20
> -	ret =3D devm_add_action(dev, sc27xx_fgu_disable, data);
> +	ret =3D devm_add_action_or_reset(dev, sc27xx_fgu_disable, data);
>  	if (ret) {
> -		sc27xx_fgu_disable(data);
>  		dev_err(dev, "failed to add fgu disable action\n");
>  		return ret;
>  	}
> --=20
> 2.11.0
>=20

--6wqikcdinrumvx6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl1taS0ACgkQ2O7X88g7
+ppo/A//cxsiIU6totIzi1b9EtpeLb9zEQ4r47Vyly8/sMjlhpos3AGI4oaaGI95
bM7WnmcRthxxkPiw6CGfza9JyzfFPi0Fl5iO5788FEwdXnRvvRvzj6EuD0+4O41e
u4Avr+rqbGpKpweH7IIpBlfhEk7zDimZ0IooLJ9Seglmsg2eRKNQBywHeR/MbPC5
aBLW7krRs7JdEz3Ast5UescipE0oqVXEZME4Yw4/DQxn+yoQkcH/8En0duJql3bu
Io8tvxYmNlR8USSoWN6GGwavjCYpu43tdkWj+y3XaPSJ5jCTrXPzJ3ny1HDKy2Ee
6s6/6cMzcuOaySfj0n+0L8ZXM1FHb66LQbYwFJgdvHciS1RlI3df/QFb5Fz0dxPn
YRIhcLL7PYHLvZHvJb2Ff9X8sZ+dN0FginFCycUMbUxQgJwZ32mCBzG9NchcJMjT
3V6+exXwYgdQwMTxKDXKs/FG6S1gVCGFYyQr4U/vDULuoWLVRkf44dDPZV7jiiA3
TwyCWfkYgiJ3/VL65N8dPIK53pyEbmkvydQoZxIrr9dEitaYYkM5FR98V7rOzSeM
H28lhVZAvFHMa9AGLhlBeB6n1UWWeILzf6CIQKRmEnYFM0Q7bS65Inh+Zc6NUTlF
j615QU9+5pHRxZrR1Hd66ZwIF1BSE5AmbP3TzqoumMz441Jj85A=
=ZkWD
-----END PGP SIGNATURE-----

--6wqikcdinrumvx6s--
