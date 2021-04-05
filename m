Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CABA35438F
	for <lists+linux-pm@lfdr.de>; Mon,  5 Apr 2021 17:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238058AbhDEPrk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Apr 2021 11:47:40 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60100 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237828AbhDEPrj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Apr 2021 11:47:39 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 67B461F4485F
Received: by earth.universe (Postfix, from userid 1000)
        id 9D50A3C0C96; Mon,  5 Apr 2021 17:47:30 +0200 (CEST)
Date:   Mon, 5 Apr 2021 17:47:30 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: Add AC driver for Surface Aggregator
 Module
Message-ID: <20210405154730.3ezemy7jcnmooget@earth.universe>
References: <20210309000530.2165752-1-luzmaximilian@gmail.com>
 <20210309000530.2165752-3-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="meea2yzlgltwcg7w"
Content-Disposition: inline
In-Reply-To: <20210309000530.2165752-3-luzmaximilian@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--meea2yzlgltwcg7w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 09, 2021 at 01:05:30AM +0100, Maximilian Luz wrote:
> On newer Microsoft Surface models (specifically 7th-generation, i.e.
> Surface Pro 7, Surface Book 3, Surface Laptop 3, and Surface Laptop Go),
> battery and AC status/information is no longer handled via standard ACPI
> devices, but instead directly via the Surface System Aggregator Module
> (SSAM), i.e. the embedded controller on those devices.
>=20
> While on previous generation models, AC status is also handled via SSAM,
> an ACPI shim was present to translate the standard ACPI AC interface to
> SSAM requests. The SSAM interface itself, which is modeled closely after
> the ACPI interface, has not changed.
>=20
> This commit introduces a new SSAM client device driver to support AC
> status/information via the aforementioned interface on said Surface
> models.
>=20
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> ---
>=20
> Note: This patch depends on the
>=20
>     platform/surface: Add Surface Aggregator device registry
>=20
> series. More specifically patch
>=20
>     platform/surface: Set up Surface Aggregator device registry
>=20
> The full series has been merged into the for-next branch of the
> platform-drivers-x86 tree [1]. The commit in question can be found at
> [2].
>=20
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drive=
rs-x86.git/log/?h=3Dfor-next
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drive=
rs-x86.git/commit/?h=3Dfor-next&id=3Dfc622b3d36e6d91330fb21506b9ad1e3206a4d=
de
>=20
> ---
>  MAINTAINERS                            |   1 +
>  drivers/power/supply/Kconfig           |  16 ++
>  drivers/power/supply/Makefile          |   1 +
>  drivers/power/supply/surface_charger.c | 296 +++++++++++++++++++++++++
>  4 files changed, 314 insertions(+)
>  create mode 100644 drivers/power/supply/surface_charger.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f44521abe8bf..d6651ba93997 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11867,6 +11867,7 @@ L:	linux-pm@vger.kernel.org
>  L:	platform-driver-x86@vger.kernel.org
>  S:	Maintained
>  F:	drivers/power/supply/surface_battery.c
> +F:	drivers/power/supply/surface_charger.c
> =20
>  MICROSOFT SURFACE GPE LID SUPPORT DRIVER
>  M:	Maximilian Luz <luzmaximilian@gmail.com>
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index cebeff10d543..91f7cf425ac9 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -817,4 +817,20 @@ config BATTERY_SURFACE
>  	  Microsoft Surface devices, i.e. Surface Pro 7, Surface Laptop 3,
>  	  Surface Book 3, and Surface Laptop Go.
> =20
> +config CHARGER_SURFACE
> +	tristate "AC driver for 7th-generation Microsoft Surface devices"
> +	depends on SURFACE_AGGREGATOR_REGISTRY
> +	help
> +	  Driver for AC devices connected via/managed by the Surface System
> +	  Aggregator Module (SSAM).
> +
> +	  This driver provides AC-information and -status support for Surface
> +	  devices where said data is not exposed via the standard ACPI devices.
> +	  On those models (7th-generation), AC-information is instead handled
> +	  directly via a SSAM client device and this driver.
> +
> +	  Say M or Y here to include AC status support for 7th-generation
> +	  Microsoft Surface devices, i.e. Surface Pro 7, Surface Laptop 3,
> +	  Surface Book 3, and Surface Laptop Go.
> +
>  endif # POWER_SUPPLY
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 134041538d2c..a7309a3d1a47 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -102,3 +102,4 @@ obj-$(CONFIG_CHARGER_WILCO)	+=3D wilco-charger.o
>  obj-$(CONFIG_RN5T618_POWER)	+=3D rn5t618_power.o
>  obj-$(CONFIG_BATTERY_ACER_A500)	+=3D acer_a500_battery.o
>  obj-$(CONFIG_BATTERY_SURFACE)	+=3D surface_battery.o
> +obj-$(CONFIG_CHARGER_SURFACE)	+=3D surface_charger.o
> diff --git a/drivers/power/supply/surface_charger.c b/drivers/power/suppl=
y/surface_charger.c
> new file mode 100644
> index 000000000000..fe484523a2c2
> --- /dev/null
> +++ b/drivers/power/supply/surface_charger.c
> @@ -0,0 +1,296 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * AC driver for 7th-generation Microsoft Surface devices via Surface Sy=
stem
> + * Aggregator Module (SSAM).
> + *
> + * Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
> + */
> +
> +#include <asm/unaligned.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/power_supply.h>
> +#include <linux/types.h>
> +
> +#include <linux/surface_aggregator/device.h>
> +
> +
> +/* -- SAM interface. ---------------------------------------------------=
----- */
> +
> +enum sam_event_cid_bat {
> +	SAM_EVENT_CID_BAT_ADP   =3D 0x17,
> +};
> +
> +enum sam_battery_sta {
> +	SAM_BATTERY_STA_OK      =3D 0x0f,
> +	SAM_BATTERY_STA_PRESENT	=3D 0x10,
> +};
> +
> +/* Get battery status (_STA). */
> +SSAM_DEFINE_SYNC_REQUEST_CL_R(ssam_bat_get_sta, __le32, {
> +	.target_category =3D SSAM_SSH_TC_BAT,
> +	.command_id      =3D 0x01,
> +});
> +
> +/* Get platform power source for battery (_PSR / DPTF PSRC). */
> +SSAM_DEFINE_SYNC_REQUEST_CL_R(ssam_bat_get_psrc, __le32, {
> +	.target_category =3D SSAM_SSH_TC_BAT,
> +	.command_id      =3D 0x0d,
> +});
> +
> +
> +/* -- Device structures. -----------------------------------------------=
----- */
> +
> +struct spwr_psy_properties {
> +	const char *name;
> +	struct ssam_event_registry registry;
> +};
> +
> +struct spwr_ac_device {
> +	struct ssam_device *sdev;
> +
> +	char name[32];
> +	struct power_supply *psy;
> +	struct power_supply_desc psy_desc;
> +
> +	struct ssam_event_notifier notif;
> +
> +	struct mutex lock;  /* Guards access to state below. */
> +
> +	__le32 state;
> +};
> +
> +
> +/* -- State management. ------------------------------------------------=
----- */
> +
> +static int spwr_ac_update_unlocked(struct spwr_ac_device *ac)
> +{
> +	u32 old =3D ac->state;
> +	int status;
> +
> +	lockdep_assert_held(&ac->lock);
> +
> +	status =3D ssam_retry(ssam_bat_get_psrc, ac->sdev, &ac->state);
> +	if (status < 0)
> +		return status;
> +
> +	return old !=3D ac->state;
> +}
> +
> +static int spwr_ac_update(struct spwr_ac_device *ac)
> +{
> +	int status;
> +
> +	mutex_lock(&ac->lock);
> +	status =3D spwr_ac_update_unlocked(ac);
> +	mutex_unlock(&ac->lock);
> +
> +	return status;
> +}
> +
> +static int spwr_ac_recheck(struct spwr_ac_device *ac)
> +{
> +	int status;
> +
> +	status =3D spwr_ac_update(ac);
> +	if (status > 0)
> +		power_supply_changed(ac->psy);
> +
> +	return status >=3D 0 ? 0 : status;
> +}
> +
> +static u32 spwr_notify_ac(struct ssam_event_notifier *nf, const struct s=
sam_event *event)
> +{
> +	struct spwr_ac_device *ac;
> +	int status;
> +
> +	ac =3D container_of(nf, struct spwr_ac_device, notif);
> +
> +	dev_dbg(&ac->sdev->dev, "power event (cid =3D %#04x, iid =3D %#04x, tid=
 =3D %#04x)\n",
> +		event->command_id, event->instance_id, event->target_id);
> +
> +	/*
> +	 * Allow events of all targets/instances here. Global adapter status
> +	 * seems to be handled via target=3D1 and instance=3D1, but events are
> +	 * reported on all targets/instances in use.
> +	 *
> +	 * While it should be enough to just listen on 1/1, listen everywhere to
> +	 * make sure we don't miss anything.
> +	 */
> +
> +	switch (event->command_id) {
> +	case SAM_EVENT_CID_BAT_ADP:
> +		status =3D spwr_ac_recheck(ac);
> +		return ssam_notifier_from_errno(status) | SSAM_NOTIF_HANDLED;
> +
> +	default:
> +		return 0;
> +	}
> +}
> +
> +
> +/* -- Properties. ------------------------------------------------------=
----- */
> +
> +static enum power_supply_property spwr_ac_props[] =3D {
> +	POWER_SUPPLY_PROP_ONLINE,
> +};
> +
> +static int spwr_ac_get_property(struct power_supply *psy, enum power_sup=
ply_property psp,
> +				union power_supply_propval *val)
> +{
> +	struct spwr_ac_device *ac =3D power_supply_get_drvdata(psy);
> +	int status;
> +
> +	mutex_lock(&ac->lock);
> +
> +	status =3D spwr_ac_update_unlocked(ac);
> +	if (status)
> +		goto out;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		val->intval =3D !!le32_to_cpu(ac->state);
> +		break;
> +
> +	default:
> +		status =3D -EINVAL;
> +		goto out;
> +	}
> +
> +out:
> +	mutex_unlock(&ac->lock);
> +	return status;
> +}
> +
> +
> +/* -- Device setup. ----------------------------------------------------=
----- */
> +
> +static void spwr_ac_init(struct spwr_ac_device *ac, struct ssam_device *=
sdev,
> +			 struct ssam_event_registry registry, const char *name)
> +{
> +	mutex_init(&ac->lock);
> +	strncpy(ac->name, name, ARRAY_SIZE(ac->name) - 1);
> +
> +	ac->sdev =3D sdev;
> +
> +	ac->notif.base.priority =3D 1;
> +	ac->notif.base.fn =3D spwr_notify_ac;
> +	ac->notif.event.reg =3D registry;
> +	ac->notif.event.id.target_category =3D sdev->uid.category;
> +	ac->notif.event.id.instance =3D 0;
> +	ac->notif.event.mask =3D SSAM_EVENT_MASK_NONE;
> +	ac->notif.event.flags =3D SSAM_EVENT_SEQUENCED;
> +
> +	ac->psy_desc.name =3D ac->name;
> +	ac->psy_desc.type =3D POWER_SUPPLY_TYPE_MAINS;
> +	ac->psy_desc.properties =3D spwr_ac_props;
> +	ac->psy_desc.num_properties =3D ARRAY_SIZE(spwr_ac_props);
> +	ac->psy_desc.get_property =3D spwr_ac_get_property;
> +}
> +
> +static void spwr_ac_destroy(struct spwr_ac_device *ac)
> +{
> +	mutex_destroy(&ac->lock);

same as battery driver - use devm_add_action_or_reset or
just drop it. It's not very useful at the end of remove().

> +}

