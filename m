Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 237C81267AF
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 18:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfLSRHH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 12:07:07 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49494 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfLSRHH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 12:07:07 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 53F6726016E
Received: by earth.universe (Postfix, from userid 1000)
        id 27B883C0C7B; Thu, 19 Dec 2019 18:07:03 +0100 (CET)
Date:   Thu, 19 Dec 2019 18:07:03 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Ma Feng <mafeng.ma@huawei.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] power: supply: ab8500: Remove unneeded semicolon
Message-ID: <20191219170703.ek57v3o6z6ivsxaz@earth.universe>
References: <1576719991-109247-1-git-send-email-mafeng.ma@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="keot7hlxufh2vqqy"
Content-Disposition: inline
In-Reply-To: <1576719991-109247-1-git-send-email-mafeng.ma@huawei.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--keot7hlxufh2vqqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 19, 2019 at 09:46:29AM +0800, Ma Feng wrote:
> Fixes coccicheck warning:
>=20
> drivers/power/supply/ab8500_fg.c:2224:5-6: Unneeded semicolon
> drivers/power/supply/ab8500_fg.c:2227:4-5: Unneeded semicolon
> drivers/power/supply/ab8500_fg.c:2334:3-4: Unneeded semicolon
> drivers/power/supply/ab8500_fg.c:2342:3-4: Unneeded semicolon
> drivers/power/supply/ab8500_fg.c:2350:3-4: Unneeded semicolon
> drivers/power/supply/ab8500_fg.c:2358:3-4: Unneeded semicolon
> drivers/power/supply/ab8500_fg.c:2366:3-4: Unneeded semicolon
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Ma Feng <mafeng.ma@huawei.com>
> ---

Thanks, I queued all 3 patches to power-supply's for-next branch.

-- Sebastian

>  drivers/power/supply/ab8500_fg.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab85=
00_fg.c
> index c3912ee..b96f90a 100644
> --- a/drivers/power/supply/ab8500_fg.c
> +++ b/drivers/power/supply/ab8500_fg.c
> @@ -2221,10 +2221,10 @@ static int ab8500_fg_get_ext_psy_data(struct devi=
ce *dev, void *data)
>  						ab8500_fg_update_cap_scalers(di);
>  					queue_work(di->fg_wq, &di->fg_work);
>  					break;
> -				};
> +				}
>  			default:
>  				break;
> -			};
> +			}
>  			break;
>  		case POWER_SUPPLY_PROP_TECHNOLOGY:
>  			switch (ext->desc->type) {
> @@ -2331,7 +2331,7 @@ static int ab8500_fg_init_hw_registers(struct ab850=
0_fg *di)
>  		if (ret) {
>  			dev_err(di->dev, "%s write failed AB8505_RTC_PCUT_MAX_TIME_REG\n", __=
func__);
>  			goto out;
> -		};
> +		}
> =20
>  		ret =3D abx500_set_register_interruptible(di->dev, AB8500_RTC,
>  			AB8505_RTC_PCUT_FLAG_TIME_REG, di->bm->fg_params->pcut_flag_time);
> @@ -2339,7 +2339,7 @@ static int ab8500_fg_init_hw_registers(struct ab850=
0_fg *di)
>  		if (ret) {
>  			dev_err(di->dev, "%s write failed AB8505_RTC_PCUT_FLAG_TIME_REG\n", _=
_func__);
>  			goto out;
> -		};
> +		}
> =20
>  		ret =3D abx500_set_register_interruptible(di->dev, AB8500_RTC,
>  			AB8505_RTC_PCUT_RESTART_REG, di->bm->fg_params->pcut_max_restart);
> @@ -2347,7 +2347,7 @@ static int ab8500_fg_init_hw_registers(struct ab850=
0_fg *di)
>  		if (ret) {
>  			dev_err(di->dev, "%s write failed AB8505_RTC_PCUT_RESTART_REG\n", __f=
unc__);
>  			goto out;
> -		};
> +		}
> =20
>  		ret =3D abx500_set_register_interruptible(di->dev, AB8500_RTC,
>  			AB8505_RTC_PCUT_DEBOUNCE_REG, di->bm->fg_params->pcut_debounce_time);
> @@ -2355,7 +2355,7 @@ static int ab8500_fg_init_hw_registers(struct ab850=
0_fg *di)
>  		if (ret) {
>  			dev_err(di->dev, "%s write failed AB8505_RTC_PCUT_DEBOUNCE_REG\n", __=
func__);
>  			goto out;
> -		};
> +		}
> =20
>  		ret =3D abx500_set_register_interruptible(di->dev, AB8500_RTC,
>  			AB8505_RTC_PCUT_CTL_STATUS_REG, di->bm->fg_params->pcut_enable);
> @@ -2363,7 +2363,7 @@ static int ab8500_fg_init_hw_registers(struct ab850=
0_fg *di)
>  		if (ret) {
>  			dev_err(di->dev, "%s write failed AB8505_RTC_PCUT_CTL_STATUS_REG\n", =
__func__);
>  			goto out;
> -		};
> +		}
>  	}
>  out:
>  	return ret;
> --=20
> 2.6.2
>=20

--keot7hlxufh2vqqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl37rjYACgkQ2O7X88g7
+pon0Q/9GwN9ypvJIfPFYDZeydD3Hx4mkQ6j2A4tLvUNfcU5rduPBdoDZqeYJAif
DyzT4JPhPjlVuAHCDFf1V9Y+57C8OYdWTyaRKW6LPOCI5yB+zerpgp1NQNlIYmrS
9A4s2W6X5SIZA32d3AfmV9imKb9CDvNUQzlMgFPoKKGILnX52bULTk33IsY+Ojey
JjtIX7hNBwRS6w0IxnbHIKosDIr5L8GTUOZ3Ydnr6VuLrdbefiUqqQHu6UVYcDjA
KInMKkQDmgP10XiEmyilJNwGTQBN2lbt/COS3FMRU578XJjDTAxDWvm06/w340Fn
5JS2N67qBMlfyinPhl5aKEglLrFRPDvWBm3Nq70Bj/H8CXwI/5VXIU9D42Tm4cX8
WYWtXvqslZWAWVKIa/MLhm4pWIEEMA/pPiWUC1poKXjm5EKNl0kJCUg+G73bAQco
0+gXxg7fyKBdpHCvZMIOzx0DVkc72yfrGEh1EQts+fguJTuemhqx3SV2qgh+WRGp
EMTNcwDK3dFQqXlCoZJF3Pf1quUj+IGzjStqxuW556gA+2mte9TgSHHqblQV6372
o+AT5z/VDzRNFMXzLlzn/7pdzuiui2dlIwJxkMTOtr9aziHQpT/W+TZQ+hi6eews
C4rkgn9bbsCcg4GXn6jg2kfi0qvrN7xE0A31XDcJs+6RqDc3pXo=
=7CSx
-----END PGP SIGNATURE-----

--keot7hlxufh2vqqy--
