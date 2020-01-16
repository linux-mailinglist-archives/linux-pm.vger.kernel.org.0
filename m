Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58AE813F9F9
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 20:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730664AbgAPTvh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 14:51:37 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42598 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbgAPTvg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 14:51:36 -0500
Received: by mail-pg1-f193.google.com with SMTP id s64so10420439pgb.9
        for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2020 11:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wu+I8aE11hoRgbOsBs0FtKqpK+C2bZSgRMmLwWFZIRw=;
        b=r5O/F1alUl7CBjpQdp0GZXx4v1NXnzhtUe6P/VPfC6ZasmBJRUUI09knkDD2oHGrn/
         yDxzA0e1yhYyussa/w9yGeprzDlaMXL1WC7B6ynovLgsxvz54xfg0W+uQ3uAJqIpYz9o
         H9zlD+evVptsKTVKN7F3TO68ts/QGrat3Mli3A3+SXkpnWE+REq+0ECXE3Nkr4el/kRR
         4Ueap7wvqXdOnA6Lfmq11MsnSifCVJtw+zUhQcQAL4uiQrdqDz9UKWEuevnVt17CJhJF
         Kem/H9vhlG7mlYV+0z02Yx1R3DirrPYgE8uwzF0VeYq4FZXyxEFu4gtbbaqzEpKkCevG
         pSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wu+I8aE11hoRgbOsBs0FtKqpK+C2bZSgRMmLwWFZIRw=;
        b=fVWQTIJ3VD535EWfIGu8vqdGrocJw3YRMrYS0jGsznoyExvOjlEMHTHTpQFYZPLoZK
         385U/CAFr6loTz10s3Wi0zxFBUnXNJjLpJfOaP6poOsYyXV51WT68BypnYPiCT07Ouu2
         rZXwOhLJynRzcoOByO7IAImSQrOwK7h+iKojKhUf2VvIqn7k5oL0kQ+nVBd6twvHC6k5
         ST+CprQgsRL7DngAzI2Po/ziAhIpcGFD7ECHQLSh1fPy1WbFC0QeoMUCuAnSXj6q/OYA
         bCMxn5RyaEXsjadEy50nCZlKazWsPaxbM7lw8BwEm/DCv1e+8rTl0CaJFRFeQOt1HJed
         JuLg==
X-Gm-Message-State: APjAAAXe6pROJ2UUEGU3bUoVdJTOYdskssgGGOH1k/7sgDj5KdRVzV/B
        81AWTqqHw42JbRkPZxmnxL7dxA==
X-Google-Smtp-Source: APXvYqykIHiICYqDETHsqr98rlEaUSUjEQi/PLKCwnevGFD6S6IIr365ComFOM8ZRnUCLO1NSwgH5A==
X-Received: by 2002:a63:3e03:: with SMTP id l3mr41344370pga.118.1579204295555;
        Thu, 16 Jan 2020 11:51:35 -0800 (PST)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id fa21sm4571804pjb.17.2020.01.16.11.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 11:51:34 -0800 (PST)
Date:   Thu, 16 Jan 2020 11:51:29 -0800
From:   Benson Leung <bleung@google.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     enric.balletbo@collabora.com, groeck@chromium.org,
        bleung@chromium.org, lee.jones@linaro.org, sre@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Jon Flatley <jflat@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH v6 1/3] platform: chrome: Add cros-usbpd-notify driver
