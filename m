Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8262614A9FC
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2020 19:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgA0Soq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jan 2020 13:44:46 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44527 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgA0Soq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jan 2020 13:44:46 -0500
Received: by mail-pg1-f196.google.com with SMTP id x7so5578140pgl.11
        for <linux-pm@vger.kernel.org>; Mon, 27 Jan 2020 10:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6UB5lr6NPGdBP9FvcQfLVVaNejuLiA0R7+VhaSBgfkw=;
        b=Y2iWT6EkrNgCX1aeOptlJwBcDXYdBQS1ZBTklWGhvEzvwN4K10hb0OmMyi7vzi9cUc
         vwVDCrylBN7mpJcyOnO4StbNXxfSOr2T4K0ciVWQvnI6N7ZYDYe330CREHHO5Ts2focn
         jhcXp0CJqPXVIW+1sy0MhzD/D5aiTDP7Ct5JeBZTlhxC4NhLhaD1sDDg7A6vTOvTIn91
         4YSdOXUAqO4+gPPmLdnEK2XORBPRm4JkqL6k1LioURf72e+jZLVSvNwQZ3C7fU5krMyG
         rGsT7Su9UKRP/aO7zWscsH6MJyKNPYHI5v7FA8F/cDyUndr5cfKHhvmcQ1bqiBHwtbzD
         2oTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6UB5lr6NPGdBP9FvcQfLVVaNejuLiA0R7+VhaSBgfkw=;
        b=UTtUuvIpyLyrhrh0twn6ml/ti0tDWjAD0cSfZX6+N6s/UKrqolWVRdfkhJAd12eK/0
         NU7jGr1OWeC6sQRSH3ZAnDL/8euzrVWUzL94+NpaMq/xrIYuDrYQnH4ZPSkCg0CsLxy2
         8zzInFXlbhsgH+sTb1r8ViTi+AG7as+J6ZLpomt2BsmHv/aRf+mv5+X+f2e7HFp61Nfy
         LhddASUC5zhFLzIOwkVcjeEL1PX6NltS4AiEOzc3/5OlxQ1wmjIi143ipHTXQBwbduci
         0j7i0mnFvH8ey0hb1JV4YQJ8V5GJvNEhZdr8I9tXe7xSbybTOJL6YimGALHtBZQv9svt
         i0Cw==
X-Gm-Message-State: APjAAAXOI85HkFoIzqIMfvT+CwAP3IaYJxQzsssKT5QvB7gIq1TMgK8c
        39Fp++d+DaPet2ptONksOkdwjA==
X-Google-Smtp-Source: APXvYqyEK/MScE38jd9xnSV7/ojs3Ig+mFbKJchjBhBz7xKC/z9M7wzJY+5kH4CojaL9atx22MQxVA==
X-Received: by 2002:a63:1f0c:: with SMTP id f12mr21509946pgf.247.1580150684733;
        Mon, 27 Jan 2020 10:44:44 -0800 (PST)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id r145sm6585324pfr.5.2020.01.27.10.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 10:44:43 -0800 (PST)
Date:   Mon, 27 Jan 2020 10:44:39 -0800
From:   Benson Leung <bleung@google.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Prashant Malani <pmalani@chromium.org>, groeck@chromium.org,
        bleung@chromium.org, lee.jones@linaro.org, sre@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Jon Flatley <jflat@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH v8 1/4] platform: chrome: Add cros-usbpd-notify driver
Message-ID: <20200127184439.GA150048@google.com>
References: <20200124231834.63628-1-pmalani@chromium.org>
 <adcf2a99-d6d8-cd4e-e22d-9ce539d87b7f@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <adcf2a99-d6d8-cd4e-e22d-9ce539d87b7f@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2020 at 03:58:42PM +0100, Enric Balletbo i Serra wrote:
> Hi Prashant,
>=20
> On 25/1/20 0:18, Prashant Malani wrote:
> > From: Jon Flatley <jflat@chromium.org>
> >=20
> > ChromiumOS uses ACPI device with HID "GOOG0003" for power delivery
> > related events. The existing cros-usbpd-charger driver relies on these
> > events without ever actually receiving them on ACPI platforms. This is
> > because in the ChromeOS kernel trees, the GOOG0003 device is owned by an
> > ACPI driver that offers firmware updates to USB-C chargers.
> >=20
> > Introduce a new platform driver under cros-ec, the ChromeOS embedded
> > controller, that handles these PD events and dispatches them
> > appropriately over a notifier chain to all drivers that use them.
> >=20
> > On platforms that don't have the ACPI device defined, the driver gets
> > instantiated for ECs which support the EC_FEATURE_USB_PD feature bit,
> > and the notification events will get delivered using the MKBP event
> > handling mechanism.
> >=20
> > Co-Developed-by: Prashant Malani <pmalani@chromium.org>
> > Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> > Reviewed-by: Benson Leung <bleung@chromium.org>
> > Signed-off-by: Jon Flatley <jflat@chromium.org>
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > ---
> >=20
>=20
> Just a nit below but for my own reference:
>=20
> Acked-for-chrome-platform: Enric Balletbo i Serra <enric.balletbo@collabo=
ra.com>
>=20
> I am not sure if we're on time to get this merged on this merge window, t=
hough.

