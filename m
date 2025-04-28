Return-Path: <linux-pm+bounces-26334-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DC6A9FD6E
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 01:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90A3718852B8
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 23:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04422045B7;
	Mon, 28 Apr 2025 23:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="JLdstz76"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EFE154BF5;
	Mon, 28 Apr 2025 23:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745881378; cv=pass; b=fY/8eMm+DnSRy56GXYW018gNbKqZ+GQJcxP9Sw8/nS2v7aIZ7ZNnxxzwwkpjLVJyqQAAV2M/L22hCeI6JUG7Mcqss9f4c+JOl0m3fw3f4ri7duzprMe5oUHSEOGI1/MeUcBbzecRONf9MaPjpiPqg8OgVSvBvwbIh+H/7Yu8MNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745881378; c=relaxed/simple;
	bh=ownss69Dxsb+YgyEfJTNQjd70aYi8CWtjQwBU6ISDCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OcscaOJaeMIwWP562ko1HriGHoRJl7/tzMIwjvAGmgHq2Uhxr0FSAVCDicLKZGQPWQ/m+xiK5oKHKOijRdQfbpYlzKUyiv5UZz/y3ToSexhawFCVAJTn2d6NHjnmV/b0+UBxDzAAxcXSyRxS2LrCX8IRDy2JsUcfxVxwsEgf36c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=JLdstz76; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1745881349; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KmFn90xU9KVcVyFi1smTfbCt78dJ2i5CHivqNI044dh9j3dJik0nzZzOZfZP+GzUdJiELvGEalrZ4ICruDgGM3wDIYEXYotiL+gPjvCuXi1CXOYq/TX1rEGCAE5nsx5M87+En4LKrEMHolr8hLIuZa7BlXfBSnBVS+ESb0OKFH4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745881349; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RhkTUI9XE9KtR01w6s10olcqVKXI9TeKkCq9NLvPXLI=; 
	b=fqUOSyEX0hAScy/mkLCEYonSxVpAxvLqaCgzm+wJwtgomIJDD6IVowzvFXruav55sJqDMq1Lt2j1rhUNZRbQLC6ItViNAg4kRlj91iT8Ad4i3WGIzSBCtH+Mr/mg4Z4Fo0s+gkQs6YyhumGOU2KBQwhRSa30zo8drckcuwDLa1A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745881349;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=RhkTUI9XE9KtR01w6s10olcqVKXI9TeKkCq9NLvPXLI=;
	b=JLdstz76na+V3rurXlpU4A2AIYOS4NutobLQh5VZXlnT/KF/d87XlVNv686tpzHW
	7fOduS0aeU31doZB3EnbrGJlyUAPJnUoxGCKTJ4nslTqziv6vfdPM4VucrPAdhXhl+3
	kSDln9lisdGjBCSJSMYHlN/KfEBtQTdD/5aUbMjY=
Received: by mx.zohomail.com with SMTPS id 1745881346002522.8861982694854;
	Mon, 28 Apr 2025 16:02:26 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 455301806F3; Tue, 29 Apr 2025 01:02:21 +0200 (CEST)
Date: Tue, 29 Apr 2025 01:02:21 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Heiko Stuebner <heiko@sntech.de>, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Aradhya Bhatia <a-bhatia1@ti.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 3/4] power/supply: Add driver for Pegatron Chagall
 battery
Message-ID: <22du3s2n3pcyivw7ktpqcvyvady24qggiqouz5hqzoca2tzyqd@vdi5qbtdkrgj>
References: <20250413111033.11408-1-clamor95@gmail.com>
 <20250413111033.11408-4-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iy6xjdlnbcua5d4x"
Content-Disposition: inline
In-Reply-To: <20250413111033.11408-4-clamor95@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/245.863.17
X-ZohoMailClient: External


--iy6xjdlnbcua5d4x
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/4] power/supply: Add driver for Pegatron Chagall
 battery
MIME-Version: 1.0

Hi,

On Sun, Apr 13, 2025 at 02:10:32PM +0300, Svyatoslav Ryhel wrote:
> The Pegatron Chagall is an Android tablet utilizing a customized Cypress
> CG7153AM microcontroller (MCU) as its battery fuel gauge. It supports a
> single-cell battery and features a dual-color charging LED.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---

