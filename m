Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1B817C742
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 21:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgCFUrj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 15:47:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:39618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgCFUrj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Mar 2020 15:47:39 -0500
Received: from earth.universe (unknown [185.62.205.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 603DC206CC;
        Fri,  6 Mar 2020 20:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583527657;
        bh=kQ/wG8H7x2ozJKKaOTCFl5qnbIv2rWONENO5bLZeRNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CMkTzCC/gcWV0aUjLc4StqNtfaoOPKnKCTV8pZA7vQiCBws2F43DuvvOSx/yiI2cY
         1Z+OWo/5VP4sYNmN5EJEBL4Dh92VvSTAzHp93i5i2NqBV7cZoe4CSlMRK/07t3lB1u
         U4zPI7x+0x4y562eQq/bDwRjeUyUkRpaW2rkAaLo=
Received: by earth.universe (Postfix, from userid 1000)
        id 041663C0C83; Fri,  6 Mar 2020 21:47:34 +0100 (CET)
Date:   Fri, 6 Mar 2020 21:47:34 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Ashish Chavan <ashish.gschavan@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: ab8500_charger: Fix typos in commit
 messages
Message-ID: <20200306204734.c3na6twovxzh7a3q@earth.universe>
References: <20200226175223.6371-1-ashish.gschavan@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xigrgwmdg4nmm3t5"
Content-Disposition: inline
In-Reply-To: <20200226175223.6371-1-ashish.gschavan@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--xigrgwmdg4nmm3t5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 26, 2020 at 11:22:23PM +0530, Ashish Chavan wrote:
> Trivial fix to spelling mistake in commit messages.
>=20
> Signed-off-by: Ashish Chavan <ashish.gschavan@gmail.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/ab8500_charger.c | 35 +++++++++++++++------------
>  1 file changed, 19 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply=
/ab8500_charger.c
> index 98b335042ba6..65741bab8552 100644
> --- a/drivers/power/supply/ab8500_charger.c
> +++ b/drivers/power/supply/ab8500_charger.c
> @@ -398,7 +398,7 @@ static void ab8500_enable_disable_sw_fallback(struct =
ab8500_charger *di,
>  }
> =20
>  /**
> - * ab8500_power_supply_changed - a wrapper with local extentions for
> + * ab8500_power_supply_changed - a wrapper with local extensions for
>   * power_supply_changed
>   * @di:	  pointer to the ab8500_charger structure
>   * @psy:  pointer to power_supply_that have changed.
> @@ -677,7 +677,7 @@ static int ab8500_charger_max_usb_curr(struct ab8500_=
charger *di,
>  	/*
>  	 * Platform only supports USB 2.0.
>  	 * This means that charging current from USB source
> -	 * is maximum 500 mA. Every occurence of USB_STAT_*_HOST_*
> +	 * is maximum 500 mA. Every occurrence of USB_STAT_*_HOST_*
>  	 * should set USB_CH_IP_CUR_LVL_0P5.
>  	 */
> =20
> @@ -1372,13 +1372,13 @@ static int ab8500_charger_ac_en(struct ux500_char=
ger *charger,
> =20
>  		/*
>  		 * Due to a bug in AB8500, BTEMP_HIGH/LOW interrupts
> -		 * will be triggered everytime we enable the VDD ADC supply.
> +		 * will be triggered every time we enable the VDD ADC supply.
>  		 * This will turn off charging for a short while.
>  		 * It can be avoided by having the supply on when
>  		 * there is a charger enabled. Normally the VDD ADC supply
> -		 * is enabled everytime a GPADC conversion is triggered. We will
> -		 * force it to be enabled from this driver to have
> -		 * the GPADC module independant of the AB8500 chargers
> +		 * is enabled every time a GPADC conversion is triggered.
> +		 * We will force it to be enabled from this driver to have
> +		 * the GPADC module independent of the AB8500 chargers
>  		 */
>  		if (!di->vddadc_en_ac) {
>  			ret =3D regulator_enable(di->regu);
> @@ -1448,7 +1448,7 @@ static int ab8500_charger_ac_en(struct ux500_charge=
r *charger,
>  		if (is_ab8500_1p1_or_earlier(di->parent)) {
>  			/*
>  			 * For ABB revision 1.0 and 1.1 there is a bug in the
> -			 * watchdog logic. That means we have to continously
> +			 * watchdog logic. That means we have to continuously
>  			 * kick the charger watchdog even when no charger is
>  			 * connected. This is only valid once the AC charger
>  			 * has been enabled. This is a bug that is not handled
> @@ -1545,13 +1545,13 @@ static int ab8500_charger_usb_en(struct ux500_cha=
rger *charger,
> =20
>  		/*
>  		 * Due to a bug in AB8500, BTEMP_HIGH/LOW interrupts
> -		 * will be triggered everytime we enable the VDD ADC supply.
> +		 * will be triggered every time we enable the VDD ADC supply.
>  		 * This will turn off charging for a short while.
>  		 * It can be avoided by having the supply on when
>  		 * there is a charger enabled. Normally the VDD ADC supply
> -		 * is enabled everytime a GPADC conversion is triggered. We will
> -		 * force it to be enabled from this driver to have
> -		 * the GPADC module independant of the AB8500 chargers
> +		 * is enabled every time a GPADC conversion is triggered.
> +		 * We will force it to be enabled from this driver to have
> +		 * the GPADC module independent of the AB8500 chargers
>  		 */
>  		if (!di->vddadc_en_usb) {
>  			ret =3D regulator_enable(di->regu);
> @@ -1575,7 +1575,10 @@ static int ab8500_charger_usb_en(struct ux500_char=
ger *charger,
>  			return -ENXIO;
>  		}
> =20
> -		/* ChVoltLevel: max voltage upto which battery can be charged */
> +		/*
> +		 * ChVoltLevel: max voltage up to which battery can be
> +		 * charged
> +		 */
>  		ret =3D abx500_set_register_interruptible(di->dev, AB8500_CHARGER,
>  			AB8500_CH_VOLT_LVL_REG, (u8) volt_index);
>  		if (ret) {
> @@ -2007,7 +2010,7 @@ static void ab8500_charger_check_hw_failure_work(st=
ruct work_struct *work)
>   * Work queue function for kicking the charger watchdog.
>   *
>   * For ABB revision 1.0 and 1.1 there is a bug in the watchdog
> - * logic. That means we have to continously kick the charger
> + * logic. That means we have to continuously kick the charger
>   * watchdog even when no charger is connected. This is only
>   * valid once the AC charger has been enabled. This is
>   * a bug that is not handled by the algorithm and the
> @@ -2255,7 +2258,7 @@ static void ab8500_charger_usb_link_status_work(str=
uct work_struct *work)
>  	 * Some chargers that breaks the USB spec is
>  	 * identified as invalid by AB8500 and it refuse
>  	 * to start the charging process. but by jumping
> -	 * thru a few hoops it can be forced to start.
> +	 * through a few hoops it can be forced to start.
>  	 */
>  	if (is_ab8500(di->parent))
>  		ret =3D abx500_get_register_interruptible(di->dev, AB8500_USB,
> @@ -3214,7 +3217,7 @@ static int ab8500_charger_resume(struct platform_de=
vice *pdev)
> =20
>  	/*
>  	 * For ABB revision 1.0 and 1.1 there is a bug in the watchdog
> -	 * logic. That means we have to continously kick the charger
> +	 * logic. That means we have to continuously kick the charger
>  	 * watchdog even when no charger is connected. This is only
>  	 * valid once the AC charger has been enabled. This is
>  	 * a bug that is not handled by the algorithm and the
> @@ -3451,7 +3454,7 @@ static int ab8500_charger_probe(struct platform_dev=
ice *pdev)
> =20
>  	/*
>  	 * For ABB revision 1.0 and 1.1 there is a bug in the watchdog
> -	 * logic. That means we have to continously kick the charger
> +	 * logic. That means we have to continuously kick the charger
>  	 * watchdog even when no charger is connected. This is only
>  	 * valid once the AC charger has been enabled. This is
>  	 * a bug that is not handled by the algorithm and the
> --=20
> 2.17.1
>=20

--xigrgwmdg4nmm3t5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl5ituUACgkQ2O7X88g7
+po2Ug/9HYyGjT9+/aCLwtvY9axS4DKbH14NDBJzv79pLPaRPWy9vWuEi1oYXd0G
gLCYHuynsOLuNkseX4ENKJNc3xRrP/teG7Si34eAAtstn8j+AicTTDkwiMAE1o3O
XhTGMzCvWdNBxpI5wZSFM3nqE5/GI/veOSv88qW37dYuNg9FoVf0JinMYB920GnI
xlDwiRNVgQcqWykvDMvi80yMOpc4n23Lr07e+nv0x5BiMBXkMEm2BIDNe/K8ZMoI
qE6xYpFKsvfYxdAPsaStlbf+OJWKq/BX7KHlC1TBe4QpzIYoVCcYcuKOXTQcRsEv
XYMB6AvrjOjar83IKspuF5oU2BMMYto74Mmz9OndB8LjDsEaWFE4EynqYloebfF7
RY7UXlntJzce1jUo9b5IbLYZagi734FfjckkWWRsj9iVqZHisPIGrBRIVtEyawOP
c+/13nwtluYbqtPO2exuDGfRQizd2do2SCeLwzbpDa0iFXI9L4OJkpPT9lRSPgMu
injCDGy2DdkV31SZSUeiujAPV6WdP8zJkHHoNL8AyO7WaqExZGZBl0S4tyAvfspW
gu19+0hYQgQ1x8Y4/2y5fa4qBgrxxyOEFEw4rPLRfd3uMAY44d3VCNRloxE+vTpH
A1bLiXoXY6NQAUs43th8K2oyxlsUXKo26iUiWDAH6SjEaXOAvkc=
=hVDy
-----END PGP SIGNATURE-----

--xigrgwmdg4nmm3t5--
