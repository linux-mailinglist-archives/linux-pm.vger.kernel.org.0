Return-Path: <linux-pm+bounces-2529-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D618385A2
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jan 2024 03:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 188371C2659D
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jan 2024 02:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAF31854;
	Tue, 23 Jan 2024 02:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="fQQ5yhGW"
X-Original-To: linux-pm@vger.kernel.org
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E48184;
	Tue, 23 Jan 2024 02:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705977673; cv=none; b=ZQtRqVYDlYioaYtCsiyRHyglPvUCScMnbsO19TLxFfX7HrYGb0kKQSnJO78Af73j3HYXzDQm2XGX8WDtg8cbH+QS2s1MoNL8gjcGizFBO9DfI2/0aQhoyLuGKOua8T+PUg5lj//IIJFUK2wdbZX6LsVUaLAIGDv3HMYR/6iLWo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705977673; c=relaxed/simple;
	bh=kLp8meRYf6WAyXXCjrEl3NJH0W1GjlZ5PFKii4fgdFE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxFw3smPU1nuNxPWBmPVLyuT0d4x5kHvaaBHMJCiTCbul3ohUI3y/mGC73NMKNWFGEJ8TJMygKkpr9m/E1Gt577p3zcLMQnWozYafaNogpcX0YmtcC4Ze6om+o5U4tlZVYvxjuWJFwFHV7YEN7xQXUWfK8SABn/bRL4b0XJtOlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=fQQ5yhGW; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id DD29746341;
	Tue, 23 Jan 2024 02:41:09 +0000 (UTC)
Date: Mon, 22 Jan 2024 21:41:07 -0500
From: Aren <aren@peacevolution.org>
To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, 
	Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/3] power: supply: axp20x_usb_power: enable usb_type
 reporting
Message-ID: <ethqwdndxmvqbcxvxkcj45iewutfb2d3zwka75yk67aavxoysf@pr2qrtd5rc7a>
References: <20240121014057.1042466-1-aren@peacevolution.org>
 <20240121014057.1042466-5-aren@peacevolution.org>
 <yltrgkwj3evlyj6lu6ltdk2kg5bchtzginpx7dyblt6aqtdzwp@noczofep5o5b>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yltrgkwj3evlyj6lu6ltdk2kg5bchtzginpx7dyblt6aqtdzwp@noczofep5o5b>
X-Spamd-Bar: /
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1705977670;
	h=from:subject:date:message-id:to:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
	bh=K6YQbP62dv7PqeMoua4cZkGTK4uQWle4Ke5iT1tdknQ=;
	b=fQQ5yhGWWTr4IwtJzOtx4F/LlI9/tvsVMBUxC3NnhLqsdUC/tSkNdSd86IdTjMIBSRjbaU
	DE9smiSBCRiZavPpIXrF2XauZtVhOtGwZFj8ZLlgMGBVSB/iXX6Go4D1u7rbNo9ccFUp1K
	esWAk1hQ7vGg7qv0EnbVa3C3XNuF21Y=

