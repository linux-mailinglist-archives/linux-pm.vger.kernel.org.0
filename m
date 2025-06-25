Return-Path: <linux-pm+bounces-29515-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D7EAE861B
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 16:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2354617DC16
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 14:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F56261568;
	Wed, 25 Jun 2025 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="M0xdIbrN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B4A17333F;
	Wed, 25 Jun 2025 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750861202; cv=none; b=SopcwZuB70/B2qgxE88f5dUDdV5ExhIyr8pxvF7XI6vJDdMqmf2XO1M1EJN+gOsmkseIlMbFGAd6NG9o6LLS3ewGB1PG9+HipUUA/MWKkehsRXYWWpE3uES6ce6HsCNEJEZI9mjWnUPpkt1uJ4QFWyoVEwxWvwaINZdxnCmok14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750861202; c=relaxed/simple;
	bh=IqMibrc5sWh5QWjmdLH8XSWzIwzV3BbtlmX878iUod4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TE5Kgqku8HtW3iQIjO8f8nA3twZHeJR6SLi/Hh1hWstMWoWL0C3m57ZvXhRD8rAFXWpMrJPWChno2LAsyKD6YOfdk7ig6GV8rtEBjJrbHPYeOdG+u0/2HjkUxLHxiDM5jSLfN2IXWBNG1cA7Uy2ktgV9h/IqIGD7sNScELdSObY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=M0xdIbrN; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 744AF3D875C6;
	Wed, 25 Jun 2025 10:19:52 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id MhNigfhJQi8s; Wed, 25 Jun 2025 10:19:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id D90EC3D8762F;
	Wed, 25 Jun 2025 10:19:50 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com D90EC3D8762F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1750861190; bh=GNbexx3sX6mIuFwLaRFHov3bJehxzgCWamKjMMlMp6g=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=M0xdIbrNy+3sSjszs2FGl0y75VnDm4WBmVg3Ubgsbp3ocoI22K21TOHCBkVlVz1qO
	 9rUaNEusQq2baCGHlDubjBgnmPKa4ivgMUspjcjBkzJDB9E6qKKN+W4nyfFHr3J1zr
	 WpFPJVDzGMTmBiLzPyJ7dEU1sYjWnJczGZurj6sq4mrz83/b4QcP57hyipo0M5bTsM
	 K53bnN1eWCBHBuizev29LfKfM0OqHftcSZxl8OJOduRN4jLd6BDlhN+NnO4KBnFnIS
	 SIe7qJiBaHJrax1SjdOQelarQoSlTFxrYL9MsIQbf/tW7ISLc0wnKDBjfdEl8tqnbZ
	 oZ9Q3czw8EJIQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id q-ES3gUGiOQk; Wed, 25 Jun 2025 10:19:50 -0400 (EDT)
Received: from fedora (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 81D533D875C6;
	Wed, 25 Jun 2025 10:19:50 -0400 (EDT)
Date: Wed, 25 Jun 2025 10:19:49 -0400
From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Frank Li <Frank.li@nxp.com>, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
	Abel Vesa <abelvesa@kernel.org>, Abel Vesa <abelvesa@linux.com>,
	Robin Gong <b38343@freescale.com>, Robin Gong <yibin.gong@nxp.com>,
	Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v7 5/6] power: supply: pf1550: add battery charger support
Message-ID: <aFwFhYoaWoSXcFdR@fedora>
References: <20250612-pf1550-v7-0-0e393b0f45d7@savoirfairelinux.com>
 <20250612-pf1550-v7-5-0e393b0f45d7@savoirfairelinux.com>
 <xgwx65axwiebh27hrq7rluuf7jynb7v4o77mf2zztsf64bx3bw@iagwzeumk2su>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xgwx65axwiebh27hrq7rluuf7jynb7v4o77mf2zztsf64bx3bw@iagwzeumk2su>

Hi Sebastian,

Thanks a lot for the review.

