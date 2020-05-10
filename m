Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128BA1CCC38
	for <lists+linux-pm@lfdr.de>; Sun, 10 May 2020 18:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgEJQ2M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 May 2020 12:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728381AbgEJQ2M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 May 2020 12:28:12 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC64C061A0C;
        Sun, 10 May 2020 09:28:12 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 069CE260136
Received: by earth.universe (Postfix, from userid 1000)
        id 23E433C08C7; Sun, 10 May 2020 18:28:09 +0200 (CEST)
Date:   Sun, 10 May 2020 18:28:09 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     David Heidelberg <david@ixit.cz>
Cc:     Jonghwa Lee <jonghwa3.lee@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Myungjoo Ham <myungjoo.ham@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>,
        mika.westerberg@linux.intel.com, ramakrishna.pallala@intel.com,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] power: supply: smb347-charger: IRQSTAT_D is volatile
Message-ID: <20200510162809.m7ucijygbb5wq3ww@earth.universe>
References: <20200329161552.215075-1-david@ixit.cz>
 <20200329161552.215075-2-david@ixit.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l7dyf4tjcoatcnna"
Content-Disposition: inline
In-Reply-To: <20200329161552.215075-2-david@ixit.cz>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--l7dyf4tjcoatcnna
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Mar 29, 2020 at 06:15:44PM +0200, David Heidelberg wrote:
> From: Dmitry Osipenko <digetx@gmail.com>
>=20
> Fix failure when USB cable is connected:
> smb347 2-006a: reading IRQSTAT_D failed
>=20
> Fixes: 1502cfe19bac ("smb347-charger: Fix battery status reporting logic =
for charger faults")
>=20
> Tested-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---

Thanks, queued to power-supply's for-next branch.

-- Sebastian

>  drivers/power/supply/smb347-charger.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply=
/smb347-charger.c
> index c1d124b8be0c..d102921b3ab2 100644
> --- a/drivers/power/supply/smb347-charger.c
> +++ b/drivers/power/supply/smb347-charger.c
> @@ -1138,6 +1138,7 @@ static bool smb347_volatile_reg(struct device *dev,=
 unsigned int reg)
>  	switch (reg) {
>  	case IRQSTAT_A:
>  	case IRQSTAT_C:
> +	case IRQSTAT_D:
>  	case IRQSTAT_E:
>  	case IRQSTAT_F:
>  	case STAT_A:
> --=20
> 2.25.0
>=20

--l7dyf4tjcoatcnna
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl64K5EACgkQ2O7X88g7
+poDxBAAju60k1uqjPUMzvMSKsrgLeZjZEJk7+Mo5ciFqRs4WrtyORtc0WVo48I8
/Ms9Xh63nX6Buf2RSgeM/HVwKVo8r5USwHQspW24XwLEwQb2ZIlBac7NFGPucrLv
yIEbUBFwSKeouFfgyWyNG7vjlsmpqIl96pPX94EtKzCdoA6LyjkY4iEdKXmyUgBI
L1pp+1J3k8rYvEoCRZN52qjy+/HOuAxUqttpIlnftB4Eplvzs7IIl8xJEflDeXEW
ylTVO8KC6TsGU80yDQ2Umyvx+JH0WNaFNISmAG9FkeUPjTFcI8It5FS754Ph4tQH
Jvt9pNYu343b4vqrI0bvh9H71nWEd5AFmPVe3AbJSqfgAsug6YkWKAXL7oKlALQA
im5Q0Yk9kbiIKKzO0kecldZ4R8ou8AcwJsBwgUPe19pwQFqbZ1DjSFhYV7mD38WR
5n7TIdjRKiRCustbs+NWvbmmZI9UWjVfedh0QVWoolIElOXDPd/07aE4to7HUpst
Mud5RJROz/+P0AXHKDXavCROmjTH4uc91dSkBQo9sQoE+3hzyGffAb5Rk6vNWZAJ
bOA8lIklqq/hWN614ZuxWwNT0TIYmjEOER/eSxVtxJxgExhXNp2lHV12nBrytG30
3XSjX6R2SeURnV8EPJ2hGLJ/OYBJjJsebfACKBOvp9eGwwTRFzc=
=XnbJ
-----END PGP SIGNATURE-----

--l7dyf4tjcoatcnna--
