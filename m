Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0721E140155
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 02:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgAQBMX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 20:12:23 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34394 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgAQBMW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 20:12:22 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 59B0729195F
Received: by earth.universe (Postfix, from userid 1000)
        id BCFD23C0C7E; Fri, 17 Jan 2020 02:12:16 +0100 (CET)
Date:   Fri, 17 Jan 2020 02:12:16 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     enric.balletbo@collabora.com, groeck@chromium.org,
        bleung@chromium.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Jon Flatley <jflat@chromium.org>
Subject: Re: [PATCH v7 3/3] power: supply: cros-ec-usbpd-charger: Fix host
 events
Message-ID: <20200117011216.p7etrc6oarptmhcb@earth.universe>
References: <20200117002820.56872-1-pmalani@chromium.org>
 <20200117002820.56872-3-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="76elxl47hgu34n4a"
Content-Disposition: inline
In-Reply-To: <20200117002820.56872-3-pmalani@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--76elxl47hgu34n4a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 16, 2020 at 04:28:24PM -0800, Prashant Malani wrote:
> From: Jon Flatley <jflat@chromium.org>
>=20
> There's a bug on ACPI platforms where host events from the ECPD ACPI
> device never make their way to the cros-ec-usbpd-charger driver. This
> makes it so the only time the charger driver updates its state is when
> user space accesses its sysfs attributes.
>=20
> Now that these events have been unified into a single notifier chain on
> both ACPI and non-ACPI platforms, update the charger driver to use this
> new notifier.
>=20
> Reviewed-by: Benson Leung <bleung@chromium.org>
> Co-Developed-by: Prashant Malani <pmalani@chromium.org>
> Signed-off-by: Jon Flatley <jflat@chromium.org>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

I currently have one cros_usbpd-charger patch queued in -next.
This patch looks like it should not create conflicts, but it's
probably better to merge an immutable branch.

-- Sebastian

