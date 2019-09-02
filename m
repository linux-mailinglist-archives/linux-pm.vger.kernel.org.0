Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 758BBA5C81
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 21:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfIBTFk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 15:05:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbfIBTFk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Sep 2019 15:05:40 -0400
Received: from earth.universe (unknown [185.62.205.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00CFF21883;
        Mon,  2 Sep 2019 19:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567451139;
        bh=Vr1yZlWF+4twzy+7EuAxHux0Cmmf1eUWlecK7qoeyTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=feOUBzM/luMfregDyDUCAJn1qOw3odq3f2Zd4yVWpEBJPJsDHpEpTkZv5BrCa9NcA
         9T/vJffTVs9d8eHEqLMhQoBs2dZAyco8D1HAm2jNfJXd01EvBLePaDqc5ZcSdaP7yU
         7XCJzBM+2ZKEnb7aboPgw64ZvKNaLqi8xm/H2BBE=
Received: by earth.universe (Postfix, from userid 1000)
        id BF4FE3C0B7F; Mon,  2 Sep 2019 21:05:36 +0200 (CEST)
Date:   Mon, 2 Sep 2019 21:05:36 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     linus.walleij@linaro.org, lee.jones@linaro.org,
        loic.pallardy@st.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] power: supply: ab8500: remove set but not used
 variables 'vbup33_vrtcn' and 'bup_vch_range'
Message-ID: <20190902190536.irlrzzvjvduvl2qd@earth.universe>
References: <20190717141848.31116-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wirrsdh333qp3ti7"
Content-Disposition: inline
In-Reply-To: <20190717141848.31116-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--wirrsdh333qp3ti7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 17, 2019 at 10:18:48PM +0800, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warnings:
>=20
> drivers/power/supply/ab8500_charger.c:
>  In function ab8500_charger_init_hw_registers:
> drivers/power/supply/ab8500_charger.c:3013:24: warning:
>  variable vbup33_vrtcn set but not used [-Wunused-but-set-variable]
> drivers/power/supply/ab8500_charger.c:3013:5: warning:
>  variable bup_vch_range set but not used [-Wunused-but-set-variable]
>=20
> They are not used since commit 4c4268dc97c4 ("power:
> supply: ab8500: Drop AB8540/9540 support")
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: Fix patch title
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/ab8500_charger.c | 7 -------
>  1 file changed, 7 deletions(-)
>=20
> diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply=
/ab8500_charger.c
> index 30de448..270a48a 100644
> --- a/drivers/power/supply/ab8500_charger.c
> +++ b/drivers/power/supply/ab8500_charger.c
> @@ -3010,7 +3010,6 @@ static int ab8500_charger_usb_get_property(struct p=
ower_supply *psy,
>  static int ab8500_charger_init_hw_registers(struct ab8500_charger *di)
>  {
>  	int ret =3D 0;
> -	u8 bup_vch_range =3D 0, vbup33_vrtcn =3D 0;
> =20
>  	/* Setup maximum charger current and voltage for ABB cut2.0 */
>  	if (!is_ab8500_1p1_or_earlier(di->parent)) {
> @@ -3111,12 +3110,6 @@ static int ab8500_charger_init_hw_registers(struct=
 ab8500_charger *di)
>  		goto out;
>  	}
> =20
> -	/* Backup battery voltage and current */
> -	if (di->bm->bkup_bat_v > BUP_VCH_SEL_3P1V)
> -		bup_vch_range =3D BUP_VCH_RANGE;
> -	if (di->bm->bkup_bat_v =3D=3D BUP_VCH_SEL_3P3V)
> -		vbup33_vrtcn =3D VBUP33_VRTCN;
> -
>  	ret =3D abx500_set_register_interruptible(di->dev,
>  		AB8500_RTC,
>  		AB8500_RTC_BACKUP_CHG_REG,
> --=20
> 2.7.4
>=20
>=20

--wirrsdh333qp3ti7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl1taAAACgkQ2O7X88g7
+ppj/A/+MLmamV+oTuwzUSJCtBMLysTquQxub5rugYTV12fDwR0n9Z6izM1IRHZf
fEfQbDJq4CWb32BZjpA/TtfaM+/WRBFptxrpmdXEdvj5XZ7ym3CdzuZjqT2RtIdL
9BFYXmweR0vXfkKBncs2AmZWyx9iS1hTpPhseBkgu+1QSBLeUHyGgNBxjFtpjXvB
NYtIC9LDYSoN4kQPdKtpMnNojFCTLNEyplc9U3zHm27uGX1TYZNPryZ7l1wwUkOv
ctzE5Ju/4BsIMLzVmJK56Q1xJj7tnVSXtaMRfnhPCsX2UXClDG8Eb++5HIm9TqYt
+lQCgSTPyGDet1hRWwVMrTMC5R8ftGCL2xAwEDcs467Xy1Nm9gVpjyPqEvlXKmmM
pBN0uwG7eckdAiy+GZ5mKaY6Eq99JlF0EfU5P5sXLwe04IWn2usIk7JMxOmReuv0
8T8w64kLY9Xrr1sPM7rfaWSjw8OWTf7KVsm+HiWcIPQMJW4/lFjmk0rScK/G6fe/
U6e2vx95VC6RDqu8vYLn+SgVvrSB1HIZmCaJREYfsgbHeTAIywchadFWH9TpQ4gv
3cSuIXx45rgPaMRfkdYTjTlcTA860Y0CHFCLjgHsio5KuuziRJJNP6HGOMfogXdM
FhDPCFCiCRPLgItV3dyzGZosBQmegH90TAJjA4s51JFuO58VlEc=
=JYRW
-----END PGP SIGNATURE-----

--wirrsdh333qp3ti7--
