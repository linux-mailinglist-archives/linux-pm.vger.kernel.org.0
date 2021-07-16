Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C167F3CB835
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jul 2021 15:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbhGPOAX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Jul 2021 10:00:23 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34824 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbhGPOAX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jul 2021 10:00:23 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 015EE1F44120
Received: by earth.universe (Postfix, from userid 1000)
        id DEE833C0C97; Fri, 16 Jul 2021 15:57:25 +0200 (CEST)
Date:   Fri, 16 Jul 2021 15:57:25 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Daisuke Nojiri <dnojiri@chromium.org>
Cc:     vpalatin@chromium.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Utkarsh Patel <utkarsh.h.patel@intel.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 1/2] power: supply: PCHG: Peripheral device charger
Message-ID: <20210716135725.d3fadbozpmigmzmp@earth.universe>
References: <20210616185131.1792509-1-dnojiri@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4l6shjqowxm5ftve"
Content-Disposition: inline
In-Reply-To: <20210616185131.1792509-1-dnojiri@chromium.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--4l6shjqowxm5ftve
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 16, 2021 at 11:51:24AM -0700, Daisuke Nojiri wrote:
> This patch adds a driver for PCHG (Peripheral CHarGer). PCHG is a
> framework managing power supplies for peripheral devices.
>=20
> This driver creates a sysfs node for each peripheral charge port:
>=20
> 	/sys/class/power_supply/peripheral<n>
>=20
> where <n> is the index of a charge port.
>=20
> For example, when a stylus is connected to a NFC/WLC port, the node
> returns:
>=20
> 	/sys/class/power_supply/peripheral0/
> 		capacity=3D50
> 		charge_type=3DStandard
> 		scope=3DDevice
> 		status=3DCharging
> 		type=3DBattery
>=20
> Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
> ---
> [...]
> +static enum power_supply_property cros_pchg_props[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_CHARGE_TYPE,
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_SCOPE,
> +	/*
> +	 * todo: Add the following.
> +	 *
> +	 * POWER_SUPPLY_PROP_TECHNOLOGY,
> +	 * POWER_SUPPLY_PROP_ERROR,
> +	 * POWER_SUPPLY_PROP_SERIAL_NUMBER,
> +	 *
> +	 * POWER_SUPPLY_PROP_ONLINE can't be used because it indicates the
> +	 * system is powered by AC.
> +	 */
> +};
> [...]

Thanks, I queued the driver with the above TODO removed. Please
track this downstream, the note is not useful in mainline kernel,
since we do not have (AFAIK) the necessary documentation to add
more features.

-- Sebastian

--4l6shjqowxm5ftve
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmDxkEUACgkQ2O7X88g7
+pog9g//edvWJfj8PO46DU32fE+gq4YtH/VZAfxFxxjUgRVU/tlFVwTrmqAgeH6G
9z6m+1JpCiHoP2IUj1Y3+dlG29iKJ/nEwqX9E0VfvlbGFmWQuEej8pKMUlTfzNd7
VsbaHZZlqDpvKV0GmXW12AMMvZfZ7fAUqkE+9ygXAuWF6SnQ2irCQZMt+QBnj1cJ
feeb+DNS8VIG2ZBMSvJx2X3rZWM+1UQuXs3UFDYmS/TKotF+mFNCHt43I/+rrTm/
vXOidPdiavklFtLcWv8Uh2XP2sWV0ZIszPhoMCDHt5eSMUuINvM/FGNUeXDxOYmy
umKNoZ8Kl2agQj7ZKEMLWd1uLZX6ATJMScJfZamDiHFT45mJa8QAqQICJgezRVA4
CYqDDNRhBDG2PYkHKNEMmaGyjhdsEm6vCD9LWYTCoDjqLtw7C98HLOimBZGqhLI+
9wk8mUeg7SzktGqGKW4A5pZajXFmSgH+xw3AHeupGpylDCoriY+gEC0WaeydOFdj
GoE3xKJ2ui8qqwfBZnNaFU+mNTEWpIzlL0oaQEAnZmgs90j2upQ9J8NYpdXc63PT
m5Usr+hV0IqvWXv0waslaG/EY6i4smzncUIHMoFp7Kj+p0rFo2cIwe9nn9NE2XdD
Zy5MNoDcNVFsnnnfE0jvZaTVkrQgEfQ0cdB/P3cywzu1FDmrgs4=
=ksno
-----END PGP SIGNATURE-----

--4l6shjqowxm5ftve--
