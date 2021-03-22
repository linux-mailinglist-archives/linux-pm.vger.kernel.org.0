Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A1434465E
	for <lists+linux-pm@lfdr.de>; Mon, 22 Mar 2021 14:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhCVN70 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 09:59:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230246AbhCVN65 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Mar 2021 09:58:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E3D761580;
        Mon, 22 Mar 2021 13:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616421536;
        bh=Evsjq2jtiHcVwQkjz/eB3zclEa72ltPjUKmSYqOBOIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mbHvjog1uZS/0VJpPyzhWfjUTHmXFBkCeicVciGaKggyuaud42HJiNJvJCPSYepCh
         4uDmTCDpOZYvKHRJ/o1vLSFqYcct1d0SIm2+YrKTlMKOFM91IRevTrI66dQTUMytQC
         QbwIZYV9y7haPQrD79aDHf4Y5rowfTjHmAK0QvN0GiPuA7ku7mbxUHVmV8Y3BEiAp7
         YUuWeS0c412ky9QR8bZ9okUY6EMnD4Ka+rrXZGqUi0ZG4ps2JZvRRIsYNTAihaFDu8
         xg4OCCruyvYkkbeF0Xh8dHjwUSIjFrFbLAtRlIFPEMxvzSd18c7FDJ0KY3PBvzjSkU
         fi52VrVaQ9piw==
Received: by earth.universe (Postfix, from userid 1000)
        id 482733C0C96; Mon, 22 Mar 2021 14:58:54 +0100 (CET)
Date:   Mon, 22 Mar 2021 14:58:54 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Jian Dong <dj0227@163.com>
Cc:     liviu.dudau@arm.com, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com, linux-pm@vger.kernel.org,
        huyue2@yulong.com, dongjian <dongjian@yulong.com>
Subject: Re: [PATCH] power: reset: remove Unneeded semicolon
Message-ID: <20210322135854.32qttdae565c7qyf@earth.universe>
References: <1616413347-149266-1-git-send-email-dj0227@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qemm3v62tpxvt4av"
Content-Disposition: inline
In-Reply-To: <1616413347-149266-1-git-send-email-dj0227@163.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--qemm3v62tpxvt4av
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 22, 2021 at 07:42:27PM +0800, Jian Dong wrote:
> From: dongjian <dongjian@yulong.com>
>=20
> Fixes coccicheck warning:
> drivers/power/reset/vexpress-poweroff.c:136:2-3: Unneeded semicolon
>=20
> Signed-off-by: dongjian <dongjian@yulong.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/reset/vexpress-poweroff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/reset/vexpress-poweroff.c b/drivers/power/rese=
t/vexpress-poweroff.c
> index 1fdbcbd..447ffda 100644
> --- a/drivers/power/reset/vexpress-poweroff.c
> +++ b/drivers/power/reset/vexpress-poweroff.c
> @@ -133,7 +133,7 @@ static int vexpress_reset_probe(struct platform_devic=
e *pdev)
>  	case FUNC_REBOOT:
>  		ret =3D _vexpress_register_restart_handler(&pdev->dev);
>  		break;
> -	};
> +	}
> =20
>  	return ret;
>  }
> --=20
> 1.9.1
>=20
>=20

--qemm3v62tpxvt4av
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBYop4ACgkQ2O7X88g7
+ppCGA/+Jd6amW1SBtzUvNw3Nv0fTj/+mw8UowACLYB1EgWEFTG5ManjNb9SBPdg
nm49jlKXh7/vCZe95h5dQ0fuUsp05G7cA/uMw3KgKKasePdTzwNMbAcqmKKtqs5w
HmD1mQEu4ww3V/GxXLyoLo/D240eNJwnCICt0j7+Vi1wi2DaZqytlnemaegXh4V2
ytVOr5ug/PnilomdlE6CK24RI0kMH6UL8fsIn8VqJZAfBmETxVyIdqMk02XWRAOS
UMrjz1jup6WCINgpISBzHZTZaKHVu2yCkx510K81tp7CLK8fUqEUw1DR9PCG3pPk
IHNzsHjrZ7zxjn0t4K2a0Ys/oy/3aYN3quA1EvVPyYR2+EbDdyw16tZYrwjleoky
e0luKXPLDWw/3hUGGboW105JHbC6Pn7js/ycRiykWV/vXKpzs1t0xS6js2hZVHa7
/mJcHWHVAFZ9jwRpN/BeZmdTp3Byv7GHAyDE+da0NVWi0ebf4SfG3SeRq/xCIZrc
VXsl90d8rBwHlSvD/RQRxoazlTRbY/s8TAi+J64Be3PgdeQgU63OnA5OQ6vnAs+2
X5XimFpjss5WW1+plAHO6fa6Na2ut12ZjjizOmeqDa3jKES4WfHAIU9gUUp8aIZH
SMsKvenuKdUP9uKJrbTsoIz/AHQBPQdKeP7g+LihPLhDA6xnjYI=
=i61n
-----END PGP SIGNATURE-----

--qemm3v62tpxvt4av--
