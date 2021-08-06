Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB963E30CA
	for <lists+linux-pm@lfdr.de>; Fri,  6 Aug 2021 23:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245129AbhHFVOU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Aug 2021 17:14:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238752AbhHFVOT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Aug 2021 17:14:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71C8061167;
        Fri,  6 Aug 2021 21:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628284441;
        bh=9OiTs9pDHjt9r3hFWFQGUT4jhn3LANAYPBeoqI6UPlk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hbETkcqpXUrvYwNfIgpnAlYdgCEKB8/dbm1RXVTO1RegMnAZkAdwQXcfhX3kM2IG5
         9MVYTLm9RZa1lNjU06oy0xwZTIgW0UZMcJDVGQlI2D1jVtg075Fc/HARUslvhcH6mm
         qfH3eGqy2XSn7uI7G6s3oSwqKFEmrJBWQ1busJa29YUjUOMU4GRnP42T4RIjzerK2Y
         JCjuK3AmbpwK2UR0SFPj11Ep9VffAH4r4u+o2sn6idjwFFywR7Eso+8hWAmybGQnzs
         DQR2Fv3pvGJTZhXHcjnxYtNhiWUp7QX/4XVeJsis33O1K368geII4XzLCM7dAMskbI
         f/HgFUtZ5lCWA==
Received: by earth.universe (Postfix, from userid 1000)
        id C7F013C0C99; Fri,  6 Aug 2021 23:13:59 +0200 (CEST)
Date:   Fri, 6 Aug 2021 23:13:59 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v6 08/12] power: supply: smb347-charger: Add missing pin
 control activation
Message-ID: <20210806211359.lq765pzmgvviffhg@earth.universe>
References: <20210731173842.19643-1-digetx@gmail.com>
 <20210731173842.19643-9-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bm4r4v2elzlke47t"
Content-Disposition: inline
In-Reply-To: <20210731173842.19643-9-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--bm4r4v2elzlke47t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 31, 2021 at 08:38:38PM +0300, Dmitry Osipenko wrote:
> Pin control needs to be activated by setting the enable bit, otherwise
> hardware rejects all pin changes. Previously this stayed unnoticed on
> Nexus 7 because pin control was enabled by default after rebooting from
> downstream kernel, which uses driver that enables the bit and charger
> registers are non-volatile until power supply (battery) is disconnected.
> Configure the pin control enable bit. This fixes the potentially
> never-enabled charging on devices that use pin control.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/smb347-charger.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply=
/smb347-charger.c
> index 27254e6efdde..1c9205ca0993 100644
> --- a/drivers/power/supply/smb347-charger.c
> +++ b/drivers/power/supply/smb347-charger.c
> @@ -55,6 +55,7 @@
>  #define CFG_PIN_EN_CTRL_ACTIVE_LOW		0x60
>  #define CFG_PIN_EN_APSD_IRQ			BIT(1)
>  #define CFG_PIN_EN_CHARGER_ERROR		BIT(2)
> +#define CFG_PIN_EN_CTRL				BIT(4)
>  #define CFG_THERM				0x07
>  #define CFG_THERM_SOFT_HOT_COMPENSATION_MASK	0x03
>  #define CFG_THERM_SOFT_HOT_COMPENSATION_SHIFT	0
> @@ -726,6 +727,15 @@ static int smb347_hw_init(struct smb347_charger *smb)
>  	if (ret < 0)
>  		goto fail;
> =20
> +	/* Activate pin control, making it writable. */
> +	switch (smb->enable_control) {
> +	case SMB3XX_CHG_ENABLE_PIN_ACTIVE_LOW:
> +	case SMB3XX_CHG_ENABLE_PIN_ACTIVE_HIGH:
> +		ret =3D regmap_set_bits(smb->regmap, CFG_PIN, CFG_PIN_EN_CTRL);
> +		if (ret < 0)
> +			goto fail;
> +	}
> +
>  	/*
>  	 * Make the charging functionality controllable by a write to the
>  	 * command register unless pin control is specified in the platform
> --=20
> 2.32.0
>=20

--bm4r4v2elzlke47t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmENphcACgkQ2O7X88g7
+pqDWw//UG5SGkUDPxPcJiiI+BIe+J/7chIvPHF0cz0qeHd0zs2G+ds8w6mVX+4t
x7okkSU7jEpIzGwdY6P7fp+eNKksNwzLcCbBjO1pMbaZf1efKB4FJqZCfK/sqvbi
sq9NJf+EviDX7xxvqejM1vPvFc5nH3zDGeR+A6f26QEaQOIyXHnYSehu2NNgY/O/
ZlWI44bjSwf+Lbua4WDxyMe3S/ScyOn3A220NmTx1G1SnOgOiHoBmPmXiAbZv6HC
KNhRXsvxClcMZE+oYCcIYzY4UGrVggsL9QfUs/rY7oZ6MIRBLGu4AQJCBj6DyKog
9nC+YDTLpBCArzZ/3M9Yl8taTYeb0yW3Ab+SuqI7W40jrCHyWUU6m9Zar5geSl0h
ew0Tn3A8A/bvdIL+BcSRyMs/iJ0WHqmZpYK7wsUDiWILUf6+cHORdANIsyZ3/92S
tNpahw/YF2AowjOWgLSg/VYKAqmGyzQXrXdriwLvx0NQz5TsTprPCN67XjzNj1YD
guVvyz1BYsMMxeJfCPit8s9T9lA1mzQwSD7SXpaX17oHAMnlP6/sftvWJwBH6iLV
nS2VCJX6pn2K2mBZOUQJ8HyASK/pL9YaVsXf9+5ezeblZ8JKfzeLJN9vubKH868K
MLJzTGkOQHEMcnADyoEKeF9IAMszgBpF+ChA+3ZeA5qpsTLLFfw=
=EsjQ
-----END PGP SIGNATURE-----

--bm4r4v2elzlke47t--
