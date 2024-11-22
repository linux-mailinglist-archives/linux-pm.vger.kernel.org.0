Return-Path: <linux-pm+bounces-17954-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BD99D5D2B
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 11:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97E5CB20F81
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 10:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569FA1D8A08;
	Fri, 22 Nov 2024 10:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="SFThPj4C"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E41165EE6;
	Fri, 22 Nov 2024 10:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732270885; cv=none; b=tO2XEBUkuWOwYt3gOyVVuX1Ynad0U9VCkmK31ah3LhyCZn9frabAsaSHP85G7ZYNKqzBmuQo16FjnRa1VmofM9CRxLe9MzGuIX1y3zwdSJCA1ec+QFfLm2vStI556VAzO1glXa7gMSfwlYeHnNp+sHY+7tq9lwHLoPny5vfy8n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732270885; c=relaxed/simple;
	bh=1LWGdxgjKMEqxkfBZhwVMju1YBlsPo35yU1MFU7teB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LsDUkfqBZZkEe81PNeB5SaTS0XQf5RgUuBKMi2hSmGDoiA3JK4VP3zgkzVtps2aehwWMVnJ/c2NZLPW9ZVoMVspG0Q3WwkMKOkl8SfSoHs40154r3L/wi1ZICheB67pAADedEWaM/m8xbZ14o0E6AXg1KIGqaaBr4CzyJUIUj7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=SFThPj4C; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1732270879; bh=1LWGdxgjKMEqxkfBZhwVMju1YBlsPo35yU1MFU7teB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SFThPj4CBn+1wWSbHDM6v+GVIrojRoJ6YIQ+iCYB7blrxfoycKQAgBT3CRGTweGs+
	 LFR6m+NAiy2r1dhSdl2P3naqmjmQ34t/jHGWvS7nSXTeWKvFwCW2r7SScsmmmWvlBT
	 4j+pBp2hUmD/Dl4481mTm6qX+Pq1A0Wugc4b9BVQ=
Date: Fri, 22 Nov 2024 11:21:18 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Sung-Chi Li <lschyi@chromium.org>
Cc: Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] power: supply: cros_usbpd-charger: extend as a
 thermal of cooling device
Message-ID: <f805c0d8-a7f7-4e03-8d8c-0c13baa02ac4@t-8ch.de>
References: <20241122-extend_power_limit-v1-0-a3ecd87afa76@chromium.org>
 <20241122-extend_power_limit-v1-1-a3ecd87afa76@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122-extend_power_limit-v1-1-a3ecd87afa76@chromium.org>

On 2024-11-22 11:47:21+0800, Sung-Chi Li wrote:
> cros_usbpd-charger is the driver that takes care the system input power
> from the pd charger. This driver also exposes the functionality to limit
> input current.
> 
> We can extend this driver to make it as a passive thermal cooling
> device by limiting the input current. As such, this commit implements
> the required cooling methods and OF style registration.
> 
> Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
> ---
>  drivers/power/supply/cros_usbpd-charger.c | 98 +++++++++++++++++++++++++++++--
>  1 file changed, 93 insertions(+), 5 deletions(-)

A dependency from CHARGER_CROS_PCHG to THERMAL needs to be added to
drivers/power/supply/Kconfig.

> 
> diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
> index 47d3f58aa15c..a0451630cdd7 100644
> --- a/drivers/power/supply/cros_usbpd-charger.c
> +++ b/drivers/power/supply/cros_usbpd-charger.c
> @@ -13,6 +13,9 @@
>  #include <linux/platform_device.h>
>  #include <linux/power_supply.h>
>  #include <linux/slab.h>
> +#ifdef CONFIG_THERMAL_OF

Remove this ifdef. The header is perfectly usable in any case.

Actually the CONFIG_THERMAL_OF dependency is not needed at all.
It is only necessary for devm_thermal_of_zone_register() but not 
devm_thermal_of_cooling_device_register() which you are using.
I am confused.

OTOH you are adding the #cooling-cells OF property which itself seems to
be only used by devm_thermal_of_zone_register(), so I'm now even more
confused.

In general, try to also test the driver configurations
!CONFIG_THERMAL_OF and !CONFIG_THERMAL.