This looks mostly good to me, but I have some comments.

>  drivers/power/supply/Kconfig           |  12 +
>  drivers/power/supply/Makefile          |   1 +
>  drivers/power/supply/chagall-battery.c | 308 +++++++++++++++++++++++++
>  3 files changed, 321 insertions(+)
>  create mode 100644 drivers/power/supply/chagall-battery.c

[...]

> +static void chagall_leds_status_update(struct chagall_battery_data *cg, =
int state)
> +{
> +	switch (state) {
> +	case POWER_SUPPLY_STATUS_FULL:
> +		led_set_brightness(&cg->amber_led, LED_OFF);
> +		led_set_brightness(&cg->white_led,  LED_ON);
> +		break;
> +
> +	case POWER_SUPPLY_STATUS_CHARGING:
> +		led_set_brightness(&cg->white_led, LED_OFF);
> +		led_set_brightness(&cg->amber_led,  LED_ON);
> +		break;
> +
> +	default:
> +		led_set_brightness(&cg->amber_led, LED_OFF);
> +		led_set_brightness(&cg->white_led, LED_OFF);
> +		break;
> +	}
> +}

Instead of doing this, you should setup LED triggers when
registering the LEDs. The white LED can use power-supply's full_trig
and the orange LED can use power-supply's charging_trig, which
should have the same effect.

> +static const enum power_supply_property chagall_battery_properties[] =3D=
 {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_VOLTAGE_MAX,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_MAX,
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_CHARGE_FULL,
> +	POWER_SUPPLY_PROP_CHARGE_NOW,
> +};
> +
> +static const unsigned int chagall_battery_prop_offs[] =3D {
> +	[POWER_SUPPLY_PROP_TEMP] =3D CHAGALL_REG_BATTERY_TEMPERATURE,
> +	[POWER_SUPPLY_PROP_VOLTAGE_NOW] =3D CHAGALL_REG_BATTERY_VOLTAGE,
> +	[POWER_SUPPLY_PROP_CURRENT_NOW] =3D CHAGALL_REG_BATTERY_CURRENT,
> +	[POWER_SUPPLY_PROP_CAPACITY] =3D CHAGALL_REG_BATTERY_CAPACITY,
> +	[POWER_SUPPLY_PROP_CURRENT_MAX] =3D CHAGALL_REG_BATTERY_CHARGING_CURREN=
T,
> +	[POWER_SUPPLY_PROP_VOLTAGE_MAX] =3D CHAGALL_REG_BATTERY_CHARGING_VOLTAG=
E,
> +	[POWER_SUPPLY_PROP_STATUS] =3D CHAGALL_REG_BATTERY_STATUS,
> +	[POWER_SUPPLY_PROP_CHARGE_NOW] =3D CHAGALL_REG_BATTERY_REMAIN_CAPACITY,
> +	[POWER_SUPPLY_PROP_CHARGE_FULL] =3D CHAGALL_REG_BATTERY_FULL_CAPACITY,
> +};

Please use the same order for chagall_battery_prop_offs and
chagall_battery_properties. Makes it a lot easier to see
that all options have been covered.

