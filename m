Return-Path: <linux-pm+bounces-40617-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD35D1034E
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 01:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3143E302DC88
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 00:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420661FDE31;
	Mon, 12 Jan 2026 00:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="P/bSBqVa"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E9C1CEAC2;
	Mon, 12 Jan 2026 00:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768179152; cv=pass; b=u3+NyLNQN2aYVemLgyBifpsQ586kmP2zCGg3KNkYMvMSUuBYAd9hDt/MWD6ihLOEBcHfHPSf6E5g5+ZvmdynkIRDqkvKORmScLjb7QDyXJFRjb7BPbX234bgjdI44dx5h0LJCO1z6OwL1cnGOEvC7MwwISyCcr2itIFNpyeCI1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768179152; c=relaxed/simple;
	bh=oWBVK7l9x3k6zpio7nrMrcliKiJhs1Yz+q30cG0idtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btVbXopmy6zw6Gv06GHWnte/qzGgWblEcN62MEFfWDjXYy5JtpqQRx/tJNRuPfC3uX+tfyZZx4nAg3MD9OLaL9c8ucErBhBS4I02cgyHST8F0Ad04aMAbXFF2bBmkzOZ5j64BkRlqdoA2OHpIuByqjT2W8car+BVUHiFz1Hry54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=P/bSBqVa; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1768179127; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WH1xMxn0iAP1xZIZ70uxErdBKtwD92A9Y7Pnj2laSryFS0hB3ZPRwi3X5110GhnQ3z1sYUHU8JBioGvY2WjmgP8H6LerYiLlVw4K6tkMLvgytjE/PXcwfQw0Ge8z16zCooHIx1xEQJJ4dYjZegFVd4RvFsTaO3KQRiz6z/I9j4M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768179127; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WfXlKQPqUHzsBHcMT+9fjdyKgcq+24WGlCdTL+yqeQo=; 
	b=bMW9DdiMiUqPVMjeKjso+m1qcinzRvYlwJ/9vp+yRJV0Fs/k/5FlUcF0qmLzfTJJu/c/fdLMeZQ38sILCgZUSNWBnjuUqIvglILGahj0ak9eGH2044dHRh48NocFSLAb3RbgbFIo5pZUVYAiuIyNfOuBTPMV1o1wf4gYa4Z8I4U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768179127;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=WfXlKQPqUHzsBHcMT+9fjdyKgcq+24WGlCdTL+yqeQo=;
	b=P/bSBqVa2AT7wKoh0PvIFh//z1JFvAC0DWDFY20RI60zj7bsZdmy2ihh9FDGNh6F
	+kq/3Jte0Bt5b2bJedU1vTbtX9fY/7gLYjxUZgWMA4gJ0a5xfyjNykIksNPP6UKF679
	eRKlisEVlAoHDH/MGTziIwaLZW9JAxWwtERJ05LI=
Received: by mx.zohomail.com with SMTPS id 1768179125955407.2518422472714;
	Sun, 11 Jan 2026 16:52:05 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 273551803AD; Mon, 12 Jan 2026 01:51:58 +0100 (CET)
Date: Mon, 12 Jan 2026 01:51:58 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org, 
	Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH RESEND v6 16/17] power: supply: bd71828-power: Support
 ROHM BD72720
Message-ID: <aWRERf70jg-IzqIx@venus>
References: <cover.1765804226.git.mazziesaccount@gmail.com>
 <fb74c0cab3dfe534135d26dbbb9c66699678c2de.1765804226.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xkg36apyy363kayk"
Content-Disposition: inline
In-Reply-To: <fb74c0cab3dfe534135d26dbbb9c66699678c2de.1765804226.git.mazziesaccount@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.5.1/268.172.5
X-ZohoMailClient: External


--xkg36apyy363kayk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RESEND v6 16/17] power: supply: bd71828-power: Support
 ROHM BD72720
MIME-Version: 1.0

Hi,

