Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B903F25326E
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 16:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgHZOzx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 10:55:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbgHZOzv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Aug 2020 10:55:51 -0400
Received: from earth.universe (unknown [95.33.152.255])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ABA82078D;
        Wed, 26 Aug 2020 14:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598453750;
        bh=rRbCqiqY/EoWxKJlqRKXx+DB87uOlZjjkyQIPWEqbf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X8cD5/7vqOTBKlyJGK/ohJXXUAgbuhvnHY0TuGm9SQaFeKcxNKJxCG+dzVps2XABR
         sLu4Kul6WZriqBJv1bZpdSkORrdZEUYpxifZC5mJ4+aqDqtNeOuh+HmtS5eUIHVUJ+
         tAZSoeHUgcXgfZU4VLh3bKkVzvdnAm+EVK+ZtXV8=
Received: by earth.universe (Postfix, from userid 1000)
        id E61E63C0C82; Wed, 26 Aug 2020 16:55:48 +0200 (CEST)
Date:   Wed, 26 Aug 2020 16:55:48 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     linux-pm@vger.kernel.org,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] power: supply: add wireless power_supply_type
Message-ID: <20200826145548.hpt7bofoznuqc2z3@earth.universe>
References: <1597343648-11136-1-git-send-email-gurus@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="57nokb3z2iq74u5g"
Content-Disposition: inline
In-Reply-To: <1597343648-11136-1-git-send-email-gurus@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--57nokb3z2iq74u5g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 13, 2020 at 11:34:08AM -0700, Guru Das Srinagesh wrote:
> From: Subbaraman Narayanamurthy <subbaram@codeaurora.org>
>=20
> Currently, power_supply framework supports only Battery, UPS,
> Mains and USB power_supply_type. Add wireless power_supply_type
> so that the drivers which supports wireless can register a power
> supply class device with POWER_SUPPLY_TYPE_WIRELESS.
>=20
> Signed-off-by: Subbaraman Narayanamurthy <subbaram@codeaurora.org>
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---

Thanks, queued.

-- Sebastian

>  Documentation/ABI/testing/sysfs-class-power | 2 +-
>  drivers/power/supply/power_supply_sysfs.c   | 1 +
>  include/linux/power_supply.h                | 1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/=
ABI/testing/sysfs-class-power
> index 40213c7..651599f 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -34,7 +34,7 @@ Description:
>  		Describes the main type of the supply.
> =20
>  		Access: Read
> -		Valid values: "Battery", "UPS", "Mains", "USB"
> +		Valid values: "Battery", "UPS", "Mains", "USB", "Wireless"
> =20
>  =3D=3D=3D=3D=3D Battery Properties =3D=3D=3D=3D=3D
> =20
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index 3d38308..a616b9d 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -56,6 +56,7 @@ static const char * const POWER_SUPPLY_TYPE_TEXT[] =3D {
>  	[POWER_SUPPLY_TYPE_USB_PD]		=3D "USB_PD",
>  	[POWER_SUPPLY_TYPE_USB_PD_DRP]		=3D "USB_PD_DRP",
>  	[POWER_SUPPLY_TYPE_APPLE_BRICK_ID]	=3D "BrickID",
> +	[POWER_SUPPLY_TYPE_WIRELESS]		=3D "Wireless",
>  };
> =20
>  static const char * const POWER_SUPPLY_USB_TYPE_TEXT[] =3D {
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 97cc4b8..ef03299 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -186,6 +186,7 @@ enum power_supply_type {
>  	POWER_SUPPLY_TYPE_USB_PD,		/* Power Delivery Port */
>  	POWER_SUPPLY_TYPE_USB_PD_DRP,		/* PD Dual Role Port */
>  	POWER_SUPPLY_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
> +	POWER_SUPPLY_TYPE_WIRELESS,		/* Wireless */
>  };
> =20
>  enum power_supply_usb_type {
> --=20
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>=20

--57nokb3z2iq74u5g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9Gd+oACgkQ2O7X88g7
+pokwhAAmxMme7G++GKR3lMafSysEFnG5OVKnLg3ePC2kZrHtbriuB1lhu780hTx
yMlCYABv5/eabd08rQVKLPAca2uK6DTfXxJRMasIpbGJlreYvGGMAzJCAWpSKEZO
MAF2JzDHda9Q3MFaRcpbFIUSz1Xsdhzkr7gN3VZF00CM3vPwAQTTb1wj90MjakvD
zBfi6Ehqkb01JxiftaWFDGNAu2zAi91V0a1yA/bh4DmbPJRr+r95nvA1M2oL7rKc
1X9ERX3WNqpNdZMMLrhx3hRsAEIDhjSXsud1kJHRLHIp+TKEeiLxrt5OLZSi9di9
q+IMzRpk1j+Orv0yK6VvabjC6FEoc3dUxOq2QfAToJxXVzBJLC4fGu1paSowz/7u
jwHrlt9XtS0rz9jo+PEEGnl+xTQOx4O0N6fsm7CU+Zg1rGmK7JxkNSh/yBCs3GIP
eDg/Ymhw8anaeA8SUEszXkxPRo10h5H0EDa+nzzXP+lgD+f4apD2MSb55OFBErgK
6nIwF5K1qD5hWS2LkN05juADG17ouVBqcIwjzng2vbXmUdFVSdl6e4KVtxdlzcOU
AM3Cv/sLyMAbKK7/r4s0H9LNJ05yGhf66Hvqmrg1cSZy0hgUbfuOwqE4MXkLYAcD
CnMdxjOfxwB6ubbYyJHc17XzhKwZ6Qn8M+q2WrVw2T+l1tZXRxQ=
=Xsv1
-----END PGP SIGNATURE-----

--57nokb3z2iq74u5g--
