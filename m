Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661971C21F9
	for <lists+linux-pm@lfdr.de>; Sat,  2 May 2020 02:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgEBAcT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 20:32:19 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38812 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgEBAcS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2020 20:32:18 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 18D332A1FD0
Received: by earth.universe (Postfix, from userid 1000)
        id A3AE43C08C7; Sat,  2 May 2020 02:32:12 +0200 (CEST)
Date:   Sat, 2 May 2020 02:32:12 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Mathew King <mathewk@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/4] power_supply: Cleanup power supply sysfs attribute
 list
Message-ID: <20200502003212.qnv6xnprk6ehkg4i@earth.universe>
References: <20200424173533.48572-1-mathewk@chromium.org>
 <20200424173533.48572-2-mathewk@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bhd6lwvrokpe4kol"
Content-Disposition: inline
In-Reply-To: <20200424173533.48572-2-mathewk@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--bhd6lwvrokpe4kol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 24, 2020 at 11:35:30AM -0600, Mathew King wrote:
> Make the device attribute list used to create sysfs attributes more
> robust by decoupling the list order from order of the enum defined in
> power_supply.h. This is done by using a designated initializer in the
> POWER_SUPPLY_ATTR macro.

Thanks for doing this :)

> Also properties not added to the list will still be created with
> name in the format "prop_*".

This is bad. We don't want to expose PROP_%d to userspace and risk
this becoming ABI. Instead it should not be registered and a warning
should be printed. This means we can drop the prop_name field and directly
use upper, which will always be in TEXT segment then.

For the lower case name, I think it's better to provide it as second
argument to POWER_SUPPLY_ATTR. Not very elegant solution, but it
means, that the string is in the TEXT segment and that we can
have the complete dev_attr initialized from the macro.

-- Sebastian

> Signed-off-by: Mathew King <mathewk@chromium.org>
> ---
>  drivers/power/supply/power_supply.h       |   7 +-
>  drivers/power/supply/power_supply_core.c  |   9 +-
>  drivers/power/supply/power_supply_sysfs.c | 290 +++++++++++++---------
>  3 files changed, 179 insertions(+), 127 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/p=
ower_supply.h
> index c310d4f36c10..e3475d35ec2a 100644
> --- a/drivers/power/supply/power_supply.h
> +++ b/drivers/power/supply/power_supply.h
> @@ -15,12 +15,15 @@ struct power_supply;
> =20
>  #ifdef CONFIG_SYSFS
> =20
> -extern void power_supply_init_attrs(struct device_type *dev_type);
> +extern int power_supply_init_attrs(struct device_type *dev_type);
> +extern void power_supply_destroy_attrs(void);
>  extern int power_supply_uevent(struct device *dev, struct kobj_uevent_en=
v *env);
> =20
>  #else
> =20
> -static inline void power_supply_init_attrs(struct device_type *dev_type)=
 {}
