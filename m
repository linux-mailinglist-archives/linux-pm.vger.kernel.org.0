Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27348201656
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jun 2020 18:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394974AbgFSQ3W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jun 2020 12:29:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394969AbgFSQ3V (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Jun 2020 12:29:21 -0400
Received: from earth.universe (dyndsl-037-138-190-043.ewe-ip-backbone.de [37.138.190.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD02D21835;
        Fri, 19 Jun 2020 16:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592584160;
        bh=+hZ55DPcpNoe52JJX6SzFUdt7Nq2feraIFoTBJOUbCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UWwui6c5uOLurxZ2rO/Zj3m9E2ST+yPpr76ryz+TxSu58kiKc/85Wfn1tJhEizMyG
         69jShU+ohV3/fNvbbYb0jW77y0mzAsbXIF63Uvh7iCzYioNBAPqB/uy0uMpiM39yy0
         koYgCjdhd3RyIVFFv7cGCowuxiXEDpHjkBNzsxMw=
Received: by earth.universe (Postfix, from userid 1000)
        id 2AA2A3C08CD; Fri, 19 Jun 2020 18:29:19 +0200 (CEST)
Date:   Fri, 19 Jun 2020 18:29:19 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Emil Velikov <emil.velikov@collabora.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv2 2/6] power: supply: gpio-charger: Make gpios optional
Message-ID: <20200619162919.kcdnx5lkdawlvrdn@earth.universe>
References: <20200605224403.181015-1-sebastian.reichel@collabora.com>
 <20200605224403.181015-3-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ch2a4gbxhtptsn53"
Content-Disposition: inline
In-Reply-To: <20200605224403.181015-3-sebastian.reichel@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ch2a4gbxhtptsn53
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jun 06, 2020 at 12:43:59AM +0200, Sebastian Reichel wrote:
> While strongly recommended, not all devices have a gpio to
> detect if the charger is connected. This moves the 'gpios'
> from required to optional section.
>=20
> This also modifies error handling for the GPIO a bit: We
> no longer fallback to pdata, if a GPIO is specified using
> GPIO descriptor tables. This is a bit cleaner and does
> not have any real impact: There are only two mainline pdata
> users (arm/mach-sa1100/collie.c, arm/mach-pxa/tosa.c) and
> none of them specify the GPIO via gpiod descriptor tables.
> Once both have been converted the driver's support for
> specifying GPIOs numbers in pdata will be dropped.
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---

Thanks, queued.

-- Sebastian

>  .../bindings/power/supply/gpio-charger.yaml   |  7 +++-
>  drivers/power/supply/gpio-charger.c           | 38 ++++++++++++-------
>  2 files changed, 31 insertions(+), 14 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.=
yaml b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
> index 78b167c62ab1..30eabbb14ef3 100644
> --- a/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
> @@ -41,7 +41,12 @@ properties:
> =20
>  required:
>    - compatible
> -  - gpios
> +
> +anyOf:
> +  - required:
> +    - gpios
> +  - required:
> +    - charge-status-gpios
> =20
>  additionalProperties: false
> =20
> diff --git a/drivers/power/supply/gpio-charger.c b/drivers/power/supply/g=
pio-charger.c
> index 1b959c7f8b0e..875735d50716 100644
> --- a/drivers/power/supply/gpio-charger.c
> +++ b/drivers/power/supply/gpio-charger.c
> @@ -112,9 +112,14 @@ static int gpio_charger_get_irq(struct device *dev, =
void *dev_id,
>  	return irq;
>  }
> =20
> +/*
> + * The entries will be overwritten by driver's probe routine depending
> + * on the available features. This list ensures, that the array is big
> + * enough for all optional features.
> + */
>  static enum power_supply_property gpio_charger_properties[] =3D {
>  	POWER_SUPPLY_PROP_ONLINE,
> -	POWER_SUPPLY_PROP_STATUS /* Must always be last in the array. */
> +	POWER_SUPPLY_PROP_STATUS,
>  };
> =20
>  static int gpio_charger_probe(struct platform_device *pdev)
> @@ -128,6 +133,7 @@ static int gpio_charger_probe(struct platform_device =
*pdev)
>  	int charge_status_irq;
>  	unsigned long flags;
>  	int ret;
> +	int num_props =3D 0;
> =20
>  	if (!pdata && !dev->of_node) {
>  		dev_err(dev, "No platform data\n");
> @@ -142,13 +148,13 @@ static int gpio_charger_probe(struct platform_devic=
e *pdev)
>  	 * This will fetch a GPIO descriptor from device tree, ACPI or
>  	 * boardfile descriptor tables. It's good to try this first.
>  	 */
> -	gpio_charger->gpiod =3D devm_gpiod_get(dev, NULL, GPIOD_IN);
> +	gpio_charger->gpiod =3D devm_gpiod_get_optional(dev, NULL, GPIOD_IN);
> =20
>  	/*
> -	 * If this fails and we're not using device tree, try the
> -	 * legacy platform data method.
> +	 * Fallback to legacy platform data method, if no GPIO is specified
> +	 * using boardfile descriptor tables.
>  	 */
> -	if (IS_ERR(gpio_charger->gpiod) && !dev->of_node) {
> +	if (!gpio_charger->gpiod && pdata) {
>  		/* Non-DT: use legacy GPIO numbers */
>  		if (!gpio_is_valid(pdata->gpio)) {
>  			dev_err(dev, "Invalid gpio pin in pdata\n");
> @@ -173,17 +179,23 @@ static int gpio_charger_probe(struct platform_devic=
e *pdev)
>  		return PTR_ERR(gpio_charger->gpiod);
>  	}
> =20
> +	if (gpio_charger->gpiod) {
> +		gpio_charger_properties[num_props] =3D POWER_SUPPLY_PROP_ONLINE;
> +		num_props++;
> +	}
> +
>  	charge_status =3D devm_gpiod_get_optional(dev, "charge-status", GPIOD_I=
N);
> -	gpio_charger->charge_status =3D charge_status;
> -	if (IS_ERR(gpio_charger->charge_status))
> -		return PTR_ERR(gpio_charger->charge_status);
> +	if (IS_ERR(charge_status))
> +		return PTR_ERR(charge_status);
> +	if (charge_status) {
> +		gpio_charger->charge_status =3D charge_status;
> +		gpio_charger_properties[num_props] =3D POWER_SUPPLY_PROP_STATUS;
> +		num_props++;
> +	}
> =20
>  	charger_desc =3D &gpio_charger->charger_desc;
>  	charger_desc->properties =3D gpio_charger_properties;
> -	charger_desc->num_properties =3D ARRAY_SIZE(gpio_charger_properties);
> -	/* Remove POWER_SUPPLY_PROP_STATUS from the supported properties. */
> -	if (!gpio_charger->charge_status)
> -		charger_desc->num_properties -=3D 1;
> +	charger_desc->num_properties =3D num_props;
>  	charger_desc->get_property =3D gpio_charger_get_property;
> =20
>  	psy_cfg.of_node =3D dev->of_node;
> @@ -269,6 +281,6 @@ static struct platform_driver gpio_charger_driver =3D=
 {
>  module_platform_driver(gpio_charger_driver);
> =20
>  MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
> -MODULE_DESCRIPTION("Driver for chargers which report their online status=
 through a GPIO");
> +MODULE_DESCRIPTION("Driver for chargers only communicating via GPIO(s)");
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS("platform:gpio-charger");
> --=20
> 2.26.2
>=20

--ch2a4gbxhtptsn53
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl7s598ACgkQ2O7X88g7
+pqlcA//eh1hM9zdzgi/BDDgC54rL2USVv09NqBaZVjWDfBhrln5gb329f+LslHJ
uMDHwzWTWpu0O0QDzqNRuubFv8HQegjqjg85qp4nSy8V7ebC2+3OQ9KT5UgnwpQg
HUUco84g90g+i2egkcvUacZhtAkD5PTNoED3wsYHWKzDoOUwPRuVACT9skhbaZyH
t4dIUAr9neLpitjIrS66jyHqs3sKHMVHLYVDCAhgOpwf304IIKfZ+6j9Jwgzog9f
Nt2CaiuZsOjDO7zlVe/6KVtGBkRRz6ZVGfGhPvPKDmQAKVUG88eYAXWkjhMfJ+Kg
U0b0s5xZKM7RCT9U5av0xhUrfo75hsQ8Ral6MmjSh3t44Cdb5HnToPjYjeNrU0AK
2pPH7z3DSQVb+hKH96EExpoqPFLHRETc05R8vGn9JbKFK+q/ECgCvnh7BaDuCSLG
5PR9cgP3xK4/yy8WrhAa8MggMc/R77lax4ZUOYN0HJazEbFWpKQnm4xoY9nMZDCF
7/Hqkemsbcce6x6LQnxFnw5BGAGPAOIG5Wtc9hZn1/bpUCBIOLu+rScPi28wZKiq
C6gCi5iBYVHHd2JtW2eZB13zNJgGGY1n4wYDFy4Rqg8Hys5QvJYFl4pd6+84ZyIF
mqD73WqwRxYQCkPiJkjusFy208U6Gz8GYOm0+izqSFzbV6i80No=
=Gp21
-----END PGP SIGNATURE-----

--ch2a4gbxhtptsn53--
