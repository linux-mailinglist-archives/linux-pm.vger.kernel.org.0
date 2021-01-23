Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54DA73017B5
	for <lists+linux-pm@lfdr.de>; Sat, 23 Jan 2021 19:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbhAWSoS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 23 Jan 2021 13:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbhAWSoQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 23 Jan 2021 13:44:16 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4F4C061786
        for <linux-pm@vger.kernel.org>; Sat, 23 Jan 2021 10:43:36 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id h11so18163749ioh.11
        for <linux-pm@vger.kernel.org>; Sat, 23 Jan 2021 10:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+y7dlJaDR3Qrx/xDqSHaNWr1pBnZnp+D5oBgGoBDw0s=;
        b=cbjzFQ4j8h4bjBjZb1yyVT2itAb/ik1PSU4MFUqvIJqumtcGCtMPigUP8yclu/zJ8N
         tf2sM7n2dEa2Zu+BD2kEiAipdQU/qf74BhZJsZtY2SR6peboI5gXQm0RjvEEFET0ztFl
         7fQ2HclV2qlXC87tH70JkWBfUpbWd0RLIRadI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+y7dlJaDR3Qrx/xDqSHaNWr1pBnZnp+D5oBgGoBDw0s=;
        b=mJga/nBPh05Hkork+86P/bbqPGK7ubs0fNrm31gQo358G8KHvw5pnSANem+jNpr6jL
         BA4bt1kl5+Jep7nBOASnfss+xOxrNisG/a5yMnZLxeFRjURtqCn05QT3pw1PE1ReeFRB
         NTuigqaz6b+EAgrZTfq8ljFGP1nUIxvSEdh40WDGdtO5/DVdWIas5S6MPuxULRLeOHVZ
         +SsanevJoWuzEDD82j8Ci59L8F2/mICjTty05ldL+6gb1CQqGPEyTepI/pzsAbmuMTvw
         xBbva8q/wQuC+oLiUoFsYKC0Q2XXnPJRRskYWELAFF629dy52dh9tz/fYARN0LiC0oEM
         gllw==
X-Gm-Message-State: AOAM531WOyEReUuXdV2MxGQnyhW3D5+ihsrrbpzUfrjEyBndJjWocHsK
        QmmHvxegkYU4P9WY5CR4tOXjKLMv432dPdOoUFnhcw==
X-Google-Smtp-Source: ABdhPJynkdMyx5arrLj/K9ki1RielzNvFayC+onbCTIAPUvaB8mBf/exSmI2ODoA4tR//99gBo1xy0c0baAQtXI6nzI=
X-Received: by 2002:a02:5ec1:: with SMTP id h184mr3886447jab.133.1611427415340;
 Sat, 23 Jan 2021 10:43:35 -0800 (PST)
