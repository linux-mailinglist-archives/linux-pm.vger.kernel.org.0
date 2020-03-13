Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4631618435B
	for <lists+linux-pm@lfdr.de>; Fri, 13 Mar 2020 10:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgCMJL2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Mar 2020 05:11:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:29970 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbgCMJL1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 13 Mar 2020 05:11:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 02:11:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,548,1574150400"; 
   d="scan'208";a="237159910"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 13 Mar 2020 02:11:23 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jCgLk-009Dzx-RH; Fri, 13 Mar 2020 11:11:24 +0200
Date:   Fri, 13 Mar 2020 11:11:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] power: supply: add CellWise cw2015 fuel gauge
 driver
Message-ID: <20200313091124.GP1922688@smile.fi.intel.com>
References: <20200312222448.25097-1-t.schramm@manjaro.org>
 <20200312222448.25097-4-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312222448.25097-4-t.schramm@manjaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 12, 2020 at 11:24:48PM +0100, Tobias Schramm wrote:
> This patch adds a driver for the CellWise cw2015 fuel gauge.
> 
> The CellWise cw2015 is a shuntless, single-cell Li-Ion fuel gauge used
> in the pine64 Pinebook Pro laptop and some Raspberry Pi UPS HATs.

Thank you for an update!
My comments below.

...

> +config BATTERY_CW2015
> +	tristate "CW2015 Battery driver"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  Say Y here to enable support for the cellwise cw2015
> +	  battery fuel gauge (used in the Pinebook Pro & others)

AFAIK, it's a good tone to include module name in help string.

...

> +#include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/time.h>
> +#include <linux/timekeeping.h>
> +#include <linux/workqueue.h>

Can you, please, double check if all of this are indeed have users in the
driver?

...

> +				dev_err(cw_bat->dev,
> +					 "Failed to upload battery info\n");

Indentation of the second line.

...


> +		ret = regmap_raw_read(cw_bat->regmap, CW2015_REG_BATINFO,
> +					bat_info, CW2015_SIZE_BATINFO);

Ditto.

> +			dev_err(cw_bat->dev,
> +				 "Failed to read stored battery profile\n");

Ditto.

> +		dev_warn(cw_bat->dev,
> +			"Can't check current battery profile, no profile provided");

Ditto.

...


> +			dev_warn(cw_bat->dev,
> +				"Too many invalid SoC reports, resetting gauge");

Ditto.

> +			dev_warn(cw_bat->dev,
> +				"SoC stuck @%u%%, resetting gauge", soc);

Ditto.

...

> +static void cw_bat_work(struct work_struct *work)
> +{
> +	struct delayed_work *delay_work;
> +	struct cw_battery *cw_bat;
> +	int ret;
> +	unsigned int reg_val;

> +	int i = 0;

Looks like redundant assignment.

> +	delay_work = to_delayed_work(work);
> +	cw_bat = container_of(delay_work, struct cw_battery, battery_delay_work);
> +	ret = regmap_read(cw_bat->regmap, CW2015_REG_MODE, &reg_val);
> +	if (ret) {
> +		dev_err(cw_bat->dev, "Failed to read mode from gauge: %d", ret);
> +	} else {
> +		if ((reg_val & CW2015_MODE_SLEEP_MASK) == CW2015_MODE_SLEEP) {
> +			for (i = 0; i < CW2015_RESET_TRIES; i++) {
> +				if (!cw_power_on_reset(cw_bat))
> +					break;
> +			}
> +		}
> +		cw_update_soc(cw_bat);
> +		cw_update_voltage(cw_bat);
> +		cw_update_charge_status(cw_bat);
> +		cw_update_status(cw_bat);
> +		cw_update_time_to_empty(cw_bat);
> +	}

> +	if (cw_bat->battery_changed)
> +		power_supply_changed(cw_bat->rk_bat);
> +	cw_bat->battery_changed = false;
> +
> +	queue_delayed_work(cw_bat->battery_workqueue,
> +			   &cw_bat->battery_delay_work,
> +			   msecs_to_jiffies(cw_bat->poll_interval_ms));
> +}

...