I'm OK with creating a branch for this series and merging it into
chrome-platform-5.7 once Linus releases v5.6-rc1 late next week.

>=20
> Thanks,
>  Enric
>=20
> > Changes in v8(pmalani@chromium.org):
> > - Fix style nits.
> > - Remove unrequired header.
> > - Remove #ifdef CONFIG_OF dependency for platform driver registration.
> > - Add module compile text to Kconfig help section.
> >=20
> > Changes in v7(pmalani@chromium.org):
> > - Removed use of module_platform_driver() and module_acpi_driver() since
> >   that was causing redefinition compilation errors on arm64 defconfig.
> >   Instead, explicitly defined the init and exit routines and
> >   register/unregister the platform and ACPI drivers there.
> > - Alphabetize #include header.
> >=20
> > Changes in v6(pmalani@chromium.org):
> > - Fix build error from typo in cros_usbpd_notify_acpi_device_ids
> >   variable name.
> >=20
> > Changes in v5(pmalani@chromium.org):
> > - Split the driver into platform and ACPI variants, each enclosed by
> >   CONFIG_OF and CONFIG_ACPI #ifdefs respectively.
> > - Updated the copyright year to 2020.
> > - Reworded the commit message and Kconfig description to incorporate
> >   the modified driver structure.
> >=20
> > Changes in v4(pmalani@chromium.org):
> > - No code changes, but added new version so that versioning is
> >   consistent with the next patch in the series.
> >=20
> > Changes in v3 (pmalani@chromium.org):
> > - Renamed driver and files from "cros_ec_pd_notify" to
> >   "cros_usbpd_notify" to be more consistent with other naming.
> > - Moved the change to include cros-usbpd-notify in the charger MFD
> >   into a separate follow-on patch.
> >=20
> > Changes in v2 (pmalani@chromium.org):
> > - Removed dependency on DT entry; instead, we will instantiate
> >   the driver on detecting EC_FEATURE_USB_PD for non-ACPI platforms.
> > - Modified the cros-ec-pd-notify device to be an mfd_cell under
> >   usbpdcharger for non-ACPI platforms. Altered the platform_probe() call
> >   to derive the cros EC structs appropriately.
> > - Replaced "usbpd_notify" with "pd_notify" in functions and structures.
> > - Addressed comments from upstream maintainer.
> >=20
> >  drivers/platform/chrome/Kconfig               |  13 ++
> >  drivers/platform/chrome/Makefile              |   1 +
> >  drivers/platform/chrome/cros_usbpd_notify.c   | 170 ++++++++++++++++++
> >  .../linux/platform_data/cros_usbpd_notify.h   |  17 ++
> >  4 files changed, 201 insertions(+)
> >  create mode 100644 drivers/platform/chrome/cros_usbpd_notify.c
> >  create mode 100644 include/linux/platform_data/cros_usbpd_notify.h
> >=20
> > diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/=
Kconfig
> > index 5f57282a28da0..e45e0fe057586 100644
> > --- a/drivers/platform/chrome/Kconfig
> > +++ b/drivers/platform/chrome/Kconfig
> > @@ -226,6 +226,19 @@ config CROS_USBPD_LOGGER
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called cros_usbpd_logger.
> > =20
> > +config CROS_USBPD_NOTIFY
> > +	tristate "ChromeOS Type-C power delivery event notifier"
> > +	depends on CROS_EC
>=20
> Like other cros-ec subdevices I am wondering if we should depend on
> MFD_CROS_EC_DEV instead of CROS_EC (as doesn't really makes sense to only
> depends on CROS_EC)
>=20
> Also, like other cros-ec subdevices, we might be interested on have a:
>=20
>        default MFD_CROS_EC_DEV
>=20
> So it is selected when the cros-ec dev is configured by default.
>=20
> Thanks,
>=20
>  Enric
>=20
> > +	help
> > +	  If you say Y here, you get support for Type-C PD event notifications
> > +	  from the ChromeOS EC. On ACPI platorms this driver will bind to the
> > +	  GOOG0003 ACPI device, and on platforms which don't have this device=
 it
