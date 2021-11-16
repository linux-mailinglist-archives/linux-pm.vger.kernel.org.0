Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA42453423
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 15:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237424AbhKPO3P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 09:29:15 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37348 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237431AbhKPO3O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 09:29:14 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 71CAD1F45793
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637072776; bh=p+84Xrz8FSKoixBY/HbQlzfr1EhSOjFp94DGnm3ck9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gzvw1zoFKC1rg0Aqd8+BHNJ9+lVQod7xo8RIVA05fsafH/RXEx4MEwP/ijt7EjQVw
         iHlUMYX63I5numKZMXoncjKP50SL+bHXJcf96CdQOJcz5sEzAeUYSo2BLRuAa9wZdP
         DB2K2Qh3kXEY9F591+fH0OlTlMDzIWgtF+nk6eFfiWmSNbPsW9bXGagQM3UUkBiF8C
         hZaphzPaA2LoyA1SWDkQ24baK8Sj8tFj1PXSHo++wm/urSqFkAEAiX5M6zK5thK+hw
         BSqlkTaeXpFty/HgeTR5dtBAhyU4I8zFzs9XS7CyhbRsQgCD0J/wvz6LTp3TWqO5J2
         DWnwBtrx7c+Jw==
Received: by earth.universe (Postfix, from userid 1000)
        id 5B8833C0F95; Tue, 16 Nov 2021 15:26:14 +0100 (CET)
Date:   Tue, 16 Nov 2021 15:26:14 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v2] power: reset: ltc2952: Fix use of floating point
 literals
Message-ID: <20211116142614.ofqoox6zpn5erlc3@earth.universe>
References: <20211105152049.2522250-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4hhn5uqosuvhtbid"
Content-Disposition: inline
In-Reply-To: <20211105152049.2522250-1-nathan@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--4hhn5uqosuvhtbid
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 05, 2021 at 08:20:50AM -0700, Nathan Chancellor wrote:
> A new commit in LLVM causes an error on the use of 'long double' when
> '-mno-x87' is used, which the kernel does through an alias,
> '-mno-80387' (see the LLVM commit below for more details around why it
> does this).
>=20
> drivers/power/reset/ltc2952-poweroff.c:162:28: error: expression requires=
  'long double' type support, but target 'x86_64-unknown-linux-gnu' does no=
t support it
>         data->wde_interval =3D 300L * 1E6L;
>                                   ^
> drivers/power/reset/ltc2952-poweroff.c:162:21: error: expression requires=
  'long double' type support, but target 'x86_64-unknown-linux-gnu' does no=
t support it
>         data->wde_interval =3D 300L * 1E6L;
>                            ^
> drivers/power/reset/ltc2952-poweroff.c:163:41: error: expression requires=
  'long double' type support, but target 'x86_64-unknown-linux-gnu' does no=
t support it
>         data->trigger_delay =3D ktime_set(2, 500L*1E6L);
>                                                ^
> 3 errors generated.
>=20
> This happens due to the use of a 'long double' literal. The 'E6' part of
> '1E6L' causes the literal to be a 'double' then the 'L' suffix promotes
> it to 'long double'.
>=20
> There is no visible reason for floating point values in this driver, as
> the values are only assigned to integer types. Use NSEC_PER_MSEC, which
> is the same integer value as '1E6L', to avoid changing functionality but
> fix the error.
>=20
> Fixes: 6647156c00cc ("power: reset: add LTC2952 poweroff driver")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1497
> Link: https://github.com/llvm/llvm-project/commit/a8083d42b1c346e21623a1d=
36d1f0cadd7801d83
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> ---

Thanks, queued to power-supply's fixes branch.

-- Sebastian

>=20
> v1 -> v2: https://lore.kernel.org/r/20211104215047.663411-1-nathan@kernel=
=2Eorg/
>=20
> * A separate review pointed out that NSEC_PER_MSEC is a better choice
>   than USEC_PER_SEC because ktime_t is nanoseconds and the few functions
>   that take these values work in nanoseconds. The value is the same but
>   the documentation is better.
>=20
> * Pick up Nick's review tag.
>=20
>  drivers/power/reset/ltc2952-poweroff.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/reset=
/ltc2952-poweroff.c
> index fbb344353fe4..65d9528cc989 100644
> --- a/drivers/power/reset/ltc2952-poweroff.c
> +++ b/drivers/power/reset/ltc2952-poweroff.c
> @@ -159,8 +159,8 @@ static void ltc2952_poweroff_kill(void)
> =20
>  static void ltc2952_poweroff_default(struct ltc2952_poweroff *data)
>  {
> -	data->wde_interval =3D 300L * 1E6L;
> -	data->trigger_delay =3D ktime_set(2, 500L*1E6L);
> +	data->wde_interval =3D 300L * NSEC_PER_MSEC;
> +	data->trigger_delay =3D ktime_set(2, 500L * NSEC_PER_MSEC);
> =20
>  	hrtimer_init(&data->timer_trigger, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>  	data->timer_trigger.function =3D ltc2952_poweroff_timer_trigger;
>=20
> base-commit: d4439a1189f93d0ac1eaf0197db8e6b3e197d5c7
> --=20
> 2.34.0.rc0
>=20

--4hhn5uqosuvhtbid
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmGTv4EACgkQ2O7X88g7
+pqHdA//Q+mvgq10/Ejyo+07Plky71EpBqEZj/dVjD4lo05aKvXxdcSjH5dR/PaJ
7tBeQixlwy+XAXu2LkNFTAebTWqQl3u01UPLmYrvfUUxKKCBefYXC9FoUwvEqxJW
DAnqSj9uKMAzxmN6iTzYi+y+NVZljItFkwIAOkvO9uL81Xdjo7FNccgqJBGzMa/1
rMXqrdHAaa7mQ2VGawIOOCYW+iltQLdglAOBvDUHfgM9jN/mhozm61rXOGg53X9B
cckGZqzqx1013mTTinCQ5B6xf2MDasQl8o3Gd7Zwzqun7Zi3N0QcaRU1CGaYdRER
MOTtlq0JRnFkpwUCaUZTcSEwQlRxl1pwSq81JHkorJC/B/OutJv8JdYz7K10axWm
I+NLo4oS4HeNTPHZoA+qcANQKXytNFshq3OF4B3glste2co1ro7WLrdRUsLno6Ph
T1xUH7EycXgZd/pdCyzhM60ig3FxBnv2qHLHkE3O2zA7ZmRkRrIM/Rplu4cgFiZD
cz5E1fJ6JxcTmDFilJDrllDT7vhI+0/U+/+8yI+Bx2n4zQIfQOlnCIKx1N3zspLm
eqtWG1P21C+2i4g4IbIchLMN0IbthvsLVcnHJdl/W4mY7EEl6hrFNkBWRTRhmIkA
0CpH4ft4JhMGmEVlVgmnur58bB3VsPom92UwC73R2yBMkZKNA5c=
=7Avg
-----END PGP SIGNATURE-----

--4hhn5uqosuvhtbid--
