Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3C622FE08
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jul 2020 01:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgG0XeR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 19:34:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgG0XeQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Jul 2020 19:34:16 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6B2F20809;
        Mon, 27 Jul 2020 23:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595892856;
        bh=JgDpgk8Xkxp89oqH9VYbBX5FyFOiPbGIIgUQHEDfMQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B9xu8NxGiZ/IjMfRoOY5GDUznSz0VYP6sHDo/YO3sFh7Lm1PakNkKub0KuJ07kdD6
         G/fcK+UqtARN45vcFdESB+KBWEtIaKvOBejZ10u9Rid9BfKQRp/8BDhgaTtL6s6uEj
         BumCxP4LgFIA589ekGFgot1nHqZCZGGTmTs3N8FU=
Received: by earth.universe (Postfix, from userid 1000)
        id 0B3A83C0B87; Tue, 28 Jul 2020 01:34:14 +0200 (CEST)
Date:   Tue, 28 Jul 2020 01:34:14 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Crag Wang <crag0715@gmail.com>
Cc:     mathewk@chromium.org, mario.limonciello@dell.com,
        campello@google.com, Crag Wang <crag.wang@dell.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 1/1] power_supply: wilco_ec: Add permanent long
 life charging mode
Message-ID: <20200727233414.xu5eqyes76a5hpkw@earth.universe>
References: <20200715145511.9464-1-crag.wang@dell.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ze4425po6izm6pbt"
Content-Disposition: inline
In-Reply-To: <20200715145511.9464-1-crag.wang@dell.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ze4425po6izm6pbt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 15, 2020 at 10:55:12PM +0800, Crag Wang wrote:
> This is a long life mode set in the factory for extended warranty
> battery, the power charging rate is customized so that battery at
> work last longer.
>=20
> Presently switching to a different battery charging mode is through
> EC PID 0x0710 to configure the battery firmware, this operation will
> be blocked by EC with failure code 0x01 when PLL mode is already
> in use.
>=20
> Signed-off-by: Crag Wang <crag.wang@dell.com>
> ---
>  Documentation/ABI/testing/sysfs-class-power-wilco | 3 +++
>  drivers/power/supply/power_supply_sysfs.c         | 1 +
>  drivers/power/supply/wilco-charger.c              | 5 +++++
>  include/linux/power_supply.h                      | 1 +
>  4 files changed, 10 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-power-wilco b/Document=
ation/ABI/testing/sysfs-class-power-wilco
> index da1d6ffe5e3c..1c91b17b6fd4 100644
> --- a/Documentation/ABI/testing/sysfs-class-power-wilco
> +++ b/Documentation/ABI/testing/sysfs-class-power-wilco
> @@ -14,6 +14,9 @@ Description:
>  			Charging begins when level drops below
>  			charge_control_start_threshold, and ceases when
>  			level is above charge_control_end_threshold.
> +		Permanent Long Life: Last longer battery life, this mode
> +			is programmed once in the factory. Switching to a
> +			different mode is unavailable.

The documentation lacks one important aspect: What happens
if I have a device where the factory did not program "Long Life"?
I.e. what happens when

# cat /sys/class/power_supply/wilco-charger/charge_type
Standard
# echo "Long Life" > /sys/class/power_supply/wilco-charger/charge_type

Will the controller switch into permanent long life battery mode
without any exit strategy?