On Sun, Jan 21, 2024 at 12:55:43PM +0100, Ondřej Jirman wrote:
> Hello Aren,
> 
> On Sat, Jan 20, 2024 at 08:40:02PM -0500, Aren Moynihan wrote:
> > Axp803 and axp813 can report the detected usb bc mode. SDP, CDP, and DCP
> > are supported.
> > 
> > Signed-off-by: Aren Moynihan <aren@peacevolution.org>
> > ---
> > 
> >  drivers/power/supply/axp20x_usb_power.c | 52 +++++++++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> > 
> > diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
> > index 8c0c2c25565f..5656f6e57d54 100644
> > --- a/drivers/power/supply/axp20x_usb_power.c
> > +++ b/drivers/power/supply/axp20x_usb_power.c
> > @@ -57,6 +57,7 @@ struct axp_data {
> >  	struct reg_field		vbus_valid_bit;
> >  	struct reg_field		vbus_mon_bit;
> >  	struct reg_field		usb_bc_en_bit;
> > +	struct reg_field		usb_bc_det_fld;
> >  	struct reg_field		vbus_disable_bit;
> >  	bool				vbus_needs_polling: 1;
> >  };
> > @@ -69,6 +70,7 @@ struct axp20x_usb_power {
> >  	struct regmap_field *vbus_valid_bit;
> >  	struct regmap_field *vbus_mon_bit;
> >  	struct regmap_field *usb_bc_en_bit;
> > +	struct regmap_field *usb_bc_det_fld;
> >  	struct regmap_field *vbus_disable_bit;
> >  	struct power_supply *supply;
> >  	const struct axp_data *axp_data;
> > @@ -197,6 +199,37 @@ axp20x_usb_power_get_input_current_limit(struct axp20x_usb_power *power,
> >  	return 0;
> >  }
> >  
> > +static int axp20x_get_usb_type(struct axp20x_usb_power *power,
> > +			       union power_supply_propval *val)
> > +{
> > +	unsigned int reg;
> > +	int ret;
> > +
> > +	if (!power->usb_bc_det_fld)
> > +		return -EINVAL;
> 
> What if detection is disabled becase custom input current limit was set by the
> user? Does the HW keep the result of previous detection in the register?

In that case the result appears to be USB_TYPE_UNKNOWN. I don't expect
that would cause problems, but I guess we could cache the value when
disabling usb bc detection if necessary.

> Kind regards,
> 	Ondrej
> 
> > +	ret = regmap_field_read(power->usb_bc_det_fld, &reg);
> > +	if (ret)
> > +		return ret;
> > +
> > +	switch (reg) {
> > +	case 1:
> > +		val->intval = POWER_SUPPLY_USB_TYPE_SDP;
> > +		break;
> > +	case 2:
> > +		val->intval = POWER_SUPPLY_USB_TYPE_CDP;
> > +		break;
> > +	case 3:
> > +		val->intval = POWER_SUPPLY_USB_TYPE_DCP;
> > +		break;
> > +	default:
> > +		val->intval = POWER_SUPPLY_USB_TYPE_UNKNOWN;
> > +		break;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int axp20x_usb_power_get_property(struct power_supply *psy,
> >  	enum power_supply_property psp, union power_supply_propval *val)
> >  {
> > @@ -266,6 +299,8 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
> >  	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> >  		return axp20x_usb_power_get_input_current_limit(power,
> >  								&val->intval);
> > +	case POWER_SUPPLY_PROP_USB_TYPE:
> > +		return axp20x_get_usb_type(power, val);
> >  	default:
> >  		break;
> >  	}
> > @@ -423,6 +458,14 @@ static enum power_supply_property axp813_usb_power_properties[] = {
> >  	POWER_SUPPLY_PROP_VOLTAGE_MIN,
> >  	POWER_SUPPLY_PROP_CURRENT_MAX,
> >  	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> > +	POWER_SUPPLY_PROP_USB_TYPE,
> > +};
> > +
> > +static enum power_supply_usb_type axp813_usb_types[] = {
> > +	POWER_SUPPLY_USB_TYPE_SDP,
> > +	POWER_SUPPLY_USB_TYPE_DCP,
> > +	POWER_SUPPLY_USB_TYPE_CDP,
> > +	POWER_SUPPLY_USB_TYPE_UNKNOWN,
> >  };
> >  
> >  static const struct power_supply_desc axp20x_usb_power_desc = {
> > @@ -453,6 +496,8 @@ static const struct power_supply_desc axp813_usb_power_desc = {
> >  	.property_is_writeable = axp20x_usb_power_prop_writeable,
> >  	.get_property = axp20x_usb_power_get_property,
> >  	.set_property = axp20x_usb_power_set_property,
> > +	.usb_types = axp813_usb_types,
> > +	.num_usb_types = ARRAY_SIZE(axp813_usb_types),
> >  };
> >  
> >  static const char * const axp20x_irq_names[] = {
> > @@ -555,6 +600,7 @@ static const struct axp_data axp813_data = {
> >  	.input_curr_lim_table = axp_813_usb_input_curr_lim_table,
> >  	.input_curr_lim_fld = REG_FIELD(AXP22X_CHRG_CTRL3, 4, 7),
> >  	.usb_bc_en_bit	= REG_FIELD(AXP288_BC_GLOBAL, 0, 0),
> > +	.usb_bc_det_fld = REG_FIELD(AXP288_BC_DET_STAT, 5, 7),
> >  	.vbus_disable_bit = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 7, 7),
> >  	.vbus_needs_polling = true,
> >  };
> > @@ -708,6 +754,12 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		return ret;
> >  
> > +	ret = axp20x_regmap_field_alloc_optional(&pdev->dev, power->regmap,
> > +						 axp_data->usb_bc_det_fld,
> > +						 &power->usb_bc_det_fld);
> > +	if (ret)
> > +		return ret;
> > +
> >  	ret = axp20x_regmap_field_alloc_optional(&pdev->dev, power->regmap,
> >  						 axp_data->vbus_disable_bit,
> >  						 &power->vbus_disable_bit);
> > -- 
> > 2.43.0
> > 