On Mon, Dec 15, 2025 at 03:21:19PM +0200, Matti Vaittinen wrote:
> From: Matti Vaittinen <mazziesaccount@gmail.com>
>=20
> The ROHM BD72720 is a power management IC with a charger and coulomb
> counter block which is closely related to the charger / coulomb counter
> found from the BD71815, BD71828, BD71879 which are all supported by the
> bd71828-power driver. Due to the similarities it makes sense to support
> also the BD72720 with the same driver.
>=20
> Add basic support for the charger logic on ROHM BD72720.
>=20
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>=20
> ---
> Revision history:
>  v2 =3D> :
>  - No changes
>=20
>  RFCv1 =3D> v2:
>  - Support using 9-bit register addresses (offset of 0x100) with the
>    BD72720
>  - Simplify probe and IC data as we don't need two regmaps
>  - Drop two BD72720 specific functions as we no longer need different
>    regmap for it.
>=20
> Note: This patch depends on the series: "power: supply: add charger for
> BD71828" by Andreas:
> https://lore.kernel.org/all/20250918-bd71828-charger-v5-0-851164839c28@ke=
mnade.info/

That should be in v6.19?

> NOTE: Fuel-gauging is not supported. You can find an unmaintained
> downstream reference-driver with a fuel-gauge example from:
> https://github.com/RohmSemiconductor/Linux-Kernel-PMIC-Drivers/releases/t=
ag/bd72720-reference-driver-v1
> ---
>  drivers/power/supply/bd71828-power.c | 134 +++++++++++++++++++++++----
>  1 file changed, 116 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/power/supply/bd71828-power.c b/drivers/power/supply/=
bd71828-power.c
> index ce73c0f48397..438e220a9cb7 100644
> --- a/drivers/power/supply/bd71828-power.c
> +++ b/drivers/power/supply/bd71828-power.c
> @@ -5,6 +5,7 @@
>  #include <linux/kernel.h>
>  #include <linux/mfd/rohm-bd71815.h>
>  #include <linux/mfd/rohm-bd71828.h>
> +#include <linux/mfd/rohm-bd72720.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
> @@ -51,12 +52,14 @@ struct pwr_regs {
>  	unsigned int chg_state;
>  	unsigned int bat_temp;
>  	unsigned int dcin_stat;
> +	unsigned int dcin_online_mask;
>  	unsigned int dcin_collapse_limit;
>  	unsigned int chg_set1;
>  	unsigned int chg_en;
>  	unsigned int vbat_alm_limit_u;
>  	unsigned int conf;
>  	unsigned int vdcin;
> +	unsigned int vdcin_himask;
>  };
> =20
>  static const struct pwr_regs pwr_regs_bd71828 =3D {
> @@ -67,12 +70,14 @@ static const struct pwr_regs pwr_regs_bd71828 =3D {
>  	.chg_state =3D BD71828_REG_CHG_STATE,
>  	.bat_temp =3D BD71828_REG_BAT_TEMP,
>  	.dcin_stat =3D BD71828_REG_DCIN_STAT,
> +	.dcin_online_mask =3D BD7182x_MASK_DCIN_DET,
>  	.dcin_collapse_limit =3D BD71828_REG_DCIN_CLPS,
>  	.chg_set1 =3D BD71828_REG_CHG_SET1,
>  	.chg_en   =3D BD71828_REG_CHG_EN,
>  	.vbat_alm_limit_u =3D BD71828_REG_ALM_VBAT_LIMIT_U,
>  	.conf =3D BD71828_REG_CONF,
>  	.vdcin =3D BD71828_REG_VDCIN_U,
> +	.vdcin_himask =3D BD7182x_MASK_VDCIN_U,
>  };
> =20
>  static const struct pwr_regs pwr_regs_bd71815 =3D {
> @@ -85,6 +90,7 @@ static const struct pwr_regs pwr_regs_bd71815 =3D {
>  	.chg_state =3D BD71815_REG_CHG_STATE,
>  	.bat_temp =3D BD71815_REG_BAT_TEMP,
>  	.dcin_stat =3D BD71815_REG_DCIN_STAT,
> +	.dcin_online_mask =3D BD7182x_MASK_DCIN_DET,
>  	.dcin_collapse_limit =3D BD71815_REG_DCIN_CLPS,
>  	.chg_set1 =3D BD71815_REG_CHG_SET1,
>  	.chg_en   =3D BD71815_REG_CHG_SET1,
> @@ -92,6 +98,31 @@ static const struct pwr_regs pwr_regs_bd71815 =3D {
>  	.conf =3D BD71815_REG_CONF,
> =20
>  	.vdcin =3D BD71815_REG_VM_DCIN_U,
> +	.vdcin_himask =3D BD7182x_MASK_VDCIN_U,
> +};
> +
> +static struct pwr_regs pwr_regs_bd72720 =3D {
> +	.vbat_avg =3D BD72720_REG_VM_SA_VBAT_U,
> +	.ibat =3D BD72720_REG_CC_CURCD_U,
> +	.ibat_avg =3D BD72720_REG_CC_SA_CURCD_U,
> +	.btemp_vth =3D BD72720_REG_VM_BTMP_U,
> +	/*
> +	 * Note, state 0x40 IMP_CHK. not documented
> +	 * on other variants but was still handled in
> +	 * existing code. No memory traces as to why.
> +	 */
> +	.chg_state =3D BD72720_REG_CHG_STATE,
> +	.bat_temp =3D BD72720_REG_CHG_BAT_TEMP_STAT,
> +	.dcin_stat =3D BD72720_REG_INT_VBUS_SRC,
> +	.dcin_online_mask =3D BD72720_MASK_DCIN_DET,
> +	.dcin_collapse_limit =3D -1, /* Automatic. Setting not supported */
> +	.chg_set1 =3D BD72720_REG_CHG_SET_1,
> +	.chg_en =3D BD72720_REG_CHG_EN,
> +	/* 15mV note in data-sheet */
> +	.vbat_alm_limit_u =3D BD72720_REG_ALM_VBAT_TH_U,
> +	.conf =3D BD72720_REG_CONF, /* o XSTB, only PON. Seprate slave addr */
> +	.vdcin =3D BD72720_REG_VM_VBUS_U, /* 10 bits not 11 as with other ICs */
> +	.vdcin_himask =3D BD72720_MASK_VDCIN_U,
>  };
> =20
>  struct bd71828_power {
> @@ -298,7 +329,7 @@ static int get_chg_online(struct bd71828_power *pwr, =
int *chg_online)
>  		dev_err(pwr->dev, "Failed to read DCIN status\n");
>  		return ret;
>  	}
> -	*chg_online =3D ((r & BD7182x_MASK_DCIN_DET) !=3D 0);
> +	*chg_online =3D ((r & pwr->regs->dcin_online_mask) !=3D 0);
> =20
>  	return 0;
>  }
> @@ -329,8 +360,8 @@ static int bd71828_bat_inserted(struct bd71828_power =
*pwr)
>  	ret =3D val & BD7182x_MASK_CONF_PON;
> =20
>  	if (ret)
> -		regmap_update_bits(pwr->regmap, pwr->regs->conf,
> -				   BD7182x_MASK_CONF_PON, 0);
> +		if (regmap_update_bits(pwr->regmap, pwr->regs->conf, BD7182x_MASK_CONF=
_PON, 0))
> +			dev_err(pwr->dev, "Failed to write CONF register\n");
> =20
>  	return ret;
>  }
> @@ -358,11 +389,13 @@ static int bd71828_init_hardware(struct bd71828_pow=
er *pwr)
>  	int ret;
> =20
>  	/* TODO: Collapse limit should come from device-tree ? */
> -	ret =3D regmap_write(pwr->regmap, pwr->regs->dcin_collapse_limit,
> -			   BD7182x_DCIN_COLLAPSE_DEFAULT);
> -	if (ret) {
> -		dev_err(pwr->dev, "Failed to write DCIN collapse limit\n");
> -		return ret;
> +	if (pwr->regs->dcin_collapse_limit !=3D (unsigned int)-1) {
> +		ret =3D regmap_write(pwr->regmap, pwr->regs->dcin_collapse_limit,
> +				   BD7182x_DCIN_COLLAPSE_DEFAULT);
> +		if (ret) {
> +			dev_err(pwr->dev, "Failed to write DCIN collapse limit\n");
> +			return ret;
> +		}
>  	}
> =20
>  	ret =3D pwr->bat_inserted(pwr);
> @@ -419,7 +452,7 @@ static int bd71828_charger_get_property(struct power_=
supply *psy,
>  		break;
>  	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>  		ret =3D bd7182x_read16_himask(pwr, pwr->regs->vdcin,
> -					    BD7182x_MASK_VDCIN_U, &tmp);
> +					    pwr->regs->vdcin_himask, &tmp);
>  		if (ret)
>  			return ret;
> =20
> @@ -630,6 +663,9 @@ BD_ISR_AC(dcin_ovp_det, "DCIN OVER VOLTAGE", true)
>  BD_ISR_DUMMY(dcin_mon_det, "DCIN voltage below threshold")
>  BD_ISR_DUMMY(dcin_mon_res, "DCIN voltage above threshold")
> =20
> +BD_ISR_DUMMY(vbus_curr_limit, "VBUS current limited")
> +BD_ISR_DUMMY(vsys_ov_res, "VSYS over-voltage cleared")
> +BD_ISR_DUMMY(vsys_ov_det, "VSYS over-voltage")
>  BD_ISR_DUMMY(vsys_uv_res, "VSYS under-voltage cleared")
>  BD_ISR_DUMMY(vsys_uv_det, "VSYS under-voltage")
>  BD_ISR_DUMMY(vsys_low_res, "'VSYS low' cleared")
> @@ -878,6 +914,51 @@ static int bd7182x_get_irqs(struct platform_device *=
pdev,
>  		BDIRQ("bd71828-temp-125-over", bd71828_temp_vf125_det),
>  		BDIRQ("bd71828-temp-125-under", bd71828_temp_vf125_res),
>  	};
> +	static const struct bd7182x_irq_res bd72720_irqs[] =3D {
> +		BDIRQ("bd72720_int_vbus_rmv", BD_ISR_NAME(dcin_removed)),
> +		BDIRQ("bd72720_int_vbus_det", bd7182x_dcin_detected),
> +		BDIRQ("bd72720_int_vbus_mon_res", BD_ISR_NAME(dcin_mon_res)),
> +		BDIRQ("bd72720_int_vbus_mon_det", BD_ISR_NAME(dcin_mon_det)),
> +		BDIRQ("bd72720_int_vsys_mon_res", BD_ISR_NAME(vsys_mon_res)),
> +		BDIRQ("bd72720_int_vsys_mon_det", BD_ISR_NAME(vsys_mon_det)),
> +		BDIRQ("bd72720_int_vsys_uv_res", BD_ISR_NAME(vsys_uv_res)),
> +		BDIRQ("bd72720_int_vsys_uv_det", BD_ISR_NAME(vsys_uv_det)),
> +		BDIRQ("bd72720_int_vsys_lo_res", BD_ISR_NAME(vsys_low_res)),
> +		BDIRQ("bd72720_int_vsys_lo_det", BD_ISR_NAME(vsys_low_det)),
> +		BDIRQ("bd72720_int_vsys_ov_res", BD_ISR_NAME(vsys_ov_res)),
> +		BDIRQ("bd72720_int_vsys_ov_det", BD_ISR_NAME(vsys_ov_det)),
> +		BDIRQ("bd72720_int_bat_ilim", BD_ISR_NAME(vbus_curr_limit)),
> +		BDIRQ("bd72720_int_chg_done", bd718x7_chg_done),
> +		BDIRQ("bd72720_int_extemp_tout", BD_ISR_NAME(chg_wdg_temp)),
> +		BDIRQ("bd72720_int_chg_wdt_exp", BD_ISR_NAME(chg_wdg)),
> +		BDIRQ("bd72720_int_bat_mnt_out", BD_ISR_NAME(rechg_res)),
> +		BDIRQ("bd72720_int_bat_mnt_in", BD_ISR_NAME(rechg_det)),
> +		BDIRQ("bd72720_int_chg_trns", BD_ISR_NAME(chg_state_changed)),
> +
> +		BDIRQ("bd72720_int_vbat_mon_res", BD_ISR_NAME(bat_mon_res)),
> +		BDIRQ("bd72720_int_vbat_mon_det", BD_ISR_NAME(bat_mon)),
> +		BDIRQ("bd72720_int_vbat_sht_res", BD_ISR_NAME(bat_short_res)),
> +		BDIRQ("bd72720_int_vbat_sht_det", BD_ISR_NAME(bat_short)),
> +		BDIRQ("bd72720_int_vbat_lo_res", BD_ISR_NAME(bat_low_res)),
> +		BDIRQ("bd72720_int_vbat_lo_det", BD_ISR_NAME(bat_low)),
> +		BDIRQ("bd72720_int_vbat_ov_res", BD_ISR_NAME(bat_ov_res)),
> +		BDIRQ("bd72720_int_vbat_ov_det", BD_ISR_NAME(bat_ov)),
> +		BDIRQ("bd72720_int_bat_rmv", BD_ISR_NAME(bat_removed)),
> +		BDIRQ("bd72720_int_bat_det", BD_ISR_NAME(bat_det)),
> +		BDIRQ("bd72720_int_dbat_det", BD_ISR_NAME(bat_dead)),
> +		BDIRQ("bd72720_int_bat_temp_trns", BD_ISR_NAME(temp_transit)),
> +		BDIRQ("bd72720_int_lobtmp_res", BD_ISR_NAME(temp_bat_low_res)),
> +		BDIRQ("bd72720_int_lobtmp_det", BD_ISR_NAME(temp_bat_low)),
> +		BDIRQ("bd72720_int_ovbtmp_res", BD_ISR_NAME(temp_bat_hi_res)),
> +		BDIRQ("bd72720_int_ovbtmp_det", BD_ISR_NAME(temp_bat_hi)),
> +		BDIRQ("bd72720_int_ocur1_res", BD_ISR_NAME(bat_oc1_res)),
> +		BDIRQ("bd72720_int_ocur1_det", BD_ISR_NAME(bat_oc1)),
> +		BDIRQ("bd72720_int_ocur2_res", BD_ISR_NAME(bat_oc2_res)),
> +		BDIRQ("bd72720_int_ocur2_det", BD_ISR_NAME(bat_oc2)),
> +		BDIRQ("bd72720_int_ocur3_res", BD_ISR_NAME(bat_oc3_res)),
> +		BDIRQ("bd72720_int_ocur3_det", BD_ISR_NAME(bat_oc3)),
> +		BDIRQ("bd72720_int_cc_mon2_det", BD_ISR_NAME(bat_cc_mon)),
> +	};
>  	int num_irqs;
>  	const struct bd7182x_irq_res *irqs;
> =20
> @@ -890,6 +971,10 @@ static int bd7182x_get_irqs(struct platform_device *=
pdev,
>  		irqs =3D &bd71815_irqs[0];
>  		num_irqs =3D ARRAY_SIZE(bd71815_irqs);
>  		break;
> +	case ROHM_CHIP_TYPE_BD72720:
> +		irqs =3D &bd72720_irqs[0];
> +		num_irqs =3D ARRAY_SIZE(bd72720_irqs);
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -958,21 +1043,27 @@ static int bd71828_power_probe(struct platform_dev=
ice *pdev)
>  	struct power_supply_config ac_cfg =3D {};
>  	struct power_supply_config bat_cfg =3D {};
>  	int ret;
> -	struct regmap *regmap;
> -
> -	regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> -	if (!regmap) {
> -		dev_err(&pdev->dev, "No parent regmap\n");
> -		return -EINVAL;
> -	}
> =20
>  	pwr =3D devm_kzalloc(&pdev->dev, sizeof(*pwr), GFP_KERNEL);
>  	if (!pwr)
>  		return -ENOMEM;
> =20
> -	pwr->regmap =3D regmap;
> -	pwr->dev =3D &pdev->dev;
> +	/*
> +	 * The BD72720 MFD device registers two regmaps. Power-supply driver
> +	 * uses the "wrap-map", which provides access to both of the I2C slave
> +	 * addresses used by the BD72720
> +	 */
>  	pwr->chip_type =3D platform_get_device_id(pdev)->driver_data;
> +	if (pwr->chip_type !=3D ROHM_CHIP_TYPE_BD72720)
> +		pwr->regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> +	else
> +		pwr->regmap =3D dev_get_regmap(pdev->dev.parent, "wrap-map");
> +	if (!pwr->regmap) {
> +		dev_err(&pdev->dev, "No parent regmap\n");
> +		return -EINVAL;
> +	}

return dev_err_probe(&pdev->dev, -EINVAL, "No parent regmap\n");

Otherwise LGTM.

Greetings,

-- Sebastian

> +
> +	pwr->dev =3D &pdev->dev;
> =20
>  	switch (pwr->chip_type) {
>  	case ROHM_CHIP_TYPE_BD71828:
> @@ -985,6 +1076,12 @@ static int bd71828_power_probe(struct platform_devi=
ce *pdev)
>  		pwr->get_temp =3D bd71815_get_temp;
>  		pwr->regs =3D &pwr_regs_bd71815;
>  		break;
> +	case ROHM_CHIP_TYPE_BD72720:
> +		pwr->bat_inserted =3D bd71828_bat_inserted;
> +		pwr->regs =3D &pwr_regs_bd72720;
> +		pwr->get_temp =3D bd71828_get_temp;
> +		dev_dbg(pwr->dev, "Found ROHM BD72720\n");
> +		break;
>  	default:
>  		dev_err(pwr->dev, "Unknown PMIC\n");
>  		return -EINVAL;
> @@ -1030,6 +1127,7 @@ static int bd71828_power_probe(struct platform_devi=
ce *pdev)
>  static const struct platform_device_id bd71828_charger_id[] =3D {
>  	{ "bd71815-power", ROHM_CHIP_TYPE_BD71815 },
>  	{ "bd71828-power", ROHM_CHIP_TYPE_BD71828 },
> +	{ "bd72720-power", ROHM_CHIP_TYPE_BD72720 },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(platform, bd71828_charger_id);
> --=20
> 2.52.0
>=20



--xkg36apyy363kayk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmlkRa0ACgkQ2O7X88g7
+pqwUg/+Mj3WA8fAj5JCyfHN+EKB3Zsji1TyERmDiaCjNplUYPMCR0CWktNyZsEf
ka6L1LxQs0eioNFDR36d5g93LO54h7w7RKWfdWpy77y7MdRwFX6A/hdUEtURuPs3
E5Bw5jL46wkGygtiE2Z1+MjBszbbX9Lk16mZ6yaMxB3GOIOOU1KSnXd+rHbYx9rm
vC/aFuCB3utAn5XxNtqdc8zJQxTGa9pmrZFkNWYa5Xkx47gKKa7+lXzusBWZltkj
zjYE5MSs/8tvLw3YWb3cC3JHFblKmhFVRcLpyJN2sgwJSoxTcQrOdrfJVMzr5SON
lQAuddefWTC55gyLQJkNLFwLMyV1FyLrLslUlL4FviAcHLp4rhuOWpT+wTuWjZk0
L0uRZPcg7ViqJYx0bcpTi92VRiOglGwEy1aflJY13+GoGB6Rji9N39AKERyW+m2J
pxgwtZ2AlchXM+871KcAqMUtuPv8wCsmrtViUc4to35Jcc4OTyNBR1XZGG13H08L
nlwq40ppyX4KsnXBR0ejd4PN4e9jtkKmh7dNiiy36CiKuLVUaMuXwYIiztpVnEN7
RkfIs2z0oV1AnaTn7Po523NDwKhHOxFeG/unVpJ7y86CsMGnhm8qr4/iCwJj0xVS
FhxlyEGF07Nx8880D8MsYJyXDJFBU81abYqCu/HvfJm7zUF8uOI=
=dT/D
-----END PGP SIGNATURE-----

--xkg36apyy363kayk--

