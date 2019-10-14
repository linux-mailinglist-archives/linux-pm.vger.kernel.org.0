Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE931D59FB
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2019 05:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbfJNDbL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Oct 2019 23:31:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:34632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729725AbfJNDbL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 13 Oct 2019 23:31:11 -0400
Received: from earth.universe (unknown [88.128.80.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D2922084D;
        Mon, 14 Oct 2019 03:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571023870;
        bh=dfOrrHn5Q/G7SfGnj2ZpeMdC3HyZW0tnttpQu2s9HrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T+8T1GlHPz06wcRulS1y3R0YgidOHjmbzaDBVNjMMD8AtUUDwjvgblt2Zy27s//Ys
         2oBgiSVYwbmK8ELpEIskcZzfTrFRd4hfVaSjJo3U3DJhvb2Q2NJP8VOH7bxz0k+zXe
         dQX7omoMgI/5lZrFWNbZC2kUzfp3Bs/yJ2L6yhx4=
Received: by earth.universe (Postfix, from userid 1000)
        id 05DD23C0CA1; Mon, 14 Oct 2019 05:31:08 +0200 (CEST)
Date:   Mon, 14 Oct 2019 05:31:08 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: max17042_battery: fix the potential
 uninitialized use in max17042_write_verify_reg()
Message-ID: <20191014033108.jgb2c7yy3y46l6tp@earth.universe>
References: <20191002154406.8875-1-yzhai003@ucr.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uy5mgzfnhj6ksy7u"
Content-Disposition: inline
In-Reply-To: <20191002154406.8875-1-yzhai003@ucr.edu>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--uy5mgzfnhj6ksy7u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 02, 2019 at 08:44:06AM -0700, Yizhuo wrote:
> In function max17042_write_verify_reg(), variable "read_value"
> could be uninitialized if regmap_read() fails. However,
> "read_value" is used to decide the control flow later in the if
> statement, which is potentially unsafe.
>=20
> Signed-off-by: Yizhuo <yzhai003@ucr.edu>
> ---

Instead of directly failing, integrate this into
the retry loop. Also the Signed-off-by and patch
author name looks incomplete.

Thanks,

-- Sebastian

>  drivers/power/supply/max17042_battery.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supp=
ly/max17042_battery.c
> index 0dfad2cf13fe..e6a2dacaa730 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -486,12 +486,15 @@ static void max17042_external_power_changed(struct =
power_supply *psy)
>  static int max17042_write_verify_reg(struct regmap *map, u8 reg, u32 val=
ue)
>  {
>  	int retries =3D 8;
> -	int ret;
> +	int ret, err;
>  	u32 read_value;
> =20
>  	do {
>  		ret =3D regmap_write(map, reg, value);
> -		regmap_read(map, reg, &read_value);
> +		err =3D regmap_read(map, reg, &read_value);
> +		if (err)
> +			return err;
> +
>  		if (read_value !=3D value) {
>  			ret =3D -EIO;
>  			retries--;
> --=20
> 2.17.1
>=20

--uy5mgzfnhj6ksy7u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2j6/sACgkQ2O7X88g7
+poCKw/3YVQktTEMrKN5htcAmBVhOdGo9C+Twnb/fTNXPQWEi4WV0683ghoVeNXd
fGiUAwqmDFkOMMKUY+NKITBJC4dAVrUXfBE0t/EwFKhU9JEy1P0DSwWHTIl3Yq+V
6GiQK9jjBdvbuJCSuzQXFUSlT1yfYr0ekeIsBYR1fnVhlNDuaDmJIZOB80cDA3m4
z17RsZlcFqAsaAAyaK3E5PrWQQJYM5vqeIXZqfOCspsXZfwTsTS7MM220/O6Er2Q
qaTgn5lBXTj0T4e2xLAfWbgKkuRROUf0wLwByY+ZYh9whRxe1N1582JzADn+ysMR
kHbU0pnxV/4LaCXWXq/nb2TO68FeM9cqwMLLJv1V2WpmyZM3bKvsLrF2JLQRmvuU
hP5vsMd/OR0fl8BFL0+G6ELzGuVKZ3ywMlcoCtVl5W0UUse9fDJHpc7O3STexomH
YMobOE5g574GDxmdNXtQXLRRDqP+9oX2ip3/WdNscfQtEh+laPAmFP0zkx4uiSne
TFWiyi6DimPAAuNY9xV2IkKZl06Mej3VHh2M8mocnVphXQRLTOm+BYIOzJXm985P
X1rbWC2aQLTg+NLY644YnJYcWKaw6YpQe/Rf+z/b2pdlbv/p3nVmcTB8h0ZcuCkX
89c3u/Nm03kK5+owvtWmTBiIOSJODw3a5eY1xExjF0gPFvfHxQ==
=brFC
-----END PGP SIGNATURE-----

--uy5mgzfnhj6ksy7u--
