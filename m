Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D8A2EC039
	for <lists+linux-pm@lfdr.de>; Wed,  6 Jan 2021 16:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbhAFPR3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Jan 2021 10:17:29 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57440 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbhAFPR3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jan 2021 10:17:29 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id B72CE1F45F97
Received: by earth.universe (Postfix, from userid 1000)
        id B15903C0C94; Wed,  6 Jan 2021 16:16:44 +0100 (CET)
Date:   Wed, 6 Jan 2021 16:16:44 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] power/supply: Add ltc4162-l-charger
Message-ID: <20210106151644.jyfpjvazof565mhk@earth.universe>
References: <20210106075557.21626-1-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hfiybnxhmy47yu46"
Content-Disposition: inline
In-Reply-To: <20210106075557.21626-1-mike.looijmans@topic.nl>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--hfiybnxhmy47yu46
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 06, 2021 at 08:55:57AM +0100, Mike Looijmans wrote:
> Add support for the LTC4162-L Li-Ion battery charger. The driver allows
> reading back telemetry and to set some charging options like the input
> current limit.
>=20
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> v2: Use microohm units instead of milliohm
>     Add interrupt support using smbalert
>     Support obtaining cell-count from devicetree
> v3: Fix overflows in calculations involving resistor values
> v4: Use attr_grp member to register attributes
>     Report input current/voltage for charger and make battery
>     voltage and current into sysfs attributes

Fine with me until we have a better way to solve the problem. IIUIC
you no longer have access to the hardware anyways? But you need to
document the custom sysfs nodes: Please document them in the
following file:

Documentation/ABI/testing/sysfs-class-power-ltc4162l

[...]

> +static int ltc4162l_remove(struct i2c_client *client)
> +{
> +	struct ltc4162l_info *info =3D i2c_get_clientdata(client);
> +
> +	sysfs_remove_group(&info->charger->dev.kobj, &ltc4162l_attr_group);
> +
> +	return 0;
> +}

power-supply core automatically removes the sysfs groups specified
in power_supply_config.attr_grp.

-- Sebastian

--hfiybnxhmy47yu46
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl/11E8ACgkQ2O7X88g7
+prrYA/+NKYgvnBnp5yVsziQU46pWKi53aA/+HGiAiNJmHVnBNQGxsIyR9KAlaHM
RYZWquQH3HNu0OllXTLRtG7zxtEp17c/NMBHdxIKIz8Ovg22yV6jgDtZ8/lzF+tX
YviiKYf4y7q7QqAsoxt8TXgHPawJ4M+VB7vEDycH1MInGCHDTsvkkENOBRQqsODI
R9kvL+dhEGRu8cg/Ei+CBkeoQRU6LOp0+unYPa2e3oN2RV7bXKxgbBtZiCEOKAm8
OByzQXq/Wt9RDDUV1Qv60GtFkN6TW3GU0lKFajTM3I1CNmS600c+o2GZcaB6HFGM
YZfk79dlZ1Uw+RlL6QndBX8KlYDjbWmwGGfh7uaBMlAsdGAm45IvTsnY0SQQREgK
Uo7ALqa3SnNzXUHqiDO/EwRYiAFXrDJO7sQWvR+SEqxshf4LElc29aB/3wh1IVrs
V9GXw3n/h8lkm0u2hOkPv3ki4JXz5UaA8ytQPXB87NNUslXZ8He23HWqJebIvKRK
yoTFwmX2DVMX9Cg0Ric6aUwbKafQLYgkb7MUEc1c84vwONf0hbShzM5or7OwmSv9
9Ly9CHi97U73gd300NWLtkj/XmoGeTVOFZNcaY0402WWYiARwUeWHadMdzY6t5K9
2YHYYE3oXIEMyJ7a8djnX/jcRcUq0JRFdOtcFXf1XHvngPjw8Ag=
=c9KA
-----END PGP SIGNATURE-----

--hfiybnxhmy47yu46--
