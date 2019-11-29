Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8819F10DA04
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2019 20:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfK2TKw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Nov 2019 14:10:52 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40726 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbfK2TKw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Nov 2019 14:10:52 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id B1BE6292BA4
Received: by earth.universe (Postfix, from userid 1000)
        id 990293C0C77; Fri, 29 Nov 2019 15:06:01 +0100 (CET)
Date:   Fri, 29 Nov 2019 15:06:01 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux@armlinux.org.uk, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 04/17] power: reset: Kconfig: select
 POWER_RESET_AT91_RESET for sam9x60
Message-ID: <20191129140601.fgbxwhk2c7rlvvyz@earth.universe>
References: <1574773941-20649-1-git-send-email-claudiu.beznea@microchip.com>
 <1574773941-20649-5-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qqra4xv2pgsrtjif"
Content-Disposition: inline
In-Reply-To: <1574773941-20649-5-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--qqra4xv2pgsrtjif
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 26, 2019 at 03:12:08PM +0200, Claudiu Beznea wrote:
> Select POWER_RESET_AT91_RESET for SAM9X60 SoC.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/power/reset/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index c721939767eb..886e60017f4d 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -26,7 +26,7 @@ config POWER_RESET_AT91_POWEROFF
>  config POWER_RESET_AT91_RESET
>  	tristate "Atmel AT91 reset driver"
>  	depends on ARCH_AT91
> -	default SOC_AT91SAM9 || SOC_SAMA5
> +	default SOC_AT91SAM9 || SOC_SAM9X60 || SOC_SAMA5
>  	help
>  	  This driver supports restart for Atmel AT91SAM9 and SAMA5
>  	  SoCs

I suppose this will go through ARM:

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

--qqra4xv2pgsrtjif
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl3hJckACgkQ2O7X88g7
+pqhDQ//WNmLXqjre475NYvywJrUR10v2JH2NyVYPBlYw5NtMdaj/2qgjlOOA5by
KaHTlh1gsCthLa5RF+xVpKc9QnKEPnt3ZIHys+QO1vBl50CA4uSdP7SJ0X8pqhSm
s/KfSa5dlkGF0z3cu6XXJg4c/oG4HSsCGPnGrbwVIaCN1kQBA8ESEBhwyggIu59J
DjBw092F4Wp+o+McqZW+xR/ILbNhqkqzz5OkJdg5r3XcWr+K3ubNUrfEIKn60+C6
49PI6hvkvbZHtHRtJgkcxW7TX/IsmFNWGWO0VSPLh7sa5DiD9Pf4Mux3mHAU6uk6
QaFfWZahcRqNvpwxcqJUqntwawnpIzYmoJfzDoqScHEfU1kZ+p3U/RenNfHBHioQ
SPO/15E2hC5Anb7JNYbxS4JccBF+0xRmpVIGRqmNJFFRaVvEhRgYuH/LWZqdgQEn
K/ZPHCXsYS/5cTMNOJ/Ma1FfgVaEbeCXv5r89ExS2/JuHtDXCD3KdC7eIYnwEvJn
9nYnHxRdBJRH92QpooEUOJI0fXKgBsGBn2lcAwqlt7ctfVNG3fL/aK8E7SuXNomw
LQyahophFRjRjCKT8ZscFperzBF70gMVXws0eiV2u55ZHVtvXBIEF7BapxxjgI6a
dg22CtqsGb4xQGY2srR7qjL4rJd9JJuQrQcuRYBwxsRnDG80Wto=
=HxsT
-----END PGP SIGNATURE-----

--qqra4xv2pgsrtjif--
