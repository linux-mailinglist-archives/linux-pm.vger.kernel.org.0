Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C132B8A11
	for <lists+linux-pm@lfdr.de>; Thu, 19 Nov 2020 03:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbgKSCYo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Nov 2020 21:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgKSCYn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2020 21:24:43 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B64C0613D4;
        Wed, 18 Nov 2020 18:24:43 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id q206so4623167oif.13;
        Wed, 18 Nov 2020 18:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RpsYpPplpfGhJJ/z3qEw/spsbZ7fqjh7G2L0NP853Vc=;
        b=rLxAeKfyXmW5n1SsVooI8Ak/n6PrM4za830OkEDJeRUwgyjHquiUaAWBJ5ACepJrPN
         Id1IA6GBvGAS/GyVVuCwxdhuWS+jg2+Wu7y5h66fFC6+R6Egoyyh4TgNnkZ0HWpm0Lgs
         g9QPWvGtelwT2EB71jvdpamM91/anq9YSg6TD7CP5mUXswMvn6WBWZhVwwqhBkxn80ky
         lg9cryaABFtYVReOZ5S8RXbS5IuqhCyg8zAWZmj0cSecASIpveaOevtvnUhUSBlluEOA
         SwRD5bxyPYC+4EgWhUueOO9HvaOwklXKxpMd7Move24G34S2JQMjuaSceouVwoy3oRA/
         qEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RpsYpPplpfGhJJ/z3qEw/spsbZ7fqjh7G2L0NP853Vc=;
        b=R5QuXb5qz+SOis15jd3VUHvjOZmFObFEw/dpmxXoFVRvZWFEb2X1yvgNRhPvRxtC2u
         vIwRXEXdvKiuPocpYT0sOoSFVLx5aVVuHVeAoqKwLUe1m8a/x8zmaqz45ROERuKY7T6M
         Q5GglECJzXDbtaPzrUmIXM8pbGdPLGqV0LMgoshvCrqsTZN5EzcOdiEl+GG25p8BHCjN
         uh3mVp0a95UjO350DcdqljGdVGLIAl5F+vA68iPhn9NWXjQeRWYDkH2fJW08T0zc88Hi
         kGbjipNabXRouOUmnVAh/yNFtSTXGINiYy7IJrKIiD6lxP3YAvvty+DwzolXT3zMWV5k
         Buhw==
X-Gm-Message-State: AOAM530FiB/ZQlUpSQXQt5D7V2k9IeMZKovV6q0xfxURhu5prHSUGGQN
        wCkFyw+bnTMkErBLYA+FsGWRI9eleCIWNL/8k9I=
X-Google-Smtp-Source: ABdhPJyZmloplHnrfK84HwSV0H6YCNWitHrnbev5LXSpG4kt8wxcGaU2VN7xzsHpIHTIG6ksvlpvwNTfUoVBTrAKZkA=
X-Received: by 2002:aca:c209:: with SMTP id s9mr1354303oif.55.1605752682369;
 Wed, 18 Nov 2020 18:24:42 -0800 (PST)
MIME-Version: 1.0
References: <1604400091-14618-1-git-send-email-gene.chen.richtek@gmail.com> <1604400091-14618-3-git-send-email-gene.chen.richtek@gmail.com>
In-Reply-To: <1604400091-14618-3-git-send-email-gene.chen.richtek@gmail.com>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Thu, 19 Nov 2020 10:24:30 +0800
Message-ID: <CAE+NS372XuPFyvxqQDrmxPT9DJUnMwBe3t9wJBOVdLB79VRtqg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] power: supply: mt6360_charger: add MT6360 charger support
To:     sre@kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gene Chen <gene_chen@richtek.com>, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear Reviewers,

   Please let me know if there is anything need to be revised.

