Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774961C294D
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 03:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgECBUQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 May 2020 21:20:16 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44704 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgECBUQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 May 2020 21:20:16 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 8C9AD270E41
Received: by earth.universe (Postfix, from userid 1000)
        id 323E13C08C7; Sun,  3 May 2020 03:20:10 +0200 (CEST)
Date:   Sun, 3 May 2020 03:20:10 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Mathew King <mathewk@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/4] power_supply: Add a macro that maps enum properties
 to text values
Message-ID: <20200503012010.i7wdh4ibsjdzpckr@earth.universe>
References: <20200424173533.48572-1-mathewk@chromium.org>
 <20200424173533.48572-4-mathewk@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="psb4zaflmyzu4nyt"
Content-Disposition: inline
In-Reply-To: <20200424173533.48572-4-mathewk@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--psb4zaflmyzu4nyt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 24, 2020 at 11:35:32AM -0600, Mathew King wrote:
> Reduce the number of touch points to add a new enum property to the
> power_supply class by mapping the array of text values to the device
> attribute descriptor. A new enum property can now added by creating an
> array with the text values named POWER_SUPPLY_${PROPNAME}_TEXT and
> adding POWER_SUPPLY_ENUM_ATTR(${PROPNAME}) to the power_supply_attrs
> array.
>=20
> Signed-off-by: Mathew King <mathewk@chromium.org>
> ---