static char *battery_supplied_to[] =3D {
    "BAT1",
    "BAT2",
};

> +static int spwr_ac_register(struct spwr_ac_device *ac)
> +{
> +	struct power_supply_config psy_cfg =3D {};
> +	__le32 sta;
> +	int status;
> +
> +	/* Make sure the device is there and functioning properly. */
> +	status =3D ssam_retry(ssam_bat_get_sta, ac->sdev, &sta);
> +	if (status)
> +		return status;
> +
> +	if ((le32_to_cpu(sta) & SAM_BATTERY_STA_OK) !=3D SAM_BATTERY_STA_OK)
> +		return -ENODEV;
> +
> +	psy_cfg.drv_data =3D ac;

psy_cfg.supplied_to =3D battery_supplied_to;
psy_cfg.num_supplicants =3D 2;

> +	ac->psy =3D power_supply_register(&ac->sdev->dev, &ac->psy_desc, &psy_c=
fg);
> +	if (IS_ERR(ac->psy))
> +		return PTR_ERR(ac->psy);
> +
> +	status =3D ssam_notifier_register(ac->sdev->ctrl, &ac->notif);
> +	if (status)
> +		power_supply_unregister(ac->psy);
> +
> +	return status;
> +}
> +
> +static int spwr_ac_unregister(struct spwr_ac_device *ac)
> +{
> +	ssam_notifier_unregister(ac->sdev->ctrl, &ac->notif);
> +	power_supply_unregister(ac->psy);

This driver can also use devm_power_supply_register :)

