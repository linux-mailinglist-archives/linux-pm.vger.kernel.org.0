Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653722F3E88
	for <lists+linux-pm@lfdr.de>; Wed, 13 Jan 2021 01:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394277AbhALWJe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 17:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394259AbhALWJd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2021 17:09:33 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCB7C061575;
        Tue, 12 Jan 2021 14:08:53 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 091791F45545
Received: by earth.universe (Postfix, from userid 1000)
        id 98ECC3C0C94; Tue, 12 Jan 2021 23:08:49 +0100 (CET)
Date:   Tue, 12 Jan 2021 23:08:49 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     menglong8.dong@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <dong.menglong@zte.com.cn>
Subject: Re: [PATCH] power: supply: remove duplicated argument in
 power_supply_hwmon_info
Message-ID: <20210112220849.2mreatjj4jktcj5p@earth.universe>
References: <20210112014931.5429-1-dong.menglong@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rnsb4af75fmcuwxo"
Content-Disposition: inline
In-Reply-To: <20210112014931.5429-1-dong.menglong@zte.com.cn>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--rnsb4af75fmcuwxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 11, 2021 at 05:49:31PM -0800, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <dong.menglong@zte.com.cn>
>=20
> 'HWMON_T_INPUT' and 'HWMON_T_MIN_ALARM' in power_supply_hwmon_info are
> duplicated and can be removed.
>=20
> Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/power_supply_hwmon.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/su=
pply/power_supply_hwmon.c
> index 7fe4b6b6ddc8..bffe6d84c429 100644
> --- a/drivers/power/supply/power_supply_hwmon.c
> +++ b/drivers/power/supply/power_supply_hwmon.c
> @@ -299,13 +299,11 @@ static const struct hwmon_channel_info *power_suppl=
y_hwmon_info[] =3D {
>  			   HWMON_T_INPUT     |
>  			   HWMON_T_MAX       |
>  			   HWMON_T_MIN       |
> -			   HWMON_T_MIN_ALARM |
>  			   HWMON_T_MIN_ALARM,
> =20
>  			   HWMON_T_LABEL     |
>  			   HWMON_T_INPUT     |
>  			   HWMON_T_MIN_ALARM |
> -			   HWMON_T_LABEL     |
>  			   HWMON_T_MAX_ALARM),
> =20
>  	HWMON_CHANNEL_INFO(curr,
> --=20
> 2.17.1
>=20

--rnsb4af75fmcuwxo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl/+HfEACgkQ2O7X88g7
+pqkrA/9Ei83I4PLiQrDaVh/ZtpH+iIdSrQeF0yuu4VUsjkdUdKnjeFJ7bifjFCC
EL107smClkV7inBjA0T4L6WKXO8hz72ErIqPpUJuRniYgytT3kDqo7O6os74oVue
0ps5941ihSQxGKhj5eNwEC0tQHCP74czPl84ttv10HE7o+tJwjiu8kurzkIimw4k
g1Q3EVjhUSfEMNvEspuGHz91F0/m2R/McdS46VmVq5AYLLF+pTfLRsIB7nmWSrT7
YCKyP/BurpO1ovsB+MfGjDb63aC9otcs6XkTV8Emvm3nOPKmw7yu2k9xcDvV2tjc
1rwgcPVpJVrVUVZvF1PsS8eyFgWqG64EBE59JDsohYsy5r1r47aU/xWcRL+ToZYV
0R0CrklDWfgchTd8EXdtghsA2mTc0LeK+F8Jg+wlGir2pxRFlq7XNQeOSb/binW9
jLEcAGLE7JMnGKThl+tKZ2JMEBXIUcvv7nxNg89/pM3Q7xIfAAXEt+uWuFKDvSez
28Q/ZMJQLhwsVMr8iMdDXp1MhD3D5gZ/l3EeGdsPc3qF3lIzXoqzWsDSJHJuOwsL
WiDd3u0DdtYTfh8uF+oshhk28CRuKC8VW4SyDeI+VpdEiTLFH0nOdKfMWOfPdl9e
sOirZmHaY7+BBzFvKyr0Mnm0EH4LMOfGvBcMJBgWFDR1CzOJ0Kk=
=RvH+
-----END PGP SIGNATURE-----

--rnsb4af75fmcuwxo--
