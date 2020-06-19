Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C3C200DB8
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jun 2020 17:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390642AbgFSPAb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jun 2020 11:00:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390636AbgFSPA3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Jun 2020 11:00:29 -0400
Received: from earth.universe (dyndsl-037-138-190-043.ewe-ip-backbone.de [37.138.190.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D3F620776;
        Fri, 19 Jun 2020 15:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578828;
        bh=eh8/68kbF3bfkG8umypTlt9ETupXMn/3RL63q3FNss8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dRXJi17MqGUpyw2FwC0Ahwetkem/jHgi1LXdzhy2rnwFplN9inUbBfgRhar8+/v0m
         zKDbAHU7QrKjEei5ZqgRNultCzOgxgUAoSZAMWKtivDL+3bm5TrOJVqcXtLlg75/gi
         KFfRjwp4AhaykGagt7mqzL6VcKAmrprGWZUTn4RI=
Received: by earth.universe (Postfix, from userid 1000)
        id F1B623C08CD; Fri, 19 Jun 2020 17:00:26 +0200 (CEST)
Date:   Fri, 19 Jun 2020 17:00:26 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Keyur Patel <iamkeyur96@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] power: supply: axp20x_usb_power: fix spelling mistake
Message-ID: <20200619150026.gam2z5tslubk2xp7@earth.universe>
References: <20200609224524.108092-1-iamkeyur96@gmail.com>
 <20200609225035.108435-1-iamkeyur96@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sskekeyxm6zhep2a"
Content-Disposition: inline
In-Reply-To: <20200609225035.108435-1-iamkeyur96@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--sskekeyxm6zhep2a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 09, 2020 at 06:50:35PM -0400, Keyur Patel wrote:
> Fix typo: "triger" --> "trigger"
>=20
> Signed-off-by: Keyur Patel <iamkeyur96@gmail.com>
> ---

Thanks, queued.

-- Sebastian Reichel

>  drivers/power/supply/axp20x_usb_power.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supp=
ly/axp20x_usb_power.c
> index 4fde24b5f35a..d01dc0332edc 100644
> --- a/drivers/power/supply/axp20x_usb_power.c
> +++ b/drivers/power/supply/axp20x_usb_power.c
> @@ -78,7 +78,7 @@ static bool axp20x_usb_vbus_needs_polling(struct axp20x=
_usb_power *power)
>  	/*
>  	 * Polling is only necessary while VBUS is offline. While online, a
>  	 * present->absent transition implies an online->offline transition
> -	 * and will triger the VBUS_REMOVAL IRQ.
> +	 * and will trigger the VBUS_REMOVAL IRQ.
>  	 */
>  	if (power->axp20x_id >=3D AXP221_ID && !power->online)
>  		return true;
> --=20
> 2.26.2
>=20

--sskekeyxm6zhep2a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl7s0woACgkQ2O7X88g7
+pqAcw/+PjEYLRpQCa5y8T4Qp3wi2GQiVgmCWKbxFRJMjPVLo+XspUbHh5Jz1/ak
88omrqUZf+0qlyZmcHSjyJ6HGexo90uP1frxr5zvXm6Gb4gwfFtf8HYzF0WLuaVj
ttX4edkhEiw5lhDWUwkKj9YxCAA1Z/e7hFUdmIuKRFVos2eYNCJ48vG+lnJoFvZ8
E7OT81amDtEzaPxLMyZUplDbxp5JvmH8FrOCwNg1R7Psx0/Oi2vqb2CZ3fB6Ad2H
sxV+KSj5+u5j04r+TU5uQVLfBvINNk2FyZ/rr3jy/3VbMsQc0BS0W2ZusZqveHuN
EBAWaiV2MUv6VJfW2W6m5aWvOP9xpRF3OxePCVb/EJsvs5rgQaLorEPsDfMK8FlG
f5zxXxBDEJxaDOkkjXkUS/PEdT+Vfx2tXc52GuO+un85daWWtIzSFbmpHhkzRQeL
XIPKb9PUhqjptelKvaCZ8D84LDHfvaP6i5Rs5p4Srw65s4RAR1sdyd1vCpA8Uziq
AWB++zhmK+ylTz03bUrs4LCdNxHf5vL5RU6g9P0P+tsVnciczkalx0lcpqLkdNiT
9REG+G/+d3i8gm+irC201CbrGCz4kME7/LgQF62U/hrdKNSB8ttnW1UjQJ9+0xpf
JzuGthPgzTxvsvMcuZtpPFlJJR6jmZm9HuicaLtPUmHh7jqkqCI=
=+QeJ
-----END PGP SIGNATURE-----

--sskekeyxm6zhep2a--