MIME-Version: 1.0
References: <20210123154922.1309290-1-dnojiri@chromium.org>
In-Reply-To: <20210123154922.1309290-1-dnojiri@chromium.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Sat, 23 Jan 2021 10:43:23 -0800
Message-ID: <CAPUE2uuf-dZ-0gy81+GQ3G8GDVmZhBSbj4bpP3aLS6EL2PZG0g@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] power: supply: PCHG: Peripheral device charger
To:     Daisuke Nojiri <dnojiri@chromium.org>
Cc:     Vincent Palatin <vpalatin@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Sebastian Reichel <sre@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Ching-Kang Yen <chingkang@chromium.org>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Vijay Hiremath <vijay.p.hiremath@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jan 23, 2021 at 7:53 AM Daisuke Nojiri <dnojiri@chromium.org> wrote:
>
> This patch adds a driver for PCHG (Peripheral CHarGer). PCHG is a
> framework managing power supplies for peripheral devices.
>
> This driver creates a sysfs node for each peripheral charge port:
>
>         /sys/class/power_supply/PCHGn
>
> where <n> is the index of a charge port.
>
> For example, when a stylus is connected to a NFC/WLC port, the node
> prints:
>
>         /sys/class/power_supply/PCHG0/
>                 capacity=50
>                 scope=Device
>                 status=Charging
>                 type=Battery
>
> Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
> ---
> v1 -> v2
> * Separate mfd/cros_ec_dev.c
> * Make CONFIG_CHARGER_CROS_PCHG default to CONFIG_MFD_CROS_EC_DEV
> v2 -> v3
> * Return POWER_SUPPLY_SCOPE_DEVICE for POWER_SUPPLY_PROP_SCOPE
> * POWER_SUPPLY_TYPE_WIRELESS -> POWER_SUPPLY_TYPE_BATTERY
> v3 -> v4
> * Return NOTIFY_DONE when a non-host event is notified.
> ---
>  drivers/power/supply/Kconfig                  |  10 +
>  drivers/power/supply/Makefile                 |   1 +
>  .../power/supply/cros_peripheral_charger.c    | 350 ++++++++++++++++++
>  .../linux/platform_data/cros_ec_commands.h    |  48 +++
>  4 files changed, 409 insertions(+)
>  create mode 100644 drivers/power/supply/cros_peripheral_charger.c
>
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index eec646c568b7be..407f9fbbc2bb50 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -714,6 +714,16 @@ config CHARGER_CROS_USBPD
>           what is connected to USB PD ports from the EC and converts
>           that into power_supply properties.
>
> +config CHARGER_CROS_PCHG
> +       tristate "ChromeOS EC based peripheral charger"
> +       depends on MFD_CROS_EC_DEV
> +       default MFD_CROS_EC_DEV
> +       help
> +         Say Y here to enable ChromeOS EC based peripheral charge driver.
> +         This driver gets various information about the devices connected to
> +         the peripheral charge ports from the EC and converts that into
> +         power_supply properties.
> +
>  config CHARGER_SC2731
>         tristate "Spreadtrum SC2731 charger driver"
>         depends on MFD_SC27XX_PMIC || COMPILE_TEST
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index dd4b86318cd9bd..5263472a64809b 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -91,6 +91,7 @@ obj-$(CONFIG_CHARGER_TPS65217)        += tps65217_charger.o
>  obj-$(CONFIG_AXP288_FUEL_GAUGE) += axp288_fuel_gauge.o
>  obj-$(CONFIG_AXP288_CHARGER)   += axp288_charger.o
>  obj-$(CONFIG_CHARGER_CROS_USBPD)       += cros_usbpd-charger.o
> +obj-$(CONFIG_CHARGER_CROS_PCHG)        += cros_peripheral_charger.o
>  obj-$(CONFIG_CHARGER_SC2731)   += sc2731_charger.o
>  obj-$(CONFIG_FUEL_GAUGE_SC27XX)        += sc27xx_fuel_gauge.o
>  obj-$(CONFIG_CHARGER_UCS1002)  += ucs1002_power.o
> diff --git a/drivers/power/supply/cros_peripheral_charger.c b/drivers/power/supply/cros_peripheral_charger.c
> new file mode 100644
> index 00000000000000..cd7db4bd5f90d0
> --- /dev/null
> +++ b/drivers/power/supply/cros_peripheral_charger.c
> @@ -0,0 +1,350 @@
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
Add

> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/slab.h>
> +#include <linux/stringify.h>
> +#include <linux/types.h>
> +
> +#define DRV_NAME               "cros-ec-pchg"
> +#define PCHG_DIR_NAME          "PCHG%d"
nit: to be coherent with function names, define CROS_EC_PCHG_DIR_NAME instead.
Isn't PCHG0, PCHG1, ... too generic? Looking at other driver, we have
strings like
"max1721x-%012X", "wm831x-battery.%d",
> +#define PCHG_DIR_NAME_LENGTH   sizeof("PCHG" __stringify(EC_PCHG_MAX_PORTS))
> +#define PCHG_CACHE_UPDATE_DELAY        msecs_to_jiffies(500)
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
As far as I can see, ec_device is used only once, in cros_pchg_ec_command().
> +       int num_registered_psy;
> +       struct port_data *ports[EC_PCHG_MAX_PORTS];
> +       struct notifier_block notifier;
> +};
> +
> +static enum power_supply_property cros_pchg_props[] = {
> +       POWER_SUPPLY_PROP_STATUS,
> +       POWER_SUPPLY_PROP_CAPACITY,
> +       POWER_SUPPLY_PROP_SCOPE,
> +       /*
> +        * todo: Add the following.
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
> +       int ret;
> +
> +       req.port = port->port_number;
> +       ret = cros_pchg_ec_command(charger, 0, EC_CMD_PCHG,
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
> +               port->battery_percentage = 0;
> +               break;
> +       case PCHG_STATE_DETECTED:
> +               port->psy_status = POWER_SUPPLY_STATUS_NOT_CHARGING;
> +               port->battery_percentage = rsp.battery_percentage;
> +               break;
> +       case PCHG_STATE_CHARGING:
> +               port->psy_status = POWER_SUPPLY_STATUS_CHARGING;
> +               port->battery_percentage = rsp.battery_percentage;
> +               break;
> +       }
> +
> +       dev_dbg(dev,
> +               "Port %d: state=%d battery=%d%%\n",
> +               port->port_number, rsp.state, rsp.battery_percentage);
> +
> +       return 0;
Looking at other drivers (drivers/power/supply/ds2760_battery.c for
instance), power_supply_changed() is called when status changes.
Should we?
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
> +       struct ec_response_device_event rsp;
> +       struct device *dev = charger->dev;
> +       int ret;
> +
> +       req.param = EC_DEVICE_EVENT_PARAM_GET_CURRENT_EVENTS;
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
cros_pchg_notify instead to preserve naming convention.
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
psy_desc is a local variable of the for loop line 297.
> +       struct charger_data *charger;
> +       struct power_supply *psy;
> +       struct port_data *port;
port is a local variable of the for loop line 297.
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
Usually, we call platform_set_drvdata(pdev, charger) to tie the
private data and the platform data together.
> +       charger->ec_dev = ec_dev;
> +       charger->ec_device = ec_device;
> +
> +       ret = cros_pchg_port_count(charger);
> +       if (ret <= 0) {
> +               /*
> +                * This feature is enabled by the EC and the kernel driver is
> +                * included by default for CrOS devices. Don't need to be loud
> +                * since this error can be normal.
> +                */
There is the same problem with iio sensors: we export
"cros_ec_get_sensor_count()" and use it in ec_device_probe(). To be
coherent, we can either export cros_pchg_port_count or call the sensor
stack even when there are no sensors reported. I prefer the former,
more generic.
> +               dev_info(dev, "No peripheral charge ports (err:%d)\n", ret);
> +               return -ENODEV;
> +       }
> +
> +       num_ports = ret;
> +       if (num_ports > EC_PCHG_MAX_PORTS) {
> +               dev_err(dev, "Too many peripheral charge ports (%d)\n",
> +                       num_ports);
> +               return -ENOBUFS;
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
nit: shall we fail probing the whole device or just the power supply
port? Here we fail the whole device, later just the port.
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
> +               psy = devm_power_supply_register_no_ws(dev, psy_desc, &psy_cfg);
> +               if (IS_ERR(psy)) {
> +                       dev_err(dev, "Failed to register power supply\n");
> +                       continue;
> +               }
> +               port->psy = psy;
> +
> +               charger->ports[charger->num_registered_psy++] = port;
> +       }
> +
> +       if (!charger->num_registered_psy)
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
> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
> index 5a3ccf8968968e..6a82a9ad99eadf 100644
> --- a/include/linux/platform_data/cros_ec_commands.h
> +++ b/include/linux/platform_data/cros_ec_commands.h
> @@ -4249,6 +4249,7 @@ enum ec_device_event {
>         EC_DEVICE_EVENT_TRACKPAD,
>         EC_DEVICE_EVENT_DSP,
>         EC_DEVICE_EVENT_WIFI,
> +       EC_DEVICE_EVENT_WLC,
>  };
>
>  enum ec_device_event_param {
> @@ -5480,6 +5481,53 @@ struct ec_response_rollback_info {
>  /* Issue AP reset */
>  #define EC_CMD_AP_RESET 0x0125
>
> +/**
> + * Get the number of peripheral charge ports
> + */
> +#define EC_CMD_PCHG_COUNT 0x0134
> +
> +#define EC_PCHG_MAX_PORTS 8
> +
> +struct ec_response_pchg_count {
> +       uint8_t port_count;
> +} __ec_align1;
> +
> +/**
> + * Get the status of a peripheral charge port
> + */
> +#define EC_CMD_PCHG 0x0135
> +
> +struct ec_params_pchg {
> +       uint8_t port;
> +} __ec_align1;
> +
> +struct ec_response_pchg {
> +       uint32_t error; /* enum pchg_error */
> +       uint8_t state; /* enum pchg_state state */
> +       uint8_t battery_percentage;
> +} __ec_align2;
> +
> +enum pchg_state {
> +       /* Charger is reset and not initialized. */
> +       PCHG_STATE_RESET = 0,
> +       /* Charger is initialized or disabled. */
> +       PCHG_STATE_INITIALIZED,
> +       /* Charger is enabled and ready to detect a device. */
> +       PCHG_STATE_ENABLED,
> +       /* Device is detected in proximity. */
> +       PCHG_STATE_DETECTED,
> +       /* Device is being charged. */
> +       PCHG_STATE_CHARGING,
> +};
> +
> +#define EC_PCHG_STATE_TEXT { \
> +       [PCHG_STATE_RESET] = "RESET", \
> +       [PCHG_STATE_INITIALIZED] = "INITIALIZED", \
> +       [PCHG_STATE_ENABLED] = "ENABLED", \
> +       [PCHG_STATE_DETECTED] = "DETECTED", \
> +       [PCHG_STATE_CHARGING] = "CHARGING", \
> +       }
> +
>  /*****************************************************************************/
>  /* Locate peripheral chips
>   *
> --
> 2.30.0.280.ga3ce27912f-goog
>
