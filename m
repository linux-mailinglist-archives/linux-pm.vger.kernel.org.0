Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A6442A7F4
	for <lists+linux-pm@lfdr.de>; Tue, 12 Oct 2021 17:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbhJLPOH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Oct 2021 11:14:07 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54354 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhJLPOG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Oct 2021 11:14:06 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 3538E1F43B75
Received: by earth.universe (Postfix, from userid 1000)
        id 0F3C73C0CA8; Tue, 12 Oct 2021 17:12:02 +0200 (CEST)
Date:   Tue, 12 Oct 2021 17:12:02 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Kate Hsuan <hpa@redhat.com>, hen-Yu Tsai <wens@csie.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: axp288-charger: Optimize register reading
 method
Message-ID: <20211012151202.ezxfnmplg74wvvqr@earth.universe>
References: <20211012054545.27314-1-hpa@redhat.com>
 <18a8262e-ee7c-767d-68c1-e18b9043a781@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fabmqnmpymwuaqpn"
Content-Disposition: inline
In-Reply-To: <18a8262e-ee7c-767d-68c1-e18b9043a781@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--fabmqnmpymwuaqpn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 12, 2021 at 09:52:52AM +0200, Hans de Goede wrote:
> On 10/12/21 7:45 AM, Kate Hsuan wrote:
> > The original implementation access the charger the same register value
> > several=A0times to get the charger status, such as online, enabled, and
> > bus limits. It takes a long time and bandwidth for every "status get"
> > operation.=A0
> >=20
> > To reduce the access of the register and save bandwidth, this commit
> > integrated every read operation into only one "register value get"=A0
> > operation and cache them in the variables. Once the "get properties"
> > is requested from the user space, the cached information can be returned
> > immediately.
> >=20
> > I2C access between Linux kernel and P-Unit is improved by explicitly ta=
king
> > semaphore once for the entire set of register accesses in the new
> > axp288_charger_usb_update_property() function. The I2C-Bus to the XPower
> > AXP288 is shared between the Linux kernel and SoCs P-Unit. The P-Unit
> > has a semaphore which the kernel must "lock" before it may use the bus.
> > If not explicitly taken by the I2C-Driver, then this semaphore is
> > automatically taken by the I2C-bus-driver for each I2C-transfer. In
> > other words, the semaphore will be locked and released several times for
> > entire set of register accesses.
> >=20
> > Signed-off-by: Kate Hsuan <hpa@redhat.com>
>=20
> Thanks, patch looks good to me:
>=20
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>=20
> I've also given this a test run on a device with an AXP288 PMIC:
>=20
> Tested-by: Hans de Goede <hdegoede@redhat.com>

Thanks, queued.

-- Sebastian

