Return-Path: <linux-pm+bounces-9127-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3B8907F3E
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 01:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A57AFB20D1D
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 23:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E5814D2B9;
	Thu, 13 Jun 2024 23:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="XQpl9Jbh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D8F13B797;
	Thu, 13 Jun 2024 23:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718320300; cv=none; b=i4/829xUCIM+TNrVj7ZFlvh12wM60kBKOT+f2tirBL33Giiid4aatoxTSiOh96E1/twFXA88x2pWDQfsuOV5yyqvQ4+7ezgPxjDCA3IeLIQP1O8Fs7HWkeXV6ib/saAZiRtoqRZzOgfNpc6HjKaicIrQ4PClzvexvZmM/DXibB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718320300; c=relaxed/simple;
	bh=+YldGtQj37QKKviAQA5kIXNW0aaOtSmZoGsS/yjcJ2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uexpHGWwkI9KG7/WTW2zPPuGdI2m+t7y1J7703OJ0zqTSia6GZMYCLBnhiBI4JAL4yuqtfgrTLTi/9WFlRauW0y+/2Czb87Ro+wAKA1uTqYHJqRRUW/3+pgyMhkeQzpRtS92a46Z+N7uE7FS3T0Aadm3+V8/zPbzMSngKUx41nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=XQpl9Jbh; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1718320290; x=1718925090; i=w_armin@gmx.de;
	bh=JmSqbki9ZVxHtusgNP4SdXHx7bVIZ8Y8P/rsSR4sfP0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XQpl9JbhBIqkJyIx5wd1kIHlGgW7aqc/8pZDRePGwsRCq2Gg5EWK7hbWUreKvKL4
	 3m+QLZGDn0cTBNa2Z+wCCCoAZV4VngccNKNzsa6UFpEnPN1uuW23S8Kejj6dT8RYI
	 kRHfB3W6wt5uOJvxMEypAUDiK9ZDm/UdFc46yU9hlpmMwz1sAp8BAYtEMQZe4xLyd
	 J182xAEXqy7uVfZaKScM9Vd+efCJwuiymebN/b+jpaNIz1bx0D+VBSdG29v1RMRO1
	 l6y123e3NwfUg876pPlCvYogGSm3fQb257BtAUnS/tTsjZF7JOCt8DIHwiUIEnKCZ
	 FuuqEfL/sFwVUMcsfA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8ykg-1sMpHw1Xhm-00BA7A; Fri, 14
 Jun 2024 01:11:30 +0200
Message-ID: <76dff03c-08f6-4edc-af57-c0b8dbf55293@gmx.de>
Date: Fri, 14 Jun 2024 01:11:29 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 3/5] power: supply: core: implement extension API
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240608-power-supply-extensions-v2-0-2dcd35b012ad@weissschuh.net>
 <20240608-power-supply-extensions-v2-3-2dcd35b012ad@weissschuh.net>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240608-power-supply-extensions-v2-3-2dcd35b012ad@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3Lv72fYWQDF/nbYhUCEMNgXhkHdwt5fwyhWVfLLEZOFxHAy5Eri
 /sbJ3lhfD0Db3h4CtWd4zd2LqftjXUzOEQ/CT4X0SrPvCyT0Cz6oKBZj0/i62vPGs54al8z
 o6WshcmuY0Gk61IRsbZXdOP8Ifwv6xQ41Oh1fd3CsSNTB+wTNGJDWBfCswfv1YsToHSlEhV
 1/dmaBfninrKl1lIl1t/A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4rd53bpqqSQ=;gz/XHxMSvjjxi7crjacU5wMO9+L
 Z6iVlxXqnh2vHbreaQBSDyATUlNtG3TiVlPFx8X5dmEZYPrzxH6O4FYPTXLhygY3mmLZS/1QP
 CYhJvK1fanhVQH/TMeFrO7UmSbq36u+Wbs3qex8ay7aBzOLtgOINLcOYjrQTpTRdIpiVZsAH8
 lq36IoiBfZaeih0/lf+feiTym6osWQGghHp7MuHH74EpHGdeqgXD8FR9W7mdlrlWPJ/9QqLb8
 BCgkjizWBOehd13uDddccZmCXJqtJcoWGOJYnEQR6i/bHSMJewvA7Lf1zooTQ6CgI9/zhTexb
 jHRb+k8LTe9Q0syl0mdJFXcpL9cjKW22h2C2eocZ8Hg2ju3WDohdvtEZOyMMrxUmoUufoM1h1
 JZez7AzqszM1+Is0+W5oYpJ2kHuYQ7yuJeuQx04g/FyKOfzyHO6vaHOgJUX5E4DSy3Fb5GN66
 tT53ATsrNvxZdqCoBngZc5nnju80Tpd7oeqLbYLLbJpaWhFC17l41AvRETzv239dc+6I6YWCv
 idlChsADCVybQpq72j2VFcnT+BZV7PvD1f//bqgn980w9tz6iD0rN7aWny4EH/OWhXBY1Fj2k
 7GpOVghBNk8BEjnKCRAl7NecbYw6No8Sf8OZFcid1xFmfBuS9MvUfX+ms7KcnA+qFGamFqOIZ
 GXXGWcsjkDkuxxvRVDcVEs4bBwxOq7Y1IIZdqZ5fhQFwMUud7NpQOp5o3A/WpIajoB2/BuVfb
 Dm59uPZ5Od0uwLCbCxyPG6jhwzTBNqn4TKaLr+Hzy+PcTpqW1TF2LKBAH6cjpUvYDvtPZjxul
 C27yyfLwlpWaWDPHPensVCKuDqp/f3pJZLGw72/1toAPU=

