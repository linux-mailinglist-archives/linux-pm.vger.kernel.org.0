Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BF83AD5BA
	for <lists+linux-pm@lfdr.de>; Sat, 19 Jun 2021 01:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbhFRXTE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Jun 2021 19:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbhFRXTD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jun 2021 19:19:03 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D04C061574
        for <linux-pm@vger.kernel.org>; Fri, 18 Jun 2021 16:16:52 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id d19so12360318oic.7
        for <linux-pm@vger.kernel.org>; Fri, 18 Jun 2021 16:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=B6kgzNyrcQ+pem5m0b/SR/HghVlMp4EDK/8K8Z3VVYA=;
        b=e9zDR4S7PwcN81gg2Kseqz6LfZW+3QKUC62exY/KwudrgTx6fvokQpeOGtxcBjZh1o
         RUcu+8Ojnh9Uh5q3NAwhZ0xLZJlPqj0V7TeQwnbD0/OdYTXUbu8D7rr1A9mWi1MLVWue
         SQuls3V4iGuB10ePbuS5jbP/A8yHFxpM+l2kE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=B6kgzNyrcQ+pem5m0b/SR/HghVlMp4EDK/8K8Z3VVYA=;
        b=Tw63CCxyXCmsnFK3uwbDl+44NoL9jcfl5ErQg9xt9ZJfNkFeCemWxGnHHS2CwLeGtf
         JTcd3IlkVi2BFo0ThiOTJnxcGcwQGc8Lc1EtnSB2SBeD1ZZVUzLgZ/UotynQdcD4m4Dw
         w8Nxhf2qnrZ1bm3lKcDSSsBZfC2pSzZ+xoyc3V7lmCwlljHJ8ymGk0nPczRsnurblcAz
         HHpPl1PwBdf0CPl8UL9bGaeLqVBGX8UoeiOqpuiRFwpFMKs/K3mWQ5kjQiN8vbA/wBOL
         TLVUEBd4aN0NlLvzN9Dh4Opzp70QxRbakjIceH+H76FFUsD3PTbNvB0fimvOQK3ttCL0
         qxPQ==
X-Gm-Message-State: AOAM531jD+MF6LrUEe3rR/6QK7F1OsNRNgReSLh6VJuRGcq2eckXxJTj
        K8ZssGUWLTGrdpx0e7EhBRMyUTX0NADyAO0PUlhA9A==
X-Google-Smtp-Source: ABdhPJxolRzw1CMOL4L/hsCuHlkW35FK17Enx+GbRptnTSu839jZyCBEToXHHfKeQaZGyQvmH+pODGaebRPwuwY/BJk=
X-Received: by 2002:a54:4802:: with SMTP id j2mr16666293oij.125.1624058211488;
 Fri, 18 Jun 2021 16:16:51 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 18 Jun 2021 16:16:51 -0700
MIME-Version: 1.0
In-Reply-To: <20210615170854.897153-1-dnojiri@chromium.org>
References: <20210615170854.897153-1-dnojiri@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 18 Jun 2021 16:16:51 -0700
Message-ID: <CAE-0n51x1X-9KmP3+-CHM2ujoK+JeVeZdh3LhdLMrhh-uheHqg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] power: supply: PCHG: Peripheral device charger
To:     Daisuke Nojiri <dnojiri@chromium.org>
Cc:     vpalatin@chromium.org, Sebastian Reichel <sre@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Utkarsh Patel <utkarsh.h.patel@intel.com>,
        Vijay Hiremath <vijay.p.hiremath@intel.com>,
        Ching-Kang Yen <chingkang@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Daisuke Nojiri (2021-06-15 10:08:48)
> This patch adds a driver for PCHG (Peripheral CHarGer). PCHG is a

Please see

 $ git grep "This patch" -- Documentation/process/submitting-patches.rst