Message-ID: <20200116195129.GD208460@google.com>
References: <20200114232219.93171-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
Content-Disposition: inline
In-Reply-To: <20200114232219.93171-1-pmalani@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2020 at 03:22:18PM -0800, Prashant Malani wrote:
> From: Jon Flatley <jflat@chromium.org>
>=20
> ChromiumOS uses ACPI device with HID "GOOG0003" for power delivery
> related events. The existing cros-usbpd-charger driver relies on these
> events without ever actually receiving them on ACPI platforms. This is
> because in the ChromeOS kernel trees, the GOOG0003 device is owned by an
> ACPI driver that offers firmware updates to USB-C chargers.
>=20
> Introduce a new platform driver under cros-ec, the ChromeOS embedded
> controller, that handles these PD events and dispatches them
> appropriately over a notifier chain to all drivers that use them.
>=20
> On platforms that don't have the ACPI device defined, the driver gets
> instantiated for ECs which support the EC_FEATURE_USB_PD feature bit,
> and the notification events will get delivered using the MKBP event
> handling mechanism.
>=20
> Co-Developed-by: Prashant Malani <pmalani@chromium.org>
> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Jon Flatley <jflat@chromium.org>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Minor nit, otherwise,
Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
>=20
> Changes in v6(pmalani@chromium.org):
> - Fix build error from typo in cros_usbpd_notify_acpi_device_ids
>   variable name.
>=20
> Changes in v5(pmalani@chromium.org):
> - Split the driver into platform and ACPI variants, each enclosed by
>   CONFIG_OF and CONFIG_ACPI #ifdefs respectively.
> - Updated the copyright year to 2020.
> - Reworded the commit message and Kconfig description to incorporate
>   the modified driver structure.
>=20
> Changes in v4(pmalani@chromium.org):
> - No code changes, but added new version so that versioning is
>   consistent with the next patch in the series.
>=20
> Changes in v3 (pmalani@chromium.org):
> - Renamed driver and files from "cros_ec_pd_notify" to
>   "cros_usbpd_notify" to be more consistent with other naming.
> - Moved the change to include cros-usbpd-notify in the charger MFD
>   into a separate follow-on patch.
>=20
> Changes in v2 (pmalani@chromium.org):
> - Removed dependency on DT entry; instead, we will instantiate
>   the driver on detecting EC_FEATURE_USB_PD for non-ACPI platforms.
> - Modified the cros-ec-pd-notify device to be an mfd_cell under
>   usbpdcharger for non-ACPI platforms. Altered the platform_probe() call
>   to derive the cros EC structs appropriately.
> - Replaced "usbpd_notify" with "pd_notify" in functions and structures.
> - Addressed comments from upstream maintainer.
>=20
>  drivers/platform/chrome/Kconfig               |  10 ++
>  drivers/platform/chrome/Makefile              |   1 +
>  drivers/platform/chrome/cros_usbpd_notify.c   | 153 ++++++++++++++++++
>  .../linux/platform_data/cros_usbpd_notify.h   |  17 ++
>  4 files changed, 181 insertions(+)
>  create mode 100644 drivers/platform/chrome/cros_usbpd_notify.c
>  create mode 100644 include/linux/platform_data/cros_usbpd_notify.h
>=20
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kc=
onfig
> index 5f57282a28da0..89df6c991089d 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -226,6 +226,16 @@ config CROS_USBPD_LOGGER
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called cros_usbpd_logger.
> =20
> +config CROS_USBPD_NOTIFY
> +	tristate "ChromeOS Type-C power delivery event notifier"
> +	depends on CROS_EC
> +	help
> +	  If you say Y here, you get support for Type-C PD event notifications
> +	  from the ChromeOS EC. On ACPI platorms this driver will bind to the
> +	  GOOG0003 ACPI device, and on platforms which don't have this device it
> +	  will get initialized on ECs which support the feature
> +	  EC_FEATURE_USB_PD.
> +
>  source "drivers/platform/chrome/wilco_ec/Kconfig"
> =20
>  endif # CHROMEOS_PLATFORMS
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/M=
akefile
> index aacd5920d8a18..f6465f8ef0b5e 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -22,5 +22,6 @@ obj-$(CONFIG_CROS_EC_DEBUGFS)		+=3D cros_ec_debugfs.o
>  obj-$(CONFIG_CROS_EC_SENSORHUB)		+=3D cros_ec_sensorhub.o
>  obj-$(CONFIG_CROS_EC_SYSFS)		+=3D cros_ec_sysfs.o
>  obj-$(CONFIG_CROS_USBPD_LOGGER)		+=3D cros_usbpd_logger.o
> +obj-$(CONFIG_CROS_USBPD_NOTIFY)		+=3D cros_usbpd_notify.o
> =20
>  obj-$(CONFIG_WILCO_EC)			+=3D wilco_ec/
> diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platfo=
rm/chrome/cros_usbpd_notify.c
> new file mode 100644
> index 0000000000000..858e494995843
> --- /dev/null
> +++ b/drivers/platform/chrome/cros_usbpd_notify.c
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2020 Google LLC
> + *
> + * This driver serves as the receiver of cros_ec PD host events.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/module.h>
> +#include <linux/mfd/cros_ec.h>
> +#include <linux/platform_data/cros_ec_commands.h>
> +#include <linux/platform_data/cros_usbpd_notify.h>

Same nit as other: Alphabetize #include list.

