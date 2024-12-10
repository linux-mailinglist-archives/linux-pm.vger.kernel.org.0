Return-Path: <linux-pm+bounces-18923-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 595089EB70B
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 17:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC89D18829BF
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 16:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191EF22FE1E;
	Tue, 10 Dec 2024 16:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="d03JJPwx"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6AA22FE15;
	Tue, 10 Dec 2024 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849436; cv=none; b=Mk2Bwma8maUwPbvZJIZ4hcrXkDyM7yVcB3kSv+JMi0Vn0B6r5je5JE42N1JkkI9JjuCCMy7qyoqzlfCo9019aiXhwD+Nl/Rv+k0R5T9eCiBzRX0VJQT+vfAkaxygdblD7+QhLimiHzRrp3adSztv+zHJgPRJNG/CRPgTxGOARwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849436; c=relaxed/simple;
	bh=zxZSWOMmUryEr6zRrQCsXK2cjC135qdU1twm+VkmFow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=taQXMuBwQkehmDAXQYRtltxPWmFF47L47AtHHHqxJGPZpCOcR4ICf3lCzMLymybmnoWs5CfDTkLaj/VL7T7pdwpQtJHQPSxFKyqtIP2r47mC/0FBSrJvP+yikCeYd0rpxx419Nk8FfueC+7KTT4k3p7l2sJ8Gl7o+BGoFZysqFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=d03JJPwx; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733849430;
	bh=zxZSWOMmUryEr6zRrQCsXK2cjC135qdU1twm+VkmFow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d03JJPwxoTySBdJmt7yqxtCD3Mqj1JTs8xG47CyStSAljW6IHtV3Ei1vzyHzjQEcf
	 BQ+x1jaRrVg0iyuz7cTd93Ul8B1Jr0nedCZgb9bWM2kCoNOPrWJ/ecpWa8mqmFtPTj
	 3nblKGDvV9RBjqS+/IAnDoFHt/MYNkSuAQ5nJpSY=
Date: Tue, 10 Dec 2024 17:50:30 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	platform-driver-x86@vger.kernel.org, Jelle van der Waa <jelle@vdwaa.nl>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/4] power: supply: core: Add new "charge_types"
 property
Message-ID: <9aa6ad55-d0c3-4cdc-82a9-0c3906f77f30@t-8ch.de>
References: <20241209204051.8786-1-hdegoede@redhat.com>
 <20241209204051.8786-3-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209204051.8786-3-hdegoede@redhat.com>

On 2024-12-09 21:40:49+0100, Hans de Goede wrote:
> Add a new "charge_types" property, this is identical to "charge_type" but
> reading returns a list of supported charge-types with the currently active
> type surrounded by square brackets, e.g.:
> 
> Fast [Standard] "Long_Life"
> 
> This has the advantage over the existing "charge_type" property that this
> allows userspace to find out which charge-types are supported for writable
> charge_type properties.
> 
> Drivers which already support "charge_type" can easily add support for
> this by setting power_supply_desc.charge_types to a bitmask representing
> valid charge_type values. The existing "charge_type" get_property() and
> set_property() code paths can be re-used for "charge_types".