> +static int chagall_battery_get_value(struct chagall_battery_data *cg,
> +				     enum power_supply_property psp, u32 *val)
> +{
> +	if (psp >=3D ARRAY_SIZE(chagall_battery_prop_offs))
> +		return -EINVAL;
> +	if (!chagall_battery_prop_offs[psp])
> +		return -EINVAL;
> +
> +	/* Battery data is stored in 2 consecutive registers with little-endian=
 */
> +	return regmap_bulk_read(cg->regmap, chagall_battery_prop_offs[psp], val=
, 2);
> +}
> +
> +static int chagall_battery_get_property(struct power_supply *psy,
> +					enum power_supply_property psp,
> +					union power_supply_propval *val)
> +{
> +	struct chagall_battery_data *cg =3D power_supply_get_drvdata(psy);
> +	int ret;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		val->intval =3D 1;
> +		break;
> +
> +	default:
> +		ret =3D chagall_battery_get_value(cg, psp, &val->intval);
> +		if (ret)
> +			return ret;
> +
> +		switch (psp) {
> +		case POWER_SUPPLY_PROP_TEMP:
> +			val->intval -=3D TEMP_CELSIUS_OFFSET;
> +			break;
> +
> +		case POWER_SUPPLY_PROP_VOLTAGE_MAX:
> +		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		case POWER_SUPPLY_PROP_CURRENT_MAX:
> +		case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		case POWER_SUPPLY_PROP_CHARGE_FULL:
> +		case POWER_SUPPLY_PROP_CHARGE_NOW:
> +			val->intval *=3D 1000;
> +			break;
> +
> +		case POWER_SUPPLY_PROP_STATUS:
> +			if (val->intval & BATTERY_FULL_CHARGED)
> +				val->intval =3D POWER_SUPPLY_STATUS_FULL;
> +			else if (val->intval & BATTERY_FULL_DISCHARGED)
> +				val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;

Have you tested this path? POWER_SUPPLY_STATUS_NOT_CHARGING is
intended to be used when the battery is neither charging nor
discharging. Does BATTERY_FULL_DISCHARGED mean, that the battery
is fully depleted and not providing any energy at all? Or is this
some kind of "battery level is criticial, you should attach a
power-supply now or the system will be turn off by itself soon"?

> +			else if (val->intval & BATTERY_DISCHARGING)
> +				val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +			else
> +				val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
> +			break;
> +
> +		default:
> +			break;
> +		}
> +
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static void chagall_battery_poll_work(struct work_struct *work)
> +{
> +	struct chagall_battery_data *cg =3D
> +		container_of(work, struct chagall_battery_data, poll_work.work);
> +	u32 state;
> +	int ret;
> +
> +	ret =3D chagall_battery_get_value(cg, POWER_SUPPLY_PROP_STATUS, &state);
> +	if (ret)
> +		return;
> +
> +	if (state & BATTERY_FULL_CHARGED)
> +		state =3D POWER_SUPPLY_STATUS_FULL;
> +	else if (state & BATTERY_DISCHARGING)
> +		state =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +	else
> +		state =3D POWER_SUPPLY_STATUS_CHARGING;

This basically duplicates the logic from chagall_battery_get_property(),
so put the translation logic into a helper function and use it in
both places.

Greetings,

-- Sebastian

--iy6xjdlnbcua5d4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmgQCPkACgkQ2O7X88g7
+pq1ig//fof6Fhl3SUpeNdPzt3Kv9vb2WmT7KdZWwHb8NtR21x0fBdMWJBnwIkjZ
SEbWAPAHTLB5sepeDNgtdWu2h9cGGFuOygbhGU3W2sd/hSvl6su30pM/GcnjUdjS
Y0cnzbiRIKGFAwoZQFdwOSy2HSnZEuBXdxV55RycV1Zeq7pLAoNDzGKnlYmHCbzZ
JopP2mS2n9wYmzHoBZXUNq2AtFHhp2I+39u8867yRKqrJUdJh51QYHrNb1vv5eKo
wH17kRiT+7yQcX5O8/nQlI1/4eU26uPErxmaQFmN+Z8Ceo/hvbpVO+8+8gm3C4jA
onj5QFCrZ/YExn/+yAunw4DFbSXbq354onU+lY6yn5LeKP7NsFUS4Ez8hnm9z6gn
mMArqLXnUVyQMp6C+Ld7IcSq5CW6nQPJrwpony6Rmhs83mRRyV2Y560THmIczp/H
9lIWiFOIPyXlGPfETDE4a3jIClHQB8+XKQOAZ9gG2xGaMz1af/evpRfbWRWo/lS5
33bzC2DjGrXt63fvYEXH0yGHysaIRq9neL4cKCvCxM5z8VzwMlWWunYfJBC5m6pm
4+0GEW/euOMBRaoNJdSw0NORLMyQl5//E8I1MDgD6ZB7t/dvjwOMQiDVShx+SXfi
gDdtHPRUWsYCyqDEjD53MjA/UmL1gBbTtqREhK6gDxezNqVIc/0=
=3MAE
-----END PGP SIGNATURE-----

--iy6xjdlnbcua5d4x--