> +static int cw_battery_get_property(struct power_supply *psy,
> +				   enum power_supply_property psp,
> +				   union power_supply_propval *val)
> +{

> +	int ret = 0;

Don't see how this is being used.

> +	struct cw_battery *cw_bat;


> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		if (cw_battery_valid_time_to_empty(cw_bat) &&
> +			cw_bat->battery.charge_full_design_uah > 0) {
> +			/* calculate remaining capacity */
> +			val->intval = cw_bat->battery.charge_full_design_uah;
> +			val->intval = val->intval * cw_bat->soc / 100;
> +
> +			/* estimate current based on time to empty */
> +			val->intval = 60 * val->intval / cw_bat->time_to_empty;
> +		} else {
> +			val->intval = 0;
> +		}
> +
> +		break;
> +
> +	default:
> +		break;
> +	}
> +	return ret;
> +}

...

> +static int cw2015_parse_properties(struct cw_battery *cw_bat)
> +{
> +	struct device *dev = cw_bat->dev;
> +	int length;
> +	u32 value;
> +	int ret;
> +
> +	length = device_property_count_u8(dev, "cellwise,battery-profile");
> +	if (length) {

Now it seems we have an issue here because return value can be negative error code.

And I'm thinking that we may refactor this function. So,

	length = ..._count_u8(...);
	if (length < 0) {
		dev_warn(...);
	} else if (length != ...) {
		dev_err(...);
		...
	} else {
		...
	}



> +		if (length != CW2015_SIZE_BATINFO) {
> +			dev_err(cw_bat->dev, "battery-profile must be %d bytes",
> +				CW2015_SIZE_BATINFO);
> +			return -EINVAL;
> +		}
> +
> +		cw_bat->bat_profile = devm_kzalloc(dev, length, GFP_KERNEL);
> +		if (!cw_bat->bat_profile) {
> +			dev_err(cw_bat->dev,
> +				"Failed to allocate memory for battery config info");
> +			return -ENOMEM;
> +		}
> +
> +		ret = device_property_read_u8_array(dev,
> +						"cellwise,battery-profile",
> +						cw_bat->bat_profile,
> +						length);
> +		if (ret)
> +			return ret;
> +	} else {
> +		dev_warn(cw_bat->dev,
> +			"No battery-profile found, rolling with current flash contents");
> +	}
> +

...and here...

> +	cw_bat->poll_interval_ms = CW2015_DEFAULT_POLL_INTERVAL_MS;
> +	ret = device_property_read_u32(dev, "cellwise,monitor-interval-ms", &value);
> +	if (ret >= 0) {
> +		dev_dbg(cw_bat->dev, "Overriding default monitor-interval with %u ms",
> +			value);
> +		cw_bat->poll_interval_ms = value;
> +	}

	ret = device_property_read_u32(dev, "cellwise,monitor-interval-ms", &cw_bat->poll_interval_ms);
	if (ret) {
		dev_dbg(cw_bat->dev, "Use default\n");
		cw_bat->poll_interval_ms = CW2015_DEFAULT_POLL_INTERVAL_MS;
	}

What do you think?

> +
> +	return 0;
> +}

...

> +static int cw_bat_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)

By the way, can you switch to ->probe_new() ?

> +{
> +	int ret;
> +	struct cw_battery *cw_bat;

> +	struct power_supply_config psy_cfg = { };

Don't you need 0 here?

> +	psy_cfg.drv_data = cw_bat;
> +	psy_cfg.fwnode = dev_fwnode(cw_bat->dev);
> +
> +	cw_bat->rk_bat = devm_power_supply_register(&client->dev,
> +		&cw2015_bat_desc, &psy_cfg);
> +	if (IS_ERR(cw_bat->rk_bat)) {
> +		dev_err(cw_bat->dev, "Failed to register power supply");
> +		return PTR_ERR(cw_bat->rk_bat);
> +	}
> +
> +	ret = power_supply_get_battery_info(cw_bat->rk_bat, &cw_bat->battery);
> +	if (ret) {

> +		dev_warn(cw_bat->dev,
> +			"No monitored battery, some properties will be missing");

'\n' is missed (please, check all messages.

> +	}
> +
> +	cw_bat->battery_workqueue = create_singlethread_workqueue("rk_battery");
> +	INIT_DELAYED_WORK(&cw_bat->battery_delay_work, cw_bat_work);
> +	queue_delayed_work(cw_bat->battery_workqueue,
> +			   &cw_bat->battery_delay_work, msecs_to_jiffies(10));
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