On Sun, Jun 22, 2025 at 02:43:36AM +0200, Sebastian Reichel wrote:
> > +static int pf1550_get_battery_health(struct regmap *regmap, int *val)
> > +{
> > +	unsigned int data;
> > +	int ret;
> > +
> > +	ret = regmap_read(regmap, PF1550_CHARG_REG_BATT_SNS, &data);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	data &= PF1550_BAT_SNS_MASK;
> > +
> > +	switch (data) {
> > +	case PF1550_BAT_NO_DETECT:
> > +		*val = POWER_SUPPLY_HEALTH_DEAD;
> 
> POWER_SUPPLY_HEALTH_NO_BATTERY ?
Yes, it should be no battery. Will update in the next version.
> 
> > +		break;
> > +	case PF1550_BAT_NO_VBUS:
> > +	case PF1550_BAT_LOW_THAN_PRECHARG:
> > +	case PF1550_BAT_CHARG_FAIL:
> > +	case PF1550_BAT_HIGH_THAN_PRECHARG:
> > +		*val = POWER_SUPPLY_HEALTH_GOOD;
> > +		break;
> > +	case PF1550_BAT_OVER_VOL:
> > +		*val = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> > +		break;
> > +	default:
> > +		*val = POWER_SUPPLY_HEALTH_UNKNOWN;
> > +		break;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int pf1550_get_present(struct regmap *regmap, int *val)
> > +{
> > +	unsigned int data;
> > +	int ret;
> > +
> > +	ret = regmap_read(regmap, PF1550_CHARG_REG_BATT_SNS, &data);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	data &= PF1550_BAT_SNS_MASK;
> > +	*val = (data == PF1550_BAT_NO_DETECT) ? 0 : 1;
> > +
> > +	return 0;
> > +}
> 
> You can drop this function + property. It's meant for a battery type
> device.
The pf1550 switches the load between battery and external power depending on
whichever is available.
> > +static void pf1550_chg_bat_work(struct work_struct *work)
> > +{
> > +	struct pf1550_charger *chg = container_of(to_delayed_work(work),
> > +						  struct pf1550_charger,
> > +						  bat_sense_work);
> > +	unsigned int data;
> > +
> > +	if (!chg->charger)
> > +		return;
> 
> This can't be called without a chg->charger being set.
> 
Will drop.
> > +	if (regmap_read(chg->pf1550->regmap, PF1550_CHARG_REG_BATT_SNS, &data)) {
> > +		dev_err(chg->dev, "Read BATT_SNS error.\n");
> > +		return;
> > +	}
> > +
> > +	switch (data & PF1550_BAT_SNS_MASK) {
> > +	case PF1550_BAT_NO_VBUS:
> > +		dev_dbg(chg->dev, "No valid VBUS input.\n");
> > +		break;
> > +	case PF1550_BAT_LOW_THAN_PRECHARG:
> > +		dev_dbg(chg->dev, "VBAT < VPRECHG.LB.\n");
> > +		break;
> > +	case PF1550_BAT_CHARG_FAIL:
> > +		dev_dbg(chg->dev, "Battery charging failed.\n");
> > +		break;
> > +	case PF1550_BAT_HIGH_THAN_PRECHARG:
> > +		dev_dbg(chg->dev, "VBAT > VPRECHG.LB.\n");
> > +		break;
> > +	case PF1550_BAT_OVER_VOL:
> > +		dev_dbg(chg->dev, "VBAT > VBATOV.\n");
> > +		break;
> > +	case PF1550_BAT_NO_DETECT:
> > +		dev_dbg(chg->dev, "Battery not detected.\n");
> > +		break;
> > +	default:
> > +		dev_err(chg->dev, "Unknown value read:%x\n",
> > +			data & PF1550_CHG_SNS_MASK);
> > +	}
> 
> So the whole handler is just for debug purposes?
>
Yes, it is solely for debugging.
> > +}
> > +
> > +static void pf1550_chg_chg_work(struct work_struct *work)
> > +{
> > +	struct pf1550_charger *chg = container_of(to_delayed_work(work),
> > +						  struct pf1550_charger,
> > +						  chg_sense_work);
> > +	unsigned int data;
> > +
> > +	if (!chg->charger)
> > +		return;
> 
> same as pf1550_chg_bat_work.
> 
Will drop.
> > +	if (regmap_read(chg->pf1550->regmap, PF1550_CHARG_REG_CHG_SNS, &data)) {
> > +		dev_err(chg->dev, "Read CHG_SNS error.\n");
> > +		return;
> > +	}
> > +
> > +	switch (data & PF1550_CHG_SNS_MASK) {
> > +	case PF1550_CHG_PRECHARGE:
> > +		dev_dbg(chg->dev, "In pre-charger mode.\n");
> > +		break;
> > +	case PF1550_CHG_CONSTANT_CURRENT:
> > +		dev_dbg(chg->dev, "In fast-charge constant current mode.\n");
> > +		break;
> > +	case PF1550_CHG_CONSTANT_VOL:
> > +		dev_dbg(chg->dev, "In fast-charge constant voltage mode.\n");
> > +		break;
> > +	case PF1550_CHG_EOC:
> > +		dev_dbg(chg->dev, "In EOC mode.\n");
> > +		break;
> > +	case PF1550_CHG_DONE:
> > +		dev_dbg(chg->dev, "In DONE mode.\n");
> > +		break;
> > +	case PF1550_CHG_TIMER_FAULT:
> > +		dev_info(chg->dev, "In timer fault mode.\n");
> > +		break;
> > +	case PF1550_CHG_SUSPEND:
> > +		dev_info(chg->dev, "In thermistor suspend mode.\n");
> > +		break;
> > +	case PF1550_CHG_OFF_INV:
> > +		dev_info(chg->dev, "Input invalid, charger off.\n");
> > +		break;
> > +	case PF1550_CHG_BAT_OVER:
> > +		dev_info(chg->dev, "Battery over-voltage.\n");
> 
> dev_warn possibly?
>
Will update.
> > +		break;
> > +	case PF1550_CHG_OFF_TEMP:
> > +		dev_info(chg->dev, "Temp high, charger off.\n");
> > +		break;
> > +	case PF1550_CHG_LINEAR_ONLY:
> > +		dev_dbg(chg->dev, "In Linear mode, not charging.\n");
> > +		break;
> > +	default:
> > +		dev_err(chg->dev, "Unknown value read:%x\n",
> > +			data & PF1550_CHG_SNS_MASK);
> > +	}
> 
> also all just for debug and othewise the IRQ is not used?
>
Yes, this is also just for debug.
> > +}
> > +
> > +static void pf1550_chg_vbus_work(struct work_struct *work)
> > +{
> > +	struct pf1550_charger *chg = container_of(to_delayed_work(work),
> > +						  struct pf1550_charger,
> > +						  vbus_sense_work);
> > +	bool psy_changed = false;
> > +	unsigned int data;
> > +
> > +	if (!chg->charger)
> > +		return;
> 
> same as pf1550_chg_bat_work.
>
Will drop.
> > +	if (regmap_read(chg->pf1550->regmap, PF1550_CHARG_REG_VBUS_SNS, &data)) {
> > +		dev_err(chg->dev, "Read VBUS_SNS error.\n");
> > +		return;
> > +	}
> > +
> > +	if (data & PF1550_VBUS_UVLO) {
> > +		chg->psy_desc.type = POWER_SUPPLY_TYPE_BATTERY;
> > +		psy_changed = true;
> > +		dev_dbg(chg->dev, "VBUS detached.\n");
> > +	}
> > +	if (data & PF1550_VBUS_IN2SYS)
> > +		dev_dbg(chg->dev, "VBUS_IN2SYS_SNS.\n");
> > +	if (data & PF1550_VBUS_OVLO)
> > +		dev_dbg(chg->dev, "VBUS_OVLO_SNS.\n");
> > +	if (data & PF1550_VBUS_VALID) {
> > +		chg->psy_desc.type = POWER_SUPPLY_TYPE_MAINS;
> > +		psy_changed = true;
> > +		dev_dbg(chg->dev, "VBUS attached.\n");
> > +	}
> 
> Changing the power_supply type dynamically is a big no go. FWIW I'm
> not sure how you came up with this weird type change in the first
> place. As far as I can see this is a normal charger and should just
> set POWER_SUPPLY_TYPE_MAINS in the probe routine and not touch it
> otherwise. 
>
The pf1550 charger receives a VBUS power input which can be provided either by
an AC adapter or a USB bus. A depleted battery is charged using the VBUS power
input (VBUSIN). When no power is supplied to VBUSIN, the pf1550 switches the
load to the connected non-depleted battery.

I could have two power_supply_desc, one for battery and one for the external
power?
> > +
> > +	if (psy_changed)
> > +		power_supply_changed(chg->charger);
> > +}
> > +
> > +static irqreturn_t pf1550_charger_irq_handler(int irq, void *data)
> > +{
> > +	struct pf1550_charger *chg = data;
> > +	struct device *dev = chg->dev;
> > +	int i, irq_type = -1;
> > +
> > +	for (i = 0; i < PF1550_CHARGER_IRQ_NR; i++)
> > +		if (irq == chg->virqs[i])
> > +			irq_type = i;
> > +
> > +	switch (irq_type) {
> > +	case PF1550_CHARG_IRQ_BAT2SOCI:
> > +		dev_info(dev, "BAT to SYS Overcurrent interrupt.\n");
> > +		break;
> > +	case PF1550_CHARG_IRQ_BATI:
> > +		schedule_delayed_work(&chg->bat_sense_work,
> > +				      msecs_to_jiffies(10));
> > +		break;
> > +	case PF1550_CHARG_IRQ_CHGI:
> > +		schedule_delayed_work(&chg->chg_sense_work,
> > +				      msecs_to_jiffies(10));
> > +		break;
> > +	case PF1550_CHARG_IRQ_VBUSI:
> > +		schedule_delayed_work(&chg->vbus_sense_work,
> > +				      msecs_to_jiffies(10));
> > +		break;
> > +	case PF1550_CHARG_IRQ_THMI:
> > +		dev_info(dev, "Thermal interrupt.\n");
> > +		break;
> > +	default:
> > +		dev_err(dev, "unknown interrupt occurred.\n");
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static enum power_supply_property pf1550_charger_props[] = {
> > +	POWER_SUPPLY_PROP_STATUS,
> > +	POWER_SUPPLY_PROP_CHARGE_TYPE,
> > +	POWER_SUPPLY_PROP_HEALTH,
> > +	POWER_SUPPLY_PROP_PRESENT,
> > +	POWER_SUPPLY_PROP_ONLINE,
> > +	POWER_SUPPLY_PROP_MODEL_NAME,
> > +	POWER_SUPPLY_PROP_MANUFACTURER,
> > +};
> > +
> > +static int pf1550_charger_get_property(struct power_supply *psy,
> > +				       enum power_supply_property psp,
> > +				       union power_supply_propval *val)
> > +{
> > +	struct pf1550_charger *chg = power_supply_get_drvdata(psy);
> > +	struct regmap *regmap = chg->pf1550->regmap;
> > +	int ret = 0;
> > +
> > +	switch (psp) {
> > +	case POWER_SUPPLY_PROP_STATUS:
> > +		ret = pf1550_get_charger_state(regmap, &val->intval);
> > +		break;
> > +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> > +		ret = pf1550_get_charge_type(regmap, &val->intval);
> > +		break;
> > +	case POWER_SUPPLY_PROP_HEALTH:
> > +		ret = pf1550_get_battery_health(regmap, &val->intval);
> > +		break;
> > +	case POWER_SUPPLY_PROP_PRESENT:
> > +		ret = pf1550_get_present(regmap, &val->intval);
> > +		break;
> > +	case POWER_SUPPLY_PROP_ONLINE:
> > +		ret = pf1550_get_online(regmap, &val->intval);
> > +		break;
> > +	case POWER_SUPPLY_PROP_MODEL_NAME:
> > +		val->strval = "PF1550";
> > +		break;
> > +	case POWER_SUPPLY_PROP_MANUFACTURER:
> > +		val->strval = "NXP";
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int pf1550_set_constant_volt(struct pf1550_charger *chg,
> > +				    unsigned int uvolt)
> > +{
> > +	unsigned int data;
> > +
> > +	if (uvolt >= 3500000 && uvolt <= 4440000)
> > +		data = 8 + (uvolt - 3500000) / 20000;
> > +	else
> > +		return dev_err_probe(chg->dev, -EINVAL,
> > +				     "Wrong value for constant voltage\n");
> > +
> > +	dev_dbg(chg->dev, "Charging constant voltage: %u (0x%x)\n", uvolt,
> > +		data);
> > +
> > +	return regmap_update_bits(chg->pf1550->regmap,
> > +				  PF1550_CHARG_REG_BATT_REG,
> > +				  PF1550_CHARG_REG_BATT_REG_CHGCV_MASK, data);
> > +}
> > +
> > +static int pf1550_set_min_system_volt(struct pf1550_charger *chg,
> > +				      unsigned int uvolt)
> > +{
> > +	unsigned int data;
> > +
> > +	switch (uvolt) {
> > +	case 3500000:
> > +		data = 0x0;
> > +		break;
> > +	case 3700000:
> > +		data = 0x1;
> > +		break;
> > +	case 4300000:
> > +		data = 0x2;
> > +		break;
> > +	default:
> > +		return dev_err_probe(chg->dev, -EINVAL,
> > +				     "Wrong value for minimum system voltage\n");
> > +	}
> > +
> > +	data <<= PF1550_CHARG_REG_BATT_REG_VMINSYS_SHIFT;
> > +
> > +	dev_dbg(chg->dev, "Minimum system regulation voltage: %u (0x%x)\n",
> > +		uvolt, data);
> > +
> > +	return regmap_update_bits(chg->pf1550->regmap,
> > +				  PF1550_CHARG_REG_BATT_REG,
> > +				  PF1550_CHARG_REG_BATT_REG_VMINSYS_MASK, data);
> > +}
> > +
> > +static int pf1550_set_thermal_regulation_temp(struct pf1550_charger *chg,
> > +					      unsigned int cells)
> > +{
> > +	unsigned int data;
> > +
> > +	switch (cells) {
> > +	case 60:
> > +		data = 0x0;
> > +		break;
> > +	case 75:
> > +		data = 0x1;
> > +		break;
> > +	case 90:
> > +		data = 0x2;
> > +		break;
> > +	case 105:
> > +		data = 0x3;
> > +		break;
> > +	default:
> > +		return dev_err_probe(chg->dev, -EINVAL,
> > +				     "Wrong value for thermal temperature\n");
> > +	}
> > +
> > +	data <<= PF1550_CHARG_REG_THM_REG_CNFG_REGTEMP_SHIFT;
> > +
> > +	dev_dbg(chg->dev, "Thermal regulation loop temperature: %u (0x%x)\n",
> > +		cells, data);
> > +
> > +	return regmap_update_bits(chg->pf1550->regmap,
> > +				  PF1550_CHARG_REG_THM_REG_CNFG,
> > +				  PF1550_CHARG_REG_THM_REG_CNFG_REGTEMP_MASK,
> > +				  data);
> > +}
> > +
> > +/*
> > + * Sets charger registers to proper and safe default values.
> > + */
> > +static int pf1550_reg_init(struct pf1550_charger *chg)
> > +{
> > +	struct device *dev = chg->dev;
> > +	unsigned int data;
> > +	int ret;
> > +
> > +	/* Unmask charger interrupt, mask DPMI and reserved bit */
> > +	ret =  regmap_write(chg->pf1550->regmap, PF1550_CHARG_REG_CHG_INT_MASK,
> > +			    PF1550_CHG_INT_MASK);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret,
> > +				     "Error unmask charger interrupt\n");
> > +
> > +	ret = regmap_read(chg->pf1550->regmap, PF1550_CHARG_REG_VBUS_SNS,
> > +			  &data);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Read charg vbus_sns error\n");
> > +
> > +	if (data & PF1550_VBUS_VALID)
> > +		chg->psy_desc.type = POWER_SUPPLY_TYPE_MAINS;
> > +
> > +	ret = pf1550_set_constant_volt(chg, chg->constant_volt);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = pf1550_set_min_system_volt(chg, chg->min_system_volt);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = pf1550_set_thermal_regulation_temp(chg,
> > +						 chg->thermal_regulation_temp);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Turn on charger */
> > +	ret = regmap_write(chg->pf1550->regmap, PF1550_CHARG_REG_CHG_OPER,
> > +			   PF1550_CHG_TURNON);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Error turn on charger\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static void pf1550_dt_parse_dev_info(struct pf1550_charger *chg)
> > +{
> > +	struct power_supply_battery_info *info;
> > +	struct device *dev = chg->dev;
> > +
> > +	if (device_property_read_u32(dev->parent, "nxp,min-system-microvolt",
> > +				     &chg->min_system_volt))
> > +		chg->min_system_volt = PF1550_DEFAULT_MIN_SYSTEM_VOLT;
> > +
> > +	if (device_property_read_u32(dev->parent,
> > +				     "nxp,thermal-regulation-celsius",
> > +				     &chg->thermal_regulation_temp))
> > +		chg->thermal_regulation_temp = PF1550_DEFAULT_THERMAL_TEMP;
> > +
> > +	if (power_supply_get_battery_info(chg->charger, &info))
> > +		chg->constant_volt = PF1550_DEFAULT_CONSTANT_VOLT;
> > +	else
> > +		chg->constant_volt = info->constant_charge_voltage_max_uv;
> > +}
> > +
> > +static int pf1550_charger_probe(struct platform_device *pdev)
> > +{
> > +	const struct pf1550_dev *pf1550 = dev_get_drvdata(pdev->dev.parent);
> > +	struct power_supply_config psy_cfg = {};
> > +	struct pf1550_charger *chg;
> > +	int i, irq, ret;
> > +
> > +	chg = devm_kzalloc(&pdev->dev, sizeof(*chg), GFP_KERNEL);
> > +	if (!chg)
> > +		return -ENOMEM;
> > +
> > +	chg->dev = &pdev->dev;
> > +	chg->pf1550 = pf1550;
> > +
> > +	if (!chg->pf1550->regmap)
> > +		return dev_err_probe(&pdev->dev, -ENODEV,
> > +				     "failed to get regmap\n");
> > +
> > +	platform_set_drvdata(pdev, chg);
> > +
> > +	INIT_DELAYED_WORK(&chg->vbus_sense_work, pf1550_chg_vbus_work);
> > +	INIT_DELAYED_WORK(&chg->chg_sense_work, pf1550_chg_chg_work);
> > +	INIT_DELAYED_WORK(&chg->bat_sense_work, pf1550_chg_bat_work);
> 
> use devm_delayed_work_autocancel(). It's not just a cleanup, but
> also fixed a race condition during module removal, as you are right
> now cancelling the job while a new one might be scheduled directly
> afterwards before the power-supply device is deregistered.
>
Will do.
> > +	for (i = 0; i < PF1550_CHARGER_IRQ_NR; i++) {
> > +		irq = platform_get_irq(pdev, i);
> > +		if (irq < 0)
> > +			return irq;
> > +
> > +		chg->virqs[i] = irq;
> > +
> > +		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> > +						pf1550_charger_irq_handler,
> > +						IRQF_NO_SUSPEND,
> > +						"pf1550-charger", chg);
> > +		if (ret)
> > +			return dev_err_probe(&pdev->dev, ret,
> > +					     "failed irq request\n");
> > +	}
> > +
> > +	psy_cfg.drv_data = chg;
> > +
> > +	chg->psy_desc.name = PF1550_CHARGER_NAME;
> > +	chg->psy_desc.type = POWER_SUPPLY_TYPE_BATTERY;
> > +	chg->psy_desc.get_property = pf1550_charger_get_property;
> > +	chg->psy_desc.properties = pf1550_charger_props;
> > +	chg->psy_desc.num_properties = ARRAY_SIZE(pf1550_charger_props);
> > +
> > +	chg->charger = devm_power_supply_register(&pdev->dev, &chg->psy_desc,
> > +						  &psy_cfg);
> > +	if (IS_ERR(chg->charger))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(chg->charger),
> > +				     "failed: power supply register\n");
> > +
> > +	pf1550_dt_parse_dev_info(chg);
> > +
> > +	return pf1550_reg_init(chg);
> > +}
> > +

Thanks,
Sam