> +#include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/platform_device.h>
> +
> +#define DRV_NAME "cros-usbpd-notify"
> +#define ACPI_DRV_NAME "GOOG0003"
> +
> +static BLOCKING_NOTIFIER_HEAD(cros_usbpd_notifier_list);
> +
> +/**
> + * cros_usbpd_register_notify - Register a notifier callback for PD even=
ts.
> + * @nb: Notifier block pointer to register
> + *
> + * On ACPI platforms this corresponds to host events on the ECPD
> + * "GOOG0003" ACPI device. On non-ACPI platforms this will filter mkbp e=
vents
> + * for USB PD events.
> + *
> + * Return: 0 on success or negative error code.
> + */
> +int cros_usbpd_register_notify(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(
> +			&cros_usbpd_notifier_list, nb);
> +}
> +EXPORT_SYMBOL_GPL(cros_usbpd_register_notify);
> +
> +
> +/**
> + * cros_usbpd_unregister_notify - Unregister notifier callback for PD ev=
ents.
> + * @nb: Notifier block pointer to unregister
> + *
> + * Unregister a notifier callback that was previously registered with
> + * cros_usbpd_register_notify().
> + */
> +void cros_usbpd_unregister_notify(struct notifier_block *nb)
> +{
> +	blocking_notifier_chain_unregister(&cros_usbpd_notifier_list, nb);
> +}
> +EXPORT_SYMBOL_GPL(cros_usbpd_unregister_notify);
> +
> +#ifdef CONFIG_ACPI
> +
> +static int cros_usbpd_notify_add_acpi(struct acpi_device *adev)
> +{
> +	return 0;
> +}
> +
> +static void cros_usbpd_notify_acpi(struct acpi_device *adev, u32 event)
> +{
> +	blocking_notifier_call_chain(&cros_usbpd_notifier_list, event, NULL);
> +}
> +
> +static const struct acpi_device_id cros_usbpd_notify_acpi_device_ids[] =
=3D {
> +	{ ACPI_DRV_NAME, 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, cros_usbpd_notify_acpi_device_ids);
> +
> +static struct acpi_driver cros_usbpd_notify_acpi_driver =3D {
> +	.name =3D DRV_NAME,
> +	.class =3D DRV_NAME,
> +	.ids =3D cros_usbpd_notify_acpi_device_ids,
> +	.ops =3D {
> +		.add =3D cros_usbpd_notify_add_acpi,
> +		.notify =3D cros_usbpd_notify_acpi,
> +	},
> +};
> +module_acpi_driver(cros_usbpd_notify_acpi_driver);
> +
> +#endif /* CONFIG_ACPI */
> +
> +#ifdef CONFIG_OF
> +
> +static int cros_usbpd_notify_plat(struct notifier_block *nb,
> +		unsigned long queued_during_suspend, void *data)
> +{
> +	struct cros_ec_device *ec_dev =3D (struct cros_ec_device *)data;
> +	u32 host_event =3D cros_ec_get_host_event(ec_dev);
> +
> +	if (!host_event)
> +		return NOTIFY_BAD;
> +
> +	if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
> +		blocking_notifier_call_chain(&cros_usbpd_notifier_list,
> +				host_event, NULL);
> +		return NOTIFY_OK;
> +	}
> +	return NOTIFY_DONE;
> +}
> +
> +static int cros_usbpd_notify_probe_plat(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct cros_ec_dev *ecdev =3D dev_get_drvdata(dev->parent);
> +	struct notifier_block *nb;
> +	int ret;
> +
> +	nb =3D devm_kzalloc(dev, sizeof(*nb), GFP_KERNEL);
> +	if (!nb)
> +		return -ENOMEM;
> +
> +	nb->notifier_call =3D cros_usbpd_notify_plat;
> +	dev_set_drvdata(dev, nb);
> +
> +	ret =3D blocking_notifier_chain_register(&ecdev->ec_dev->event_notifier,
> +						nb);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to register notifier\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cros_usbpd_notify_remove_plat(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct cros_ec_dev *ecdev =3D dev_get_drvdata(dev->parent);
> +	struct notifier_block *nb =3D
> +		(struct notifier_block *)dev_get_drvdata(dev);
> +
> +	blocking_notifier_chain_unregister(&ecdev->ec_dev->event_notifier,
> +			nb);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver cros_usbpd_notify_plat_driver =3D {
> +	.driver =3D {
> +		.name =3D DRV_NAME,
> +	},
> +	.probe =3D cros_usbpd_notify_probe_plat,
> +	.remove =3D cros_usbpd_notify_remove_plat,
> +};
> +module_platform_driver(cros_usbpd_notify_plat_driver);
> +
> +#endif /* CONFIG_OF */
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("ChromeOS power delivery notifier device");
> +MODULE_AUTHOR("Jon Flatley <jflat@chromium.org>");
> +MODULE_ALIAS("platform:" DRV_NAME);
> diff --git a/include/linux/platform_data/cros_usbpd_notify.h b/include/li=
nux/platform_data/cros_usbpd_notify.h
> new file mode 100644
> index 0000000000000..4f2791722b6d3
> --- /dev/null
> +++ b/include/linux/platform_data/cros_usbpd_notify.h
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ChromeOS EC Power Delivery Notifier Driver
> + *
> + * Copyright 2020 Google LLC
> + */
> +
> +#ifndef __LINUX_PLATFORM_DATA_CROS_USBPD_NOTIFY_H
> +#define __LINUX_PLATFORM_DATA_CROS_USBPD_NOTIFY_H
> +
> +#include <linux/notifier.h>
> +
> +int cros_usbpd_register_notify(struct notifier_block *nb);
> +
> +void cros_usbpd_unregister_notify(struct notifier_block *nb);
> +
> +#endif  /* __LINUX_PLATFORM_DATA_CROS_USBPD_NOTIFY_H */
> --=20
> 2.25.0.341.g760bfbb309-goog
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXiC+wQAKCRBzbaomhzOw
wuN3AQDB4Q1NmuP+t8X4OizjnyRzUk9VBJVkoynrO5XKn7/SqgD/YZ3TvXxhLxNq
d7qveRMcSkrAreryhqfg9GlJQJRagA8=
=gH1s
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--