> +#include <linux/thermal.h>
> +#endif /* CONFIG_THERMAL_OF */
>  
>  #define CHARGER_USBPD_DIR_NAME			"CROS_USBPD_CHARGER%d"
>  #define CHARGER_DEDICATED_DIR_NAME		"CROS_DEDICATED_CHARGER"
> @@ -22,6 +25,7 @@
>  					 sizeof(CHARGER_DEDICATED_DIR_NAME))
>  #define CHARGER_CACHE_UPDATE_DELAY		msecs_to_jiffies(500)
>  #define CHARGER_MANUFACTURER_MODEL_LENGTH	32
> +#define CHARGER_COOLING_INTERVALS		10
>  
>  #define DRV_NAME "cros-usbpd-charger"
>  
> @@ -76,6 +80,8 @@ static enum power_supply_property cros_usbpd_dedicated_charger_props[] = {
>  /* Input voltage/current limit in mV/mA. Default to none. */
>  static u16 input_voltage_limit = EC_POWER_LIMIT_NONE;
>  static u16 input_current_limit = EC_POWER_LIMIT_NONE;
> +/* Cooling level interns of current limit */
> +static u16 input_current_cooling_level;
>  
>  static bool cros_usbpd_charger_port_is_dedicated(struct port_data *port)
>  {
> @@ -459,13 +465,20 @@ static int cros_usbpd_charger_set_prop(struct power_supply *psy,
>  			break;
>  
>  		input_current_limit = intval;
> -		if (input_current_limit == EC_POWER_LIMIT_NONE)
> +		if (input_current_limit == EC_POWER_LIMIT_NONE) {
>  			dev_info(dev,
>  			  "External Current Limit cleared for all ports\n");
> -		else
> -			dev_info(dev,
> -			  "External Current Limit set to %dmA for all ports\n",
> -			  input_current_limit);
> +			input_current_cooling_level = 0;
> +		} else {
> +			dev_info(
> +				dev,
> +				"External Current Limit set to %dmA for all ports\n",
> +				input_current_limit);
> +			input_current_cooling_level =
> +				input_current_limit *
> +				CHARGER_COOLING_INTERVALS /
> +				port->psy_current_max;

This seems to be a very spammy driver...

> +		}
>  		break;
>  	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
>  		ret = cros_usbpd_charger_set_ext_power_limit(charger,
> @@ -525,6 +538,66 @@ static void cros_usbpd_charger_unregister_notifier(void *data)
>  	cros_usbpd_unregister_notify(&charger->notifier);
>  }
>  
> +#ifdef CONFIG_THERMAL_OF
> +static int
> +cros_usbpd_charger_get_max_cooling_state(struct thermal_cooling_device *cdev,
> +					 unsigned long *cooling_level)
> +{
> +	*cooling_level = CHARGER_COOLING_INTERVALS;
> +	return 0;
> +}
> +
> +static int
> +cros_usbpd_charger_get_cur_cooling_state(struct thermal_cooling_device *cdev,
> +					 unsigned long *cooling_level)
> +{
> +	*cooling_level = input_current_cooling_level;
> +	return 0;
> +}
> +
> +static int
> +cros_usbpd_charger_set_cur_cooling_state(struct thermal_cooling_device *cdev,
> +					 unsigned long cooling_level)
> +{
> +	struct charger_data *charger = cdev->devdata;
> +	struct port_data *port;
> +	int current_limit;
> +	int idx = -1;
> +	int ret;
> +
> +	for (int i = 0; i < charger->num_registered_psy; i++) {
> +		port = charger->ports[i];
> +		if (port->psy_status == POWER_SUPPLY_STATUS_CHARGING) {
> +			idx = i;
> +			break;
> +		}
> +	}

Why not register one cooling device per charger?
It would make things more predictable.
I have no experience with the thermal subsystem, so this is just a
guess.

> +
> +	if (idx == -1)
> +		return -EINVAL;
> +
> +	current_limit =
> +		port->psy_current_max - (cooling_level * port->psy_current_max /
> +					 CHARGER_COOLING_INTERVALS);
> +	ret = cros_usbpd_charger_set_ext_power_limit(charger, current_limit,
> +						     input_voltage_limit);
> +	if (ret < 0)
> +		return ret;
> +
> +	input_current_limit = (current_limit == port->psy_current_max) ?
> +				      EC_POWER_LIMIT_NONE :
> +				      current_limit;
> +	input_current_cooling_level = cooling_level;
> +	return 0;
> +}
> +
> +static struct thermal_cooling_device_ops cros_usbpd_charger_cooling_ops = {

const

> +	.get_max_state = cros_usbpd_charger_get_max_cooling_state,
> +	.get_cur_state = cros_usbpd_charger_get_cur_cooling_state,
> +	.set_cur_state = cros_usbpd_charger_set_cur_cooling_state,
> +};
> +#endif /* CONFIG_THERMAL_OF */
> +
>  static int cros_usbpd_charger_probe(struct platform_device *pd)
>  {
>  	struct cros_ec_dev *ec_dev = dev_get_drvdata(pd->dev.parent);
> @@ -534,6 +607,9 @@ static int cros_usbpd_charger_probe(struct platform_device *pd)
>  	struct charger_data *charger;
>  	struct power_supply *psy;
>  	struct port_data *port;
> +#ifdef CONFIG_THERMAL_OF
> +	struct thermal_cooling_device *cdev;
> +#endif /* CONFIG_THERMAL_OF */
>  	int ret = -EINVAL;
>  	int i;
>  
> @@ -674,6 +750,18 @@ static int cros_usbpd_charger_probe(struct platform_device *pd)
>  			goto fail;
>  	}
>  
> +#ifdef CONFIG_THERMAL_OF

Avoid ifdef in .c files.
Use if (IS_ENABLED(CONFIG_THERMAL_OF)) in the normal code flow.
The compiler will optimize away all the unreachable code.

> +	cdev = devm_thermal_of_cooling_device_register(
> +		dev, ec_device->dev->of_node, DRV_NAME, charger,
> +		&cros_usbpd_charger_cooling_ops);
> +	if (IS_ERR(cdev)) {
> +		dev_err(dev,
> +			"Failing register thermal cooling device (err:%pe)\n",
> +			cdev);

dev_err_probe().

> +		goto fail;

Does the call to devm_thermal_of_cooling_device_register() work if there
is no OF configuration?

> +	}
> +#endif /* CONFIG_THERMAL_OF */
> +
>  	return 0;
>  
>  fail:
> 
> -- 
> 2.47.0.371.ga323438b13-goog
> 

