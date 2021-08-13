Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6EC3EB992
	for <lists+linux-pm@lfdr.de>; Fri, 13 Aug 2021 17:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241357AbhHMPyW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Aug 2021 11:54:22 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57574 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241418AbhHMPyW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Aug 2021 11:54:22 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A8F7C1F40E8C
Received: by earth.universe (Postfix, from userid 1000)
        id 4B5E23C0C99; Fri, 13 Aug 2021 17:53:51 +0200 (CEST)
Date:   Fri, 13 Aug 2021 17:53:51 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Colin King <colin.king@canonical.com>
Cc:     linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2][next] power: supply: ab8500: clean up warnings found
 by checkpatch
Message-ID: <20210813155351.dj67imzn5nfpdf3d@earth.universe>
References: <20210720082922.6398-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lewwtmsomymedhht"
Content-Disposition: inline
In-Reply-To: <20210720082922.6398-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--lewwtmsomymedhht
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 20, 2021 at 09:29:21AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Clean up a handful of checkpatch warnings:
>  - static const char * array should probably be static const char * const
>  - function arguments should have identifier names
>  - else should follow close brace '}'
>  - suspect code indent for conditional statements
>  - unnecessary parentheses in an if condition
>  - avoid multiple line dereference
>  - remove debug showing function execution, ftrace can trace these better
>  - prefer 'long' over 'long int' as the int is unnecessary
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> V2: Fix subject, s/cppcheck/checkpatch/
>     Remove debug, ftrace can track these better.
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/ab8500_chargalg.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/suppl=
y/ab8500_chargalg.c
> index 46b0c9fedebb..ff4b26b1ceca 100644
> --- a/drivers/power/supply/ab8500_chargalg.c
> +++ b/drivers/power/supply/ab8500_chargalg.c
> @@ -123,7 +123,7 @@ enum ab8500_chargalg_states {
>  	STATE_WD_EXPIRED,
>  };
> =20
> -static const char *states[] =3D {
> +static const char * const states[] =3D {
>  	"HANDHELD_INIT",
>  	"HANDHELD",
>  	"CHG_NOT_OK_INIT",
> @@ -274,8 +274,8 @@ static enum power_supply_property ab8500_chargalg_pro=
ps[] =3D {
> =20
>  struct ab8500_chargalg_sysfs_entry {
>  	struct attribute attr;
> -	ssize_t (*show)(struct ab8500_chargalg *, char *);
> -	ssize_t (*store)(struct ab8500_chargalg *, const char *, size_t);
> +	ssize_t (*show)(struct ab8500_chargalg *di, char *buf);
> +	ssize_t (*store)(struct ab8500_chargalg *di, const char *buf, size_t le=
ngth);
>  };
> =20
>  /**
> @@ -526,8 +526,7 @@ static int ab8500_chargalg_kick_watchdog(struct ab850=
0_chargalg *di)
>  			di->usb_chg->ops.kick_wd(di->usb_chg);
> =20
>  		return di->ac_chg->ops.kick_wd(di->ac_chg);
> -	}
> -	else if (di->usb_chg && di->usb_chg->ops.kick_wd &&
> +	} else if (di->usb_chg && di->usb_chg->ops.kick_wd &&
>  			di->chg_info.online_chg & USB_CHG)
>  		return di->usb_chg->ops.kick_wd(di->usb_chg);
> =20
> @@ -750,8 +749,8 @@ static void ab8500_chargalg_check_temp(struct ab8500_=
chargalg *di)
>  			di->t_hyst_norm =3D 0;
>  			di->t_hyst_lowhigh =3D di->bm->temp_hysteresis;
>  		} else {
> -		/* Within hysteresis */
> -		dev_dbg(di->dev, "Within hysteresis limit temp: %d "
> +			/* Within hysteresis */
> +			dev_dbg(di->dev, "Within hysteresis limit temp: %d "
>  				"hyst_lowhigh %d, hyst normal %d\n",
>  				di->batt_data.temp, di->t_hyst_lowhigh,
>  				di->t_hyst_norm);
> @@ -867,7 +866,7 @@ static enum maxim_ret ab8500_chargalg_chg_curr_maxim(=
struct ab8500_chargalg *di)
> =20
>  	di->ccm.wait_cnt =3D 0;
> =20
> -	if ((di->batt_data.inst_curr > di->ccm.original_iset)) {
> +	if (di->batt_data.inst_curr > di->ccm.original_iset) {
>  		dev_dbg(di->dev, " Maximization Ibat (%dmA) too high"
>  			" (limit %dmA) (current iset: %dmA)!\n",
>  			di->batt_data.inst_curr, di->ccm.original_iset,
> @@ -1545,8 +1544,7 @@ static void ab8500_chargalg_algorithm(struct ab8500=
_chargalg *di)
> =20
>  	case STATE_WAIT_FOR_RECHARGE:
>  		if (di->batt_data.percent <=3D
> -		    di->bm->bat_type[di->bm->batt_id].
> -		    recharge_cap)
> +		    di->bm->bat_type[di->bm->batt_id].recharge_cap)
>  			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
>  		break;
> =20
> @@ -1676,8 +1674,6 @@ static void ab8500_chargalg_wd_work(struct work_str=
uct *work)
>  	struct ab8500_chargalg *di =3D container_of(work,
>  		struct ab8500_chargalg, chargalg_wd_work.work);
> =20
> -	dev_dbg(di->dev, "ab8500_chargalg_wd_work\n");
> -
>  	ret =3D ab8500_chargalg_kick_watchdog(di);
>  	if (ret < 0)
>  		dev_err(di->dev, "failed to kick watchdog\n");
> @@ -1754,7 +1750,7 @@ static ssize_t ab8500_chargalg_curr_step_show(struc=
t ab8500_chargalg *di,
>  static ssize_t ab8500_chargalg_curr_step_store(struct ab8500_chargalg *d=
i,
>  					       const char *buf, size_t length)
>  {
> -	long int param;
> +	long param;
>  	int ret;
> =20
>  	ret =3D kstrtol(buf, 10, &param);
> @@ -1787,7 +1783,7 @@ static ssize_t ab8500_chargalg_en_show(struct ab850=
0_chargalg *di,
>  static ssize_t ab8500_chargalg_en_store(struct ab8500_chargalg *di,
>  	const char *buf, size_t length)
>  {
> -	long int param;
> +	long param;
>  	int ac_usb;
>  	int ret;
> =20
> --=20
> 2.31.1
>=20

--lewwtmsomymedhht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmEWlYgACgkQ2O7X88g7
+ppDoA/7B0JZuIjapZNNyPrc+2hDpJOBtiTyT/1zqaRTfREcBFd7ns700z8+attk
kSJmbfg13v4kKr/SfaJ3r6galSfdJTJJo9xH/qsdJy9towapyKubU78y3lMRzv1v
GqpXh3GGq/jJ3clokRI4AlT6ngKjrh7tx/1czHfl31PuOYp2WwUuMEDXX01NHVX5
BWL6YNX45EPuba+2CJNmaqOBU0PmToca44uf46XNnPAq6cuR2WhtGWYm/2zm40c1
5Sg6vr+YB5X2qX457LnHyC9Y+YSA2WQFGjEZ2lW2hmG1MyCSRYWz+XcKgDUQJxgX
6QQZRR+NQL7AhldrSxSBS/DH9VV79Zdgn/nrnSoFFvgbB/PwlhbRmWk5F0PfdXbO
bynoTeEXefLySFUzNDGPwIgUtJkXwbxx0RO0ViqNrpeGQEWBEG6yHrmthY8CbY3O
+r0JOhfhhB+YRzio4rQLEt7b9NkgH5VWlz7vzgmIrIFqxFG2vi3PyWp9lNHfD7fQ
N1mH6JUTLMS2jvtUSnJSkj5VpI16wFaFZms0JtRIO0MjMae9/ELI6uI6ewYNAtLp
nicG/lJg9kiz2XuyVHg19TVBOtUTOs9sot9iopZ1HXMgbVqD9+NlHuVID0yFtri8
IEmK9wA/ULZAltFumR57RbjWArqwgHUkjvXqXTDkpopZi7ihWz4=
=mZ7a
-----END PGP SIGNATURE-----

--lewwtmsomymedhht--
