Return-Path: <linux-pm+bounces-40776-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14093D1C18D
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 03:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62EF530206AD
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 02:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C842F363C;
	Wed, 14 Jan 2026 02:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="kmapE3p6"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA162BD031;
	Wed, 14 Jan 2026 02:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768356640; cv=pass; b=I/ufzkLIhK31F9PsZq79UaqHL+jMf+/QMly4v/EXY6CT3qkP1+J2F1ijxaEDa8bhRB2dqiizNd1fEuF9chQ3dTHfc0lrm6wnbexxI5BwQgJh4JL/vxeKUP++c8aHzq1N/Ah6Yc5FdLgDKf2VaRMPuPdxceOSJxHiE4Al1zza2O8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768356640; c=relaxed/simple;
	bh=O0Ivhw7woOsif25CljgIgjAw2R0wejDxI2D/ZOzQ5EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XB7ECEHWmjxVukueALQe9+8KrCSYvGGlkX0uhzQRZ33yntAgNDaOctXU+YaNfaUsx7IEMlaygT3AR4zrXcoYJy+3WYlmG7+Cn7E/wM8gvq7TJckekVkqN5pzgFkWOYCUQb1C12LL52Jb0KdMMe+YfhNf2ehU0gPGuvUNTIslPVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=kmapE3p6; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1768356611; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mDMIY06DWmBTF9JhhpUqmJoyXg2bmoXcADF+c9aJxaZr0JjXj1U76Se5MhDl+yiOvg1IGEcRjtaCGTcWauN5ZM3C1eUZSAi461d7R3JD7+rFYjU2G1YD/Uik5rhUhvn1b9tRRMmiTyYOu566fi1lkpJP6/NXJ4bdKVRHZkHQDEk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768356611; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QiVCVe1cYJIUAXAFkEAbbXGMpN8JJSh7GbSj81AjfWc=; 
	b=mXlPXhsMlVqfGEENpr6LhMd+mW6Fr6wb5yWmS8sOvDSlnYlyt7PBXLrj8JgpoOFf3y47pkTOq8b0qaDwvnikm59bWFgmBSjM+wwW3uA0yGLsH4982Ho0gPB1U4S05To/lCsBxMrVdahmOQ+tFEmQ+108FrDW69Xu+qHvf1h7hJc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768356611;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=QiVCVe1cYJIUAXAFkEAbbXGMpN8JJSh7GbSj81AjfWc=;
	b=kmapE3p6njHPtGK/VVaW1tgLc/nhMEJjGj7MEdrbLQUATqfO4sIB6QATsPlevyxE
	QCrIb+q2Io3u2ctGo1Y3L9fUTCK68qafh52v/3l+c4KCru2OzCcrOfK5MMLViZ0HuZB
	I6sRw/Z28GvLyCqLY5sUfrGkg65Drt5suHOj56Q8=
Received: by mx.zohomail.com with SMTPS id 176835660886387.39151167560578;
	Tue, 13 Jan 2026 18:10:08 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id DD8B8181010; Wed, 14 Jan 2026 03:10:03 +0100 (CET)
Date: Wed, 14 Jan 2026 03:10:03 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: michael.reeves077@gmail.com
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Neal Gompa <neal@gompa.dev>, Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 1/2] power: supply: Add macsmc-power driver for Apple
 Silicon
Message-ID: <aWbq2pgTJlOWC07w@venus>
References: <20260109-b4-macsmc-power-v2-0-93818f1e7d62@gmail.com>
 <20260109-b4-macsmc-power-v2-1-93818f1e7d62@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tbmaaos5ehfdpxta"
Content-Disposition: inline
In-Reply-To: <20260109-b4-macsmc-power-v2-1-93818f1e7d62@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.5.1/268.349.40
X-ZohoMailClient: External


--tbmaaos5ehfdpxta
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/2] power: supply: Add macsmc-power driver for Apple
 Silicon
MIME-Version: 1.0

Hi,