> +static inline int power_supply_init_attrs(struct device_type *dev_type)
> +{ return 0; }
> +static void power_supply_destroy_attrs(void) {}
>  #define power_supply_uevent NULL
> =20
>  #endif /* CONFIG_SYSFS */
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index 1a9a9fae73d3..7fb99302b532 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -1329,19 +1329,26 @@ EXPORT_SYMBOL_GPL(power_supply_get_drvdata);
> =20
>  static int __init power_supply_class_init(void)
>  {
> +	int ret;
>  	power_supply_class =3D class_create(THIS_MODULE, "power_supply");
> =20
>  	if (IS_ERR(power_supply_class))
>  		return PTR_ERR(power_supply_class);
> =20
>  	power_supply_class->dev_uevent =3D power_supply_uevent;
> -	power_supply_init_attrs(&power_supply_dev_type);
> +
> +	ret =3D power_supply_init_attrs(&power_supply_dev_type);
> +	if (ret) {
> +		class_destroy(power_supply_class);
> +		return ret;
> +	}
> =20
>  	return 0;
>  }
> =20
>  static void __exit power_supply_class_exit(void)
>  {
> +	power_supply_destroy_attrs();
>  	class_destroy(power_supply_class);
>  }
> =20
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index f37ad4eae60b..b579081599d7 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -18,27 +18,22 @@
> =20
>  #include "power_supply.h"
> =20
> -/*
> - * This is because the name "current" breaks the device attr macro.
> - * The "current" word resolves to "(get_current())" so instead of
> - * "current" "(get_current())" appears in the sysfs.
> - *
> - * The source of this definition is the device.h which calls __ATTR
> - * macro in sysfs.h which calls the __stringify macro.
> - *
> - * Only modification that the name is not tried to be resolved
> - * (as a macro let's say).
> - */
> +#define UNDEF_PROP_NAME_FMT "PROP_%d"
> +#define UNDEF_PROP_NAME_LEN (strlen(UNDEF_PROP_NAME_FMT) + 2)
> +
> +struct power_supply_attr {
> +	const char *prop_name;
> +	const char *upper_name;
> +	const char *lower_name;
> +	struct device_attribute dev_attr;
> +};
> =20
> -#define POWER_SUPPLY_ATTR(_name)					\
> -{									\
> -	.attr =3D { .name =3D #_name },					\
> -	.show =3D power_supply_show_property,				\
> -	.store =3D power_supply_store_property,				\
> +#define POWER_SUPPLY_ATTR(_name)	\
> +[POWER_SUPPLY_PROP_ ## _name] =3D		\
> +{					\
> +	.prop_name =3D #_name		\
>  }
> =20
> -static struct device_attribute power_supply_attrs[];
> -
>  static const char * const power_supply_type_text[] =3D {
>  	"Unknown", "Battery", "UPS", "Mains", "USB",
>  	"USB_DCP", "USB_CDP", "USB_ACA", "USB_C",
> @@ -77,6 +72,91 @@ static const char * const power_supply_scope_text[] =
=3D {
>  	"Unknown", "System", "Device"
>  };
> =20
> +static struct power_supply_attr power_supply_attrs[] =3D {
> +	/* Properties of type `int' */
> +	POWER_SUPPLY_ATTR(STATUS),
> +	POWER_SUPPLY_ATTR(CHARGE_TYPE),
> +	POWER_SUPPLY_ATTR(HEALTH),
> +	POWER_SUPPLY_ATTR(PRESENT),
> +	POWER_SUPPLY_ATTR(ONLINE),
> +	POWER_SUPPLY_ATTR(AUTHENTIC),
> +	POWER_SUPPLY_ATTR(TECHNOLOGY),
> +	POWER_SUPPLY_ATTR(CYCLE_COUNT),
> +	POWER_SUPPLY_ATTR(VOLTAGE_MAX),
> +	POWER_SUPPLY_ATTR(VOLTAGE_MIN),
> +	POWER_SUPPLY_ATTR(VOLTAGE_MAX_DESIGN),
> +	POWER_SUPPLY_ATTR(VOLTAGE_MIN_DESIGN),
> +	POWER_SUPPLY_ATTR(VOLTAGE_NOW),
> +	POWER_SUPPLY_ATTR(VOLTAGE_AVG),
> +	POWER_SUPPLY_ATTR(VOLTAGE_OCV),
> +	POWER_SUPPLY_ATTR(VOLTAGE_BOOT),
> +	POWER_SUPPLY_ATTR(CURRENT_MAX),
> +	POWER_SUPPLY_ATTR(CURRENT_NOW),
> +	POWER_SUPPLY_ATTR(CURRENT_AVG),
> +	POWER_SUPPLY_ATTR(CURRENT_BOOT),
> +	POWER_SUPPLY_ATTR(POWER_NOW),
> +	POWER_SUPPLY_ATTR(POWER_AVG),
> +	POWER_SUPPLY_ATTR(CHARGE_FULL_DESIGN),
> +	POWER_SUPPLY_ATTR(CHARGE_EMPTY_DESIGN),
> +	POWER_SUPPLY_ATTR(CHARGE_FULL),
> +	POWER_SUPPLY_ATTR(CHARGE_EMPTY),
> +	POWER_SUPPLY_ATTR(CHARGE_NOW),
> +	POWER_SUPPLY_ATTR(CHARGE_AVG),
> +	POWER_SUPPLY_ATTR(CHARGE_COUNTER),
> +	POWER_SUPPLY_ATTR(CONSTANT_CHARGE_CURRENT),
> +	POWER_SUPPLY_ATTR(CONSTANT_CHARGE_CURRENT_MAX),
> +	POWER_SUPPLY_ATTR(CONSTANT_CHARGE_VOLTAGE),
> +	POWER_SUPPLY_ATTR(CONSTANT_CHARGE_VOLTAGE_MAX),
> +	POWER_SUPPLY_ATTR(CHARGE_CONTROL_LIMIT),
> +	POWER_SUPPLY_ATTR(CHARGE_CONTROL_LIMIT_MAX),
> +	POWER_SUPPLY_ATTR(CHARGE_CONTROL_START_THRESHOLD),
> +	POWER_SUPPLY_ATTR(CHARGE_CONTROL_END_THRESHOLD),
> +	POWER_SUPPLY_ATTR(INPUT_CURRENT_LIMIT),
> +	POWER_SUPPLY_ATTR(INPUT_VOLTAGE_LIMIT),
> +	POWER_SUPPLY_ATTR(INPUT_POWER_LIMIT),
> +	POWER_SUPPLY_ATTR(ENERGY_FULL_DESIGN),
> +	POWER_SUPPLY_ATTR(ENERGY_EMPTY_DESIGN),
> +	POWER_SUPPLY_ATTR(ENERGY_FULL),
> +	POWER_SUPPLY_ATTR(ENERGY_EMPTY),
> +	POWER_SUPPLY_ATTR(ENERGY_NOW),
> +	POWER_SUPPLY_ATTR(ENERGY_AVG),
> +	POWER_SUPPLY_ATTR(CAPACITY),
> +	POWER_SUPPLY_ATTR(CAPACITY_ALERT_MIN),
> +	POWER_SUPPLY_ATTR(CAPACITY_ALERT_MAX),
> +	POWER_SUPPLY_ATTR(CAPACITY_LEVEL),
> +	POWER_SUPPLY_ATTR(TEMP),
> +	POWER_SUPPLY_ATTR(TEMP_MAX),
> +	POWER_SUPPLY_ATTR(TEMP_MIN),
> +	POWER_SUPPLY_ATTR(TEMP_ALERT_MIN),
> +	POWER_SUPPLY_ATTR(TEMP_ALERT_MAX),
> +	POWER_SUPPLY_ATTR(TEMP_AMBIENT),
> +	POWER_SUPPLY_ATTR(TEMP_AMBIENT_ALERT_MIN),
> +	POWER_SUPPLY_ATTR(TEMP_AMBIENT_ALERT_MAX),
> +	POWER_SUPPLY_ATTR(TIME_TO_EMPTY_NOW),
> +	POWER_SUPPLY_ATTR(TIME_TO_EMPTY_AVG),
> +	POWER_SUPPLY_ATTR(TIME_TO_FULL_NOW),
> +	POWER_SUPPLY_ATTR(TIME_TO_FULL_AVG),
> +	POWER_SUPPLY_ATTR(TYPE),
> +	POWER_SUPPLY_ATTR(USB_TYPE),
> +	POWER_SUPPLY_ATTR(SCOPE),
> +	POWER_SUPPLY_ATTR(PRECHARGE_CURRENT),
> +	POWER_SUPPLY_ATTR(CHARGE_TERM_CURRENT),
> +	POWER_SUPPLY_ATTR(CALIBRATE),
> +	/* Properties of type `const char *' */
> +	POWER_SUPPLY_ATTR(MODEL_NAME),
> +	POWER_SUPPLY_ATTR(MANUFACTURER),
> +	POWER_SUPPLY_ATTR(SERIAL_NUMBER),
> +};
> +
> +static struct attribute *
> +__power_supply_attrs[ARRAY_SIZE(power_supply_attrs) + 1];
> +
> +static enum power_supply_property dev_attr_psp(struct device_attribute *=
attr)
> +{
> +	return container_of(attr, struct power_supply_attr, dev_attr) -
> +		power_supply_attrs;
> +}
> +
>  static ssize_t power_supply_show_usb_type(struct device *dev,
>  					  enum power_supply_usb_type *usb_types,
>  					  ssize_t num_usb_types,
> @@ -117,7 +197,7 @@ static ssize_t power_supply_show_property(struct devi=
ce *dev,
>  					  char *buf) {
>  	ssize_t ret;
>  	struct power_supply *psy =3D dev_get_drvdata(dev);
> -	enum power_supply_property psp =3D attr - power_supply_attrs;
> +	enum power_supply_property psp =3D dev_attr_psp(attr);
>  	union power_supply_propval value;
> =20
>  	if (psp =3D=3D POWER_SUPPLY_PROP_TYPE) {
> @@ -186,7 +266,7 @@ static ssize_t power_supply_store_property(struct dev=
ice *dev,
>  					   const char *buf, size_t count) {
>  	ssize_t ret;
>  	struct power_supply *psy =3D dev_get_drvdata(dev);
> -	enum power_supply_property psp =3D attr - power_supply_attrs;
> +	enum power_supply_property psp =3D dev_attr_psp(attr);
>  	union power_supply_propval value;
> =20
>  	switch (psp) {
> @@ -235,86 +315,6 @@ static ssize_t power_supply_store_property(struct de=
vice *dev,
>  	return count;
>  }
> =20
> -/* Must be in the same order as POWER_SUPPLY_PROP_* */
> -static struct device_attribute power_supply_attrs[] =3D {
> -	/* Properties of type `int' */
> -	POWER_SUPPLY_ATTR(status),
> -	POWER_SUPPLY_ATTR(charge_type),
> -	POWER_SUPPLY_ATTR(health),
> -	POWER_SUPPLY_ATTR(present),
> -	POWER_SUPPLY_ATTR(online),
> -	POWER_SUPPLY_ATTR(authentic),
> -	POWER_SUPPLY_ATTR(technology),
> -	POWER_SUPPLY_ATTR(cycle_count),
> -	POWER_SUPPLY_ATTR(voltage_max),
> -	POWER_SUPPLY_ATTR(voltage_min),
> -	POWER_SUPPLY_ATTR(voltage_max_design),
> -	POWER_SUPPLY_ATTR(voltage_min_design),
> -	POWER_SUPPLY_ATTR(voltage_now),
> -	POWER_SUPPLY_ATTR(voltage_avg),
> -	POWER_SUPPLY_ATTR(voltage_ocv),
> -	POWER_SUPPLY_ATTR(voltage_boot),
> -	POWER_SUPPLY_ATTR(current_max),
> -	POWER_SUPPLY_ATTR(current_now),
> -	POWER_SUPPLY_ATTR(current_avg),
> -	POWER_SUPPLY_ATTR(current_boot),
> -	POWER_SUPPLY_ATTR(power_now),
> -	POWER_SUPPLY_ATTR(power_avg),
> -	POWER_SUPPLY_ATTR(charge_full_design),
> -	POWER_SUPPLY_ATTR(charge_empty_design),
> -	POWER_SUPPLY_ATTR(charge_full),
> -	POWER_SUPPLY_ATTR(charge_empty),
> -	POWER_SUPPLY_ATTR(charge_now),
> -	POWER_SUPPLY_ATTR(charge_avg),
> -	POWER_SUPPLY_ATTR(charge_counter),
> -	POWER_SUPPLY_ATTR(constant_charge_current),
> -	POWER_SUPPLY_ATTR(constant_charge_current_max),
> -	POWER_SUPPLY_ATTR(constant_charge_voltage),
> -	POWER_SUPPLY_ATTR(constant_charge_voltage_max),
> -	POWER_SUPPLY_ATTR(charge_control_limit),
> -	POWER_SUPPLY_ATTR(charge_control_limit_max),
> -	POWER_SUPPLY_ATTR(charge_control_start_threshold),
> -	POWER_SUPPLY_ATTR(charge_control_end_threshold),
> -	POWER_SUPPLY_ATTR(input_current_limit),
> -	POWER_SUPPLY_ATTR(input_voltage_limit),
> -	POWER_SUPPLY_ATTR(input_power_limit),
> -	POWER_SUPPLY_ATTR(energy_full_design),
> -	POWER_SUPPLY_ATTR(energy_empty_design),
> -	POWER_SUPPLY_ATTR(energy_full),
> -	POWER_SUPPLY_ATTR(energy_empty),
> -	POWER_SUPPLY_ATTR(energy_now),
> -	POWER_SUPPLY_ATTR(energy_avg),
> -	POWER_SUPPLY_ATTR(capacity),
> -	POWER_SUPPLY_ATTR(capacity_alert_min),
> -	POWER_SUPPLY_ATTR(capacity_alert_max),
> -	POWER_SUPPLY_ATTR(capacity_level),
> -	POWER_SUPPLY_ATTR(temp),
> -	POWER_SUPPLY_ATTR(temp_max),
> -	POWER_SUPPLY_ATTR(temp_min),
> -	POWER_SUPPLY_ATTR(temp_alert_min),
> -	POWER_SUPPLY_ATTR(temp_alert_max),
> -	POWER_SUPPLY_ATTR(temp_ambient),
> -	POWER_SUPPLY_ATTR(temp_ambient_alert_min),
> -	POWER_SUPPLY_ATTR(temp_ambient_alert_max),
> -	POWER_SUPPLY_ATTR(time_to_empty_now),
> -	POWER_SUPPLY_ATTR(time_to_empty_avg),
> -	POWER_SUPPLY_ATTR(time_to_full_now),
> -	POWER_SUPPLY_ATTR(time_to_full_avg),
> -	POWER_SUPPLY_ATTR(type),
> -	POWER_SUPPLY_ATTR(usb_type),
> -	POWER_SUPPLY_ATTR(scope),
> -	POWER_SUPPLY_ATTR(precharge_current),
> -	POWER_SUPPLY_ATTR(charge_term_current),
> -	POWER_SUPPLY_ATTR(calibrate),
> -	/* Properties of type `const char *' */
> -	POWER_SUPPLY_ATTR(model_name),
> -	POWER_SUPPLY_ATTR(manufacturer),
> -	POWER_SUPPLY_ATTR(serial_number),
> -};
> -
> -static struct attribute *
> -__power_supply_attrs[ARRAY_SIZE(power_supply_attrs) + 1];
> -
>  static umode_t power_supply_attr_is_visible(struct kobject *kobj,
>  					   struct attribute *attr,
>  					   int attrno)
> @@ -352,17 +352,7 @@ static const struct attribute_group *power_supply_at=
tr_groups[] =3D {
>  	NULL,
>  };
> =20
> -void power_supply_init_attrs(struct device_type *dev_type)
> -{
> -	int i;
> -
> -	dev_type->groups =3D power_supply_attr_groups;
> -
> -	for (i =3D 0; i < ARRAY_SIZE(power_supply_attrs); i++)
> -		__power_supply_attrs[i] =3D &power_supply_attrs[i].attr;
> -}
> -
> -static char *kstruprdup(const char *str, gfp_t gfp)
> +static char *kstrlwrdup(const char *str, gfp_t gfp)
>  {
>  	char *ret, *ustr;
> =20
> @@ -372,19 +362,75 @@ static char *kstruprdup(const char *str, gfp_t gfp)
>  		return NULL;
> =20
>  	while (*str)
> -		*ustr++ =3D toupper(*str++);
> +		*ustr++ =3D tolower(*str++);
> =20
>  	*ustr =3D 0;
> =20
>  	return ret;
>  }
> =20
> +int power_supply_init_attrs(struct device_type *dev_type)
> +{
> +	int i;
> +
> +	dev_type->groups =3D power_supply_attr_groups;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(power_supply_attrs); i++) {
> +		const char *upper, *lower;
> +		struct device_attribute *attr;
> +
> +		upper =3D power_supply_attrs[i].prop_name;
> +
> +		if (!upper) {
> +			char *name =3D kmalloc(UNDEF_PROP_NAME_LEN, GFP_KERNEL);
> +
> +			if (!name)
> +				goto err_no_mem;
> +
> +			sprintf(name, UNDEF_PROP_NAME_FMT, i);
> +			upper =3D name;
> +		}
> +
> +		lower =3D kstrlwrdup(upper, GFP_KERNEL);
> +
> +		if (!lower)
> +			goto err_no_mem;
> +
> +		power_supply_attrs[i].upper_name =3D upper;
> +		power_supply_attrs[i].lower_name =3D lower;
> +
> +		attr =3D &power_supply_attrs[i].dev_attr;
> +
> +		attr->attr.name =3D lower;
> +		attr->show =3D power_supply_show_property;
> +		attr->store =3D power_supply_store_property;
> +		__power_supply_attrs[i] =3D &attr->attr;
> +	}
> +
> +	return 0;
> +
> +err_no_mem:
> +	power_supply_destroy_attrs();
> +	return -ENOMEM;
> +}
> +
> +void power_supply_destroy_attrs(void)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(power_supply_attrs); i++) {
> +		kfree(power_supply_attrs[i].lower_name);
> +
> +		if (!power_supply_attrs[i].prop_name)
> +			kfree(power_supply_attrs[i].upper_name);
> +	}
> +}
> +
>  int power_supply_uevent(struct device *dev, struct kobj_uevent_env *env)
>  {
>  	struct power_supply *psy =3D dev_get_drvdata(dev);
>  	int ret =3D 0, j;
>  	char *prop_buf;
> -	char *attrname;
> =20
>  	if (!psy || !psy->desc) {
>  		dev_dbg(dev, "No power supply yet\n");
> @@ -400,12 +446,14 @@ int power_supply_uevent(struct device *dev, struct =
kobj_uevent_env *env)
>  		return -ENOMEM;
> =20
>  	for (j =3D 0; j < psy->desc->num_properties; j++) {
> -		struct device_attribute *attr;
> +		struct power_supply_attr *pwr_attr;
> +		struct device_attribute *dev_attr;
>  		char *line;
> =20
> -		attr =3D &power_supply_attrs[psy->desc->properties[j]];
> +		pwr_attr =3D &power_supply_attrs[psy->desc->properties[j]];
> +		dev_attr =3D &pwr_attr->dev_attr;
> =20
> -		ret =3D power_supply_show_property(dev, attr, prop_buf);
> +		ret =3D power_supply_show_property(dev, dev_attr, prop_buf);
>  		if (ret =3D=3D -ENODEV || ret =3D=3D -ENODATA) {
>  			/* When a battery is absent, we expect -ENODEV. Don't abort;
>  			   send the uevent with at least the the PRESENT=3D0 property */
> @@ -420,14 +468,8 @@ int power_supply_uevent(struct device *dev, struct k=
obj_uevent_env *env)
>  		if (line)
>  			*line =3D 0;
> =20
> -		attrname =3D kstruprdup(attr->attr.name, GFP_KERNEL);
> -		if (!attrname) {
> -			ret =3D -ENOMEM;
> -			goto out;
> -		}
> -
> -		ret =3D add_uevent_var(env, "POWER_SUPPLY_%s=3D%s", attrname, prop_buf=
);
> -		kfree(attrname);
> +		ret =3D add_uevent_var(env, "POWER_SUPPLY_%s=3D%s",
> +				     pwr_attr->upper_name, prop_buf);
>  		if (ret)
>  			goto out;
>  	}
> --=20
> 2.26.2.303.gf8c07b1a785-goog
>=20

--bhd6lwvrokpe4kol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6sv4UACgkQ2O7X88g7
+pr5hQ//YXs2j/U0ujwlB5JggYKZCspVlUmyNSpdBIVprdF+Lg+7IB299kNLP0CF
HZwlvZ7CMIbDGK7STiUZRmJFUWROUdvC07GWq/OSYbHtNM7fUwT4beK+/bO3KFhh
od5eLsbfIWWRDPhaUdQiAW7r2gRPJp9CdtRjs00FE+XuI+fGmH3DbkbdkGaU/aCc
E+V8hbalyouMlhUHgMpOPcaDyWE+LW9lDtkk4ZplVN61GmS6sF/03koT/3dCDuwZ
3xXA09tGCNz7b2zhDKEEgPNqZ9+qKhf+q8Ef0X1HB1zm3NsPmK4jlwQMRDE8XS2x
RkhCbQSo+k44o6+mvpDmX6C7l1b9ix8sp5Sk4Qqw2vzG/nq4dZIkPPllocPwpJsc
jR3MMHIIg8BieF3BzTDi0sf26A50Mr0pFM5y37pV4+yYHkBGDOtqRLuEQhq6RzxE
VfywM+aHa+lxUgBN8McgEbDhArDt16MTaT+HrY47fAJgVi3mv26D6Z3GvU8/CrFQ
8UVlTJiB9U0td5p5u6XG5K5NHaYGOe9I2JIIu/EyxfVZQIVLPzOTUyYmFv046fas
nr9fPSs6y6F2cBe/x4OCRJxFnTXAxrZ24Nfo0/AGYrceO6rFzXnt3H/eFrA6sqSP
J5XKGo5Ek7S787hi1Wvxf5bmof7kqG0ADstob21UWflgydQe8xw=
=MQ8O
-----END PGP SIGNATURE-----

--bhd6lwvrokpe4kol--