> framework managing power supplies for peripheral devices.
>
> This driver creates a sysfs node for each peripheral charge port:
>
>         /sys/class/power_supply/peripheral<n>
>
> where <n> is the index of a charge port.
>
> For example, when a stylus is connected to a NFC/WLC port, the node
> returns:
>
>         /sys/class/power_supply/peripheral0/
>                 capacity=50
>                 scope=Device
>                 status=Charging
>                 type=Battery
>
> Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
> ---
> v2
> * Separate mfd/cros_ec_dev.c
> * Make CONFIG_CHARGER_CROS_PCHG default to CONFIG_MFD_CROS_EC_DEV
> v3
> * Return POWER_SUPPLY_SCOPE_DEVICE for POWER_SUPPLY_PROP_SCOPE
> * POWER_SUPPLY_TYPE_WIRELESS -> POWER_SUPPLY_TYPE_BATTERY
> v4
> * Return NOTIFY_DONE when a non-host event is notified.
> v5
> * Change sysfs node prefix from PCHG to peripheral.
> * Update EC_CMD_PCHG to 1 and make probe fail if EC doesn't support it.
> * Call power_supply_changed if status or battery percentage changed.
> * Add PCHG_STATE_FULL. It's sent from EC explicitly for fully charged battery.
> * Register each port as a wakeup source.
> ---
>  drivers/power/supply/Kconfig                  |  10 +
>  drivers/power/supply/Makefile                 |   1 +
>  .../power/supply/cros_peripheral_charger.c    | 387 ++++++++++++++++++
>  .../linux/platform_data/cros_ec_commands.h    |  64 +++
>  4 files changed, 462 insertions(+)
>  create mode 100644 drivers/power/supply/cros_peripheral_charger.c
>
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 006b95eca67394..0f7bc1c3de0f37 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -735,6 +735,16 @@ config CHARGER_CROS_USBPD
>           what is connected to USB PD ports from the EC and converts
>           that into power_supply properties.
>
> +config CHARGER_CROS_PCHG
> +       tristate "ChromeOS EC based peripheral charger"
> +       depends on MFD_CROS_EC_DEV
> +       default MFD_CROS_EC_DEV

The default is nice to avoid updating the config but then if you don't
have this device you leave the driver enabled in the kernel. Can we make
it not default enabled if you have enabled cros-ec? That way everyone
using cros-ec doesn't have to have a driver sitting around, probably
builtin, when it doesn't use it.

> +       help
> +         Say Y here to enable ChromeOS EC based peripheral charge driver.
> +         This driver gets various information about the devices connected to
> +         the peripheral charge ports from the EC and converts that into
> +         power_supply properties.
> +
>  config CHARGER_SC2731
>         tristate "Spreadtrum SC2731 charger driver"
>         depends on MFD_SC27XX_PMIC || COMPILE_TEST
> diff --git a/drivers/power/supply/cros_peripheral_charger.c b/drivers/power/supply/cros_peripheral_charger.c
> new file mode 100644
> index 00000000000000..e0074d0f3f2d80
> --- /dev/null
> +++ b/drivers/power/supply/cros_peripheral_charger.c
> @@ -0,0 +1,387 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Power supply driver for ChromeOS EC based Peripheral Device Charger.
> + *
> + * Copyright 2020 Google LLC.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/notifier.h>
> +#include <linux/platform_data/cros_ec_commands.h>
> +#include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/slab.h>
> +#include <linux/stringify.h>
> +#include <linux/types.h>
> +
> +#define DRV_NAME               "cros-ec-pchg"
> +#define PCHG_DIR_PREFIX                "peripheral"
> +#define PCHG_DIR_NAME          PCHG_DIR_PREFIX "%d"
> +#define PCHG_DIR_NAME_LENGTH \
> +               sizeof(PCHG_DIR_PREFIX __stringify(EC_PCHG_MAX_PORTS))
> +#define PCHG_CACHE_UPDATE_DELAY        msecs_to_jiffies(500)

Need to include jiffies.h for msecs_to_jiffies()