Am 08.06.24 um 21:19 schrieb Thomas Wei=C3=9Fschuh:

> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
>   drivers/power/supply/power_supply.h       |  13 ++-
>   drivers/power/supply/power_supply_core.c  | 128 ++++++++++++++++++++++=
++++++--
>   drivers/power/supply/power_supply_hwmon.c |   2 +-
>   drivers/power/supply/power_supply_sysfs.c |  37 ++++++++-
>   include/linux/power_supply.h              |  26 ++++++
>   5 files changed, 192 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/=
power_supply.h
> index 622be1f0a180..686b66161900 100644
> --- a/drivers/power/supply/power_supply.h
> +++ b/drivers/power/supply/power_supply.h
> @@ -13,8 +13,17 @@ struct device;
>   struct device_type;
>   struct power_supply;
>
> -extern bool power_supply_has_property(const struct power_supply_desc *p=
sy_desc,
> -				      enum power_supply_property psp);
> +struct psy_ext_registration {
> +	struct list_head list_head;
> +	const struct power_supply_ext *ext;
> +};
> +
> +#define psy_for_each_extension(psy, pos) list_for_each_entry(pos, &(psy=
)->extensions, list_head)

Hi,

sorry for taking so long to respond, the patch looks good to me except one=
 single thing:

when removing a power supply extension, the driver has to be sure that no =
one is still using
the removed extension. So you might want to add some sort of locking when =
using a power supply
extension.

Thanks,
Armin Wolf

