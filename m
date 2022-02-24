Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B924C29EA
	for <lists+linux-pm@lfdr.de>; Thu, 24 Feb 2022 11:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbiBXKy6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Feb 2022 05:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiBXKy5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Feb 2022 05:54:57 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925D727992D
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 02:54:28 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 20F561F44F1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645700067;
        bh=jyakSzlPUZInKe2LRE4gPhKLDpLB/xdekgws3nOL2o4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SkdqkGEF8W/Y0DtCI8pYREiSkwlaqYMfuohvhwKWVSLNlmHfItENRmYtLktUC+hNT
         DCsWlF9P8yb545xVUq3cKBp3+l8xqFHSCEyo79DHaN1q3KJkoc/klJmVvLzpXHE/w9
         X9R7EIOYE3TwZr9TNBepuL9WTQOy/gqj4FGZ+x7IE6Ggz5rmGYu0jROjsB7JsR2SjX
         qzZhMJlNXf68BUHsJHz18D8U7rVqodvxF+gKbVUnGDDcEscXnyVs2KCJndnrW0mBq5
         kY061bMBlskUCwS+KrbNYWdOlavlpN1DlUNIUxgEwKD6jUykV+PMVXB3epXuYInHoc
         YwJbvBcvLvhBg==
Received: by mercury (Postfix, from userid 1000)
        id C9CD4106049B; Thu, 24 Feb 2022 11:54:08 +0100 (CET)
Date:   Thu, 24 Feb 2022 11:54:08 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: Use an rbtree rather than flat register
 cache
Message-ID: <20220224105408.hx5xbg4xizr6punl@mercury.elektranox.org>
References: <20220222214331.1557723-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x3kqi7mdyf2vuevp"
Content-Disposition: inline
In-Reply-To: <20220222214331.1557723-1-broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--x3kqi7mdyf2vuevp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 22, 2022 at 09:43:31PM +0000, Mark Brown wrote:
> The smb347 has a very sparse register map (the maximum register is 0x3f b=
ut
> less than 10% of the possible registers appear to be defined) and doesn't
> have any hardware defaults specified so the sparser data structure of an
> rbtree is a better fit for it's needs than a flat cache. Since it uses I2C
> for the control interface there is no performance concern with the slight=
ly
> more involved code so let's convert it.
>=20
> This will mean we avoid any issues created by assuming that any previously
> unaccessed registers hold a value that doesn't match what's in the hardwa=
re
> (eg, an _update_bits() suppressing a write).
>=20
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/smb347-charger.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply=
/smb347-charger.c
> index d56e469043bb..1511f71f937c 100644
> --- a/drivers/power/supply/smb347-charger.c
> +++ b/drivers/power/supply/smb347-charger.c
> @@ -1488,8 +1488,7 @@ static const struct regmap_config smb347_regmap =3D=
 {
>  	.max_register	=3D SMB347_MAX_REGISTER,
>  	.volatile_reg	=3D smb347_volatile_reg,
>  	.readable_reg	=3D smb347_readable_reg,
> -	.cache_type	=3D REGCACHE_FLAT,
> -	.num_reg_defaults_raw =3D SMB347_MAX_REGISTER,
> +	.cache_type	=3D REGCACHE_RBTREE,
>  };
> =20
>  static const struct regulator_ops smb347_usb_vbus_regulator_ops =3D {
> --=20
> 2.30.2
>=20

--x3kqi7mdyf2vuevp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIXY7wACgkQ2O7X88g7
+pobYRAAjWsJTBbi5o4VfvG4tfeR6CRqSC+uCe44vpROnQrvO1IaAo9MNLcDlJWY
AzaDv6fByTK0eReewjzPuXimdzLT6rZyNerNaBN/GX5B0LQeDUoOx1Gbp1Lj/wjS
GxAM5sCRuHQoY9NQ6SbmqACSLwIHmDeSn68PSjzsbiYM/2E4MOC3wjyhD8gcn657
2z8CGLihJ0DxoBanCkk2sFSgaiQR4Eee+hfYrfLwnz2ZqUPl24G/0kY1xrdcXDt3
4pzET+Lh1M911PuoDozl4LUjkdiaGxIqVA452FiMJaIhpcsWJJi3J0PYoackJmBc
uLes721sKuMmCAXDo65XYyYDNxDFmpevzbrSZewQXD1MQUkiYzkKOSFnXbH5aq+q
WXQ1r8QBDgE5nJT4Ev8Wvxtp8Vdq+K1ICmz0VivN+FzDPWfKqzAXZg7VOl3EP6mm
Kk5/iuyTHnX3OpsrXXSv61Lpm+VOzmMedfzCLaCcPhwbPCePZsfMUgwBz1cw7rDi
Xb8VFE91KGlsVDP9P+cZb6OFcoDEZ7gETiuMy9PD5LDQIvE2icM078aZa0wm8Ecn
p15Q4A0pYJlpx/vAA46NM6vnF42fccfm2e/mLWBJRhFCmkySaH7OHv8Klt96WEZw
WTHZAvM5srGPKfRaZQSTAQGeB8lobKvbeE9torLqw5tvepJmhgg=
=3Pd+
-----END PGP SIGNATURE-----

--x3kqi7mdyf2vuevp--
