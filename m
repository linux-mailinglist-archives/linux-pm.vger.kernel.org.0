Return-Path: <linux-pm+bounces-14263-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67116979019
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 12:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B742857CF
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 10:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7301CEACC;
	Sat, 14 Sep 2024 10:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="gGxKyJHx"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7CE1CE715;
	Sat, 14 Sep 2024 10:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726311077; cv=pass; b=JgqmERnxCC4kthY0OBUbSEaPH1V41QpAFyk5cwKSXHiULGdJ5l5j9bAihZatQQoaGeGRAHpm9S4cwB43z251ZaD5YLIj4LdBpWCMdUBCSJhC3CIOINB1he+Q/wPn3HV9WVWAGc2hRslKnwjKx6IJ87kifWYuBGNVtkWorFydRHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726311077; c=relaxed/simple;
	bh=0OjDdq+WcAdfg45ocFrYaJfaQpdgWDX2VsMfoC+frnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwCls+CGhrjpbnyNhA6za5QnmR/nJw6FCj1KxLbkQgUm8/GzjJrgjMkBI9kyeYWevZMk/fGZbSTV1J5tcGi8YCudgj0Mr0LM880VNfEjl6hI5LNlV7ZLy+oGO0Yt7dsxM/9GfBCWypDTDURnMlQj3ON9jZkOxezjgyljfzZKky8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=gGxKyJHx; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726311066; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NEzTBtDkAUkrzbXtZAqhYHvfvCL+yQ5yFWbQ50P6/cltLUmpOb+p2yPJMRA927RKFWQHl5EF5JYN3W8KYl76TQKeY1es2dBlf5z8jNM1/B8oxWi2xsLq/0OaB+SpHYvjL17uEAep0kOILZS5MM1hIxolwbm2eHBydIlY4R4U/Qg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726311066; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=APwco8G85DMdcz5gtQilcKK5zlyPGfrYCAw2YmHnerE=; 
	b=AbXqIS2CiKiD0entZNWIabt2Q9L/lTasLwYWGmcleqRh47k6U1jfZkGpxEhXe4eunmw0RmlgGu1DlbC83nF/MJ9EZpJtJVBlbtm2+ZoEWvx46xDxU4AWwXvWaqupxTiLieH11Z7Xniki0jenHboILfzz+FaN5cxyRYhOff+MwUA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726311066;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=APwco8G85DMdcz5gtQilcKK5zlyPGfrYCAw2YmHnerE=;
	b=gGxKyJHxym7+2LMMQN1C9p7AqV525iAoMZJQR2gTUPcZ5VjxTPl/8Fkl7oFI7KHj
	IlflYylork0ETREyX1Gr475j5rQFLiP+1v9mKZRg5UGTKdUr6xtoQUtWJEaFKf0yWIT
	ZgtkWypwXLX/Bk6WdhHzo99KZqBvdlgUEuy/3vk8=
Received: by mx.zohomail.com with SMTPS id 1726311063840168.2829224585505;
	Sat, 14 Sep 2024 03:51:03 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
	id 1A6761060578; Sat, 14 Sep 2024 12:50:57 +0200 (CEST)
Date: Sat, 14 Sep 2024 12:50:57 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 6/9] power: supply: core: implement extension API
Message-ID: <vq7r2udbmqfp5v7o2occtnoziwrnpidht2wgkofvfyfic2o67m@3wtnxxvtdgye>
References: <20240904-power-supply-extensions-v3-0-62efeb93f8ec@weissschuh.net>
 <20240904-power-supply-extensions-v3-6-62efeb93f8ec@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sdyzsh5tovt4mp23"
Content-Disposition: inline
In-Reply-To: <20240904-power-supply-extensions-v3-6-62efeb93f8ec@weissschuh.net>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/223.982.64
X-ZohoMailClient: External


--sdyzsh5tovt4mp23
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 04, 2024 at 09:25:39PM GMT, Thomas Wei=DFschuh wrote:
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---

missing long description :)

In general I like the concept. It looks like a good candidate to
clean up the mess with the custom registration of properties done
by the x86 platform code.

Apart from ACPI with custom battery extensions mess, there is
something similar in the embedded world: Many charger chips have
rudimentary fuel-gauge support. Some drivers register a charger/usb
and a battery device. That results in two battery devices when the
machine also has a proper fuel gauge. Having two battery devices
exposed is bad, since that means the machine has two batteries
(like some Thinkpads). Not exposing the battery from the charger
device is possibly loosing information (depending on fuel gauge
features).

