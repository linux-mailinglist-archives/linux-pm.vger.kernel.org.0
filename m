Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E552346DF
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jul 2020 15:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgGaNaE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jul 2020 09:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbgGaNaE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 Jul 2020 09:30:04 -0400
Received: from earth.universe (dyndsl-037-138-184-248.ewe-ip-backbone.de [37.138.184.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 217B222B3F;
        Fri, 31 Jul 2020 13:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596202203;
        bh=9J8+SfLgQFhaZ3UwUM5jsEeepNuEJuqZs4CrrlHx7iw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vEA5lavzfwAX4CezhW4qGMG4wqew2GF1sDPBODvp5Fer/OQ5yi9v1YO8g3WHofUTb
         7cCKDoTRrfHvmFib3CvVaMb9z2h6I4DvqhOlr37F9egc9fpCWPLdkAbMeDvHZsmDoV
         /EOFqPRS4sQ9T+gq+poScCiedkV5JIRFQ3z77b3Q=
Received: by earth.universe (Postfix, from userid 1000)
        id 7F7623C0B87; Fri, 31 Jul 2020 15:30:01 +0200 (CEST)
Date:   Fri, 31 Jul 2020 15:30:01 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Crag Wang <crag0715@gmail.com>
Cc:     mario.limonciello@dell.com, mathewk@chromium.org,
        campello@google.com, crag.wang@dell.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] power_supply: wilco_ec: Add long life charging
 mode
Message-ID: <20200731133001.zlukj5wy5pzhlgnc@earth.universe>
References: <20200715145511.9464-1-crag.wang@dell.com>
 <20200730032609.20330-1-crag.wang@dell.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vqfmkacknvhfpg4v"
Content-Disposition: inline
In-Reply-To: <20200730032609.20330-1-crag.wang@dell.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--vqfmkacknvhfpg4v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 30, 2020 at 11:26:09AM +0800, Crag Wang wrote:
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
> Reviewed-by: Mario Limonciello <mario.limonciello@dell.com>
> ---

Thanks, queued.

-- Sebastian

>  Documentation/ABI/testing/sysfs-class-power-wilco | 4 ++++
>  drivers/power/supply/power_supply_sysfs.c         | 1 +
>  drivers/power/supply/wilco-charger.c              | 5 +++++
>  include/linux/power_supply.h                      | 1 +
>  4 files changed, 11 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-power-wilco b/Document=
ation/ABI/testing/sysfs-class-power-wilco
> index da1d6ffe5e3c..84fde1d0ada0 100644
> --- a/Documentation/ABI/testing/sysfs-class-power-wilco
> +++ b/Documentation/ABI/testing/sysfs-class-power-wilco
> @@ -14,6 +14,10 @@ Description:
>  			Charging begins when level drops below
>  			charge_control_start_threshold, and ceases when
>  			level is above charge_control_end_threshold.
> +		Long Life: Customized charge rate for last longer battery life.
> +			On Wilco device this mode is pre-configured in the factory
> +			through EC's private PID. Swiching to a different mode will
> +			be denied by Wilco EC when Long Life mode is enabled.
> =20
>  What:		/sys/class/power_supply/wilco-charger/charge_control_start_thresh=
old
>  Date:		April 2019
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index bc79560229b5..cfb87b8b8392 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -87,6 +87,7 @@ static const char * const POWER_SUPPLY_CHARGE_TYPE_TEXT=
[] =3D {
>  	[POWER_SUPPLY_CHARGE_TYPE_STANDARD]	=3D "Standard",
>  	[POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE]	=3D "Adaptive",
>  	[POWER_SUPPLY_CHARGE_TYPE_CUSTOM]	=3D "Custom",
> +	[POWER_SUPPLY_CHARGE_TYPE_LONGLIFE]	=3D "Long Life",
>  };
> =20
>  static const char * const POWER_SUPPLY_HEALTH_TEXT[] =3D {
> diff --git a/drivers/power/supply/wilco-charger.c b/drivers/power/supply/=
wilco-charger.c
> index b3c6d7cdd731..98ade073ef05 100644
> --- a/drivers/power/supply/wilco-charger.c
> +++ b/drivers/power/supply/wilco-charger.c
> @@ -27,6 +27,7 @@ enum charge_mode {
>  	CHARGE_MODE_AC =3D 3,	/* Mostly AC use, used for Trickle */
>  	CHARGE_MODE_AUTO =3D 4,	/* Used for Adaptive */
>  	CHARGE_MODE_CUSTOM =3D 5,	/* Used for Custom */
> +	CHARGE_MODE_LONGLIFE =3D 6, /* Used for Long Life */
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

--vqfmkacknvhfpg4v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl8kHMYACgkQ2O7X88g7
+pp3Og//YuxU67BOuDowvVcMiMqz5Wiawq/N/EAwbx8PnhJZKCOCZ3mV8Fo+w2bR
1geFsg6GT5pShnNX6O2FmEIMhS74TpxqHHKfIHYHmR3zm5AfYthfe8g4KSLLmZ/p
8jxODYpI322GsJ9OmpbeGCFVIcc61zgfbBZlmhhSQY81do/2Ca9iZsFDVcYIZvCO
2keAIn3j6nt1+YipuYrLaB3uWGl+9Bdgo+UsezI6mFefz/DAvt7MCRTcBGNQQ81G
0qT3BsLYjmiSclziT4pS9vzwuEqwOD2VXA7HcvJwK0TYa3LfibRA0YUa8s8g55Dl
p4bgqZZqt7+fv+ZkYqIQWi7H6ij8wcFwZG+9J5mrZykmRyt3WKXjHN4B+FIuMJh8
OQciR/z9Kt108K7jkorD8E0bAbntX6JBqUUZpj6IMjIiuVdBoK+aWgQe94GsmL2U
2dEQOcnrOxk1lYfFVt7yJiN4QCZz4wPtFZ1Sbb8YmVo7+4gLiq8Z7YxLq6sOcvGy
F43UMXPg6qRxs1/cmx+DrtVyrb8FpTc0oar0JlwKR3/X1nuiOirr3xoYCrFzoP+A
7ajLtBwEclUkjKcGw9Zv9z5u5LGUyiedoUvEiOMh5asxHyJlpBLxB4BqyCBQKWkM
biSZJOKZJj6HyKG9oOI6VokCbLAED2hQQjusCp02m+ZZFZPCuD8=
=nxsr
-----END PGP SIGNATURE-----

--vqfmkacknvhfpg4v--
