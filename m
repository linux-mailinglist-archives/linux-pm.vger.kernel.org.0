Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A6D2F6963
	for <lists+linux-pm@lfdr.de>; Thu, 14 Jan 2021 19:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbhANSUe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Jan 2021 13:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbhANSUd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jan 2021 13:20:33 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AC6C061757
        for <linux-pm@vger.kernel.org>; Thu, 14 Jan 2021 10:19:52 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id c22so4297593pgg.13
        for <linux-pm@vger.kernel.org>; Thu, 14 Jan 2021 10:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q3PGhrh5A2Rr01NHG2bKOCGtODN+DK8+x1R1DeNE5Wg=;
        b=nuM7kk6mk/9PfbvzI1YGJqSDxUt62lTkaDXh0iFjtIqmDnhart9fTD3qDmKTMcPQM2
         azmOLxyC9vI99VWiddBgpQWR3aflU4hK0bia5IeiAmARPKBr6NMEOcJ6x2UaV9PfibVG
         6+C1y2E/XhFpnspnAVjYX4PbgBDlK+h9gfeXmtQhlL2jccnmejoltQXgEIX0wXrNM/Mo
         mhSAR7jpl9F5qzFv8QHBwbzn/mWlSMEt4IMEhWCQGK1qUHSmdX9tOwy0VjQLV5Q8walh
         XAIz6+AtDAs6szcYDgDWbULSptp4otARq9ZPKcgEJyz3FbF7NCO7eM6UTEmNMm3smHSB
         BMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q3PGhrh5A2Rr01NHG2bKOCGtODN+DK8+x1R1DeNE5Wg=;
        b=cFtZPM8DD1H6C5AbidFwcHn7Tk71V44G8/Hnpa1Sc/6FY4QD9MowJ9PFkuiBlkN3ld
         tWLAb/1Y5pCQ1hUPan+sGlROOhKi07xEp1ECpR+W8qDY4TzGkwIAkmeTPY0BUlBc43kC
         7luz/NUtgA0wlKO93zgU+8J6w3oxwOheNPyTOgMGMnqw0gpANeHaCCfXJV0arDs8+KDx
         xHlpFlaIuERi+7MutAlJBYq0IBKKxhHPP18qSI54PAt6y3apgwxEyPlLVFebp/Texorz
         2uQ7LXQMJDQu9jbDjgezC8DiSJD65sZewxlsff+ijtW+lrL2QviWCEGfJ2EF4DE9gVIZ
         +RjQ==
X-Gm-Message-State: AOAM531wxzXaQQSVIv0Rqg8JCU77j1+IPG79xH0P1cpUWDMi2485J5Ow
        +wkzxcv2GoZ8z3SSU9wYKBcscg==
X-Google-Smtp-Source: ABdhPJwABc6YJXjRgpurYM9Po/iOtzcY3fB+V+T61bcFsWRb+obttztD709aY+RyuCeWWaMSsMHmrw==
X-Received: by 2002:a63:6686:: with SMTP id a128mr8642482pgc.96.1610648391789;
        Thu, 14 Jan 2021 10:19:51 -0800 (PST)
Received: from google.com ([2620:15c:202:201:f693:9fff:fef4:fc72])
        by smtp.gmail.com with ESMTPSA id l3sm2115644pjz.27.2021.01.14.10.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 10:19:50 -0800 (PST)
Date:   Thu, 14 Jan 2021 10:19:44 -0800
From:   Benson Leung <bleung@google.com>
To:     Daisuke Nojiri <dnojiri@chromium.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     vpalatin@chromium.org, Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
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
Message-ID: <YACLQBf4KA4uJ6rW@google.com>
References: <20201216163416.2969209-1-dnojiri@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="D660Sa2aIkTuYR87"
Content-Disposition: inline
In-Reply-To: <20201216163416.2969209-1-dnojiri@chromium.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--D660Sa2aIkTuYR87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

On Wed, Dec 16, 2020 at 08:34:15AM -0800, Daisuke Nojiri wrote:
> This patch adds a driver for PCHG (Peripheral CHarGer). PCHG is a
> framework managing power supplies for peripheral devices.
>=20
> This driver creates a sysfs node for each peripheral charge port:
>=20
> 	/sys/class/power_supply/PCHGn
>=20
> where <n> is the index of a charge port.
>=20
> For example, when a stylus is connected to a NFC/WLC port, the node
> prints:
>=20
> 	/sys/class/power_supply/PCHG0/
> 		capacity=3D50
> 		status=3DCharging
> 		type=3DWireless
>=20
> Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>