> +	return 0;
> +}
> +
> +
> +/* -- Driver setup. ----------------------------------------------------=
----- */
> +
> +static int __maybe_unused surface_ac_resume(struct device *dev)
> +{
> +	return spwr_ac_recheck(dev_get_drvdata(dev));
> +}
> +SIMPLE_DEV_PM_OPS(surface_ac_pm_ops, NULL, surface_ac_resume);
> +
> +static int surface_ac_probe(struct ssam_device *sdev)
> +{
> +	const struct spwr_psy_properties *p;
> +	struct spwr_ac_device *ac;
> +	int status;
> +
> +	p =3D ssam_device_get_match_data(sdev);
> +	if (!p)
> +		return -ENODEV;
> +
> +	ac =3D devm_kzalloc(&sdev->dev, sizeof(*ac), GFP_KERNEL);
> +	if (!ac)
> +		return -ENOMEM;
> +
> +	spwr_ac_init(ac, sdev, p->registry, p->name);
> +	ssam_device_set_drvdata(sdev, ac);
> +
> +	status =3D spwr_ac_register(ac);
> +	if (status)
> +		spwr_ac_destroy(ac);
> +
> +	return status;
> +}
> +
> +static void surface_ac_remove(struct ssam_device *sdev)
> +{
> +	struct spwr_ac_device *ac =3D ssam_device_get_drvdata(sdev);
> +
> +	spwr_ac_unregister(ac);
> +	spwr_ac_destroy(ac);
> +}
> +
> +static const struct spwr_psy_properties spwr_psy_props_adp1 =3D {
> +	.name =3D "ADP1",
> +	.registry =3D SSAM_EVENT_REGISTRY_SAM,
> +};
> +
> +static const struct ssam_device_id surface_ac_match[] =3D {
> +	{ SSAM_SDEV(BAT, 0x01, 0x01, 0x01), (unsigned long)&spwr_psy_props_adp1=
 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(ssam, surface_ac_match);
> +
> +static struct ssam_device_driver surface_ac_driver =3D {
> +	.probe =3D surface_ac_probe,
> +	.remove =3D surface_ac_remove,
> +	.match_table =3D surface_ac_match,
> +	.driver =3D {
> +		.name =3D "surface_ac",
> +		.pm =3D &surface_ac_pm_ops,
> +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +};
> +module_ssam_device_driver(surface_ac_driver);
> +
> +MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
> +MODULE_DESCRIPTION("AC driver for Surface System Aggregator Module");
> +MODULE_LICENSE("GPL");

Otherwise LGTM.

Thanks,

-- Sebastian

--meea2yzlgltwcg7w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBrMRIACgkQ2O7X88g7
+pqjxA//anLYKUvn0LfLXdIgGLqe6J7m2Z36g90S8kTxxAKQ0i7+kv3tojlgeu6b
82kVnyipGbZ6msnEeI/7V1ytVLFdsDv5zSB/da+SxpkYLTVQo2fc8zRl+Smm3kv8
CjOIE2u5WIJRM39ZC9o3yOC4eCyBiiq/F94+WTtM4tlZMkoXUwxxHQoc99b/A93l
XSspuEdQyRXQRFTEEGy+511y0d857oksOAvpe9kSAGzsFCVncXx/oIB2J4yq3odi
dDP26r+nArKrvSZegsZ7wSBeg/U3/DQycinwHZcqQJ4etETzT08UKrSJpSUaAEVv
qyiort5cK0d0rPSy1B6Hn3NV1JzybAx18QvGWWgWrjGWArj05r4h+Cr153mtTIxD
YuvFSQtJYChJ4TAhvA6xY5JmT4OqI29hqFnv8jjIzZTAWMRC9FaIA5poIaqMy9l7
Iimd/bWUIXfE51gGkTOtY1H+tsMHsl6HfhXgCDcJ9q634P5uRICUUC70eqx976LO
H3wwrtpa75HEFeUJKHtioF2tr3l+q24WcRYMeT4UCXZsMGI6X0+DeAsoagliD4iS
2PrzNGNZ7rhz+I5vEVzXIHCQrJhqVRpAY0IGbDWeSX9I0jw7c15s0ZTvXxeLpuWz
v3rdqlH9AhwIgWaccsj9nVTYEqzyvU5kRT/kpngCE7vnw8qYEAc=
=GdNv
-----END PGP SIGNATURE-----

--meea2yzlgltwcg7w--
