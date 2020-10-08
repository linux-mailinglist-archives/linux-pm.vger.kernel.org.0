Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72B0287EB7
	for <lists+linux-pm@lfdr.de>; Fri,  9 Oct 2020 00:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbgJHWfh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 18:35:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgJHWfh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Oct 2020 18:35:37 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB7F022243;
        Thu,  8 Oct 2020 22:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602196537;
        bh=PeIACjzzI6yIf/aSxGCPkaHQEf6QCvGkKA02CAPwhPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rbm4Z9YckXZAfXMNtCrryiF8e1XjrwzGoXDNlTISITnAVbQvSO/llaTNYNAv+uRY5
         e3aP6cOS2pl5aEk1pILSygRsOnafu88Vkrj+4QMnSmKSnLWtN57diK3S1KH41VQrdP
         hjnHydSn7TDPf7VMt9de1pt8t8ueqbewjJcJo/uM=
Received: by earth.universe (Postfix, from userid 1000)
        id 662303C0C87; Fri,  9 Oct 2020 00:35:34 +0200 (CEST)
Date:   Fri, 9 Oct 2020 00:35:34 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: charger-manager: Tidy function
Message-ID: <20201008223534.l7g3obifuyfddsc4@earth.universe>
References: <20200902165816.401213-1-alex.dewar90@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ezefwwe2vrkcuoxq"
Content-Disposition: inline
In-Reply-To: <20200902165816.401213-1-alex.dewar90@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ezefwwe2vrkcuoxq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 02, 2020 at 05:58:16PM +0100, Alex Dewar wrote:
> check_charging_duration() contains some copy-pasted code, which makes it
> less readable. Refactor the function to be a bit tidier.
>=20
> I've also fixed a couple of typos.
>=20
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> ---
>  drivers/power/supply/charger-manager.c | 39 +++++++++-----------------
>  1 file changed, 14 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/suppl=
y/charger-manager.c
> index 07992821e252..67c7b1fb6601 100644
> --- a/drivers/power/supply/charger-manager.c
> +++ b/drivers/power/supply/charger-manager.c
> @@ -443,42 +443,31 @@ static int try_charger_enable(struct charger_manage=
r *cm, bool enable)
>   * check_charging_duration - Monitor charging/discharging duration
>   * @cm: the Charger Manager representing the battery.
>   *
> - * If whole charging duration exceed 'charging_max_duration_ms',
> + * If whole charging duration exceeds 'charging_max_duration_ms',
>   * cm stop charging to prevent overcharge/overheat. If discharging
> - * duration exceed 'discharging _max_duration_ms', charger cable is
> + * duration exceeds 'discharging _max_duration_ms', charger cable is
>   * attached, after full-batt, cm start charging to maintain fully
>   * charged state for battery.
>   */
>  static int check_charging_duration(struct charger_manager *cm)
>  {
>  	struct charger_desc *desc =3D cm->desc;
> -	u64 curr =3D ktime_to_ms(ktime_get());
>  	u64 duration;
> -	int ret =3D false;
> =20
> -	if (!desc->charging_max_duration_ms &&
> -			!desc->discharging_max_duration_ms)
> -		return ret;
> -
> -	if (cm->charger_enabled) {
> -		duration =3D curr - cm->charging_start_time;
> -
> -		if (duration > desc->charging_max_duration_ms) {
> -			dev_info(cm->dev, "Charging duration exceed %ums\n",
> -				 desc->charging_max_duration_ms);
> -			ret =3D true;
> -		}
> -	} else if (cm->battery_status =3D=3D POWER_SUPPLY_STATUS_NOT_CHARGING) {
> -		duration =3D curr - cm->charging_end_time;

^^^ this is charging_end_time, not charging_start_time

> +	if ((desc->charging_max_duration_ms =3D=3D 0 &&
> +			desc->discharging_max_duration_ms =3D=3D 0))
> +		return false;
> +	if (!cm->charger_enabled &&
> +			cm->battery_status !=3D POWER_SUPPLY_STATUS_NOT_CHARGING)
> +		return false;
> =20
> -		if (duration > desc->charging_max_duration_ms) {

^^^ this is discharging_max_duration_ms after I applied a fix.

> -			dev_info(cm->dev, "Discharging duration exceed %ums\n",
> -				 desc->discharging_max_duration_ms);
> -			ret =3D true;
> -		}
> +	duration =3D ktime_to_ms(ktime_get()) - cm->charging_start_time;
> +	if (duration > desc->charging_max_duration_ms) {
> +		dev_info(cm->dev, "Charging duration exceeds %ums\n",
> +				desc->charging_max_duration_ms);
> +		return true;
>  	}
> -
> -	return ret;
> +	return false;
>  }
> =20
>  static int cm_get_battery_temperature_by_psy(struct charger_manager *cm,

So basically code is similar, but not the same.

-- Sebastian

--ezefwwe2vrkcuoxq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9/lDIACgkQ2O7X88g7
+prAQw//RGtWZhhNTNJMjPSK/8wkpCLAGBAQVhTRPagSQJ1qRtLM6UBzxtbULOGu
nCPIkPHkagnfFJwZSNM4tosHyH6X5L96IaoJ1qoIF51lHEeeeu8EJaXwV8AzQTo3
1+0303EZCtJRv1MuGUwT78hs3Wg1L93d/KYiiqltES1stqKSZjwaXafL0IVr7vdP
o6D7je47ZGRDM1bqd0s8fr4wcNZgV5ZSm7vhVi6ifYeFirYt8PP+WsmLmF0J7paE
712UVy+gVeYFBNoDWBbtHvuTWoxxKv0PB8/VwJ4MJEKyIC3Rj0VQ/u1B9PKrPbrj
E3v8ODYHwdsQo/ORK5Wnz55RJm6voWeDYyeQLPjmNNRGoQ1c+62hwRsq3ALhyUih
yOFZGR0HJVIO/zm+Gmw+h2zcfFIEgCHgD9km23TDVc3gM8CADAmM99qwkoTz3I5H
MOmpQgWCthrttBpQQkjreb7rLFwUfKQXKoz42qa3yAG0oLKTMDoHxh1Blp3F64kz
4HOixUKFjnwl+QIVZ/v7pFWnjnaIJzxMTpLb7AxIonw7Yq4ZtwJlLTdjy9sRiLUp
mNVj28kPwIfQXV81zWMiYrG3+pKyIQpagjsV8mZLvEp0QbpNxUyGXqckgwu+GVan
KsiqL4uHCH9IVPn5J4g1Wu+c+bJQPNd7UyweDEXn3KAhL+Y0ge8=
=foWd
-----END PGP SIGNATURE-----

--ezefwwe2vrkcuoxq--
