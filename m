Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778F5352A69
	for <lists+linux-pm@lfdr.de>; Fri,  2 Apr 2021 13:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbhDBL5r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Apr 2021 07:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhDBL5r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Apr 2021 07:57:47 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F99C0613E6;
        Fri,  2 Apr 2021 04:57:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 03E941F4689B
Received: by earth.universe (Postfix, from userid 1000)
        id 19BF13C0C96; Fri,  2 Apr 2021 13:57:42 +0200 (CEST)
Date:   Fri, 2 Apr 2021 13:57:42 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: Re: [PATCH v4 2/2] power: supply: mt6360_charger: add MT6360 charger
 support
Message-ID: <20210402115742.ssgh72eztfjv66sc@earth.universe>
References: <1610973703-676-1-git-send-email-gene.chen.richtek@gmail.com>
 <1610973703-676-3-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rp6csmjucqhiijpy"
Content-Disposition: inline
In-Reply-To: <1610973703-676-3-git-send-email-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--rp6csmjucqhiijpy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 18, 2021 at 08:41:43PM +0800, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
>=20
> Add basic support for the battery charger for MT6360 PMIC
>=20
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  drivers/power/supply/Kconfig          |  10 +
>  drivers/power/supply/Makefile         |   1 +
>  drivers/power/supply/mt6360_charger.c | 914 ++++++++++++++++++++++++++++=
++++++
>  3 files changed, 925 insertions(+)
>  create mode 100644 drivers/power/supply/mt6360_charger.c
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index eec646c..dd63bed 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -567,6 +567,16 @@ config CHARGER_MP2629
>  	  Battery charger. This driver provides Battery charger power management
>  	  functions on the systems.
> =20
> +config CHARGER_MT6360
> +	tristate "Mediatek MT6360 Charger Driver"
> +	depends on MFD_MT6360
> +	depends on REGULATOR
> +	help
> +	  Say Y here to enable MT6360 Charger Part.
> +	  The device supports High-Accuracy Voltage/Current Regulation,
> +	  Average Input Current Regulation, Battery Tempature Sensing,
> +	  Over-Temperature Protection, DPDM Detection for BC1.2
> +
>  config CHARGER_QCOM_SMBB
>  	tristate "Qualcomm Switch-Mode Battery Charger and Boost"
>  	depends on MFD_SPMI_PMIC || COMPILE_TEST
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index dd4b863..9bd0804 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -77,6 +77,7 @@ obj-$(CONFIG_CHARGER_MAX77693)	+=3D max77693_charger.o
>  obj-$(CONFIG_CHARGER_MAX8997)	+=3D max8997_charger.o
>  obj-$(CONFIG_CHARGER_MAX8998)	+=3D max8998_charger.o
>  obj-$(CONFIG_CHARGER_MP2629)	+=3D mp2629_charger.o
> +obj-$(CONFIG_CHARGER_MT6360)	+=3D mt6360_charger.o
>  obj-$(CONFIG_CHARGER_QCOM_SMBB)	+=3D qcom_smbb.o
>  obj-$(CONFIG_CHARGER_BQ2415X)	+=3D bq2415x_charger.o
>  obj-$(CONFIG_CHARGER_BQ24190)	+=3D bq24190_charger.o
> diff --git a/drivers/power/supply/mt6360_charger.c b/drivers/power/supply=
/mt6360_charger.c
> new file mode 100644
> index 0000000..d80bdad
> --- /dev/null
> +++ b/drivers/power/supply/mt6360_charger.c
> @@ -0,0 +1,914 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2021 MediaTek Inc.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/driver.h>
> +
> +#define MT6360_PMU_CHG_CTRL1	0x311
> +#define MT6360_PMU_CHG_CTRL2	0x312
> +#define MT6360_PMU_CHG_CTRL3	0x313
> +#define MT6360_PMU_CHG_CTRL4	0x314
> +#define MT6360_PMU_CHG_CTRL5	0x315
> +#define MT6360_PMU_CHG_CTRL6	0x316
> +#define MT6360_PMU_CHG_CTRL7	0x317
> +#define MT6360_PMU_CHG_CTRL8	0x318
> +#define MT6360_PMU_CHG_CTRL9	0x319
> +#define MT6360_PMU_CHG_CTRL10	0x31A
> +#define MT6360_PMU_DEVICE_TYPE	0x322
> +#define MT6360_PMU_USB_STATUS1	0x327
> +#define MT6360_PMU_CHG_STAT	0x34A
> +#define MT6360_PMU_CHG_CTRL19	0x361
> +#define MT6360_PMU_FOD_STAT	0x3E7
> +
> +/* MT6360_PMU_CHG_CTRL1 */
> +#define MT6360_FSLP_SHFT	(3)
> +#define MT6360_FSLP_MASK	BIT(MT6360_FSLP_SHFT)
> +#define MT6360_OPA_MODE_SHFT	(0)
> +#define MT6360_OPA_MODE_MASK	BIT(MT6360_OPA_MODE_SHFT)
> +/* MT6360_PMU_CHG_CTRL2 */
> +#define MT6360_IINLMTSEL_SHFT	(2)
> +#define MT6360_IINLMTSEL_MASK	GENMASK(3, 2)
> +/* MT6360_PMU_CHG_CTRL3 */
> +#define MT6360_IAICR_SHFT	(2)
> +#define MT6360_IAICR_MASK	GENMASK(7, 2)
> +#define MT6360_ILIM_EN_MASK	BIT(0)
> +/* MT6360_PMU_CHG_CTRL4 */
> +#define MT6360_VOREG_SHFT	(1)
> +#define MT6360_VOREG_MASK	GENMASK(7, 1)
> +/* MT6360_PMU_CHG_CTRL5 */
> +#define MT6360_VOBST_MASK	GENMASK(7, 2)
> +/* MT6360_PMU_CHG_CTRL6 */
> +#define MT6360_VMIVR_SHFT      (1)
> +#define MT6360_VMIVR_MASK      GENMASK(7, 1)
> +/* MT6360_PMU_CHG_CTRL7 */
> +#define MT6360_ICHG_SHFT	(2)
> +#define MT6360_ICHG_MASK	GENMASK(7, 2)
> +/* MT6360_PMU_CHG_CTRL8 */
> +#define MT6360_IPREC_SHFT	(0)
> +#define MT6360_IPREC_MASK	GENMASK(3, 0)
> +/* MT6360_PMU_CHG_CTRL9 */
> +#define MT6360_IEOC_SHFT	(4)
> +#define MT6360_IEOC_MASK	GENMASK(7, 4)
> +/* MT6360_PMU_CHG_CTRL10 */
> +#define MT6360_OTG_OC_MASK	GENMASK(3, 0)
> +/* MT6360_PMU_DEVICE_TYPE */
> +#define MT6360_USBCHGEN_MASK	BIT(7)
> +/* MT6360_PMU_USB_STATUS1 */
> +#define MT6360_USB_STATUS_SHFT	(4)
> +#define MT6360_USB_STATUS_MASK	GENMASK(6, 4)
> +/* MT6360_PMU_CHG_STAT */
> +#define MT6360_CHG_STAT_SHFT	(6)
> +#define MT6360_CHG_STAT_MASK	GENMASK(7, 6)
> +#define MT6360_VBAT_LVL_MASK	BIT(5)
> +/* MT6360_PMU_CHG_CTRL19 */
> +#define MT6360_VINOVP_SHFT	(5)
> +#define MT6360_VINOVP_MASK	GENMASK(6, 5)
> +/* MT6360_PMU_FOD_STAT */
> +#define MT6360_CHRDET_EXT_MASK	BIT(4)
> +
> +/* uV */
> +#define MT6360_VMIVR_MIN	3900000
> +#define MT6360_VMIVR_MAX	13400000
> +#define MT6360_VMIVR_STEP	100000
> +/* uA */
> +#define MT6360_ICHG_MIN		100000
> +#define MT6360_ICHG_MAX		5000000
> +#define MT6360_ICHG_STEP	100000
> +/* uV */
> +#define MT6360_VOREG_MIN	3900000
> +#define MT6360_VOREG_MAX	4710000
> +#define MT6360_VOREG_STEP	10000
> +/* uA */
> +#define MT6360_AICR_MIN		100000
> +#define MT6360_AICR_MAX		3250000
> +#define MT6360_AICR_STEP	50000
> +/* uA */
> +#define MT6360_IPREC_MIN	100000
> +#define MT6360_IPREC_MAX	850000
> +#define MT6360_IPREC_STEP	50000
> +/* uA */
> +#define MT6360_IEOC_MIN		100000
> +#define MT6360_IEOC_MAX		850000
> +#define MT6360_IEOC_STEP	50000
> +
> +struct mt6360_chg_info {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct power_supply_desc psy_desc;
> +	struct power_supply *psy;
> +	struct regulator_dev *otg_rdev;
> +	struct mutex chgdet_lock;
> +	u32 vinovp;
> +	bool pwr_rdy;
> +	bool bc12_en;
> +	int psy_usb_type;
> +	struct work_struct chrdet_work;
> +};
> +
> +enum mt6360_iinlmtsel {
> +	MT6360_IINLMTSEL_AICR_3250 =3D 0,
> +	MT6360_IINLMTSEL_CHG_TYPE,
> +	MT6360_IINLMTSEL_AICR,
> +	MT6360_IINLMTSEL_LOWER_LEVEL,
> +};
> +
> +enum mt6360_pmu_chg_type {
> +	MT6360_CHG_TYPE_NOVBUS =3D 0,
> +	MT6360_CHG_TYPE_UNDER_GOING,
> +	MT6360_CHG_TYPE_SDP,
> +	MT6360_CHG_TYPE_SDPNSTD,
> +	MT6360_CHG_TYPE_DCP,
> +	MT6360_CHG_TYPE_CDP,
> +	MT6360_CHG_TYPE_DISABLE_BC12,
> +	MT6360_CHG_TYPE_MAX,
> +};
> +
> +static enum power_supply_usb_type mt6360_charger_usb_types[] =3D {
> +	POWER_SUPPLY_USB_TYPE_UNKNOWN,
> +	POWER_SUPPLY_USB_TYPE_SDP,
> +	POWER_SUPPLY_USB_TYPE_DCP,
> +	POWER_SUPPLY_USB_TYPE_CDP,
> +};
> +
> +static unsigned int mt6360_map_reg_sel(u32 data, u32 min, u32 max, u32 s=
tep)
> +{
> +	u32 target =3D 0, max_sel;
> +
> +	if (data >=3D min) {
> +		target =3D (data - min) / step;
> +		max_sel =3D (max - min) / step;
> +		if (target > max_sel)
> +			target =3D max_sel;
> +	}
> +	return target;
> +}
> +
> +static u32 mt6360_map_real_val(u32 sel, u32 min, u32 max, u32 step)
> +{
> +	u32 target =3D 0;
> +
> +	target =3D min + (sel * step);
> +	if (target > max)
> +		target =3D max;
> +	return target;
> +}
> +
> +static int mt6360_get_chrdet_ext_stat(struct mt6360_chg_info *mci,
> +					     bool *pwr_rdy)
> +{
> +	int ret;
> +	unsigned int regval;
> +
> +	ret =3D regmap_read(mci->regmap, MT6360_PMU_FOD_STAT, &regval);
> +	if (ret < 0)
> +		return ret;
> +	*pwr_rdy =3D (regval & MT6360_CHRDET_EXT_MASK) ? true : false;
> +	return 0;
> +}
> +
> +static int mt6360_charger_get_online(struct mt6360_chg_info *mci,
> +				     union power_supply_propval *val)
> +{
> +	int ret;
> +	bool pwr_rdy;
> +
> +	ret =3D mt6360_get_chrdet_ext_stat(mci, &pwr_rdy);
> +	if (ret < 0)
> +		return ret;
> +	val->intval =3D pwr_rdy ? true : false;
> +	return 0;
> +}
> +
> +static int mt6360_charger_get_status(struct mt6360_chg_info *mci,
> +				     union power_supply_propval *val)
> +{
> +	int status, ret;
> +	unsigned int regval;
> +	bool pwr_rdy;
> +
> +	ret =3D mt6360_get_chrdet_ext_stat(mci, &pwr_rdy);
> +	if (ret < 0)
> +		return ret;
> +	if (!pwr_rdy) {
> +		status =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +		goto out;
> +	}
> +
> +	ret =3D regmap_read(mci->regmap, MT6360_PMU_CHG_STAT, &regval);
> +	if (ret < 0)
> +		return ret;
> +	regval &=3D MT6360_CHG_STAT_MASK;
> +	regval >>=3D MT6360_CHG_STAT_SHFT;
> +	switch (regval) {
> +	case 0x0:
> +		status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		break;
> +	case 0x1:
> +		status =3D POWER_SUPPLY_STATUS_CHARGING;
> +		break;
> +	case 0x2:
> +		status =3D POWER_SUPPLY_STATUS_FULL;
> +		break;
> +	default:
> +		ret =3D -EIO;
> +	}
> +out:
> +	if (!ret)
> +		val->intval =3D status;
> +	return ret;
> +}
> +
> +static int mt6360_charger_get_charge_type(struct mt6360_chg_info *mci,
> +					  union power_supply_propval *val)
> +{
> +	int type, ret;
> +	unsigned int regval;
> +	u8 chg_stat;
> +
> +	ret =3D regmap_read(mci->regmap, MT6360_PMU_CHG_STAT, &regval);
> +	if (ret < 0)
> +		return ret;
> +
> +	chg_stat =3D (regval & MT6360_CHG_STAT_MASK) >> MT6360_CHG_STAT_SHFT;
> +	switch (chg_stat) {
> +	case 0x01: /* Charge in Progress */
> +		if (regval & MT6360_VBAT_LVL_MASK)
> +			type =3D POWER_SUPPLY_CHARGE_TYPE_FAST;
> +		else
> +			type =3D POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
> +		break;
> +	case 0x00: /* Not Charging */
> +	case 0x02: /* Charge Done */
> +	case 0x03: /* Charge Fault */
> +	default:
> +		type =3D POWER_SUPPLY_CHARGE_TYPE_NONE;
> +		break;
> +	}
> +
> +	val->intval =3D type;
> +	return 0;
> +}
> +
> +static int mt6360_charger_get_ichg(struct mt6360_chg_info *mci,
> +				   union power_supply_propval *val)
> +{
> +	int ret;
> +	unsigned int regval;
> +
> +	ret =3D regmap_read(mci->regmap, MT6360_PMU_CHG_CTRL7, &regval);
> +	if (ret < 0)
> +		return ret;
> +	regval =3D (regval & MT6360_ICHG_MASK) >> MT6360_ICHG_SHFT;
> +	val->intval =3D mt6360_map_real_val(regval,
> +					  MT6360_ICHG_MIN,
> +					  MT6360_ICHG_MAX,
> +					  MT6360_ICHG_STEP);
> +	return 0;
> +}
> +
> +static int mt6360_charger_get_max_ichg(struct mt6360_chg_info *mci,
> +				       union power_supply_propval *val)
> +{
> +	val->intval =3D MT6360_ICHG_MAX;
> +	return 0;
> +}
> +
> +static int mt6360_charger_get_cv(struct mt6360_chg_info *mci,
> +				 union power_supply_propval *val)
> +{
> +	int ret;
> +	unsigned int regval;
> +
> +	ret =3D regmap_read(mci->regmap, MT6360_PMU_CHG_CTRL4, &regval);
> +	if (ret < 0)
> +		return ret;
> +	regval =3D (regval & MT6360_VOREG_MASK) >> MT6360_VOREG_SHFT;
> +	val->intval =3D mt6360_map_real_val(regval,
> +					  MT6360_VOREG_MIN,
> +					  MT6360_VOREG_MAX,
> +					  MT6360_VOREG_STEP);
> +	return 0;
> +}
> +
> +static int mt6360_charger_get_max_cv(struct mt6360_chg_info *mci,
> +				     union power_supply_propval *val)
> +{
> +	val->intval =3D MT6360_VOREG_MAX;
> +	return 0;
> +}
> +
> +static int mt6360_charger_get_aicr(struct mt6360_chg_info *mci,
> +				   union power_supply_propval *val)
> +{
> +	int ret;
> +	unsigned int regval;
> +
> +	ret =3D regmap_read(mci->regmap, MT6360_PMU_CHG_CTRL3, &regval);
> +	if (ret < 0)
> +		return ret;
> +	regval =3D (regval & MT6360_IAICR_MASK) >> MT6360_IAICR_SHFT;
> +	val->intval =3D mt6360_map_real_val(regval,
> +					  MT6360_AICR_MIN,
> +					  MT6360_AICR_MAX,
> +					  MT6360_AICR_STEP);
> +	return 0;
> +}
> +
> +static int mt6360_charger_get_mivr(struct mt6360_chg_info *mci,
> +				   union power_supply_propval *val)
> +{
> +	int ret;
> +	unsigned int regval;
> +
> +	ret =3D regmap_read(mci->regmap, MT6360_PMU_CHG_CTRL6, &regval);
> +	if (ret < 0)
> +		return ret;
> +	regval =3D (regval & MT6360_VMIVR_MASK) >> MT6360_VMIVR_SHFT;
> +	val->intval =3D mt6360_map_real_val(regval,
> +					  MT6360_VMIVR_MIN,
> +					  MT6360_VMIVR_MAX,
> +					  MT6360_VMIVR_STEP);
> +	return 0;
> +}
> +
> +static int mt6360_charger_get_iprechg(struct mt6360_chg_info *mci,
> +				      union power_supply_propval *val)
> +{
> +	int ret;
> +	unsigned int regval;
> +
> +	ret =3D regmap_read(mci->regmap, MT6360_PMU_CHG_CTRL8, &regval);
> +	if (ret < 0)
> +		return ret;
> +	regval =3D (regval & MT6360_IPREC_MASK) >> MT6360_IPREC_SHFT;
> +	val->intval =3D mt6360_map_real_val(regval,
> +					  MT6360_IPREC_MIN,
> +					  MT6360_IPREC_MAX,
> +					  MT6360_IPREC_STEP);
> +	return 0;
> +}
> +
> +static int mt6360_charger_get_ieoc(struct mt6360_chg_info *mci,
> +				   union power_supply_propval *val)
> +{
> +	int ret;
> +	unsigned int regval;
> +
> +	ret =3D regmap_read(mci->regmap, MT6360_PMU_CHG_CTRL9, &regval);
> +	if (ret < 0)
> +		return ret;
> +	regval =3D (regval & MT6360_IEOC_MASK) >> MT6360_IEOC_SHFT;
> +	val->intval =3D mt6360_map_real_val(regval,
> +					  MT6360_IEOC_MIN,
> +					  MT6360_IEOC_MAX,
> +					  MT6360_IEOC_STEP);
> +	return 0;
> +}
> +
> +static int mt6360_charger_set_online(struct mt6360_chg_info *mci,
> +				     const union power_supply_propval *val)
> +{
> +	u8 force_sleep =3D val->intval ? 0 : 1;
> +
> +	return regmap_update_bits(mci->regmap,
> +				  MT6360_PMU_CHG_CTRL1,
> +				  MT6360_FSLP_MASK,
> +				  force_sleep << MT6360_FSLP_SHFT);
> +}
> +
> +static int mt6360_charger_set_ichg(struct mt6360_chg_info *mci,
> +				   const union power_supply_propval *val)
> +{
> +	u8 sel;
> +
> +	sel =3D mt6360_map_reg_sel(val->intval,
> +				 MT6360_ICHG_MIN,
> +				 MT6360_ICHG_MAX,
> +				 MT6360_ICHG_STEP);
> +	return regmap_update_bits(mci->regmap,
> +				  MT6360_PMU_CHG_CTRL7,
> +				  MT6360_ICHG_MASK,
> +				  sel << MT6360_ICHG_SHFT);
> +}
> +
> +static int mt6360_charger_set_cv(struct mt6360_chg_info *mci,
> +				 const union power_supply_propval *val)
> +{
> +	u8 sel;
> +
> +	sel =3D mt6360_map_reg_sel(val->intval,
> +				 MT6360_VOREG_MIN,
> +				 MT6360_VOREG_MAX,
> +				 MT6360_VOREG_STEP);
> +	return regmap_update_bits(mci->regmap,
> +				  MT6360_PMU_CHG_CTRL4,
> +				  MT6360_VOREG_MASK,
> +				  sel << MT6360_VOREG_SHFT);
> +}
> +
> +static int mt6360_charger_set_aicr(struct mt6360_chg_info *mci,
> +				   const union power_supply_propval *val)
> +{
> +	u8 sel;
> +
> +	sel =3D mt6360_map_reg_sel(val->intval,
> +				 MT6360_AICR_MIN,
> +				 MT6360_AICR_MAX,
> +				 MT6360_AICR_STEP);
> +	return regmap_update_bits(mci->regmap,
> +				  MT6360_PMU_CHG_CTRL3,
> +				  MT6360_IAICR_MASK,
> +				  sel << MT6360_IAICR_SHFT);
> +}
> +
> +static int mt6360_charger_set_mivr(struct mt6360_chg_info *mci,
> +				   const union power_supply_propval *val)
> +{
> +	u8 sel;
> +
> +	sel =3D mt6360_map_reg_sel(val->intval,
> +				 MT6360_VMIVR_MIN,
> +				 MT6360_VMIVR_MAX,
> +				 MT6360_VMIVR_STEP);
> +	return regmap_update_bits(mci->regmap,
> +				  MT6360_PMU_CHG_CTRL3,
> +				  MT6360_VMIVR_MASK,
> +				  sel << MT6360_VMIVR_SHFT);
> +}
> +
> +static int mt6360_charger_set_iprechg(struct mt6360_chg_info *mci,
> +				      const union power_supply_propval *val)
> +{
> +	u8 sel;
> +
> +	sel =3D mt6360_map_reg_sel(val->intval,
> +				 MT6360_IPREC_MIN,
> +				 MT6360_IPREC_MAX,
> +				 MT6360_IPREC_STEP);
> +	return regmap_update_bits(mci->regmap,
> +				  MT6360_PMU_CHG_CTRL8,
> +				  MT6360_IPREC_MASK,
> +				  sel << MT6360_IPREC_SHFT);
> +}
> +
> +static int mt6360_charger_set_ieoc(struct mt6360_chg_info *mci,
> +				   const union power_supply_propval *val)
> +{
> +	u8 sel;
> +
> +	sel =3D mt6360_map_reg_sel(val->intval,
> +				 MT6360_IEOC_MIN,
> +				 MT6360_IEOC_MAX,
> +				 MT6360_IEOC_STEP);
> +	return regmap_update_bits(mci->regmap,
> +				  MT6360_PMU_CHG_CTRL9,
> +				  MT6360_IEOC_MASK,
> +				  sel << MT6360_IEOC_SHFT);
> +}
> +
> +static int mt6360_charger_get_property(struct power_supply *psy,
> +				       enum power_supply_property psp,
> +				       union power_supply_propval *val)
> +{
> +	struct mt6360_chg_info *mci =3D power_supply_get_drvdata(psy);
> +	int ret =3D 0;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		ret =3D mt6360_charger_get_online(mci, val);
> +		break;
> +	case POWER_SUPPLY_PROP_STATUS:
> +		ret =3D mt6360_charger_get_status(mci, val);
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +		ret =3D mt6360_charger_get_charge_type(mci, val);
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +		ret =3D mt6360_charger_get_ichg(mci, val);
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> +		ret =3D mt6360_charger_get_max_ichg(mci, val);
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> +		ret =3D mt6360_charger_get_cv(mci, val);
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
> +		ret =3D mt6360_charger_get_max_cv(mci, val);
> +		break;
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		ret =3D mt6360_charger_get_aicr(mci, val);
> +		break;
> +	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
> +		ret =3D mt6360_charger_get_mivr(mci, val);
> +		break;
> +	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
> +		ret =3D mt6360_charger_get_iprechg(mci, val);
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
> +		ret =3D mt6360_charger_get_ieoc(mci, val);
> +		break;
> +	case POWER_SUPPLY_PROP_USB_TYPE:
> +		val->intval =3D mci->psy_usb_type;
> +		break;
> +	default:
> +		ret =3D -ENODATA;
> +	}
> +	return ret;
> +}
> +
> +static int mt6360_charger_set_property(struct power_supply *psy,
> +				       enum power_supply_property psp,
> +				       const union power_supply_propval *val)
> +{
> +	struct mt6360_chg_info *mci =3D power_supply_get_drvdata(psy);
> +	int ret;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		ret =3D mt6360_charger_set_online(mci, val);
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +		ret =3D mt6360_charger_set_ichg(mci, val);
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> +		ret =3D mt6360_charger_set_cv(mci, val);
> +		break;
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		ret =3D mt6360_charger_set_aicr(mci, val);
> +		break;
> +	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
> +		ret =3D mt6360_charger_set_mivr(mci, val);
> +		break;
> +	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
> +		ret =3D mt6360_charger_set_iprechg(mci, val);
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
> +		ret =3D mt6360_charger_set_ieoc(mci, val);
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +	}
> +	return ret;
> +}
> +
> +static int mt6360_charger_property_is_writeable(struct power_supply *psy,
> +					       enum power_supply_property psp)
> +{
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
> +	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
> +	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
> +		return 1;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static enum power_supply_property mt6360_charger_properties[] =3D {
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_CHARGE_TYPE,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
> +	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +	POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT,
> +	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
> +	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
> +	POWER_SUPPLY_PROP_USB_TYPE,
> +};
> +
> +static const struct power_supply_desc mt6360_charger_desc =3D {
> +	.type			=3D POWER_SUPPLY_TYPE_USB,
> +	.properties		=3D mt6360_charger_properties,
> +	.num_properties		=3D ARRAY_SIZE(mt6360_charger_properties),
> +	.get_property		=3D mt6360_charger_get_property,
> +	.set_property		=3D mt6360_charger_set_property,
> +	.property_is_writeable	=3D mt6360_charger_property_is_writeable,
> +	.usb_types		=3D mt6360_charger_usb_types,
> +	.num_usb_types		=3D ARRAY_SIZE(mt6360_charger_usb_types),
> +};
> +
> +static const struct regulator_ops mt6360_chg_otg_ops =3D {
> +	.list_voltage =3D regulator_list_voltage_linear,
> +	.enable =3D regulator_enable_regmap,
> +	.disable =3D regulator_disable_regmap,
> +	.is_enabled =3D regulator_is_enabled_regmap,
> +	.set_voltage_sel =3D regulator_set_voltage_sel_regmap,
> +	.get_voltage_sel =3D regulator_get_voltage_sel_regmap,
> +};
> +
> +static const struct regulator_desc mt6360_otg_rdesc =3D {
> +	.of_match =3D "usb-otg-vbus",
> +	.name =3D "usb-otg-vbus",
> +	.ops =3D &mt6360_chg_otg_ops,
> +	.owner =3D THIS_MODULE,
> +	.type =3D REGULATOR_VOLTAGE,
> +	.min_uV =3D 4425000,
> +	.uV_step =3D 25000,
> +	.n_voltages =3D 57,
> +	.vsel_reg =3D MT6360_PMU_CHG_CTRL5,
> +	.vsel_mask =3D MT6360_VOBST_MASK,
> +	.enable_reg =3D MT6360_PMU_CHG_CTRL1,
> +	.enable_mask =3D MT6360_OPA_MODE_MASK,
> +};
> +
> +static irqreturn_t mt6360_pmu_attach_i_handler(int irq, void *data)
> +{
> +	struct mt6360_chg_info *mci =3D data;
> +	int ret;
> +	unsigned int usb_status;
> +	int last_usb_type;
> +
> +	mutex_lock(&mci->chgdet_lock);
> +	if (!mci->bc12_en) {
> +		dev_warn(mci->dev, "Received attach interrupt, bc12 disabled, ignore i=
rq\n");
> +		goto out;
> +	}
> +	last_usb_type =3D mci->psy_usb_type;
> +	/* Plug in */
> +	ret =3D regmap_read(mci->regmap, MT6360_PMU_USB_STATUS1, &usb_status);
> +	if (ret < 0)
> +		goto out;
> +	usb_status &=3D MT6360_USB_STATUS_MASK;
> +	usb_status >>=3D MT6360_USB_STATUS_SHFT;
> +	switch (usb_status) {
> +	case MT6360_CHG_TYPE_NOVBUS:
> +		dev_dbg(mci->dev, "Received attach interrupt, no vbus\n");
> +		goto out;
> +	case MT6360_CHG_TYPE_UNDER_GOING:
> +		dev_dbg(mci->dev, "Received attach interrupt, under going...\n");
> +		goto out;
> +	case MT6360_CHG_TYPE_SDP:
> +		mci->psy_usb_type =3D POWER_SUPPLY_USB_TYPE_SDP;
> +		break;
> +	case MT6360_CHG_TYPE_SDPNSTD:
> +		mci->psy_usb_type =3D POWER_SUPPLY_USB_TYPE_SDP;
> +		break;
> +	case MT6360_CHG_TYPE_CDP:
> +		mci->psy_usb_type =3D POWER_SUPPLY_USB_TYPE_CDP;
> +		break;
> +	case MT6360_CHG_TYPE_DCP:
> +		mci->psy_usb_type =3D POWER_SUPPLY_USB_TYPE_DCP;
> +		break;
> +	case MT6360_CHG_TYPE_DISABLE_BC12:
> +		dev_dbg(mci->dev, "Received attach interrupt, bc12 detect not enable\n=
");
> +		goto out;
> +	default:
> +		dev_dbg(mci->dev, "Received attach interrupt, reserved address\n");
> +		goto out;
> +	}

I suppose the cases with dev_dbg should have

mci->psy_usb_type =3D POWER_SUPPLY_USB_TYPE_UNKNOWN;

> +	dev_dbg(mci->dev, "Received attach interrupt, chg_type =3D %d\n", mci->=
psy_usb_type);
> +	if (last_usb_type !=3D mci->psy_usb_type)
> +		power_supply_changed(mci->psy);
> +out:
> +	mutex_unlock(&mci->chgdet_lock);
> +	return IRQ_HANDLED;
> +}
> +
> +static void mt6360_handle_chrdet_ext_evt(struct mt6360_chg_info *mci)
> +{
> +	int ret;
> +	bool pwr_rdy;
> +
> +	mutex_lock(&mci->chgdet_lock);
> +	ret =3D mt6360_get_chrdet_ext_stat(mci, &pwr_rdy);
> +	if (ret < 0)
> +		goto out;
> +	if (mci->pwr_rdy =3D=3D pwr_rdy) {
> +		dev_dbg(mci->dev, "Received vbus interrupt, pwr_rdy is same(%d)\n", pw=
r_rdy);
> +		goto out;
> +	}
> +	mci->pwr_rdy =3D pwr_rdy;
> +	dev_dbg(mci->dev, "Received vbus interrupt, pwr_rdy =3D %d\n", pwr_rdy);
> +	if (!pwr_rdy) {
> +		mci->psy_usb_type =3D POWER_SUPPLY_USB_TYPE_UNKNOWN;
> +		power_supply_changed(mci->psy);
> +
> +	}
> +	ret =3D regmap_update_bits(mci->regmap,
> +				 MT6360_PMU_DEVICE_TYPE,
> +				 MT6360_USBCHGEN_MASK,
> +				 pwr_rdy ? MT6360_USBCHGEN_MASK : 0);
> +	if (ret < 0)
> +		goto out;
> +	mci->bc12_en =3D pwr_rdy;
> +out:
> +	mutex_unlock(&mci->chgdet_lock);
> +}
> +
> +static void mt6360_chrdet_work(struct work_struct *work)
> +{
> +	struct mt6360_chg_info *mci =3D (struct mt6360_chg_info *)container_of(
> +				     work, struct mt6360_chg_info, chrdet_work);
> +
> +	mt6360_handle_chrdet_ext_evt(mci);
> +}
> +
> +static irqreturn_t mt6360_pmu_chrdet_ext_evt_handler(int irq, void *data)
> +{
> +	struct mt6360_chg_info *mci =3D data;
> +
> +	mt6360_handle_chrdet_ext_evt(mci);
> +	return IRQ_HANDLED;
> +}
> +
> +static int mt6360_chg_irq_register(struct platform_device *pdev)
> +{
> +	const struct {
> +		const char *name;
> +		irq_handler_t handler;
> +	} irq_descs[] =3D {
> +		{ "attach_i", mt6360_pmu_attach_i_handler },
> +		{ "chrdet_ext_evt", mt6360_pmu_chrdet_ext_evt_handler }
> +	};
> +	int i, ret;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(irq_descs); i++) {
> +		ret =3D platform_get_irq_byname(pdev, irq_descs[i].name);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret =3D devm_request_threaded_irq(&pdev->dev, ret, NULL,
> +						irq_descs[i].handler,
> +						IRQF_TRIGGER_FALLING,
> +						irq_descs[i].name,
> +						platform_get_drvdata(pdev));
> +		if (ret < 0)
> +			return dev_err_probe(&pdev->dev, ret, "Failed to request %s irq\n",
> +					     irq_descs[i].name);

Missing IRQF_ONESHOT

> +	}
> +
> +	return 0;
> +}
> +
> +struct mt6360_field_info {
> +	struct device_attribute dev_attr;
> +	u16 reg;
> +	u8 mask;
> +	u8 shft;
> +};
> +
> +static int mt6360_chg_init_setting(struct mt6360_chg_info *mci)
> +{
> +	int ret;
> +
> +	ret =3D regmap_update_bits(mci->regmap, MT6360_PMU_DEVICE_TYPE,
> +				 MT6360_USBCHGEN_MASK, 0);
> +	if (ret)
> +		return dev_err_probe(mci->dev, ret, "%s: Failed to disable bc12\n", __=
func__);
> +	ret =3D regmap_update_bits(mci->regmap, MT6360_PMU_CHG_CTRL2,
> +				 MT6360_IINLMTSEL_MASK,
> +				 MT6360_IINLMTSEL_AICR <<
> +					MT6360_IINLMTSEL_SHFT);
> +	if (ret)
> +		return dev_err_probe(mci->dev, ret,
> +				     "%s: Failed to switch iinlmtsel to aicr\n", __func__);
> +	usleep_range(5000, 6000);
> +	ret =3D regmap_update_bits(mci->regmap, MT6360_PMU_CHG_CTRL3,
> +				 MT6360_ILIM_EN_MASK, 0);
> +	if (ret)
> +		return dev_err_probe(mci->dev, ret,
> +				     "%s: Failed to disable ilim\n", __func__);
> +	ret =3D regmap_update_bits(mci->regmap, MT6360_PMU_CHG_CTRL10,
> +				 MT6360_OTG_OC_MASK, MT6360_OTG_OC_MASK);
> +	if (ret)
> +		return dev_err_probe(mci->dev, ret,
> +				     "%s: Failed to config otg oc to 3A\n", __func__);
> +	return 0;
> +}
> +
> +static u32 mt6360_vinovp_trans_to_sel(u32 val)
> +{
> +	u32 vinovp_tbl[] =3D { 5500000, 6500000, 11000000, 14500000 };
> +	int i;
> +
> +	/* Select the smaller and equal supported value */
> +	for (i =3D 0; i < ARRAY_SIZE(vinovp_tbl)-1; i++) {
> +		if (val < vinovp_tbl[i+1])
> +			break;
> +	}
> +	return i;
> +}
> +
> +static int mt6360_parse_dt(struct platform_device *pdev)
> +{
> +	struct mt6360_chg_info *mci =3D dev_get_drvdata(&pdev->dev);
> +	int ret;
> +
> +	ret =3D device_property_read_u32(&pdev->dev, "richtek,vinovp-microvolt"=
, &mci->vinovp);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "Failed to parse vinovp in DT\n"=
);
> +	return ret;
> +}
> +
> +static int mt6360_apply_dt(struct platform_device *pdev)
> +{
> +	struct mt6360_chg_info *mci =3D dev_get_drvdata(&pdev->dev);
> +	u32 sel;
> +
> +	sel =3D mt6360_vinovp_trans_to_sel(mci->vinovp);
> +	return regmap_update_bits(mci->regmap, MT6360_PMU_CHG_CTRL19,
> +				  MT6360_VINOVP_MASK, sel << MT6360_VINOVP_SHFT);
> +}
> +
> +static int mt6360_charger_probe(struct platform_device *pdev)
> +{
> +	struct mt6360_chg_info *mci;
> +	struct power_supply_config charger_cfg =3D {};
> +	struct regulator_config config =3D { };
> +	int ret;
> +
> +	mci =3D devm_kzalloc(&pdev->dev, sizeof(*mci), GFP_KERNEL);
> +	if (!mci)
> +		return -ENOMEM;
> +
> +	ret =3D mt6360_parse_dt(pdev);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "Failed to parse dt\n");

Just directly call device_property_read_u32() here. No need for
extra complexity.

> +	mci->dev =3D &pdev->dev;
> +	mci->vinovp =3D 6500000;

You are overwriting the value provided by device_property_* here.
You need to call it after initializing the value.=20

> +	mutex_init(&mci->chgdet_lock);
> +	platform_set_drvdata(pdev, mci);
> +	INIT_WORK(&mci->chrdet_work, &mt6360_chrdet_work);
> +
> +	mci->regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!mci->regmap)
> +		return dev_err_probe(&pdev->dev, -ENODEV, "Failed to get parent regmap=
\n");
> +
> +	ret =3D mt6360_apply_dt(pdev);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "Failed to apply dt\n");

