Return-Path: <linux-pm+bounces-18040-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 729259D7D79
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 09:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF34B1637BB
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 08:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F5C18E050;
	Mon, 25 Nov 2024 08:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="qivXEEi9"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0463718D649;
	Mon, 25 Nov 2024 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732524661; cv=none; b=eOaGMxPG7eQc2vbYFib1hGaolJPk5QDmyZT89w9y9OfrOKm5s/oyl0icyrACPXi27KKzanNXPSf7bzMKLxV+oHPyfo/dpjPSaFwi9RUxiClWUggrbL6t2czZCjaxUq2Q7oIFfTjcHJKuRzymWyptLqMYKFU8rnflhXxZGZ38ang=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732524661; c=relaxed/simple;
	bh=0iUN2yu7Ghaf6/FfjQx7895ONseHSNLpsd10/qOsSm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6KOJXBc87fV1sAFUSLCqTIQL3Rd3rVqpZ+jZDFHIA1o0AZKTRhBEa/jeeocGHHIGSqbL8auvFJ+wn8OuNfMyT7pPsmH63AmPTozdRSBWqedU3zJWGhGglT8LNpRk5kS9WjRVdh2v1Y17pi/otfI3Q9R8mCD3zJzsWM8KyW/mqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=qivXEEi9; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1732524655; bh=0iUN2yu7Ghaf6/FfjQx7895ONseHSNLpsd10/qOsSm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qivXEEi9Wjl224Ts3KfU48zRWhYyi2snyTBobhaEOBhMp4+CJI+nU9hzdBGEBKG+6
	 eeXGJnRtga8Z7egCddXihXZa/H6wEWm4k5g/8IPpW1Ruw/R3K1mnGg7nAkB4R8ctO5
	 zPO5Ayl/Our1gNgN7WX0HYvF+NVynZL/1qAtfuW8=
Date: Mon, 25 Nov 2024 09:50:54 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: "Sung-Chi, Li" <lschyi@chromium.org>
Cc: Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] power: supply: cros_usbpd-charger: extend as a
 thermal of cooling device
Message-ID: <04e5c795-c246-44e0-a31c-a4ff01b777f9@t-8ch.de>
References: <20241122-extend_power_limit-v1-0-a3ecd87afa76@chromium.org>
 <20241122-extend_power_limit-v1-1-a3ecd87afa76@chromium.org>
 <f805c0d8-a7f7-4e03-8d8c-0c13baa02ac4@t-8ch.de>
 <Z0Pi-_BUnf9OdcAM@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z0Pi-_BUnf9OdcAM@google.com>

On 2024-11-25 10:37:47+0800, Sung-Chi, Li wrote:
> On Fri, Nov 22, 2024 at 11:21:18AM +0100, Thomas Weißschuh wrote:
> > On 2024-11-22 11:47:21+0800, Sung-Chi Li wrote:
> > > 
> > > diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
> > > index 47d3f58aa15c..a0451630cdd7 100644
> > > --- a/drivers/power/supply/cros_usbpd-charger.c
> > > +++ b/drivers/power/supply/cros_usbpd-charger.c
> > > @@ -13,6 +13,9 @@
> > >  #include <linux/platform_device.h>
> > >  #include <linux/power_supply.h>
> > >  #include <linux/slab.h>
> > > +#ifdef CONFIG_THERMAL_OF
> > 
> > Remove this ifdef. The header is perfectly usable in any case.
> > 
> > Actually the CONFIG_THERMAL_OF dependency is not needed at all.
> > It is only necessary for devm_thermal_of_zone_register() but not 
> > devm_thermal_of_cooling_device_register() which you are using.
> > I am confused.
> > 
> > OTOH you are adding the #cooling-cells OF property which itself seems to
> > be only used by devm_thermal_of_zone_register(), so I'm now even more
> > confused.
> > 
> > In general, try to also test the driver configurations
> > !CONFIG_THERMAL_OF and !CONFIG_THERMAL.
> > 
> 
> Thank you, I removed the ifdef. Yes, it is confusing that
> devm_thermal_of_cooling_device_register() does not depend on CONFIG_THERMAL_OF.
> You can supply NULL to the device_node to
> devm_thermal_of_cooling_device_register(), and if you are going the OF route,
> you then fail at devm_thermal_of_zone_register(), because that call requires the
> supplied device_node to have property '#cooling-cells'.
> 
> I would like to split the handling on thermal side to OF route and non-OF route,
> so I would use CONFIG_THERMAL_OF to decide which route to go.

