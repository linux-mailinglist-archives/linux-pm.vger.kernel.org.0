Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C213C17C73F
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 21:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgCFUrR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 15:47:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:39382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgCFUrR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Mar 2020 15:47:17 -0500
Received: from earth.universe (unknown [185.62.205.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FFA2206CC;
        Fri,  6 Mar 2020 20:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583527635;
        bh=CGUlFpKeC/Aq+Hjpqcsgc5CwpgRqbAKS3+GmNaXWkpA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a4PHKn1ug9riJMNVQh3J0n20OlbM8gdPvxLheZFxIEwgeXRM4dGJLx5SeTnIaKsEy
         WEo5tXuUECHqdXN3afFYK+Iq7ZE+/mtIimwi0C/paXx2vqjGll3zre+E0SEAimJZ76
         5ybXJ2wLmgandLMcCPlEksy74FdzFUxfXaPEL2yM=
Received: by earth.universe (Postfix, from userid 1000)
        id 0EB533C0C83; Fri,  6 Mar 2020 21:47:12 +0100 (CET)
Date:   Fri, 6 Mar 2020 21:47:12 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, saravanak@google.com,
        kernel-team@android.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] power: supply: Allow charger manager can be built as
 a module
Message-ID: <20200306204712.dgomi52jzyakylky@earth.universe>
References: <5e098be25c70e07c37e743f84a901f6f756090e0.1583461755.git.baolin.wang7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gsujtxoazwncud73"
Content-Disposition: inline
In-Reply-To: <5e098be25c70e07c37e743f84a901f6f756090e0.1583461755.git.baolin.wang7@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--gsujtxoazwncud73
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 06, 2020 at 10:34:10AM +0800, Baolin Wang wrote:
> Allow charger manager can be built as a module like other charger
> drivers.
>=20
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> ---

Thanks, queued. I do not like this driver, but its the best we have
at the moment.

-- Sebastian

> Changes from v1:
>  - Use IS_ENABLED() instead.
> ---
>  drivers/power/supply/Kconfig          | 2 +-
>  include/linux/power/charger-manager.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 9a5591a..195bc04 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -480,7 +480,7 @@ config CHARGER_GPIO
>  	  called gpio-charger.
> =20
>  config CHARGER_MANAGER
> -	bool "Battery charger manager for multiple chargers"
> +	tristate "Battery charger manager for multiple chargers"
>  	depends on REGULATOR
>  	select EXTCON
>  	help
> diff --git a/include/linux/power/charger-manager.h b/include/linux/power/=
charger-manager.h
> index ad19e68..ae94dce 100644
> --- a/include/linux/power/charger-manager.h
> +++ b/include/linux/power/charger-manager.h
> @@ -248,7 +248,7 @@ struct charger_manager {
>  	u64 charging_end_time;
>  };
> =20
> -#ifdef CONFIG_CHARGER_MANAGER
> +#if IS_ENABLED(CONFIG_CHARGER_MANAGER)
>  extern void cm_notify_event(struct power_supply *psy,
>  				enum cm_event_types type, char *msg);
>  #else
> --=20
> 1.9.1
>=20

--gsujtxoazwncud73
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl5itswACgkQ2O7X88g7
+popsBAAjRAF+IgaH0fiR6Fw3tg3XSc9b4LzYAhiRyTbjBVFouvCA3k583qlngSb
78cFhEZzbtnWTyGmXQ31Vbs1YWVCQm7vKIWRHabkzYXRnWMvuE+ZPvm5tf03kpZs
7SsI4tp6+eb5cq0XIYx4taqV1RWzrRiOoSzQdM+vpHldIQJnZEqy2oeNHTuoTPxe
OeF12rW5G3sw4E8pzUDhv7i/DpyPCC2ox6V5EItWjmlsvDhHVeV8Sb71QSAKSpAe
r2fcZbt9h9InMMzfSyG/u06HY6WmHzdXHvyxry+nFyVpKgT6bYbZVVHV8SrHVZNt
EcOW5JSstz4d9G52v9d7+VEFjR60Nad7KnvmH7elhQtRWhBkpSGIseG0SkZVfLnc
TAfs+cpWBqaj0FveKoB+NAEY/ojhvgUGZCqi7IBxGFofiucTlsWz3qt0BPP0P3Fo
goWP2J1GuQ8XnuVRFumNW39fAoY9J9m74C687xBRVKp1rof3QOmgCC5SutagkXKs
wwE3kNSlkv/d4SH/CRxlzYwK175Xk/Bh2NcJRzwYwub0+UsqAVq4FbXgAIhAskk7
0LfBYMaD17HzOWx0cD7sg9rBvldbF4zREFHtOXqKOb0FN5mRtsl133hCek21qPBT
/R7I0/ty1C+5KHoqWIva4Qr66OoYU+cwgy4uHmuHIe/sGINndZk=
=A++/
-----END PGP SIGNATURE-----

--gsujtxoazwncud73--