> +
> +struct port_data {
> +       int port_number;
> +       char name[PCHG_DIR_NAME_LENGTH];
> +       struct power_supply *psy;
> +       struct power_supply_desc psy_desc;
> +       int psy_status;
> +       int battery_percentage;
> +       struct charger_data *charger;
> +       unsigned long last_update;
> +};
> +
> +struct charger_data {
> +       struct device *dev;
> +       struct cros_ec_dev *ec_dev;
> +       struct cros_ec_device *ec_device;

Wow that is confusing, ec_dev vs. ec_device.

> +       int num_registered_psy;
> +       struct port_data *ports[EC_PCHG_MAX_PORTS];
> +       struct notifier_block notifier;
> +};
> +
> +static enum power_supply_property cros_pchg_props[] = {

Can this be const?

> +       POWER_SUPPLY_PROP_STATUS,
> +       POWER_SUPPLY_PROP_CAPACITY,
> +       POWER_SUPPLY_PROP_SCOPE,
> +       /*
> +        * todo: Add the following.

TODO

> +        *
> +        * POWER_SUPPLY_PROP_TECHNOLOGY,
> +        * POWER_SUPPLY_PROP_ERROR,
> +        * POWER_SUPPLY_PROP_SERIAL_NUMBER,
> +        *
> +        * POWER_SUPPLY_PROP_ONLINE can't be used because it indicates the
> +        * system is powered by AC.
> +        */
> +};
> +
> +static int cros_pchg_ec_command(const struct charger_data *charger,
> +                               unsigned int version,
> +                               unsigned int command,
> +                               const void *outdata,
> +                               unsigned int outsize,
> +                               void *indata,
> +                               unsigned int insize)
> +{
> +       struct cros_ec_dev *ec_dev = charger->ec_dev;
> +       struct cros_ec_command *msg;
> +       int ret;
> +
> +       msg = kzalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL);
> +       if (!msg)
> +               return -ENOMEM;
> +
> +       msg->version = version;
> +       msg->command = ec_dev->cmd_offset + command;
> +       msg->outsize = outsize;
> +       msg->insize = insize;
> +
> +       if (outsize)
> +               memcpy(msg->data, outdata, outsize);
> +
> +       ret = cros_ec_cmd_xfer_status(charger->ec_device, msg);
> +       if (ret >= 0 && insize)
> +               memcpy(indata, msg->data, insize);
> +
> +       kfree(msg);
> +       return ret;
> +}
> +
> +static const unsigned int pchg_cmd_version = 1;

Use a #define? I don't see the point in adding a symbol to the symbol
table for this.

