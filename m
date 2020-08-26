Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E789325362E
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 19:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgHZRs2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 13:48:28 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45500 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgHZRs0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2020 13:48:26 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 8944F294D9C
Received: by earth.universe (Postfix, from userid 1000)
        id 54F1E3C0C82; Wed, 26 Aug 2020 19:48:17 +0200 (CEST)
Date:   Wed, 26 Aug 2020 19:48:17 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.galvani@gmail.com, phh@phh.me,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH 1/2] power: supply: Add support for RN5T618/RC5T619
 charger and fuel gauge
Message-ID: <20200826174817.vhus3j4i4t7u7jc4@earth.universe>
References: <20200815165610.10647-1-andreas@kemnade.info>
 <20200815165610.10647-2-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y3moyevmvc7nmaqp"
Content-Disposition: inline
In-Reply-To: <20200815165610.10647-2-andreas@kemnade.info>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--y3moyevmvc7nmaqp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Driver looks mostly good.

On Sat, Aug 15, 2020 at 06:56:09PM +0200, Andreas Kemnade wrote:
> [...]
> +static int rn5t618_battery_current_now(struct rn5t618_power_info *info,
> +				       union power_supply_propval *val)
> +{
> +	u16 res;
> +	int ret;
> +
> +	ret = rn5t618_battery_read_doublereg(info, RN5T618_CC_AVEREG1, &res);
> +	if (ret)
> +		return ret;
> +
> +	val->intval = res;
> +	/* 2's complement */
> +	if (val->intval & (1 << 13))
> +		val->intval = val->intval - (1 << 14);
> +
> +	/* negate current to be positive when discharging */
> +	val->intval *= -1000;

mh, the sign is not documented (which should be fixed). At least
sbs-battery does it the other way around (negative current when
discharging, positive otherwise). Some drivers do not support
signed current and always report positive values (e.g. ACPI driver).

What did you use as reference for swapping the sign?

> +	return 0;
> +}
> [...]
> +static const struct power_supply_desc rn5t618_adp_desc = {
> +	.name                   = "rn5t618-adp",
> +	.type                   = POWER_SUPPLY_TYPE_MAINS,
> +	.properties             = rn5t618_usb_props,

wrong property array, works by accident since usb and adp property
lists are the same.

> +	.num_properties         = ARRAY_SIZE(rn5t618_adp_props),
> +	.get_property           = rn5t618_adp_get_property,
> +};
> [...]

-- Sebastian

--y3moyevmvc7nmaqp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9GoFsACgkQ2O7X88g7
+prupQ/+PUw6LW965p9e0EajZ5HB7SF2KwRWx6T+uXRreV8R2dMAS1s8K1gJplca
0/U5ZqMf3BjI5lP9m4h7/ccgUNEp/Iuk6tl143dCHutV+33SzTMgsucZVkuB+C7l
te75mJdDcxlf54+A2YBTLJkWoeFuznG9Cnecz0+KYJVpFia5Y6IJDQhmuAkW1UQ/
iSe8LnvAIZH+HQ9dyU0/wTSYhlidecfybKJL2i4o9Rv0l0jp4eKYnb/vhFQ7tW/u
4IXtEuc+CPSMy4wWC0gFMx2fo7EMBVmMLgxKOw3p5E3+26yG0tMoR/q8Pp4paIqk
CC/YZolAbU0nPWm71gCbisiZc3V/FE10SA6v65mFU/PyDIdCFHxmpWYb3A+LaOim
Z/HAcKzJj3mtmTDBu/O7sezuIgULfx2Zb3lAZ2HtuqWKJ/KYaZ0Z10TXtiBNGm14
3jWp2hEBVHsktNNVf4kjTQwENGwMaI85Kjsx9e2YNXJoESpyJh32M3HMKiBpDUKh
v/Qkb2Y5SSlgMb0E+StPIbRpVQ46vZpV2Ys04X5dfOp81UoG7NhvSECI5fOLRpo7
Kpa2/mrPMhe1gha/LEk2OItqXAZF8P95PL1obXVXWyV39vYm/v5oUd51wnOdnlu1
oyc2RLOgLW0Ae3KZsywx7ZgqD9XhhM076V0NaSMfSd5AAMQt0vI=
=TU9+
-----END PGP SIGNATURE-----

--y3moyevmvc7nmaqp--
