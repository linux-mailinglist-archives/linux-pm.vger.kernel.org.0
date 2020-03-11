Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 565AD1815A4
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 11:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgCKKSe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 06:18:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:54003 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbgCKKSd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Mar 2020 06:18:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 03:18:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; 
   d="scan'208";a="322094690"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 11 Mar 2020 03:18:28 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jByRa-008i07-Ca; Wed, 11 Mar 2020 12:18:30 +0200
Date:   Wed, 11 Mar 2020 12:18:30 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
Subject: Re: [PATCH v3 3/3] power: supply: add CellWise cw2015 fuel gauge
 driver
Message-ID: <20200311101830.GE1922688@smile.fi.intel.com>
References: <20200311093043.3636807-1-t.schramm@manjaro.org>
 <20200311093043.3636807-4-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311093043.3636807-4-t.schramm@manjaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 11, 2020 at 10:30:43AM +0100, Tobias Schramm wrote:
> This patch adds a driver for the CellWise cw2015 fuel gauge.
> 
> The CellWise cw2015 is a shuntless, single-cell Li-Ion fuel gauge used
> in the pine64 Pinebook Pro laptop and some Raspberry Pi UPS HATs.

Thank you for an update!
My comments below.

...

> +	/* wait for gauge to become ready */
> +	for (i = 0; i < CW2015_READ_TRIES; i++) {
> +		ret = regmap_read(cw_bat->regmap, CW2015_REG_SOC, &reg_val);
> +		if (ret)
> +			return ret;
> +		/* SoC must not be more than 100% */
> +		else if (reg_val <= 100)
> +			break;
> +
> +		msleep(100);
> +	}

Have you considered to use regmap_read_poll_timeout()?

> +
> +	if (i >= CW2015_READ_TRIES) {
> +		reg_val = CW2015_MODE_SLEEP;
> +		regmap_write(cw_bat->regmap, CW2015_REG_MODE, reg_val);
> +		dev_err(cw_bat->dev,
> +			"Gauge did not become ready after profile upload");
> +		return -ETIMEDOUT;
> +	}

...

