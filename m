Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B34E417F48C
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 11:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgCJKKx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 06:10:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:53433 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgCJKKw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Mar 2020 06:10:52 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 03:10:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,536,1574150400"; 
   d="scan'208";a="288992361"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Mar 2020 03:10:48 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jBbqd-008Qzl-0B; Tue, 10 Mar 2020 12:10:51 +0200
Date:   Tue, 10 Mar 2020 12:10:50 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] power: supply: add CellWise cw2015 fuel gauge
 driver
Message-ID: <20200310101050.GG1922688@smile.fi.intel.com>
References: <20200309160346.2203680-1-t.schramm@manjaro.org>
 <20200309160346.2203680-3-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309160346.2203680-3-t.schramm@manjaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 09, 2020 at 05:03:46PM +0100, Tobias Schramm wrote:
> This patch adds a driver for the CellWise cw2015 fuel gauge.
> 
> The CellWise cw2015 is a shuntless, single-cell Li-Ion fuel gauge used
> in the pine64 Pinebook Pro laptop and some Raspberry Pi UPS HATs.

...

>  F:	arch/powerpc/oprofile/*cell*
>  F:	arch/powerpc/platforms/cell/
>  
> +CELLWISE CW2015 BATTERY DRIVER
> +M:	Tobias Schrammm <t.schramm@manjaro.org>
> +S:	Maintained
> +F:	drivers/power/supply/cw2015_battery.c
> +F:	Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
> +
>  CEPH COMMON CODE (LIBCEPH)
>  M:	Ilya Dryomov <idryomov@gmail.com>
>  M:	Jeff Layton <jlayton@kernel.org>

Run parse-mainteiners.pl and fix ordering issue in above.

...

> + * Authors: xuhuicong <xhc@rock-chips.com>
> + * Authors: Tobias Schramm <tobias@t-sys.eu>

> + *

Redundant line.

...

> +#include <linux/delay.h>
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>

> +#include <linux/of_gpio.h>

I think you need gpio/consumer.h.

> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/slab.h>
> +#include <linux/timekeeping.h>
> +#include <linux/workqueue.h>
> +#include <linux/regmap.h>

Perhaps keep above sorted?

...

> +#define CW2015_READ_TRIES		30
> +#define CW2015_RESET_TRIES		5
> +
> +#define CW2015_REG_VERSION		0x0
> +#define CW2015_REG_VCELL		0x2
> +#define CW2015_REG_SOC			0x4
> +#define CW2015_REG_RRT_ALERT		0x6
> +#define CW2015_REG_CONFIG		0x8
> +#define CW2015_REG_MODE			0xA
> +#define CW2015_REG_BATINFO		0x10

Use same width for all register offsets:
	0x08
etc.

> +#define CW2015_MODE_SLEEP_MASK		(0x3<<6)
> +#define CW2015_MODE_SLEEP		(0x3<<6)
> +#define CW2015_MODE_NORMAL		(0x0<<6)
> +#define CW2015_MODE_QUICK_START		(0x3<<4)
> +#define CW2015_MODE_RESTART		(0xf<<0)
> +
> +#define CW2015_CONFIG_UPDATE_FLG	(0x01<<1)
> +#define CW2015_ATHD(x)			((x)<<3)
> +#define CW2015_MASK_ATHD		(0x1f<<3)
> +#define CW2015_MASK_SOC			(0x1fff)

GENMASK() and somebody missed a lot of white spaces above.

> +#define CW2015_BATTERY_UP_MAX_CHANGE		(420 * 1000)
> +#define CW2015_BATTERY_DOWN_MAX_CHANGE		(120 * 1000)
> +#define CW2015_BATTERY_DOWN_CHANGE		60
> +#define CW2015_BATTERY_DOWN_MIN_CHANGE_RUN	30
> +#define CW2015_BATTERY_DOWN_MIN_CHANGE_SLEEP	1800
> +#define CW2015_BATTERY_JUMP_TO_ZERO		(30 * 1000)
> +#define CW2015_BATTERY_CAPACITY_ERROR		(40 * 1000)
> +#define CW2015_BATTERY_CHARGING_ZERO		(1800 * 1000)

What these multiplications about? We have time units in time.h (or time64.h).
Moreover is a good tone to use units in the name of definitions. And try to
shorten them, they are already quite long.

> +#define CW2015_DEFAULT_MONITOR_MS		8000

8 seconds? Any comments about this?

...

> +struct cw_battery {
> +	struct i2c_client *client;

Do you need this? Perhaps you can keep struct device from which you can easily
retrive the client.

> +};

...

> +#define PREFIX "cellwise,"

We have pr_fmt() / dev_fmt() for this.

> +#define cw_dbg(cw_bat, ...) dev_dbg(&(cw_bat)->client->dev, __VA_ARGS__)
> +#define cw_info(cw_bat, ...) dev_info(&(cw_bat)->client->dev, __VA_ARGS__)
> +#define cw_warn(cw_bat, ...) dev_warn(&(cw_bat)->client->dev, __VA_ARGS__)
> +#define cw_err(cw_bat, ...) dev_err(&(cw_bat)->client->dev, __VA_ARGS__)

No, please don't. It doesn't bring any value and makes this small driver harder to read.
If you need shorten lines, simple use temporary variable.

...

> +static int cw_read(struct cw_battery *cw_bat, u8 reg, u8 *val)
> +{
> +	u32 tmp;
> +	int ret;
> +
> +	ret = regmap_read(cw_bat->regmap, reg, &tmp);
> +	*val = tmp;
> +	return ret;
> +}
> +
> +static int cw_write(struct cw_battery *cw_bat, u8 reg, const u8 val)
> +{
> +	return regmap_write(cw_bat->regmap, reg, val);
> +}

This two has no value. Why?

...

> +static int cw_read_word(struct cw_battery *cw_bat, u8 reg, u16 *val)
> +{
> +	u8 reg_val[2];
> +	int ret;
> +
> +	ret = regmap_raw_read(cw_bat->regmap, reg, reg_val, 2);
> +	*val = (reg_val[0] << 8) + reg_val[1];
> +	return ret;
> +}

NIH BE type of readings? Can REGMAP_ENDIAN_BIG help?

> +static int cw_read_bulk(struct cw_battery *cw_bat, u8 reg, u8 *buf, size_t len)
> +{
> +	return regmap_raw_read(cw_bat->regmap, reg, buf, len);
> +}

No value.

> +static int cw_write_bulk(struct cw_battery *cw_bat, u8 reg, u8 const *buf,
> +				size_t len)
> +{
> +	return regmap_raw_write(cw_bat->regmap, reg, buf, len);
> +}

Ditto.

> +int cw_update_config_info(struct cw_battery *cw_bat)
> +{
> +	int ret;
> +	u8 reg_val;
> +	u8 reset_val;
> +
> +	if (!cw_bat->bat_config_info) {
> +		cw_err(cw_bat,
> +			"No battery config info provided, can't update flash contents");
> +		return -EINVAL;
> +	}
> +
> +	/* make sure gauge is not in sleep mode */
> +	ret = cw_read(cw_bat, CW2015_REG_MODE, &reg_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	reset_val = reg_val;
> +	if ((reg_val & CW2015_MODE_SLEEP_MASK) == CW2015_MODE_SLEEP) {
> +		cw_err(cw_bat,
> +			"Device is in sleep mode, can't update battery info");
> +		return -EINVAL;
> +	}
> +
> +	/* write new battery info */
> +	ret = cw_write_bulk(cw_bat, CW2015_REG_BATINFO,
> +				cw_bat->bat_config_info,
> +				CW2015_SIZE_BATINFO);

> +

Redundant line.

> +	if (ret < 0)
> +		return ret;

All above comparison (and a lot below) are against negative return code, have
you checked if positive is ever possible (AFAIR no, they are not possible).

> +	reg_val |= CW2015_CONFIG_UPDATE_FLG;	/* set UPDATE_FLAG */
> +	reg_val &= ~CW2015_MASK_ATHD;	/* clear alert level */
> +	reg_val |= CW2015_ATHD(cw_bat->alert_level);	/* set alert level */

All comments can be replaced with one on top of three

	/* Update alert level */

> +	ret = cw_write(cw_bat, CW2015_REG_CONFIG, reg_val);
> +	if (ret < 0)
> +		return ret;
> +

> +	/* reset */

Useless.

> +	reset_val &= ~(CW2015_MODE_RESTART);

Too many parentheses.

Note all my comments should be applied to all similar places in the code, even
if I didn't comment them explicitly.

> +	reg_val = reset_val | CW2015_MODE_RESTART;
> +	ret = cw_write(cw_bat, CW2015_REG_MODE, reg_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	msleep(20);
> +	ret = cw_write(cw_bat, CW2015_REG_MODE, reset_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	cw_dbg(cw_bat, "Battery config updated");
> +
> +	return 0;
> +}

...

I didn't review some parts because of style issues. Please, fix all of them and
send v2.

...

> +	msleep(20);


This big delay has to be explained.

...

> +	} else if (charging_5_loop != 0) {

Useless conditional.

> +		charging_5_loop = 0;
> +	}

...

> +	voltage = avg * 312 / 1024;

All calculations like that better to be explained (like: "Data sheet provides
a formula to normalize raw value ... bla bla bla").

...

> +	else if (cw_bat->capacity != cw_capacity) {
> +		cw_bat->capacity = cw_capacity;

> +	else if (cw_bat->voltage != ret)
> +		cw_bat->voltage = ret;

Too many useless conditionals.

...

> +			// calculate remaining capacity

> +			// estimate current based on time to empty (in minutes)

You need to choose one comment style over the code.

...

> +#ifdef CONFIG_OF

You didn't have of.h in the inclusion block, why do you have this?

Hint: you can easily drop this dependency by using fwnode / device property
API.

> +static int cw2015_parse_dt(struct cw_battery *cw_bat)
> +{
> +	struct device *dev = &cw_bat->client->dev;
> +	struct device_node *node = dev->of_node;
> +	struct property *prop;
> +	int length;
> +	u32 value;
> +	int ret;
> +
> +	if (!node)
> +		return -ENODEV;
> +

> +	prop = of_find_property(node, PREFIX"bat-config-info", &length);

No, no, please always spell explicitly name of nodes / properties / etc.

> +	if (prop) {
> +		if (length != CW2015_SIZE_BATINFO) {
> +			cw_err(cw_bat, "bat-config-info must be %d bytes",
> +				CW2015_SIZE_BATINFO);
> +			return -EINVAL;
> +		}
> +
> +		cw_bat->bat_config_info =
> +			devm_kzalloc(dev, CW2015_SIZE_BATINFO, GFP_KERNEL);
> +		if (!cw_bat->bat_config_info) {
> +			cw_err(cw_bat,
> +				"Failed to allocate memory for battery config info");
> +			return -ENOMEM;
> +		}
> +
> +		ret = of_property_read_u8_array(node, PREFIX"bat-config-info",
> +						 cw_bat->bat_config_info,
> +						 CW2015_SIZE_BATINFO);
> +		if (ret < 0)
> +			return ret;
> +	} else
> +		cw_warn(cw_bat,
> +			"No bat-config-info found, rolling with current flash contents");
> +
> +	cw_bat->monitor_sec = CW2015_DEFAULT_MONITOR_MS;
> +
> +	ret = of_property_read_u32(node, PREFIX"monitor-interval-ms", &value);
> +	if (ret >= 0) {
> +		cw_dbg(cw_bat, "Overriding default monitor-interval with %u ms",
> +			value);
> +		cw_bat->monitor_sec = value;
> +	}
> +
> +	return 0;
> +}
> +#else
> +static int cw2015_parse_dt(struct cw_battery *cw_bat)
> +{
> +	return -ENODEV;
> +}
> +#endif

...

> +static const struct regmap_range regmap_ranges_wr_yes[] = {
> +	regmap_reg_range(CW2015_REG_RRT_ALERT, CW2015_REG_CONFIG),
> +	regmap_reg_range(CW2015_REG_MODE, CW2015_REG_MODE),

> +	regmap_reg_range(CW2015_REG_BATINFO, CW2015_REG_BATINFO +
> +				CW2015_SIZE_BATINFO - 1),

Much better to split differently, i.e.

	regmap_reg_range(CW2015_REG_BATINFO,
			 CW2015_REG_BATINFO + CW2015_SIZE_BATINFO - 1),

> +};

...

> +	cw_dbg(cw_bat, "cw2015/cw2013 driver probe success");

Noise.

...

> +#ifdef CONFIG_PM

Can be replaced by __maybe_unused attribute to the below functions.

> +static int cw_bat_suspend(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct cw_battery *cw_bat = i2c_get_clientdata(client);
> +
> +	ktime_get_boottime_ts64(&cw_bat->suspend_time_before);
> +	cancel_delayed_work_sync(&cw_bat->battery_delay_work);
> +	return 0;
> +}
> +
> +static int cw_bat_resume(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct cw_battery *cw_bat = i2c_get_clientdata(client);
> +
> +	cw_bat->suspend_resume_mark = 1;
> +	ktime_get_boottime_ts64(&cw_bat->after);
> +	cw_bat->after = timespec64_sub(cw_bat->after,
> +				     cw_bat->suspend_time_before);
> +	queue_delayed_work(cw_bat->battery_workqueue,
> +			   &cw_bat->battery_delay_work, msecs_to_jiffies(2));
> +	return 0;
> +}
> +

> +static const struct dev_pm_ops cw_bat_pm_ops = {
> +	.suspend  = cw_bat_suspend,
> +	.resume   = cw_bat_resume,
> +};

Use proper helper macro from pm.h instead of above.

> +#endif

...

> +	cw_dbg(cw_bat, "Removing device");

Noise.

> +	cancel_delayed_work(&cw_bat->battery_delay_work);

Are you sure you have no scheduled work after that?

...

> +static const struct of_device_id cw2015_of_match[] = {
> +	{ .compatible = PREFIX"cw2015" },

> +	{ },

No need to have comma for terminator line.

> +};

...

> +#ifdef CONFIG_PM
> +		.pm = &cw_bat_pm_ops,
> +#endif

Drop this ifdefery and use proper helper macro above.

-- 
With Best Regards,
Andy Shevchenko