On Fri, Jan 09, 2026 at 12:18:48AM +1100, Michael Reeves via B4 Relay wrote:
> From: Michael Reeves <michael.reeves077@gmail.com>
>=20
> This driver provides battery and AC status monitoring for Apple Silicon
> Macs via the SMC (System Management Controller). It supports
> reporting capacity, voltage, current, and charging status.
>=20
> Co-developed-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
> ---
>  MAINTAINERS                         |   1 +
>  drivers/power/supply/Kconfig        |  11 +
>  drivers/power/supply/Makefile       |   1 +
>  drivers/power/supply/macsmc-power.c | 883 ++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 896 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0dbf349fc1ed..c18da2295477 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2507,6 +2507,7 @@ F:	drivers/nvmem/apple-efuses.c
>  F:	drivers/nvmem/apple-spmi-nvmem.c
>  F:	drivers/pinctrl/pinctrl-apple-gpio.c
>  F:	drivers/power/reset/macsmc-reboot.c
> +F:	drivers/power/supply/macsmc-power.c
>  F:	drivers/pwm/pwm-apple.c
>  F:	drivers/rtc/rtc-macsmc.c
>  F:	drivers/soc/apple/*
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 92f9f7aae92f..3a5b7d9234c2 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -1132,4 +1132,15 @@ config FUEL_GAUGE_MM8013
>  	  the state of charge, temperature, cycle count, actual and design
>  	  capacity, etc.
> =20
> +config MACSMC_POWER
> +	tristate "Apple SMC Battery and Power Driver"
> +	depends on MFD_MACSMC
> +	help
> +	  This driver provides support for the battery and AC adapter on
> +	  Apple Silicon machines. It exposes battery telemetry (voltage,
> +	  current, health) and AC adapter status through the standard Linux
> +	  power supply framework.
> +
> +	  Say Y or M here if you have an Apple Silicon based Mac.
> +
>  endif # POWER_SUPPLY
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 4b79d5abc49a..d14420b606d8 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -128,3 +128,4 @@ obj-$(CONFIG_CHARGER_SURFACE)	+=3D surface_charger.o
>  obj-$(CONFIG_BATTERY_UG3105)	+=3D ug3105_battery.o
>  obj-$(CONFIG_CHARGER_QCOM_SMB2)	+=3D qcom_smbx.o
>  obj-$(CONFIG_FUEL_GAUGE_MM8013)	+=3D mm8013.o
> +obj-$(CONFIG_MACSMC_POWER)	+=3D macsmc-power.o
> diff --git a/drivers/power/supply/macsmc-power.c b/drivers/power/supply/m=
acsmc-power.c
> new file mode 100644
> index 000000000000..4ff90da73fa0
> --- /dev/null
> +++ b/drivers/power/supply/macsmc-power.c
> @@ -0,0 +1,883 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Apple SMC Power/Battery Management Driver
> + *
> + * This driver exposes battery telemetry (voltage, current, temperature,=
 health)
> + * and AC adapter status provided by the Apple SMC (System Management Co=
ntroller)
> + * on Apple Silicon systems.
> + *
> + * Copyright The Asahi Linux Contributors
> + */
> +
> +#include <linux/ctype.h>
> +#include <linux/delay.h>
> +#include <linux/limits.h>
> +#include <linux/module.h>
> +#include <linux/mfd/macsmc.h>
> +#include <linux/notifier.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/reboot.h>
> +#include <linux/workqueue.h>
> +
> +#define MAX_STRING_LENGTH 256
> +
> +/*
> + * The SMC reports charge in mAh (Coulombs) but energy in mWh (Joules).
> + * We lack a register for "Nominal Voltage" or "Energy Accumulator".
> + * We use a fixed 3.8V/cell constant to approximate energy stats for use=
rspace,
> + * derived from empirical data across supported MacBook models.
> + */
> +#define MACSMC_NOMINAL_CELL_VOLTAGE_MV 3800
> +
> +/* SMC Key Flags */
> +#define CHNC_BATTERY_FULL	BIT(0)
> +#define CHNC_NO_CHARGER		BIT(7)
> +#define CHNC_NOCHG_CH0C		BIT(14)
> +#define CHNC_NOCHG_CH0B_CH0K	BIT(15)
> +#define CHNC_BATTERY_FULL_2	BIT(18)
> +#define CHNC_BMS_BUSY		BIT(23)
> +#define CHNC_CHLS_LIMIT		BIT(24)
> +#define CHNC_NOAC_CH0J		BIT(53)
> +#define CHNC_NOAC_CH0I		BIT(54)
> +
> +#define CH0R_LOWER_FLAGS	GENMASK(15, 0)
> +#define CH0R_NOAC_CH0I		BIT(0)
> +#define CH0R_NOAC_DISCONNECTED	BIT(4)
> +#define CH0R_NOAC_CH0J		BIT(5)
> +#define CH0R_BMS_BUSY		BIT(8)
> +#define CH0R_NOAC_CH0K		BIT(9)
> +#define CH0R_NOAC_CHWA		BIT(11)
> +
> +#define CH0X_CH0C		BIT(0)
> +#define CH0X_CH0B		BIT(1)
> +
> +#define ACSt_CAN_BOOT_AP	BIT(2)
> +#define ACSt_CAN_BOOT_IBOOT	BIT(1)
> +
> +#define CHWA_CHLS_FIXED_START_OFFSET	5
> +#define CHLS_MIN_END_THRESHOLD		10
> +#define CHLS_FORCE_DISCHARGE		0x100
> +#define CHWA_FIXED_END_THRESHOLD	80
> +#define CHWA_PROP_WRITE_THRESHOLD	95
> +
> +#define MACSMC_MAX_BATT_PROPS		50
> +#define MACSMC_MAX_AC_PROPS		10
> +
> +struct macsmc_power {
> +	struct device *dev;
> +	struct apple_smc *smc;
> +
> +	struct power_supply_desc ac_desc;
> +	struct power_supply_desc batt_desc;
> +
> +	enum power_supply_property *ac_props;
> +	enum power_supply_property *batt_props;
> +
> +	struct power_supply *batt;
> +	struct power_supply *ac;
> +
> +	char model_name[MAX_STRING_LENGTH];
> +	char serial_number[MAX_STRING_LENGTH];
> +	char mfg_date[MAX_STRING_LENGTH];
> +
> +	bool has_chwa;
> +	bool has_chls;
> +	bool has_ch0i;
> +	bool has_ch0c;
> +	bool has_chte;
> +
> +	u8 num_cells;
> +	int nominal_voltage_mv;
> +
> +	struct notifier_block nb;
> +	struct work_struct critical_work;
> +	bool shutdown_started;
> +};
> +
> +static int macsmc_battery_get_status(struct macsmc_power *power)
> +{
> +	u64 nocharge_flags;
> +	u32 nopower_flags;
> +	u16 ac_current;
> +	int charge_limit =3D 0;
> +	bool limited =3D false;
> +	bool flag;
> +	int ret;
> +
> +	/*
> +	 * Fallbacks exist for keys that may disappear in future hardware.
> +	 * CHCE/CHCC/BSFC/CHSC are considered fundamental; absence is an error.
> +	 */
> +
> +	/* Check if power input is inhibited (e.g. BMS balancing cycle) */
> +	ret =3D apple_smc_read_u32(power->smc, SMC_KEY(CH0R), &nopower_flags);
> +	if (!ret && (nopower_flags & CH0R_LOWER_FLAGS & ~CH0R_BMS_BUSY))
> +		return POWER_SUPPLY_STATUS_DISCHARGING;
> +
> +	/* Check if charger is present */
> +	ret =3D apple_smc_read_flag(power->smc, SMC_KEY(CHCE), &flag);
> +	if (ret < 0)
> +		return ret;
> +	if (!flag)
> +		return POWER_SUPPLY_STATUS_DISCHARGING;
> +
> +	/* Check if AC is charge capable */
> +	ret =3D apple_smc_read_flag(power->smc, SMC_KEY(CHCC), &flag);
> +	if (ret < 0)
> +		return ret;
> +	if (!flag)
> +		return POWER_SUPPLY_STATUS_DISCHARGING;
> +
> +	/* Check if AC input limit is too low */
> +	ret =3D apple_smc_read_u16(power->smc, SMC_KEY(AC-i), &ac_current);
> +	if (!ret && ac_current < 100)
> +		return POWER_SUPPLY_STATUS_DISCHARGING;
> +
> +	/* Check if battery is full */
> +	ret =3D apple_smc_read_flag(power->smc, SMC_KEY(BSFC), &flag);
> +	if (ret < 0)
> +		return ret;
> +	if (flag)
> +		return POWER_SUPPLY_STATUS_FULL;
> +
> +	/* Check for user-defined charge limits */
> +	if (power->has_chls) {
> +		u16 vu16;
> +
> +		ret =3D apple_smc_read_u16(power->smc, SMC_KEY(CHLS), &vu16);
> +		if (ret =3D=3D 0 && (vu16 & 0xff) >=3D CHLS_MIN_END_THRESHOLD)
> +			charge_limit =3D (vu16 & 0xff) - CHWA_CHLS_FIXED_START_OFFSET;
> +	} else if (power->has_chwa) {
> +		ret =3D apple_smc_read_flag(power->smc, SMC_KEY(CHWA), &flag);
> +		if (ret =3D=3D 0 && flag)
> +			charge_limit =3D CHWA_FIXED_END_THRESHOLD - CHWA_CHLS_FIXED_START_OFF=
SET;
> +	}
> +
> +	if (charge_limit > 0) {
> +		u8 buic =3D 0;
> +
> +		if (apple_smc_read_u8(power->smc, SMC_KEY(BUIC), &buic) >=3D 0 &&
> +		    buic >=3D charge_limit)
> +			limited =3D true;
> +	}
> +
> +	/* Check charging inhibitors */
> +	ret =3D apple_smc_read_u64(power->smc, SMC_KEY(CHNC), &nocharge_flags);
> +	if (!ret) {
> +		if (nocharge_flags & CHNC_BATTERY_FULL)
> +			return POWER_SUPPLY_STATUS_FULL;
> +		/* BMS busy shows up as inhibit, but we treat it as charging */
> +		else if (nocharge_flags =3D=3D CHNC_BMS_BUSY && !limited)
> +			return POWER_SUPPLY_STATUS_CHARGING;
> +		else if (nocharge_flags)
> +			return POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		else
> +			return POWER_SUPPLY_STATUS_CHARGING;
> +	}
> +
> +	/* Fallback: System charging flag */
> +	ret =3D apple_smc_read_flag(power->smc, SMC_KEY(CHSC), &flag);
> +	if (ret < 0)
> +		return ret;
> +	if (!flag)
> +		return POWER_SUPPLY_STATUS_NOT_CHARGING;
> +
> +	return POWER_SUPPLY_STATUS_CHARGING;
> +}
> +
> +static int macsmc_battery_get_charge_behaviour(struct macsmc_power *powe=
r)
> +{
> +	int ret;
> +	u8 val8;
> +	u8 chte_buf[4];
> +
> +	if (power->has_ch0i) {
> +		ret =3D apple_smc_read_u8(power->smc, SMC_KEY(CH0I), &val8);
> +		if (ret)
> +			return ret;
> +		if (val8 & CH0R_NOAC_CH0I)
> +			return POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE;
> +	}
> +
> +	if (power->has_chte) {
> +		ret =3D apple_smc_read(power->smc, SMC_KEY(CHTE), chte_buf, 4);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (chte_buf[0] =3D=3D 0x01)
> +			return POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
> +	} else if (power->has_ch0c) {
> +		ret =3D apple_smc_read_u8(power->smc, SMC_KEY(CH0C), &val8);
> +		if (ret)
> +			return ret;
> +		if (val8 & CH0X_CH0C)
> +			return POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
> +	}
> +
> +	return POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
> +}
> +
> +static int macsmc_battery_set_charge_behaviour(struct macsmc_power *powe=
r, int val)
> +{
> +	int ret;
> +
> +	/* First, reset all inhibitors to a known-good 'auto' state */
> +	if (power->has_ch0i) {
> +		ret =3D apple_smc_write_u8(power->smc, SMC_KEY(CH0I), 0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (power->has_chte) {
> +		ret =3D apple_smc_write_u32(power->smc, SMC_KEY(CHTE), 0);
> +		if (ret)
> +			return ret;
> +	} else if (power->has_ch0c) {
> +		ret =3D apple_smc_write_u8(power->smc, SMC_KEY(CH0C), 0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	switch (val) {
> +	case POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO:
> +		return 0;
> +
> +	case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE:
> +		if (power->has_chte)
> +			return apple_smc_write_u32(power->smc, SMC_KEY(CHTE), 1);
> +		else if (power->has_ch0c)
> +			return apple_smc_write_u8(power->smc, SMC_KEY(CH0C), 1);
> +		else
> +			return -EOPNOTSUPP;
> +	break;

Indentation?

> +
> +	case POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE:
> +		if (!power->has_ch0i)
> +			return -EOPNOTSUPP;
> +	return apple_smc_write_u8(power->smc, SMC_KEY(CH0I), 1);

Indentation?

> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int macsmc_battery_get_date(const char *s, int *out)
> +{
> +	if (!isdigit(s[0]) || !isdigit(s[1]))
> +		return -EOPNOTSUPP;
> +
> +	*out =3D (s[0] - '0') * 10 + s[1] - '0';
> +	return 0;
> +}
> +
> +static int macsmc_battery_get_capacity_level(struct macsmc_power *power)
> +{
> +	bool flag;
> +	u32 val;
> +	int ret;
> +
> +	/* Check for emergency shutdown condition */
> +	if (apple_smc_read_u32(power->smc, SMC_KEY(BCF0), &val) >=3D 0 && val)
> +		return POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
> +
> +	/* Check AC status for whether we could boot in this state */
> +	if (apple_smc_read_u32(power->smc, SMC_KEY(ACSt), &val) >=3D 0) {
> +		if (!(val & ACSt_CAN_BOOT_IBOOT))
> +			return POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
> +
> +		if (!(val & ACSt_CAN_BOOT_AP))
> +			return POWER_SUPPLY_CAPACITY_LEVEL_LOW;
> +	}
> +
> +	ret =3D apple_smc_read_flag(power->smc, SMC_KEY(BSFC), &flag);
> +	if (ret < 0)
> +		return POWER_SUPPLY_CAPACITY_LEVEL_UNKNOWN;
> +
> +	if (flag)
> +		return POWER_SUPPLY_CAPACITY_LEVEL_FULL;
> +	else
> +		return POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
> +}
> +
> +static int macsmc_battery_get_property(struct power_supply *psy,
> +				       enum power_supply_property psp,
> +				       union power_supply_propval *val)
> +{
> +	struct macsmc_power *power =3D power_supply_get_drvdata(psy);
> +	int ret =3D 0;
> +	u8 vu8;
> +	u16 vu16;
> +	s16 vs16;
> +	s32 vs32;
> +	s64 vs64;
> +	bool flag;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		val->intval =3D macsmc_battery_get_status(power);
> +		ret =3D val->intval < 0 ? val->intval : 0;
> +		break;
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		val->intval =3D 1;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> +		val->intval =3D macsmc_battery_get_charge_behaviour(power);
> +		ret =3D val->intval < 0 ? val->intval : 0;
> +		break;
> +	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
> +		ret =3D apple_smc_read_u16(power->smc, SMC_KEY(B0TE), &vu16);
> +		val->intval =3D vu16 =3D=3D 0xffff ? 0 : vu16 * 60;
> +		break;
> +	case POWER_SUPPLY_PROP_TIME_TO_FULL_NOW:
> +		ret =3D apple_smc_read_u16(power->smc, SMC_KEY(B0TF), &vu16);
> +		val->intval =3D vu16 =3D=3D 0xffff ? 0 : vu16 * 60;
> +		break;
> +	case POWER_SUPPLY_PROP_CAPACITY:
> +		ret =3D apple_smc_read_u8(power->smc, SMC_KEY(BUIC), &vu8);
> +		val->intval =3D vu8;
> +		break;
> +	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
> +		val->intval =3D macsmc_battery_get_capacity_level(power);
> +		ret =3D val->intval < 0 ? val->intval : 0;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		ret =3D apple_smc_read_u16(power->smc, SMC_KEY(B0AV), &vu16);
> +		val->intval =3D vu16 * 1000;
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		ret =3D apple_smc_read_s16(power->smc, SMC_KEY(B0AC), &vs16);
> +		val->intval =3D vs16 * 1000;
> +		break;
> +	case POWER_SUPPLY_PROP_POWER_NOW:
> +		ret =3D apple_smc_read_s32(power->smc, SMC_KEY(B0AP), &vs32);
> +		val->intval =3D vs32 * 1000;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
> +		ret =3D apple_smc_read_u16(power->smc, SMC_KEY(BITV), &vu16);
> +		val->intval =3D vu16 * 1000;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> +		/* Calculate total max design voltage from per-cell nominal voltage */

Using the nominal voltage here doesn't make much sense. As the
comment above mentions not having nominal voltage data for the
battery, I suppose the comment is wrong and this uses the per-cell
**maximum** voltage?

> +		ret =3D apple_smc_read_u16(power->smc, SMC_KEY(BVVN), &vu16);
> +		val->intval =3D vu16 * 1000 * power->num_cells;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> +		/* Lifetime min */
> +		ret =3D apple_smc_read_s16(power->smc, SMC_KEY(BLPM), &vs16);
> +		val->intval =3D vs16 * 1000;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
> +		/* Lifetime max */
> +		ret =3D apple_smc_read_s16(power->smc, SMC_KEY(BLPX), &vs16);
> +		val->intval =3D vs16 * 1000;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
> +		ret =3D apple_smc_read_u16(power->smc, SMC_KEY(B0RC), &vu16);
> +		val->intval =3D vu16 * 1000;
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> +		ret =3D apple_smc_read_u16(power->smc, SMC_KEY(B0RI), &vu16);
> +		val->intval =3D vu16 * 1000;
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> +		ret =3D apple_smc_read_u16(power->smc, SMC_KEY(B0RV), &vu16);
> +		val->intval =3D vu16 * 1000;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> +		ret =3D apple_smc_read_u16(power->smc, SMC_KEY(B0DC), &vu16);
> +		val->intval =3D vu16 * 1000;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_FULL:
> +		ret =3D apple_smc_read_u16(power->smc, SMC_KEY(B0FC), &vu16);
> +		val->intval =3D vu16 * 1000;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_NOW:
> +		ret =3D apple_smc_read_u16(power->smc, SMC_KEY(B0RM), &vu16);
> +		/* B0RM is Big Endian, likely pass through from TI gas gauge */
> +		val->intval =3D (s16)swab16(vu16) * 1000;
> +		break;
> +	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
> +		ret =3D apple_smc_read_u16(power->smc, SMC_KEY(B0DC), &vu16);
> +		val->intval =3D vu16 * power->nominal_voltage_mv;
> +		break;
> +	case POWER_SUPPLY_PROP_ENERGY_FULL:
> +		ret =3D apple_smc_read_u16(power->smc, SMC_KEY(B0FC), &vu16);
> +		val->intval =3D vu16 * power->nominal_voltage_mv;
> +		break;
> +	case POWER_SUPPLY_PROP_ENERGY_NOW:
> +		ret =3D apple_smc_read_u16(power->smc, SMC_KEY(B0RM), &vu16);
> +		/* B0RM is Big Endian, likely pass through from TI gas gauge */
> +		val->intval =3D (s16)swab16(vu16) * power->nominal_voltage_mv;
> +		break;
> +	case POWER_SUPPLY_PROP_TEMP:
> +		ret =3D apple_smc_read_u16(power->smc, SMC_KEY(B0AT), &vu16);
> +		val->intval =3D vu16 - 2732; /* Kelvin x10 to Celsius x10 */
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
> +		ret =3D apple_smc_read_s64(power->smc, SMC_KEY(BAAC), &vs64);
> +		val->intval =3D vs64;
> +		break;
> +	case POWER_SUPPLY_PROP_CYCLE_COUNT:
> +		ret =3D apple_smc_read_u16(power->smc, SMC_KEY(B0CT), &vu16);
> +		val->intval =3D vu16;
> +		break;
> +	case POWER_SUPPLY_PROP_SCOPE:
> +		val->intval =3D POWER_SUPPLY_SCOPE_SYSTEM;
> +		break;
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		flag =3D false;
> +		ret =3D apple_smc_read_flag(power->smc, SMC_KEY(BBAD), &flag);
> +		val->intval =3D flag ? POWER_SUPPLY_HEALTH_DEAD : POWER_SUPPLY_HEALTH_=
GOOD;
> +		break;
> +	case POWER_SUPPLY_PROP_MODEL_NAME:
> +		val->strval =3D power->model_name;
> +		break;
> +	case POWER_SUPPLY_PROP_SERIAL_NUMBER:
> +		val->strval =3D power->serial_number;
> +		break;
> +	case POWER_SUPPLY_PROP_MANUFACTURE_YEAR:
> +		ret =3D macsmc_battery_get_date(&power->mfg_date[0], &val->intval);
> +		/* The SMC reports the manufacture year as an offset from 1992. */
> +		val->intval +=3D 1992;
> +		break;
> +	case POWER_SUPPLY_PROP_MANUFACTURE_MONTH:
> +		ret =3D macsmc_battery_get_date(&power->mfg_date[2], &val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_MANUFACTURE_DAY:
> +		ret =3D macsmc_battery_get_date(&power->mfg_date[4], &val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD:
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
> +		if (power->has_chls) {
> +			ret =3D apple_smc_read_u16(power->smc, SMC_KEY(CHLS), &vu16);
> +			val->intval =3D vu16 & 0xff;
> +			if (val->intval < CHLS_MIN_END_THRESHOLD || val->intval >=3D 100)
> +				val->intval =3D 100;
> +		} else if (power->has_chwa) {
> +			flag =3D false;
> +			ret =3D apple_smc_read_flag(power->smc, SMC_KEY(CHWA), &flag);
> +			val->intval =3D flag ? CHWA_FIXED_END_THRESHOLD : 100;
> +		} else {
> +			return -EINVAL;
> +		}
> +		if (psp =3D=3D POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD &&
> +		    ret >=3D 0 && val->intval < 100 && val->intval >=3D CHLS_MIN_END_T=
HRESHOLD)
> +			val->intval -=3D CHWA_CHLS_FIXED_START_OFFSET;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int macsmc_battery_set_property(struct power_supply *psy,
> +				       enum power_supply_property psp,
> +				       const union power_supply_propval *val)
> +{
> +	struct macsmc_power *power =3D power_supply_get_drvdata(psy);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> +		return macsmc_battery_set_charge_behaviour(power, val->intval);
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD:
> +		/*
> +		 * Read-only reflection of end threshold logic.
> +		 * Allowed to be written to avoid userspace confusion, but ignored.
> +		 */
> +		return 0;

I think it's better to fix userspace and expose the value read-only.
In any case this creates an ABI and requires proper documentation in
Documentation/ABI/testing/sysfs-class-power. My suggestion would be
to drop this for now and handle it in a separate patchset, so that
ABI discussion don't block the remaining driver.

> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
> +		if (power->has_chls) {
> +			u16 kval =3D 0;
> +			/* Configurable logic for future expansion */
> +			if (val->intval < CHLS_MIN_END_THRESHOLD)
> +				kval =3D CHLS_FORCE_DISCHARGE | CHLS_MIN_END_THRESHOLD;
> +			else if (val->intval < 100)
> +				kval =3D CHLS_FORCE_DISCHARGE | (val->intval & 0xff);
> +
> +			return apple_smc_write_u16(power->smc, SMC_KEY(CHLS), kval);
> +		} else if (power->has_chwa) {
> +			return apple_smc_write_flag(power->smc, SMC_KEY(CHWA),
> +						    val->intval <=3D CHWA_PROP_WRITE_THRESHOLD);
> +		} else {
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int macsmc_battery_property_is_writeable(struct power_supply *psy,
> +						enum power_supply_property psp)
> +{
> +	struct macsmc_power *power =3D power_supply_get_drvdata(psy);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> +		return true;
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD:
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
> +		return power->has_chwa || power->has_chls;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static const struct power_supply_desc macsmc_battery_desc_template =3D {
> +	.name			=3D "macsmc-battery",
> +	.type			=3D POWER_SUPPLY_TYPE_BATTERY,
> +	.get_property		=3D macsmc_battery_get_property,
> +	.set_property		=3D macsmc_battery_set_property,
> +	.property_is_writeable	=3D macsmc_battery_property_is_writeable,
> +};
> +
> +static int macsmc_ac_get_property(struct power_supply *psy,
> +				  enum power_supply_property psp,
> +				  union power_supply_propval *val)
> +{
> +	struct macsmc_power *power =3D power_supply_get_drvdata(psy);
> +	int ret =3D 0;
> +	u16 vu16;
> +	u32 vu32;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		ret =3D apple_smc_read_u32(power->smc, SMC_KEY(CHIS), &vu32);
> +		val->intval =3D !!vu32;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		ret =3D apple_smc_read_u16(power->smc, SMC_KEY(AC-n), &vu16);
> +		val->intval =3D vu16 * 1000;
> +		break;
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		ret =3D apple_smc_read_u16(power->smc, SMC_KEY(AC-i), &vu16);
> +		val->intval =3D vu16 * 1000;
> +		break;
> +	case POWER_SUPPLY_PROP_INPUT_POWER_LIMIT:
> +		ret =3D apple_smc_read_u32(power->smc, SMC_KEY(ACPW), &vu32);
> +		val->intval =3D vu32 * 1000;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct power_supply_desc macsmc_ac_desc_template =3D {
> +	.name			=3D "macsmc-ac",
> +	.type			=3D POWER_SUPPLY_TYPE_MAINS,
> +	.get_property		=3D macsmc_ac_get_property,
> +};
> +
> +static void macsmc_power_critical_work(struct work_struct *wrk)
> +{
> +	struct macsmc_power *power =3D container_of(wrk, struct macsmc_power, c=
ritical_work);
> +	u16 bitv, b0av;
> +	u32 bcf0;
> +
> +	if (!power->batt)
> +		return;
> +
> +	/*
> +	 * EMERGENCY: Check voltage vs design minimum.
> +	 * If we are below BITV, the battery is physically exhausted.
> +	 * We must shut down NOW to protect the filesystem.
> +	 */
> +	if (apple_smc_read_u16(power->smc, SMC_KEY(BITV), &bitv) >=3D 0 &&
> +	    apple_smc_read_u16(power->smc, SMC_KEY(B0AV), &b0av) >=3D 0 &&
> +	    b0av < bitv) {
> +		dev_emerg(power->dev,
> +			 "Battery voltage (%d mV) below design minimum (%d mV)! Emergency shu=
tdown.\n",
> +			 b0av, bitv);
> +		kernel_power_off();
> +		return;
> +	}
> +
> +	/*
> +	 * Avoid duplicate attempts at orderly shutdown.
> +	 * Voltage check is above this as we may want to
> +	 * "upgrade" an orderly shutdown to a critical power
> +	 * off if voltage drops.
> +	 */
> +	if (power->shutdown_started || system_state > SYSTEM_RUNNING)
> +		return;
> +
> +	/*
> +	 * Check if SMC flagged the battery as empty.
> +	 * We trigger a graceful shutdown to let the OS save data.
> +	 */
> +	if (apple_smc_read_u32(power->smc, SMC_KEY(BCF0), &bcf0) =3D=3D 0 && bc=
f0 !=3D 0) {
> +		power->shutdown_started =3D true;
> +		dev_crit(power->dev, "Battery critical (empty flag set). Triggering or=
derly shutdown.\n");
> +		orderly_poweroff(true);
> +	}
> +}
> +
> +static int macsmc_power_event(struct notifier_block *nb, unsigned long e=
vent, void *data)
> +{
> +	struct macsmc_power *power =3D container_of(nb, struct macsmc_power, nb=
);
> +
> +	/*
> +	 * SMC Event IDs are reverse-engineered.
> +	 * 0x71... indicates power/battery events.
> +	 */
> +	if ((event & 0xffffff00) =3D=3D 0x71010100 || /* Charger status change =
*/
> +	    (event & 0xffff0000) =3D=3D 0x71060000 || /* Port charge state chan=
ge */
> +	    (event & 0xffff0000) =3D=3D 0x71130000) { /* Connector insert/remov=
e event */
> +		if (power->batt)
> +			power_supply_changed(power->batt);
> +		if (power->ac)
> +			power_supply_changed(power->ac);
> +		return NOTIFY_OK;
> +	} else if (event =3D=3D 0x71020000) {
> +		/* Critical battery warning */
> +		if (power->batt)
> +			schedule_work(&power->critical_work);
> +		return NOTIFY_OK;
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int macsmc_power_probe(struct platform_device *pdev)
> +{
> +	struct apple_smc *smc =3D dev_get_drvdata(pdev->dev.parent);

You have a bunch of &pdev->dev further ahead, so I think it's
sensible to create 'struct dev =3D &pdev->dev;' and use it everywhere
in the probe function.

> +	struct power_supply_config psy_cfg =3D {};
> +	struct macsmc_power *power;
> +	bool has_battery =3D false;
> +	bool has_ac_adapter =3D false;
> +	int ret;
> +	bool flag;
> +	u16 vu16;
> +	u32 val32;
> +	enum power_supply_property *props;
> +	size_t nprops;
> +
> +	if (!smc)
> +		return -ENODEV;
> +
> +	power =3D devm_kzalloc(&pdev->dev, sizeof(*power), GFP_KERNEL);
> +	if (!power)
> +		return -ENOMEM;
> +
> +	power->dev =3D &pdev->dev;
> +	power->smc =3D smc;
> +	dev_set_drvdata(&pdev->dev, power);
> +
> +	/*
> +	 * Check for battery presence.
> +	 * B0AV is a fundamental key.
> +	 */
> +	if (apple_smc_read_u16(power->smc, SMC_KEY(B0AV), &vu16) =3D=3D 0 &&
> +	    macsmc_battery_get_status(power) > POWER_SUPPLY_STATUS_UNKNOWN)
> +		has_battery =3D true;
> +
> +	/*
> +	 * Check for AC adapter presence.
> +	 * CHIS is a fundamental key.
> +	 */
> +	if (apple_smc_key_exists(smc, SMC_KEY(CHIS)))
> +		has_ac_adapter =3D true;
> +
> +	if (has_battery) {
> +		power->batt_desc =3D macsmc_battery_desc_template;
> +		power->batt_props =3D devm_kcalloc(&pdev->dev, MACSMC_MAX_BATT_PROPS,
> +						 sizeof(enum power_supply_property),
> +						 GFP_KERNEL);
> +		if (!power->batt_props)
> +			return -ENOMEM;
> +
> +		props =3D power->batt_props;
> +		nprops =3D 0;
> +
> +		/* Fundamental properties */
> +		props[nprops++] =3D POWER_SUPPLY_PROP_STATUS;
> +		props[nprops++] =3D POWER_SUPPLY_PROP_PRESENT;
> +		props[nprops++] =3D POWER_SUPPLY_PROP_VOLTAGE_NOW;
> +		props[nprops++] =3D POWER_SUPPLY_PROP_CURRENT_NOW;
> +		props[nprops++] =3D POWER_SUPPLY_PROP_POWER_NOW;
> +		props[nprops++] =3D POWER_SUPPLY_PROP_CAPACITY;
> +		props[nprops++] =3D POWER_SUPPLY_PROP_CAPACITY_LEVEL;
> +		props[nprops++] =3D POWER_SUPPLY_PROP_TEMP;
> +		props[nprops++] =3D POWER_SUPPLY_PROP_CYCLE_COUNT;
> +		props[nprops++] =3D POWER_SUPPLY_PROP_HEALTH;
> +		props[nprops++] =3D POWER_SUPPLY_PROP_SCOPE;
> +		props[nprops++] =3D POWER_SUPPLY_PROP_MODEL_NAME;
> +		props[nprops++] =3D POWER_SUPPLY_PROP_SERIAL_NUMBER;
> +		props[nprops++] =3D POWER_SUPPLY_PROP_MANUFACTURE_YEAR;
> +		props[nprops++] =3D POWER_SUPPLY_PROP_MANUFACTURE_MONTH;
> +		props[nprops++] =3D POWER_SUPPLY_PROP_MANUFACTURE_DAY;
> +
> +		/* Extended properties usually present */
> +		props[nprops++] =3D POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW;
> +		props[nprops++] =3D POWER_SUPPLY_PROP_TIME_TO_FULL_NOW;
> +		props[nprops++] =3D POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN;
> +		props[nprops++] =3D POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN;
> +		props[nprops++] =3D POWER_SUPPLY_PROP_VOLTAGE_MIN;
> +		props[nprops++] =3D POWER_SUPPLY_PROP_VOLTAGE_MAX;
> +		props[nprops++] =3D POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT;
> +		props[nprops++] =3D POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX;
> +		props[nprops++] =3D POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE;
> +		props[nprops++] =3D POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN;
> +		props[nprops++] =3D POWER_SUPPLY_PROP_CHARGE_FULL;
> +		props[nprops++] =3D POWER_SUPPLY_PROP_CHARGE_NOW;
> +		props[nprops++] =3D POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN;
> +		props[nprops++] =3D POWER_SUPPLY_PROP_ENERGY_FULL;
> +		props[nprops++] =3D POWER_SUPPLY_PROP_ENERGY_NOW;
> +		props[nprops++] =3D POWER_SUPPLY_PROP_CHARGE_COUNTER;
> +
> +		/* Detect features based on key availability */
> +		if (apple_smc_key_exists(smc, SMC_KEY(CHTE)))
> +			power->has_chte =3D true;
> +		if (apple_smc_key_exists(smc, SMC_KEY(CH0C)))
> +			power->has_ch0c =3D true;
> +		if (apple_smc_key_exists(smc, SMC_KEY(CH0I)))
> +			power->has_ch0i =3D true;
> +
> +		/* Reset "Optimised Battery Charging" flags to default state */
> +		if (power->has_chte)
> +			apple_smc_write_u32(smc, SMC_KEY(CHTE), 0);
> +		else if (power->has_ch0c)
> +			apple_smc_write_u8(smc, SMC_KEY(CH0C), 0);
> +
> +		if (power->has_ch0i)
> +			apple_smc_write_u8(smc, SMC_KEY(CH0I), 0);
> +
> +		apple_smc_write_u8(smc, SMC_KEY(CH0K), 0);
> +		apple_smc_write_u8(smc, SMC_KEY(CH0B), 0);
> +
> +		/* Configure charge behaviour if supported */
> +		if (power->has_ch0i || power->has_ch0c || power->has_chte) {
> +			props[nprops++] =3D POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR;
> +
> +			power->batt_desc.charge_behaviours =3D
> +				BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO);
> +
> +			if (power->has_ch0i)
> +				power->batt_desc.charge_behaviours |=3D
> +					BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE);
> +
> +			if (power->has_chte || power->has_ch0c)
> +				power->batt_desc.charge_behaviours |=3D
> +					BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE);
> +		}
> +
> +		/* Detect charge limit method (CHWA vs CHLS) */
> +		if (apple_smc_read_flag(power->smc, SMC_KEY(CHWA), &flag) =3D=3D 0)
> +			power->has_chwa =3D true;
> +		else if (apple_smc_read_u16(power->smc, SMC_KEY(CHLS), &vu16) >=3D 0)
> +			power->has_chls =3D true;
> +
> +		if (power->has_chwa || power->has_chls) {
> +			props[nprops++] =3D POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD;
> +			props[nprops++] =3D POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD;
> +		}
> +
> +		power->batt_desc.properties =3D power->batt_props;

It seems 'power->batt_props' is not used anywhere and you can just
use 'power->batt_desc.properties' directly?

> +		power->batt_desc.num_properties =3D nprops;
> +
> +		/* Fetch identity strings */
> +		apple_smc_read(smc, SMC_KEY(BMDN), power->model_name,
> +			       sizeof(power->model_name) - 1);
> +		apple_smc_read(smc, SMC_KEY(BMSN), power->serial_number,
> +			       sizeof(power->serial_number) - 1);
> +		apple_smc_read(smc, SMC_KEY(BMDT), power->mfg_date,
> +			       sizeof(power->mfg_date) - 1);
> +
> +		apple_smc_read_u8(power->smc, SMC_KEY(BNCB), &power->num_cells);
> +		power->nominal_voltage_mv =3D MACSMC_NOMINAL_CELL_VOLTAGE_MV * power->=
num_cells;
> +
> +		/* Enable critical shutdown notifications by reading status once */
> +		apple_smc_read_u32(power->smc, SMC_KEY(BCF0), &val32);
> +
> +		psy_cfg.drv_data =3D power;
> +		power->batt =3D devm_power_supply_register(&pdev->dev, &power->batt_de=
sc, &psy_cfg);
> +		if (IS_ERR(power->batt)) {
> +			ret =3D dev_err_probe(&pdev->dev, PTR_ERR(power->batt),
> +					    "Failed to register battery\n");

No need to assign ret; it is unused. But it becomes necessary with
a follow-up suggestion from me.

> +			/* Don't return failure yet; try AC registration first */
> +			power->batt =3D NULL;
> +		}
> +	} else {
> +		dev_dbg(&pdev->dev, "No battery detected.\n");
> +	}
> +
> +	if (has_ac_adapter) {
> +		power->ac_desc =3D macsmc_ac_desc_template;
> +		power->ac_props =3D devm_kcalloc(&pdev->dev, MACSMC_MAX_AC_PROPS,
> +					       sizeof(enum power_supply_property),
> +					       GFP_KERNEL);
> +		if (!power->ac_props)
> +			return -ENOMEM;
> +
> +		props =3D power->ac_props;
> +		nprops =3D 0;
> +
> +		/* Online status is fundamental */
> +		props[nprops++] =3D POWER_SUPPLY_PROP_ONLINE;
> +
> +		/* Input power limits are usually available */
> +		if (apple_smc_key_exists(power->smc, SMC_KEY(ACPW)))
> +			props[nprops++] =3D POWER_SUPPLY_PROP_INPUT_POWER_LIMIT;
> +
> +		/* macOS 15.4+ firmware dropped legacy AC keys (AC-n, AC-i) */
> +		if (apple_smc_read_u16(power->smc, SMC_KEY(AC-n), &vu16) >=3D 0) {
> +			props[nprops++] =3D POWER_SUPPLY_PROP_VOLTAGE_NOW;
> +			props[nprops++] =3D POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT;
> +		}
> +
> +		power->ac_desc.properties =3D power->ac_props;

Just like 'power->batt_props': You can drop power->ac_props and use
power->ac_desc.properties directly.

> +		power->ac_desc.num_properties =3D nprops;
> +
> +		psy_cfg.drv_data =3D power;
> +		power->ac =3D devm_power_supply_register(&pdev->dev, &power->ac_desc, =
&psy_cfg);
> +		if (IS_ERR(power->ac)) {
> +			ret =3D dev_err_probe(&pdev->dev, PTR_ERR(power->ac),
> +					    "Failed to register AC adapter\n");
> +			/* If battery also failed or didn't exist, this is a fatal error */
> +			if (!power->batt)
> +				return ret;

You can just drop this check and instead rely on the "Final check"

> +			power->ac =3D NULL;
> +		}
> +	} else {
> +		dev_dbg(&pdev->dev, "No A/C adapter detected.\n");
> +	}
> +
> +	/* Final check: did we register anything? */
> +	if (!power->batt && !power->ac)
> +		return -ENODEV;

You can just return ret here, if you assign -ENODEV as initial
value. In that case the correct error code will be returned in all
cases.

> +	power->nb.notifier_call =3D macsmc_power_event;
> +	blocking_notifier_chain_register(&smc->event_handlers, &power->nb);
> +
> +	INIT_WORK(&power->critical_work, macsmc_power_critical_work);

This must happen before registering the event handler, which in
theory might instant-trigger an event creating a race condition. You
already have the correct order in the remove handler (which also
hints about this problem :)). After reordering you can further
simplify by just using devm_work_autocancel().

> +
> +	return 0;
> +}
> +
> +static void macsmc_power_remove(struct platform_device *pdev)
> +{
> +	struct macsmc_power *power =3D dev_get_drvdata(&pdev->dev);
> +
> +	blocking_notifier_chain_unregister(&power->smc->event_handlers, &power-=
>nb);
> +	cancel_work_sync(&power->critical_work);
> +}
> +
> +static struct platform_driver macsmc_power_driver =3D {
> +	.driver =3D {
> +		.name =3D "macsmc-power",
> +		.owner =3D THIS_MODULE,

There is no need to set platform_driver.driver.owner manually. It is
handled automatically, so please drop.

> +	},
> +	.probe =3D macsmc_power_probe,
> +	.remove =3D macsmc_power_remove,
> +};
> +module_platform_driver(macsmc_power_driver);
> +
> +MODULE_LICENSE("Dual MIT/GPL");
> +MODULE_DESCRIPTION("Apple SMC battery and power management driver");
> +MODULE_AUTHOR("Hector Martin <marcan@marcan.st>");
> +MODULE_AUTHOR("Michael Reeves <michael.reeves077@gmail.com>");
> +MODULE_ALIAS("platform:macsmc-power");

Drop MODULE_ALIAS and instead add a platform_device_id table with
MODULE_DEVICE_TABLE(platform, <NAME>);

Greetings,

-- Sebastian

--tbmaaos5ehfdpxta
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmlm+vYACgkQ2O7X88g7
+ppx4A//TAmDIhdmGXZnuTjGy2TQBqByQS72QwmooPRQJbAaoliyT60A9VZtuHar
V7H9wT6Ro8YqMaZbgdYx+1u8V9LlMBPJ7RrX4Ar4XqeXjhxngMlHAc3e5z+odcQy
mDM+SKJYbizAi6qwI3Foqsg4Ym4speg1HqjIvSMMgB78zY3arq5JqJDFemq6Ying
7V8142bQr29LeSnPophZRbMZQxRGg8gk9vtNKHn1G2fq0FFpK2Zli2eAL0sXgPLc
zRhOOR5jp9MdDWx8K8pEkiPUGaRzg43wYqMp0SsCobT3uQO8h7dFrai/0vbdep6T
k1ASpn71t5Fp5mzUvcqMzbhp7I6rpL5QOddirO+6kqy09V9Ebu/bc6b5IqpUyYzP
n139H65+q5WapkVKvL3SIxrzmSxjY0lsQoeL5IAx3jHxZNSxABO5OIl6XgmVIMNa
5r0laepMAXQ4P3BXs3t3ejOEJkb/ooeB4J1JaWZ9iEOEufM0rrWbMsgzSDNcH/FC
UpERJsEOkDHzIzNVtlEON0PqncHUh9diME8/tWltSnATWR3y112Rz9YIxbPUonSl
Tv8OE12USf6712v+yymN2Cs0bP5OgdhVB/eBaFXpzXUvptuclp+zR8PIhYlR6AI1
HUZv+ZcRbzB7bONVcHj86xRufRS4mCU8QA/RkHySHjOc9gyPNp0=
=ECr/
-----END PGP SIGNATURE-----

--tbmaaos5ehfdpxta--

