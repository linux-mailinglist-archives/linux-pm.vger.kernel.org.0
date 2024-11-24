Return-Path: <linux-pm+bounces-18003-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9BD9D77A4
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2024 20:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E80F6B258B0
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2024 17:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5407DA88;
	Sun, 24 Nov 2024 17:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="YYvmLkdo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124FC2500C7;
	Sun, 24 Nov 2024 17:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732470828; cv=none; b=hoHf9z2YsKevdwgulo9fXvlOopdJFfEslJ/jWkbN8UYmC6Fp8RBdCCeRTj8sBs6bjNKgDQcuVU5KKQmrHV7PQDzPBECa/86qPa7ZOlBTtiU3w7GiWxdd5xgKu647e+i48KKtDGMoz60dr+XstT6tTmbWbdG2zK2HPynEg7tYsKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732470828; c=relaxed/simple;
	bh=u5wiDJ2W5x/XuiSiGvRjef3oIM130d/cnZ8lOXQfHC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=neIbFCNumMTDWBpogzGi5/YHw1t5cWiZyi9ZF3+icQg/O50O+V+iUs2B05P78tC3AMUMM2TlOs8bk7r/sifPjXl2bwD8vUNnKejJka4E/VrKTY9JcHBNksZQ8qAAkv/E3t2wpkVHI08sO1zrrWXlb90DPKJwL3wXtsdNwV6CzLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=YYvmLkdo; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732470814; x=1733075614; i=w_armin@gmx.de;
	bh=J6SCdfx7UQJh7xRcL5iXnt8BhAJ2MRY+6MnyC2d/45s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YYvmLkdoaklzTv5yHFPxK/PUTrfTgWlGYsTOVxN8pX3mQ5zILoEWA+R7EiT8ENrF
	 2qOqJeMfEpyIYtedXHf3VgqGftDtBMzaNJPbX4ibxNf0BLKtxKaOaQsODwoXCqENw
	 vdF6gB4aUEMN+Dc+Fm6OtEyyZoWuJj9RbTVICVk8mMmMt7t5SUwoFNRlA+eXyn0k8
	 WLF5m88fybTbn+vAFAXHQUeiA0ybYAF2/CpZtL3Y7h0BOjrbUDMhvKNArpG3BM7Jg
	 oE8dKWZ1b0rFeJ+EjbgetQ26Jvp7ELTvRI6Trg6/I3PQc0PVrtXXd/3ohVtLPIbkH
	 FD3cdLxoaj7GQ4K3aA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQ5rU-1t21Gg13Dc-00Z7qg; Sun, 24
 Nov 2024 18:53:34 +0100
Message-ID: <a488ad9c-f1f5-4838-9215-1dafe594724a@gmx.de>
Date: Sun, 24 Nov 2024 18:53:32 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/9] power: supply: hwmon: prepare for power supply
 extensions
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 chrome-platform@lists.linux.dev,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20241111-power-supply-extensions-v4-0-7240144daa8e@weissschuh.net>
 <20241111-power-supply-extensions-v4-4-7240144daa8e@weissschuh.net>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241111-power-supply-extensions-v4-4-7240144daa8e@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EvTlIo0NgN2yJBd5E+jUy9K43iIToa2QTxdnIgybDgK3j/2mxih
 yDWlZ2qh1/6oYq/aEGXd9HRV2Bfyt81gG6iEfAqfe4T8YXFItSvOSCpr4n+4HL2FL4xjDsG
 gFaFWfzzAhw2xUqB4dIi665beMKNoQyKeWfY6eLe2CIfMC+tz/MXuSgm3G2xUA82wRXX8Qb
 7/ic4PjrwoAdqVOHXK+fg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hKzIQRuqAtQ=;hSwzqCJX/twfuYmqyk/RN59lT+G
 TMqmpAZN75Ljx7eRE1Zme+K7G+itj6v55RdJiEVQJnkL0iDISiEtwa1Ky38telZz6t4WCARzT
 Xb0qycxKbQtsgkP2Mrmts7BibIap8yUai9Oz2uoOo+DhzCwxYcw+sMJuyKWmkv2s2VEKk3/Z+
 7w282t0GrEdJO9IAUDsi7JbiVYVxlpTfdl0e5F/QiiA7XUyn0wc4MWWfDcG+vo/KcE+b3Jusy
 yvb37gqPuCGNtfd1frFSFZhQkceVTAE8yYYlXT6Dsi4kmZmXuzblNuCOOhLhYIcp+XRXAEyJL
 SZB6W///Ulymgob6/AkcU2pmvlc5fr36k/Swa3zuqxy9b3BTjCfLNPQa08HmaKISMrpfgMFPc
 zFND0Dxlntg6hj/LP5sztzGASAXkLJbCZBNOYqDarIKVrAqcah08BRFF8ZBZ8WxBb2QfQGl/E
 PZ/U3nvb/qk9wHqVPJBGDn8Kv+IRD8KnbIUYa6+bu1jJ97tXCapxtTBg41yk5COEq0VmTBLnM
 uyrMkq+Iigyk7q4Nlyd8gTxJvZOboCO+jjNu4d4h6L5vvSHT1MYmK9yEyzvQJWF7YeOvE4kQc
 pjqy7/RFn8TUEkZc6x/BzQwks2XN5BR5CfK2YKYjSd1cYFFwnQZMb8tA/9ev2mpgW+sCxz3BD
 2vXVK7v0R7ASfbdpOyGCUnFXrq5OBG5l8dx1H6kipVPfFV4JI0bKkrlO6cBh4uWZl7AEAZ6Nc
 Qq3l8qIxnWzDtAXbVtuLuJU/P8ghzTs8hjcO/dnIisBfIudV6eF5KAAbamaoXOSzXbaHcMDX3
 AmGKE5asJ/F5pza/5AOCV6umQevk/79DO4hbJ4pVIKBgVu19RpM50MtN8frTOmlikVZyYEQtV
 bAGDbfF+/h1rwTqaTuxdBZTKt49OUvn79M07lw8yFsAKQwFEHWcDfbXk1OZM2IlR3b8YNp9Kx
 iBmSED/n1iOaoaHLPxfhJnWl+wA0ycpvwYiltrc1HRFWznrF0QkE734Sn+mgdMW3Kz5husvF/
 Ao+jP1kxm4AlPKh2Oh7UOrGCQ/RS5pm7CE2OS6NN00n7NXMW4OoeYc2mmzEuFIp2qjO7veNti
 kSnd4po8QqxSeN4pKzlcZ3PMahEc+J

