Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E841B37FB6D
	for <lists+linux-pm@lfdr.de>; Thu, 13 May 2021 18:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbhEMQZr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 May 2021 12:25:47 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42126 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbhEMQZr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 May 2021 12:25:47 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id B0DF51F42DEC
Received: by earth.universe (Postfix, from userid 1000)
        id C8CA43C0C95; Thu, 13 May 2021 18:24:33 +0200 (CEST)
Date:   Thu, 13 May 2021 18:24:33 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: power: supply: use Krzysztof Kozlowski's
 Canonical address
Message-ID: <20210513162433.7dnf5mesqgetp6lp@earth.universe>
References: <20210504121437.13424-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y5uu6cbm5tlibfv6"
Content-Disposition: inline
In-Reply-To: <20210504121437.13424-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--y5uu6cbm5tlibfv6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 04, 2021 at 08:14:37AM -0400, Krzysztof Kozlowski wrote:
> Switch to Canonical address in S3C power supply driver, just like in
> other entries.
>=20
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---

Thanks, queued.

-- Sebastian

>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1783372a608a..ccb9823fb77f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16021,7 +16021,7 @@ W:	http://www.ibm.com/developerworks/linux/linux3=
90/
>  F:	drivers/s390/scsi/zfcp_*
> =20
>  S3C ADC BATTERY DRIVER
> -M:	Krzysztof Kozlowski <krzk@kernel.org>
> +M:	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>  L:	linux-samsung-soc@vger.kernel.org
>  S:	Odd Fixes
>  F:	drivers/power/supply/s3c_adc_battery.c
> --=20
> 2.25.1
>=20

--y5uu6cbm5tlibfv6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmCdUsEACgkQ2O7X88g7
+pqrmBAAmxItoc7gAdBW1fS5FmGhlJiJmNtKSRZSnHQt25JcBoh9n83j87IvAHb4
4dwiv16ayl8VkK/WPv7aaH8VSF9W9MtpluKwm12cispyrEXtcAwsq/idpDsuVt/I
DR3ituJuufnvyyF88euFTL96bl1iGUdjDpl4NCyzV15XuZXC281mr9ET3H7FvPO1
1ViZJX8EKaawXJnNiHGGTrbP76wNbUOK2Oi/7Ed/LOiocjGmlalolwFEAkUAMR+R
sw3IxZm9RSuNW/kj9fYxS7AzX/YGpSdpwk1xGmZPOax0Ip46E3HRnB/AlE2oeRkq
jK5Mnw3XVX9NjN0RkyaUrKpwPaGGhHYG3N5siz3jIKyn/W1dlK9YAnG7Wv1T2sQK
P1aq59kGjRFRQ09OpGISVC/a0WYi2LmCYnNAv4MmOc27KQGSFpQ49GrCcCZT3MU5
AjEsQh9ntEadijvoIY2oaa1npx+Eh9ToWZXKwsw+R23iUU2p7EIi1kuF0Unq8Zfm
6gAtXU4yI74j9vhO36CIe/JHisUmKWZH6P3vUKxI2mys0tz6EoSNgsOiQLS66VQv
BnQZ2F03erC9hC+5FS9s9G3mrY3vIUAWDWxv6pFds4DnWkBVJMZhP71QrbZhCxcU
L7AxugZ7hjlSK6agDcJtoy/xSNemAAG9rI6bnltP8PuYCsSbg0E=
=rLNg
-----END PGP SIGNATURE-----

--y5uu6cbm5tlibfv6--