nice cleanup :)

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/power_supply_sysfs.c | 122 +++++++++-------------
>  1 file changed, 49 insertions(+), 73 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index 328107589770..fbb05466b9a5 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -26,15 +26,25 @@ struct power_supply_attr {
>  	const char *upper_name;
>  	const char *lower_name;
>  	struct device_attribute dev_attr;
> +	const char * const *text_values;
> +	int text_values_len;
>  };
> =20
> -#define POWER_SUPPLY_ATTR(_name)	\
> -[POWER_SUPPLY_PROP_ ## _name] =3D		\
> -{					\
> -	.prop_name =3D #_name		\
> +#define _POWER_SUPPLY_ATTR(_name, _text, _len)	\
> +[POWER_SUPPLY_PROP_ ## _name] =3D			\
> +{						\
> +	.prop_name =3D #_name,			\
> +	.text_values =3D _text,			\
> +	.text_values_len =3D _len,		\
>  }
> =20
> -static const char * const power_supply_type_text[] =3D {
> +#define POWER_SUPPLY_ATTR(_name) _POWER_SUPPLY_ATTR(_name, NULL, 0)
> +#define _POWER_SUPPLY_ENUM_ATTR(_name, _text)	\
> +	_POWER_SUPPLY_ATTR(_name, _text, ARRAY_SIZE(_text))
> +#define POWER_SUPPLY_ENUM_ATTR(_name)	\
> +	_POWER_SUPPLY_ENUM_ATTR(_name, POWER_SUPPLY_ ## _name ## _TEXT)
> +
> +static const char * const POWER_SUPPLY_TYPE_TEXT[] =3D {
>  	[POWER_SUPPLY_TYPE_UNKNOWN]		=3D "Unknown",
>  	[POWER_SUPPLY_TYPE_BATTERY]		=3D "Battery",
>  	[POWER_SUPPLY_TYPE_UPS]			=3D "UPS",
> @@ -62,7 +72,7 @@ static const char * const POWER_SUPPLY_USB_TYPE_TEXT[] =
=3D {
>  	[POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID]	=3D "BrickID",
>  };
> =20
> -static const char * const power_supply_status_text[] =3D {
> +static const char * const POWER_SUPPLY_STATUS_TEXT[] =3D {
>  	[POWER_SUPPLY_STATUS_UNKNOWN]		=3D "Unknown",
>  	[POWER_SUPPLY_STATUS_CHARGING]		=3D "Charging",
>  	[POWER_SUPPLY_STATUS_DISCHARGING]	=3D "Discharging",
> @@ -70,7 +80,7 @@ static const char * const power_supply_status_text[] =
=3D {
>  	[POWER_SUPPLY_STATUS_FULL]		=3D "Full",
>  };
> =20
> -static const char * const power_supply_charge_type_text[] =3D {
> +static const char * const POWER_SUPPLY_CHARGE_TYPE_TEXT[] =3D {
>  	[POWER_SUPPLY_CHARGE_TYPE_UNKNOWN]	=3D "Unknown",
>  	[POWER_SUPPLY_CHARGE_TYPE_NONE]		=3D "N/A",
>  	[POWER_SUPPLY_CHARGE_TYPE_TRICKLE]	=3D "Trickle",
> @@ -80,7 +90,7 @@ static const char * const power_supply_charge_type_text=
[] =3D {
>  	[POWER_SUPPLY_CHARGE_TYPE_CUSTOM]	=3D "Custom",
>  };
> =20
> -static const char * const power_supply_health_text[] =3D {
> +static const char * const POWER_SUPPLY_HEALTH_TEXT[] =3D {
>  	[POWER_SUPPLY_HEALTH_UNKNOWN]		    =3D "Unknown",
>  	[POWER_SUPPLY_HEALTH_GOOD]		    =3D "Good",
>  	[POWER_SUPPLY_HEALTH_OVERHEAT]		    =3D "Overheat",
> @@ -93,7 +103,7 @@ static const char * const power_supply_health_text[] =
=3D {
>  	[POWER_SUPPLY_HEALTH_OVERCURRENT]	    =3D "Over current",
>  };
> =20
> -static const char * const power_supply_technology_text[] =3D {
> +static const char * const POWER_SUPPLY_TECHNOLOGY_TEXT[] =3D {
>  	[POWER_SUPPLY_TECHNOLOGY_UNKNOWN]	=3D "Unknown",
>  	[POWER_SUPPLY_TECHNOLOGY_NiMH]		=3D "NiMH",
>  	[POWER_SUPPLY_TECHNOLOGY_LION]		=3D "Li-ion",
> @@ -103,7 +113,7 @@ static const char * const power_supply_technology_tex=
t[] =3D {
>  	[POWER_SUPPLY_TECHNOLOGY_LiMn]		=3D "LiMn",
>  };
> =20
> -static const char * const power_supply_capacity_level_text[] =3D {
> +static const char * const POWER_SUPPLY_CAPACITY_LEVEL_TEXT[] =3D {
>  	[POWER_SUPPLY_CAPACITY_LEVEL_UNKNOWN]	=3D "Unknown",
>  	[POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL]	=3D "Critical",
>  	[POWER_SUPPLY_CAPACITY_LEVEL_LOW]	=3D "Low",
> @@ -112,7 +122,7 @@ static const char * const power_supply_capacity_level=
_text[] =3D {
>  	[POWER_SUPPLY_CAPACITY_LEVEL_FULL]	=3D "Full",
>  };
> =20
> -static const char * const power_supply_scope_text[] =3D {
> +static const char * const POWER_SUPPLY_SCOPE_TEXT[] =3D {
>  	[POWER_SUPPLY_SCOPE_UNKNOWN]	=3D "Unknown",
>  	[POWER_SUPPLY_SCOPE_SYSTEM]	=3D "System",
>  	[POWER_SUPPLY_SCOPE_DEVICE]	=3D "Device",
> @@ -120,13 +130,13 @@ static const char * const power_supply_scope_text[]=
 =3D {
> =20
>  static struct power_supply_attr power_supply_attrs[] =3D {
>  	/* Properties of type `int' */
> -	POWER_SUPPLY_ATTR(STATUS),
> -	POWER_SUPPLY_ATTR(CHARGE_TYPE),
> -	POWER_SUPPLY_ATTR(HEALTH),
> +	POWER_SUPPLY_ENUM_ATTR(STATUS),
> +	POWER_SUPPLY_ENUM_ATTR(CHARGE_TYPE),
> +	POWER_SUPPLY_ENUM_ATTR(HEALTH),
>  	POWER_SUPPLY_ATTR(PRESENT),
>  	POWER_SUPPLY_ATTR(ONLINE),
>  	POWER_SUPPLY_ATTR(AUTHENTIC),
> -	POWER_SUPPLY_ATTR(TECHNOLOGY),
> +	POWER_SUPPLY_ENUM_ATTR(TECHNOLOGY),
>  	POWER_SUPPLY_ATTR(CYCLE_COUNT),
>  	POWER_SUPPLY_ATTR(VOLTAGE_MAX),
>  	POWER_SUPPLY_ATTR(VOLTAGE_MIN),
> @@ -169,7 +179,7 @@ static struct power_supply_attr power_supply_attrs[] =
=3D {
>  	POWER_SUPPLY_ATTR(CAPACITY),
>  	POWER_SUPPLY_ATTR(CAPACITY_ALERT_MIN),
>  	POWER_SUPPLY_ATTR(CAPACITY_ALERT_MAX),
> -	POWER_SUPPLY_ATTR(CAPACITY_LEVEL),
> +	POWER_SUPPLY_ENUM_ATTR(CAPACITY_LEVEL),
>  	POWER_SUPPLY_ATTR(TEMP),
>  	POWER_SUPPLY_ATTR(TEMP_MAX),
>  	POWER_SUPPLY_ATTR(TEMP_MIN),
> @@ -182,9 +192,9 @@ static struct power_supply_attr power_supply_attrs[] =
=3D {
>  	POWER_SUPPLY_ATTR(TIME_TO_EMPTY_AVG),
>  	POWER_SUPPLY_ATTR(TIME_TO_FULL_NOW),
>  	POWER_SUPPLY_ATTR(TIME_TO_FULL_AVG),
> -	POWER_SUPPLY_ATTR(TYPE),
> +	POWER_SUPPLY_ENUM_ATTR(TYPE),
>  	POWER_SUPPLY_ATTR(USB_TYPE),
> -	POWER_SUPPLY_ATTR(SCOPE),
> +	POWER_SUPPLY_ENUM_ATTR(SCOPE),
>  	POWER_SUPPLY_ATTR(PRECHARGE_CURRENT),
>  	POWER_SUPPLY_ATTR(CHARGE_TERM_CURRENT),
>  	POWER_SUPPLY_ATTR(CALIBRATE),
> @@ -197,10 +207,14 @@ static struct power_supply_attr power_supply_attrs[=
] =3D {
>  static struct attribute *
>  __power_supply_attrs[ARRAY_SIZE(power_supply_attrs) + 1];
> =20
> +static struct power_supply_attr *to_ps_attr(struct device_attribute *att=
r)
> +{
> +	return container_of(attr, struct power_supply_attr, dev_attr);
> +}
> +
>  static enum power_supply_property dev_attr_psp(struct device_attribute *=
attr)
>  {
> -	return container_of(attr, struct power_supply_attr, dev_attr) -
> -		power_supply_attrs;
> +	return  to_ps_attr(attr) - power_supply_attrs;
>  }
> =20
>  static ssize_t power_supply_show_usb_type(struct device *dev,
> @@ -219,11 +233,11 @@ static ssize_t power_supply_show_usb_type(struct de=
vice *dev,
> =20
>  		if (value->intval =3D=3D usb_type) {
>  			count +=3D sprintf(buf + count, "[%s] ",
> -					 power_supply_usb_type_text[usb_type]);
> +					 POWER_SUPPLY_USB_TYPE_TEXT[usb_type]);
>  			match =3D true;
>  		} else {
>  			count +=3D sprintf(buf + count, "%s ",
> -					 power_supply_usb_type_text[usb_type]);
> +					 POWER_SUPPLY_USB_TYPE_TEXT[usb_type]);
>  		}
>  	}
> =20
> @@ -243,6 +257,7 @@ static ssize_t power_supply_show_property(struct devi=
ce *dev,
>  					  char *buf) {
>  	ssize_t ret;
>  	struct power_supply *psy =3D dev_get_drvdata(dev);
> +	struct power_supply_attr *ps_attr =3D to_ps_attr(attr);
>  	enum power_supply_property psp =3D dev_attr_psp(attr);
>  	union power_supply_propval value;
> =20
> @@ -263,39 +278,16 @@ static ssize_t power_supply_show_property(struct de=
vice *dev,
>  		}
>  	}
> =20
> +	if (ps_attr->text_values_len > 0 &&
> +	    value.intval < ps_attr->text_values_len && value.intval >=3D 0) {
> +		return sprintf(buf, "%s\n", ps_attr->text_values[value.intval]);
> +	}
> +
>  	switch (psp) {
> -	case POWER_SUPPLY_PROP_STATUS:
> -		ret =3D sprintf(buf, "%s\n",
> -			      power_supply_status_text[value.intval]);
> -		break;
> -	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> -		ret =3D sprintf(buf, "%s\n",
> -			      power_supply_charge_type_text[value.intval]);
> -		break;
> -	case POWER_SUPPLY_PROP_HEALTH:
> -		ret =3D sprintf(buf, "%s\n",
> -			      power_supply_health_text[value.intval]);
> -		break;
> -	case POWER_SUPPLY_PROP_TECHNOLOGY:
> -		ret =3D sprintf(buf, "%s\n",
> -			      power_supply_technology_text[value.intval]);
> -		break;
> -	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
> -		ret =3D sprintf(buf, "%s\n",
> -			      power_supply_capacity_level_text[value.intval]);
> -		break;
> -	case POWER_SUPPLY_PROP_TYPE:
> -		ret =3D sprintf(buf, "%s\n",
> -			      power_supply_type_text[value.intval]);
> -		break;
>  	case POWER_SUPPLY_PROP_USB_TYPE:
>  		ret =3D power_supply_show_usb_type(dev, psy->desc->usb_types,
> -						 psy->desc->num_usb_types,
> -						 &value, buf);
> -		break;
> -	case POWER_SUPPLY_PROP_SCOPE:
> -		ret =3D sprintf(buf, "%s\n",
> -			      power_supply_scope_text[value.intval]);
> +						psy->desc->num_usb_types,
> +						&value, buf);
>  		break;
>  	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_SERIAL_NUMBER:
>  		ret =3D sprintf(buf, "%s\n", value.strval);
> @@ -312,30 +304,14 @@ static ssize_t power_supply_store_property(struct d=
evice *dev,
>  					   const char *buf, size_t count) {
>  	ssize_t ret;
>  	struct power_supply *psy =3D dev_get_drvdata(dev);
> +	struct power_supply_attr *ps_attr =3D to_ps_attr(attr);
>  	enum power_supply_property psp =3D dev_attr_psp(attr);
>  	union power_supply_propval value;
> =20
> -	switch (psp) {
> -	case POWER_SUPPLY_PROP_STATUS:
> -		ret =3D sysfs_match_string(power_supply_status_text, buf);
> -		break;
> -	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> -		ret =3D sysfs_match_string(power_supply_charge_type_text, buf);
> -		break;
> -	case POWER_SUPPLY_PROP_HEALTH:
> -		ret =3D sysfs_match_string(power_supply_health_text, buf);
> -		break;
> -	case POWER_SUPPLY_PROP_TECHNOLOGY:
> -		ret =3D sysfs_match_string(power_supply_technology_text, buf);
> -		break;
> -	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
> -		ret =3D sysfs_match_string(power_supply_capacity_level_text, buf);
> -		break;
> -	case POWER_SUPPLY_PROP_SCOPE:
> -		ret =3D sysfs_match_string(power_supply_scope_text, buf);
> -		break;
> -	default:
> -		ret =3D -EINVAL;
> +	ret =3D -EINVAL;
> +	if (ps_attr->text_values_len > 0) {
> +		ret =3D __sysfs_match_string(ps_attr->text_values,
> +					   ps_attr->text_values_len, buf);
>  	}
> =20
>  	/*
> --=20
> 2.26.2.303.gf8c07b1a785-goog
>=20

--psb4zaflmyzu4nyt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6uHEoACgkQ2O7X88g7
+prnHA/8Dsou2FoK79Qz8f1N0ZMWvb8S01Ay71P9nX3qh7aRKjbPfGwm/GmZ1Bnj
AJpDyEGIO4PjWAxc8tuhlHQETRpjAWdiPQZeLlStiS1gyNwj0Ud5qvlRYg7QbDVl
s0x6dL5y2YnpxrqQvUbaKFisnpRndiC4KrFSJVYDqNtEO2cQr8VGvpGKXISwpqdz
ZARh4FGkpg5hg6kqp6sj3zPJnumjVcqyC+QGjoXc9sz3HhzDP5Z8mTTNctttlzPT
G5lUL1MrD0Na4TZ2jDE7nDszmxlv8sBPhVhEjkzsBXxx1JJ59GpukDMDTMIDVFCX
tcpD8u9QElN0A8czG05vCfi55FJINvZMk6Iq0GvAHl0gkYWDzPQ7UBp/QCBaW2tn
n89e5rHK63TAtcHbAA9FSeUBJ4lEQzLL35zHmSoEcQJAtVL5knIRD6BGcN/Yit7A
vsbhNR7mmaapPXh6myQz7cg7eohlCci+fIawTw68G+VFAnW4N/5EJLcBodI8z9s3
HnSmc3UteHReHQDSyNV+zZjXzhUwuSAOjRaFvN6cyAN9ioDfLtV6w6bJOoy9tfA6
HTWB8FJH4lStN0KaaSH3z9zhCi+0LIEfy3EZXa8/KL/zwZGRWbFc5gGTHgOVHalj
4627h2vPDuem1ajrkPthHklaGh9ocjXpw6BLJABqFttyAVUvrxI=
=+dI4
-----END PGP SIGNATURE-----

--psb4zaflmyzu4nyt--
