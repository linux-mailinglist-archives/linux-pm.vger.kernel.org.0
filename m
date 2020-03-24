Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 017CE1909F3
	for <lists+linux-pm@lfdr.de>; Tue, 24 Mar 2020 10:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgCXJub (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Mar 2020 05:50:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:22401 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbgCXJub (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Mar 2020 05:50:31 -0400
IronPort-SDR: 3c7kcUqvWcDDfHtie8GXZCqJmhXmGTW4qkTcDID0bFWtdpa7Eu0LH7BQZsnKsHVXTTQ4e2pr3X
 mHeL7tfS22qA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 02:50:31 -0700
IronPort-SDR: 7qTtx2V3hntiFz5XSVMoESWmCqDXxAo9Sjvu4vvh1Q7uOxbeJZyrYx3oI+CamvzI5XDdbkixsd
 MPms7UxGquZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,299,1580803200"; 
   d="scan'208";a="446163213"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 24 Mar 2020 02:50:23 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jGgCW-00CUef-Bz; Tue, 24 Mar 2020 11:50:24 +0200
Date:   Tue, 24 Mar 2020 11:50:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>,
        Brendan Higgins <brendanhiggins@google.com>,
        Changbin Du <changbin.du@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Gow <davidgow@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Gary Hook <Gary.Hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Tal Gilboa <talgi@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v6 09/10] power: supply: Support ROHM bd99954 charger
Message-ID: <20200324095024.GE1922688@smile.fi.intel.com>
References: <cover.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
 <1bf2431b80489ae412e774519a92616a9aa2bcca.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1bf2431b80489ae412e774519a92616a9aa2bcca.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 24, 2020 at 10:32:19AM +0200, Matti Vaittinen wrote:
> The ROHM BD99954 is a Battery Management LSI for 1-4 cell Lithium-Ion
> secondary battery intended to be used in space-constraint equipment such
> as Low profile Notebook PC, Tablets and other applications. BD99954
> provides a Dual-source Battery Charger, two port BC1.2 detection and a
> Battery Monitor.

...

> + *	Bugs added by:
> + *		Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

Bugs or not, but some style improvements can be done.

...

> +#include <linux/acpi.h>

> +#include <linux/of.h>

I didn't find any evidence of use of those two, otherwise, missed property.h
and perhaps mod_devicetable.h.

...

> +static const struct regmap_config bd9995x_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.reg_stride = 1,

> +	.max_register = 3*0x100,

Spaces, please.

> +	.cache_type = REGCACHE_RBTREE,
> +
> +	.ranges = regmap_range_cfg,
> +	.num_ranges = ARRAY_SIZE(regmap_range_cfg),
> +	.val_format_endian = REGMAP_ENDIAN_LITTLE,
> +	.wr_table = &bd9995x_writeable_regs,
> +	.volatile_table = &bd9995x_volatile_regs,
> +};

...

> +#define IDI0T_BIT 0x1

In contemporary world somebody can be offended (not me).

...

> +static int bd9995x_get_prop_batt_present(struct bd9995x_device *bd)
> +{
> +	int ret, tmp;
> +
> +	ret = regmap_field_read(bd->rmap_fields[F_BATTEMP], &tmp);
> +	if (ret)
> +		return false;
> +

> +	return (tmp != BATT_OPEN) ? true : false;

C 101 (I saw somewhere coccinelle script for this):

	return tmp != BATT_OPEN;

> +}

...

> +		/*
> +		 * the actual range : 2560 to 19200 mV. No matter what the

t -> T

> +		 * register says
> +		 */

> +		val->intval = max(val->intval, 2560);
> +		val->intval = min(val->intval, 19200);

clamp_val()

> +		val->intval *= 1000;

...

> +	/* The idiot bit does not represent any sub-registers */
> +	tmp &= ~(IDI0T_BIT);

Besides above, this has too many parentheses.

...

> +	for (i = ffs(tmp); i; i = ffs(tmp)) {

NIH of for_each_set_bit().

> +		int sub_status, sub_mask;
> +		int sub_status_reg[] = {
> +			-1, INT1_STATUS, INT2_STATUS, INT3_STATUS, INT4_STATUS,
> +			INT5_STATUS, INT6_STATUS, INT7_STATUS,
> +		};
> +		struct regmap_field *sub_mask_f[] = {
> +			NULL, bd->rmap_fields[F_INT1_SET],
> +			bd->rmap_fields[F_INT2_SET],
> +			bd->rmap_fields[F_INT3_SET],
> +			bd->rmap_fields[F_INT4_SET],
> +			bd->rmap_fields[F_INT5_SET],
> +			bd->rmap_fields[F_INT6_SET],
> +			bd->rmap_fields[F_INT7_SET],
> +		};
> +

> +		tmp &= ~(1 << (i - 1));

See above.

> +
> +		if (i - 1 > ARRAY_SIZE(sub_status_reg))
> +			break;

See above. You may prepare tmp beforehand.

> +	}

...

> +	do {
> +		ret = regmap_field_read(bd->rmap_fields[F_OTPLD_STATE], &state);
> +		if (ret)
> +			return ret;
> +
> +		msleep(10);
> +	} while (state == 0 && --rst_check_counter);

regmap_read_poll_timeout() exists, but I see you use it for field. Perhaps it's
a time to introduce similar helper for field polling.

...

> +static const struct linear_range input_current_limit_ranges[] = {
> +	{
> +		.min = 0,
> +		.step = 32000,

> +		.min_sel = 0x0,

Perhaps 0x000 to match max_sel width. Same applies to other places.

> +		.max_sel = 0x1ff,
> +	},
> +};

...

> +	/*
> +	 *  the power_supply_get_battery_info does not support getting values

t -> T
Also when we refer to function use () suffix.

> +	 * from ACPI. Let's fix it if required :)
> +	 */

And yes, good question why you simple do not fix it there?

...

> +static int bd9995x_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)

Can you switch to ->probe_new() (Note, it doesn't mean you need to drop I²C ID table)

...

> +	if (!dev->platform_data) {

dev_get_platdata()

> +		ret = bd9995x_fw_probe(bd);
> +		if (ret < 0) {
> +			dev_err(dev, "Cannot read device properties.\n");
> +			return ret;
> +		}
> +	} else {

> +		return -ENODEV;

So, existing platform data leads to an error?!

> +	}

...

> +	/*

> +	 * reset all registers to default values. This should also disable

r -> R. Check all your messages for proper grammar.

> +	 * CHG_EN bit. If this is not required we can get rid of the remove.
> +	 */

...

> +	dev_info(bd->dev, "Driver for DB99954 chip removed\n");

Noise. You can easily check this by using initcall_debug facility.

...

> +static const struct of_device_id bd9995x_of_match[] = {
> +	{ .compatible = "rohm,bd99954", },
> +	{ },

Terminator lines better without comma. Preventing new potential bugs in the future :-)

> +};
> +MODULE_DEVICE_TABLE(of, bd9995x_of_match);
> +
> +static const struct acpi_device_id bd9995x_acpi_match[] = {
> +	{"BD999540", 0},

> +	{},

Ditto.

> +};
> +MODULE_DEVICE_TABLE(acpi, bd9995x_acpi_match);

...

> +#ifndef BD99954_CHARGER_H
> +#define BD99954_CHARGER_H
> +
> +#include <linux/regmap.h>

It is not the header you have users for.
Proper one should be bits.h.

-- 
With Best Regards,
Andy Shevchenko


