Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F0D2F8E1E
	for <lists+linux-pm@lfdr.de>; Sat, 16 Jan 2021 18:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbhAPRFw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 Jan 2021 12:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbhAPQbV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Jan 2021 11:31:21 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72E9C06179A;
        Sat, 16 Jan 2021 05:23:52 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 1765D1F449F0
Received: by earth.universe (Postfix, from userid 1000)
        id 999123C0C94; Sat, 16 Jan 2021 14:23:07 +0100 (CET)
Date:   Sat, 16 Jan 2021 14:23:07 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Daisuke Nojiri <dnojiri@chromium.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, vpalatin@chromium.org,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Sebastian Reichel <sre@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Alex Levin <levinale@google.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Vijay Hiremath <vijay.p.hiremath@intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] power: supply: PCHG: Peripheral device charger
Message-ID: <20210116132307.rh6y3scvzzcpaquu@earth.universe>
References: <20201216163416.2969209-1-dnojiri@chromium.org>
 <20201216182330.GA63657@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vdjnkfduwckvbnr4"
Content-Disposition: inline
In-Reply-To: <20201216182330.GA63657@roeck-us.net>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--vdjnkfduwckvbnr4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

This is mostly meant to forward Guenter's, so that it's recorded
by lore.kernel.org and Daisuke. I only had a quick look myself so
far assuming a new version would appear soon without noticing
Guenter's mail having interesting headers resulting in most people
probably not having received it.

IIUIC this is always reports the battery/charging status of
peripherals and not from the system itself? In that case please also
provide POWER_SUPPLY_PROP_SCOPE and return POWER_SUPPLY_SCOPE_DEVICE.

Also type=3DWireless is meant to be used for wireless/inductive
chargers (e.g. Qi wireless charging). Peripherals set type=3DBattery,
see e.g. drivers/hid/hid-steam.c or drivers/hid/hid-sony.c.

-- Sebastian