> +		if (memcmp(bat_info, cw_bat->bat_profile,
> +				CW2015_SIZE_BATINFO)) {

I think it's pretty much okay to have this on one line, disregard 80 limit
(it's only 1 extra).

...

> +static int cw_get_soc(struct cw_battery *cw_bat)
> +{
> +	unsigned int soc;
> +	int ret;
> +
> +	ret = regmap_read(cw_bat->regmap, CW2015_REG_SOC, &soc);
> +	if (ret)
> +		return ret;
> +
> +	if (soc > 100) {

> +		int max_error_cycles = CW2015_BAT_SOC_ERROR_MS /
> +					cw_bat->poll_interval_ms;

The following looks better

		int max_error_cycles =
			CW2015_BAT_SOC_ERROR_MS / cw_bat->poll_interval_ms;

Applies to all similar places in the code.

> +		dev_err(cw_bat->dev, "Invalid SoC %d%%", soc);
> +		cw_bat->read_errors++;
> +		if (cw_bat->read_errors > max_error_cycles) {
> +			dev_warn(cw_bat->dev,
> +				"Too many invalid SoC reports, resetting gauge");
> +			cw_power_on_reset(cw_bat);
> +			cw_bat->read_errors = 0;
> +		}
> +		return cw_bat->soc;
> +	}
> +	cw_bat->read_errors = 0;
> +
> +	/* Reset gauge if stuck while charging */

> +	if (cw_bat->status == POWER_SUPPLY_STATUS_CHARGING &&
> +			soc == cw_bat->soc) {

A bit strange indentation, and honestly I would leave it on one line, but it's up to you.

> +		int max_stuck_cycles = CW2015_BAT_CHARGING_STUCK_MS /
> +					cw_bat->poll_interval_ms;
> +
> +		cw_bat->charge_stuck_cnt++;
> +		if (cw_bat->charge_stuck_cnt > max_stuck_cycles) {
> +			dev_warn(cw_bat->dev,
> +				"SoC stuck @%u%%, resetting gauge", soc);
> +			cw_power_on_reset(cw_bat);
> +			cw_bat->charge_stuck_cnt = 0;
> +		}
> +	} else {
> +		cw_bat->charge_stuck_cnt = 0;
> +	}
> +
> +	/* Ignore voltage dips during charge */

> +	if (cw_bat->charger_attached &&
> +			HYSTERESIS(soc, cw_bat->soc, 0, 3)) {

This is pretty much one line (77), check your editor settings and update all
similar places in the code.

> +		soc = cw_bat->soc;
> +	}
> +
> +	/* Ignore voltage spikes during discharge */
> +	if (!cw_bat->charger_attached &&
> +			HYSTERESIS(soc, cw_bat->soc, 3, 0)) {
> +		soc = cw_bat->soc;
> +	}
> +
> +	return soc;
> +}

...

> +	cw_bat =
> +		container_of(delay_work, struct cw_battery, battery_delay_work);

It will be better to read if it would be one line.

...

> +static bool cw_battery_valid_time_to_empty(struct cw_battery *cw_bat)
> +{
> +	return cw_bat->time_to_empty > 0 &&
> +		cw_bat->time_to_empty < CW2015_MASK_SOC &&
> +		cw_bat->status == POWER_SUPPLY_STATUS_DISCHARGING;

Fix indentation to be all 'c':s in one column.

> +}

...

> +static int cw2015_parse_properties(struct cw_battery *cw_bat)
> +{
> +	struct device *dev = cw_bat->dev;
> +	int length;
> +	u32 value;
> +	int ret;
> +

> +	length = device_property_read_u8_array(dev, "cellwise,battery-profile",
> +						NULL, 0);

device_property_count_u8();

> +	if (length) {
> +		if (length != CW2015_SIZE_BATINFO) {
> +			dev_err(cw_bat->dev, "battery-profile must be %d bytes",
> +				CW2015_SIZE_BATINFO);
> +			return -EINVAL;
> +		}
> +
> +		cw_bat->bat_profile =
> +			devm_kzalloc(dev, CW2015_SIZE_BATINFO, GFP_KERNEL);

Replace with length (so, you will have one point of validation), and put on
one line.

> +		if (!cw_bat->bat_profile) {
> +			dev_err(cw_bat->dev,
> +				"Failed to allocate memory for battery config info");
> +			return -ENOMEM;
> +		}
> +
> +		ret = device_property_read_u8_array(dev,
> +						"cellwise,battery-profile",
> +						cw_bat->bat_profile,

> +						CW2015_SIZE_BATINFO);

length.

> +		if (ret)
> +			return ret;
> +	} else {
> +		dev_warn(cw_bat->dev,
> +			"No battery-profile found, rolling with current flash contents");
> +	}
> +
> +	cw_bat->poll_interval_ms = CW2015_DEFAULT_POLL_INTERVAL_MS;

> +	ret = device_property_read_u32_array(dev,
> +						"cellwise,monitor-interval-ms",

It's fine to have it on one line.

> +						&value, 1);
> +	if (ret >= 0) {
> +		dev_dbg(cw_bat->dev, "Overriding default monitor-interval with %u ms",
> +			value);
> +		cw_bat->poll_interval_ms = value;
> +	}
> +
> +	return 0;
> +}

...

> +	regmap_reg_range(CW2015_REG_BATINFO,
> +				CW2015_REG_BATINFO + CW2015_SIZE_BATINFO - 1),

Indentation issue. Check all similar places.

...

> +	cw_bat->rk_bat = devm_power_supply_register(&client->dev,
> +		&cw2015_bat_desc, &psy_cfg);
> +	if (IS_ERR(cw_bat->rk_bat)) {
> +		dev_err(cw_bat->dev, "Failed to register power supply");

> +		return -1;

Do not shadow an error code.

> +	}

-- 
With Best Regards,
Andy Shevchenko


