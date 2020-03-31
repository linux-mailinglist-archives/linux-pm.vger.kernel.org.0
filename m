Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB6019984A
	for <lists+linux-pm@lfdr.de>; Tue, 31 Mar 2020 16:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730946AbgCaOTn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Mar 2020 10:19:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:13636 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730464AbgCaOTn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 31 Mar 2020 10:19:43 -0400
IronPort-SDR: j7cNB8neDCt1XMZ9hGrX68O2sXlfP47X/s2Y7lo/z7rQhGlX0TvdOFZbEkanz9Q+ToAwcscZX8
 72p72I6Ip/lA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 07:19:42 -0700
IronPort-SDR: cRKDxEEbRCRWnWVfnFjCLSXiabFWp5mt/JJwnXdk3rIB1htmesLkIq6Y/TnQ31OLsOG4h1Soqn
 U1tkJrjrMr9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,328,1580803200"; 
   d="scan'208";a="328098370"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 31 Mar 2020 07:19:32 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jJHjp-00EWLW-QM; Tue, 31 Mar 2020 17:19:33 +0300
Date:   Tue, 31 Mar 2020 17:19:33 +0300
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
Subject: Re: [PATCH v7 09/10] power: supply: Support ROHM bd99954 charger
Message-ID: <20200331141933.GK1922688@smile.fi.intel.com>
References: <cover.1585656143.git.matti.vaittinen@fi.rohmeurope.com>
 <1cc9518fbd8f0e0b4724f9bc1ac37353a0b073b5.1585656144.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cc9518fbd8f0e0b4724f9bc1ac37353a0b073b5.1585656144.git.matti.vaittinen@fi.rohmeurope.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 31, 2020 at 03:28:17PM +0300, Matti Vaittinen wrote:
> The ROHM BD99954 is a Battery Management LSI for 1-4 cell Lithium-Ion
> secondary battery intended to be used in space-constraint equipment such
> as Low profile Notebook PC, Tablets and other applications. BD99954
> provides a Dual-source Battery Charger, two port BC1.2 detection and a
> Battery Monitor.
> 
> Support ROHM BD99954 Charger IC.

...

