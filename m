Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E816C577215
	for <lists+linux-pm@lfdr.de>; Sun, 17 Jul 2022 00:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbiGPW6y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 Jul 2022 18:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPW6y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Jul 2022 18:58:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFEBAE60
        for <linux-pm@vger.kernel.org>; Sat, 16 Jul 2022 15:58:51 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 56F666601656;
        Sat, 16 Jul 2022 23:58:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658012330;
        bh=eXpDEEzrVs24TZGdVyKJUkjZ0Kar5MCJXifz2KP63QQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gX/JohoieyetZN396aQxVu2EZ7ll78grBeaRwei53+j81S7/QKxmIyiYFdF4Esgb7
         rrPerUnvZakylXP+5klPlYMoa9uc/EbOYt9QTOsiwTB5FgaZMhQwmSlRW66dGy/GSx
         b6dNqm+hu4DFHkjt97ccMCf9FTyl4Rpdizpps9KE/rb9yAzU1+rNhcmhfSfmJc4gp9
         xfGzx0rBXrKd2DSQyayCVyHQjUoLR5DYNObp1qzTFLFvVsWWHYq+wTpmALJ2gkLbYa
         17E0FTtGUuKuZlSPtE7DF+8CySCxWe8p/P4+0weKA1eXAUCZ17q9yfJxDPjiW+HI6y
         KBJ5O+Q+R8rKA==
Received: by mercury (Postfix, from userid 1000)
        id 1B27A1060428; Sun, 17 Jul 2022 00:58:48 +0200 (CEST)
