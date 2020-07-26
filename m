Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C38422E303
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 00:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgGZWJw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Jul 2020 18:09:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:33352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgGZWJv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 26 Jul 2020 18:09:51 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 762762065F;
        Sun, 26 Jul 2020 22:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595801391;
        bh=LfHWfBg1Qfp818BKW1nd9sxbwjERmwPxm12kyIqm0Ak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1pCHgWq75TDYeOlW/SX2FohhHJ4AAL4TKHTj80iEU+lD0wfmvWm8m5Gh/sqYbB8TF
         Gjedib6n5Ej1KUI7qoPXQRJGNIzyrBmgLdbA9xJ5oApxzt3Iqt2tMusW2GONwyAwH1
         yOdCW4E0nnppQom5b5kGK4UUJ7EjjDrNrPVtYv0g=
Received: by earth.universe (Postfix, from userid 1000)
        id B16DA3C0B87; Mon, 27 Jul 2020 00:09:49 +0200 (CEST)
Date:   Mon, 27 Jul 2020 00:09:49 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] power: Convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <20200726220949.m456hoqcb5bis4ry@earth.universe>
References: <20200716085849.11571-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2twpfrl4w4tppxvr"
Content-Disposition: inline
In-Reply-To: <20200716085849.11571-1-miaoqinglang@huawei.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--2twpfrl4w4tppxvr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 16, 2020 at 04:58:49PM +0800, Qinglang Miao wrote:
> From: Yongqiang Liu <liuyongqiang13@huawei.com>
>=20
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>=20
> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>

Thanks, queued.

-- Sebastian

>  drivers/power/supply/da9030_battery.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>=20
> diff --git a/drivers/power/supply/da9030_battery.c b/drivers/power/supply=
/da9030_battery.c
> index 292ecf875..0deba48d2 100644
> --- a/drivers/power/supply/da9030_battery.c
> +++ b/drivers/power/supply/da9030_battery.c
> @@ -172,17 +172,7 @@ static int bat_debug_show(struct seq_file *s, void *=
data)
>  	return 0;
>  }
> =20
> -static int debug_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, bat_debug_show, inode->i_private);
> -}
> -
> -static const struct file_operations bat_debug_fops =3D {
> -	.open		=3D debug_open,
> -	.read_iter		=3D seq_read_iter,
> -	.llseek		=3D seq_lseek,
> -	.release	=3D single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(bat_debug);
> =20
>  static struct dentry *da9030_bat_create_debugfs(struct da9030_charger *c=
harger)
>  {
> --=20
> 2.17.1
>=20

--2twpfrl4w4tppxvr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl8d/ygACgkQ2O7X88g7
+pqmSA//fvwJAMXbsenKVkN26BoMn1sGqtCr6wiAveZsXonjqg6W8zMDW8AaDNJy
RUid+1abBPkqEJ8Vvo9azVGmhHbauh+/467fY4mPyjf/Gill+FxIdap/hriiom5P
XUKtQ9EzBroM55ktPkaH4W3lUjUTSpfuGdDc9DPKOi4Hr2VVo/pJ8PBrCm4g+MxE
m2Ufzda9YYYzbN8Pj71k6PgYCFlUEAIuaOSPxCOrTu6hIGOyyenySooPlXtp1YbG
Xd/o+1nHMuI+l/lKn9+ofh1xjrzz9uyOOKktPSlQhHtLG+zcfM9fHvTqpienqP3Z
qZQ12CCjbraBkduQpJtVKlyYRDBX6/xmgpvx7qYCNk57V1dyzcwDlpOUho5dwQ9D
Q2IzEpp6sP7R1Bj3Z03RSKtRtcl4GWumD1uKJFiZdObgIhqU8MobLE5nUYU5tdZt
zUPTkDgxOInHxq8btmM/pWpA9OlEeqmsNffCE9k5UCaoA4kYnl56CeEBjf7fH14x
IParuo95m1Ybi88QMu/grbXUmtHdZnGbqrSshF5zvSxaTqNupxFI+6WeEhYiRSWi
2xOrzTe/DwuFNJ8SA1A96+v1txu8pk+JBXkwnY4NBju9+cBQJ31L8ebgTl0kpfhF
c+a5z2qaLwCm/0/ECnVpd8xn1N20Ipgx83idM7zKQlB1qYYRr8w=
=iYzJ
-----END PGP SIGNATURE-----

--2twpfrl4w4tppxvr--