Am 11.11.24 um 22:40 schrieb Thomas Wei=C3=9Fschuh:

> The upcoming extension API will add properties which are not part of the
> the power_supply_desc.
> Use power_supply_has_property() so the properties from extensions are
> also chec

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> ked.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>   drivers/power/supply/power_supply_hwmon.c | 50 +++++++++++++++--------=
--------
>   1 file changed, 24 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/s=
upply/power_supply_hwmon.c
> index 01be04903d7d2465ae2acb9eeb0b55a87868bb87..95245e6a6baa3e85ae8551e7=
1f4f7905639a3325 100644
> --- a/drivers/power/supply/power_supply_hwmon.c
> +++ b/drivers/power/supply/power_supply_hwmon.c
> @@ -349,9 +349,28 @@ static const struct hwmon_chip_info power_supply_hw=
mon_chip_info =3D {
>   	.info =3D power_supply_hwmon_info,
>   };
>
> +static const enum power_supply_property power_supply_hwmon_props[] =3D =
{
> +	POWER_SUPPLY_PROP_CURRENT_AVG,
> +	POWER_SUPPLY_PROP_CURRENT_MAX,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_POWER_AVG,
> +	POWER_SUPPLY_PROP_POWER_NOW,
> +	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_TEMP_MAX,
> +	POWER_SUPPLY_PROP_TEMP_MIN,
> +	POWER_SUPPLY_PROP_TEMP_ALERT_MIN,
> +	POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
> +	POWER_SUPPLY_PROP_TEMP_AMBIENT,
> +	POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN,
> +	POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX,
> +	POWER_SUPPLY_PROP_VOLTAGE_AVG,
> +	POWER_SUPPLY_PROP_VOLTAGE_MIN,
> +	POWER_SUPPLY_PROP_VOLTAGE_MAX,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +};
> +
>   int power_supply_add_hwmon_sysfs(struct power_supply *psy)
>   {
> -	const struct power_supply_desc *desc =3D psy->desc;
>   	struct power_supply_hwmon *psyhw;
>   	struct device *dev =3D &psy->dev;
>   	struct device *hwmon;
> @@ -377,32 +396,11 @@ int power_supply_add_hwmon_sysfs(struct power_supp=
ly *psy)
>   		goto error;
>   	}
>
> -	for (i =3D 0; i < desc->num_properties; i++) {
> -		const enum power_supply_property prop =3D desc->properties[i];
> -
> -		switch (prop) {
> -		case POWER_SUPPLY_PROP_CURRENT_AVG:
> -		case POWER_SUPPLY_PROP_CURRENT_MAX:
> -		case POWER_SUPPLY_PROP_CURRENT_NOW:
> -		case POWER_SUPPLY_PROP_POWER_AVG:
> -		case POWER_SUPPLY_PROP_POWER_NOW:
> -		case POWER_SUPPLY_PROP_TEMP:
> -		case POWER_SUPPLY_PROP_TEMP_MAX:
> -		case POWER_SUPPLY_PROP_TEMP_MIN:
> -		case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
> -		case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
> -		case POWER_SUPPLY_PROP_TEMP_AMBIENT:
> -		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN:
> -		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX:
> -		case POWER_SUPPLY_PROP_VOLTAGE_AVG:
> -		case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> -		case POWER_SUPPLY_PROP_VOLTAGE_MAX:
> -		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +	for (i =3D 0; i < ARRAY_SIZE(power_supply_hwmon_props); i++) {
> +		const enum power_supply_property prop =3D power_supply_hwmon_props[i]=
;
> +
> +		if (power_supply_has_property(psy, prop))
>   			set_bit(prop, psyhw->props);
> -			break;
> -		default:
> -			break;
> -		}
>   	}
>
>   	name =3D psy->desc->name;
>

