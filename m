Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A017A3540EA
	for <lists+linux-pm@lfdr.de>; Mon,  5 Apr 2021 12:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240962AbhDEJe3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Apr 2021 05:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239966AbhDEJeO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Apr 2021 05:34:14 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41318C061756;
        Mon,  5 Apr 2021 02:34:08 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id B06211F44D3A
Received: by earth.universe (Postfix, from userid 1000)
        id 056123C0C96; Mon,  5 Apr 2021 11:34:02 +0200 (CEST)
Date:   Mon, 5 Apr 2021 11:34:02 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Daisuke Nojiri <dnojiri@chromium.org>,
        Vincent Palatin <vpalatin@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Ching-Kang Yen <chingkang@chromium.org>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Vijay Hiremath <vijay.p.hiremath@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 1/2] power: supply: PCHG: Peripheral device charger
Message-ID: <20210405093402.53plhb75dviwaxzu@earth.universe>
References: <20210123154922.1309290-1-dnojiri@chromium.org>
 <CAPUE2uuf-dZ-0gy81+GQ3G8GDVmZhBSbj4bpP3aLS6EL2PZG0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="52egjnhjuxfffvlm"
Content-Disposition: inline
In-Reply-To: <CAPUE2uuf-dZ-0gy81+GQ3G8GDVmZhBSbj4bpP3aLS6EL2PZG0g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--52egjnhjuxfffvlm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jan 23, 2021 at 10:43:23AM -0800, Gwendal Grignou wrote:
> On Sat, Jan 23, 2021 at 7:53 AM Daisuke Nojiri <dnojiri@chromium.org> wro=
te:
> >
> > This patch adds a driver for PCHG (Peripheral CHarGer). PCHG is a
> > framework managing power supplies for peripheral devices.
> >
> > This driver creates a sysfs node for each peripheral charge port:
> >
> >         /sys/class/power_supply/PCHGn
> >
> > where <n> is the index of a charge port.
> >
> > For example, when a stylus is connected to a NFC/WLC port, the node
> > prints:
> >
> >         /sys/class/power_supply/PCHG0/
> >                 capacity=3D50
> >                 scope=3DDevice
> >                 status=3DCharging
> >                 type=3DBattery
> >
> > Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
> > ---
> > v1 -> v2
> > * Separate mfd/cros_ec_dev.c
> > * Make CONFIG_CHARGER_CROS_PCHG default to CONFIG_MFD_CROS_EC_DEV
> > v2 -> v3
> > * Return POWER_SUPPLY_SCOPE_DEVICE for POWER_SUPPLY_PROP_SCOPE
> > * POWER_SUPPLY_TYPE_WIRELESS -> POWER_SUPPLY_TYPE_BATTERY
> > v3 -> v4
> > * Return NOTIFY_DONE when a non-host event is notified.
> > ---
> >  drivers/power/supply/Kconfig                  |  10 +
> >  drivers/power/supply/Makefile                 |   1 +
> >  .../power/supply/cros_peripheral_charger.c    | 350 ++++++++++++++++++
> >  .../linux/platform_data/cros_ec_commands.h    |  48 +++
> >  4 files changed, 409 insertions(+)
> >  create mode 100644 drivers/power/supply/cros_peripheral_charger.c
> >
> > diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> > index eec646c568b7be..407f9fbbc2bb50 100644
> > --- a/drivers/power/supply/Kconfig
> > +++ b/drivers/power/supply/Kconfig
> > @@ -714,6 +714,16 @@ config CHARGER_CROS_USBPD
> >           what is connected to USB PD ports from the EC and converts
> >           that into power_supply properties.
> >
> > +config CHARGER_CROS_PCHG
> > +       tristate "ChromeOS EC based peripheral charger"
> > +       depends on MFD_CROS_EC_DEV
> > +       default MFD_CROS_EC_DEV
> > +       help
> > +         Say Y here to enable ChromeOS EC based peripheral charge driv=
er.
> > +         This driver gets various information about the devices connec=
ted to
> > +         the peripheral charge ports from the EC and converts that into
> > +         power_supply properties.
> > +
> >  config CHARGER_SC2731
> >         tristate "Spreadtrum SC2731 charger driver"
> >         depends on MFD_SC27XX_PMIC || COMPILE_TEST
> > diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makef=
ile
> > index dd4b86318cd9bd..5263472a64809b 100644
> > --- a/drivers/power/supply/Makefile
> > +++ b/drivers/power/supply/Makefile
> > @@ -91,6 +91,7 @@ obj-$(CONFIG_CHARGER_TPS65217)        +=3D tps65217_c=
harger.o
> >  obj-$(CONFIG_AXP288_FUEL_GAUGE) +=3D axp288_fuel_gauge.o
> >  obj-$(CONFIG_AXP288_CHARGER)   +=3D axp288_charger.o
> >  obj-$(CONFIG_CHARGER_CROS_USBPD)       +=3D cros_usbpd-charger.o
> > +obj-$(CONFIG_CHARGER_CROS_PCHG)        +=3D cros_peripheral_charger.o
> >  obj-$(CONFIG_CHARGER_SC2731)   +=3D sc2731_charger.o
> >  obj-$(CONFIG_FUEL_GAUGE_SC27XX)        +=3D sc27xx_fuel_gauge.o
> >  obj-$(CONFIG_CHARGER_UCS1002)  +=3D ucs1002_power.o
> > diff --git a/drivers/power/supply/cros_peripheral_charger.c b/drivers/p=
ower/supply/cros_peripheral_charger.c
> > new file mode 100644
> > index 00000000000000..cd7db4bd5f90d0
> > --- /dev/null
> > +++ b/drivers/power/supply/cros_peripheral_charger.c
> > @@ -0,0 +1,350 @@
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
> Add
>=20
> > +#include <linux/platform_device.h>
> > +#include <linux/power_supply.h>
> > +#include <linux/slab.h>
> > +#include <linux/stringify.h>
> > +#include <linux/types.h>
> > +
> > +#define DRV_NAME               "cros-ec-pchg"
> > +#define PCHG_DIR_NAME          "PCHG%d"
> nit: to be coherent with function names, define CROS_EC_PCHG_DIR_NAME ins=
tead.
> Isn't PCHG0, PCHG1, ... too generic? Looking at other driver, we have
> strings like
> "max1721x-%012X", "wm831x-battery.%d",