Gene Chen <gene.chen.richtek@gmail.com> =E6=96=BC 2020=E5=B9=B411=E6=9C=883=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=886:41=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> From: Gene Chen <gene_chen@richtek.com>
>
> Add basic support for the battery charger for MT6360 PMIC
>
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  drivers/power/supply/Kconfig          |   10 +
>  drivers/power/supply/Makefile         |    1 +
>  drivers/power/supply/mt6360_charger.c | 1022 +++++++++++++++++++++++++++=
++++++
>  3 files changed, 1033 insertions(+)
>  create mode 100644 drivers/power/supply/mt6360_charger.c
>
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index faf2830..e2d53a3 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -562,6 +562,16 @@ config CHARGER_MP2629
>           Battery charger. This driver provides Battery charger power man=
agement
>           functions on the systems.
>
> +config CHARGER_MT6360
> +       tristate "Mediatek MT6360 Charger Driver"
> +       depends on MFD_MT6360
> +       depends on REGULATOR
> +       help
> +         Say Y here to enable MT6360 Charger Part.
> +         The device supports High-Accuracy Voltage/Current Regulation,
> +         Average Input Current Regulation, Battery Tempature Sensing,
> +         Over-Temperature Protection, DPDM Detection for BC1.2
> +
>  config CHARGER_QCOM_SMBB
>         tristate "Qualcomm Switch-Mode Battery Charger and Boost"
>         depends on MFD_SPMI_PMIC || COMPILE_TEST
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefil=
e
> index b3c694a..9abecb9c 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -77,6 +77,7 @@ obj-$(CONFIG_CHARGER_MAX77693)        +=3D max77693_cha=
rger.o
>  obj-$(CONFIG_CHARGER_MAX8997)  +=3D max8997_charger.o
>  obj-$(CONFIG_CHARGER_MAX8998)  +=3D max8998_charger.o
>  obj-$(CONFIG_CHARGER_MP2629)   +=3D mp2629_charger.o
> +obj-$(CONFIG_CHARGER_MT6360)   +=3D mt6360_charger.o
>  obj-$(CONFIG_CHARGER_QCOM_SMBB)        +=3D qcom_smbb.o
>  obj-$(CONFIG_CHARGER_BQ2415X)  +=3D bq2415x_charger.o
>  obj-$(CONFIG_CHARGER_BQ24190)  +=3D bq24190_charger.o
> diff --git a/drivers/power/supply/mt6360_charger.c b/drivers/power/supply=
/mt6360_charger.c
> new file mode 100644
> index 0000000..5631875
> --- /dev/null
> +++ b/drivers/power/supply/mt6360_charger.c
> @@ -0,0 +1,1022 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 MediaTek Inc.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/regmap.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/interrupt.h>
> +#include <linux/power_supply.h>
> +#include <linux/regulator/driver.h>
> +
> +#define MT6360_PMU_CHG_CTRL1   0x311
> +#define MT6360_PMU_CHG_CTRL2   0x312
> +#define MT6360_PMU_CHG_CTRL3   0x313
> +#define MT6360_PMU_CHG_CTRL4   0x314
> +#define MT6360_PMU_CHG_CTRL5   0x315
> +#define MT6360_PMU_CHG_CTRL6   0x316
> +#define MT6360_PMU_CHG_CTRL7   0x317
> +#define MT6360_PMU_CHG_CTRL8   0x318
> +#define MT6360_PMU_CHG_CTRL9   0x319
> +#define MT6360_PMU_CHG_CTRL10  0x31A
> +#define MT6360_PMU_CHG_CTRL11  0x31B
> +#define MT6360_PMU_CHG_CTRL12  0x31C
> +#define MT6360_PMU_CHG_CTRL13  0x31D
> +#define MT6360_PMU_DEVICE_TYPE 0x322
> +#define MT6360_PMU_USB_STATUS1 0x327
> +#define MT6360_PMU_CHG_CTRL17  0x32B
> +#define MT6360_PMU_CHG_CTRL18  0x32C
> +#define MT6360_PMU_CHG_STAT    0x34A
> +#define MT6360_PMU_CHG_CTRL19  0x361
> +#define MT6360_PMU_FOD_STAT    0x3E7
> +
> +/* MT6360_PMU_CHG_CTRL1 */
> +#define MT6360_FSLP_SHFT       (3)
> +#define MT6360_FSLP_MASK       BIT(MT6360_FSLP_SHFT)
> +#define MT6360_HIZ_SHFT                (2)
> +#define MT6360_HIZ_MASK                BIT(MT6360_HIZ_SHFT)
> +#define MT6360_OPA_MODE_SHFT   (0)
> +#define MT6360_OPA_MODE_MASK   BIT(MT6360_OPA_MODE_SHFT)
> +/* MT6360_PMU_CHG_CTRL2 */
> +#define MT6360_TE_SHFT         (4)
> +#define MT6360_TE_MASK         BIT(MT6360_TE_SHFT)
> +#define MT6360_IINLMTSEL_SHFT  (2)
> +#define MT6360_IINLMTSEL_MASK  GENMASK(3, 2)
> +#define MT6360_CHG_EN_SHFT     (0)
> +#define MT6360_CHG_EN_MASK     BIT(MT6360_CHG_EN_SHFT)
> +/* MT6360_PMU_CHG_CTRL3 */
> +#define MT6360_IAICR_SHFT      (2)
> +#define MT6360_IAICR_MASK      GENMASK(7, 2)
> +#define MT6360_ILIM_EN_MASK    BIT(0)
> +/* MT6360_PMU_CHG_CTRL4 */
> +#define MT6360_VOREG_SHFT      (1)
> +#define MT6360_VOREG_MASK      GENMASK(7, 1)
> +/* MT6360_PMU_CHG_CTRL5 */
> +#define MT6360_VOBST_MASK      GENMASK(7, 2)
> +/* MT6360_PMU_CHG_CTRL6 */
> +#define MT6360_VMIVR_SHFT      (1)
> +#define MT6360_VMIVR_MASK      GENMASK(7, 1)
> +/* MT6360_PMU_CHG_CTRL7 */
> +#define MT6360_ICHG_SHFT       (2)
> +#define MT6360_ICHG_MASK       GENMASK(7, 2)
> +/* MT6360_PMU_CHG_CTRL8 */
> +#define MT6360_IPREC_SHFT      (0)
> +#define MT6360_IPREC_MASK      GENMASK(3, 0)
> +/* MT6360_PMU_CHG_CTRL9 */
> +#define MT6360_IEOC_SHFT       (4)
> +#define MT6360_IEOC_MASK       GENMASK(7, 4)
> +/* MT6360_PMU_CHG_CTRL10 */
> +#define MT6360_LBP_SHFT                (4)
> +#define MT6360_LBP_MASK                GENMASK(7, 4)
> +#define MT6360_OTG_OC_SHFT     (0)
> +#define MT6360_OTG_OC_MASK     GENMASK(3, 0)
> +/* MT6360_PMU_CHG_CTRL11 */
> +#define MT6360_SYSREG_SHFT     (2)
> +#define MT6360_SYSREG_MASK     GENMASK(4, 2)
> +#define MT6360_VREC_SHFT       (0)
> +#define MT6360_VREC_MASK       GENMASK(2, 0)
> +/* MT6360_PMU_CHG_CTRL12 */
> +#define MT6360_WT_FC_SHFT      (5)
> +#define MT6360_WT_FC_MASK      GENMASK(7, 5)
> +/* MT6360_PMU_CHG_CTRL13 */
> +#define MT6360_CHG_WDT_EN_SHFT (7)
> +#define MT6360_CHG_WDT_EN_MASK BIT(MT6360_CHG_WDT_EN_SHFT)
> +#define MT6360_CHG_WDT_SHFT    (4)
> +#define MT6360_CHG_WDT_MASK    GENMASK(5, 4)
> +/* MT6360_PMU_DEVICE_TYPE */
> +#define MT6360_USBCHGEN_SHFT   (7)
> +#define MT6360_USBCHGEN_MASK   BIT(MT6360_USBCHGEN_SHFT)
> +/* MT6360_PMU_USB_STATUS1 */
> +#define MT6360_USB_STATUS_SHFT (4)
> +#define MT6360_USB_STATUS_MASK GENMASK(6, 4)
> +/* MT6360_PMU_CHG_CTRL18 */
> +#define MT6360_BAT_COMP_SHFT   (3)
> +#define MT6360_BAT_COMP_MASK   GENMASK(5, 3)
> +#define MT6360_VCLAMP_SHFT     (0)
> +#define MT6360_VCLAMP_MASK     GENMASK(2, 0)
> +/* MT6360_PMU_CHG_STAT */
> +#define MT6360_CHG_STAT_SHFT   (6)
> +#define MT6360_CHG_STAT_MASK   GENMASK(7, 6)
> +#define MT6360_VBAT_LVL_MASK   BIT(5)
> +/* MT6360_PMU_CHG_CTRL19 */
> +#define MT6360_VINOVP_SHFT     (5)
> +#define MT6360_VINOVP_MASK     GENMASK(6, 5)
> +/* MT6360_PMU_FOD_STAT */
> +#define MT6360_CHRDET_EXT_SHFT (4)
> +#define MT6360_CHRDET_EXT_MASK BIT(4)
> +
> +/* uA */
> +#define MT6360_ICHG_MIN                100000
> +#define MT6360_ICHG_MAX                5000000
> +#define MT6360_ICHG_STEP       100000
> +/* uV */
> +#define MT6360_VOREG_MIN       3900000
> +#define MT6360_VOREG_MAX       4710000
> +#define MT6360_VOREG_STEP      10000
> +/* uA */
> +#define MT6360_AICR_MIN                100000
> +#define MT6360_AICR_MAX                3250000
> +#define MT6360_AICR_STEP       50000
> +/* uA */
> +#define MT6360_IPREC_MIN       100000
> +#define MT6360_IPREC_MAX       850000
> +#define MT6360_IPREC_STEP      50000
> +/* uA */
> +#define MT6360_IEOC_MIN                100000
> +#define MT6360_IEOC_MAX                850000
> +#define MT6360_IEOC_STEP       50000
> +
> +struct mt6360_chg_platform_data {
> +       u32 vinovp;
> +};
> +
> +struct mt6360_chg_info {
> +       struct device *dev;
> +       struct mt6360_chg_platform_data *pdata;
> +       struct regmap *regmap;
> +       struct power_supply_desc psy_desc;
> +       struct power_supply *psy;
> +       struct regulator_dev *otg_rdev;
> +       struct mutex chgdet_lock;
> +       bool pwr_rdy;
> +       bool bc12_en;
> +       int psy_usb_type;
> +       struct work_struct chrdet_work;
> +};
> +
> +static struct mt6360_chg_platform_data def_platform_data =3D {
> +       .vinovp =3D 6500000,
> +};
> +
> +enum mt6360_iinlmtsel {
> +       MT6360_IINLMTSEL_AICR_3250 =3D 0,
> +       MT6360_IINLMTSEL_CHG_TYPE,
> +       MT6360_IINLMTSEL_AICR,
> +       MT6360_IINLMTSEL_LOWER_LEVEL,
> +};
> +
> +enum mt6360_pmu_chg_type {
> +       MT6360_CHG_TYPE_NOVBUS =3D 0,
> +       MT6360_CHG_TYPE_UNDER_GOING,
> +       MT6360_CHG_TYPE_SDP,
> +       MT6360_CHG_TYPE_SDPNSTD,
> +       MT6360_CHG_TYPE_DCP,
> +       MT6360_CHG_TYPE_CDP,
> +       MT6360_CHG_TYPE_MAX,
> +};
> +
> +static enum power_supply_usb_type mt6360_charger_usb_types[] =3D {
> +       POWER_SUPPLY_USB_TYPE_UNKNOWN,
> +       POWER_SUPPLY_USB_TYPE_SDP,
> +       POWER_SUPPLY_USB_TYPE_DCP,
> +       POWER_SUPPLY_USB_TYPE_CDP,
> +       POWER_SUPPLY_USB_TYPE_C,
> +       POWER_SUPPLY_USB_TYPE_PD,
> +       POWER_SUPPLY_USB_TYPE_PD_DRP,
> +       POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID
> +};
> +
> +static unsigned int mt6360_trans_reg_sel(u32 data, u32 min_val, u32 step=
,
> +                                               u32 max_sel)
> +{
> +       unsigned int target =3D 0;
> +
> +       if (data >=3D min_val)
> +               target =3D (data - min_val) / step;
> +       if (target > max_sel)
> +               target =3D max_sel;
> +       return target;
> +}
> +
> +static int mt6360_get_chrdet_ext_stat(struct mt6360_chg_info *mci,
> +                                            bool *pwr_rdy)
> +{
> +       int ret;
> +       unsigned int regval;
> +
> +       ret =3D regmap_read(mci->regmap, MT6360_PMU_FOD_STAT, &regval);
> +       if (ret < 0)
> +               return ret;
> +       *pwr_rdy =3D (regval & MT6360_CHRDET_EXT_MASK) ? true : false;
> +       return 0;
> +}
> +
> +static int mt6360_charger_get_online(struct mt6360_chg_info *mci,
> +                                    union power_supply_propval *val)
> +{
> +       int ret;
> +       bool pwr_rdy;
> +
> +       ret =3D mt6360_get_chrdet_ext_stat(mci, &pwr_rdy);
> +       if (ret < 0)
> +               return ret;
> +       val->intval =3D pwr_rdy ? true : false;
> +       return 0;
> +}
> +
> +static int mt6360_charger_get_status(struct mt6360_chg_info *mci,
> +                                    union power_supply_propval *val)
> +{
> +       int status, ret;
> +       unsigned int regval;
> +       bool pwr_rdy;
> +
> +       ret =3D mt6360_get_chrdet_ext_stat(mci, &pwr_rdy);
> +       if (ret < 0)
> +               return ret;
> +       if (!pwr_rdy) {
> +               status =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +               goto out;
> +       }
> +
> +       ret =3D regmap_read(mci->regmap, MT6360_PMU_CHG_STAT, &regval);
> +       if (ret < 0)
> +               return ret;
> +       regval &=3D MT6360_CHG_STAT_MASK;
> +       regval >>=3D MT6360_CHG_STAT_SHFT;
> +       switch (regval) {
> +       case 0x0:
> +               status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +               break;
> +       case 0x1:
> +               status =3D POWER_SUPPLY_STATUS_CHARGING;
> +               break;
> +       case 0x2:
> +               status =3D POWER_SUPPLY_STATUS_FULL;
> +               break;
> +       default:
> +               ret =3D -EIO;
> +       }
> +out:
> +       if (!ret)
> +               val->intval =3D status;
> +       return ret;
> +}
> +
> +static int mt6360_charger_get_charge_type(struct mt6360_chg_info *mci,
> +                                         union power_supply_propval *val=
)
> +{
> +       int type, ret;
> +       unsigned int regval;
> +       u8 chg_stat;
> +
> +       ret =3D regmap_read(mci->regmap, MT6360_PMU_CHG_STAT, &regval);
> +       if (ret < 0)
> +               return ret;
> +
> +       chg_stat =3D (regval & MT6360_CHG_STAT_MASK) >> MT6360_CHG_STAT_S=
HFT;
> +       switch (chg_stat) {
> +       case 0x01: /* Charge in Progress */
> +               if (regval & MT6360_VBAT_LVL_MASK)
> +                       type =3D POWER_SUPPLY_CHARGE_TYPE_FAST;
> +               else
> +                       type =3D POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
> +               break;
> +       case 0x00: /* Not Charging */
> +       case 0x02: /* Charge Done */
> +       case 0x03: /* Charge Fault */
> +       default:
> +               type =3D POWER_SUPPLY_CHARGE_TYPE_NONE;
> +               break;
> +       }
> +
> +       val->intval =3D type;
> +       return 0;
> +}
> +
> +static int mt6360_charger_get_ichg(struct mt6360_chg_info *mci,
> +                                  union power_supply_propval *val)
> +{
> +       int ichg, ret;
> +       unsigned int regval;
> +
> +       ret =3D regmap_read(mci->regmap, MT6360_PMU_CHG_CTRL7, &regval);
> +       if (ret < 0)
> +               return ret;
> +       regval =3D (regval & MT6360_ICHG_MASK) >> MT6360_ICHG_SHFT;
> +       ichg =3D MT6360_ICHG_MIN + (regval * MT6360_ICHG_STEP);
> +       if (ichg > MT6360_ICHG_MAX)
> +               ichg =3D MT6360_ICHG_MAX;
> +       val->intval =3D ichg;
> +       return 0;
> +}
> +
> +static int mt6360_charger_get_max_ichg(struct mt6360_chg_info *mci,
> +                                      union power_supply_propval *val)
> +{
> +       val->intval =3D MT6360_ICHG_MAX;
> +       return 0;
> +}
> +
> +static int mt6360_charger_get_cv(struct mt6360_chg_info *mci,
> +                                union power_supply_propval *val)
> +{
> +       int cv, ret;
> +       unsigned int regval;
> +
> +       ret =3D regmap_read(mci->regmap, MT6360_PMU_CHG_CTRL4, &regval);
> +       if (ret < 0)
> +               return ret;
> +       regval =3D (regval & MT6360_VOREG_MASK) >> MT6360_VOREG_SHFT;
> +       cv =3D MT6360_VOREG_MIN + (regval * MT6360_VOREG_STEP);
> +       if (cv > MT6360_VOREG_MAX)
> +               cv =3D MT6360_VOREG_MAX;
> +       val->intval =3D cv;
> +       return 0;
> +}
> +
> +static int mt6360_charger_get_max_cv(struct mt6360_chg_info *mci,
> +                                    union power_supply_propval *val)
> +{
> +       val->intval =3D MT6360_VOREG_MAX;
> +       return 0;
> +}
> +
> +static int mt6360_charger_get_aicr(struct mt6360_chg_info *mci,
> +                                  union power_supply_propval *val)
> +{
> +       int ret;
> +       unsigned int regval;
> +
> +       ret =3D regmap_read(mci->regmap, MT6360_PMU_CHG_CTRL3, &regval);
> +       if (ret < 0)
> +               return ret;
> +       regval =3D (regval & MT6360_IAICR_MASK) >> MT6360_IAICR_SHFT;
> +       val->intval =3D MT6360_AICR_MIN + (regval * MT6360_AICR_STEP);
> +       return 0;
> +}
> +
> +static int mt6360_charger_get_iprechg(struct mt6360_chg_info *mci,
> +                                     union power_supply_propval *val)
> +{
> +       int ret;
> +       unsigned int regval;
> +
> +       ret =3D regmap_read(mci->regmap, MT6360_PMU_CHG_CTRL8, &regval);
> +       if (ret < 0)
> +               return ret;
> +       regval =3D (regval & MT6360_IPREC_MASK) >> MT6360_IPREC_SHFT;
> +       val->intval =3D MT6360_IPREC_MIN + (regval * MT6360_IPREC_STEP);
> +       return 0;
> +}
> +
> +static int mt6360_charger_get_ieoc(struct mt6360_chg_info *mci,
> +                                  union power_supply_propval *val)
> +{
> +       int ret;
> +       unsigned int regval;
> +
> +       ret =3D regmap_read(mci->regmap, MT6360_PMU_CHG_CTRL9, &regval);
> +       if (ret < 0)
> +               return ret;
> +       regval =3D (regval & MT6360_IEOC_MASK) >> MT6360_IEOC_SHFT;
> +       val->intval =3D MT6360_IEOC_MIN + (regval * MT6360_IEOC_STEP);
> +       return 0;
> +}
> +
> +static int mt6360_charger_set_online(struct mt6360_chg_info *mci,
> +                                    const union power_supply_propval *va=
l)
> +{
> +       u8 force_sleep =3D val->intval ? 0 : 1;
> +
> +       return regmap_update_bits(mci->regmap, MT6360_PMU_CHG_CTRL1,
> +                                 MT6360_FSLP_MASK,
> +                                 force_sleep << MT6360_FSLP_SHFT);
> +}
> +
> +static int mt6360_charger_set_ichg(struct mt6360_chg_info *mci,
> +                                  const union power_supply_propval *val)
> +{
> +       unsigned int regval;
> +
> +       regval =3D mt6360_trans_reg_sel(val->intval, 100000, 100000, 0x31=
);
> +       return regmap_update_bits(mci->regmap, MT6360_PMU_CHG_CTRL7,
> +                                 MT6360_ICHG_MASK, regval << MT6360_ICHG=
_SHFT);
> +}
> +
> +static int mt6360_charger_set_cv(struct mt6360_chg_info *mci,
> +                                const union power_supply_propval *val)
> +{
> +       unsigned int regval;
> +
> +       regval =3D mt6360_trans_reg_sel(val->intval, 3900000, 10000, 0x51=
);
> +       return regmap_update_bits(mci->regmap,
> +                                 MT6360_PMU_CHG_CTRL4,
> +                                 MT6360_VOREG_MASK,
> +                                 regval << MT6360_VOREG_SHFT);
> +}
> +
> +static int mt6360_charger_set_aicr(struct mt6360_chg_info *mci,
> +                                  const union power_supply_propval *val)
> +{
> +       unsigned int regval;
> +
> +       regval =3D mt6360_trans_reg_sel(val->intval, 100000, 50000, 0x3F)=
;
> +       return regmap_update_bits(mci->regmap,
> +                                 MT6360_PMU_CHG_CTRL3,
> +                                 MT6360_IAICR_MASK,
> +                                 regval << MT6360_IAICR_SHFT);
> +}
> +
> +static int mt6360_charger_set_iprechg(struct mt6360_chg_info *mci,
> +                                     const union power_supply_propval *v=
al)
> +{
> +       unsigned int regval;
> +
> +       regval =3D mt6360_trans_reg_sel(val->intval, 100000, 50000, 0x0F)=
;
> +       return regmap_update_bits(mci->regmap,
> +                                 MT6360_PMU_CHG_CTRL8,
> +                                 MT6360_IPREC_MASK,
> +                                 regval << MT6360_IPREC_SHFT);
> +}
> +
> +static int mt6360_charger_set_ieoc(struct mt6360_chg_info *mci,
> +                                  const union power_supply_propval *val)
> +{
> +       unsigned int regval;
> +
> +       regval =3D mt6360_trans_reg_sel(val->intval, 100000, 50000, 0x0F)=
;
> +       return regmap_update_bits(mci->regmap,
> +                                 MT6360_PMU_CHG_CTRL9,
> +                                 MT6360_IEOC_MASK,
> +                                 regval << MT6360_IEOC_SHFT);
> +}
> +
> +static int mt6360_charger_get_property(struct power_supply *psy,
> +                                      enum power_supply_property psp,
> +                                      union power_supply_propval *val)
> +{
> +       struct mt6360_chg_info *mci =3D power_supply_get_drvdata(psy);
> +       int ret =3D 0;
> +
> +       dev_dbg(mci->dev, "%s: prop =3D %d\n", __func__, psp);
> +       switch (psp) {
> +       case POWER_SUPPLY_PROP_ONLINE:
> +               ret =3D mt6360_charger_get_online(mci, val);
> +               break;
> +       case POWER_SUPPLY_PROP_STATUS:
> +               ret =3D mt6360_charger_get_status(mci, val);
> +               break;
> +       case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +               ret =3D mt6360_charger_get_charge_type(mci, val);
> +               break;
> +       case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +               ret =3D mt6360_charger_get_ichg(mci, val);
> +               break;
> +       case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> +               ret =3D mt6360_charger_get_max_ichg(mci, val);
> +               break;
> +       case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> +               ret =3D mt6360_charger_get_cv(mci, val);
> +               break;
> +       case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
> +               ret =3D mt6360_charger_get_max_cv(mci, val);
> +               break;
> +       case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +               ret =3D mt6360_charger_get_aicr(mci, val);
> +               break;
> +       case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
> +               ret =3D mt6360_charger_get_iprechg(mci, val);
> +               break;
> +       case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
> +               ret =3D mt6360_charger_get_ieoc(mci, val);
> +               break;
> +       case POWER_SUPPLY_PROP_USB_TYPE:
> +               val->intval =3D mci->psy_usb_type;
> +               break;
> +       default:
> +               ret =3D -ENODATA;
> +       }
> +       return ret;
> +}
> +
> +static int mt6360_charger_set_property(struct power_supply *psy,
> +                                      enum power_supply_property psp,
> +                                      const union power_supply_propval *=
val)
> +{
> +       struct mt6360_chg_info *mci =3D power_supply_get_drvdata(psy);
> +       int ret;
> +
> +       dev_dbg(mci->dev, "%s: prop =3D %d\n", __func__, psp);
> +       switch (psp) {
> +       case POWER_SUPPLY_PROP_ONLINE:
> +               ret =3D mt6360_charger_set_online(mci, val);
> +               break;
> +       case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +               ret =3D mt6360_charger_set_ichg(mci, val);
> +               break;
> +       case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> +               ret =3D mt6360_charger_set_cv(mci, val);
> +               break;
> +       case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +               ret =3D mt6360_charger_set_aicr(mci, val);
> +               break;
> +       case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
> +               ret =3D mt6360_charger_set_iprechg(mci, val);
> +               break;
> +       case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
> +               ret =3D mt6360_charger_set_ieoc(mci, val);
> +               break;
> +       default:
> +               ret =3D -EINVAL;
> +       }
> +       return ret;
> +}
> +
> +static int mt6360_charger_property_is_writeable(struct power_supply *psy=
,
> +                                              enum power_supply_property=
 psp)