>  What:		/sys/class/power_supply/wilco-charger/charge_control_start_thresh=
old
>  Date:		April 2019
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index bc79560229b5..af3884015ad8 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -87,6 +87,7 @@ static const char * const POWER_SUPPLY_CHARGE_TYPE_TEXT=
[] =3D {
>  	[POWER_SUPPLY_CHARGE_TYPE_STANDARD]	=3D "Standard",
>  	[POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE]	=3D "Adaptive",
>  	[POWER_SUPPLY_CHARGE_TYPE_CUSTOM]	=3D "Custom",
> +	[POWER_SUPPLY_CHARGE_TYPE_LONGLIFE]	=3D "Permanent Long Life",

The "Permanent" part is specific to the Wilco EC, so I think it's
better to avoid it in the generic API. I think it's better to use
just "Long Life" (and keep the wilco specific sysfs Documentation,
that Long Life configuration is permanent).

-- Sebastian

>  };
> =20
>  static const char * const POWER_SUPPLY_HEALTH_TEXT[] =3D {
> diff --git a/drivers/power/supply/wilco-charger.c b/drivers/power/supply/=
wilco-charger.c
> index b3c6d7cdd731..713c3018652f 100644
> --- a/drivers/power/supply/wilco-charger.c
> +++ b/drivers/power/supply/wilco-charger.c
> @@ -27,6 +27,7 @@ enum charge_mode {
>  	CHARGE_MODE_AC =3D 3,	/* Mostly AC use, used for Trickle */
>  	CHARGE_MODE_AUTO =3D 4,	/* Used for Adaptive */
>  	CHARGE_MODE_CUSTOM =3D 5,	/* Used for Custom */
> +	CHARGE_MODE_LONGLIFE =3D 6, /* Used for Permanent Long Life */
>  };
> =20
>  #define CHARGE_LOWER_LIMIT_MIN	50
> @@ -48,6 +49,8 @@ static int psp_val_to_charge_mode(int psp_val)
>  		return CHARGE_MODE_AUTO;
>  	case POWER_SUPPLY_CHARGE_TYPE_CUSTOM:
>  		return CHARGE_MODE_CUSTOM;
> +	case POWER_SUPPLY_CHARGE_TYPE_LONGLIFE:
> +		return CHARGE_MODE_LONGLIFE;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -67,6 +70,8 @@ static int charge_mode_to_psp_val(enum charge_mode mode)
>  		return POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE;
>  	case CHARGE_MODE_CUSTOM:
>  		return POWER_SUPPLY_CHARGE_TYPE_CUSTOM;
> +	case CHARGE_MODE_LONGLIFE:
> +		return POWER_SUPPLY_CHARGE_TYPE_LONGLIFE;
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index ac1345a48ad0..528a3eaa2320 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -48,6 +48,7 @@ enum {
>  	POWER_SUPPLY_CHARGE_TYPE_STANDARD,	/* normal speed */
>  	POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE,	/* dynamically adjusted speed */
>  	POWER_SUPPLY_CHARGE_TYPE_CUSTOM,	/* use CHARGE_CONTROL_* props */
> +	POWER_SUPPLY_CHARGE_TYPE_LONGLIFE,	/* slow speed, longer life */
>  };
> =20
>  enum {
> --=20
> 2.17.1
>=20
> ---
> The original author, Nick no longer being around and that's why he's not =
on CC.

--ze4425po6izm6pbt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl8fZHIACgkQ2O7X88g7
+pon5Q//Q0ljbWhfCtEjqe2xMDCnjXF3rx1XwzK/m99ouLBowdasFvLQ3qG7/LAI
O7lQvSo4pHfAFKy9+H0eZXtGSQwqjoF0DNhLiGuHbF3trqO4Tm7dxQhejlOtCpIj
Eh7D2B2YIXley9jR3RuxTuL0dNStR0jB+DL3c6/8IO8gA7GSqjKcpXEPohm0++RI
fwyOGOsqAKof3+98Ze1jal46vORiuwhTEcCahzqh8FWoO5VsiFMKkg6oxqIOwuWd
8bRITrCgcEb+8ioxCYdm/Rh+65OptYFKDZMKTobZkS8qWqoxp+R/Mhky1tYey11V
N85n5XZvTVbLQG/Y1RrxnGdEX6pCfMox/PWz4EsS3xE4JG0ra2MjvHcmGbzz7y8A
d4wJORjUEw6p3HJaHIXcThyDgPHX+i5lhmdeTjW50sAf5CkRGjbLNnjoTbjpLu/1
uutJEounTDhYxacfcUJL8xucaJKZY90y5PBruuzV8QOj8vcCayaTC8tQ44Qi+e7l
hVXK30ZEUZ0sbgrn/VmcD6aIc9LRhbgy14ankeQQqKBB6jAViBQzx62yqqVsF8by
DqbduN18BZi3z5Ad2i9bDgzT1BSbeE2kHH/zeCjAOSMU4Ol9y6YClHP4MclIGuOs
KFodT5uRd3RIF9XpIASCa3m4oeB85VIdKNdq4cWBeir73vFVUj8=
=lkV5
-----END PGP SIGNATURE-----

--ze4425po6izm6pbt--