I think it should be possible to register the charger's rudimentary
battery device as a power_supply_ext, if it detects a proper fuel
gauge being available (e.g. via the DT "power-supplies" property).
But then the charger's properties are the preferred ones. I think
they should be fallback properties instead. A machine only gets its
own fuel-gauge, when that provides better values than the data
available from the charger :)

So the question is which property getter/setter should be used
when the same property is exposed multiple times. Your examples
only add new properties and does not run into this. The intuitive
thing would be for properties from extensions to be preferred,
but do we actually have a use case for that?

Greetings,

-- Sebastian

>  drivers/power/supply/power_supply.h       |  12 ++++
>  drivers/power/supply/power_supply_core.c  | 114 ++++++++++++++++++++++++=
+++++-
>  drivers/power/supply/power_supply_sysfs.c |  20 +++++-
>  include/linux/power_supply.h              |  30 ++++++++
>  4 files changed, 171 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/p=
ower_supply.h
> index b01faeaf7827..fb45f0717bd1 100644
> --- a/drivers/power/supply/power_supply.h
> +++ b/drivers/power/supply/power_supply.h
> @@ -15,6 +15,18 @@ struct power_supply;
> =20
>  extern bool power_supply_has_property(struct power_supply *psy,
>  				      enum power_supply_property psp);
> +extern bool power_supply_ext_has_property(const struct power_supply_ext =
*ext,
> +				          enum power_supply_property psp);
> +
> +struct power_supply_ext_registration {
> +	struct list_head list_head;
> +	const struct power_supply_ext *ext;
> +	void *data;
> +};
> +
> +#define power_supply_for_each_extension(pos, psy) \
> +	list_for_each_entry(pos, &(psy)->extensions, list_head)
> +
> =20
>  #ifdef CONFIG_SYSFS
> =20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index dcb7e4853030..db5e7af57e67 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -1199,15 +1199,40 @@ static bool psy_desc_has_property(const struct po=
wer_supply_desc *psy_desc,
>  	return found;
>  }
> =20
> +bool power_supply_ext_has_property(const struct power_supply_ext *psy_ex=
t,
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
>  bool power_supply_has_property(struct power_supply *psy,
>  			       enum power_supply_property psp)
>  {
> +	struct power_supply_ext_registration *reg;
> +
>  	if (psy_desc_has_property(psy->desc, psp))
>  		return true;
> =20
>  	if (power_supply_battery_info_has_prop(psy->battery_info, psp))
>  		return true;
> =20
> +	power_supply_for_each_extension(reg, psy)
> +		if (power_supply_ext_has_property(reg->ext, psp))
> +			return true;
> +
>  	return false;
>  }
> =20
> @@ -1215,12 +1240,19 @@ int power_supply_get_property(struct power_supply=
 *psy,
>  			    enum power_supply_property psp,
>  			    union power_supply_propval *val)
>  {
> +	struct power_supply_ext_registration *reg;
> +
>  	if (atomic_read(&psy->use_cnt) <=3D 0) {
>  		if (!psy->initialized)
>  			return -EAGAIN;
>  		return -ENODEV;
>  	}
> =20
> +	power_supply_for_each_extension(reg, psy) {
> +		if (power_supply_ext_has_property(reg->ext, psp))
> +			return reg->ext->get_property(psy, reg->ext, reg->data, psp, val);
> +	}
> +
>  	if (psy_desc_has_property(psy->desc, psp))
>  		return psy->desc->get_property(psy, psp, val);
>  	else if (power_supply_battery_info_has_prop(psy->battery_info, psp))
> @@ -1234,7 +1266,21 @@ int power_supply_set_property(struct power_supply =
*psy,
>  			    enum power_supply_property psp,
>  			    const union power_supply_propval *val)
>  {
> -	if (atomic_read(&psy->use_cnt) <=3D 0 || !psy->desc->set_property)
> +	struct power_supply_ext_registration *reg;
> +
> +	if (atomic_read(&psy->use_cnt) <=3D 0)
> +		return -ENODEV;
> +
> +	power_supply_for_each_extension(reg, psy) {
> +		if (power_supply_ext_has_property(reg->ext, psp)) {
> +			if (reg->ext->set_property)
> +				return reg->ext->set_property(psy, reg->ext, reg->data, psp, val);
> +			else
> +				return -ENODEV;
> +		}
> +	}
> +
> +	if (!psy->desc->set_property)
>  		return -ENODEV;
> =20
>  	return psy->desc->set_property(psy, psp, val);
> @@ -1244,8 +1290,21 @@ EXPORT_SYMBOL_GPL(power_supply_set_property);
>  int power_supply_property_is_writeable(struct power_supply *psy,
>  					enum power_supply_property psp)
>  {
> -	if (atomic_read(&psy->use_cnt) <=3D 0 ||
> -			!psy->desc->property_is_writeable)
> +	struct power_supply_ext_registration *reg;
> +
> +	if (atomic_read(&psy->use_cnt) <=3D 0)
> +		return -ENODEV;
> +
> +	power_supply_for_each_extension(reg, psy) {
> +		if (power_supply_ext_has_property(reg->ext, psp)) {
> +			if (reg->ext->property_is_writeable)
> +				return reg->ext->property_is_writeable(psy, reg->ext, reg->data, psp=
);
> +			else
> +				return -ENODEV;
> +		}
> +	}
> +
> +	if (!psy->desc->property_is_writeable)
>  		return -ENODEV;
> =20
>  	return psy->desc->property_is_writeable(psy, psp);
> @@ -1268,6 +1327,54 @@ int power_supply_powers(struct power_supply *psy, =
struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(power_supply_powers);
> =20
> +static int power_supply_update_groups(struct power_supply *psy)
> +{
> +	int ret;
> +
> +	ret =3D sysfs_update_groups(&psy->dev.kobj, power_supply_dev_type.group=
s);
> +	power_supply_changed(psy);
> +	return ret;
> +}
> +
> +int power_supply_register_extension(struct power_supply *psy, const stru=
ct power_supply_ext *ext,
> +				    void *ext_data)
> +{
> +	struct power_supply_ext_registration *reg;
> +	size_t i;
> +
> +	for (i =3D 0; i < ext->num_properties; i++) {
> +		if (power_supply_has_property(psy, ext->properties[i]))
> +			return -EEXIST;
> +	}
> +
> +	reg =3D kmalloc(sizeof(*reg), GFP_KERNEL);
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
> +void power_supply_unregister_extension(struct power_supply *psy, const s=
truct power_supply_ext *ext)
> +{
> +	struct power_supply_ext_registration *reg;
> +
> +	power_supply_for_each_extension(reg, psy) {
> +		if (reg->ext =3D=3D ext) {
> +			list_del(&reg->list_head);
> +			kfree(reg);
> +			power_supply_update_groups(psy);
> +			return;
> +		}
> +	}
> +
> +	dev_warn(&psy->dev, "Trying to unregister invalid extension");
> +}
> +EXPORT_SYMBOL_GPL(power_supply_unregister_extension);
> +
>  static void power_supply_dev_release(struct device *dev)
>  {
>  	struct power_supply *psy =3D to_power_supply(dev);
> @@ -1427,6 +1534,7 @@ __power_supply_register(struct device *parent,
>  	}
> =20
>  	spin_lock_init(&psy->changed_lock);
> +	INIT_LIST_HEAD(&psy->extensions);
>  	rc =3D device_add(dev);
>  	if (rc)
>  		goto device_add_failed;
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index 915a4ba62258..e7c306afd846 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -271,6 +271,23 @@ static ssize_t power_supply_show_usb_type(struct dev=
ice *dev,
>  	return count;
>  }
> =20
> +static ssize_t power_supply_show_charge_behaviour(struct device *dev,
> +						  struct power_supply *psy,
> +						  union power_supply_propval *value,
> +						  char *buf)
> +{
> +	struct power_supply_ext_registration *reg;
> +
> +	power_supply_for_each_extension(reg, psy) {
> +		if (power_supply_ext_has_property(reg->ext, POWER_SUPPLY_PROP_CHARGE_B=
EHAVIOUR))
> +			return power_supply_charge_behaviour_show(dev, reg->ext->charge_behav=
iours,
> +								  value->intval, buf);
> +	}
> +
> +	return power_supply_charge_behaviour_show(dev, psy->desc->charge_behavi=
ours,
> +						  value->intval, buf);
> +}
> +
>  static ssize_t power_supply_show_property(struct device *dev,
>  					  struct device_attribute *attr,
>  					  char *buf) {
> @@ -306,8 +323,7 @@ static ssize_t power_supply_show_property(struct devi=
ce *dev,
>  						&value, buf);
>  		break;
>  	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> -		ret =3D power_supply_charge_behaviour_show(dev, psy->desc->charge_beha=
viours,
> -							 value.intval, buf);
> +		ret =3D power_supply_show_charge_behaviour(dev, psy, &value, buf);
>  		break;
>  	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_SERIAL_NUMBER:
>  		ret =3D sysfs_emit(buf, "%s\n", value.strval);
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 72dc7e45c90c..51788faf1d66 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -15,6 +15,7 @@
>  #include <linux/device.h>
>  #include <linux/workqueue.h>
>  #include <linux/leds.h>
> +#include <linux/list.h>
>  #include <linux/spinlock.h>
>  #include <linux/notifier.h>
> =20
> @@ -280,6 +281,28 @@ struct power_supply_desc {
>  	int use_for_apm;
>  };
> =20
> +struct power_supply_ext {
> +	u8 charge_behaviours;
> +	const enum power_supply_property *properties;
> +	size_t num_properties;
> +
> +	int (*get_property)(struct power_supply *psy,
> +			    const struct power_supply_ext *ext,
> +			    void *ext_data,
> +			    enum power_supply_property psp,
> +			    union power_supply_propval *val);
> +	int (*set_property)(struct power_supply *psy,
> +			    const struct power_supply_ext *ext,
> +			    void *ext_data,
> +			    enum power_supply_property psp,
> +			    const union power_supply_propval *val);
> +
> +	int (*property_is_writeable)(struct power_supply *psy,
> +				     const struct power_supply_ext *ext,
> +				     void *ext_data,
> +				     enum power_supply_property psp);
> +};
> +
>  struct power_supply {
>  	const struct power_supply_desc *desc;
> =20
> @@ -303,6 +326,7 @@ struct power_supply {
>  	bool removing;
>  	atomic_t use_cnt;
>  	struct power_supply_battery_info *battery_info;
> +	struct list_head extensions;
>  #ifdef CONFIG_THERMAL
>  	struct thermal_zone_device *tzd;
>  	struct thermal_cooling_device *tcd;
> @@ -887,6 +911,12 @@ devm_power_supply_register_no_ws(struct device *pare=
nt,
>  extern void power_supply_unregister(struct power_supply *psy);
>  extern int power_supply_powers(struct power_supply *psy, struct device *=
dev);
> =20
> +extern int power_supply_register_extension(struct power_supply *psy,
> +					   const struct power_supply_ext *ext,
> +					   void *ext_data);
> +extern void power_supply_unregister_extension(struct power_supply *psy,
> +					      const struct power_supply_ext *ext);
> +
>  #define to_power_supply(device) container_of(device, struct power_supply=
, dev)
> =20
>  extern void *power_supply_get_drvdata(struct power_supply *psy);
>=20
> --=20
> 2.46.0
>=20
>=20

--sdyzsh5tovt4mp23
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmblao0ACgkQ2O7X88g7
+prCRw//dQN849Adlrl28bqo0VCl68vDC5ILDzPtq3EfcmFEquTpEo5nR7IQWUbu
Yp9uFQcTHIQlapEIWAB2KVAmyECFpsw4vtjDt2eyosIfM8IdpL/OpGidvkhSIASy
lwbWYXlZ/C001lMO/8iFxKRzILd1Me3ZSgfniSFVKYLGCb8uiftQYK47PhVmcLkI
c4hCtYnqNPXskpokjpPxLDyqksxewlI42dIcSlvlZNy0P2ys6q6V5VVL6Jj9f0D2
4Q2JA2bfcTvqZJpyS89LTK6+Fa2n833WK179h6Ch2wqEiW1yiacFxqTRtZaSPDaK
+QnOk2p1v7MAudAyQhCwoXrLRmLdSJsL6qtbaITqrUoTr0z0vrfGi9zMmmff5mkT
Lq82Q3dobYuD7whF9rhgpmupg3rz/ZtMogeaZfCwPw55jzCSSh42FumL+hIFMOQ6
hMUYFsCWC6BHcjLdcvTwB3FDmopemG5QDO9/+XS0WUIU+3JroXTOr14NlAzOjb/m
yucRyiqzQZGTwQuX/YSaareb6C0jlzreYXtNQx8qFCviKba9Pi8mW8ZbvLBEANaX
aumSegNI/QmPn0EtUzD3g4j2Zd2nEZDQ+sCQeFkijcwW+Bzb0j5pkG1Rhkbl9CeA
0jJMIeACvhxOi1mEPpMiTGrted2qdZrcaxWlOqqkLjMIYRxDBdE=
=GvXd
-----END PGP SIGNATURE-----

--sdyzsh5tovt4mp23--