> +{
> +       switch (psp) {
> +       case POWER_SUPPLY_PROP_ONLINE:
> +       case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +       case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> +       case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +       case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
> +       case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
> +               return 1;
> +       default:
> +               return 0;
> +       }
> +}
> +
> +static enum power_supply_property mt6360_charger_properties[] =3D {
> +       POWER_SUPPLY_PROP_ONLINE,
> +       POWER_SUPPLY_PROP_STATUS,
> +       POWER_SUPPLY_PROP_CHARGE_TYPE,
> +       POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
> +       POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
> +       POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
> +       POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
> +       POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +       POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
> +       POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
> +       POWER_SUPPLY_PROP_USB_TYPE,
> +};
> +
> +static char *mt6360_charger_supplied_to[] =3D {
> +       "main-battery"
> +};
> +
> +static const struct power_supply_desc mt6360_charger_desc =3D {
> +       .type                   =3D POWER_SUPPLY_TYPE_USB,
> +       .properties             =3D mt6360_charger_properties,
> +       .num_properties         =3D ARRAY_SIZE(mt6360_charger_properties)=
,
> +       .get_property           =3D mt6360_charger_get_property,
> +       .set_property           =3D mt6360_charger_set_property,
> +       .property_is_writeable  =3D mt6360_charger_property_is_writeable,
> +       .usb_types              =3D mt6360_charger_usb_types,
> +       .num_usb_types          =3D ARRAY_SIZE(mt6360_charger_usb_types),
> +};
> +
> +static const struct regulator_ops mt6360_chg_otg_ops =3D {
> +       .list_voltage =3D regulator_list_voltage_linear,
> +       .enable =3D regulator_enable_regmap,
> +       .disable =3D regulator_disable_regmap,
> +       .is_enabled =3D regulator_is_enabled_regmap,
> +       .set_voltage_sel =3D regulator_set_voltage_sel_regmap,
> +       .get_voltage_sel =3D regulator_get_voltage_sel_regmap,
> +};
> +
> +static const struct regulator_desc mt6360_otg_rdesc =3D {
> +       .of_match =3D "usb-otg-vbus",
> +       .name =3D "usb-otg-vbus",
> +       .ops =3D &mt6360_chg_otg_ops,
> +       .owner =3D THIS_MODULE,
> +       .type =3D REGULATOR_VOLTAGE,
> +       .min_uV =3D 4425000,
> +       .uV_step =3D 25000, /* step  25mV */
> +       .n_voltages =3D 57, /* 4425mV to 5825mV */
> +       .vsel_reg =3D MT6360_PMU_CHG_CTRL5,
> +       .vsel_mask =3D MT6360_VOBST_MASK,
> +       .enable_reg =3D MT6360_PMU_CHG_CTRL1,
> +       .enable_mask =3D MT6360_OPA_MODE_MASK,
> +};
> +
> +static irqreturn_t mt6360_pmu_attach_i_handler(int irq, void *data)
> +{
> +       struct mt6360_chg_info *mci =3D data;
> +       int ret;
> +       unsigned int usb_status;
> +       int last_usb_type;
> +
> +       dev_dbg(mci->dev, "%s\n", __func__);
> +       mutex_lock(&mci->chgdet_lock);
> +       if (!mci->bc12_en) {
> +               dev_info(mci->dev, "%s: bc12 disabled, ignore irq\n", __f=
unc__);
> +               goto out;
> +       }
> +       last_usb_type =3D mci->psy_usb_type;
> +       /* Plug in */
> +       ret =3D regmap_read(mci->regmap, MT6360_PMU_USB_STATUS1, &usb_sta=
tus);
> +       if (ret < 0)
> +               goto out;
> +       usb_status &=3D MT6360_USB_STATUS_MASK;
> +       usb_status >>=3D MT6360_USB_STATUS_SHFT;
> +       switch (usb_status) {
> +       case MT6360_CHG_TYPE_UNDER_GOING:
> +               dev_info(mci->dev, "%s: under going...\n", __func__);
> +               goto out;
> +       case MT6360_CHG_TYPE_SDP:
> +               mci->psy_usb_type =3D POWER_SUPPLY_USB_TYPE_SDP;
> +               break;
> +       case MT6360_CHG_TYPE_SDPNSTD:
> +               mci->psy_usb_type =3D POWER_SUPPLY_USB_TYPE_SDP;
> +               break;
> +       case MT6360_CHG_TYPE_CDP:
> +               mci->psy_usb_type =3D POWER_SUPPLY_USB_TYPE_CDP;
> +               break;
> +       case MT6360_CHG_TYPE_DCP:
> +               mci->psy_usb_type =3D POWER_SUPPLY_USB_TYPE_DCP;
> +               break;
> +       default:
> +               dev_warn(mci->dev,
> +                        "%s: disconnect or unknown status\n", __func__);
> +               goto out;
> +       }
> +
> +       dev_info(mci->dev, "%s: chg_type =3D %d\n", __func__, mci->psy_us=
b_type);
> +       if (last_usb_type !=3D mci->psy_usb_type)
> +               power_supply_changed(mci->psy);
> +out:
> +       mutex_unlock(&mci->chgdet_lock);
> +       return IRQ_HANDLED;
> +}
> +
> +static void mt6360_handle_chrdet_ext_evt(struct mt6360_chg_info *mci)
> +{
> +       int ret;
> +       bool pwr_rdy;
> +       int last_usb_type;
> +
> +       mutex_lock(&mci->chgdet_lock);
> +       ret =3D mt6360_get_chrdet_ext_stat(mci, &pwr_rdy);
> +       if (ret < 0)
> +               goto out;
> +       if (mci->pwr_rdy =3D=3D pwr_rdy) {
> +               dev_info(mci->dev,
> +                        "%s: pwr_rdy is same(%d)\n", __func__, pwr_rdy);
> +               goto out;
> +       }
> +       mci->pwr_rdy =3D pwr_rdy;
> +       last_usb_type =3D mci->psy_usb_type;
> +       dev_info(mci->dev, "%s: pwr_rdy =3D %d\n", __func__, pwr_rdy);
> +       if (!pwr_rdy) {
> +               mci->psy_usb_type =3D POWER_SUPPLY_USB_TYPE_UNKNOWN;
> +               if (last_usb_type !=3D mci->psy_usb_type)
> +                       power_supply_changed(mci->psy);
> +
> +       }
> +       ret =3D regmap_update_bits(mci->regmap,
> +                                MT6360_PMU_DEVICE_TYPE,
> +                                MT6360_USBCHGEN_MASK,
> +                                pwr_rdy ? MT6360_USBCHGEN_MASK : 0);
> +       if (ret < 0)
> +               goto out;
> +       mci->bc12_en =3D pwr_rdy;
> +out:
> +       mutex_unlock(&mci->chgdet_lock);
> +}
> +
> +static void mt6360_chrdet_work(struct work_struct *work)
> +{
> +       struct mt6360_chg_info *mci =3D (struct mt6360_chg_info *)contain=
er_of(
> +                                    work, struct mt6360_chg_info, chrdet=
_work);
> +
> +       dev_info(mci->dev, "%s\n", __func__);
> +       mt6360_handle_chrdet_ext_evt(mci);
> +}
> +
> +static irqreturn_t mt6360_pmu_chrdet_ext_evt_handler(int irq, void *data=
)
> +{
> +       struct mt6360_chg_info *mci =3D data;
> +
> +       dev_info(mci->dev, "%s\n", __func__);
> +       mt6360_handle_chrdet_ext_evt(mci);
> +       return IRQ_HANDLED;
> +}
> +
> +static int mt6360_chg_irq_register(struct platform_device *pdev)
> +{
> +       const struct {
> +               const char *name;
> +               irq_handler_t handler;
> +       } irq_descs[] =3D {
> +               { "attach_i", mt6360_pmu_attach_i_handler },
> +               { "chrdet_ext_evt", mt6360_pmu_chrdet_ext_evt_handler }
> +       };
> +       int i, ret;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(irq_descs); i++) {
> +               ret =3D platform_get_irq_byname(pdev, irq_descs[i].name);
> +               if (ret < 0)
> +                       return ret;
> +
> +               ret =3D devm_request_threaded_irq(&pdev->dev, ret, NULL,
> +                                               irq_descs[i].handler,
> +                                               IRQF_TRIGGER_FALLING,
> +                                               irq_descs[i].name,
> +                                               platform_get_drvdata(pdev=
));
> +               if (ret < 0) {
> +                       dev_err(&pdev->dev,
> +                               "request %s irq fail\n", irq_descs[i].nam=
e);
> +                       return ret;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +struct mt6360_field_info {
> +       struct device_attribute dev_attr;
> +       u16 reg;
> +       u8 mask;
> +       u8 shft;
> +};
> +
> +static ssize_t mt6360_sysfs_show(struct device *dev,
> +               struct device_attribute *attr, char *buf);
> +static ssize_t mt6360_sysfs_store(struct device *dev,
> +               struct device_attribute *attr, const char *buf, size_t co=
unt);
> +
> +#define MT6360_FIELD_RW(_name, _reg, _nbit)                    \
> +{                                                              \
> +       .dev_attr =3D __ATTR(_name, 0664,                         \
> +                      mt6360_sysfs_show, mt6360_sysfs_store),  \
> +       .reg    =3D MT6360_PMU_##_reg,                            \
> +       .mask   =3D MT6360_##_nbit##_MASK,                               =
 \
> +       .shft   =3D MT6360_##_nbit##_SHFT,                               =
 \
> +}
> +
> +#define MT6360_FIELD_RO(_name, _reg, _nbit)                    \
> +{                                                              \
> +       .dev_attr =3D __ATTR(_name, 0444,                         \
> +                       mt6360_sysfs_show, NULL),               \
> +       .reg    =3D MT6360_PMU_##_reg,                            \
> +       .mask   =3D MT6360_##_nbit##_MASK,                        \
> +       .shft   =3D MT6360_##_nbit##_SHFT,                        \
> +}
> +
> +static struct mt6360_field_info mt6360_field_tbl[] =3D {
> +       MT6360_FIELD_RW(hiz,            CHG_CTRL1,      HIZ),
> +       MT6360_FIELD_RW(vmivr,          CHG_CTRL6,      VMIVR),
> +       MT6360_FIELD_RW(iaicr,          CHG_CTRL3,      IAICR),
> +       MT6360_FIELD_RW(SYSREG,         CHG_CTRL11,     SYSREG),
> +       MT6360_FIELD_RW(otg_oc,         CHG_CTRL10,     OTG_OC),
> +       MT6360_FIELD_RW(ichg,           CHG_CTRL17,     ICHG),
> +       MT6360_FIELD_RW(iprec,          CHG_CTRL8,      IPREC),
> +       MT6360_FIELD_RW(ieoc,           CHG_CTRL9,      IEOC),
> +       MT6360_FIELD_RW(voreg,          CHG_CTRL4,      VOREG),
> +       MT6360_FIELD_RW(lbp,            CHG_CTRL10,     LBP),
> +       MT6360_FIELD_RW(vrec,           CHG_CTRL11,     VREC),
> +       MT6360_FIELD_RW(te,             CHG_CTRL2,      TE),
> +       MT6360_FIELD_RW(chg_wdt_en,     CHG_CTRL13,     CHG_WDT_EN),
> +       MT6360_FIELD_RW(chg_wdt,        CHG_CTRL13,     CHG_WDT),
> +       MT6360_FIELD_RW(wt_fc,          CHG_CTRL12,     WT_FC),
> +       MT6360_FIELD_RW(bat_comp,       CHG_CTRL18,     BAT_COMP),
> +       MT6360_FIELD_RW(vclamp,         CHG_CTRL18,     VCLAMP),
> +       MT6360_FIELD_RW(usbchgen,       DEVICE_TYPE,    USBCHGEN),
> +       MT6360_FIELD_RW(chg_en,         CHG_CTRL2,      CHG_EN),
> +       MT6360_FIELD_RO(chrdet_ext,     FOD_STAT,       CHRDET_EXT),
> +};
> +
> +static struct attribute *mt6360_attrs[ARRAY_SIZE(mt6360_field_tbl) + 1];
> +
> +static const struct attribute_group mt6360_attr_group =3D {
> +       .attrs =3D mt6360_attrs,
> +};
> +
> +static ssize_t mt6360_sysfs_show(struct device *dev,
> +                                struct device_attribute *attr, char *buf=
)
> +{
> +       struct mt6360_chg_info *mci =3D dev_get_drvdata(dev->parent);
> +       struct mt6360_field_info *info =3D (void *)attr;
> +       unsigned int regval;
> +       int ret;
> +
> +       ret =3D regmap_read(mci->regmap, info->reg, &regval);
> +       if (ret < 0)
> +               return ret;
> +       regval =3D (regval & info->mask) >> info->shft;
> +       return scnprintf(buf, PAGE_SIZE, "%02x\n", regval);
> +}
> +
> +static ssize_t mt6360_sysfs_store(struct device *dev,
> +                  struct device_attribute *attr, const char *buf, size_t=
 count)
> +{
> +       struct mt6360_chg_info *mci =3D dev_get_drvdata(dev->parent);
> +       struct mt6360_field_info *info =3D (void *)attr;
> +       int ret, tmp;
> +
> +       if (kstrtoint(buf, 10, &tmp) < 0) {
> +               dev_err(dev, "failed to parsing number\n");
> +               return -EINVAL;
> +       }
> +       ret =3D regmap_update_bits(mci->regmap,
> +                                info->reg, info->mask, tmp << info->shft=
);
> +       if (ret < 0)
> +               return ret;
> +       return count;
> +}
> +
> +static int mt6360_sysfs_create_group(struct mt6360_chg_info *mci)
> +{
> +       int i, tb_size =3D ARRAY_SIZE(mt6360_field_tbl);
> +
> +       for (i =3D 0; i < tb_size; i++)
> +               mt6360_attrs[i] =3D &(mt6360_field_tbl[i].dev_attr.attr);
> +       return devm_device_add_group(&mci->psy->dev, &mt6360_attr_group);
> +}
> +
> +static int mt6360_chg_init_setting(struct mt6360_chg_info *mci)
> +{
> +       int ret;
> +
> +       /* Disable bc12 */
> +       ret =3D regmap_update_bits(mci->regmap, MT6360_PMU_DEVICE_TYPE,
> +                                MT6360_USBCHGEN_MASK, 0);
> +       if (ret < 0) {
> +               dev_err(mci->dev, "%s: disable bc12 fail\n", __func__);
> +               goto out;
> +       }
> +       /* Set input current limit select by AICR */
> +       ret =3D regmap_update_bits(mci->regmap, MT6360_PMU_CHG_CTRL2,
> +                                MT6360_IINLMTSEL_MASK,
> +                                MT6360_IINLMTSEL_AICR <<
> +                                       MT6360_IINLMTSEL_SHFT);
> +       if (ret < 0) {
> +               dev_err(mci->dev,
> +                       "%s: switch iinlmtsel to aicr fail\n", __func__);
> +               goto out;
> +       }
> +       usleep_range(5000, 6000);
> +       /* Disable ilim */
> +       ret =3D regmap_update_bits(mci->regmap, MT6360_PMU_CHG_CTRL3,
> +                                MT6360_ILIM_EN_MASK, 0);
> +       if (ret < 0) {
> +               dev_err(mci->dev,
> +                       "%s: switch iinlmtsel to aicr fail\n", __func__);
> +               goto out;
> +       }
> +       /* Enlarge OTG_OC to max 3A */
> +       ret =3D regmap_update_bits(mci->regmap,
> +                                MT6360_PMU_CHG_CTRL10, 0x07, 0x07);
> +       if (ret < 0) {
> +               dev_err(mci->dev,
> +                       "%s: faled config otg oc to maximum\n", __func__)=
;
> +       }
> +out:
> +       return ret;
> +}
> +
> +static u32 mt6360_vinovp_trans_to_sel(u32 val)
> +{
> +       u32 vinovp_tbl[] =3D { 5500000, 6500000, 11000000, 14500000 };
> +       int i;
> +
> +       /* Select the smaller and equal supported value */
> +       for (i =3D 0; i < ARRAY_SIZE(vinovp_tbl)-1; i++) {
> +               if (val < vinovp_tbl[i+1])
> +                       break;
> +       }
> +       return i;
> +}
> +
> +static struct mt6360_chg_platform_data *mt6360_parse_pdata(
> +                                                  struct platform_device=
 *pdev)
> +{
> +       struct mt6360_chg_platform_data *pdata =3D dev_get_platdata(&pdev=
->dev);
> +       struct device_node *np =3D pdev->dev.of_node;
> +       int ret;
> +
> +       pdata =3D kmemdup(&def_platform_data, sizeof(*pdata), GFP_KERNEL)=
;
> +       ret =3D of_property_read_u32(np, "richtek,vinovp-microvolt", &pda=
ta->vinovp);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to parse vinovp in DT\n");
> +               return ERR_PTR(ret);
> +       }
> +       return pdata;
> +}
> +
> +static int mt6360_apply_pdata(struct platform_device *pdev)
> +{
> +       struct mt6360_chg_platform_data *pdata =3D dev_get_platdata(&pdev=
->dev);
> +       struct mt6360_chg_info *mci =3D dev_get_drvdata(&pdev->dev);
> +       int ret;
> +       u32 sel;
> +
> +       sel =3D mt6360_vinovp_trans_to_sel(pdata->vinovp);
> +       ret =3D regmap_update_bits(mci->regmap, MT6360_PMU_CHG_CTRL19,
> +                                MT6360_VINOVP_MASK, sel << MT6360_VINOVP=
_SHFT);
> +       if (ret)
> +               return ret;
> +       return 0;
> +}
> +
> +static int mt6360_charger_probe(struct platform_device *pdev)
> +{
> +       struct mt6360_chg_platform_data *pdata =3D dev_get_platdata(&pdev=
->dev);
> +       struct mt6360_chg_info *mci;
> +       struct power_supply_config charger_cfg =3D {};
> +       struct regulator_config config =3D { };
> +       int ret;
> +
> +       mci =3D devm_kzalloc(&pdev->dev, sizeof(*mci), GFP_KERNEL);
> +       if (!mci)
> +               return -ENOMEM;
> +
> +       pdata =3D mt6360_parse_pdata(pdev);
> +       if (IS_ERR_OR_NULL(pdata))
> +               return PTR_ERR(pdata);
> +
> +       pdev->dev.platform_data =3D pdata;
> +
> +       mci->dev =3D &pdev->dev;
> +       mutex_init(&mci->chgdet_lock);
> +       platform_set_drvdata(pdev, mci);
> +       INIT_WORK(&mci->chrdet_work, &mt6360_chrdet_work);
> +
> +       mci->regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> +       if (!mci->regmap) {
> +               dev_err(&pdev->dev, "Failed to get parent regmap\n");
> +               return -ENODEV;
> +       }
> +
> +       ret =3D mt6360_apply_pdata(pdev);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Failed to apply pdata\n");
> +               return ret;
> +       }
> +
> +       memcpy(&mci->psy_desc, &mt6360_charger_desc, sizeof(mci->psy_desc=
));
> +       mci->psy_desc.name =3D dev_name(&pdev->dev);
> +       charger_cfg.drv_data =3D mci;
> +       charger_cfg.of_node =3D pdev->dev.of_node;
> +       charger_cfg.supplied_to =3D mt6360_charger_supplied_to;
> +       charger_cfg.num_supplicants =3D ARRAY_SIZE(mt6360_charger_supplie=
d_to);
> +       mci->psy =3D devm_power_supply_register(&pdev->dev,
> +                                             &mci->psy_desc, &charger_cf=
g);
> +       if (IS_ERR(mci->psy)) {
> +               dev_err(&pdev->dev, "Failed to register power supply dev\=
n");
> +               return PTR_ERR(mci->psy);
> +       }
> +
> +       ret =3D mt6360_chg_init_setting(mci);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Failed to initial setting\n");
> +               return ret;
> +       }
> +
> +       schedule_work(&mci->chrdet_work);
> +
> +       ret =3D mt6360_chg_irq_register(pdev);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Failed to register irqs\n");
> +               return ret;
> +       }
> +
> +       config.dev =3D &pdev->dev;
> +       config.regmap =3D mci->regmap;
> +       mci->otg_rdev =3D devm_regulator_register(&pdev->dev, &mt6360_otg=
_rdesc,
> +                                               &config);
> +       if (IS_ERR(mci->otg_rdev))
> +               return PTR_ERR(mci->otg_rdev);
> +
> +       ret =3D mt6360_sysfs_create_group(mci);
> +       if (ret) {
> +               dev_err(&pdev->dev,
> +                       "%s: create sysfs attrs fail\n", __func__);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id __maybe_unused mt6360_charger_of_id[] =
=3D {
> +       { .compatible =3D "mediatek,mt6360-chg", },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, mt6360_charger_of_id);
> +
> +static const struct platform_device_id mt6360_charger_id[] =3D {
> +       { "mt6360-chg", 0 },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(platform, mt6360_charger_id);
> +
> +static struct platform_driver mt6360_charger_driver =3D {
> +       .driver =3D {
> +               .name =3D "mt6360-chg",
> +               .of_match_table =3D of_match_ptr(mt6360_charger_of_id),
> +       },
> +       .probe =3D mt6360_charger_probe,
> +       .id_table =3D mt6360_charger_id,
> +};
> +module_platform_driver(mt6360_charger_driver);
> +
> +MODULE_AUTHOR("CY_Huang <cy_huang@richtek.com>");
> +MODULE_DESCRIPTION("MT6360 Charger Driver");
> +MODULE_LICENSE("GPL");
> --
> 2.7.4
>
