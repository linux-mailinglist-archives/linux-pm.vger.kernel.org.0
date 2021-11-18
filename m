Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97CD8455B72
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 13:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344582AbhKRMZh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Nov 2021 07:25:37 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33268 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344620AbhKRMZe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Nov 2021 07:25:34 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 161A21F46A8F
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637238152; bh=lYlMXiP4nz1RaOxxaa71KgChCTVevMt+/EYOLvLW4V8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TEqT96HIvd1shHDO25zQEISCjBscB1Kr2Bl/rRR9THeycUsoP0i/9rGmsAD2dh8U4
         DN78nkkJBcacpMNNdAVirDXc6CAIUuqAXyJL2koX1BNxW2xZnNb81agekWL+F8YYhg
         yjrouaP6AQwAX003L8BOHpy7/RPasgET0cUCmugSu9z+89ji1IQGi18R3XtCjY2cF/
         5a1r/qYsikwxuV1BVHciFqDG5wHSic+rXYlm7oANNc/Cf+dNoxXDQ88ldPBKDGI2dE
         oOhLpFXCicpjW0OBaTNJo35SvP3fOsSMfz3bT7JnUI5wdBOnLLhQFbkdjjUlB22u/T
         ydIS/diYk0N1w==
Received: by earth.universe (Postfix, from userid 1000)
        id E492E3C0F9E; Thu, 18 Nov 2021 13:22:29 +0100 (CET)
Date:   Thu, 18 Nov 2021 13:22:29 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] extcon: fix extcon_get_extcon_dev() error handling
Message-ID: <20211118122229.f7zzpiif2k4hr73q@earth.universe>
References: <20211118113026.GG1147@kili>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z5v7lnf7mcpizrt6"
Content-Disposition: inline
In-Reply-To: <20211118113026.GG1147@kili>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--z5v7lnf7mcpizrt6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 18, 2021 at 02:32:22PM +0300, Dan Carpenter wrote:
> The extcon_get_extcon_dev() function returns error pointers on error
> and NULL when it's a -EPROBE_DEFER defer situation.  There are eight
> callers and only two of them handled this correctly.  In the other
> callers an error pointer return would lead to a crash.
>=20
> What prevents crashes is that errors can only happen in the case of
> a bug in the caller or if CONFIG_EXTCON is disabled.  Six out of
> eight callers use the Kconfig to either depend on or select
> CONFIG_EXTCON.  Thus the real life impact of these bugs is tiny.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> The two callers where the drivers can be built without CONFIG_EXTCON
> are TYPEC_FUSB302 and CHARGER_MAX8997.
>=20
> If we apply this patch, it might be a good idea to send it to -stable
> so that backported code that relies on handling error pointers does
> not break silently.
>=20
>  drivers/extcon/extcon.c                |  2 +-
>  drivers/power/supply/axp288_charger.c  | 17 ++++++++++-------
>  drivers/power/supply/charger-manager.c |  7 ++-----
>  drivers/power/supply/max8997_charger.c | 10 +++++-----
>  drivers/usb/dwc3/drd.c                 |  9 ++-------
>  drivers/usb/phy/phy-omap-otg.c         |  4 ++--
>  drivers/usb/typec/tcpm/fusb302.c       |  4 ++--
>  drivers/extcon/extcon-axp288.c         |  4 ++--
>  8 files changed, 26 insertions(+), 31 deletions(-)

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com> # for power-s=
upply

-- Sebastian