> +static irqreturn_t bd9995x_irq_handler_thread(int irq, void *private)
> +{
> +	struct bd9995x_device *bd = private;
> +	int ret, status, mask, i;
> +	unsigned long tmp;
> +	struct bd9995x_state state;
> +
> +	/*
> +	 * The bd9995x does not seem to generate big amount of interrupts.
> +	 * The logic regarding which interrupts can cause relevant
> +	 * status changes seem to be pretty complex.
> +	 *
> +	 * So lets implement really simple and hopefully bullet-proof handler:
> +	 * It does not really matter which IRQ we handle, we just go and
> +	 * re-read all interesting statuses + give the framework a nudge.
> +	 *
> +	 * Other option would be building a _complex_ and error prone logic
> +	 * trying to decide what could have been changed (resulting this IRQ
> +	 * we are now handling). During the normal operation the BD99954 does
> +	 * not seem to be generating much of interrupts so benefit from such
> +	 * logic would probably be minimal.
> +	 */
> +
> +	ret = regmap_read(bd->rmap, INT0_STATUS, &status);
> +	if (ret) {
> +		dev_err(bd->dev, "Failed to read IRQ status\n");
> +		return IRQ_NONE;
> +	}
> +
> +	ret = regmap_field_read(bd->rmap_fields[F_INT0_SET], &mask);
> +	if (ret) {
> +		dev_err(bd->dev, "Failed to read IRQ mask\n");
> +		return IRQ_NONE;
> +	}
> +
> +	/* Handle only IRQs that are not masked */
> +	status &= mask;
> +	tmp = status;
> +
> +	/* Lowest bit does not represent any sub-registers */
> +	tmp >>= 1;
> +
> +	/*
> +	 * Mask and ack IRQs we will handle (+ the idiot bit)
> +	 */
> +	ret = regmap_field_write(bd->rmap_fields[F_INT0_SET], 0);
> +	if (ret) {
> +		dev_err(bd->dev, "Failed to mask F_INT0\n");
> +		return IRQ_NONE;
> +	}
> +
> +	ret = regmap_write(bd->rmap, INT0_STATUS, status);
> +	if (ret) {
> +		dev_err(bd->dev, "Failed to ack F_INT0\n");
> +		goto err_umask;
> +	}
> +
> +	for_each_set_bit(i, &tmp, 7) {
> +		int sub_status, sub_mask;
> +		int sub_status_reg[] = {
> +			INT1_STATUS, INT2_STATUS, INT3_STATUS, INT4_STATUS,
> +			INT5_STATUS, INT6_STATUS, INT7_STATUS,
> +		};
> +		struct regmap_field *sub_mask_f[] = {
> +			bd->rmap_fields[F_INT1_SET],
> +			bd->rmap_fields[F_INT2_SET],
> +			bd->rmap_fields[F_INT3_SET],
> +			bd->rmap_fields[F_INT4_SET],
> +			bd->rmap_fields[F_INT5_SET],
> +			bd->rmap_fields[F_INT6_SET],
> +			bd->rmap_fields[F_INT7_SET],
> +		};
> +
> +		/* Clear sub IRQs */
> +		ret = regmap_read(bd->rmap, sub_status_reg[i], &sub_status);
> +		if (ret) {
> +			dev_err(bd->dev, "Failed to read IRQ sub-status\n");
> +			goto err_umask;
> +		}


Looking into it makes me thing that you perhaps need regmap IRQ chip?
Have you chance to look at drivers/mfd/intel_soc_pmic_bxtwc.c, for example?

> +		ret = regmap_field_read(sub_mask_f[i], &sub_mask);
> +		if (ret) {
> +			dev_err(bd->dev, "Failed to read IRQ sub-mask\n");
> +			goto err_umask;
> +		}
> +
> +		/* Ack active sub-statuses */
> +		sub_status &= sub_mask;
> +
> +		ret = regmap_write(bd->rmap, sub_status_reg[i], sub_status);
> +		if (ret) {
> +			dev_err(bd->dev, "Failed to ack sub-IRQ\n");
> +			goto err_umask;
> +		}
> +	}
> +
> +	ret = regmap_field_write(bd->rmap_fields[F_INT0_SET], mask);
> +	if (ret)
> +		/* May as well retry once */
> +		goto err_umask;
> +
> +	/* Read whole chip state */
> +	ret = bd9995x_get_chip_state(bd, &state);
> +	if (ret < 0) {
> +		dev_err(bd->dev, "Failed to read chip state\n");
> +	} else {
> +		mutex_lock(&bd->lock);
> +		bd->state = state;
> +		mutex_unlock(&bd->lock);
> +
> +		power_supply_changed(bd->charger);
> +	}
> +
> +	return IRQ_HANDLED;
> +
> +err_umask:
> +	ret = regmap_field_write(bd->rmap_fields[F_INT0_SET], mask);
> +	if (ret)
> +		dev_err(bd->dev,
> +		"Failed to un-mask F_INT0 - IRQ permanently disabled\n");
> +
> +	return IRQ_NONE;
> +}

...