>=20
> Regards,
>=20
> Hans
>=20
> > ---
> >  drivers/power/supply/axp288_charger.c | 150 +++++++++++++++++---------
> >  1 file changed, 99 insertions(+), 51 deletions(-)
> >=20
> > diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supp=
ly/axp288_charger.c
> > index b9553be9bed5..fd4983c98fd9 100644
> > --- a/drivers/power/supply/axp288_charger.c
> > +++ b/drivers/power/supply/axp288_charger.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/mfd/axp20x.h>
> >  #include <linux/extcon.h>
> >  #include <linux/dmi.h>
> > +#include <asm/iosf_mbi.h>
> > =20
> >  #define PS_STAT_VBUS_TRIGGER		BIT(0)
> >  #define PS_STAT_BAT_CHRG_DIR		BIT(2)
> > @@ -95,6 +96,8 @@
> >  #define CV_4200MV			4200	/* 4200mV */
> >  #define CV_4350MV			4350	/* 4350mV */
> > =20
> > +#define AXP288_REG_UPDATE_INTERVAL	(60 * HZ)
> > +
> >  #define AXP288_EXTCON_DEV_NAME		"axp288_extcon"
> >  #define USB_HOST_EXTCON_HID		"INT3496"
> >  #define USB_HOST_EXTCON_NAME		"INT3496:00"
> > @@ -118,6 +121,7 @@ struct axp288_chrg_info {
> >  	struct regmap_irq_chip_data *regmap_irqc;
> >  	int irq[CHRG_INTR_END];
> >  	struct power_supply *psy_usb;
> > +	struct mutex lock;
> > =20
> >  	/* OTG/Host mode */
> >  	struct {
> > @@ -138,6 +142,12 @@ struct axp288_chrg_info {
> >  	int cv;
> >  	int max_cc;
> >  	int max_cv;
> > +
> > +	unsigned long last_updated;
> > +	unsigned int input_status;
> > +	unsigned int op_mode;
> > +	unsigned int backend_control;
> > +	bool valid;
> >  };
> > =20
> >  static inline int axp288_charger_set_cc(struct axp288_chrg_info *info,=
 int cc)
> > @@ -197,11 +207,8 @@ static inline int axp288_charger_set_cv(struct axp=
288_chrg_info *info, int cv)
> >  static int axp288_charger_get_vbus_inlmt(struct axp288_chrg_info *info)
> >  {
> >  	unsigned int val;
> > -	int ret;
> > =20
> > -	ret =3D regmap_read(info->regmap, AXP20X_CHRG_BAK_CTRL, &val);
> > -	if (ret < 0)
> > -		return ret;
> > +	val =3D info->backend_control;
> > =20
> >  	val >>=3D CHRG_VBUS_ILIM_BIT_POS;
> >  	switch (val) {
> > @@ -297,55 +304,34 @@ static int axp288_charger_enable_charger(struct a=
xp288_chrg_info *info,
> > =20
> >  static int axp288_charger_is_present(struct axp288_chrg_info *info)
> >  {
> > -	int ret, present =3D 0;
> > -	unsigned int val;
> > -
> > -	ret =3D regmap_read(info->regmap, AXP20X_PWR_INPUT_STATUS, &val);
> > -	if (ret < 0)
> > -		return ret;
> > +	int present =3D 0;
> > =20
> > -	if (val & PS_STAT_VBUS_PRESENT)
> > +	if (info->input_status & PS_STAT_VBUS_PRESENT)
> >  		present =3D 1;
> >  	return present;
> >  }
> > =20
> >  static int axp288_charger_is_online(struct axp288_chrg_info *info)
> >  {
> > -	int ret, online =3D 0;
> > -	unsigned int val;
> > -
> > -	ret =3D regmap_read(info->regmap, AXP20X_PWR_INPUT_STATUS, &val);
> > -	if (ret < 0)
> > -		return ret;
> > +	int online =3D 0;
> > =20
> > -	if (val & PS_STAT_VBUS_VALID)
> > +	if (info->input_status & PS_STAT_VBUS_VALID)
> >  		online =3D 1;
> >  	return online;
> >  }
> > =20
> >  static int axp288_get_charger_health(struct axp288_chrg_info *info)
> >  {
> > -	int ret, pwr_stat, chrg_stat;
> >  	int health =3D POWER_SUPPLY_HEALTH_UNKNOWN;
> > -	unsigned int val;
> > =20
> > -	ret =3D regmap_read(info->regmap, AXP20X_PWR_INPUT_STATUS, &val);
> > -	if ((ret < 0) || !(val & PS_STAT_VBUS_PRESENT))
> > +	if (!(info->input_status & PS_STAT_VBUS_PRESENT))
> >  		goto health_read_fail;
> > -	else
> > -		pwr_stat =3D val;
> > =20
> > -	ret =3D regmap_read(info->regmap, AXP20X_PWR_OP_MODE, &val);
> > -	if (ret < 0)
> > -		goto health_read_fail;
> > -	else
> > -		chrg_stat =3D val;
> > -
> > -	if (!(pwr_stat & PS_STAT_VBUS_VALID))
> > +	if (!(info->input_status & PS_STAT_VBUS_VALID))
> >  		health =3D POWER_SUPPLY_HEALTH_DEAD;
> > -	else if (chrg_stat & CHRG_STAT_PMIC_OTP)
> > +	else if (info->op_mode & CHRG_STAT_PMIC_OTP)
> >  		health =3D POWER_SUPPLY_HEALTH_OVERHEAT;
> > -	else if (chrg_stat & CHRG_STAT_BAT_SAFE_MODE)
> > +	else if (info->op_mode & CHRG_STAT_BAT_SAFE_MODE)
> >  		health =3D POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE;
> >  	else
> >  		health =3D POWER_SUPPLY_HEALTH_GOOD;
> > @@ -362,30 +348,86 @@ static int axp288_charger_usb_set_property(struct=
 power_supply *psy,
> >  	int ret =3D 0;
> >  	int scaled_val;
> > =20
> > +	mutex_lock(&info->lock);
> >  	switch (psp) {
> >  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> >  		scaled_val =3D min(val->intval, info->max_cc);
> >  		scaled_val =3D DIV_ROUND_CLOSEST(scaled_val, 1000);
> >  		ret =3D axp288_charger_set_cc(info, scaled_val);
> > -		if (ret < 0)
> > +		if (ret < 0) {
> >  			dev_warn(&info->pdev->dev, "set charge current failed\n");
> > +			goto out;
> > +		}
> >  		break;
> >  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> >  		scaled_val =3D min(val->intval, info->max_cv);
> >  		scaled_val =3D DIV_ROUND_CLOSEST(scaled_val, 1000);
> >  		ret =3D axp288_charger_set_cv(info, scaled_val);
> > -		if (ret < 0)
> > +		if (ret < 0) {
> >  			dev_warn(&info->pdev->dev, "set charge voltage failed\n");
> > +			goto out;
> > +		}
> >  		break;
> >  	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> >  		ret =3D axp288_charger_set_vbus_inlmt(info, val->intval);
> > -		if (ret < 0)
> > +		if (ret < 0) {
> >  			dev_warn(&info->pdev->dev, "set input current limit failed\n");
> > +			goto out;
> > +		}
> > +		info->valid =3D false;
> >  		break;
> >  	default:
> >  		ret =3D -EINVAL;
> >  	}
> > =20
> > +out:
> > +	mutex_unlock(&info->lock);
> > +	return ret;
> > +}
> > +
> > +static int axp288_charger_reg_readb(struct axp288_chrg_info *info, int=
 reg, unsigned int *ret_val)
> > +{
> > +	int ret;
> > +
> > +	ret =3D regmap_read(info->regmap, reg, ret_val);
> > +	if (ret < 0) {
> > +		dev_err(&info->pdev->dev, "Error %d on reading value from register 0=
x%04x\n",
> > +			ret,
> > +			reg);
> > +		return ret;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int axp288_charger_usb_update_property(struct axp288_chrg_info =
*info)
> > +{
> > +	int ret =3D 0;
> > +
> > +	if (info->valid && time_before(jiffies, info->last_updated + AXP288_R=
EG_UPDATE_INTERVAL))
> > +		return 0;
> > +
> > +	dev_dbg(&info->pdev->dev, "Charger updating register values...\n");
> > +
> > +	ret =3D iosf_mbi_block_punit_i2c_access();
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret =3D axp288_charger_reg_readb(info, AXP20X_PWR_INPUT_STATUS, &info=
->input_status);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	ret =3D axp288_charger_reg_readb(info, AXP20X_PWR_OP_MODE, &info->op_=
mode);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	ret =3D axp288_charger_reg_readb(info, AXP20X_CHRG_BAK_CTRL, &info->b=
ackend_control);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	info->last_updated =3D jiffies;
> > +	info->valid =3D true;
> > +out:
> > +	iosf_mbi_unblock_punit_i2c_access();
> >  	return ret;
> >  }
> > =20
> > @@ -396,6 +438,11 @@ static int axp288_charger_usb_get_property(struct =
power_supply *psy,
> >  	struct axp288_chrg_info *info =3D power_supply_get_drvdata(psy);
> >  	int ret;
> > =20
> > +	mutex_lock(&info->lock);
> > +	ret =3D axp288_charger_usb_update_property(info);
> > +	if (ret < 0)
> > +		goto out;
> > +
> >  	switch (psp) {
> >  	case POWER_SUPPLY_PROP_PRESENT:
> >  		/* Check for OTG case first */
> > @@ -403,10 +450,7 @@ static int axp288_charger_usb_get_property(struct =
power_supply *psy,
> >  			val->intval =3D 0;
> >  			break;
> >  		}
> > -		ret =3D axp288_charger_is_present(info);
> > -		if (ret < 0)
> > -			return ret;
> > -		val->intval =3D ret;
> > +		val->intval =3D axp288_charger_is_present(info);
> >  		break;
> >  	case POWER_SUPPLY_PROP_ONLINE:
> >  		/* Check for OTG case first */
> > @@ -414,10 +458,7 @@ static int axp288_charger_usb_get_property(struct =
power_supply *psy,
> >  			val->intval =3D 0;
> >  			break;
> >  		}
> > -		ret =3D axp288_charger_is_online(info);
> > -		if (ret < 0)
> > -			return ret;
> > -		val->intval =3D ret;
> > +		val->intval =3D axp288_charger_is_online(info);
> >  		break;
> >  	case POWER_SUPPLY_PROP_HEALTH:
> >  		val->intval =3D axp288_get_charger_health(info);
> > @@ -435,16 +476,15 @@ static int axp288_charger_usb_get_property(struct=
 power_supply *psy,
> >  		val->intval =3D info->max_cv * 1000;
> >  		break;
> >  	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> > -		ret =3D axp288_charger_get_vbus_inlmt(info);
> > -		if (ret < 0)
> > -			return ret;
> > -		val->intval =3D ret;
> > +		val->intval =3D axp288_charger_get_vbus_inlmt(info);
> >  		break;
> >  	default:
> > -		return -EINVAL;
> > +		ret =3D -EINVAL;
> >  	}
> > =20
> > -	return 0;
> > +out:
> > +	mutex_unlock(&info->lock);
> > +	return ret;
> >  }
> > =20
> >  static int axp288_charger_property_is_writeable(struct power_supply *p=
sy,
> > @@ -540,7 +580,9 @@ static irqreturn_t axp288_charger_irq_thread_handle=
r(int irq, void *dev)
> >  		dev_warn(&info->pdev->dev, "Spurious Interrupt!!!\n");
> >  		goto out;
> >  	}
> > -
> > +	mutex_lock(&info->lock);
> > +	info->valid =3D false;
> > +	mutex_unlock(&info->lock);
> >  	power_supply_changed(info->psy_usb);
> >  out:
> >  	return IRQ_HANDLED;
> > @@ -613,6 +655,9 @@ static void axp288_charger_extcon_evt_worker(struct=
 work_struct *work)
> >  	if (!(val & PS_STAT_VBUS_VALID)) {
> >  		dev_dbg(&info->pdev->dev, "USB charger disconnected\n");
> >  		axp288_charger_enable_charger(info, false);
> > +		mutex_lock(&info->lock);
> > +		info->valid =3D false;
> > +		mutex_unlock(&info->lock);
> >  		power_supply_changed(info->psy_usb);
> >  		return;
> >  	}
> > @@ -644,6 +689,9 @@ static void axp288_charger_extcon_evt_worker(struct=
 work_struct *work)
> >  		dev_err(&info->pdev->dev,
> >  			"error setting current limit (%d)\n", ret);
> > =20
> > +	mutex_lock(&info->lock);
> > +	info->valid =3D false;
> > +	mutex_unlock(&info->lock);
> >  	power_supply_changed(info->psy_usb);
> >  }
> > =20
> >=20
>=20

--fabmqnmpymwuaqpn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmFlpbwACgkQ2O7X88g7
+po/xg//cePRV5LHD2dkc/QQgKqYZGFaS5hQAqVnO/5EWLkwMQz0YUJirXxE/kZl
n1nO/GgpFFPqUQYm1zD6LayJhQSUrJoYBrt5yPtF+b5M0k4Dx4CexT+QwYlRZ+DV
3mKBySH9sMrZqScYaJN3WzhO+Ws5da3Q/l1q2XlfAJOuis/1LTb0g5/ZSRrSzPhi
3ziNzyBqKJTIwYuaMRFBDl0IPg3z3aAiYgTbFs4U/Qm6GgsydMt60hcQVuISo0On
3R7aF6s1HnTvXunfoRXNyPon+rrnD8tB7WaZ441tInASgsos7/DXAsQFnN082ld/
f0ibBGpr7qlFIwtH6ylbxBtbCm+VzRabiaw+DAsSfv0RZ5XzI/BXlWfV/7rBLdhZ
elvHRE0qJmbtiXuirf296ieW3qZTC6ic8AHW3kChc/v6637Sv/6g/ohVxVGqRw0W
rodldgHFEVKpBDaGCbHTqhCU6jV21MOFdD4b51kuMJ86CtZUUm8kVfLSr5tFKwS1
W+MGdPjGRGo/XYtvXVKNkEp7t36iWMML7XhSOyih/P2dmjrJ8Ik5X0F821Xwxi7w
6SPwMTf/IC1iOZO99XJpcNkmRAXWp55kpol0b1+/3iwAvJIK9BH2EdMzT62AQbns
FA4et7nPB1+REAdYy/9WpZeNAz4IaMMVb7qvBM47Vvx9O+c3Gkk=
=ObbB
-----END PGP SIGNATURE-----

--fabmqnmpymwuaqpn--
