Return-Path: <linux-pm+bounces-23905-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B02A5D89B
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 09:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C26175E60
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 08:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27699236449;
	Wed, 12 Mar 2025 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="b+tZUZ+z"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8973E2F43;
	Wed, 12 Mar 2025 08:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741769446; cv=pass; b=jRx5ZewY3AN+udiGBAntLbp0X49rzxlVHjML2EZEMQn6KWwCiVu8FShJyWVkQa/H2Gk+Uq/ReDKZBKLUO7GZXuwmBPLv2fLVQj86/fjMAQ1bQ2+DqEDFJ7kuRqAk4VYNzH3eCmOINIJTqqkT7PwZZ/kefU36cc/X1yWkyIw+0SM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741769446; c=relaxed/simple;
	bh=xnLPrh9+m2KUtHUYJrIMXTWAr+bz8BjLWIk1FQq7kbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnDcYxkqE/H9vvp73KzLzA1iG0vzyD9L77w7G0QWhnInimdpRZMnQN3MSeSfhdMQBtKN7qGQzcmhwCsUXRvjzz6p8LiXfGvqpRrTkuMQgB26NODCbpOy0UMKlFiaEiucsSf+W8eEj8r/U7JLumZ511GIX+FbogPPvNXuWJ/s5zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=b+tZUZ+z; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741769436; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=engtjH+4oOTetCbrKzprqNB3Qeyy/20uT5y0hPLQubkXNuEEVS7ih62Wq0CQ6qUyj7P2yReenMJtH/1Gbg9SJVCp+SBhtaHYSgcTCbkh+eTC2Yp74eQKzRJUL8CIL5RSY58EQYFp1V5iRG2pkZl2EQoGQxzWBU+sRbIOqnAB5sQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741769436; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QVG2FtRBMTG+cJ043EMPTuCPvQ/jhcqS1OYGZW0kD/0=; 
	b=mm/fx6v6dhHbvdW0bEF26H0/H+PIxrqbKFGD+Y7PjvAPsvTuScRt1fuT0nyuQlT7msz0StTFwey4w/nB3Uh89DFJKXVaBEEg0fVqhtXQssDI1HehhHJekB58o3nuZNyAC7W5dBplkEbSwNjRhkzoBwZZZtA1wuIhAHdkqhtSb5Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741769436;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=QVG2FtRBMTG+cJ043EMPTuCPvQ/jhcqS1OYGZW0kD/0=;
	b=b+tZUZ+zwpXb3CWLogH0CEKWY3br+qY03Eyg3oUcX5LqeeTHOKQ1rEDmDwJtTf2/
	zF77bcvgS3MI2IJovLOIEIyWUz/yqa+JkNEg6vE1n8MYqXnJWoEwWfH+HAc6NJaNK70
	N4eSQVUjTE2gZF2n/UL3eUHmDxUmBYfbE6qGsRkc=
Received: by mx.zohomail.com with SMTPS id 1741769434055669.9288245847308;
	Wed, 12 Mar 2025 01:50:34 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id BB58D180692; Wed, 12 Mar 2025 09:50:27 +0100 (CET)
Date: Wed, 12 Mar 2025 09:50:27 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] power: supply: Add support for Maxim MAX8971
 charger
Message-ID: <axqbrwdkkuztwrz67hke2nwqgz2ifpedpypas7nuohohzlzkt4@i4d2np6vclwb>
References: <20250310080237.7400-1-clamor95@gmail.com>
 <20250310080237.7400-3-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jw3aewlmxahdtsur"
Content-Disposition: inline
In-Reply-To: <20250310080237.7400-3-clamor95@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/241.705.14
X-ZohoMailClient: External


--jw3aewlmxahdtsur
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/2] power: supply: Add support for Maxim MAX8971
 charger
MIME-Version: 1.0

Hi,

I have a couple of comments inline.