This change seems reasonable to me. I've reviewed the cros_ec_commands head=
er,
and it looks good.

Sebastian, do you have any comments on this? I can merge this through the
chrome/platform tree if we have your Acked-By.

Thanks,
Benson


> ---
> v1 -> v2
> * Separate mfd/cros_ec_dev.c
> * Make CONFIG_CHARGER_CROS_PCHG default to CONFIG_MFD_CROS_EC_DEV
> ---
>=20
>  drivers/power/supply/Kconfig                  |  10 +
>  drivers/power/supply/Makefile                 |   1 +
>  .../power/supply/cros_peripheral_charger.c    | 346 ++++++++++++++++++
>  .../linux/platform_data/cros_ec_commands.h    |  48 +++
>  4 files changed, 405 insertions(+)
>  create mode 100644 drivers/power/supply/cros_peripheral_charger.c
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index eec646c568b7be..407f9fbbc2bb50 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -714,6 +714,16 @@ config CHARGER_CROS_USBPD
>  	  what is connected to USB PD ports from the EC and converts
>  	  that into power_supply properties.
> =20
> +config CHARGER_CROS_PCHG
> +	tristate "ChromeOS EC based peripheral charger"
> +	depends on MFD_CROS_EC_DEV
> +	default MFD_CROS_EC_DEV
> +	help
> +	  Say Y here to enable ChromeOS EC based peripheral charge driver.
> +	  This driver gets various information about the devices connected to
> +	  the peripheral charge ports from the EC and converts that into
> +	  power_supply properties.
> +
>  config CHARGER_SC2731
>  	tristate "Spreadtrum SC2731 charger driver"
>  	depends on MFD_SC27XX_PMIC || COMPILE_TEST
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index dd4b86318cd9bd..5263472a64809b 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -91,6 +91,7 @@ obj-$(CONFIG_CHARGER_TPS65217)	+=3D tps65217_charger.o
>  obj-$(CONFIG_AXP288_FUEL_GAUGE) +=3D axp288_fuel_gauge.o
>  obj-$(CONFIG_AXP288_CHARGER)	+=3D axp288_charger.o
>  obj-$(CONFIG_CHARGER_CROS_USBPD)	+=3D cros_usbpd-charger.o
> +obj-$(CONFIG_CHARGER_CROS_PCHG)	+=3D cros_peripheral_charger.o
>  obj-$(CONFIG_CHARGER_SC2731)	+=3D sc2731_charger.o
>  obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+=3D sc27xx_fuel_gauge.o
>  obj-$(CONFIG_CHARGER_UCS1002)	+=3D ucs1002_power.o
> diff --git a/drivers/power/supply/cros_peripheral_charger.c b/drivers/pow=
er/supply/cros_peripheral_charger.c
> new file mode 100644
> index 00000000000000..db68d3b7c80f32
> --- /dev/null
> +++ b/drivers/power/supply/cros_peripheral_charger.c
> @@ -0,0 +1,346 @@
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
> +#define DRV_NAME		"cros-ec-pchg"
> +#define PCHG_DIR_NAME		"PCHG%d"
> +#define PCHG_DIR_NAME_LENGTH	sizeof("PCHG" __stringify(EC_PCHG_MAX_PORTS=
))
> +#define PCHG_CACHE_UPDATE_DELAY	msecs_to_jiffies(500)
> +
> +struct port_data {
> +	int port_number;
> +	char name[PCHG_DIR_NAME_LENGTH];
> +	struct power_supply *psy;
> +	struct power_supply_desc psy_desc;
> +	int psy_status;
> +	int battery_percentage;
> +	struct charger_data *charger;
> +	unsigned long last_update;
> +};
> +
> +struct charger_data {
> +	struct device *dev;
> +	struct cros_ec_dev *ec_dev;
> +	struct cros_ec_device *ec_device;
> +	int num_registered_psy;
> +	struct port_data *ports[EC_PCHG_MAX_PORTS];
> +	struct notifier_block notifier;
> +};
> +
> +static enum power_supply_property cros_pchg_props[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	/*
> +	 * todo: Add the following.
> +	 *
> +	 * POWER_SUPPLY_PROP_TECHNOLOGY,
> +	 * POWER_SUPPLY_PROP_ERROR,
> +	 * POWER_SUPPLY_PROP_SERIAL_NUMBER,
> +	 *
> +	 * POWER_SUPPLY_PROP_ONLINE can't be used because it indicates the
> +	 * system is powered by AC.
> +	 */
> +};
> +
> +static int cros_pchg_ec_command(const struct charger_data *charger,
> +				unsigned int version,
> +				unsigned int command,
> +				const void *outdata,
> +				unsigned int outsize,
> +				void *indata,
> +				unsigned int insize)
> +{
> +	struct cros_ec_dev *ec_dev =3D charger->ec_dev;
> +	struct cros_ec_command *msg;
> +	int ret;
> +
> +	msg =3D kzalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	msg->version =3D version;
> +	msg->command =3D ec_dev->cmd_offset + command;
> +	msg->outsize =3D outsize;
> +	msg->insize =3D insize;
> +
> +	if (outsize)
> +		memcpy(msg->data, outdata, outsize);
> +
> +	ret =3D cros_ec_cmd_xfer_status(charger->ec_device, msg);
> +	if (ret >=3D 0 && insize)
> +		memcpy(indata, msg->data, insize);
> +
> +	kfree(msg);
> +	return ret;
> +}
> +
> +static int cros_pchg_port_count(const struct charger_data *charger)
> +{
> +	struct ec_response_pchg_count rsp;
> +	int ret;
> +
> +	ret =3D cros_pchg_ec_command(charger, 0, EC_CMD_PCHG_COUNT,
> +				   NULL, 0, &rsp, sizeof(rsp));
> +	if (ret < 0) {
> +		dev_warn(charger->dev,
> +			 "Unable to get number or ports (err:%d)\n", ret);
> +		return ret;
> +	}
> +
> +	return rsp.port_count;
> +}
> +
> +static int cros_pchg_get_status(struct port_data *port)
> +{
> +	struct charger_data *charger =3D port->charger;
> +	struct ec_params_pchg req;
> +	struct ec_response_pchg rsp;
> +	struct device *dev =3D charger->dev;
> +	int ret;
> +
> +	req.port =3D port->port_number;
> +	ret =3D cros_pchg_ec_command(charger, 0, EC_CMD_PCHG,
> +				   &req, sizeof(req), &rsp, sizeof(rsp));
> +	if (ret < 0) {
> +		dev_err(dev, "Unable to get port.%d status (err:%d)\n",
> +			port->port_number, ret);
> +		return ret;
> +	}
> +
> +	switch (rsp.state) {
> +	case PCHG_STATE_RESET:
> +	case PCHG_STATE_INITIALIZED:
> +	case PCHG_STATE_ENABLED:
> +	default:
> +		port->psy_status =3D POWER_SUPPLY_STATUS_UNKNOWN;
> +		port->battery_percentage =3D 0;
> +		break;
> +	case PCHG_STATE_DETECTED:
> +		port->psy_status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		port->battery_percentage =3D rsp.battery_percentage;
> +		break;
> +	case PCHG_STATE_CHARGING:
> +		port->psy_status =3D POWER_SUPPLY_STATUS_CHARGING;
> +		port->battery_percentage =3D rsp.battery_percentage;
> +		break;
> +	}
> +
> +	dev_dbg(dev,
> +		"Port %d: state=3D%d battery=3D%d%%\n",
> +		port->port_number, rsp.state, rsp.battery_percentage);
> +
> +	return 0;
> +}
> +
> +static int cros_pchg_get_port_status(struct port_data *port, bool rateli=
mit)
> +{
> +	int ret;
> +
> +	if (ratelimit &&
> +	    time_is_after_jiffies(port->last_update + PCHG_CACHE_UPDATE_DELAY))
> +		return 0;
> +
> +	ret =3D cros_pchg_get_status(port);
> +	if (ret < 0)
> +		return ret;
> +
> +	port->last_update =3D jiffies;
> +
> +	return ret;
> +}
> +
> +static int cros_pchg_get_prop(struct power_supply *psy,
> +			      enum power_supply_property psp,
> +			      union power_supply_propval *val)
> +{
> +	struct port_data *port =3D power_supply_get_drvdata(psy);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +	case POWER_SUPPLY_PROP_CAPACITY:
> +		cros_pchg_get_port_status(port, true);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		val->intval =3D port->psy_status;
> +		break;
> +	case POWER_SUPPLY_PROP_CAPACITY:
> +		val->intval =3D port->battery_percentage;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cros_pchg_event(const struct charger_data *charger,
> +			   unsigned long host_event)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < charger->num_registered_psy; i++)
> +		cros_pchg_get_port_status(charger->ports[i], false);
> +
> +	return NOTIFY_OK;
> +}
> +
> +static u32 cros_get_device_event(const struct charger_data *charger)
> +{
> +	struct ec_params_device_event req;
> +	struct ec_response_device_event rsp;
> +	struct device *dev =3D charger->dev;
> +	int ret;
> +
> +	req.param =3D EC_DEVICE_EVENT_PARAM_GET_CURRENT_EVENTS;
> +	ret =3D cros_pchg_ec_command(charger, 0, EC_CMD_DEVICE_EVENT,
> +				   &req, sizeof(req), &rsp, sizeof(rsp));
> +	if (ret < 0) {
> +		dev_warn(dev, "Unable to get device events (err:%d)\n", ret);
> +		return 0;
> +	}
> +
> +	return rsp.event_mask;
> +}
> +
> +static int cros_ec_notify(struct notifier_block *nb,
> +			  unsigned long queued_during_suspend,
> +			  void *data)
> +{
> +	struct cros_ec_device *ec_dev =3D (struct cros_ec_device *)data;
> +	u32 host_event =3D cros_ec_get_host_event(ec_dev);
> +	struct charger_data *charger =3D
> +			container_of(nb, struct charger_data, notifier);
> +	u32 device_event_mask;
> +
> +	if (!host_event)
> +		return NOTIFY_BAD;
> +
> +	if (!(host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_DEVICE)))
> +		return NOTIFY_DONE;
> +
> +	/*
> +	 * todo: Retrieve device event mask in common place
> +	 * (e.g. cros_ec_proto.c).
> +	 */
> +	device_event_mask =3D cros_get_device_event(charger);
> +	if (!(device_event_mask & EC_DEVICE_EVENT_MASK(EC_DEVICE_EVENT_WLC)))
> +		return NOTIFY_DONE;
> +
> +	return cros_pchg_event(charger, host_event);
> +}
> +
> +static int cros_pchg_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct cros_ec_dev *ec_dev =3D dev_get_drvdata(dev->parent);
> +	struct cros_ec_device *ec_device =3D ec_dev->ec_dev;
> +	struct power_supply_desc *psy_desc;
> +	struct charger_data *charger;
> +	struct power_supply *psy;
> +	struct port_data *port;
> +	struct notifier_block *nb;
> +	int num_ports;
> +	int ret;
> +	int i;
> +
> +	charger =3D devm_kzalloc(dev, sizeof(*charger), GFP_KERNEL);
> +	if (!charger)
> +		return -ENOMEM;
> +
> +	charger->dev =3D dev;
> +	charger->ec_dev =3D ec_dev;
> +	charger->ec_device =3D ec_device;
> +
> +	ret =3D cros_pchg_port_count(charger);
> +	if (ret <=3D 0) {
> +		/*
> +		 * This feature is enabled by the EC and the kernel driver is
> +		 * included by default for CrOS devices. Don't need to be loud
> +		 * since this error can be normal.
> +		 */
> +		dev_info(dev, "No peripheral charge ports (err:%d)\n", ret);
> +		return -ENODEV;
> +	}
> +
> +	num_ports =3D ret;
> +	if (num_ports > EC_PCHG_MAX_PORTS) {
> +		dev_err(dev, "Too many peripheral charge ports (%d)\n",
> +			num_ports);
> +		return -ENOBUFS;
> +	}
> +
> +	dev_info(dev, "%d peripheral charge ports found\n", num_ports);
> +
> +	for (i =3D 0; i < num_ports; i++) {
> +		struct power_supply_config psy_cfg =3D {};
> +
> +		port =3D devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> +		if (!port)
> +			return -ENOMEM;
> +
> +		port->charger =3D charger;
> +		port->port_number =3D i;
> +		snprintf(port->name, sizeof(port->name), PCHG_DIR_NAME, i);
> +
> +		psy_desc =3D &port->psy_desc;
> +		psy_desc->name =3D port->name;
> +		psy_desc->type =3D POWER_SUPPLY_TYPE_WIRELESS;
> +		psy_desc->get_property =3D cros_pchg_get_prop;
> +		psy_desc->external_power_changed =3D NULL;
> +		psy_desc->properties =3D cros_pchg_props;
> +		psy_desc->num_properties =3D ARRAY_SIZE(cros_pchg_props);
> +		psy_cfg.drv_data =3D port;
> +
> +		psy =3D devm_power_supply_register_no_ws(dev, psy_desc, &psy_cfg);
> +		if (IS_ERR(psy)) {
> +			dev_err(dev, "Failed to register power supply\n");
> +			continue;
> +		}
> +		port->psy =3D psy;
> +
> +		charger->ports[charger->num_registered_psy++] =3D port;
> +	}
> +
> +	if (!charger->num_registered_psy)
> +		return -ENODEV;
> +
> +	nb =3D &charger->notifier;
> +	nb->notifier_call =3D cros_ec_notify;
> +	ret =3D blocking_notifier_chain_register(&ec_dev->ec_dev->event_notifie=
r,
> +					       nb);
> +	if (ret < 0)
> +		dev_err(dev, "Failed to register notifier (err:%d)\n", ret);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver cros_pchg_driver =3D {
> +	.driver =3D {
> +		.name =3D DRV_NAME,
> +	},
> +	.probe =3D cros_pchg_probe
> +};
> +
> +module_platform_driver(cros_pchg_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("ChromeOS EC peripheral device charger");
> +MODULE_ALIAS("platform:" DRV_NAME);
> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/lin=
ux/platform_data/cros_ec_commands.h
> index 58495127dfa656..c0f0a032c8beb6 100644
> --- a/include/linux/platform_data/cros_ec_commands.h
> +++ b/include/linux/platform_data/cros_ec_commands.h
> @@ -4225,6 +4225,7 @@ enum ec_device_event {
>  	EC_DEVICE_EVENT_TRACKPAD,
>  	EC_DEVICE_EVENT_DSP,
>  	EC_DEVICE_EVENT_WIFI,
> +	EC_DEVICE_EVENT_WLC,
>  };
> =20
>  enum ec_device_event_param {
> @@ -5456,6 +5457,53 @@ struct ec_response_rollback_info {
>  /* Issue AP reset */
>  #define EC_CMD_AP_RESET 0x0125
> =20
> +/**
> + * Get the number of peripheral charge ports
> + */
> +#define EC_CMD_PCHG_COUNT 0x0134
> +
> +#define EC_PCHG_MAX_PORTS 8
> +
> +struct ec_response_pchg_count {
> +	uint8_t port_count;
> +} __ec_align1;
> +
> +/**
> + * Get the status of a peripheral charge port
> + */
> +#define EC_CMD_PCHG 0x0135
> +
> +struct ec_params_pchg {
> +	uint8_t port;
> +} __ec_align1;
> +
> +struct ec_response_pchg {
> +	uint32_t error; /* enum pchg_error */
> +	uint8_t state; /* enum pchg_state state */
> +	uint8_t battery_percentage;
> +} __ec_align2;
> +
> +enum pchg_state {
> +	/* Charger is reset and not initialized. */
> +	PCHG_STATE_RESET =3D 0,
> +	/* Charger is initialized or disabled. */
> +	PCHG_STATE_INITIALIZED,
> +	/* Charger is enabled and ready to detect a device. */
> +	PCHG_STATE_ENABLED,
> +	/* Device is detected in proximity. */
> +	PCHG_STATE_DETECTED,
> +	/* Device is being charged. */
> +	PCHG_STATE_CHARGING,
> +};
> +
> +#define EC_PCHG_STATE_TEXT { \
> +	[PCHG_STATE_RESET] =3D "RESET", \
> +	[PCHG_STATE_INITIALIZED] =3D "INITIALIZED", \
> +	[PCHG_STATE_ENABLED] =3D "ENABLED", \
> +	[PCHG_STATE_DETECTED] =3D "DETECTED", \
> +	[PCHG_STATE_CHARGING] =3D "CHARGING", \
> +	}
> +
>  /***********************************************************************=
******/
>  /* Locate peripheral chips
>   *
> --=20
> 2.29.2.684.gfbc64c5ab5-goog
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--D660Sa2aIkTuYR87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYACLQAAKCRBzbaomhzOw
wh3gAQCTgX54LEe9QPexq9GNnvikwVi0JLeTwqNfhzPj8SQNdQD5AQjmyx+rCnLz
UOyRnxFe3Yf7xQEij3JcJbEJ7aKedQ8=
=Jpp/
-----END PGP SIGNATURE-----

--D660Sa2aIkTuYR87--