Date:   Sun, 17 Jul 2022 00:58:48 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marcus Cooper <codekipper@gmail.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: ab8500: Drop external charger leftovers
Message-ID: <20220716225848.sxa63jmr5n4a5cqj@mercury.elektranox.org>
References: <20220623142545.1841362-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vlszukluk37frba5"
Content-Disposition: inline
In-Reply-To: <20220623142545.1841362-1-linus.walleij@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--vlszukluk37frba5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 23, 2022 at 04:25:45PM +0200, Linus Walleij wrote:
> Some leftover code for external chargers only used with
> unreleased ASIC revisions and the header file for the
> unsupported PM2301 was left behind in an earlier cleanup,
> fix it by deleting the remnants.
>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/ab8500-chargalg.h |   4 -
>  drivers/power/supply/ab8500_chargalg.c |  23 +-
>  drivers/power/supply/ab8500_charger.c  |  45 +--
>  drivers/power/supply/pm2301_charger.h  | 492 -------------------------
>  4 files changed, 2 insertions(+), 562 deletions(-)
>  delete mode 100644 drivers/power/supply/pm2301_charger.h
>=20
> diff --git a/drivers/power/supply/ab8500-chargalg.h b/drivers/power/suppl=
y/ab8500-chargalg.h
> index f47a0061c36a..8534d067ba95 100644
> --- a/drivers/power/supply/ab8500-chargalg.h
> +++ b/drivers/power/supply/ab8500-chargalg.h
> @@ -34,7 +34,6 @@ struct ux500_charger_ops {
>   * @max_out_volt_uv	maximum output charger voltage in uV
>   * @max_out_curr_ua	maximum output charger current in uA
>   * @enabled		indicates if this charger is used or not
> - * @external		external charger unit (pm2xxx)
>   */
>  struct ux500_charger {
>  	struct power_supply *psy;
> @@ -43,9 +42,6 @@ struct ux500_charger {
>  	int max_out_curr_ua;
>  	int wdt_refresh;
>  	bool enabled;
> -	bool external;
>  };
> =20
> -extern struct blocking_notifier_head charger_notifier_list;
> -
>  #endif /* _AB8500_CHARGALG_H_ */
> diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/suppl=
y/ab8500_chargalg.c
> index 1b23b5261881..ce71e5315cdf 100644
> --- a/drivers/power/supply/ab8500_chargalg.c
> +++ b/drivers/power/supply/ab8500_chargalg.c
> @@ -246,9 +246,6 @@ struct ab8500_chargalg {
>  	struct kobject chargalg_kobject;
>  };
> =20
> -/*External charger prepare notifier*/
> -BLOCKING_NOTIFIER_HEAD(charger_notifier_list);
> -
>  /* Main battery properties */
>  static enum power_supply_property ab8500_chargalg_props[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
> @@ -343,8 +340,7 @@ static int ab8500_chargalg_check_charger_enable(struc=
t ab8500_chargalg *di)
>  		return di->usb_chg->ops.check_enable(di->usb_chg,
>  			bi->constant_charge_voltage_max_uv,
>  			bi->constant_charge_current_max_ua);
> -	} else if ((di->chg_info.charger_type & AC_CHG) &&
> -		   !(di->ac_chg->external)) {
> +	} else if (di->chg_info.charger_type & AC_CHG) {
>  		return di->ac_chg->ops.check_enable(di->ac_chg,
>  			bi->constant_charge_voltage_max_uv,
>  			bi->constant_charge_current_max_ua);
> @@ -473,15 +469,6 @@ static int ab8500_chargalg_kick_watchdog(struct ab85=
00_chargalg *di)
>  	/* Check if charger exists and kick watchdog if charging */
>  	if (di->ac_chg && di->ac_chg->ops.kick_wd &&
>  	    di->chg_info.online_chg & AC_CHG) {
> -		/*
> -		 * If AB charger watchdog expired, pm2xxx charging
> -		 * gets disabled. To be safe, kick both AB charger watchdog
> -		 * and pm2xxx watchdog.
> -		 */
> -		if (di->ac_chg->external &&
> -		    di->usb_chg && di->usb_chg->ops.kick_wd)
> -			di->usb_chg->ops.kick_wd(di->usb_chg);
> -
>  		return di->ac_chg->ops.kick_wd(di->ac_chg);
>  	} else if (di->usb_chg && di->usb_chg->ops.kick_wd &&
>  			di->chg_info.online_chg & USB_CHG)
> @@ -517,14 +504,6 @@ static int ab8500_chargalg_ac_en(struct ab8500_charg=
alg *di, int enable,
>  	di->chg_info.ac_iset_ua =3D iset_ua;
>  	di->chg_info.ac_vset_uv =3D vset_uv;
> =20
> -	/* Enable external charger */
> -	if (enable && di->ac_chg->external &&
> -	    !ab8500_chargalg_ex_ac_enable_toggle) {
> -		blocking_notifier_call_chain(&charger_notifier_list,
> -					     0, di->dev);
> -		ab8500_chargalg_ex_ac_enable_toggle++;
> -	}
> -
>  	return di->ac_chg->ops.enable(di->ac_chg, enable, vset_uv, iset_ua);
>  }
> =20
> diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply=
/ab8500_charger.c
> index f7e8c207494f..1c34aaebb692 100644
> --- a/drivers/power/supply/ab8500_charger.c
> +++ b/drivers/power/supply/ab8500_charger.c
> @@ -1716,29 +1716,6 @@ static int ab8500_charger_usb_en(struct ux500_char=
ger *charger,
>  	return ret;
>  }
> =20
> -static int ab8500_external_charger_prepare(struct notifier_block *charge=
r_nb,
> -				unsigned long event, void *data)
> -{
> -	int ret;
> -	struct device *dev =3D data;
> -	/*Toggle External charger control pin*/
> -	ret =3D abx500_set_register_interruptible(dev, AB8500_SYS_CTRL1_BLOCK,
> -				  AB8500_SYS_CHARGER_CONTROL_REG,
> -				  EXTERNAL_CHARGER_DISABLE_REG_VAL);
> -	if (ret < 0) {
> -		dev_err(dev, "write reg failed %d\n", ret);
> -		goto out;
> -	}
> -	ret =3D abx500_set_register_interruptible(dev, AB8500_SYS_CTRL1_BLOCK,
> -				  AB8500_SYS_CHARGER_CONTROL_REG,
> -				  EXTERNAL_CHARGER_ENABLE_REG_VAL);
> -	if (ret < 0)
> -		dev_err(dev, "Write reg failed %d\n", ret);
> -
> -out:
> -	return ret;
> -}
> -
>  /**
>   * ab8500_charger_usb_check_enable() - enable usb charging
>   * @charger:	pointer to the ux500_charger structure
> @@ -3316,10 +3293,6 @@ static int __maybe_unused ab8500_charger_suspend(s=
truct device *dev)
>  	return 0;
>  }
> =20
> -static struct notifier_block charger_nb =3D {
> -	.notifier_call =3D ab8500_external_charger_prepare,
> -};
> -
>  static char *supply_interface[] =3D {
>  	"ab8500_chargalg",
>  	"ab8500_fg",
> @@ -3540,7 +3513,6 @@ static int ab8500_charger_probe(struct platform_dev=
ice *pdev)
>  	 */
>  	if (!is_ab8505(di->parent))
>  		di->ac_chg.enabled =3D true;
> -	di->ac_chg.external =3D false;
> =20
>  	/* USB supply */
>  	/* ux500_charger sub-class */
> @@ -3553,7 +3525,6 @@ static int ab8500_charger_probe(struct platform_dev=
ice *pdev)
>  	di->usb_chg.max_out_curr_ua =3D
>  		ab8500_charge_output_curr_map[ARRAY_SIZE(ab8500_charge_output_curr_map=
) - 1];
>  	di->usb_chg.wdt_refresh =3D CHG_WD_INTERVAL;
> -	di->usb_chg.external =3D false;
>  	di->usb_state.usb_current_ua =3D -1;
> =20
>  	mutex_init(&di->charger_attached_mutex);
> @@ -3677,17 +3648,11 @@ static int ab8500_charger_probe(struct platform_d=
evice *pdev)
>  		goto remove_ab8500_bm;
>  	}
> =20
> -	/* Notifier for external charger enabling */
> -	if (!di->ac_chg.enabled)
> -		blocking_notifier_chain_register(
> -			&charger_notifier_list, &charger_nb);
> -
> -
>  	di->usb_phy =3D usb_get_phy(USB_PHY_TYPE_USB2);
>  	if (IS_ERR_OR_NULL(di->usb_phy)) {
>  		dev_err(dev, "failed to get usb transceiver\n");
>  		ret =3D -EINVAL;
> -		goto out_charger_notifier;
> +		goto remove_ab8500_bm;
>  	}
>  	di->nb.notifier_call =3D ab8500_charger_usb_notifier_call;
>  	ret =3D usb_register_notifier(di->usb_phy, &di->nb);
> @@ -3696,7 +3661,6 @@ static int ab8500_charger_probe(struct platform_dev=
ice *pdev)
>  		goto put_usb_phy;
>  	}
> =20
> -
>  	ret =3D component_master_add_with_match(&pdev->dev,
>  					      &ab8500_charger_comp_ops,
>  					      match);
> @@ -3711,10 +3675,6 @@ static int ab8500_charger_probe(struct platform_de=
vice *pdev)
>  	usb_unregister_notifier(di->usb_phy, &di->nb);
>  put_usb_phy:
>  	usb_put_phy(di->usb_phy);
> -out_charger_notifier:
> -	if (!di->ac_chg.enabled)
> -		blocking_notifier_chain_unregister(
> -			&charger_notifier_list, &charger_nb);
>  remove_ab8500_bm:
>  	ab8500_bm_of_remove(di->usb_chg.psy, di->bm);
>  	return ret;
> @@ -3729,9 +3689,6 @@ static int ab8500_charger_remove(struct platform_de=
vice *pdev)
>  	usb_unregister_notifier(di->usb_phy, &di->nb);
>  	ab8500_bm_of_remove(di->usb_chg.psy, di->bm);
>  	usb_put_phy(di->usb_phy);
> -	if (!di->ac_chg.enabled)
> -		blocking_notifier_chain_unregister(
> -			&charger_notifier_list, &charger_nb);
> =20
>  	return 0;
>  }
> diff --git a/drivers/power/supply/pm2301_charger.h b/drivers/power/supply=
/pm2301_charger.h
> deleted file mode 100644
> index 74397e377982..000000000000
> --- a/drivers/power/supply/pm2301_charger.h
> +++ /dev/null
> @@ -1,492 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Copyright (C) ST-Ericsson SA 2012
> - *
> - * PM2301 power supply interface
> - */
> -
> -#ifndef PM2301_CHARGER_H
> -#define PM2301_CHARGER_H
> -
> -/* Watchdog timeout constant */
> -#define WD_TIMER			0x30 /* 4min */
> -#define WD_KICK_INTERVAL		(30 * HZ)
> -
> -#define PM2XXX_NUM_INT_REG		0x6
> -
> -/* Constant voltage/current */
> -#define PM2XXX_CONST_CURR		0x0
> -#define PM2XXX_CONST_VOLT		0x1
> -
> -/* Lowest charger voltage is 3.39V -> 0x4E */
> -#define LOW_VOLT_REG			0x4E
> -
> -#define PM2XXX_BATT_CTRL_REG1		0x00
> -#define PM2XXX_BATT_CTRL_REG2		0x01
> -#define PM2XXX_BATT_CTRL_REG3		0x02
> -#define PM2XXX_BATT_CTRL_REG4		0x03
> -#define PM2XXX_BATT_CTRL_REG5		0x04
> -#define PM2XXX_BATT_CTRL_REG6		0x05
> -#define PM2XXX_BATT_CTRL_REG7		0x06
> -#define PM2XXX_BATT_CTRL_REG8		0x07
> -#define PM2XXX_NTC_CTRL_REG1		0x08
> -#define PM2XXX_NTC_CTRL_REG2		0x09
> -#define PM2XXX_BATT_CTRL_REG9		0x0A
> -#define PM2XXX_BATT_STAT_REG1		0x0B
> -#define PM2XXX_INP_VOLT_VPWR2		0x11
> -#define PM2XXX_INP_DROP_VPWR2		0x13
> -#define PM2XXX_INP_VOLT_VPWR1		0x15
> -#define PM2XXX_INP_DROP_VPWR1		0x17
> -#define PM2XXX_INP_MODE_VPWR		0x18
> -#define PM2XXX_BATT_WD_KICK		0x70
> -#define PM2XXX_DEV_VER_STAT		0x0C
> -#define PM2XXX_THERM_WARN_CTRL_REG	0x20
> -#define PM2XXX_BATT_DISC_REG		0x21
> -#define PM2XXX_BATT_LOW_LEV_COMP_REG	0x22
> -#define PM2XXX_BATT_LOW_LEV_VAL_REG	0x23
> -#define PM2XXX_I2C_PAD_CTRL_REG		0x24
> -#define PM2XXX_SW_CTRL_REG		0x26
> -#define PM2XXX_LED_CTRL_REG		0x28
> -
> -#define PM2XXX_REG_INT1			0x40
> -#define PM2XXX_MASK_REG_INT1		0x50
> -#define PM2XXX_SRCE_REG_INT1		0x60
> -#define PM2XXX_REG_INT2			0x41
> -#define PM2XXX_MASK_REG_INT2		0x51
> -#define PM2XXX_SRCE_REG_INT2		0x61
> -#define PM2XXX_REG_INT3			0x42
> -#define PM2XXX_MASK_REG_INT3		0x52
> -#define PM2XXX_SRCE_REG_INT3		0x62
> -#define PM2XXX_REG_INT4			0x43
> -#define PM2XXX_MASK_REG_INT4		0x53
> -#define PM2XXX_SRCE_REG_INT4		0x63
> -#define PM2XXX_REG_INT5			0x44
> -#define PM2XXX_MASK_REG_INT5		0x54
> -#define PM2XXX_SRCE_REG_INT5		0x64
> -#define PM2XXX_REG_INT6			0x45
> -#define PM2XXX_MASK_REG_INT6		0x55
> -#define PM2XXX_SRCE_REG_INT6		0x65
> -
> -#define VPWR_OVV			0x0
> -#define VSYSTEM_OVV			0x1
> -
> -/* control Reg 1 */
> -#define PM2XXX_CH_RESUME_EN		0x1
> -#define PM2XXX_CH_RESUME_DIS		0x0
> -
> -/* control Reg 2 */
> -#define PM2XXX_CH_AUTO_RESUME_EN	0X2
> -#define PM2XXX_CH_AUTO_RESUME_DIS	0X0
> -#define PM2XXX_CHARGER_ENA		0x4
> -#define PM2XXX_CHARGER_DIS		0x0
> -
> -/* control Reg 3 */
> -#define PM2XXX_CH_WD_CC_PHASE_OFF	0x0
> -#define PM2XXX_CH_WD_CC_PHASE_5MIN	0x1
> -#define PM2XXX_CH_WD_CC_PHASE_10MIN	0x2
> -#define PM2XXX_CH_WD_CC_PHASE_30MIN	0x3
> -#define PM2XXX_CH_WD_CC_PHASE_60MIN	0x4
> -#define PM2XXX_CH_WD_CC_PHASE_120MIN	0x5
> -#define PM2XXX_CH_WD_CC_PHASE_240MIN	0x6
> -#define PM2XXX_CH_WD_CC_PHASE_360MIN	0x7
> -
> -#define PM2XXX_CH_WD_CV_PHASE_OFF	(0x0<<3)
> -#define PM2XXX_CH_WD_CV_PHASE_5MIN	(0x1<<3)
> -#define PM2XXX_CH_WD_CV_PHASE_10MIN	(0x2<<3)
> -#define PM2XXX_CH_WD_CV_PHASE_30MIN	(0x3<<3)
> -#define PM2XXX_CH_WD_CV_PHASE_60MIN	(0x4<<3)
> -#define PM2XXX_CH_WD_CV_PHASE_120MIN	(0x5<<3)
> -#define PM2XXX_CH_WD_CV_PHASE_240MIN	(0x6<<3)
> -#define PM2XXX_CH_WD_CV_PHASE_360MIN	(0x7<<3)
> -
> -/* control Reg 4 */
> -#define PM2XXX_CH_WD_PRECH_PHASE_OFF	0x0
> -#define PM2XXX_CH_WD_PRECH_PHASE_1MIN	0x1
> -#define PM2XXX_CH_WD_PRECH_PHASE_5MIN	0x2
> -#define PM2XXX_CH_WD_PRECH_PHASE_10MIN	0x3
> -#define PM2XXX_CH_WD_PRECH_PHASE_30MIN	0x4
> -#define PM2XXX_CH_WD_PRECH_PHASE_60MIN	0x5
> -#define PM2XXX_CH_WD_PRECH_PHASE_120MIN	0x6
> -#define PM2XXX_CH_WD_PRECH_PHASE_240MIN	0x7
> -
> -/* control Reg 5 */
> -#define PM2XXX_CH_WD_AUTO_TIMEOUT_NONE	0x0
> -#define PM2XXX_CH_WD_AUTO_TIMEOUT_20MIN	0x1
> -
> -/* control Reg 6 */
> -#define PM2XXX_DIR_CH_CC_CURRENT_MASK	0x0F
> -#define PM2XXX_DIR_CH_CC_CURRENT_200MA	0x0
> -#define PM2XXX_DIR_CH_CC_CURRENT_400MA	0x2
> -#define PM2XXX_DIR_CH_CC_CURRENT_600MA	0x3
> -#define PM2XXX_DIR_CH_CC_CURRENT_800MA	0x4
> -#define PM2XXX_DIR_CH_CC_CURRENT_1000MA	0x5
> -#define PM2XXX_DIR_CH_CC_CURRENT_1200MA	0x6
> -#define PM2XXX_DIR_CH_CC_CURRENT_1400MA	0x7
> -#define PM2XXX_DIR_CH_CC_CURRENT_1600MA	0x8
> -#define PM2XXX_DIR_CH_CC_CURRENT_1800MA	0x9
> -#define PM2XXX_DIR_CH_CC_CURRENT_2000MA	0xA
> -#define PM2XXX_DIR_CH_CC_CURRENT_2200MA	0xB
> -#define PM2XXX_DIR_CH_CC_CURRENT_2400MA	0xC
> -#define PM2XXX_DIR_CH_CC_CURRENT_2600MA	0xD
> -#define PM2XXX_DIR_CH_CC_CURRENT_2800MA	0xE
> -#define PM2XXX_DIR_CH_CC_CURRENT_3000MA	0xF
> -
> -#define PM2XXX_CH_PRECH_CURRENT_MASK	0x30
> -#define PM2XXX_CH_PRECH_CURRENT_25MA	(0x0<<4)
> -#define PM2XXX_CH_PRECH_CURRENT_50MA	(0x1<<4)
> -#define PM2XXX_CH_PRECH_CURRENT_75MA	(0x2<<4)
> -#define PM2XXX_CH_PRECH_CURRENT_100MA	(0x3<<4)
> -
> -#define PM2XXX_CH_EOC_CURRENT_MASK	0xC0
> -#define PM2XXX_CH_EOC_CURRENT_100MA	(0x0<<6)
> -#define PM2XXX_CH_EOC_CURRENT_150MA	(0x1<<6)
> -#define PM2XXX_CH_EOC_CURRENT_300MA	(0x2<<6)
> -#define PM2XXX_CH_EOC_CURRENT_400MA	(0x3<<6)
> -
> -/* control Reg 7 */
> -#define PM2XXX_CH_PRECH_VOL_2_5		0x0
> -#define PM2XXX_CH_PRECH_VOL_2_7		0x1
> -#define PM2XXX_CH_PRECH_VOL_2_9		0x2
> -#define PM2XXX_CH_PRECH_VOL_3_1		0x3
> -
> -#define PM2XXX_CH_VRESUME_VOL_3_2	(0x0<<2)
> -#define PM2XXX_CH_VRESUME_VOL_3_4	(0x1<<2)
> -#define PM2XXX_CH_VRESUME_VOL_3_6	(0x2<<2)
> -#define PM2XXX_CH_VRESUME_VOL_3_8	(0x3<<2)
> -
> -/* control Reg 8 */
> -#define PM2XXX_CH_VOLT_MASK		0x3F
> -#define PM2XXX_CH_VOLT_3_5		0x0
> -#define PM2XXX_CH_VOLT_3_5225		0x1
> -#define PM2XXX_CH_VOLT_3_6		0x4
> -#define PM2XXX_CH_VOLT_3_7		0x8
> -#define PM2XXX_CH_VOLT_4_0		0x14
> -#define PM2XXX_CH_VOLT_4_175		0x1B
> -#define PM2XXX_CH_VOLT_4_2		0x1C
> -#define PM2XXX_CH_VOLT_4_275		0x1F
> -#define PM2XXX_CH_VOLT_4_3		0x20
> -
> -/*NTC control register 1*/
> -#define PM2XXX_BTEMP_HIGH_TH_45		0x0
> -#define PM2XXX_BTEMP_HIGH_TH_50		0x1
> -#define PM2XXX_BTEMP_HIGH_TH_55		0x2
> -#define PM2XXX_BTEMP_HIGH_TH_60		0x3
> -#define PM2XXX_BTEMP_HIGH_TH_65		0x4
> -
> -#define PM2XXX_BTEMP_LOW_TH_N5		(0x0<<3)
> -#define PM2XXX_BTEMP_LOW_TH_0		(0x1<<3)
> -#define PM2XXX_BTEMP_LOW_TH_5		(0x2<<3)
> -#define PM2XXX_BTEMP_LOW_TH_10		(0x3<<3)
> -
> -/*NTC control register 2*/
> -#define PM2XXX_NTC_BETA_COEFF_3477	0x0
> -#define PM2XXX_NTC_BETA_COEFF_3964	0x1
> -
> -#define PM2XXX_NTC_RES_10K		(0x0<<2)
> -#define PM2XXX_NTC_RES_47K		(0x1<<2)
> -#define PM2XXX_NTC_RES_100K		(0x2<<2)
> -#define PM2XXX_NTC_RES_NO_NTC		(0x3<<2)
> -
> -/* control Reg 9 */
> -#define PM2XXX_CH_CC_MODEDROP_EN	1
> -#define PM2XXX_CH_CC_MODEDROP_DIS	0
> -
> -#define PM2XXX_CH_CC_REDUCED_CURRENT_100MA	(0x0<<1)
> -#define PM2XXX_CH_CC_REDUCED_CURRENT_200MA	(0x1<<1)
> -#define PM2XXX_CH_CC_REDUCED_CURRENT_400MA	(0x2<<1)
> -#define PM2XXX_CH_CC_REDUCED_CURRENT_IDENT	(0x3<<1)
> -
> -#define PM2XXX_CHARCHING_INFO_DIS	(0<<3)
> -#define PM2XXX_CHARCHING_INFO_EN	(1<<3)
> -
> -#define PM2XXX_CH_150MV_DROP_300MV	(0<<4)
> -#define PM2XXX_CH_150MV_DROP_150MV	(1<<4)
> -
> -
> -/* charger status register */
> -#define PM2XXX_CHG_STATUS_OFF		0x0
> -#define PM2XXX_CHG_STATUS_ON		0x1
> -#define PM2XXX_CHG_STATUS_FULL		0x2
> -#define PM2XXX_CHG_STATUS_ERR		0x3
> -#define PM2XXX_CHG_STATUS_WAIT		0x4
> -#define PM2XXX_CHG_STATUS_NOBAT		0x5
> -
> -/* Input charger voltage VPWR2 */
> -#define PM2XXX_VPWR2_OVV_6_0		0x0
> -#define PM2XXX_VPWR2_OVV_6_3		0x1
> -#define PM2XXX_VPWR2_OVV_10		0x2
> -#define PM2XXX_VPWR2_OVV_NONE		0x3
> -
> -/* Input charger drop VPWR2 */
> -#define PM2XXX_VPWR2_HW_OPT_EN		(0x1<<4)
> -#define PM2XXX_VPWR2_HW_OPT_DIS		(0x0<<4)
> -
> -#define PM2XXX_VPWR2_VALID_EN		(0x1<<3)
> -#define PM2XXX_VPWR2_VALID_DIS		(0x0<<3)
> -
> -#define PM2XXX_VPWR2_DROP_EN		(0x1<<2)
> -#define PM2XXX_VPWR2_DROP_DIS		(0x0<<2)
> -
> -/* Input charger voltage VPWR1 */
> -#define PM2XXX_VPWR1_OVV_6_0		0x0
> -#define PM2XXX_VPWR1_OVV_6_3		0x1
> -#define PM2XXX_VPWR1_OVV_10		0x2
> -#define PM2XXX_VPWR1_OVV_NONE		0x3
> -
> -/* Input charger drop VPWR1 */
> -#define PM2XXX_VPWR1_HW_OPT_EN		(0x1<<4)
> -#define PM2XXX_VPWR1_HW_OPT_DIS		(0x0<<4)
> -
> -#define PM2XXX_VPWR1_VALID_EN		(0x1<<3)
> -#define PM2XXX_VPWR1_VALID_DIS		(0x0<<3)
> -
> -#define PM2XXX_VPWR1_DROP_EN		(0x1<<2)
> -#define PM2XXX_VPWR1_DROP_DIS		(0x0<<2)
> -
> -/* Battery low level comparator control register */
> -#define PM2XXX_VBAT_LOW_MONITORING_DIS	0x0
> -#define PM2XXX_VBAT_LOW_MONITORING_ENA	0x1
> -
> -/* Battery low level value control register */
> -#define PM2XXX_VBAT_LOW_LEVEL_2_3	0x0
> -#define PM2XXX_VBAT_LOW_LEVEL_2_4	0x1
> -#define PM2XXX_VBAT_LOW_LEVEL_2_5	0x2
> -#define PM2XXX_VBAT_LOW_LEVEL_2_6	0x3
> -#define PM2XXX_VBAT_LOW_LEVEL_2_7	0x4
> -#define PM2XXX_VBAT_LOW_LEVEL_2_8	0x5
> -#define PM2XXX_VBAT_LOW_LEVEL_2_9	0x6
> -#define PM2XXX_VBAT_LOW_LEVEL_3_0	0x7
> -#define PM2XXX_VBAT_LOW_LEVEL_3_1	0x8
> -#define PM2XXX_VBAT_LOW_LEVEL_3_2	0x9
> -#define PM2XXX_VBAT_LOW_LEVEL_3_3	0xA
> -#define PM2XXX_VBAT_LOW_LEVEL_3_4	0xB
> -#define PM2XXX_VBAT_LOW_LEVEL_3_5	0xC
> -#define PM2XXX_VBAT_LOW_LEVEL_3_6	0xD
> -#define PM2XXX_VBAT_LOW_LEVEL_3_7	0xE
> -#define PM2XXX_VBAT_LOW_LEVEL_3_8	0xF
> -#define PM2XXX_VBAT_LOW_LEVEL_3_9	0x10
> -#define PM2XXX_VBAT_LOW_LEVEL_4_0	0x11
> -#define PM2XXX_VBAT_LOW_LEVEL_4_1	0x12
> -#define PM2XXX_VBAT_LOW_LEVEL_4_2	0x13
> -
> -/* SW CTRL */
> -#define PM2XXX_SWCTRL_HW		0x0
> -#define PM2XXX_SWCTRL_SW		0x1
> -
> -
> -/* LED Driver Control */
> -#define PM2XXX_LED_CURRENT_MASK		0x0C
> -#define PM2XXX_LED_CURRENT_2_5MA	(0X0<<2)
> -#define PM2XXX_LED_CURRENT_1MA		(0X1<<2)
> -#define PM2XXX_LED_CURRENT_5MA		(0X2<<2)
> -#define PM2XXX_LED_CURRENT_10MA		(0X3<<2)
> -
> -#define PM2XXX_LED_SELECT_MASK		0x02
> -#define PM2XXX_LED_SELECT_EN		(0X0<<1)
> -#define PM2XXX_LED_SELECT_DIS		(0X1<<1)
> -
> -#define PM2XXX_ANTI_OVERSHOOT_MASK	0x01
> -#define PM2XXX_ANTI_OVERSHOOT_DIS	0X0
> -#define PM2XXX_ANTI_OVERSHOOT_EN	0X1
> -
> -enum pm2xxx_reg_int1 {
> -	PM2XXX_INT1_ITVBATDISCONNECT	=3D 0x02,
> -	PM2XXX_INT1_ITVBATLOWR		=3D 0x04,
> -	PM2XXX_INT1_ITVBATLOWF		=3D 0x08,
> -};
> -
> -enum pm2xxx_mask_reg_int1 {
> -	PM2XXX_INT1_M_ITVBATDISCONNECT	=3D 0x02,
> -	PM2XXX_INT1_M_ITVBATLOWR	=3D 0x04,
> -	PM2XXX_INT1_M_ITVBATLOWF	=3D 0x08,
> -};
> -
> -enum pm2xxx_source_reg_int1 {
> -	PM2XXX_INT1_S_ITVBATDISCONNECT	=3D 0x02,
> -	PM2XXX_INT1_S_ITVBATLOWR	=3D 0x04,
> -	PM2XXX_INT1_S_ITVBATLOWF	=3D 0x08,
> -};
> -
> -enum pm2xxx_reg_int2 {
> -	PM2XXX_INT2_ITVPWR2PLUG		=3D 0x01,
> -	PM2XXX_INT2_ITVPWR2UNPLUG	=3D 0x02,
> -	PM2XXX_INT2_ITVPWR1PLUG		=3D 0x04,
> -	PM2XXX_INT2_ITVPWR1UNPLUG	=3D 0x08,
> -};
> -
> -enum pm2xxx_mask_reg_int2 {
> -	PM2XXX_INT2_M_ITVPWR2PLUG	=3D 0x01,
> -	PM2XXX_INT2_M_ITVPWR2UNPLUG	=3D 0x02,
> -	PM2XXX_INT2_M_ITVPWR1PLUG	=3D 0x04,
> -	PM2XXX_INT2_M_ITVPWR1UNPLUG	=3D 0x08,
> -};
> -
> -enum pm2xxx_source_reg_int2 {
> -	PM2XXX_INT2_S_ITVPWR2PLUG	=3D 0x03,
> -	PM2XXX_INT2_S_ITVPWR1PLUG	=3D 0x0c,
> -};
> -
> -enum pm2xxx_reg_int3 {
> -	PM2XXX_INT3_ITCHPRECHARGEWD	=3D 0x01,
> -	PM2XXX_INT3_ITCHCCWD		=3D 0x02,
> -	PM2XXX_INT3_ITCHCVWD		=3D 0x04,
> -	PM2XXX_INT3_ITAUTOTIMEOUTWD	=3D 0x08,
> -};
> -
> -enum pm2xxx_mask_reg_int3 {
> -	PM2XXX_INT3_M_ITCHPRECHARGEWD	=3D 0x01,
> -	PM2XXX_INT3_M_ITCHCCWD		=3D 0x02,
> -	PM2XXX_INT3_M_ITCHCVWD		=3D 0x04,
> -	PM2XXX_INT3_M_ITAUTOTIMEOUTWD	=3D 0x08,
> -};
> -
> -enum pm2xxx_source_reg_int3 {
> -	PM2XXX_INT3_S_ITCHPRECHARGEWD	=3D 0x01,
> -	PM2XXX_INT3_S_ITCHCCWD		=3D 0x02,
> -	PM2XXX_INT3_S_ITCHCVWD		=3D 0x04,
> -	PM2XXX_INT3_S_ITAUTOTIMEOUTWD	=3D 0x08,
> -};
> -
> -enum pm2xxx_reg_int4 {
> -	PM2XXX_INT4_ITBATTEMPCOLD	=3D 0x01,
> -	PM2XXX_INT4_ITBATTEMPHOT	=3D 0x02,
> -	PM2XXX_INT4_ITVPWR2OVV		=3D 0x04,
> -	PM2XXX_INT4_ITVPWR1OVV		=3D 0x08,
> -	PM2XXX_INT4_ITCHARGINGON	=3D 0x10,
> -	PM2XXX_INT4_ITVRESUME		=3D 0x20,
> -	PM2XXX_INT4_ITBATTFULL		=3D 0x40,
> -	PM2XXX_INT4_ITCVPHASE		=3D 0x80,
> -};
> -
> -enum pm2xxx_mask_reg_int4 {
> -	PM2XXX_INT4_M_ITBATTEMPCOLD	=3D 0x01,
> -	PM2XXX_INT4_M_ITBATTEMPHOT	=3D 0x02,
> -	PM2XXX_INT4_M_ITVPWR2OVV	=3D 0x04,
> -	PM2XXX_INT4_M_ITVPWR1OVV	=3D 0x08,
> -	PM2XXX_INT4_M_ITCHARGINGON	=3D 0x10,
> -	PM2XXX_INT4_M_ITVRESUME		=3D 0x20,
> -	PM2XXX_INT4_M_ITBATTFULL	=3D 0x40,
> -	PM2XXX_INT4_M_ITCVPHASE		=3D 0x80,
> -};
> -
> -enum pm2xxx_source_reg_int4 {
> -	PM2XXX_INT4_S_ITBATTEMPCOLD	=3D 0x01,
> -	PM2XXX_INT4_S_ITBATTEMPHOT	=3D 0x02,
> -	PM2XXX_INT4_S_ITVPWR2OVV	=3D 0x04,
> -	PM2XXX_INT4_S_ITVPWR1OVV	=3D 0x08,
> -	PM2XXX_INT4_S_ITCHARGINGON	=3D 0x10,
> -	PM2XXX_INT4_S_ITVRESUME		=3D 0x20,
> -	PM2XXX_INT4_S_ITBATTFULL	=3D 0x40,
> -	PM2XXX_INT4_S_ITCVPHASE		=3D 0x80,
> -};
> -
> -enum pm2xxx_reg_int5 {
> -	PM2XXX_INT5_ITTHERMALSHUTDOWNRISE	=3D 0x01,
> -	PM2XXX_INT5_ITTHERMALSHUTDOWNFALL	=3D 0x02,
> -	PM2XXX_INT5_ITTHERMALWARNINGRISE	=3D 0x04,
> -	PM2XXX_INT5_ITTHERMALWARNINGFALL	=3D 0x08,
> -	PM2XXX_INT5_ITVSYSTEMOVV		=3D 0x10,
> -};
> -
> -enum pm2xxx_mask_reg_int5 {
> -	PM2XXX_INT5_M_ITTHERMALSHUTDOWNRISE	=3D 0x01,
> -	PM2XXX_INT5_M_ITTHERMALSHUTDOWNFALL	=3D 0x02,
> -	PM2XXX_INT5_M_ITTHERMALWARNINGRISE	=3D 0x04,
> -	PM2XXX_INT5_M_ITTHERMALWARNINGFALL	=3D 0x08,
> -	PM2XXX_INT5_M_ITVSYSTEMOVV		=3D 0x10,
> -};
> -
> -enum pm2xxx_source_reg_int5 {
> -	PM2XXX_INT5_S_ITTHERMALSHUTDOWNRISE	=3D 0x01,
> -	PM2XXX_INT5_S_ITTHERMALSHUTDOWNFALL	=3D 0x02,
> -	PM2XXX_INT5_S_ITTHERMALWARNINGRISE	=3D 0x04,
> -	PM2XXX_INT5_S_ITTHERMALWARNINGFALL	=3D 0x08,
> -	PM2XXX_INT5_S_ITVSYSTEMOVV		=3D 0x10,
> -};
> -
> -enum pm2xxx_reg_int6 {
> -	PM2XXX_INT6_ITVPWR2DROP		=3D 0x01,
> -	PM2XXX_INT6_ITVPWR1DROP		=3D 0x02,
> -	PM2XXX_INT6_ITVPWR2VALIDRISE	=3D 0x04,
> -	PM2XXX_INT6_ITVPWR2VALIDFALL	=3D 0x08,
> -	PM2XXX_INT6_ITVPWR1VALIDRISE	=3D 0x10,
> -	PM2XXX_INT6_ITVPWR1VALIDFALL	=3D 0x20,
> -};
> -
> -enum pm2xxx_mask_reg_int6 {
> -	PM2XXX_INT6_M_ITVPWR2DROP	=3D 0x01,
> -	PM2XXX_INT6_M_ITVPWR1DROP	=3D 0x02,
> -	PM2XXX_INT6_M_ITVPWR2VALIDRISE	=3D 0x04,
> -	PM2XXX_INT6_M_ITVPWR2VALIDFALL	=3D 0x08,
> -	PM2XXX_INT6_M_ITVPWR1VALIDRISE	=3D 0x10,
> -	PM2XXX_INT6_M_ITVPWR1VALIDFALL	=3D 0x20,
> -};
> -
> -enum pm2xxx_source_reg_int6 {
> -	PM2XXX_INT6_S_ITVPWR2DROP	=3D 0x01,
> -	PM2XXX_INT6_S_ITVPWR1DROP	=3D 0x02,
> -	PM2XXX_INT6_S_ITVPWR2VALIDRISE	=3D 0x04,
> -	PM2XXX_INT6_S_ITVPWR2VALIDFALL	=3D 0x08,
> -	PM2XXX_INT6_S_ITVPWR1VALIDRISE	=3D 0x10,
> -	PM2XXX_INT6_S_ITVPWR1VALIDFALL	=3D 0x20,
> -};
> -
> -struct pm2xxx_charger_info {
> -	int charger_connected;
> -	int charger_online;
> -	int cv_active;
> -	bool wd_expired;
> -};
> -
> -struct pm2xxx_charger_event_flags {
> -	bool mainextchnotok;
> -	bool main_thermal_prot;
> -	bool ovv;
> -	bool chgwdexp;
> -};
> -
> -struct pm2xxx_interrupts {
> -	u8 reg[PM2XXX_NUM_INT_REG];
> -	int (*handler[PM2XXX_NUM_INT_REG])(void *, int);
> -};
> -
> -struct pm2xxx_config {
> -	struct i2c_client *pm2xxx_i2c;
> -	struct i2c_device_id *pm2xxx_id;
> -};
> -
> -struct pm2xxx_irq {
> -	char *name;
> -	irqreturn_t (*isr)(int irq, void *data);
> -};
> -
> -struct pm2xxx_charger {
> -	struct device *dev;
> -	u8 chip_id;
> -	bool vddadc_en_ac;
> -	struct pm2xxx_config config;
> -	bool ac_conn;
> -	unsigned int gpio_irq;
> -	int vbat;
> -	int old_vbat;
> -	int failure_case;
> -	int failure_input_ovv;
> -	unsigned int lpn_pin;
> -	struct pm2xxx_interrupts *pm2_int;
> -	struct regulator *regu;
> -	struct pm2xxx_bm_data *bat;
> -	struct mutex lock;
> -	struct ab8500 *parent;
> -	struct pm2xxx_charger_info ac;
> -	struct pm2xxx_charger_platform_data *pdata;
> -	struct workqueue_struct *charger_wq;
> -	struct delayed_work check_vbat_work;
> -	struct work_struct ac_work;
> -	struct work_struct check_main_thermal_prot_work;
> -	struct delayed_work check_hw_failure_work;
> -	struct ux500_charger ac_chg;
> -	struct power_supply_desc ac_chg_desc;
> -	struct pm2xxx_charger_event_flags flags;
> -};
> -
> -#endif /* PM2301_CHARGER_H */
> --=20
> 2.36.1
>=20

