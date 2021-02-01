Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905C630A5D7
	for <lists+linux-pm@lfdr.de>; Mon,  1 Feb 2021 11:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbhBAKxq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Feb 2021 05:53:46 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:56658 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbhBAKxn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Feb 2021 05:53:43 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id CF9951C0B78; Mon,  1 Feb 2021 11:52:43 +0100 (CET)
Date:   Mon, 1 Feb 2021 11:52:43 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Abel Wu <abel.w@icloud.com>
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, hewenliang4@huawei.com,
        wuyun.wu@huawei.com
Subject: Re: [PATCH] PM: hibernate: add sanity check on power_kobj
Message-ID: <20210201105243.GA23135@duo.ucw.cz>
References: <20210201075041.1201-1-abel.w@icloud.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <20210201075041.1201-1-abel.w@icloud.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2021-02-01 02:50:41, Abel Wu wrote:
> The @power_kobj is initialized in pm_init() which is the same
> initcall level as pm_disk_init(). Although this dependency is
> guaranteed based on the current initcall serial execution model,
> it would still be better do a cost-less sanity check to avoid
> oops once the dependency is broken.

I don't believe this is good idea. If the dependency is ever broken,
this will make failure more subtle and harder to debug.

> Signed-off-by: Abel Wu <abel.w@icloud.com>
> ---
>  kernel/power/hibernate.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index da0b41914177..060089cc261d 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -1262,6 +1262,9 @@ static const struct attribute_group attr_group =3D {
> =20
>  static int __init pm_disk_init(void)
>  {
> +	if (!power_kobj)
> +		return -EINVAL;
> +
>  	return sysfs_create_group(power_kobj, &attr_group);
>  }
> =20
> --=20
> 2.27.0

--=20
http://www.livejournal.com/~pavelmachek

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYBfdewAKCRAw5/Bqldv6
8hWOAJ9GZ5FYShq3xhcMliGsSXBmz0SA+gCePQN4Q0MHaHcYqgR2q8kjeDrW2mM=
=nGhd
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