>=20
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index e7a9561a826d..a35e99928807 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -876,7 +876,7 @@ struct extcon_dev *extcon_get_extcon_dev(const char *=
extcon_name)
>  		if (!strcmp(sd->name, extcon_name))
>  			goto out;
>  	}
> -	sd =3D NULL;
> +	sd =3D ERR_PTR(-EPROBE_DEFER);
>  out:
>  	mutex_unlock(&extcon_dev_list_lock);
>  	return sd;
> diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply=
/axp288_charger.c
> index ec41f6cd3f93..4acfeb52a44e 100644
> --- a/drivers/power/supply/axp288_charger.c
> +++ b/drivers/power/supply/axp288_charger.c
> @@ -848,17 +848,20 @@ static int axp288_charger_probe(struct platform_dev=
ice *pdev)
>  	info->regmap_irqc =3D axp20x->regmap_irqc;
> =20
>  	info->cable.edev =3D extcon_get_extcon_dev(AXP288_EXTCON_DEV_NAME);
> -	if (info->cable.edev =3D=3D NULL) {
> -		dev_dbg(dev, "%s is not ready, probe deferred\n",
> -			AXP288_EXTCON_DEV_NAME);
> -		return -EPROBE_DEFER;
> +	if (IS_ERR(info->cable.edev)) {
> +		dev_err_probe(dev, PTR_ERR(info->cable.edev),
> +			      "extcon_get_extcon_dev(%s) failed\n",
> +			      AXP288_EXTCON_DEV_NAME);
> +		return PTR_ERR(info->cable.edev);
>  	}
> =20
>  	if (acpi_dev_present(USB_HOST_EXTCON_HID, NULL, -1)) {
>  		info->otg.cable =3D extcon_get_extcon_dev(USB_HOST_EXTCON_NAME);
> -		if (info->otg.cable =3D=3D NULL) {
> -			dev_dbg(dev, "EXTCON_USB_HOST is not ready, probe deferred\n");
> -			return -EPROBE_DEFER;
> +		if (IS_ERR(info->otg.cable)) {
> +			dev_err_probe(dev, PTR_ERR(info->otg.cable),
> +				      "extcon_get_extcon_dev(%s) failed\n",
> +				      USB_HOST_EXTCON_NAME);
> +			return PTR_ERR(info->otg.cable);
>  		}
>  		dev_info(dev, "Using " USB_HOST_EXTCON_HID " extcon for usb-id\n");
>  	}
> diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/suppl=
y/charger-manager.c
> index d67edb760c94..92db79400a6a 100644
> --- a/drivers/power/supply/charger-manager.c
> +++ b/drivers/power/supply/charger-manager.c
> @@ -985,13 +985,10 @@ static int charger_extcon_init(struct charger_manag=
er *cm,
>  	cable->nb.notifier_call =3D charger_extcon_notifier;
> =20
>  	cable->extcon_dev =3D extcon_get_extcon_dev(cable->extcon_name);
> -	if (IS_ERR_OR_NULL(cable->extcon_dev)) {
> +	if (IS_ERR(cable->extcon_dev)) {
>  		pr_err("Cannot find extcon_dev for %s (cable: %s)\n",
>  			cable->extcon_name, cable->name);
> -		if (cable->extcon_dev =3D=3D NULL)
> -			return -EPROBE_DEFER;
> -		else
> -			return PTR_ERR(cable->extcon_dev);
> +		return PTR_ERR(cable->extcon_dev);
>  	}
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(extcon_mapping); i++) {
> diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power/suppl=
y/max8997_charger.c
> index 25207fe2aa68..634658adf313 100644
> --- a/drivers/power/supply/max8997_charger.c
> +++ b/drivers/power/supply/max8997_charger.c
> @@ -248,13 +248,13 @@ static int max8997_battery_probe(struct platform_de=
vice *pdev)
>  		dev_info(&pdev->dev, "couldn't get charger regulator\n");
>  	}
>  	charger->edev =3D extcon_get_extcon_dev("max8997-muic");
> -	if (IS_ERR_OR_NULL(charger->edev)) {
> -		if (!charger->edev)
> -			return -EPROBE_DEFER;
> -		dev_info(charger->dev, "couldn't get extcon device\n");
> +	if (IS_ERR(charger->edev)) {
> +		dev_err_probe(charger->dev, PTR_ERR(charger->edev),
> +			      "couldn't get extcon device: max8997-muic\n");
> +		return PTR_ERR(charger->edev);
>  	}
> =20
> -	if (!IS_ERR(charger->reg) && !IS_ERR_OR_NULL(charger->edev)) {
> +	if (!IS_ERR(charger->reg)) {
>  		INIT_WORK(&charger->extcon_work, max8997_battery_extcon_evt_worker);
>  		ret =3D devm_add_action(&pdev->dev, max8997_battery_extcon_evt_stop_wo=
rk, charger);
>  		if (ret) {
> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
> index d7f76835137f..a490f79131c1 100644
> --- a/drivers/usb/dwc3/drd.c
> +++ b/drivers/usb/dwc3/drd.c
> @@ -454,13 +454,8 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc=
3 *dwc)
>  	 * This device property is for kernel internal use only and
>  	 * is expected to be set by the glue code.
>  	 */
> -	if (device_property_read_string(dev, "linux,extcon-name", &name) =3D=3D=
 0) {
> -		edev =3D extcon_get_extcon_dev(name);
> -		if (!edev)
> -			return ERR_PTR(-EPROBE_DEFER);
> -
> -		return edev;
> -	}
> +	if (device_property_read_string(dev, "linux,extcon-name", &name) =3D=3D=
 0)
> +		return extcon_get_extcon_dev(name);
> =20
>  	/*
>  	 * Try to get an extcon device from the USB PHY controller's "port"
> diff --git a/drivers/usb/phy/phy-omap-otg.c b/drivers/usb/phy/phy-omap-ot=
g.c
> index ee0863c6553e..6e6ef8c0bc7e 100644
> --- a/drivers/usb/phy/phy-omap-otg.c
> +++ b/drivers/usb/phy/phy-omap-otg.c
> @@ -95,8 +95,8 @@ static int omap_otg_probe(struct platform_device *pdev)
>  		return -ENODEV;
> =20
>  	extcon =3D extcon_get_extcon_dev(config->extcon);
> -	if (!extcon)
> -		return -EPROBE_DEFER;
> +	if (IS_ERR(extcon))
> +		return PTR_ERR(extcon);
> =20
>  	otg_dev =3D devm_kzalloc(&pdev->dev, sizeof(*otg_dev), GFP_KERNEL);
>  	if (!otg_dev)
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fu=
sb302.c
> index 7a2a17866a82..8594b59bd527 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -1706,8 +1706,8 @@ static int fusb302_probe(struct i2c_client *client,
>  	 */
>  	if (device_property_read_string(dev, "linux,extcon-name", &name) =3D=3D=
 0) {
>  		chip->extcon =3D extcon_get_extcon_dev(name);
> -		if (!chip->extcon)
> -			return -EPROBE_DEFER;
> +		if (IS_ERR(chip->extcon))
> +			return PTR_ERR(chip->extcon);
>  	}
> =20
>  	chip->vbus =3D devm_regulator_get(chip->dev, "vbus");
> diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp28=
8.c
> index 7c6d5857ff25..180be768c215 100644
> --- a/drivers/extcon/extcon-axp288.c
> +++ b/drivers/extcon/extcon-axp288.c
> @@ -394,8 +394,8 @@ static int axp288_extcon_probe(struct platform_device=
 *pdev)
>  		if (adev) {
>  			info->id_extcon =3D extcon_get_extcon_dev(acpi_dev_name(adev));
>  			put_device(&adev->dev);
> -			if (!info->id_extcon)
> -				return -EPROBE_DEFER;
> +			if (IS_ERR(info->id_extcon))
> +				return PTR_ERR(info->id_extcon);
> =20
>  			dev_info(dev, "controlling USB role\n");
>  		} else {
> --=20
> 2.20.1
>=20

--z5v7lnf7mcpizrt6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmGWRX8ACgkQ2O7X88g7
+prY1A/6AlHt9/9Sqs3JZBaDcacgQbuL2hATtIodPI4knAHSG/ZQgpNIoqMnGGuw
fNHM9uJMaObVolucsxcNTbkcqD5feUu/DObfdUuzydS6B8xJjLNbLHUT6pX2gnmE
hX2elEzlO1+1Om1Sp2xBkkvx2avHj/tUBv3mBsiyTCdPF8eD4KgFKcArRlpz/IAv
+SRbRVzmx1OpEw4EwBzcNPrY1M/s1PSw7HXz6IHE3DckyJu9IYSlp1F9dal8WTXl
AytAdo1Rd1ALOfiTX0A8hqJKmwdOUK4FAg+IjHDh8FPRM72/nWPsuH9XJ+q771E1
d+N1FAAVU6OFfXEUVh1h4/lnThC+isTO5Bj5JTIDcZxu/4AGOqQIIFI6Or39A0Y5
n3wIbtejOZTEvSUvzLyNkkt50KC0q1lx8KsTqyO75gLyGVOOoRerQ8yfaH2kMVmK
TR9g3TiTw1eZoFbDzmrVVK3yo5SfNo1ULnpzTz4YqzsMjOIXO6Jk8O3Liqt8DnDE
FZZYTRxUzKZiLAN5P6XB5P4o4LgzDaVL/rNKMLURBb5u4+gGoDs2gg1ysXdchdyG
CTfYsRLr1yl8Ocg9rA2gfTIRfr4s8av7/ZY1F6I5rti+AHIRK7AonzaofojPKYGu
xiy+zua4N3lU63Og+lCY405LMIjNU583I/RrSsK33d1B8USuryE=
=BXLN
-----END PGP SIGNATURE-----

--z5v7lnf7mcpizrt6--