Thanks for the clarifications and thinking about this usecase.

> > > +#include <linux/thermal.h>
> > > +#endif /* CONFIG_THERMAL_OF */
> > >  
> > >  #define CHARGER_USBPD_DIR_NAME			"CROS_USBPD_CHARGER%d"
> > >  #define CHARGER_DEDICATED_DIR_NAME		"CROS_DEDICATED_CHARGER"
> > > @@ -22,6 +25,7 @@
> > >  					 sizeof(CHARGER_DEDICATED_DIR_NAME))
> > >  #define CHARGER_CACHE_UPDATE_DELAY		msecs_to_jiffies(500)
> > >  #define CHARGER_MANUFACTURER_MODEL_LENGTH	32
> > > +#define CHARGER_COOLING_INTERVALS		10
> > >  
> > >  #define DRV_NAME "cros-usbpd-charger"
> > >  
> > > @@ -76,6 +80,8 @@ static enum power_supply_property cros_usbpd_dedicated_charger_props[] = {
> > >  /* Input voltage/current limit in mV/mA. Default to none. */
> > >  static u16 input_voltage_limit = EC_POWER_LIMIT_NONE;
> > >  static u16 input_current_limit = EC_POWER_LIMIT_NONE;
> > > +/* Cooling level interns of current limit */
> > > +static u16 input_current_cooling_level;
> > >  
> > >  static bool cros_usbpd_charger_port_is_dedicated(struct port_data *port)
> > >  {
> > > @@ -459,13 +465,20 @@ static int cros_usbpd_charger_set_prop(struct power_supply *psy,
> s ap> >  			break;
> > >  
> > >  		input_current_limit = intval;
> > > -		if (input_current_limit == EC_POWER_LIMIT_NONE)
> > > +		if (input_current_limit == EC_POWER_LIMIT_NONE) {
> > >  			dev_info(dev,
> > >  			  "External Current Limit cleared for all ports\n");
> > > -		else
> > > -			dev_info(dev,
> > > -			  "External Current Limit set to %dmA for all ports\n",
> > > -			  input_current_limit);
> > > +			input_current_cooling_level = 0;
> > > +		} else {
> > > +			dev_info(
> > > +				dev,
> > > +				"External Current Limit set to %dmA for all ports\n",
> > > +				input_current_limit);
> > > +			input_current_cooling_level =
> > > +				input_current_limit *
> > > +				CHARGER_COOLING_INTERVALS /
> > > +				port->psy_current_max;
> > 
> > This seems to be a very spammy driver...
> > 
> 
> Hmm, I did not add extra logs, just that I add more actions in these branches
> when the current limit is applied, so the clang format tool touches these lines.
> 
> I think I can revert the formatting changes, and maybe I can make these logs to
> dev_dbg in a following commit.

This wasn't a real review comment for your patch, only a general
observation. Maybe it's worth to have a dedicated commit trimming down
the dev_info() to dev_dbg() and reducing the spam during probe
(failures).

> 
> > > +		}
> > >  		break;
> > >  	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
> > >  		ret = cros_usbpd_charger_set_ext_power_limit(charger,
> > > @@ -525,6 +538,66 @@ static void cros_usbpd_charger_unregister_notifier(void *data)
> > >  	cros_usbpd_unregister_notify(&charger->notifier);
> > >  }
> > >  
> > > +#ifdef CONFIG_THERMAL_OF
> > > +static int
> > > +cros_usbpd_charger_get_max_cooling_state(struct thermal_cooling_device *cdev,
> > > +					 unsigned long *cooling_level)
> > > +{
> > > +	*cooling_level = CHARGER_COOLING_INTERVALS;
> > > +	return 0;
> > > +}
> > > +
> > > +static int
> > > +cros_usbpd_charger_get_cur_cooling_state(struct thermal_cooling_device *cdev,
> > > +					 unsigned long *cooling_level)
> > > +{
> > > +	*cooling_level = input_current_cooling_level;
> > > +	return 0;
> > > +}
> > > +
> > > +static int
> > > +cros_usbpd_charger_set_cur_cooling_state(struct thermal_cooling_device *cdev,
> > > +					 unsigned long cooling_level)
> > > +{
> > > +	struct charger_data *charger = cdev->devdata;
> > > +	struct port_data *port;
> > > +	int current_limit;
> > > +	int idx = -1;
> > > +	int ret;
> > > +
> > > +	for (int i = 0; i < charger->num_registered_psy; i++) {
> > > +		port = charger->ports[i];
> > > +		if (port->psy_status == POWER_SUPPLY_STATUS_CHARGING) {
> > > +			idx = i;
> > > +			break;
> > > +		}
> > > +	}
> > 
> > Why not register one cooling device per charger?
> > It would make things more predictable.
> > I have no experience with the thermal subsystem, so this is just a
> > guess.
> > 
> 
> The driver has only one power limiting instance, so I treat the whole EC as a
> cooling device. This is also more convenient when crafting the thermal zone
> settings. Maybe we can see how other reviewers think?

Yes, I am don't know much about the thermal subsystem.

> > > +	.get_max_state = cros_usbpd_charger_get_max_cooling_state,
> > > +	.get_cur_state = cros_usbpd_charger_get_cur_cooling_state,
> > > +	.set_cur_state = cros_usbpd_charger_set_cur_cooling_state,
> > > +};
> > > +#endif /* CONFIG_THERMAL_OF */
> > > +
> > >  static int cros_usbpd_charger_probe(struct platform_device *pd)
> > >  {
> > >  	struct cros_ec_dev *ec_dev = dev_get_drvdata(pd->dev.parent);
> > > @@ -534,6 +607,9 @@ static int cros_usbpd_charger_probe(struct platform_device *pd)
> > >  	struct charger_data *charger;
> > >  	struct power_supply *psy;
> > >  	struct port_data *port;
> > > +#ifdef CONFIG_THERMAL_OF
> > > +	struct thermal_cooling_device *cdev;
> > > +#endif /* CONFIG_THERMAL_OF */
> > >  	int ret = -EINVAL;
> > >  	int i;
> > >  
> > > @@ -674,6 +750,18 @@ static int cros_usbpd_charger_probe(struct platform_device *pd)
> > >  			goto fail;
> > >  	}
> > >  
> > > +#ifdef CONFIG_THERMAL_OF
> > 
> > Avoid ifdef in .c files.
> > Use if (IS_ENABLED(CONFIG_THERMAL_OF)) in the normal code flow.
> > The compiler will optimize away all the unreachable code.
> > 
> 
> Thank you, applied this approach when using CONFIG_THERMAL_OF.
> 
> > > +	cdev = devm_thermal_of_cooling_device_register(
> > > +		dev, ec_device->dev->of_node, DRV_NAME, charger,
> > > +		&cros_usbpd_charger_cooling_ops);
> > > +	if (IS_ERR(cdev)) {
> > > +		dev_err(dev,
> > > +			"Failing register thermal cooling device (err:%pe)\n",
> > > +			cdev);
> > 
> > dev_err_probe().
> > 
> > > +		goto fail;
> > 
> > Does the call to devm_thermal_of_cooling_device_register() work if there
> > is no OF configuration?
> > 
> > > +	}
> > > +#endif /* CONFIG_THERMAL_OF */
> > > +
> > >  	return 0;
> > >  
> > >  fail:
> > > 
> > > -- 
> > > 2.47.0.371.ga323438b13-goog
> > > 
> 
> As the thermal functionality is later added to extend this driver, I think you
> are right, it would be better to make this behavior just make warnings, rather
> than directly failing this driver probe. Will use dev_warn_probe, and do not
> goto fail branch for registering it as a cooling device.

Can it also be an info? There should be existing devices in the field
without the OF configuration which will run your mainline driver.