Better name gives users better chance to understand what this is. I
think "peripheral%d" is already better than "PCHG%d", which is quite
cryptic. Does EC know the device type (e.g. stylus)?

> > +#define PCHG_DIR_NAME_LENGTH   sizeof("PCHG" __stringify(EC_PCHG_MAX_P=
ORTS))
> > +#define PCHG_CACHE_UPDATE_DELAY        msecs_to_jiffies(500)
> > +
> > +struct port_data {
> > +       int port_number;
> > +       char name[PCHG_DIR_NAME_LENGTH];
> > +       struct power_supply *psy;
> > +       struct power_supply_desc psy_desc;
> > +       int psy_status;
> > +       int battery_percentage;
> > +       struct charger_data *charger;
> > +       unsigned long last_update;
> > +};
> > +
> > +struct charger_data {
> > +       struct device *dev;
> > +       struct cros_ec_dev *ec_dev;
> > +       struct cros_ec_device *ec_device;
> As far as I can see, ec_device is used only once, in cros_pchg_ec_command=
().
> > +       int num_registered_psy;
> > +       struct port_data *ports[EC_PCHG_MAX_PORTS];
> > +       struct notifier_block notifier;
> > +};
> > +
> > +static enum power_supply_property cros_pchg_props[] =3D {
> > +       POWER_SUPPLY_PROP_STATUS,
> > +       POWER_SUPPLY_PROP_CAPACITY,
> > +       POWER_SUPPLY_PROP_SCOPE,
> > +       /*
> > +        * todo: Add the following.
> > +        *
> > +        * POWER_SUPPLY_PROP_TECHNOLOGY,
> > +        * POWER_SUPPLY_PROP_ERROR,
> > +        * POWER_SUPPLY_PROP_SERIAL_NUMBER,
> > +        *
> > +        * POWER_SUPPLY_PROP_ONLINE can't be used because it indicates =
the
> > +        * system is powered by AC.
> > +        */
> > +};
> > +
> > +static int cros_pchg_ec_command(const struct charger_data *charger,
> > +                               unsigned int version,
> > +                               unsigned int command,
> > +                               const void *outdata,
> > +                               unsigned int outsize,
> > +                               void *indata,
> > +                               unsigned int insize)
> > +{
> > +       struct cros_ec_dev *ec_dev =3D charger->ec_dev;
> > +       struct cros_ec_command *msg;
> > +       int ret;
> > +
> > +       msg =3D kzalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL=
);
> > +       if (!msg)
> > +               return -ENOMEM;
> > +
> > +       msg->version =3D version;
> > +       msg->command =3D ec_dev->cmd_offset + command;
> > +       msg->outsize =3D outsize;
> > +       msg->insize =3D insize;
> > +
> > +       if (outsize)
> > +               memcpy(msg->data, outdata, outsize);
> > +
> > +       ret =3D cros_ec_cmd_xfer_status(charger->ec_device, msg);
> > +       if (ret >=3D 0 && insize)
> > +               memcpy(indata, msg->data, insize);
> > +
> > +       kfree(msg);
> > +       return ret;
> > +}
> > +
> > +static int cros_pchg_port_count(const struct charger_data *charger)
> > +{
> > +       struct ec_response_pchg_count rsp;
> > +       int ret;
> > +
> > +       ret =3D cros_pchg_ec_command(charger, 0, EC_CMD_PCHG_COUNT,
> > +                                  NULL, 0, &rsp, sizeof(rsp));
> > +       if (ret < 0) {
> > +               dev_warn(charger->dev,
> > +                        "Unable to get number or ports (err:%d)\n", re=
t);
> > +               return ret;
> > +       }
> > +
> > +       return rsp.port_count;
> > +}
> > +
> > +static int cros_pchg_get_status(struct port_data *port)
> > +{
> > +       struct charger_data *charger =3D port->charger;
> > +       struct ec_params_pchg req;
> > +       struct ec_response_pchg rsp;
> > +       struct device *dev =3D charger->dev;
> > +       int ret;
> > +
> > +       req.port =3D port->port_number;
> > +       ret =3D cros_pchg_ec_command(charger, 0, EC_CMD_PCHG,
> > +                                  &req, sizeof(req), &rsp, sizeof(rsp)=
);
> > +       if (ret < 0) {
> > +               dev_err(dev, "Unable to get port.%d status (err:%d)\n",
> > +                       port->port_number, ret);
> > +               return ret;
> > +       }
> > +
> > +       switch (rsp.state) {
> > +       case PCHG_STATE_RESET:
> > +       case PCHG_STATE_INITIALIZED:
> > +       case PCHG_STATE_ENABLED:
> > +       default:
> > +               port->psy_status =3D POWER_SUPPLY_STATUS_UNKNOWN;
> > +               port->battery_percentage =3D 0;
> > +               break;
> > +       case PCHG_STATE_DETECTED:
> > +               port->psy_status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> > +               port->battery_percentage =3D rsp.battery_percentage;
> > +               break;
> > +       case PCHG_STATE_CHARGING:
> > +               port->psy_status =3D POWER_SUPPLY_STATUS_CHARGING;
> > +               port->battery_percentage =3D rsp.battery_percentage;
> > +               break;
> > +       }
> > +
> > +       dev_dbg(dev,
> > +               "Port %d: state=3D%d battery=3D%d%%\n",
> > +               port->port_number, rsp.state, rsp.battery_percentage);
> > +
> > +       return 0;
> Looking at other drivers (drivers/power/supply/ds2760_battery.c for
> instance), power_supply_changed() is called when status changes.
> Should we?

power_supply_changed() triggers a couple of things:

1. it takes care of updating the any LED triggers
2. it notifies userspace via uevent
3. it notifies supplied devices

I suppose in this case at least the second point is interesting.
It's generally a good idea to call it when charging status changes
or battery level gets critical.

> > +}
> > +
> > +static int cros_pchg_get_port_status(struct port_data *port, bool rate=
limit)
> > +{
> > +       int ret;
> > +
> > +       if (ratelimit &&
> > +           time_is_after_jiffies(port->last_update + PCHG_CACHE_UPDATE=
_DELAY))
> > +               return 0;
> > +
> > +       ret =3D cros_pchg_get_status(port);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       port->last_update =3D jiffies;
> > +
> > +       return ret;
> > +}
> > +
> > +static int cros_pchg_get_prop(struct power_supply *psy,
> > +                             enum power_supply_property psp,
> > +                             union power_supply_propval *val)
> > +{
> > +       struct port_data *port =3D power_supply_get_drvdata(psy);
> > +
> > +       switch (psp) {
> > +       case POWER_SUPPLY_PROP_STATUS:
> > +       case POWER_SUPPLY_PROP_CAPACITY:
> > +               cros_pchg_get_port_status(port, true);
> > +               break;
> > +       default:
> > +               break;
> > +       }
> > +
> > +       switch (psp) {
> > +       case POWER_SUPPLY_PROP_STATUS:
> > +               val->intval =3D port->psy_status;
> > +               break;
> > +       case POWER_SUPPLY_PROP_CAPACITY:
> > +               val->intval =3D port->battery_percentage;
> > +               break;
> > +       case POWER_SUPPLY_PROP_SCOPE:
> > +               val->intval =3D POWER_SUPPLY_SCOPE_DEVICE;
> > +               break;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int cros_pchg_event(const struct charger_data *charger,
> > +                          unsigned long host_event)
> > +{
> > +       int i;
> > +
> > +       for (i =3D 0; i < charger->num_registered_psy; i++)
> > +               cros_pchg_get_port_status(charger->ports[i], false);
> > +
> > +       return NOTIFY_OK;
> > +}
> > +
> > +static u32 cros_get_device_event(const struct charger_data *charger)
> > +{
> > +       struct ec_params_device_event req;
> > +       struct ec_response_device_event rsp;
> > +       struct device *dev =3D charger->dev;
> > +       int ret;
> > +
> > +       req.param =3D EC_DEVICE_EVENT_PARAM_GET_CURRENT_EVENTS;
> > +       ret =3D cros_pchg_ec_command(charger, 0, EC_CMD_DEVICE_EVENT,
> > +                                  &req, sizeof(req), &rsp, sizeof(rsp)=
);
> > +       if (ret < 0) {
> > +               dev_warn(dev, "Unable to get device events (err:%d)\n",=
 ret);
> > +               return 0;
> > +       }
> > +
> > +       return rsp.event_mask;
> > +}
> > +
> > +static int cros_ec_notify(struct notifier_block *nb,
> cros_pchg_notify instead to preserve naming convention.
> > +                         unsigned long queued_during_suspend,
> > +                         void *data)
> > +{
> > +       struct cros_ec_device *ec_dev =3D (struct cros_ec_device *)data;
> > +       u32 host_event =3D cros_ec_get_host_event(ec_dev);
> > +       struct charger_data *charger =3D
> > +                       container_of(nb, struct charger_data, notifier);
> > +       u32 device_event_mask;
> > +
> > +       if (!host_event)
> > +               return NOTIFY_DONE;
> > +
> > +       if (!(host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_DEVICE)))
> > +               return NOTIFY_DONE;
> > +
> > +       /*
> > +        * todo: Retrieve device event mask in common place
> > +        * (e.g. cros_ec_proto.c).
> > +        */
> > +       device_event_mask =3D cros_get_device_event(charger);
> > +       if (!(device_event_mask & EC_DEVICE_EVENT_MASK(EC_DEVICE_EVENT_=
WLC)))
> > +               return NOTIFY_DONE;
> > +
> > +       return cros_pchg_event(charger, host_event);
> > +}
> > +
> > +static int cros_pchg_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev =3D &pdev->dev;
> > +       struct cros_ec_dev *ec_dev =3D dev_get_drvdata(dev->parent);
> > +       struct cros_ec_device *ec_device =3D ec_dev->ec_dev;
> > +       struct power_supply_desc *psy_desc;
> psy_desc is a local variable of the for loop line 297.
> > +       struct charger_data *charger;
> > +       struct power_supply *psy;
> > +       struct port_data *port;
> port is a local variable of the for loop line 297.
> > +       struct notifier_block *nb;
> > +       int num_ports;
> > +       int ret;
> > +       int i;
> > +
> > +       charger =3D devm_kzalloc(dev, sizeof(*charger), GFP_KERNEL);
> > +       if (!charger)
> > +               return -ENOMEM;
> > +
> > +       charger->dev =3D dev;
> Usually, we call platform_set_drvdata(pdev, charger) to tie the
> private data and the platform data together.

You need platform_set_drvdata(pdev, charger) to get charger from
pdev and charger->dev to get device from charger. This look ok to
me.

> > +       charger->ec_dev =3D ec_dev;
> > +       charger->ec_device =3D ec_device;
> > +
> > +       ret =3D cros_pchg_port_count(charger);
> > +       if (ret <=3D 0) {
> > +               /*
> > +                * This feature is enabled by the EC and the kernel dri=
ver is
> > +                * included by default for CrOS devices. Don't need to =
be loud
> > +                * since this error can be normal.
> > +                */
> There is the same problem with iio sensors: we export
> "cros_ec_get_sensor_count()" and use it in ec_device_probe(). To be
> coherent, we can either export cros_pchg_port_count or call the sensor
> stack even when there are no sensors reported. I prefer the former,
> more generic.
> > +               dev_info(dev, "No peripheral charge ports (err:%d)\n", =
ret);
> > +               return -ENODEV;
> > +       }
> > +
> > +       num_ports =3D ret;
> > +       if (num_ports > EC_PCHG_MAX_PORTS) {
> > +               dev_err(dev, "Too many peripheral charge ports (%d)\n",
> > +                       num_ports);
> > +               return -ENOBUFS;
> > +       }
> > +
> > +       dev_info(dev, "%d peripheral charge ports found\n", num_ports);
> > +
> > +       for (i =3D 0; i < num_ports; i++) {
> > +               struct power_supply_config psy_cfg =3D {};
> > +
> > +               port =3D devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> > +               if (!port)
> > +                       return -ENOMEM;
> nit: shall we fail probing the whole device or just the power supply
> port? Here we fail the whole device, later just the port.

For memory errors it's definitive fine to fail everything. Kernel is
in huge problems anyways.

> > +               port->charger =3D charger;
> > +               port->port_number =3D i;
> > +               snprintf(port->name, sizeof(port->name), PCHG_DIR_NAME,=
 i);
> > +
> > +               psy_desc =3D &port->psy_desc;
> > +               psy_desc->name =3D port->name;
> > +               psy_desc->type =3D POWER_SUPPLY_TYPE_BATTERY;
> > +               psy_desc->get_property =3D cros_pchg_get_prop;
> > +               psy_desc->external_power_changed =3D NULL;
> > +               psy_desc->properties =3D cros_pchg_props;
> > +               psy_desc->num_properties =3D ARRAY_SIZE(cros_pchg_props=
);
> > +               psy_cfg.drv_data =3D port;
> > +
> > +               psy =3D devm_power_supply_register_no_ws(dev, psy_desc,=
 &psy_cfg);
> > +               if (IS_ERR(psy)) {
> > +                       dev_err(dev, "Failed to register power supply\n=
");
> > +                       continue;
> > +               }

I suppose we might also just bail out here. Most common problems for
this function are:

-ENOMEM -> if kernel runs oom during boot I would not expect other
           supplies to be functional.
-EINVAL -> some power-supply properties are invalid. Since you
           register the same ones for all supplies all of them
           would fail to register anyways
-EPROBE_DEFER -> no relevant for this driver

So maybe just call

return dev_err_probe(dev, ERR_PTR(psy), "Failed to register power supply");

> > +               port->psy =3D psy;
> > +
> > +               charger->ports[charger->num_registered_psy++] =3D port;
> > +       }
> > +
> > +       if (!charger->num_registered_psy)
> > +               return -ENODEV;
> > +
> > +       nb =3D &charger->notifier;
> > +       nb->notifier_call =3D cros_ec_notify;
> > +       ret =3D blocking_notifier_chain_register(&ec_dev->ec_dev->event=
_notifier,
> > +                                              nb);
> > +       if (ret < 0)
> > +               dev_err(dev, "Failed to register notifier (err:%d)\n", =
ret);
> > +
> > +       return 0;
> > +}
> > +
> > +static struct platform_driver cros_pchg_driver =3D {
> > +       .driver =3D {
> > +               .name =3D DRV_NAME,
> > +       },
> > +       .probe =3D cros_pchg_probe
> > +};
> > +
> > +module_platform_driver(cros_pchg_driver);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_DESCRIPTION("ChromeOS EC peripheral device charger");
> > +MODULE_ALIAS("platform:" DRV_NAME);
> > diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/l=
inux/platform_data/cros_ec_commands.h
> > index 5a3ccf8968968e..6a82a9ad99eadf 100644
> > --- a/include/linux/platform_data/cros_ec_commands.h
> > +++ b/include/linux/platform_data/cros_ec_commands.h
> > @@ -4249,6 +4249,7 @@ enum ec_device_event {
> >         EC_DEVICE_EVENT_TRACKPAD,
> >         EC_DEVICE_EVENT_DSP,
> >         EC_DEVICE_EVENT_WIFI,
> > +       EC_DEVICE_EVENT_WLC,
> >  };
> >
> >  enum ec_device_event_param {
> > @@ -5480,6 +5481,53 @@ struct ec_response_rollback_info {
> >  /* Issue AP reset */
> >  #define EC_CMD_AP_RESET 0x0125
> >
> > +/**
> > + * Get the number of peripheral charge ports
> > + */
> > +#define EC_CMD_PCHG_COUNT 0x0134
> > +
> > +#define EC_PCHG_MAX_PORTS 8
> > +
> > +struct ec_response_pchg_count {
> > +       uint8_t port_count;
> > +} __ec_align1;
> > +
> > +/**
> > + * Get the status of a peripheral charge port
> > + */
> > +#define EC_CMD_PCHG 0x0135
> > +
> > +struct ec_params_pchg {
> > +       uint8_t port;
> > +} __ec_align1;
> > +
> > +struct ec_response_pchg {
> > +       uint32_t error; /* enum pchg_error */
> > +       uint8_t state; /* enum pchg_state state */
> > +       uint8_t battery_percentage;
> > +} __ec_align2;
> > +
> > +enum pchg_state {
> > +       /* Charger is reset and not initialized. */
> > +       PCHG_STATE_RESET =3D 0,
> > +       /* Charger is initialized or disabled. */
> > +       PCHG_STATE_INITIALIZED,
> > +       /* Charger is enabled and ready to detect a device. */
> > +       PCHG_STATE_ENABLED,
> > +       /* Device is detected in proximity. */
> > +       PCHG_STATE_DETECTED,
> > +       /* Device is being charged. */
> > +       PCHG_STATE_CHARGING,
> > +};
> > +
> > +#define EC_PCHG_STATE_TEXT { \
> > +       [PCHG_STATE_RESET] =3D "RESET", \
> > +       [PCHG_STATE_INITIALIZED] =3D "INITIALIZED", \
> > +       [PCHG_STATE_ENABLED] =3D "ENABLED", \
> > +       [PCHG_STATE_DETECTED] =3D "DETECTED", \
> > +       [PCHG_STATE_CHARGING] =3D "CHARGING", \
> > +       }
> > +
> >  /*********************************************************************=
********/
> >  /* Locate peripheral chips
> >   *
> > --
> > 2.30.0.280.ga3ce27912f-goog
> >

-- Sebastian

--52egjnhjuxfffvlm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBq2YUACgkQ2O7X88g7
+pryGRAAjJSvKPHDwHFsMjdROjQak4O3fSuR3wJuj7R9S5wJMhE7pDQROZn4fXTb
0JppMsxgxXguWP0s5EFWztNlKcPoxygSdvEZPJ2EvmyBD1xmTrkY+fMnFv2sc2Zp
mdFRTcwGjKvXmwgAMy80lC+g5PfQI/wJZvouZU7OWtFmLYrfs3rov+MMVgd2mAQS
PkBLYyxzbmofbhRjXH8HBncejELYBQrCx0b32iVb27DDDPujCH2UMrStcmCEQhe8
zlXjGDkrSXEpr8YluDbFlCyupg0UQv08f2aFpqbSmskMGyQw0tHQQsAZIYE97pmL
6S1fnpwP3KK4+pZYtVIS6xc1FwkRAUnrH/CjRGTZV0SCplfCpq2NLNDfB7BqHNAV
jrphL5rmlIqSBeZAcerI6ckMaOQ4z3XMcXNsbu1qUm254nafeizvdRVZTTQ5HaLp
XRjwVXqWAidQdPe912Tc9Gfk69nz1rGL8SUOqjrgWQHy/nIJyD0jg+qD7w7x/wdj
leS5bCQL+KsMemEJfFL/lj2ZC4EV3lSrffKRU4bbiNJX5lFIQlhGxaUrxRl6tR9F
fFd07CW1PkAq1fmfMRvLM96Lsy8E91Eb1GX0bGQxfL0kKcQyvYqdJnjnT19FNk46
n1vg7OvVAEGXicwBS6vYnUvGA9SNol40gDtfRLD7MeCX1LMOuJY=
=pUzw
-----END PGP SIGNATURE-----

--52egjnhjuxfffvlm--
