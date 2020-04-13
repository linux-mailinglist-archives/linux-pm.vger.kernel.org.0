Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3571A1A6DBD
	for <lists+linux-pm@lfdr.de>; Mon, 13 Apr 2020 23:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388724AbgDMVFR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Apr 2020 17:05:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34262 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388723AbgDMVFQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2020 17:05:16 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id D5CAB2A1205
Received: by earth.universe (Postfix, from userid 1000)
        id B9B673C08C7; Mon, 13 Apr 2020 23:05:12 +0200 (CEST)
Date:   Mon, 13 Apr 2020 23:05:12 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: max14656: remove set but not used 'ret'
Message-ID: <20200413210512.mljqzlgu46hzn3hu@earth.universe>
References: <20200409085401.47516-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ul3uf7dcirbx5qse"
Content-Disposition: inline
In-Reply-To: <20200409085401.47516-1-yanaijie@huawei.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ul3uf7dcirbx5qse
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 09, 2020 at 04:54:01PM +0800, Jason Yan wrote:
> Fix the following gcc warning:
>=20
> drivers/power/supply/max14656_charger_detector.c:142:6: warning:
> variable =E2=80=98ret=E2=80=99 set but not used [-Wunused-but-set-variabl=
e]
>   int ret =3D 0;
>       ^~~
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/max14656_charger_detector.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/max14656_charger_detector.c b/drivers/p=
ower/supply/max14656_charger_detector.c
> index 3bbb8b4c8ae7..137f9fafce8c 100644
> --- a/drivers/power/supply/max14656_charger_detector.c
> +++ b/drivers/power/supply/max14656_charger_detector.c
> @@ -139,10 +139,9 @@ static void max14656_irq_worker(struct work_struct *=
work)
> =20
>  	u8 buf[REG_TOTAL_NUM];
>  	u8 chg_type;
> -	int ret =3D 0;
> =20
> -	ret =3D max14656_read_block_reg(chip->client, MAX14656_DEVICE_ID,
> -				      REG_TOTAL_NUM, buf);
> +	max14656_read_block_reg(chip->client, MAX14656_DEVICE_ID,
> +				REG_TOTAL_NUM, buf);
> =20
>  	if ((buf[MAX14656_STATUS_1] & STATUS1_VB_VALID_MASK) &&
>  		(buf[MAX14656_STATUS_1] & STATUS1_CHG_TYPE_MASK)) {
> --=20
> 2.17.2
>=20

--ul3uf7dcirbx5qse
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6U1AIACgkQ2O7X88g7
+pqpgw//Y+UzgZPhDZpKZko7ATusRTbvh7P59AmNkfarrIHMYH2Ygi/txHlnkyN9
ChuByntYsQvL2D7PMAFCw7MZBcYz+nToUQcrWRqLUN0YMeZpfgWVQO/nkw7B3AU1
QN2QXxI9exfko7USJPv6lt24aFv0AeZaOR3XN47MvQP2EYcqmBYZSCa2Dcv3ntM8
XrCAfhmnOrC0cXzp2TEwQXN5Z5QMPgFr9mg4a7EQ9KFSynNArHck1lgtR73w6zRo
uyES0kB+eNlzu19xFocKv1LCILChIjIJ1Y/EA05ZaYiSimkTO2ZKRrKJFDswqgDR
NEHW80ZooM08Hjm+vr9dFI9qF0p7D2OVghP2iQcsg0dQ//kFrOFSgjPfYBphWqcn
tSE/5tqXpo+4FgwcqWSW21pdWBm4JwhXL3emOldLJy7tLcGdyStQKW2B45yVcVJh
t5PEeAW9ngxyjsvpe2rgVDyTNesgSSGDpkVC06VMg40ndi0WA0BPZb+WfbwtNU28
Yod1Sa7Wuay6Aa7iUGcpTQGnv+f20zIsw/y0tM8Edjqm6S30LDfvkiGK7opCMRZR
sUuYY6AmgIphpbSfCyKPMAPKKoAxgUoxoCNzv22JadzGpVQEB4kyvR+Nde1EY6kI
mL4hUIPIGMzkNmToY2yjOJlI+Z6UmNXjR9rY14Egu4XjiUg/yjg=
=AFfq
-----END PGP SIGNATURE-----

--ul3uf7dcirbx5qse--