> +
> +static bool cros_pchg_cmd_ver_check(const struct charger_data *charger)
> +{
> +       struct ec_params_get_cmd_versions_v1 req;
> +       struct ec_response_get_cmd_versions rsp;
> +       int ret;
> +
> +       req.cmd = EC_CMD_PCHG;
> +       ret = cros_pchg_ec_command(charger, 1, EC_CMD_GET_CMD_VERSIONS,
> +                                  &req, sizeof(req), &rsp, sizeof(rsp));
> +       if (ret < 0) {
> +               dev_warn(charger->dev,
> +                        "Unable to get versions of EC_CMD_PCHG (err:%d)\n",
> +                        ret);
> +               return false;
> +       }
> +
> +       return !!(rsp.version_mask & BIT(pchg_cmd_version));
> +}
> +
> +static int cros_pchg_port_count(const struct charger_data *charger)
> +{
> +       struct ec_response_pchg_count rsp;
> +       int ret;
> +
> +       ret = cros_pchg_ec_command(charger, 0, EC_CMD_PCHG_COUNT,
> +                                  NULL, 0, &rsp, sizeof(rsp));
> +       if (ret < 0) {
> +               dev_warn(charger->dev,
> +                        "Unable to get number or ports (err:%d)\n", ret);

number of ports?

> +               return ret;
> +       }
> +
> +       return rsp.port_count;
> +}
> +
> +static int cros_pchg_get_status(struct port_data *port)
> +{
> +       struct charger_data *charger = port->charger;
> +       struct ec_params_pchg req;
> +       struct ec_response_pchg rsp;
> +       struct device *dev = charger->dev;
> +       int old_status = port->psy_status;
> +       int old_percentage = port->battery_percentage;
> +       int ret;
> +
> +       req.port = port->port_number;
> +       ret = cros_pchg_ec_command(charger, pchg_cmd_version, EC_CMD_PCHG,
> +                                  &req, sizeof(req), &rsp, sizeof(rsp));
> +       if (ret < 0) {
> +               dev_err(dev, "Unable to get port.%d status (err:%d)\n",
> +                       port->port_number, ret);
> +               return ret;
> +       }
> +
> +       switch (rsp.state) {
> +       case PCHG_STATE_RESET:
> +       case PCHG_STATE_INITIALIZED:
> +       case PCHG_STATE_ENABLED:
> +       default:
> +               port->psy_status = POWER_SUPPLY_STATUS_UNKNOWN;
> +               break;
> +       case PCHG_STATE_DETECTED:
> +               port->psy_status = POWER_SUPPLY_STATUS_NOT_CHARGING;
> +               break;
> +       case PCHG_STATE_CHARGING:
> +               port->psy_status = POWER_SUPPLY_STATUS_CHARGING;
> +               break;
> +       case PCHG_STATE_FULL:
> +               port->psy_status = POWER_SUPPLY_STATUS_FULL;
> +               break;
> +       }
> +
> +       port->battery_percentage = rsp.battery_percentage;
> +
> +       if (port->psy_status != old_status
> +                       || port->battery_percentage != old_percentage)

	if (port->psy_status != old_status ||
	    port->battery_percentage != old_percentage)

> +               power_supply_changed(port->psy);
> +
> +       dev_dbg(dev,
> +               "Port %d: state=%d battery=%d%%\n",

What's with the two % after %d?

> +               port->port_number, rsp.state, rsp.battery_percentage);
> +
> +       return 0;
> +}
> +
> +static int cros_pchg_get_port_status(struct port_data *port, bool ratelimit)
> +{
> +       int ret;
> +
> +       if (ratelimit &&
> +           time_is_after_jiffies(port->last_update + PCHG_CACHE_UPDATE_DELAY))
> +               return 0;
> +
> +       ret = cros_pchg_get_status(port);
> +       if (ret < 0)
> +               return ret;
> +
> +       port->last_update = jiffies;
> +
> +       return ret;

Could be shorter

	ret = cros_pchg_get_status(port)
	if (ret >= 0)
		port->last_update = jiffies;

	return ret;

> +}
> +
> +static int cros_pchg_get_prop(struct power_supply *psy,
> +                             enum power_supply_property psp,
> +                             union power_supply_propval *val)
> +{
> +       struct port_data *port = power_supply_get_drvdata(psy);
> +
> +       switch (psp) {
> +       case POWER_SUPPLY_PROP_STATUS:
> +       case POWER_SUPPLY_PROP_CAPACITY:
> +               cros_pchg_get_port_status(port, true);
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       switch (psp) {
> +       case POWER_SUPPLY_PROP_STATUS:
> +               val->intval = port->psy_status;
> +               break;
> +       case POWER_SUPPLY_PROP_CAPACITY:
> +               val->intval = port->battery_percentage;
> +               break;
> +       case POWER_SUPPLY_PROP_SCOPE:
> +               val->intval = POWER_SUPPLY_SCOPE_DEVICE;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static int cros_pchg_event(const struct charger_data *charger,
> +                          unsigned long host_event)
> +{
> +       int i;
> +
> +       for (i = 0; i < charger->num_registered_psy; i++)
> +               cros_pchg_get_port_status(charger->ports[i], false);
> +
> +       return NOTIFY_OK;
> +}
> +
> +static u32 cros_get_device_event(const struct charger_data *charger)
> +{
> +       struct ec_params_device_event req;

Maybe use dot initializer? i.e.

	struct ec_params_device_event req = {
		.param = EC_DEVICE_EVENT_PARAM_GET_CURRENT_EVENTS,
	};

> +       struct ec_response_device_event rsp;
> +       struct device *dev = charger->dev;
> +       int ret;
> +
> +       req.param = EC_DEVICE_EVENT_PARAM_GET_CURRENT_EVENTS;

Because otherwise I don't see the other member of req being initialized.

> +       ret = cros_pchg_ec_command(charger, 0, EC_CMD_DEVICE_EVENT,
> +                                  &req, sizeof(req), &rsp, sizeof(rsp));
> +       if (ret < 0) {
> +               dev_warn(dev, "Unable to get device events (err:%d)\n", ret);
> +               return 0;
> +       }
> +
> +       return rsp.event_mask;
> +}
> +
> +static int cros_ec_notify(struct notifier_block *nb,
> +                         unsigned long queued_during_suspend,
> +                         void *data)
> +{
> +       struct cros_ec_device *ec_dev = (struct cros_ec_device *)data;
> +       u32 host_event = cros_ec_get_host_event(ec_dev);
> +       struct charger_data *charger =
> +                       container_of(nb, struct charger_data, notifier);
> +       u32 device_event_mask;
> +
> +       if (!host_event)
> +               return NOTIFY_DONE;
> +
> +       if (!(host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_DEVICE)))
> +               return NOTIFY_DONE;
> +
> +       /*
> +        * todo: Retrieve device event mask in common place

TODO

> +        * (e.g. cros_ec_proto.c).
> +        */
> +       device_event_mask = cros_get_device_event(charger);
> +       if (!(device_event_mask & EC_DEVICE_EVENT_MASK(EC_DEVICE_EVENT_WLC)))
> +               return NOTIFY_DONE;
> +
> +       return cros_pchg_event(charger, host_event);
> +}
> +
> +static int cros_pchg_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
> +       struct cros_ec_device *ec_device = ec_dev->ec_dev;
> +       struct power_supply_desc *psy_desc;
> +       struct charger_data *charger;
> +       struct power_supply *psy;
> +       struct port_data *port;
> +       struct notifier_block *nb;
> +       int num_ports;
> +       int ret;
> +       int i;
> +
> +       charger = devm_kzalloc(dev, sizeof(*charger), GFP_KERNEL);
> +       if (!charger)
> +               return -ENOMEM;
> +
> +       charger->dev = dev;
> +       charger->ec_dev = ec_dev;
> +       charger->ec_device = ec_device;
> +
> +       ret = cros_pchg_port_count(charger);
> +       if (ret <= 0) {
> +               /*
> +                * This feature is enabled by the EC and the kernel driver is

Can we query the EC before adding this device to the platform bus? The
idea is don't add the device until we know the cros_pchg_port_count()
functions returns a value > 0. Then this driver won't even probe unless
there is something to do, and this logic here can be dropped.

> +                * included by default for CrOS devices. Don't need to be loud
> +                * since this error can be normal.
> +                */
> +               dev_info(dev, "No peripheral charge ports (err:%d)\n", ret);
> +               return -ENODEV;
> +       }
> +
> +       if (!cros_pchg_cmd_ver_check(charger)) {
> +               dev_err(dev, "EC_CMD_PCHG version %d isn't available.\n",
> +                       pchg_cmd_version);
> +               return -ENOTSUPP;

This can probably also be included in that check before adding the
device?

> +       }
> +
> +       num_ports = ret;
> +       if (num_ports > EC_PCHG_MAX_PORTS) {
> +               dev_err(dev, "Too many peripheral charge ports (%d)\n",
> +                       num_ports);
> +               return -ENOBUFS;

And this one too.

> +       }
> +
> +       dev_info(dev, "%d peripheral charge ports found\n", num_ports);
> +
> +       for (i = 0; i < num_ports; i++) {
> +               struct power_supply_config psy_cfg = {};
> +
> +               port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> +               if (!port)
> +                       return -ENOMEM;
> +
> +               port->charger = charger;
> +               port->port_number = i;
> +               snprintf(port->name, sizeof(port->name), PCHG_DIR_NAME, i);
> +
> +               psy_desc = &port->psy_desc;
> +               psy_desc->name = port->name;
> +               psy_desc->type = POWER_SUPPLY_TYPE_BATTERY;
> +               psy_desc->get_property = cros_pchg_get_prop;
> +               psy_desc->external_power_changed = NULL;
> +               psy_desc->properties = cros_pchg_props;
> +               psy_desc->num_properties = ARRAY_SIZE(cros_pchg_props);
> +               psy_cfg.drv_data = port;
> +
> +               psy = devm_power_supply_register(dev, psy_desc, &psy_cfg);
> +               if (IS_ERR(psy))
> +                       return dev_err_probe(
> +                                       dev, ERR_PTR(psy),
> +                                       "Failed to register power supply\n");

Please write it as

			return dev_err_probe(dev, ERR_PTR(psy),
					     "Failed to register...");

> +               port->psy = psy;
> +
> +               charger->ports[charger->num_registered_psy++] = port;
> +       }
> +
> +       if (!charger->num_registered_psy)

How is this possible? num_ports should be at least 1 right?

> +               return -ENODEV;
> +
> +       nb = &charger->notifier;
> +       nb->notifier_call = cros_ec_notify;
> +       ret = blocking_notifier_chain_register(&ec_dev->ec_dev->event_notifier,
> +                                              nb);
> +       if (ret < 0)
> +               dev_err(dev, "Failed to register notifier (err:%d)\n", ret);
> +
> +       return 0;

return ret?

> +}
> +
> +static struct platform_driver cros_pchg_driver = {
> +       .driver = {
> +               .name = DRV_NAME,
> +       },
> +       .probe = cros_pchg_probe
> +};
> +
> +module_platform_driver(cros_pchg_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("ChromeOS EC peripheral device charger");
> +MODULE_ALIAS("platform:" DRV_NAME);