>=20
> Changes in v7(pmalani@chromium.org):
> - Alphabetize #include header.
>=20
> Changes in v6(pmalani@chromium.org):
> - Patch first introduced into the series in v6.
>=20
>  drivers/power/supply/Kconfig              |  2 +-
>  drivers/power/supply/cros_usbpd-charger.c | 50 ++++++++---------------
>  2 files changed, 19 insertions(+), 33 deletions(-)
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 27164a1d3c7c4..ba74ddd793c3d 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -659,7 +659,7 @@ config CHARGER_RT9455
> =20
>  config CHARGER_CROS_USBPD
>  	tristate "ChromeOS EC based USBPD charger"
> -	depends on CROS_EC
> +	depends on CROS_USBPD_NOTIFY
>  	default n
>  	help
>  	  Say Y here to enable ChromeOS EC based USBPD charger
> diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/su=
pply/cros_usbpd-charger.c
> index 6cc7c3910e098..7eea080048f43 100644
> --- a/drivers/power/supply/cros_usbpd-charger.c
> +++ b/drivers/power/supply/cros_usbpd-charger.c
> @@ -9,6 +9,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/platform_data/cros_usbpd_notify.h>
>  #include <linux/platform_device.h>
>  #include <linux/power_supply.h>
>  #include <linux/slab.h>
> @@ -524,32 +525,21 @@ static int cros_usbpd_charger_property_is_writeable=
(struct power_supply *psy,
>  }
> =20
>  static int cros_usbpd_charger_ec_event(struct notifier_block *nb,
> -				       unsigned long queued_during_suspend,
> +				       unsigned long host_event,
>  				       void *_notify)
>  {
> -	struct cros_ec_device *ec_device;
> -	struct charger_data *charger;
> -	u32 host_event;
> +	struct charger_data *charger =3D container_of(nb, struct charger_data,
> +						    notifier);
> =20
> -	charger =3D container_of(nb, struct charger_data, notifier);
> -	ec_device =3D charger->ec_device;
> -
> -	host_event =3D cros_ec_get_host_event(ec_device);
> -	if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
> -		cros_usbpd_charger_power_changed(charger->ports[0]->psy);
> -		return NOTIFY_OK;
> -	} else {
> -		return NOTIFY_DONE;
> -	}
> +	cros_usbpd_charger_power_changed(charger->ports[0]->psy);
> +	return NOTIFY_OK;
>  }
> =20
>  static void cros_usbpd_charger_unregister_notifier(void *data)
>  {
>  	struct charger_data *charger =3D data;
> -	struct cros_ec_device *ec_device =3D charger->ec_device;
> =20
> -	blocking_notifier_chain_unregister(&ec_device->event_notifier,
> -					   &charger->notifier);
> +	cros_usbpd_unregister_notify(&charger->notifier);
>  }
> =20
>  static int cros_usbpd_charger_probe(struct platform_device *pd)
> @@ -683,21 +673,17 @@ static int cros_usbpd_charger_probe(struct platform=
_device *pd)
>  		goto fail;
>  	}
> =20
> -	if (ec_device->mkbp_event_supported) {
> -		/* Get PD events from the EC */
> -		charger->notifier.notifier_call =3D cros_usbpd_charger_ec_event;
> -		ret =3D blocking_notifier_chain_register(
> -						&ec_device->event_notifier,
> -						&charger->notifier);
> -		if (ret < 0) {
> -			dev_warn(dev, "failed to register notifier\n");
> -		} else {
> -			ret =3D devm_add_action_or_reset(dev,
> -					cros_usbpd_charger_unregister_notifier,
> -					charger);
> -			if (ret < 0)
> -				goto fail;
> -		}
> +	/* Get PD events from the EC */
> +	charger->notifier.notifier_call =3D cros_usbpd_charger_ec_event;
> +	ret =3D cros_usbpd_register_notify(&charger->notifier);
> +	if (ret < 0) {
> +		dev_warn(dev, "failed to register notifier\n");
> +	} else {
> +		ret =3D devm_add_action_or_reset(dev,
> +				cros_usbpd_charger_unregister_notifier,
> +				charger);
> +		if (ret < 0)
> +			goto fail;
>  	}
> =20
>  	return 0;
> --=20
> 2.25.0.341.g760bfbb309-goog
>=20

--76elxl47hgu34n4a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl4hCfAACgkQ2O7X88g7
+prSdRAAndFRCIrvPRuln3f8oxxNC85C+Z+hPlTNWaJppPguaTZ+xBkRGPs5oyrE
Gueiptsi1Ua8AaCECUU+cZeAHvVYDvVdTY21J48YMOXNgFiFC/BUN5oI9oZpe+Ri
F1J1sekKfwbFz5mbC6gSlqW36bIFiFHuOXrNjuEMtua2jsbCcf1QXe5dI6uLXAGj
UcFuvAvPafO9L90UojNrMGytkaAfpi04Cnj34i3INAcqsMkAYbb5o6I7lqFjjUlE
GZDkJA5oylOF7CCxKHBq5rCWHXHZT1kDKk2dXLepqJeP/H7MckNi+9/8hU9bBWp+
oDeSzeQN5lkXV8+LRUlOBjG0jPYj6JIltoqKkSglfPpQBWIOvsyF3Gs9rXw8ybxt
B1tCc2EG6Z4XBkYdyL31I0QZrlrVP4Kn23TNa4ah2KKMcveNEmtV5VD1R/sDFM8I
zK6S4/rdJIwD66Pu6on/Au47IWIPBTGGGtF0oJsDCle2PmZfo5PnD0yC6njqaQ2o
ivpEgujzcVkXRRLJB6HRqbuBoz4Tmt85MwXdDd/Q20DCLr5M77PcVaaC9agDuU+N
K7g3/jHkN2c/9o+UbZNLB08uTLea4eCrrYribWl6RkBCer/F6MDlEn37U2pmBocv
b2PbY0f06p9CWwRANS167dpLgBnsDgFEodvlradBVcUIGOygYAU=
=Rh6s
-----END PGP SIGNATURE-----

--76elxl47hgu34n4a--