> > +	  will get initialized on ECs which support the feature
> > +	  EC_FEATURE_USB_PD.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called cros_usbpd_notify.
> > +
> >  source "drivers/platform/chrome/wilco_ec/Kconfig"
> > =20
> >  endif # CHROMEOS_PLATFORMS
> > diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome=
/Makefile
> > index aacd5920d8a18..f6465f8ef0b5e 100644
> > --- a/drivers/platform/chrome/Makefile
> > +++ b/drivers/platform/chrome/Makefile
> > @@ -22,5 +22,6 @@ obj-$(CONFIG_CROS_EC_DEBUGFS)		+=3D cros_ec_debugfs.o
> >  obj-$(CONFIG_CROS_EC_SENSORHUB)		+=3D cros_ec_sensorhub.o
> >  obj-$(CONFIG_CROS_EC_SYSFS)		+=3D cros_ec_sysfs.o
> >  obj-$(CONFIG_CROS_USBPD_LOGGER)		+=3D cros_usbpd_logger.o
> > +obj-$(CONFIG_CROS_USBPD_NOTIFY)		+=3D cros_usbpd_notify.o
> > =20
> >  obj-$(CONFIG_WILCO_EC)			+=3D wilco_ec/
> > diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/plat=
form/chrome/cros_usbpd_notify.c
> > new file mode 100644
> > index 0000000000000..6ead5c62b3c5f
> > --- /dev/null
> > +++ b/drivers/platform/chrome/cros_usbpd_notify.c
> > @@ -0,0 +1,170 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright 2020 Google LLC
> > + *
> > + * This driver serves as the receiver of cros_ec PD host events.
> > + */
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/module.h>
> > +#include <linux/mfd/cros_ec.h>
> > +#include <linux/platform_data/cros_ec_proto.h>
> > +#include <linux/platform_data/cros_usbpd_notify.h>
> > +#include <linux/platform_device.h>
> > +
> > +#define DRV_NAME "cros-usbpd-notify"
> > +#define ACPI_DRV_NAME "GOOG0003"
> > +
> > +static BLOCKING_NOTIFIER_HEAD(cros_usbpd_notifier_list);
> > +
> > +/**
> > + * cros_usbpd_register_notify - Register a notifier callback for PD ev=
ents.
> > + * @nb: Notifier block pointer to register
> > + *
> > + * On ACPI platforms this corresponds to host events on the ECPD
> > + * "GOOG0003" ACPI device. On non-ACPI platforms this will filter mkbp=
 events
> > + * for USB PD events.
> > + *
> > + * Return: 0 on success or negative error code.
> > + */
> > +int cros_usbpd_register_notify(struct notifier_block *nb)
> > +{
> > +	return blocking_notifier_chain_register(&cros_usbpd_notifier_list,
> > +						nb);
> > +}
> > +EXPORT_SYMBOL_GPL(cros_usbpd_register_notify);
> > +
> > +/**
> > + * cros_usbpd_unregister_notify - Unregister notifier callback for PD =
events.
> > + * @nb: Notifier block pointer to unregister
> > + *
> > + * Unregister a notifier callback that was previously registered with
> > + * cros_usbpd_register_notify().
> > + */
> > +void cros_usbpd_unregister_notify(struct notifier_block *nb)
> > +{
> > +	blocking_notifier_chain_unregister(&cros_usbpd_notifier_list, nb);
> > +}
> > +EXPORT_SYMBOL_GPL(cros_usbpd_unregister_notify);
> > +
> > +#ifdef CONFIG_ACPI
> > +
> > +static int cros_usbpd_notify_add_acpi(struct acpi_device *adev)
> > +{
> > +	return 0;
> > +}
> > +
> > +static void cros_usbpd_notify_acpi(struct acpi_device *adev, u32 event)
> > +{
> > +	blocking_notifier_call_chain(&cros_usbpd_notifier_list, event, NULL);
> > +}
> > +
> > +static const struct acpi_device_id cros_usbpd_notify_acpi_device_ids[]=
 =3D {
> > +	{ ACPI_DRV_NAME, 0 },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(acpi, cros_usbpd_notify_acpi_device_ids);
> > +
> > +static struct acpi_driver cros_usbpd_notify_acpi_driver =3D {
> > +	.name =3D DRV_NAME,
> > +	.class =3D DRV_NAME,
> > +	.ids =3D cros_usbpd_notify_acpi_device_ids,
> > +	.ops =3D {
> > +		.add =3D cros_usbpd_notify_add_acpi,
> > +		.notify =3D cros_usbpd_notify_acpi,
> > +	},
> > +};
> > +
> > +#endif /* CONFIG_ACPI */
> > +
> > +static int cros_usbpd_notify_plat(struct notifier_block *nb,
> > +				  unsigned long queued_during_suspend,
> > +				  void *data)
> > +{
> > +	struct cros_ec_device *ec_dev =3D (struct cros_ec_device *)data;
> > +	u32 host_event =3D cros_ec_get_host_event(ec_dev);
> > +
> > +	if (!host_event)
> > +		return NOTIFY_BAD;
> > +
> > +	if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
> > +		blocking_notifier_call_chain(&cros_usbpd_notifier_list,
> > +					     host_event, NULL);
> > +		return NOTIFY_OK;
> > +	}
> > +	return NOTIFY_DONE;
> > +}
> > +
> > +static int cros_usbpd_notify_probe_plat(struct platform_device *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct cros_ec_dev *ecdev =3D dev_get_drvdata(dev->parent);
> > +	struct notifier_block *nb;
> > +	int ret;
> > +
> > +	nb =3D devm_kzalloc(dev, sizeof(*nb), GFP_KERNEL);
> > +	if (!nb)
> > +		return -ENOMEM;
> > +
> > +	nb->notifier_call =3D cros_usbpd_notify_plat;
> > +	dev_set_drvdata(dev, nb);
> > +
> > +	ret =3D blocking_notifier_chain_register(&ecdev->ec_dev->event_notifi=
er,
> > +					       nb);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Failed to register notifier\n");
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int cros_usbpd_notify_remove_plat(struct platform_device *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct cros_ec_dev *ecdev =3D dev_get_drvdata(dev->parent);
> > +	struct notifier_block *nb =3D
> > +		(struct notifier_block *)dev_get_drvdata(dev);
> > +
> > +	blocking_notifier_chain_unregister(&ecdev->ec_dev->event_notifier, nb=
);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct platform_driver cros_usbpd_notify_plat_driver =3D {
> > +	.driver =3D {
> > +		.name =3D DRV_NAME,
> > +	},
> > +	.probe =3D cros_usbpd_notify_probe_plat,
> > +	.remove =3D cros_usbpd_notify_remove_plat,
> > +};
> > +
> > +static int __init cros_usbpd_notify_init(void)
> > +{
> > +	int ret;
> > +
> > +	ret =3D platform_driver_register(&cros_usbpd_notify_plat_driver);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +#ifdef CONFIG_ACPI
> > +	acpi_bus_register_driver(&cros_usbpd_notify_acpi_driver);
> > +#endif
> > +	return 0;
> > +}
> > +
> > +static void __exit cros_usbpd_notify_exit(void)
> > +{
> > +#ifdef CONFIG_ACPI
> > +	acpi_bus_unregister_driver(&cros_usbpd_notify_acpi_driver);
> > +#endif
> > +	platform_driver_unregister(&cros_usbpd_notify_plat_driver);
> > +}
> > +
> > +module_init(cros_usbpd_notify_init);
> > +module_exit(cros_usbpd_notify_exit);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_DESCRIPTION("ChromeOS power delivery notifier device");
> > +MODULE_AUTHOR("Jon Flatley <jflat@chromium.org>");
> > +MODULE_ALIAS("platform:" DRV_NAME);
> > diff --git a/include/linux/platform_data/cros_usbpd_notify.h b/include/=
linux/platform_data/cros_usbpd_notify.h
> > new file mode 100644
> > index 0000000000000..4f2791722b6d3
> > --- /dev/null
> > +++ b/include/linux/platform_data/cros_usbpd_notify.h
> > @@ -0,0 +1,17 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * ChromeOS EC Power Delivery Notifier Driver
> > + *
> > + * Copyright 2020 Google LLC
> > + */
> > +
> > +#ifndef __LINUX_PLATFORM_DATA_CROS_USBPD_NOTIFY_H
> > +#define __LINUX_PLATFORM_DATA_CROS_USBPD_NOTIFY_H
> > +
> > +#include <linux/notifier.h>
> > +
> > +int cros_usbpd_register_notify(struct notifier_block *nb);
> > +
> > +void cros_usbpd_unregister_notify(struct notifier_block *nb);
> > +
> > +#endif  /* __LINUX_PLATFORM_DATA_CROS_USBPD_NOTIFY_H */
> >=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXi8vlwAKCRBzbaomhzOw
wl8UAQCgsSvYLuQSgyf5h/iiQElpGIUgnZcUUiF2uLTHKqDsBAEArr8NdFolocqS
R8JybsOst7F2kdTIOkDDk3wbque8sgc=
=5AtN
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