> +
> +bool power_supply_has_property(const struct power_supply *psy,
> +			       enum power_supply_property psp);
> +bool power_supply_ext_has_property(const struct power_supply_ext *psy_e=
xt,
> +				   enum power_supply_property psp);
>
>   #ifdef CONFIG_SYSFS
>
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/su=
pply/power_supply_core.c
> index d57ecdd966e0..fcdfedf3df7c 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -1183,8 +1183,8 @@ bool power_supply_battery_bti_in_range(struct powe=
r_supply_battery_info *info,
>   }
>   EXPORT_SYMBOL_GPL(power_supply_battery_bti_in_range);
>
> -bool power_supply_has_property(const struct power_supply_desc *psy_desc=
,
> -			       enum power_supply_property psp)
> +static bool psy_desc_has_property(const struct power_supply_desc *psy_d=
esc,
> +				  enum power_supply_property psp)
>   {
>   	bool found =3D false;
>   	int i;
> @@ -1199,17 +1199,55 @@ bool power_supply_has_property(const struct powe=
r_supply_desc *psy_desc,
>   	return found;
>   }
>
> +bool power_supply_ext_has_property(const struct power_supply_ext *psy_e=
xt,
> +				   enum power_supply_property psp)
> +{
> +	bool found =3D false;
> +	int i;
> +
> +	if (!psy_ext)
> +		return false;
> +
> +	for (i =3D 0; i < psy_ext->num_properties; i++) {
> +		if (psy_ext->properties[i] =3D=3D psp) {
> +			found =3D true;
> +			break;
> +		}
> +	}
> +
> +	return found;
> +}
> +
> +bool power_supply_has_property(const struct power_supply *psy,
> +			       enum power_supply_property psp)
> +{
> +	struct psy_ext_registration *reg;
> +
> +	psy_for_each_extension(psy, reg)
> +		if (power_supply_ext_has_property(reg->ext, psp))
> +			return true;
> +
> +	return psy_desc_has_property(psy->desc, psp);
> +}
> +
>   int power_supply_get_property(struct power_supply *psy,
>   			    enum power_supply_property psp,
>   			    union power_supply_propval *val)
>   {
> +	struct psy_ext_registration *reg;
> +
>   	if (atomic_read(&psy->use_cnt) <=3D 0) {
>   		if (!psy->initialized)
>   			return -EAGAIN;
>   		return -ENODEV;
>   	}
>
> -	if (power_supply_has_property(psy->desc, psp))
> +	psy_for_each_extension(psy, reg) {
> +		if (power_supply_ext_has_property(reg->ext, psp))
> +			return reg->ext->get_property(psy, reg->ext, psp, val);
> +	}
> +
> +	if (psy_desc_has_property(psy->desc, psp))
>   		return psy->desc->get_property(psy, psp, val);
>   	else if (power_supply_battery_info_has_prop(psy->battery_info, psp))
>   		return power_supply_battery_info_get_prop(psy->battery_info, psp, va=
l);
> @@ -1222,7 +1260,21 @@ int power_supply_set_property(struct power_supply=
 *psy,
>   			    enum power_supply_property psp,
>   			    const union power_supply_propval *val)
>   {
> -	if (atomic_read(&psy->use_cnt) <=3D 0 || !psy->desc->set_property)
> +	struct psy_ext_registration *reg;
> +
> +	if (atomic_read(&psy->use_cnt) <=3D 0)
> +		return -ENODEV;
> +
> +	psy_for_each_extension(psy, reg) {
> +		if (power_supply_ext_has_property(reg->ext, psp)) {
> +			if (reg->ext->set_property)
> +				return reg->ext->set_property(psy, reg->ext, psp, val);
> +			else
> +				return -ENODEV;
> +		}
> +	}
> +
> +	if (!psy->desc->set_property)
>   		return -ENODEV;
>
>   	return psy->desc->set_property(psy, psp, val);
> @@ -1232,8 +1284,21 @@ EXPORT_SYMBOL_GPL(power_supply_set_property);
>   int power_supply_property_is_writeable(struct power_supply *psy,
>   					enum power_supply_property psp)
>   {
> -	if (atomic_read(&psy->use_cnt) <=3D 0 ||
> -			!psy->desc->property_is_writeable)
> +	struct psy_ext_registration *reg;
> +
> +	if (atomic_read(&psy->use_cnt) <=3D 0)
> +		return -ENODEV;
> +
> +	psy_for_each_extension(psy, reg) {
> +		if (power_supply_ext_has_property(reg->ext, psp)) {
> +			if (reg->ext->property_is_writeable)
> +				return reg->ext->property_is_writeable(psy, reg->ext, psp);
> +			else
> +				return -ENODEV;
> +		}
> +	}
> +
> +	if (!psy->desc->property_is_writeable)
>   		return -ENODEV;
>
>   	return psy->desc->property_is_writeable(psy, psp);
> @@ -1256,6 +1321,52 @@ int power_supply_powers(struct power_supply *psy,=
 struct device *dev)
>   }
>   EXPORT_SYMBOL_GPL(power_supply_powers);
>
> +static int power_supply_update_groups(struct power_supply *psy)
> +{
> +	int ret;
> +
> +	ret =3D sysfs_update_groups(&psy->dev.kobj, power_supply_dev_type.grou=
ps);
> +	power_supply_changed(psy);
> +	return ret;
> +}
> +
> +int power_supply_register_extension(struct power_supply *psy, const str=
uct power_supply_ext *ext)
> +{
> +	struct psy_ext_registration *reg;
> +	size_t i;
> +
> +	for (i =3D 0; i < ext->num_properties; i++) {
> +		if (power_supply_has_property(psy, ext->properties[i]))
> +			return -EEXIST;
> +	}
> +
> +	reg =3D devm_kmalloc(&psy->dev, sizeof(*reg), GFP_KERNEL);
> +	if (!reg)
> +		return -ENOMEM;
> +
> +	reg->ext =3D ext;
> +	list_add(&reg->list_head, &psy->extensions);
> +
> +	return power_supply_update_groups(psy);
> +}
> +EXPORT_SYMBOL_GPL(power_supply_register_extension);
> +
> +void power_supply_unregister_extension(struct power_supply *psy, const =
struct power_supply_ext *ext)
> +{
> +	struct psy_ext_registration *reg;
> +
> +	psy_for_each_extension(psy, reg) {
> +		if (reg->ext =3D=3D ext) {
> +			list_del(&reg->list_head);
> +			power_supply_update_groups(psy);
> +			return;
> +		}
> +	}
> +
> +	dev_warn(&psy->dev, "Trying to unregister invalid extension");
> +}
> +EXPORT_SYMBOL_GPL(power_supply_unregister_extension);
> +
>   static void power_supply_dev_release(struct device *dev)
>   {
>   	struct power_supply *psy =3D to_power_supply(dev);
> @@ -1308,7 +1419,7 @@ static int psy_register_thermal(struct power_suppl=
y *psy)
>   		return 0;
>
>   	/* Register battery zone device psy reports temperature */
> -	if (power_supply_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
> +	if (power_supply_has_property(psy, POWER_SUPPLY_PROP_TEMP)) {
>   		/* Prefer our hwmon device and avoid duplicates */
>   		struct thermal_zone_params tzp =3D {
>   			.no_hwmon =3D IS_ENABLED(CONFIG_POWER_SUPPLY_HWMON)
> @@ -1361,7 +1472,7 @@ __power_supply_register(struct device *parent,
>   		pr_warn("%s: Expected proper parent device for '%s'\n",
>   			__func__, desc->name);
>
> -	if (power_supply_has_property(desc, POWER_SUPPLY_PROP_USB_TYPE) &&
> +	if (psy_desc_has_property(desc, POWER_SUPPLY_PROP_USB_TYPE) &&
>   	    (!desc->usb_types || !desc->num_usb_types))
>   		return ERR_PTR(-EINVAL);
>
> @@ -1415,6 +1526,7 @@ __power_supply_register(struct device *parent,
>   	}
>
>   	spin_lock_init(&psy->changed_lock);
> +	INIT_LIST_HEAD(&psy->extensions);
>   	rc =3D device_add(dev);
>   	if (rc)
>   		goto device_add_failed;
> diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/s=
upply/power_supply_hwmon.c
> index 2ecbe4a74c25..8cb852a734b1 100644
> --- a/drivers/power/supply/power_supply_hwmon.c
> +++ b/drivers/power/supply/power_supply_hwmon.c
> @@ -374,7 +374,7 @@ int power_supply_add_hwmon_sysfs(struct power_supply=
 *psy)
>   	for (i =3D 0; i < ARRAY_SIZE(power_supply_hwmon_props); i++) {
>   		const enum power_supply_property prop =3D power_supply_hwmon_props[i=
];
>
> -		if (power_supply_has_property(psy->desc, prop))
> +		if (power_supply_has_property(psy, prop))
>   			set_bit(prop, psyhw->props);
>   	}
>
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/s=
upply/power_supply_sysfs.c
> index abd44ebfe6fe..8f29ddea08d0 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -271,6 +271,23 @@ static ssize_t power_supply_show_usb_type(struct de=
vice *dev,
>   	return count;
>   }
>
> +static ssize_t power_supply_show_charge_behaviour(struct device *dev,
> +						  struct power_supply *psy,
> +						  union power_supply_propval *value,
> +						  char *buf)
> +{
> +	struct psy_ext_registration *reg;
> +
> +	psy_for_each_extension(psy, reg) {
> +		if (power_supply_ext_has_property(reg->ext, POWER_SUPPLY_PROP_CHARGE_=
BEHAVIOUR))
> +			return power_supply_charge_behaviour_show(dev, reg->ext->charge_beha=
viours,
> +								  value->intval, buf);
> +	}
> +
> +	return power_supply_charge_behaviour_show(dev, psy->desc->charge_behav=
iours,
> +						  value->intval, buf);
> +}
> +
>   static ssize_t power_supply_show_property(struct device *dev,
>   					  struct device_attribute *attr,
>   					  char *buf) {
> @@ -304,8 +321,7 @@ static ssize_t power_supply_show_property(struct dev=
ice *dev,
>   						&value, buf);
>   		break;
>   	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> -		ret =3D power_supply_charge_behaviour_show(dev, psy->desc->charge_beh=
aviours,
> -							 value.intval, buf);
> +		ret =3D power_supply_show_charge_behaviour(dev, psy, &value, buf);
>   		break;
>   	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_SERIAL_NUMBER=
:
>   		ret =3D sysfs_emit(buf, "%s\n", value.strval);
> @@ -374,7 +390,7 @@ static umode_t power_supply_attr_is_visible(struct k=
object *kobj,
>   	if (attrno =3D=3D POWER_SUPPLY_PROP_TYPE)
>   		return mode;
>
> -	if (power_supply_has_property(psy->desc, attrno)) {
> +	if (power_supply_has_property(psy, attrno)) {
>   		if (power_supply_property_is_writeable(psy, attrno) > 0)
>   			mode |=3D S_IWUSR;
>   		return mode;
> @@ -459,6 +475,7 @@ int power_supply_uevent(const struct device *dev, st=
ruct kobj_uevent_env *env)
>   		power_supply_battery_info_properties;
>   	unsigned long psy_drv_properties[POWER_SUPPLY_ATTR_CNT /
>   					 sizeof(unsigned long) + 1] =3D {0};
> +	struct psy_ext_registration *ext;
>   	int ret =3D 0, j;
>   	char *prop_buf;
>
> @@ -486,7 +503,21 @@ int power_supply_uevent(const struct device *dev, s=
truct kobj_uevent_env *env)
>   	if (ret)
>   		goto out;
>
> +	psy_for_each_extension(psy, ext) {
> +		for (j =3D 0; j < ext->ext->num_properties; j++) {
> +			if (test_bit(ext->ext->properties[j], psy_drv_properties))
> +				continue;
> +			set_bit(ext->ext->properties[j], psy_drv_properties);
> +			ret =3D add_prop_uevent(dev, env, ext->ext->properties[j],
> +					      prop_buf);
> +			if (ret)
> +				goto out;
> +		}
> +	}
> +
>   	for (j =3D 0; j < psy->desc->num_properties; j++) {
> +		if (test_bit(psy->desc->properties[j], psy_drv_properties))
> +			continue;
>   		set_bit(psy->desc->properties[j], psy_drv_properties);
>   		ret =3D add_prop_uevent(dev, env, psy->desc->properties[j],
>   				      prop_buf);
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 8e5705a56b85..128e7a67f268 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -15,6 +15,7 @@
>   #include <linux/device.h>
>   #include <linux/workqueue.h>
>   #include <linux/leds.h>
> +#include <linux/list.h>
>   #include <linux/spinlock.h>
>   #include <linux/notifier.h>
>
> @@ -280,6 +281,25 @@ struct power_supply_desc {
>   	int use_for_apm;
>   };
>
> +struct power_supply_ext {
> +	u8 charge_behaviours;
> +	const enum power_supply_property *properties;
> +	size_t num_properties;
> +
> +	int (*get_property)(struct power_supply *psy,
> +			    const struct power_supply_ext *ext,
> +			    enum power_supply_property psp,
> +			    union power_supply_propval *val);
> +	int (*set_property)(struct power_supply *psy,
> +			    const struct power_supply_ext *ext,
> +			    enum power_supply_property psp,
> +			    const union power_supply_propval *val);
> +
> +	int (*property_is_writeable)(struct power_supply *psy,
> +				     const struct power_supply_ext *ext,
> +				     enum power_supply_property psp);
> +};
> +
>   struct power_supply {
>   	const struct power_supply_desc *desc;
>
> @@ -303,6 +323,7 @@ struct power_supply {
>   	bool removing;
>   	atomic_t use_cnt;
>   	struct power_supply_battery_info *battery_info;
> +	struct list_head extensions;
>   #ifdef CONFIG_THERMAL
>   	struct thermal_zone_device *tzd;
>   	struct thermal_cooling_device *tcd;
> @@ -892,6 +913,11 @@ devm_power_supply_register_no_ws(struct device *par=
ent,
>   extern void power_supply_unregister(struct power_supply *psy);
>   extern int power_supply_powers(struct power_supply *psy, struct device=
 *dev);
>
> +extern int power_supply_register_extension(struct power_supply *psy,
> +					   const struct power_supply_ext *ext);
> +extern void power_supply_unregister_extension(struct power_supply *psy,
> +					      const struct power_supply_ext *ext);
> +
>   #define to_power_supply(device) container_of(device, struct power_supp=
ly, dev)
>
>   extern void *power_supply_get_drvdata(struct power_supply *psy);
>

