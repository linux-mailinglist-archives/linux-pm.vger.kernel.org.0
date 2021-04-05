Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6316F35411F
	for <lists+linux-pm@lfdr.de>; Mon,  5 Apr 2021 12:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241685AbhDEKPO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Apr 2021 06:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241681AbhDEKPO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Apr 2021 06:15:14 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA58C061756;
        Mon,  5 Apr 2021 03:15:08 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 262EF1F44D7D
Received: by earth.universe (Postfix, from userid 1000)
        id C6AD83C0C96; Mon,  5 Apr 2021 12:15:04 +0200 (CEST)
Date:   Mon, 5 Apr 2021 12:15:04 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: Use true and false for bool variable
Message-ID: <20210405101504.67fowho7fhfojcxp@earth.universe>
References: <1612864723-57143-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="itravfoy4wvih4x2"
Content-Disposition: inline
In-Reply-To: <1612864723-57143-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--itravfoy4wvih4x2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 09, 2021 at 05:58:43PM +0800, Jiapeng Chong wrote:
> Fix the following coccicheck warning:
>=20
> ./include/linux/power_supply.h:507:9-10: WARNING: return of 0/1 in
> function 'power_supply_is_watt_property' with return type bool.
>=20
> ./include/linux/power_supply.h:479:9-10: WARNING: return of 0/1 in
> function 'power_supply_is_amp_property' with return type bool.
>=20
> Reported-by: Abaci Robot<abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---

Thanks, queued.

-- Sebastian

>  include/linux/power_supply.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 81a55e9..029e6e9 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -476,12 +476,12 @@ static inline bool power_supply_is_amp_property(enu=
m power_supply_property psp)
>  	case POWER_SUPPLY_PROP_CURRENT_NOW:
>  	case POWER_SUPPLY_PROP_CURRENT_AVG:
>  	case POWER_SUPPLY_PROP_CURRENT_BOOT:
> -		return 1;
> +		return true;
>  	default:
>  		break;
>  	}
> =20
> -	return 0;
> +	return false;
>  }
> =20
>  static inline bool power_supply_is_watt_property(enum power_supply_prope=
rty psp)
> @@ -504,12 +504,12 @@ static inline bool power_supply_is_watt_property(en=
um power_supply_property psp)
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
>  	case POWER_SUPPLY_PROP_POWER_NOW:
> -		return 1;
> +		return true;
>  	default:
>  		break;
>  	}
> =20
> -	return 0;
> +	return false;
>  }
> =20
>  #ifdef CONFIG_POWER_SUPPLY_HWMON
> --=20
> 1.8.3.1
>=20

--itravfoy4wvih4x2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBq4ygACgkQ2O7X88g7
+po/wg//bH7c/cyVKOnSjDYR5ldUnEWi6WDYyNq8M1ygK864h57r++X0l4lI+8eC
g2lqAVD3Wx5WrUNMEuIbR+zw5e8NNJCye3gUvcoTZBHfstt+PJgum+1EBBMy2Uco
uqnaLQLLI/UT3QaIsOXC/4Gf/j4gi6zR7dyTylExtGSqm7oYVzwAK82N816td7+c
qYKCEoDsL7kMn/X2THEgN9uW7A3B4ekjepXkhg6x/3FgrLyz8XmZuRfMfxJGnCp0
fS25UKwnEGWwzDXF1L9aNJ0aXWd7trPeDfladk/qJM+R4Tz0+rePWB2ETPfWOVpe
iy01QPzXLNQubGhEbLEBDGdvthQ5q8tiTXlIwSi18JLcv/oK0vAMYvfljC9pUA3R
QZjWGdCWv9Wd9wSfX3mg4gpW/KWqm5pavEMxuZW8ifQFkvv0fdZ2QSDvl132p6+S
k79hxyFal2XMkorY+tB12SCJttmeqFRrxTVfVqaawl3+lDWcwdB66QvpiniGXqGO
mXpaFLPX3X4A6rmqU6tVbbXkunSYU0Cx6rh/bXneZiTUFiOZj34wAcwU9hznHNMs
RhGH1JA0yOckFkni2lXX/9dTO/ta2ygjDI/NcAHWd+fTsdExsIV9QXqhJfRzglmR
x9zN7OHZjuv93I49QBmmZ9mXycMNvYlFfKr/P/nCOXOUOU2/U0A=
=Uj5I
-----END PGP SIGNATURE-----

--itravfoy4wvih4x2--
