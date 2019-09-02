Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2D1A5087
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 10:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbfIBIAG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 04:00:06 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45188 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729535AbfIBIAG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Sep 2019 04:00:06 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 3FF54283C69
Received: by earth.universe (Postfix, from userid 1000)
        id 0FA1A3C0B7F; Mon,  2 Sep 2019 10:00:01 +0200 (CEST)
Date:   Mon, 2 Sep 2019 10:00:01 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Denis Efremov <efremov@linux.com>
Cc:     linux-kernel@vger.kernel.org, joe@perches.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: N900: Remove isp1704_charger.h record
Message-ID: <20190902080001.66rj5spzaauarvqy@earth.universe>
References: <20190325212737.27322-1-joe@perches.com>
 <20190813061358.17223-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="krhurshqx4pzxoo3"
Content-Disposition: inline
In-Reply-To: <20190813061358.17223-1-efremov@linux.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--krhurshqx4pzxoo3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 13, 2019 at 09:13:58AM +0300, Denis Efremov wrote:
> Update MAINTAINERS to reflect that isp1704_charger.h file was removed.
>=20
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Pali Roh=E1r <pali.rohar@gmail.com>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Cc: linux-pm@vger.kernel.org
> Fixes: f5d782d46aa5 ("power: supply: isp1704: switch to gpiod API")
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---

Thanks, queued.

-- Sebastian

>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 29514fc19b01..2776e0797ae3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11400,7 +11400,6 @@ NOKIA N900 POWER SUPPLY DRIVERS
>  R:	Pali Roh=E1r <pali.rohar@gmail.com>
>  F:	include/linux/power/bq2415x_charger.h
>  F:	include/linux/power/bq27xxx_battery.h
> -F:	include/linux/power/isp1704_charger.h
>  F:	drivers/power/supply/bq2415x_charger.c
>  F:	drivers/power/supply/bq27xxx_battery.c
>  F:	drivers/power/supply/bq27xxx_battery_i2c.c
> --=20
> 2.21.0
>=20

--krhurshqx4pzxoo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl1szAAACgkQ2O7X88g7
+pod9A/+JUsyTh1EkTARCpyGyhu7UUwz6kyUB8RDrf8A7++VC3dElKc1lMqrpFw/
W7xUSMjB2KXwx+im1D5UYOwnBo1AKnV7mfjOwcw1SxJ8xc69nNoMT2SjNYayi3iH
VZDa9jOwU7k5+kSNOfacOLq45ZZKIkkA8uyV4qYL0sBzekItPaQ3Ag8QCTBbm+02
2IDIQp4ifKuQrNPcMp25XN8wT+qTFYITBTAsmNHuAv86NXpHYmYi0M7FK8uEP8Pp
8ch5v5MdXmRt91D5mwtqIEGBh2MX2nI8J9jUzBDZ49GgYK46BC5cVqs2OXLaXLzW
ySIUHbJqvJ7PlWlOfuDREwrrIFDbQ+ytT4FUdLx1P0kpjKaV/jFEBJ6vJrrt9Smx
1R1UCzeJiePXFa2DvqHLbux16KSB63FuGhoHbfiF17mAfYgYUlevSVzPTidED+My
Yfe9Xt86gW6g2mZXf33XCEHmBpdB7rKZ+NWEIEzrNSLmuoy+Pz9kn08c0iEgxHm9
9zGlSuLWJbL/QySZLSduO2ZR7DaqvlMmnX8WlViHanAxobnu3ZLxwQIaPPLIGeTu
mIdoOy4+sQyE6QdJs7AJFEhYXCw8eZ0CI5jvxdzGIgMjfOpnpqJVRbv8pExyyald
+IVdpxrU6LpFHawwe5PFETDG+PaQhzRdyTDDWUfraWpvtctvRPk=
=tdy4
-----END PGP SIGNATURE-----

--krhurshqx4pzxoo3--