Either rename to something like mt6360_apply_config
(device_property_* also supports e.g. ACPI), or just
drop the function and do the config here. Is there
any reason to initialize this value early? Otherwise
just merge this function into mt6360_chg_init_setting().

> +	memcpy(&mci->psy_desc, &mt6360_charger_desc, sizeof(mci->psy_desc));
> +	mci->psy_desc.name =3D dev_name(&pdev->dev);
> +	charger_cfg.drv_data =3D mci;
> +	charger_cfg.of_node =3D pdev->dev.of_node;
> +	mci->psy =3D devm_power_supply_register(&pdev->dev,
> +					      &mci->psy_desc, &charger_cfg);
> +	if (IS_ERR(mci->psy))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(mci->psy),
> +				     "Failed to register power supply dev\n");
> +
> +	ret =3D mt6360_chg_init_setting(mci);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "Failed to initial setting\n");
> +
> +	schedule_work(&mci->chrdet_work);

Missing work cleanup on probe error or driver removal?

> +	ret =3D mt6360_chg_irq_register(pdev);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "Failed to register irqs\n");
> +
> +	config.dev =3D &pdev->dev;
> +	config.regmap =3D mci->regmap;
> +	mci->otg_rdev =3D devm_regulator_register(&pdev->dev, &mt6360_otg_rdesc,
> +						&config);
> +	if (IS_ERR(mci->otg_rdev))
> +		return PTR_ERR(mci->otg_rdev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id __maybe_unused mt6360_charger_of_id[] =
=3D {
> +	{ .compatible =3D "mediatek,mt6360-chg", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mt6360_charger_of_id);
> +
> +static const struct platform_device_id mt6360_charger_id[] =3D {
> +	{ "mt6360-chg", 0 },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(platform, mt6360_charger_id);
> +
> +static struct platform_driver mt6360_charger_driver =3D {
> +	.driver =3D {
> +		.name =3D "mt6360-chg",
> +		.of_match_table =3D of_match_ptr(mt6360_charger_of_id),
> +	},
> +	.probe =3D mt6360_charger_probe,
> +	.id_table =3D mt6360_charger_id,
> +};
> +module_platform_driver(mt6360_charger_driver);
> +
> +MODULE_AUTHOR("Gene Chen <gene_chen@richtek.com>");
> +MODULE_DESCRIPTION("MT6360 Charger Driver");
> +MODULE_LICENSE("GPL");

-- Sebastian

--rp6csmjucqhiijpy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBnBqoACgkQ2O7X88g7
+prJZg/9E9bk+M/NbhMnJbp/Rlur93o3f37H06FrwTsQ9MmrpNjl8EkPih2tapt8
woFFRL1YeE52oNhqj798gl+Y/VhrrvxFfiXGXqxu2W0G4eeBkO/r53sRnM4xmHWS
h7suuYx6JFTdSmsmFzt+Y6ExZ1CEkgNMdMbv5eUyswtUkx/s8kKVKrz0+vn8JHws
4yo+K/dV/NLf+yxZpJEaTTlF2CMJSzgpvaIw6ypceJQArucHF+YCpM436uVIlIhZ
2vx7u1ugtLAAVdej7n1naXDm0qR+a9ZVSB3N0diNzteX8QsDeSOndyUYLBOy80Go
usUFjKB6ykiJRogjMuzH5+W6uvPg7DLptRIXtSJcrznK2VEE8gfsYyVa5WCaRoKy
Toj9ITgD7Og6p/heukxyB0xh4A6ISbukyVrJDzcrfhcJ1V0gzM1Ktl1hmy//Jbn4
Ls4qoTSTl8bfT3hwt0I/F+rFVEUwZ8U+ZPOMq9iuf3zjLVTyvLA3mVbT0uXpO/8a
I9am5Jc57dBedYCXXfiYkwLRNYylYHYxQdO6UGj9q0zybpmzevAzeuB7p+NdVjzG
dcTPI5VH5ASzJf9jemZP6TeuG5vtN2QGzQyPFZ5mqWzh3FtlVuM99gOn/9X+MPIy
cbsK6XlrbaMqxaIhefTnVZlDhtXGgtyzwRnmmcjTDUHbDMyA+qM=
=/vXH
-----END PGP SIGNATURE-----

--rp6csmjucqhiijpy--