--vlszukluk37frba5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmLTQqcACgkQ2O7X88g7
+pqsihAAmgZOPNR1iIVlAeBGRXh8r1SuWR86RLFViIjYeL2ORhhi8+nl+J+3VDNT
zTarIYsu/O3SCSXz0+rz8xn1wXR1DZl0WnRoUylh3xAB3Lcg6x85JLbSkrSuEmhx
Un0Rq7EI/Lkp+rfkQIR7RE182pcKOFUozfbexTjO7bZ9EBCeAo4MveoRdCBUOPyQ
6IcC42dzQjLq4Z643EhS81tl1/XunhM1ZJs5W3xts3DONN+IsOvAdOPJLlOTirJp
PnQednstAmqjKcrDuqg7I/SHOb/H9QSiXQQklQkUL57a5uWsKl7L25/Z7MfDdXBw
iOGGBcZlZpojRpHrNkp8VVkfN2uMTAaILQba4kiS7EDeM34zPo+YXR22xLCemvb9
3HX3Cj1jyZWavBRD1amR2BRKYc8rRV4j8WIyxY4GLLRW54oqnG/3hFvSwOdhfLYZ
BaYYc4xfjIc4Dg9CKEYytc63dr1Ib9sGSHxsvr/XiommmMi2sZRys/qZgZwGYIaI
MHWW6fYAR5SFHZrKyAfhV+wGmPVfeRGrrHnx8uQKjtWjaWFg7bbOVQttiG0wMryd
Ag1DcsvNfzxvQ0jxY9AORHixFT8RLR4tgVVTqt/LOj2bVqhf/S1hO1BhzUmFkAhF
kNlMlshXKlV7WhHxWp+I8IcxMkAdLhb4/iabdTi7eDwOMLK8TGQ=
=Rg7b
-----END PGP SIGNATURE-----

--vlszukluk37frba5--