On Mon, Mar 10, 2025 at 10:02:37AM +0200, Svyatoslav Ryhel wrote:
> The MAX8971 is a compact, high-frequency, high-efficiency switch-mode
> charger for a one-cell lithium-ion (Li+) battery.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
> diff --git a/drivers/power/supply/max8971_charger.c b/drivers/power/suppl=
y/max8971_charger.c
> new file mode 100644
> index 000000000000..a271b1570e05
> --- /dev/null
> +++ b/drivers/power/supply/max8971_charger.c
> @@ -0,0 +1,759 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <linux/devm-helpers.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/extcon.h>
> +#include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/of_graph.h>
> +#include <linux/property.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/pm.h>
> +#include <linux/power_supply.h>
> +#include <linux/regmap.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +
> +#define MAX8971_REG_CHGINT		0x0f
> +#define   MAX8971_REG_CHG_RST		BIT(0)
> +#define MAX8971_REG_CHGINT_MASK		0x01
> +#define   MAX8971_AICL_MASK		BIT(7)
> +#define MAX8971_REG_CHG_STAT		0x02
> +#define   MAX8971_CHG_MASK		BIT(3)
> +#define MAX8971_REG_DETAILS1		0x03
> +#define MAX8971_REG_DETAILS2		0x04
> +#define MAX8971_REG_CHGCNTL1		0x05
> +#define MAX8971_REG_FCHGCRNT		0x06
> +#define MAX8971_REG_DCCRNT		0x07
> +#define   MAX8971_CHGRSTRT_MASK		BIT(6)
> +#define MAX8971_REG_TOPOFF		0x08
> +#define MAX8971_REG_TEMPREG		0x09
> +#define MAX8971_REG_PROTCMD		0x0a
> +#define   MAX8971_CHGPROT_LOCKED	0x00
> +#define   MAX8971_CHGPROT_UNLOCKED	0x03
> +
> +#define MAX8971_FCHGT_DEFAULT		2
> +#define MAX8971_TOPOFFT_DEFAULT		3
> +
> +static const char *max8971_manufacturer	=3D "Maxim Integrated";
> +static const char *max8971_model	=3D "MAX8971";
> +
> +enum max8971_charging_state {
> +	MAX8971_CHARGING_DEAD_BATTERY,
> +	MAX8971_CHARGING_PREQUALIFICATION,
> +	MAX8971_CHARGING_FAST_CONST_CURRENT,
> +	MAX8971_CHARGING_FAST_CONST_VOLTAGE,
> +	MAX8971_CHARGING_TOP_OFF,
> +	MAX8971_CHARGING_DONE,
> +	MAX8971_CHARGING_TIMER_FAULT,
> +	MAX8971_CHARGING_SUSPENDED_THERMAL,
> +	MAX8971_CHARGING_OFF,
> +	MAX8971_CHARGING_THERMAL_LOOP,
> +};
> +
> +enum max8971_health_state {
> +	MAX8971_HEALTH_UNKNOWN,
> +	MAX8971_HEALTH_COLD,
> +	MAX8971_HEALTH_COOL,
> +	MAX8971_HEALTH_WARM,
> +	MAX8971_HEALTH_HOT,
> +	MAX8971_HEALTH_OVERHEAT,
> +};
> +
> +/* Fast-Charge current limit, 250..1550 mA, 50 mA steps */
> +#define MAX8971_CHG_CC_STEP			  50000U
> +#define MAX8971_CHG_CC_MIN			 250000U
> +#define MAX8971_CHG_CC_MAX			1550000U
> +
> +/* Input current limit, 250..1500 mA, 25 mA steps */
> +#define MAX8971_DCILMT_STEP			  25000U
> +#define MAX8971_DCILMT_MIN			 250000U
> +#define MAX8971_DCILMT_MAX			1500000U
> +
> +enum max8971_field_idx {
> +	THM_DTLS,		/* DETAILS1 */
> +	BAT_DTLS, CHG_DTLS,	/* DETAILS2 */
> +	CHG_CC, FCHG_T,		/* FCHGCRNT */
> +	DCI_LMT,		/* DCCRNT */
> +	TOPOFF_T, TOPOFF_S,	/* TOPOFF */
> +	CPROT,			/* PROTCMD */
> +	MAX8971_N_REGMAP_FIELDS
> +};
> +
> +static const struct reg_field max8971_reg_field[MAX8971_N_REGMAP_FIELDS]=
 =3D {
> +	[THM_DTLS] =3D REG_FIELD(MAX8971_REG_DETAILS1, 0, 2),
> +	[BAT_DTLS] =3D REG_FIELD(MAX8971_REG_DETAILS2, 4, 5),
> +	[CHG_DTLS] =3D REG_FIELD(MAX8971_REG_DETAILS2, 0, 3),
> +	[CHG_CC]   =3D REG_FIELD(MAX8971_REG_FCHGCRNT, 0, 4),
> +	[FCHG_T]   =3D REG_FIELD(MAX8971_REG_FCHGCRNT, 5, 7),
> +	[DCI_LMT]  =3D REG_FIELD(MAX8971_REG_DCCRNT,   0, 5),
> +	[TOPOFF_T] =3D REG_FIELD(MAX8971_REG_TOPOFF,   5, 7),
> +	[TOPOFF_S] =3D REG_FIELD(MAX8971_REG_TOPOFF,   2, 3),
> +	[CPROT]    =3D REG_FIELD(MAX8971_REG_PROTCMD,  2, 3),
> +};
> +
> +static const struct regmap_config max8971_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.max_register =3D MAX8971_REG_CHGINT,
> +};
> +
> +struct max8971_data {
> +	struct i2c_client *client;

This is never read and can be dropped.

> +	struct device *dev;
> +	struct power_supply *psy_mains;
> +
> +	struct extcon_dev *edev;
> +	struct notifier_block extcon_nb;
> +	struct delayed_work extcon_work;
> +
> +	struct regmap *regmap;
> +	struct regmap_field *rfield[MAX8971_N_REGMAP_FIELDS];
> +
> +	enum power_supply_usb_type usb_type;
> +
> +	u32 fchgt;
> +	u32 tofft;
> +	u32 toffs;
> +
> +	bool present;
> +};
> +
> +static int max8971_get_status(struct max8971_data *priv, int *val)
> +{
> +	u32 regval;
> +	int err;
> +
> +	err =3D regmap_field_read(priv->rfield[CHG_DTLS], &regval);
> +	if (err)
> +		return err;
> +
> +	switch (regval) {
> +	case MAX8971_CHARGING_DEAD_BATTERY:
> +	case MAX8971_CHARGING_PREQUALIFICATION:
> +	case MAX8971_CHARGING_FAST_CONST_CURRENT:
> +	case MAX8971_CHARGING_FAST_CONST_VOLTAGE:
> +	case MAX8971_CHARGING_TOP_OFF:
> +	case MAX8971_CHARGING_THERMAL_LOOP:
> +		*val =3D POWER_SUPPLY_STATUS_CHARGING;
> +		break;
> +	case MAX8971_CHARGING_DONE:
> +		*val =3D POWER_SUPPLY_STATUS_FULL;
> +		break;
> +	case MAX8971_CHARGING_TIMER_FAULT:
> +		*val =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		break;
> +	case MAX8971_CHARGING_OFF:
> +	case MAX8971_CHARGING_SUSPENDED_THERMAL:
> +		*val =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +		break;
> +	default:
> +		*val =3D POWER_SUPPLY_STATUS_UNKNOWN;
> +	}
> +
> +	return 0;
> +}
> +
> +static int max8971_get_charge_type(struct max8971_data *priv, int *val)
> +{
> +	u32 regval;
> +	int err;
> +
> +	err =3D regmap_field_read(priv->rfield[CHG_DTLS], &regval);
> +	if (err)
> +		return err;
> +
> +	switch (regval) {
> +	case MAX8971_CHARGING_DEAD_BATTERY:
> +	case MAX8971_CHARGING_PREQUALIFICATION:
> +		*val =3D POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
> +		break;
> +	case MAX8971_CHARGING_FAST_CONST_CURRENT:
> +	case MAX8971_CHARGING_FAST_CONST_VOLTAGE:
> +		*val =3D POWER_SUPPLY_CHARGE_TYPE_FAST;
> +		break;
> +	case MAX8971_CHARGING_TOP_OFF:
> +	case MAX8971_CHARGING_THERMAL_LOOP:
> +		*val =3D POWER_SUPPLY_CHARGE_TYPE_STANDARD;
> +		break;
> +	case MAX8971_CHARGING_DONE:
> +	case MAX8971_CHARGING_TIMER_FAULT:
> +	case MAX8971_CHARGING_SUSPENDED_THERMAL:
> +	case MAX8971_CHARGING_OFF:
> +		*val =3D POWER_SUPPLY_CHARGE_TYPE_NONE;
> +		break;
> +	default:
> +		*val =3D POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
> +	}
> +
> +	return 0;
> +}
> +
> +static int max8971_get_health(struct max8971_data *priv, int *val)
> +{
> +	u32 regval;
> +	int err;
> +
> +	err =3D regmap_field_read(priv->rfield[THM_DTLS], &regval);
> +	if (err)
> +		return err;
> +
> +	switch (regval) {
> +	case MAX8971_HEALTH_COLD:
> +		*val =3D POWER_SUPPLY_HEALTH_COLD;
> +		break;
> +	case MAX8971_HEALTH_COOL:
> +		*val =3D POWER_SUPPLY_HEALTH_COOL;
> +		break;
> +	case MAX8971_HEALTH_WARM:
> +		*val =3D POWER_SUPPLY_HEALTH_GOOD;
> +		break;
> +	case MAX8971_HEALTH_HOT:
> +		*val =3D POWER_SUPPLY_HEALTH_HOT;
> +		break;
> +	case MAX8971_HEALTH_OVERHEAT:
> +		*val =3D POWER_SUPPLY_HEALTH_OVERHEAT;
> +		break;
> +	case MAX8971_HEALTH_UNKNOWN:
> +	default:
> +		*val =3D POWER_SUPPLY_HEALTH_UNKNOWN;
> +	}

I guess it makes sense to report POWER_SUPPLY_HEALTH_DEAD
for MAX8971_CHARGING_DEAD_BATTERY?

> +
> +	return 0;
> +}
> +
> +static int max8971_get_online(struct max8971_data *priv, int *val)
> +{
> +	u32 regval;
> +	int err;
> +
> +	err =3D regmap_read(priv->regmap, MAX8971_REG_CHG_STAT, &regval);
> +	if (err)
> +		return err;
> +
> +	if (priv->present)
> +		/* CHG_OK bit is 0 when charger is online */
> +		*val =3D !(regval & MAX8971_CHG_MASK);
> +	else
> +		*val =3D priv->present;
> +
> +	return 0;
> +}
> +
> +static int max8971_get_integer(struct max8971_data *priv, enum max8971_f=
ield_idx fidx,
> +			       u32 clamp_min, u32 clamp_max, u32 mult, int *val)
> +{
> +	u32 regval;
> +	int err;
> +
> +	err =3D regmap_field_read(priv->rfield[fidx], &regval);
> +	if (err)
> +		return err;
> +
> +	*val =3D clamp_val(regval * mult, clamp_min, clamp_max);
> +
> +	return 0;
> +}
> +
> +static int max8971_set_integer(struct max8971_data *priv, enum max8971_f=
ield_idx fidx,
> +			       u32 clamp_min, u32 clamp_max, u32 div, int val)
> +{
> +	u32 regval;
> +
> +	regval =3D clamp_val(val, clamp_min, clamp_max) / div;
> +
> +	return regmap_field_write(priv->rfield[fidx], regval);
> +}
> +
> +static int max8971_get_property(struct power_supply *psy, enum power_sup=
ply_property psp,
> +				union power_supply_propval *val)
> +{
> +	struct max8971_data *priv =3D power_supply_get_drvdata(psy);
> +	int err =3D 0;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		err =3D max8971_get_status(priv, &val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +		err =3D max8971_get_charge_type(priv, &val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_USB_TYPE:
> +		val->intval =3D priv->usb_type;
> +		break;
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		err =3D max8971_get_health(priv, &val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		err =3D max8971_get_online(priv, &val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		val->intval =3D priv->present;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX:
> +		val->intval =3D MAX8971_CHG_CC_MAX;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
> +		err =3D max8971_get_integer(priv, CHG_CC, MAX8971_CHG_CC_MIN, MAX8971_=
CHG_CC_MAX,
> +					  MAX8971_CHG_CC_STEP, &val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		err =3D max8971_get_integer(priv, DCI_LMT, MAX8971_DCILMT_MIN, MAX8971=
_DCILMT_MAX,
> +					  MAX8971_DCILMT_STEP, &val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_MODEL_NAME:
> +		val->strval =3D max8971_model;
> +		break;
> +	case POWER_SUPPLY_PROP_MANUFACTURER:
> +		val->strval =3D max8971_manufacturer;
> +		break;
> +	default:
> +		err =3D -EINVAL;
> +	}
> +
> +	return err;
> +}
> +
> +static int max8971_set_property(struct power_supply *psy, enum power_sup=
ply_property psp,
> +				const union power_supply_propval *val)
> +{
> +	struct max8971_data *priv =3D power_supply_get_drvdata(psy);
> +	int err =3D 0;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
> +		err =3D max8971_set_integer(priv, CHG_CC, MAX8971_CHG_CC_MIN, MAX8971_=
CHG_CC_MAX,
> +					  MAX8971_CHG_CC_STEP, val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		err =3D max8971_set_integer(priv, DCI_LMT, MAX8971_DCILMT_MIN, MAX8971=
_DCILMT_MAX,
> +					  MAX8971_DCILMT_STEP, val->intval);
> +		break;
> +	default:
> +		err =3D -EINVAL;
> +	}
> +
> +	return err;
> +};
> +
> +static int max8971_property_is_writeable(struct power_supply *psy,
> +					 enum power_supply_property psp)
> +{
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static enum power_supply_property max8971_properties[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_CHARGE_TYPE,
> +	POWER_SUPPLY_PROP_USB_TYPE,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT,
> +	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
> +	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +	POWER_SUPPLY_PROP_MODEL_NAME,
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +};
> +
> +static const struct power_supply_desc max8971_charger_desc =3D {
> +	.name =3D "charger",
> +	.type =3D POWER_SUPPLY_TYPE_USB,
> +	.usb_types =3D BIT(POWER_SUPPLY_USB_TYPE_UNKNOWN) |
> +		     BIT(POWER_SUPPLY_USB_TYPE_SDP) |
> +		     BIT(POWER_SUPPLY_USB_TYPE_DCP) |
> +		     BIT(POWER_SUPPLY_USB_TYPE_CDP) |
> +		     BIT(POWER_SUPPLY_USB_TYPE_ACA),
> +	.properties =3D max8971_properties,
> +	.num_properties =3D ARRAY_SIZE(max8971_properties),
> +	.get_property =3D max8971_get_property,
> +	.set_property =3D max8971_set_property,
> +	.property_is_writeable =3D max8971_property_is_writeable,
> +};
> +
> +static void max8971_update_config(struct max8971_data *priv)
> +{
> +	regmap_field_write(priv->rfield[CPROT], MAX8971_CHGPROT_UNLOCKED);
> +
> +	if (priv->fchgt !=3D MAX8971_FCHGT_DEFAULT)
> +		regmap_field_write(priv->rfield[FCHG_T], priv->fchgt);
> +
> +	regmap_write_bits(priv->regmap, MAX8971_REG_DCCRNT, MAX8971_CHGRSTRT_MA=
SK,
> +			  MAX8971_CHGRSTRT_MASK);
> +
> +	if (priv->tofft !=3D MAX8971_TOPOFFT_DEFAULT)
> +		regmap_field_write(priv->rfield[TOPOFF_T], priv->tofft);
> +
> +	if (priv->toffs)
> +		regmap_field_write(priv->rfield[TOPOFF_S], priv->toffs);
> +
> +	regmap_field_write(priv->rfield[CPROT], MAX8971_CHGPROT_LOCKED);
> +}
> +
> +static ssize_t fast_charge_timer_show(struct device *dev, struct device_=
attribute *attr,
> +				      char *buf)
> +{
> +	struct max8971_data *priv =3D dev_get_drvdata(dev);
> +	u32 regval;
> +	int err;
> +
> +	err =3D regmap_field_read(priv->rfield[FCHG_T], &regval);
> +	if (err)
> +		return err;
> +
> +	switch (regval) {
> +	case 0x1 ... 0x7:
> +		/* Time if off by 3 hours comparing to value */
> +		regval +=3D 3;
> +		break;
> +	case 0x0:
> +	default:
> +		regval =3D 0;
> +		break;
> +	}
> +
> +	return sysfs_emit(buf, "%u\n", regval);
> +}
> +
> +static ssize_t fast_charge_timer_store(struct device *dev, struct device=
_attribute *attr,
> +				       const char *buf, size_t count)
> +{
> +	struct max8971_data *priv =3D dev_get_drvdata(dev);
> +	unsigned long hours;
> +	int val, err;
> +
> +	err =3D kstrtoul(buf, 10, &hours);
> +	if (err)
> +		return err;
> +
> +	val =3D hours - 3;
> +	if (val <=3D 0 || val > 7)
> +		priv->fchgt =3D 0;
> +	else
> +		priv->fchgt =3D val;
> +
> +	max8971_update_config(priv);
> +
> +	return count;
> +}
> +
> +static ssize_t top_off_threshold_current_show(struct device *dev,
> +					      struct device_attribute *attr,
> +					      char *buf)
> +{
> +	struct max8971_data *priv =3D dev_get_drvdata(dev);
> +	u32 regval, val;
> +	int err;
> +
> +	err =3D regmap_field_read(priv->rfield[TOPOFF_S], &regval);
> +	if (err)
> +		return err;
> +
> +	/* 50uA start with 50uA step */
> +	val =3D regval * 50 + 50;
> +	val *=3D 1000;
> +
> +	return sysfs_emit(buf, "%u\n", val);
> +}
> +
> +static ssize_t top_off_threshold_current_store(struct device *dev,
> +					       struct device_attribute *attr,
> +					       const char *buf, size_t count)
> +{
> +	struct max8971_data *priv =3D dev_get_drvdata(dev);
> +	unsigned long uamp;
> +	int err;
> +
> +	err =3D kstrtoul(buf, 10, &uamp);
> +	if (err)
> +		return err;
> +
> +	if (uamp < 50000 || uamp > 200000)
> +		return -EINVAL;
> +
> +	priv->toffs =3D uamp / 50000 - 1;
> +
> +	max8971_update_config(priv);
> +
> +	return count;
> +}
> +
> +static ssize_t top_off_timer_show(struct device *dev, struct device_attr=
ibute *attr,
> +				  char *buf)
> +{
> +	struct max8971_data *priv =3D dev_get_drvdata(dev);
> +	u32 regval;
> +	int err;
> +
> +	err =3D regmap_field_read(priv->rfield[TOPOFF_T], &regval);
> +	if (err)
> +		return err;
> +
> +	/* 10 min intervals */
> +	regval *=3D 10;
> +
> +	return sysfs_emit(buf, "%u\n", regval);
> +}
> +
> +static ssize_t top_off_timer_store(struct device *dev, struct device_att=
ribute *attr,
> +				   const char *buf, size_t count)
> +{
> +	struct max8971_data *priv =3D dev_get_drvdata(dev);
> +	unsigned long minutes;
> +	int err;
> +
> +	err =3D kstrtoul(buf, 10, &minutes);
> +	if (err)
> +		return err;
> +
> +	if (minutes > 70)
> +		return -EINVAL;
> +
> +	priv->tofft =3D minutes / 10;
> +
> +	max8971_update_config(priv);
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(fast_charge_timer);
> +static DEVICE_ATTR_RW(top_off_threshold_current);
> +static DEVICE_ATTR_RW(top_off_timer);
> +
> +static struct attribute *max8971_attributes[] =3D {
> +	&dev_attr_fast_charge_timer.attr,
> +	&dev_attr_top_off_threshold_current.attr,
> +	&dev_attr_top_off_timer.attr,
> +	NULL
> +};

Missing ABI documentation. Also wondering if we can instead just
configure sensible values without exposing them to userspace. For
debugging things there is always the regmap debugfs API.

> +static const struct attribute_group max8971_attr_group =3D {
> +	.attrs =3D max8971_attributes,
> +};
> +
> +static void max8971_extcon_evt_worker(struct work_struct *work)
> +{
> +	struct max8971_data *priv =3D
> +		container_of(work, struct max8971_data, extcon_work.work);
> +	struct device *dev =3D priv->dev;
> +	struct extcon_dev *edev =3D priv->edev;
> +	u32 chgcc, dcilmt;
> +
> +	if (extcon_get_state(edev, EXTCON_CHG_USB_SDP) > 0) {
> +		dev_dbg(dev, "USB SDP charger is connected\n");
> +		priv->usb_type =3D POWER_SUPPLY_USB_TYPE_SDP;
> +		chgcc =3D 500000;
> +		dcilmt =3D 500000;
> +	} else if (extcon_get_state(edev, EXTCON_USB) > 0) {
> +		dev_dbg(dev, "USB charger is connected\n");
> +		priv->usb_type =3D POWER_SUPPLY_USB_TYPE_SDP;
> +		chgcc =3D 500000;
> +		dcilmt =3D 500000;
> +	} else if (extcon_get_state(edev, EXTCON_DISP_MHL) > 0) {
> +		dev_dbg(dev, "MHL plug is connected\n");
> +		priv->usb_type =3D POWER_SUPPLY_USB_TYPE_SDP;
> +		chgcc =3D 500000;
> +		dcilmt =3D 500000;
> +	} else if (extcon_get_state(edev, EXTCON_CHG_USB_DCP) > 0) {
> +		dev_dbg(dev, "USB DCP charger is connected\n");
> +		priv->usb_type =3D POWER_SUPPLY_USB_TYPE_DCP;
> +		chgcc =3D 900000;
> +		dcilmt =3D 1200000;
> +	} else if (extcon_get_state(edev, EXTCON_CHG_USB_FAST) > 0) {
> +		dev_dbg(dev, "USB FAST charger is connected\n");
> +		priv->usb_type =3D POWER_SUPPLY_USB_TYPE_ACA;
> +		chgcc =3D 900000;
> +		dcilmt =3D 1200000;
> +	} else if (extcon_get_state(edev, EXTCON_CHG_USB_SLOW) > 0) {
> +		dev_dbg(dev, "USB SLOW charger is connected\n");
> +		priv->usb_type =3D POWER_SUPPLY_USB_TYPE_ACA;
> +		chgcc =3D 900000;
> +		dcilmt =3D 1200000;
> +	} else if (extcon_get_state(edev, EXTCON_CHG_USB_CDP) > 0) {
> +		dev_dbg(dev, "USB CDP charger is connected\n");
> +		priv->usb_type =3D POWER_SUPPLY_USB_TYPE_CDP;
> +		chgcc =3D 900000;
> +		dcilmt =3D 1200000;
> +	} else {
> +		dev_dbg(dev, "USB state is unknown\n");
> +		priv->usb_type =3D POWER_SUPPLY_USB_TYPE_UNKNOWN;
> +		return;
> +	}
> +
> +	regmap_field_write(priv->rfield[CPROT], MAX8971_CHGPROT_UNLOCKED);
> +
> +	max8971_set_integer(priv, CHG_CC, MAX8971_CHG_CC_MIN, MAX8971_CHG_CC_MA=
X,
> +			    MAX8971_CHG_CC_STEP, chgcc);
> +	max8971_set_integer(priv, DCI_LMT, MAX8971_DCILMT_MIN, MAX8971_DCILMT_M=
AX,
> +			    MAX8971_DCILMT_STEP, dcilmt);
> +
> +	regmap_field_write(priv->rfield[CPROT], MAX8971_CHGPROT_LOCKED);
> +}
> +
> +static int extcon_get_charger_type(struct notifier_block *nb,
> +				   unsigned long state, void *data)
> +{
> +	struct max8971_data *priv =3D
> +		container_of(nb, struct max8971_data, extcon_nb);
> +	schedule_delayed_work(&priv->extcon_work, 0);
> +	return NOTIFY_OK;
> +}
> +
> +static irqreturn_t max8971_interrupt(int irq, void *dev_id)
> +{
> +	struct max8971_data *priv =3D dev_id;
> +	struct device *dev =3D priv->dev;
> +	int err, state;
> +
> +	err =3D regmap_read(priv->regmap, MAX8971_REG_CHGINT, &state);
> +	if (err)
> +		dev_err(dev, "interrupt reg read failed %d\n", err);
> +
> +	err =3D regmap_write_bits(priv->regmap, MAX8971_REG_CHGINT_MASK,
> +				MAX8971_AICL_MASK, MAX8971_AICL_MASK);
> +	if (err)
> +		dev_err(dev, "failed to mask IRQ\n");
> +
> +	/* set presence prop */
> +	priv->present =3D state & MAX8971_REG_CHG_RST;
> +
> +	/* on every plug chip resets to default */
> +	if (priv->present)
> +		max8971_update_config(priv);
> +
> +	/* update supply status */
> +	power_supply_changed(priv->psy_mains);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static char *max8971_supplied_to[] =3D {
> +	"battery",
> +};

This should not be needed for a DT based platform.

> +static int max8971_probe(struct i2c_client *client)
> +{
> +	struct device *dev =3D &client->dev;
> +	struct max8971_data *priv;
> +	struct device_node *connector, *extcon;
> +	struct power_supply_config cfg =3D { };
> +	int err, i;
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->client =3D client;
> +	priv->dev =3D dev;
> +	priv->usb_type =3D POWER_SUPPLY_USB_TYPE_UNKNOWN;
> +
> +	i2c_set_clientdata(client, priv);
> +
> +	priv->regmap =3D devm_regmap_init_i2c(client, &max8971_regmap_config);
> +	if (IS_ERR(priv->regmap))
> +		return dev_err_probe(dev, PTR_ERR(priv->regmap), "cannot allocate regm=
ap\n");
> +
> +	for (i =3D 0; i < MAX8971_N_REGMAP_FIELDS; i++) {
> +		priv->rfield[i] =3D devm_regmap_field_alloc(dev, priv->regmap, max8971=
_reg_field[i]);
> +		if (IS_ERR(priv->rfield[i]))
> +			return dev_err_probe(dev, PTR_ERR(priv->rfield[i]),
> +					     "cannot allocate regmap field\n");
> +	}
> +
> +	cfg.of_node =3D dev->of_node;

cfg.fwnode =3D dev_fwnode(dev);

> +	cfg.drv_data =3D priv;
> +	cfg.supplied_to =3D max8971_supplied_to;
> +	cfg.num_supplicants =3D ARRAY_SIZE(max8971_supplied_to);
> +
> +	priv->psy_mains =3D devm_power_supply_register(dev, &max8971_charger_de=
sc, &cfg);
> +	if (IS_ERR(priv->psy_mains))
> +		return dev_err_probe(dev, PTR_ERR(priv->psy_mains),
> +				     "failed to register mains supply\n");
> +
> +	err =3D regmap_write_bits(priv->regmap, MAX8971_REG_CHGINT_MASK, MAX897=
1_AICL_MASK,
> +				MAX8971_AICL_MASK);
> +	if (err)
> +		return dev_err_probe(dev, err, "failed to mask IRQ\n");
> +
> +	err =3D devm_device_add_group(dev, &max8971_attr_group);
> +	if (err)
> +		return dev_err_probe(dev, err, "failed to create sysfs attributes\n");

Iff we need the custom properties they should be at least registered
automatically at device creation time via 'cfg.attr_grp'.

> +	err =3D devm_request_threaded_irq(dev, client->irq, NULL, &max8971_inte=
rrupt,
> +					IRQF_ONESHOT | IRQF_SHARED, client->name, priv);
> +	if (err)
> +		return dev_err_probe(dev, err, "failed to register IRQ %d\n", client->=
irq);
> +
> +	/* Extcon support is not vital for the charger to work */

The comment is a bit missleading, because the current code seems to
make extcon support mandatory as far as I can tell.

> +	connector =3D of_parse_phandle(dev->of_node, "maxim,usb-connector", 0);
> +	extcon =3D of_get_parent(connector);
> +	of_node_put(connector);
> +
> +	priv->edev =3D extcon_find_edev_by_node(extcon);
> +	of_node_put(extcon);
> +	if (IS_ERR(priv->edev))
> +		return 0;
> +
> +	err =3D devm_delayed_work_autocancel(dev, &priv->extcon_work,
> +					   max8971_extcon_evt_worker);
> +	if (err)
> +		return dev_err_probe(dev, err, "failed to add extcon evt stop action\n=
");
> +
> +	priv->extcon_nb.notifier_call =3D extcon_get_charger_type;
> +
> +	err =3D devm_extcon_register_notifier_all(dev, priv->edev, &priv->extco=
n_nb);
> +	if (err)
> +		return dev_err_probe(dev, err, "failed to register notifier\n");
> +
> +	/* Initial configuration work with 1 sec delay */
> +	schedule_delayed_work(&priv->extcon_work, msecs_to_jiffies(1000));
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused max8971_resume(struct device *dev)
> +{
> +	struct i2c_client *client =3D to_i2c_client(dev);
> +	struct max8971_data *priv =3D i2c_get_clientdata(client);
> +
> +	irq_wake_thread(client->irq, priv);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(max8971_pm_ops, NULL, max8971_resume);
> +
> +static const struct of_device_id max8971_match_ids[] =3D {
> +	{ .compatible =3D "maxim,max8971" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, max8971_match_ids);
> +
> +static const struct i2c_device_id max8971_i2c_id[] =3D {
> +	{ "max8971" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, max8971_i2c_id);
> +
> +static struct i2c_driver max8971_driver =3D {
> +	.driver =3D {
> +		.name =3D "max8971-charger",
> +		.of_match_table =3D max8971_match_ids,
> +		.pm =3D &max8971_pm_ops,
> +	},
> +	.probe =3D max8971_probe,
> +	.id_table =3D max8971_i2c_id,
> +};
> +module_i2c_driver(max8971_driver);
> +
> +MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
> +MODULE_DESCRIPTION("MAX8971 Charger Driver");
> +MODULE_LICENSE("GPL");

Otherwise LGTM.

-- Sebastian

--jw3aewlmxahdtsur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmfRSs8ACgkQ2O7X88g7
+po0Sg//Q6nyoeL6ZFsJ/JiEYdZxOnxkyliz7Wh6n2Mfh52NyRTSTbQsDnXvaWHX
UJwPxl18D3zgXWcNZRKfgES64AQ73qiigwYWd+8uyLEBh9VCamLbsKpyhrxdhdaQ
NV39Qg1hjrzIZKOuIKpYKbwTjgealohkOMFXhovP3f2c+qt7k1CqOZqD5Yp6wRoz
FtIFdjU2eNVOZyV2MXVvxXLYDJmYVYTQgWOT5N9XvQANZMCkys2CldxK5wo3aTjm
+AbCha50BIxTuZPZ107+EK4Me2ZXFn9pvLnDHv1QNi0lRsDWSwSQTLUS1HLLg6pd
AgNY5i2uStjazj74yo3GwROtVS/BM2Ow59sNw42lJ/fsFIEyz1TEn2l/R678I5mh
jQT6xSyyBOd3qAokEZWgHkbgXR8BJpBKd7L8qzLYGdR1rncGeYp16BO9Mrxb0U8k
fAnkIT/tIamyU+xTluWmDJfT7vWroOilGc+gbCF4tevpj6raRfZzQeCv976eTD1O
hdulxqBuMXIa+CcvWlwwdLobtUSsswHRLYQ/uZcH/qZsI6Dc2pfroNo+bl4Deer9
x7oWv/mJADgaCI7Ht3O4xoEy+TALQfONzcrbqM5E5QlwWmpRpulHVd842Gv3DkjK
0ClYZEOXU4gQnPIl3hDkU1Gv4hcJ8JpRO3yxGHY5KJVJ3fEc+qY=
=aP/A
-----END PGP SIGNATURE-----

--jw3aewlmxahdtsur--