IMO it would be nice to have the psy core implement "charge_type" in
terms of "charge_types" if that is available.
(And reject a custom "charge_type" in that case)

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - Add "Check charge_types to get the values supported by the battery."
>   to Documentation/ABI/testing/sysfs-class-power
> - Add a note about labels with spaces having these replaced by '_'
>   to Documentation/ABI/testing/sysfs-class-power
> - Use power_supply_match_string() in power_supply_charge_types_parse()
> ---
>  Documentation/ABI/testing/sysfs-class-power | 20 ++++++++++++
>  drivers/power/supply/power_supply_sysfs.c   | 34 +++++++++++++++++++++
>  include/linux/power_supply.h                | 23 +++++++++++++-
>  3 files changed, 76 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index 45180b62d426..4421815cfb40 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -407,10 +407,30 @@ Description:
>  
>  		Access: Read, Write
>  
> +		Reading this returns the current active value, e.g. 'Standard'.
> +		Check charge_types to get the values supported by the battery.
> +
>  		Valid values:
>  			      "Unknown", "N/A", "Trickle", "Fast", "Standard",
>  			      "Adaptive", "Custom", "Long Life", "Bypass"
>  
> +What:		/sys/class/power_supply/<supply_name>/charge_types
> +Date:		November 2024
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Identical to charge_type but reading returns a list of supported
> +		charge-types with the currently active type surrounded by square
> +		brackets, e.g.: "Fast [Standard] Long_Life".
> +
> +		power_supply class devices may support both charge_type and
> +		charge_types for backward compatibility. In this case both will
> +		always have the same active value and the active value can be
> +		changed by writing either property.
> +
> +		Note charge-types which contain a space such as "Long Life" will
> +		have the space replaced by a '_' resulting in e.g. "Long_Life".
> +		When writing charge-types both variants are accepted.
> +
>  What:		/sys/class/power_supply/<supply_name>/charge_term_current
>  Date:		July 2014
>  Contact:	linux-pm@vger.kernel.org
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index 034e1848f1ca..48a9bf791a38 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -182,6 +182,8 @@ static struct power_supply_attr power_supply_attrs[] __ro_after_init = {
>  	POWER_SUPPLY_ATTR(CHARGE_CONTROL_START_THRESHOLD),
>  	POWER_SUPPLY_ATTR(CHARGE_CONTROL_END_THRESHOLD),
>  	POWER_SUPPLY_ENUM_ATTR(CHARGE_BEHAVIOUR),
> +	/* Same enum value texts as "charge_type" without the 's' at the end */
> +	_POWER_SUPPLY_ENUM_ATTR(CHARGE_TYPES, POWER_SUPPLY_CHARGE_TYPE_TEXT),
>  	POWER_SUPPLY_ATTR(INPUT_CURRENT_LIMIT),
>  	POWER_SUPPLY_ATTR(INPUT_VOLTAGE_LIMIT),
>  	POWER_SUPPLY_ATTR(INPUT_POWER_LIMIT),
> @@ -335,6 +337,10 @@ static ssize_t power_supply_show_property(struct device *dev,
>  		ret = power_supply_charge_behaviour_show(dev, psy->desc->charge_behaviours,
>  							 value.intval, buf);
>  		break;
> +	case POWER_SUPPLY_PROP_CHARGE_TYPES:

This should only show a single value for uevent. The same as
charge_behaviours above (done in a recent change).

> +		ret = power_supply_charge_types_show(dev, psy->desc->charge_types,
> +						     value.intval, buf);
> +		break;
>  	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_SERIAL_NUMBER:
>  		ret = sysfs_emit(buf, "%s\n", value.strval);
>  		break;
> @@ -571,3 +577,31 @@ int power_supply_charge_behaviour_parse(unsigned int available_behaviours, const
>  	return -EINVAL;
>  }
>  EXPORT_SYMBOL_GPL(power_supply_charge_behaviour_parse);
> +
> +ssize_t power_supply_charge_types_show(struct device *dev,
> +				       unsigned int available_types,
> +				       enum power_supply_charge_type current_type,
> +				       char *buf)
> +{
> +	return power_supply_show_enum_with_available(
> +				dev, POWER_SUPPLY_CHARGE_TYPE_TEXT,
> +				ARRAY_SIZE(POWER_SUPPLY_CHARGE_TYPE_TEXT),
> +				available_types, current_type, buf);
> +}
> +EXPORT_SYMBOL_GPL(power_supply_charge_types_show);
> +
> +int power_supply_charge_types_parse(unsigned int available_types, const char *buf)
> +{
> +	int i = power_supply_match_string(POWER_SUPPLY_CHARGE_TYPE_TEXT,
> +					  ARRAY_SIZE(POWER_SUPPLY_CHARGE_TYPE_TEXT),
> +					  buf);
> +
> +	if (i < 0)
> +		return i;
> +
> +	if (available_types & BIT(i))
> +		return i;
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(power_supply_charge_types_parse);
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index b98106e1a90f..60c7f669ec3e 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -40,7 +40,7 @@ enum {
>  };
>  
>  /* What algorithm is the charger using? */
> -enum {
> +enum power_supply_charge_type {
>  	POWER_SUPPLY_CHARGE_TYPE_UNKNOWN = 0,
>  	POWER_SUPPLY_CHARGE_TYPE_NONE,
>  	POWER_SUPPLY_CHARGE_TYPE_TRICKLE,	/* slow speed */
> @@ -135,6 +135,7 @@ enum power_supply_property {
>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD, /* in percents! */
>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD, /* in percents! */
>  	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
> +	POWER_SUPPLY_PROP_CHARGE_TYPES,

Could the related enum values be kept together?

>  	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
>  	POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT,
>  	POWER_SUPPLY_PROP_INPUT_POWER_LIMIT,
> @@ -245,6 +246,7 @@ struct power_supply_desc {
>  	const char *name;
>  	enum power_supply_type type;
>  	u8 charge_behaviours;
> +	u32 charge_types;
>  	u32 usb_types;
>  	const enum power_supply_property *properties;
>  	size_t num_properties;
> @@ -944,6 +946,11 @@ ssize_t power_supply_charge_behaviour_show(struct device *dev,
>  					   char *buf);
>  
>  int power_supply_charge_behaviour_parse(unsigned int available_behaviours, const char *buf);
> +ssize_t power_supply_charge_types_show(struct device *dev,
> +				       unsigned int available_types,
> +				       enum power_supply_charge_type current_type,
> +				       char *buf);
> +int power_supply_charge_types_parse(unsigned int available_types, const char *buf);
>  #else
>  static inline
>  ssize_t power_supply_charge_behaviour_show(struct device *dev,
> @@ -959,6 +966,20 @@ static inline int power_supply_charge_behaviour_parse(unsigned int available_beh
>  {
>  	return -EOPNOTSUPP;
>  }
> +
> +static inline
> +ssize_t power_supply_charge_types_show(struct device *dev,
> +				       unsigned int available_types,
> +				       enum power_supply_charge_type current_type,
> +				       char *buf)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int power_supply_charge_types_parse(unsigned int available_types, const char *buf)
> +{
> +	return -EOPNOTSUPP;
> +}
>  #endif
>  
>  #endif /* __LINUX_POWER_SUPPLY_H__ */
> -- 
> 2.47.1
> 