On Wed, Dec 16, 2020 at 10:23:30AM -0800, Guenter Roeck wrote:
> On Wed, Dec 16, 2020 at 08:34:15AM -0800, Daisuke Nojiri wrote:
> > This patch adds a driver for PCHG (Peripheral CHarGer). PCHG is a
> > framework managing power supplies for peripheral devices.
> >=20
> > This driver creates a sysfs node for each peripheral charge port:
> >=20
> > 	/sys/class/power_supply/PCHGn
> >=20
> > where <n> is the index of a charge port.
> >=20
> > For example, when a stylus is connected to a NFC/WLC port, the node
> > prints:
> >=20
> > 	/sys/class/power_supply/PCHG0/
> > 		capacity=3D50
> > 		status=3DCharging
> > 		type=3DWireless
> >=20
> > Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
> > ---
> > v1 -> v2
> > * Separate mfd/cros_ec_dev.c
> > * Make CONFIG_CHARGER_CROS_PCHG default to CONFIG_MFD_CROS_EC_DEV
> > ---
> >=20
> >  drivers/power/supply/Kconfig                  |  10 +
> >  drivers/power/supply/Makefile                 |   1 +
> >  .../power/supply/cros_peripheral_charger.c    | 346 ++++++++++++++++++
> >  .../linux/platform_data/cros_ec_commands.h    |  48 +++
> >  4 files changed, 405 insertions(+)
> >  create mode 100644 drivers/power/supply/cros_peripheral_charger.c
> >=20
> > diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> > index eec646c568b7be..407f9fbbc2bb50 100644
> > --- a/drivers/power/supply/Kconfig
> > +++ b/drivers/power/supply/Kconfig
> > @@ -714,6 +714,16 @@ config CHARGER_CROS_USBPD
> >  	  what is connected to USB PD ports from the EC and converts
> >  	  that into power_supply properties.
> > =20
> > +config CHARGER_CROS_PCHG
> > +	tristate "ChromeOS EC based peripheral charger"
> > +	depends on MFD_CROS_EC_DEV
> > +	default MFD_CROS_EC_DEV
> > +	help
> > +	  Say Y here to enable ChromeOS EC based peripheral charge driver.
> > +	  This driver gets various information about the devices connected to
> > +	  the peripheral charge ports from the EC and converts that into
> > +	  power_supply properties.
> > +
> >  config CHARGER_SC2731
> >  	tristate "Spreadtrum SC2731 charger driver"
> >  	depends on MFD_SC27XX_PMIC || COMPILE_TEST
> > diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makef=
ile
> > index dd4b86318cd9bd..5263472a64809b 100644
> > --- a/drivers/power/supply/Makefile
> > +++ b/drivers/power/supply/Makefile
> > @@ -91,6 +91,7 @@ obj-$(CONFIG_CHARGER_TPS65217)	+=3D tps65217_charger.o
> >  obj-$(CONFIG_AXP288_FUEL_GAUGE) +=3D axp288_fuel_gauge.o
> >  obj-$(CONFIG_AXP288_CHARGER)	+=3D axp288_charger.o
> >  obj-$(CONFIG_CHARGER_CROS_USBPD)	+=3D cros_usbpd-charger.o
> > +obj-$(CONFIG_CHARGER_CROS_PCHG)	+=3D cros_peripheral_charger.o
> >  obj-$(CONFIG_CHARGER_SC2731)	+=3D sc2731_charger.o
> >  obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+=3D sc27xx_fuel_gauge.o
> >  obj-$(CONFIG_CHARGER_UCS1002)	+=3D ucs1002_power.o
> > diff --git a/drivers/power/supply/cros_peripheral_charger.c b/drivers/p=
ower/supply/cros_peripheral_charger.c
> > new file mode 100644
> > index 00000000000000..db68d3b7c80f32
> > --- /dev/null
> > +++ b/drivers/power/supply/cros_peripheral_charger.c
> > @@ -0,0 +1,346 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Power supply driver for ChromeOS EC based Peripheral Device Charger.
> > + *
> > + * Copyright 2020 Google LLC.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/notifier.h>
> > +#include <linux/platform_data/cros_ec_commands.h>
> > +#include <linux/platform_data/cros_ec_proto.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/power_supply.h>
> > +#include <linux/slab.h>
> > +#include <linux/stringify.h>
> > +#include <linux/types.h>
> > +
> > +#define DRV_NAME		"cros-ec-pchg"
> > +#define PCHG_DIR_NAME		"PCHG%d"
> > +#define PCHG_DIR_NAME_LENGTH	sizeof("PCHG" __stringify(EC_PCHG_MAX_POR=
TS))
>=20
> I think this is way too complex. Just pick a reasonable
> constant, such as 8 or 16.
>=20
> > +#define PCHG_CACHE_UPDATE_DELAY	msecs_to_jiffies(500)
> > +
> > +struct port_data {
> > +	int port_number;
> > +	char name[PCHG_DIR_NAME_LENGTH];
> > +	struct power_supply *psy;
> > +	struct power_supply_desc psy_desc;
> > +	int psy_status;
> > +	int battery_percentage;
> > +	struct charger_data *charger;
> > +	unsigned long last_update;
> > +};
> > +
> > +struct charger_data {
> > +	struct device *dev;
> > +	struct cros_ec_dev *ec_dev;
> > +	struct cros_ec_device *ec_device;
> > +	int num_registered_psy;
> > +	struct port_data *ports[EC_PCHG_MAX_PORTS];
> > +	struct notifier_block notifier;
> > +};
> > +
> > +static enum power_supply_property cros_pchg_props[] =3D {
> > +	POWER_SUPPLY_PROP_STATUS,
> > +	POWER_SUPPLY_PROP_CAPACITY,
> > +	/*
> > +	 * todo: Add the following.
>=20
> I would suggest to either implement this or to drop the comment.
>=20
> > +	 *
> > +	 * POWER_SUPPLY_PROP_TECHNOLOGY,
> > +	 * POWER_SUPPLY_PROP_ERROR,
> > +	 * POWER_SUPPLY_PROP_SERIAL_NUMBER,
> > +	 *
> > +	 * POWER_SUPPLY_PROP_ONLINE can't be used because it indicates the
> > +	 * system is powered by AC.
> > +	 */
> > +};
> > +
> > +static int cros_pchg_ec_command(const struct charger_data *charger,
> > +				unsigned int version,
> > +				unsigned int command,
> > +				const void *outdata,
> > +				unsigned int outsize,
> > +				void *indata,
> > +				unsigned int insize)
> > +{
> > +	struct cros_ec_dev *ec_dev =3D charger->ec_dev;
> > +	struct cros_ec_command *msg;
> > +	int ret;
> > +
> > +	msg =3D kzalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL);
> > +	if (!msg)
> > +		return -ENOMEM;
> > +
> > +	msg->version =3D version;
> > +	msg->command =3D ec_dev->cmd_offset + command;
> > +	msg->outsize =3D outsize;
> > +	msg->insize =3D insize;
> > +
> > +	if (outsize)
> > +		memcpy(msg->data, outdata, outsize);
> > +
> > +	ret =3D cros_ec_cmd_xfer_status(charger->ec_device, msg);
> > +	if (ret >=3D 0 && insize)
> > +		memcpy(indata, msg->data, insize);
> > +
> > +	kfree(msg);
> > +	return ret;
> > +}
> > +
> > +static int cros_pchg_port_count(const struct charger_data *charger)
> > +{
> > +	struct ec_response_pchg_count rsp;
> > +	int ret;
> > +
> > +	ret =3D cros_pchg_ec_command(charger, 0, EC_CMD_PCHG_COUNT,
> > +				   NULL, 0, &rsp, sizeof(rsp));
> > +	if (ret < 0) {
> > +		dev_warn(charger->dev,
> > +			 "Unable to get number or ports (err:%d)\n", ret);
>=20
> Why dev_warn() and not dev_err() ?
>=20
> > +		return ret;
> > +	}
> > +
> > +	return rsp.port_count;
> > +}
> > +
> > +static int cros_pchg_get_status(struct port_data *port)
> > +{
> > +	struct charger_data *charger =3D port->charger;
> > +	struct ec_params_pchg req;
> > +	struct ec_response_pchg rsp;
> > +	struct device *dev =3D charger->dev;
> > +	int ret;
> > +
> > +	req.port =3D port->port_number;
> > +	ret =3D cros_pchg_ec_command(charger, 0, EC_CMD_PCHG,
> > +				   &req, sizeof(req), &rsp, sizeof(rsp));
> > +	if (ret < 0) {
> > +		dev_err(dev, "Unable to get port.%d status (err:%d)\n",
> > +			port->port_number, ret);
> > +		return ret;
> > +	}
> > +
> > +	switch (rsp.state) {
> > +	case PCHG_STATE_RESET:
> > +	case PCHG_STATE_INITIALIZED:
> > +	case PCHG_STATE_ENABLED:
> > +	default:
> > +		port->psy_status =3D POWER_SUPPLY_STATUS_UNKNOWN;
> > +		port->battery_percentage =3D 0;
> > +		break;
> > +	case PCHG_STATE_DETECTED:
> > +		port->psy_status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> > +		port->battery_percentage =3D rsp.battery_percentage;
> > +		break;
> > +	case PCHG_STATE_CHARGING:
> > +		port->psy_status =3D POWER_SUPPLY_STATUS_CHARGING;
> > +		port->battery_percentage =3D rsp.battery_percentage;
> > +		break;
> > +	}
> > +
> > +	dev_dbg(dev,
> > +		"Port %d: state=3D%d battery=3D%d%%\n",
> > +		port->port_number, rsp.state, rsp.battery_percentage);
> > +
> > +	return 0;
> > +}
> > +
> > +static int cros_pchg_get_port_status(struct port_data *port, bool rate=
limit)
> > +{
> > +	int ret;
> > +
> > +	if (ratelimit &&
> > +	    time_is_after_jiffies(port->last_update + PCHG_CACHE_UPDATE_DELAY=
))
>=20
> Is this correct, or should it be time_is_before_jiffies() ?
>=20
> > +		return 0;
> > +
> > +	ret =3D cros_pchg_get_status(port);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	port->last_update =3D jiffies;
> > +
> > +	return ret;
> > +}
> > +
> > +static int cros_pchg_get_prop(struct power_supply *psy,
> > +			      enum power_supply_property psp,
> > +			      union power_supply_propval *val)
> > +{
> > +	struct port_data *port =3D power_supply_get_drvdata(psy);
> > +
> > +	switch (psp) {
> > +	case POWER_SUPPLY_PROP_STATUS:
> > +	case POWER_SUPPLY_PROP_CAPACITY:
> > +		cros_pchg_get_port_status(port, true);
> > +		break;
> > +	default:
> > +		break;
> > +	}
>=20
> Is the above case statement really needed (in other words, will this
> function ever be called for anything but POWER_SUPPLY_PROP_STATUS and
> POWER_SUPPLY_PROP_CAPACITY) ?
>=20
> > +
> > +	switch (psp) {
> > +	case POWER_SUPPLY_PROP_STATUS:
> > +		val->intval =3D port->psy_status;
> > +		break;
> > +	case POWER_SUPPLY_PROP_CAPACITY:
> > +		val->intval =3D port->battery_percentage;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int cros_pchg_event(const struct charger_data *charger,
> > +			   unsigned long host_event)
> > +{
> > +	int i;
> > +
> > +	for (i =3D 0; i < charger->num_registered_psy; i++)
> > +		cros_pchg_get_port_status(charger->ports[i], false);
> > +
> > +	return NOTIFY_OK;
> > +}
> > +
> > +static u32 cros_get_device_event(const struct charger_data *charger)
> > +{
> > +	struct ec_params_device_event req;
> > +	struct ec_response_device_event rsp;
> > +	struct device *dev =3D charger->dev;
> > +	int ret;
> > +
> > +	req.param =3D EC_DEVICE_EVENT_PARAM_GET_CURRENT_EVENTS;
> > +	ret =3D cros_pchg_ec_command(charger, 0, EC_CMD_DEVICE_EVENT,
> > +				   &req, sizeof(req), &rsp, sizeof(rsp));
> > +	if (ret < 0) {
> > +		dev_warn(dev, "Unable to get device events (err:%d)\n", ret);
> > +		return 0;
> > +	}
> > +
> > +	return rsp.event_mask;
> > +}
> > +
> > +static int cros_ec_notify(struct notifier_block *nb,
> > +			  unsigned long queued_during_suspend,
> > +			  void *data)
> > +{
> > +	struct cros_ec_device *ec_dev =3D (struct cros_ec_device *)data;
> > +	u32 host_event =3D cros_ec_get_host_event(ec_dev);
> > +	struct charger_data *charger =3D
> > +			container_of(nb, struct charger_data, notifier);
> > +	u32 device_event_mask;
> > +
> > +	if (!host_event)
> > +		return NOTIFY_BAD;
> > +
> > +	if (!(host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_DEVICE)))
> > +		return NOTIFY_DONE;
> > +
> > +	/*
> > +	 * todo: Retrieve device event mask in common place
> > +	 * (e.g. cros_ec_proto.c).
> > +	 */
> > +	device_event_mask =3D cros_get_device_event(charger);
> > +	if (!(device_event_mask & EC_DEVICE_EVENT_MASK(EC_DEVICE_EVENT_WLC)))
> > +		return NOTIFY_DONE;
> > +
> > +	return cros_pchg_event(charger, host_event);
> > +}
> > +
> > +static int cros_pchg_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct cros_ec_dev *ec_dev =3D dev_get_drvdata(dev->parent);
> > +	struct cros_ec_device *ec_device =3D ec_dev->ec_dev;
> > +	struct power_supply_desc *psy_desc;
> > +	struct charger_data *charger;
> > +	struct power_supply *psy;
> > +	struct port_data *port;
> > +	struct notifier_block *nb;
> > +	int num_ports;
> > +	int ret;
> > +	int i;
> > +
> > +	charger =3D devm_kzalloc(dev, sizeof(*charger), GFP_KERNEL);
> > +	if (!charger)
> > +		return -ENOMEM;
> > +
> > +	charger->dev =3D dev;
> > +	charger->ec_dev =3D ec_dev;
> > +	charger->ec_device =3D ec_device;
> > +
> > +	ret =3D cros_pchg_port_count(charger);
> > +	if (ret <=3D 0) {
> > +		/*
> > +		 * This feature is enabled by the EC and the kernel driver is
> > +		 * included by default for CrOS devices. Don't need to be loud
> > +		 * since this error can be normal.
> > +		 */
> > +		dev_info(dev, "No peripheral charge ports (err:%d)\n", ret);
>=20
> Is this message really needed / useful ? I am concerned that it will poll=
ute
> lots of logs. Also, cros_pchg_port_count() alreayd displays an error/warn=
ing
> message.
>=20
> > +		return -ENODEV;
> > +	}
> > +
> > +	num_ports =3D ret;
> > +	if (num_ports > EC_PCHG_MAX_PORTS) {
> > +		dev_err(dev, "Too many peripheral charge ports (%d)\n",
> > +			num_ports);
> > +		return -ENOBUFS;
>=20
> "No buffer space available" ?
>=20
> A more dynamic solution would be to allocate 'struct port_data *ports'
> separately and just accept the number of ports.
>=20
> > +	}
> > +
> > +	dev_info(dev, "%d peripheral charge ports found\n", num_ports);
> > +
>=20
> Personally I think this driver is way too noisy.
>=20
> > +	for (i =3D 0; i < num_ports; i++) {
> > +		struct power_supply_config psy_cfg =3D {};
> > +
> > +		port =3D devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> > +		if (!port)
> > +			return -ENOMEM;
> > +
> > +		port->charger =3D charger;
> > +		port->port_number =3D i;
> > +		snprintf(port->name, sizeof(port->name), PCHG_DIR_NAME, i);
> > +
> > +		psy_desc =3D &port->psy_desc;
> > +		psy_desc->name =3D port->name;
> > +		psy_desc->type =3D POWER_SUPPLY_TYPE_WIRELESS;
> > +		psy_desc->get_property =3D cros_pchg_get_prop;
> > +		psy_desc->external_power_changed =3D NULL;
> > +		psy_desc->properties =3D cros_pchg_props;
> > +		psy_desc->num_properties =3D ARRAY_SIZE(cros_pchg_props);
> > +		psy_cfg.drv_data =3D port;
> > +
> > +		psy =3D devm_power_supply_register_no_ws(dev, psy_desc, &psy_cfg);
> > +		if (IS_ERR(psy)) {
> > +			dev_err(dev, "Failed to register power supply\n");
>=20
> Is this an "acceptable" or ignorable error ? It seems to be somewhat odd.
>=20
> > +			continue;
> > +		}
> > +		port->psy =3D psy;
> > +
> > +		charger->ports[charger->num_registered_psy++] =3D port;
> > +	}
> > +
> > +	if (!charger->num_registered_psy)
> > +		return -ENODEV;
> > +
> > +	nb =3D &charger->notifier;
> > +	nb->notifier_call =3D cros_ec_notify;
> > +	ret =3D blocking_notifier_chain_register(&ec_dev->ec_dev->event_notif=
ier,
> > +					       nb);
> > +	if (ret < 0)
> > +		dev_err(dev, "Failed to register notifier (err:%d)\n", ret);
>=20
> If this is an error, it should be reported to the caller. If it isn't,
> it should not be reported as error.
>=20
> > +
> > +	return 0;
> > +}
> > +
> > +static struct platform_driver cros_pchg_driver =3D {
> > +	.driver =3D {
> > +		.name =3D DRV_NAME,
> > +	},
> > +	.probe =3D cros_pchg_probe
> > +};
> > +
> > +module_platform_driver(cros_pchg_driver);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_DESCRIPTION("ChromeOS EC peripheral device charger");
> > +MODULE_ALIAS("platform:" DRV_NAME);
> > diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/l=
inux/platform_data/cros_ec_commands.h
>=20
> This should be done in a separate patch, and probably simply align
> the current version of cros_ec_commands.h with the version in the
> EC code base (to avoid deviation from that version). We had major
> problems with that earlier, and I am not looking forward to
> re-introducing it.
>=20
> > index 58495127dfa656..c0f0a032c8beb6 100644
> > --- a/include/linux/platform_data/cros_ec_commands.h
> > +++ b/include/linux/platform_data/cros_ec_commands.h
> > @@ -4225,6 +4225,7 @@ enum ec_device_event {
> >  	EC_DEVICE_EVENT_TRACKPAD,
> >  	EC_DEVICE_EVENT_DSP,
> >  	EC_DEVICE_EVENT_WIFI,
> > +	EC_DEVICE_EVENT_WLC,
> >  };
> > =20
> >  enum ec_device_event_param {
> > @@ -5456,6 +5457,53 @@ struct ec_response_rollback_info {
> >  /* Issue AP reset */
> >  #define EC_CMD_AP_RESET 0x0125
> > =20
> > +/**
> > + * Get the number of peripheral charge ports
> > + */
> > +#define EC_CMD_PCHG_COUNT 0x0134
> > +
> > +#define EC_PCHG_MAX_PORTS 8
> > +
> > +struct ec_response_pchg_count {
> > +	uint8_t port_count;
> > +} __ec_align1;
> > +
> > +/**
> > + * Get the status of a peripheral charge port
> > + */
> > +#define EC_CMD_PCHG 0x0135
> > +
> > +struct ec_params_pchg {
> > +	uint8_t port;
> > +} __ec_align1;
> > +
> > +struct ec_response_pchg {
> > +	uint32_t error; /* enum pchg_error */
> > +	uint8_t state; /* enum pchg_state state */
> > +	uint8_t battery_percentage;
> > +} __ec_align2;
> > +
> > +enum pchg_state {
> > +	/* Charger is reset and not initialized. */
> > +	PCHG_STATE_RESET =3D 0,
> > +	/* Charger is initialized or disabled. */
> > +	PCHG_STATE_INITIALIZED,
> > +	/* Charger is enabled and ready to detect a device. */
> > +	PCHG_STATE_ENABLED,
> > +	/* Device is detected in proximity. */
> > +	PCHG_STATE_DETECTED,
> > +	/* Device is being charged. */
> > +	PCHG_STATE_CHARGING,
> > +};
> > +
> > +#define EC_PCHG_STATE_TEXT { \
> > +	[PCHG_STATE_RESET] =3D "RESET", \
> > +	[PCHG_STATE_INITIALIZED] =3D "INITIALIZED", \
> > +	[PCHG_STATE_ENABLED] =3D "ENABLED", \
> > +	[PCHG_STATE_DETECTED] =3D "DETECTED", \
> > +	[PCHG_STATE_CHARGING] =3D "CHARGING", \
> > +	}
> > +
> >  /*********************************************************************=
********/
> >  /* Locate peripheral chips
> >   *

--vdjnkfduwckvbnr4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmAC6LYACgkQ2O7X88g7
+poX4w/6ApH/8hWQXoRTxXhoXugUddvN7nq1pqASt2pCrIHVwGC98Wn/8TetyT21
1tp0xjnafS64BDHbpYVr8rk/Pu3v785keQIkAKqT4HAu0+Exo5OnYV85aix+f6m4
7uoo5pQYFymXRBRkrcEKlytKON8aqxzCnseUsttyoul/jzK1lkXkfX/zQHxqagyP
3U0+1fRp4IQZ3Gy/FY1HVV3o+GfEkSV1JW33kqewUuTP1LQOtb9YY0VoP6ThqP2u
zxfQghlEDu2Eolf82NYwKE5s6SSct6DD5vL4G/+l9DRcT90N38FTE+9qEVn+44hl
wC1dC4SjSvi/4yizCpaq+xRLlWRXgjHtw4ojjrLqxJ29EfoY6bnn4KDdZeF0jaU8
Pw+qT+QbZ6knzu4h2U9K7qrUjSplw8jBL2OIkGM06DnjfBbJYVMSPUAtgHP+eihg
xS4Yk0c8jBBSyz41Fwquam3BQ3dED5KPyj1fa/uvajrvasm83Dvi1hT1KUc37lPU
cOK7/pCrO3daoxWgwiO/BvrgiMfPO2L7LOkScFKKo3telvpo3Uvv8PXTWgoPCQY2
hINyrQrJBDuvaUqXLXxipk7c0vN17YDDjdCUJsDPi7GrDZvQGrEqLzt7I1n1MQLl
MwgQV8+OgLtINMkxeD1kMZslaPLQVVvm+A1lTObpXg7wgvYgFs4=
=j1gI
-----END PGP SIGNATURE-----

--vdjnkfduwckvbnr4--