> +static int bd9995x_fw_probe(struct bd9995x_device *bd)
> +{
> +	int ret;
> +	struct power_supply_battery_info info;
> +	u32 property;
> +	int i;
> +	int regval;
> +	bool found;
> +	struct bd9995x_init_data *init = &bd->init_data;
> +	struct battery_init battery_inits[] = {
> +		{
> +			.name = "trickle-charging current",
> +			.info_data = &info.tricklecharge_current_ua,
> +			.range = &charging_current_ranges[0],
> +			.ranges = 2,
> +			.data = &init->itrich_set,
> +		}, {
> +			.name = "pre-charging current",
> +			.info_data = &info.precharge_current_ua,
> +			.range = &charging_current_ranges[0],
> +			.ranges = 2,
> +			.data = &init->iprech_set,
> +		}, {
> +			.name = "pre-to-trickle charge voltage threshold",
> +			.info_data = &info.precharge_voltage_max_uv,
> +			.range = &trickle_to_pre_threshold_ranges[0],
> +			.ranges = 2,
> +			.data = &init->vprechg_th_set,
> +		}, {
> +			.name = "charging termination current",
> +			.info_data = &info.charge_term_current_ua,
> +			.range = &charging_current_ranges[0],
> +			.ranges = 2,
> +			.data = &init->iterm_set,
> +		}, {
> +			.name = "charging re-start voltage",
> +			.info_data = &info.charge_restart_voltage_uv,
> +			.range = &charge_voltage_regulation_ranges[0],
> +			.ranges = 2,
> +			.data = &init->vrechg_set,
> +		}, {
> +			.name = "battery overvoltage limit",
> +			.info_data = &info.overvoltage_limit_uv,
> +			.range = &charge_voltage_regulation_ranges[0],
> +			.ranges = 2,
> +			.data = &init->vbatovp_set,
> +		}, {
> +			.name = "fast-charging max current",
> +			.info_data = &info.constant_charge_current_max_ua,
> +			.range = &fast_charge_current_ranges[0],
> +			.ranges = 1,
> +			.data = &init->ichg_set,
> +		}, {
> +			.name = "fast-charging voltage",
> +			.info_data = &info.constant_charge_voltage_max_uv,
> +			.range = &charge_voltage_regulation_ranges[0],
> +			.ranges = 2,
> +			.data = &init->vfastchg_reg_set1,
> +		},
> +	};
> +	struct dt_init props[] = {
> +		{
> +			.prop = "rohm,vsys-regulation-microvolt",
> +			.range = &vsys_voltage_regulation_ranges[0],
> +			.ranges = 2,
> +			.data = &init->vsysreg_set,
> +		}, {
> +			.prop = "rohm,vbus-input-current-limit-microamp",
> +			.range = &input_current_limit_ranges[0],
> +			.ranges = 1,
> +			.data = &init->ibus_lim_set,
> +		}, {
> +			.prop = "rohm,vcc-input-current-limit-microamp",
> +			.range = &input_current_limit_ranges[0],
> +			.ranges = 1,
> +			.data = &init->icc_lim_set,
> +		},
> +	};
> +

> +	/*
> +	 * The power_supply_get_battery_info() does not support getting values
> +	 * from ACPI. Let's fix it if ACPI is required here.
> +	 */

Previously we discussed this and you told that you don't need ACPI support. Did
I get your wrong or something has been changed? If the latter, perhaps
converting power supply core to use device property API is not harder than what
you have done below.

> +	ret = power_supply_get_battery_info(bd->charger, &info);
> +	if (ret < 0)
> +		return ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(battery_inits); i++) {
> +		int val = *battery_inits[i].info_data;
> +		const struct linear_range *range = battery_inits[i].range;
> +		int ranges = battery_inits[i].ranges;
> +
> +		if (val == -EINVAL)
> +			continue;
> +
> +		ret = linear_range_get_selector_low_array(range, ranges, val,
> +							  &regval, &found);
> +		if (ret) {
> +			dev_err(bd->dev, "Unsupported value for %s\n",
> +				battery_inits[i].name);
> +
> +			power_supply_put_battery_info(bd->charger, &info);
> +			return -EINVAL;
> +		}
> +		if (!found) {
> +			dev_warn(bd->dev,
> +				 "Unsupported value for %s - using smaller\n",
> +				 battery_inits[i].name);
> +		}
> +		*(battery_inits[i].data) = regval;
> +	}
> +
> +	power_supply_put_battery_info(bd->charger, &info);
> +
> +	for (i = 0; i < ARRAY_SIZE(props); i++) {
> +		ret = device_property_read_u32(bd->dev, props[i].prop,
> +					       &property);
> +		if (ret < 0) {
> +			dev_err(bd->dev, "failed to read %s", props[i].prop);
> +
> +			return ret;
> +		}
> +
> +		ret = linear_range_get_selector_low_array(props[i].range,
> +							  props[i].ranges,
> +							  property, &regval,
> +							  &found);
> +		if (ret) {
> +			dev_err(bd->dev, "Unsupported value for '%s'\n",
> +				props[i].prop);
> +
> +			return -EINVAL;
> +		}
> +
> +		if (!found) {
> +			dev_warn(bd->dev,
> +				 "Unsupported value for '%s' - using smaller\n",
> +				 props[i].prop);
> +		}
> +
> +		*(props[i].data) = regval;
> +	}
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


