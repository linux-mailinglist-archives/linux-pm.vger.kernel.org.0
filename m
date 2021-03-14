Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1594B33A8B6
	for <lists+linux-pm@lfdr.de>; Mon, 15 Mar 2021 00:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhCNXKG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 14 Mar 2021 19:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229532AbhCNXJv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 14 Mar 2021 19:09:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A4E264E57;
        Sun, 14 Mar 2021 23:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615763391;
        bh=JxP6qRPRnem1wDPQJdFgDNj+jcfWu9bKINw7cuKkFxk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mT5iCWxQuKdkus1tFq82hLru42YFQxRazEe2iQgUCT90DzvYu/0gu+JHxEiY5Ff63
         kF5BtPzfJFPm4JKoj5et9gfN/jga5pk8s9TAzEAY3XLXEDzMo8mTIWbpik/X+2o6FK
         ZgT8Ar+kKRduFYu9dyvs2iZfEUVI+K+uVBZDiw3nUo6YpvPDRlSQWCCY0PZ2TD9Xax
         hEgjF8WRz73TnZqhK8sGVNwg8XFku/icscvTXpR8OlxUeBmvOCqzljbN0zxqYJxA12
         8B4uVxtJfSgxgV+q6x77MoAzUTtOJNbLRloeVInP4bUv0Qep6flNHlaZ0zsobQnHEd
         djez6c/Dn3ZIw==
Received: by earth.universe (Postfix, from userid 1000)
        id 9436E3C0C96; Mon, 15 Mar 2021 00:09:49 +0100 (CET)
Date:   Mon, 15 Mar 2021 00:09:49 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-pm@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] power: supply: z2_battery: Drop unused variable
Message-ID: <20210314230949.r4btm5z6md3b274e@earth.universe>
References: <20210305100108.2036203-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4b3bikmbrn6z563y"
Content-Disposition: inline
In-Reply-To: <20210305100108.2036203-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--4b3bikmbrn6z563y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 05, 2021 at 11:01:08AM +0100, Linus Walleij wrote:
> The kernel test robot reports an unused variable in the
> Z2 battery code caused by a recent commit.
>=20
> Fixes: a3b4388ea19b ("power: supply: z2_battery: Convert to GPIO descript=
ors")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/z2_battery.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/z2_battery.c b/drivers/power/supply/z2_=
battery.c
> index b1508fe70e5e..7ed4e4bb26ec 100644
> --- a/drivers/power/supply/z2_battery.c
> +++ b/drivers/power/supply/z2_battery.c
> @@ -90,9 +90,6 @@ static void z2_batt_ext_power_changed(struct power_supp=
ly *batt_ps)
>  static void z2_batt_update(struct z2_charger *charger)
>  {
>  	int old_status =3D charger->bat_status;
> -	struct z2_battery_info *info;
> -
> -	info =3D charger->info;
> =20
>  	mutex_lock(&charger->work_lock);
> =20
> --=20
> 2.29.2
>=20

--4b3bikmbrn6z563y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBOl6oACgkQ2O7X88g7
+pp19w//Y6aykz8RqvuGqBJaFXPIbHhZvfjxAo01aosi5IJgva0Iufe1MCf3/on3
GNOxj9os0h8obhibgXk7an6HXw54q3CTsDBK7/mkRXezMO4FzPf/8co6Xk9CZvZc
yahWekF26Pig0A/oiIlCYKRMdEYBt/B9Agkjytdp2qdiCbFCLAgmNNcM0doQoemD
n6j54qypTm+5kW3DLxTN2LzcCYFmC6Ai6emXeXyP5t7yB8kdqE5yD51bAQv1JW5I
jvMLKHSI51bm5APfDg5FPQesB6GojQ0TOvOkSq0qThndxfR6n9INCS/FSkLtau+3
kkx9MKy/qUKKJWdxeEwfaxz3ugHfp5yUSFBQr7OyNpSPTyAFUHDWQ4RrbN5M/ORt
gT9bIQ2EG/+tCydWF+7JxHKWdoGLlQGZXMcugrMbtGvMohpDH4gKIGhtT7G6dLZb
7XUwTd9JSPQkqutMU4VgOGyk0W2Mlx+zIZxB1j0U3DcnE8Z3WvxxCJ/NoRntj4j+
owzYQO44NZMDuUvLLOpz5xiaufG8TeS7PHRmpdWDOyvpKbwoxgs+Y/ZwsBUXXfYM
scSQBKe7rgKkY9lTjTHeNR1VmBK1jKGhL0K7irCBAiIYWi4W1L0/L0S/6bJDVcou
G1Mug+r3MpThaaLE2OrlgLhL6Zx3WTv7kTCRmmCXwXfiexCdJaU=
=HSxq
-----END PGP SIGNATURE-----

--4b3bikmbrn6z563y--
