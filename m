Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855CC4C4E56
	for <lists+linux-pm@lfdr.de>; Fri, 25 Feb 2022 20:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbiBYTLM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Feb 2022 14:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbiBYTLM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Feb 2022 14:11:12 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5423920B150
        for <linux-pm@vger.kernel.org>; Fri, 25 Feb 2022 11:10:39 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 19AE21F45AAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645816238;
        bh=SM4p5TyrTcZUqLLFDjVg8qMd1P0AviM10LGb3OQXdRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nBxyxNQTelNKKt/vOG8iKwWTSGMjou9ldQGBJ0cz4+OTOA72VuTrVhs+hf25BEBrv
         LV73R/w322QjxuKawjX8BDeaIDyFxmZjy8NEKbMPKWDfyewjIbuRhnTGudoTbtKxGv
         Zghvz8MY89PeMiBIpsBaEOZQz2GWT7DZM6qaB3Ub7zdY2GhfnvXODTxYKEs9Hhtd+V
         cmMjDEncAHO/ntrkFpz2yapVzbrVJCOx0JmNM0n42ZMHeiyKMQ8srkOTZuIlAX9N0V
         LQxcVXA7oTauIpvJFRz66hTbkU+ab4qjklsaqiCf799Z7ZGxwegrwbhaw1qqTG4Wq8
         9JHtGyL07h1hA==
Received: by mercury (Postfix, from userid 1000)
        id C81D0106049B; Fri, 25 Feb 2022 20:10:35 +0100 (CET)
Date:   Fri, 25 Feb 2022 20:10:35 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 2/2] power: supply: bq24190_charger: Delay applying
 charge_type changes when OTG 5V Vbus boost is on
Message-ID: <20220225191035.awm56brexuyaacwk@mercury.elektranox.org>
References: <20220212164817.204323-1-hdegoede@redhat.com>
 <20220212164817.204323-2-hdegoede@redhat.com>
 <YhkIF7vrwk3sVm5y@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xttxxag3aqamgpj6"
Content-Disposition: inline
In-Reply-To: <YhkIF7vrwk3sVm5y@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--xttxxag3aqamgpj6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 25, 2022 at 06:47:19PM +0200, Andy Shevchenko wrote:
> On Sat, Feb 12, 2022 at 05:48:17PM +0100, Hans de Goede wrote:
> > Recently userspace has started switching power_supply class devices with
> > a charge_type psy-property between fast and trickle charge mode, see:
> > https://gitlab.freedesktop.org/hadess/power-profiles-daemon/-/issues/85
> >=20
> > Before this patch bq24190_charger_set_charge_type() would unconditional=
ly
> > write charging or none to the BQ24190_REG_POC_CHG_CONFIG bits, replacing
> > the otg setting of those bits when the OTG 5V Vbus boost converter was =
on,
> > turning the 5V Vbus off, removing the power from any attached periphera=
ls.
> >=20
> > This fixes this by keeping track of otg_vbus_enabled and the requested
> > charger_type settings and when otg_vbus_enabled is true, delay applying
> > the charger_type until the 5V boost converter is turned off.
>=20
> Both of them looks good to me, FWIW,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks, queued.

-- Sebastian

> > Cc: Bastien Nocera <hadess@hadess.net>
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> >  drivers/power/supply/bq24190_charger.c | 41 +++++++++++++++++++-------
> >  1 file changed, 30 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/sup=
ply/bq24190_charger.c
> > index dcbfd97a55be..aa1a589eb9f2 100644
> > --- a/drivers/power/supply/bq24190_charger.c
> > +++ b/drivers/power/supply/bq24190_charger.c
> > @@ -163,6 +163,8 @@ struct bq24190_dev_info {
> >  	char				model_name[I2C_NAME_SIZE];
> >  	bool				initialized;
> >  	bool				irq_event;
> > +	bool				otg_vbus_enabled;
> > +	int				charge_type;
> >  	u16				sys_min;
> >  	u16				iprechg;
> >  	u16				iterm;
> > @@ -176,6 +178,9 @@ struct bq24190_dev_info {
> >  	u8				watchdog;
> >  };
> > =20
> > +static int bq24190_charger_set_charge_type(struct bq24190_dev_info *bd=
i,
> > +					   const union power_supply_propval *val);
> > +
> >  static const unsigned int bq24190_usb_extcon_cable[] =3D {
> >  	EXTCON_USB,
> >  	EXTCON_NONE,
> > @@ -502,8 +507,9 @@ static ssize_t bq24190_sysfs_store(struct device *d=
ev,
> >  }
> >  #endif
> > =20
> > -static int bq24190_set_charge_mode(struct bq24190_dev_info *bdi, u8 va=
l)
> > +static int bq24190_set_otg_vbus(struct bq24190_dev_info *bdi, bool ena=
ble)
> >  {
> > +	union power_supply_propval val =3D { .intval =3D bdi->charge_type };
> >  	int ret;
> > =20
> >  	ret =3D pm_runtime_get_sync(bdi->dev);
> > @@ -513,9 +519,14 @@ static int bq24190_set_charge_mode(struct bq24190_=
dev_info *bdi, u8 val)
> >  		return ret;
> >  	}
> > =20
> > -	ret =3D bq24190_write_mask(bdi, BQ24190_REG_POC,
> > -				 BQ24190_REG_POC_CHG_CONFIG_MASK,
> > -				 BQ24190_REG_POC_CHG_CONFIG_SHIFT, val);
> > +	bdi->otg_vbus_enabled =3D enable;
> > +	if (enable)
> > +		ret =3D bq24190_write_mask(bdi, BQ24190_REG_POC,
> > +					 BQ24190_REG_POC_CHG_CONFIG_MASK,
> > +					 BQ24190_REG_POC_CHG_CONFIG_SHIFT,
> > +					 BQ24190_REG_POC_CHG_CONFIG_OTG);
> > +	else
> > +		ret =3D bq24190_charger_set_charge_type(bdi, &val);
> > =20
> >  	pm_runtime_mark_last_busy(bdi->dev);
> >  	pm_runtime_put_autosuspend(bdi->dev);
> > @@ -526,14 +537,12 @@ static int bq24190_set_charge_mode(struct bq24190=
_dev_info *bdi, u8 val)
> >  #ifdef CONFIG_REGULATOR
> >  static int bq24190_vbus_enable(struct regulator_dev *dev)
> >  {
> > -	return bq24190_set_charge_mode(rdev_get_drvdata(dev),
> > -				       BQ24190_REG_POC_CHG_CONFIG_OTG);
> > +	return bq24190_set_otg_vbus(rdev_get_drvdata(dev), true);
> >  }
> > =20
> >  static int bq24190_vbus_disable(struct regulator_dev *dev)
> >  {
> > -	return bq24190_set_charge_mode(rdev_get_drvdata(dev),
> > -				       BQ24190_REG_POC_CHG_CONFIG_CHARGE);
> > +	return bq24190_set_otg_vbus(rdev_get_drvdata(dev), false);
> >  }
> > =20
> >  static int bq24190_vbus_is_enabled(struct regulator_dev *dev)
> > @@ -559,8 +568,9 @@ static int bq24190_vbus_is_enabled(struct regulator=
_dev *dev)
> >  	if (ret)
> >  		return ret;
> > =20
> > -	return (val =3D=3D BQ24190_REG_POC_CHG_CONFIG_OTG ||
> > -		val =3D=3D BQ24190_REG_POC_CHG_CONFIG_OTG_ALT);
> > +	bdi->otg_vbus_enabled =3D (val =3D=3D BQ24190_REG_POC_CHG_CONFIG_OTG =
||
> > +				 val =3D=3D BQ24190_REG_POC_CHG_CONFIG_OTG_ALT);
> > +	return bdi->otg_vbus_enabled;
> >  }
> > =20
> >  static const struct regulator_ops bq24190_vbus_ops =3D {
> > @@ -807,6 +817,14 @@ static int bq24190_charger_set_charge_type(struct =
bq24190_dev_info *bdi,
> >  		return -EINVAL;
> >  	}
> > =20
> > +	bdi->charge_type =3D val->intval;
> > +	/*
> > +	 * If the 5V Vbus boost regulator is enabled delay setting
> > +	 * the charge-type until its gets disabled.
> > +	 */
> > +	if (bdi->otg_vbus_enabled)
> > +		return 0;
> > +
> >  	if (chg_config) { /* Enabling the charger */
> >  		ret =3D bq24190_write_mask(bdi, BQ24190_REG_CCC,
> >  				BQ24190_REG_CCC_FORCE_20PCT_MASK,
> > @@ -1788,6 +1806,7 @@ static int bq24190_probe(struct i2c_client *clien=
t,
> >  	bdi->dev =3D dev;
> >  	strncpy(bdi->model_name, id->name, I2C_NAME_SIZE);
> >  	mutex_init(&bdi->f_reg_lock);
> > +	bdi->charge_type =3D POWER_SUPPLY_CHARGE_TYPE_FAST;
> >  	bdi->f_reg =3D 0;
> >  	bdi->ss_reg =3D BQ24190_REG_SS_VBUS_STAT_MASK; /* impossible state */
> >  	INIT_DELAYED_WORK(&bdi->input_current_limit_work,
> > @@ -1925,7 +1944,7 @@ static void bq24190_shutdown(struct i2c_client *c=
lient)
> >  	struct bq24190_dev_info *bdi =3D i2c_get_clientdata(client);
> > =20
> >  	/* Turn off 5V boost regulator on shutdown */
> > -	bq24190_set_charge_mode(bdi, BQ24190_REG_POC_CHG_CONFIG_CHARGE);
> > +	bq24190_set_otg_vbus(bdi, false);
> >  }
> > =20
> >  static __maybe_unused int bq24190_runtime_suspend(struct device *dev)
> > --=20
> > 2.33.1
> >=20
> >=20
>=20
> --=20
> With Best Regards,
> Andy Shevchenko
>=20
>=20

--xttxxag3aqamgpj6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIZKasACgkQ2O7X88g7
+prHMQ/+Jy+6OBjTt3VGAFN2AuekkFYfthwJBTBJG0H0N09wm7er+0zMt0+vgBJY
SIk2y5fruwsy/eEOa/9vJC/7m5b1zQ2RERf5x7APQVA0219AFVY+RdAjapa3i6+p
2Mnte/YNS86YUFIaktGuicC0pUIqQWO8+fVOQ/M9A7Ovadvugro1Nwn4pqGq4MWe
HSzot2EFnpbyg4Ni4pTwD/mnj3pVn9IAxH21yBvd8vYMY2IPKisGuWXNu3i9cvN8
zF2pP0bA8qskJoBFNJV9w2g8wJW7EtAc55lg4eXBtJ5tHWcEl1ix84sL9DU3Z44o
QJeKO2cqFgLgrwDxIuJOm7k02cMpHwjmu6wZ2DnMZTTKFc6rePnSuzNjld16XP2f
BqNnU9qc3dwdCSxMTpvvORNtgn9WV6PqPTXz+2uKDPyW5ye7z7KELSzWHPfOmBD4
e7rjfPh7RZL7k3B/aO3l3RPDA2fs7Ujj5F9ArctOWmZaMzeyJp+T2TiTX7fL+P+Q
eUCcqyM5BIvi4rFPe1X+fubab7IozXghKHCVvegDz73gcPBAJhNCtmyjex/vzRk5
y8dswkuZnHTavWAIP2mYZ6Th8rHKHjuYBO21l1V5yFhx3RcOM0XdMcBZMJyu3Ulw
AL2r9uAk+yC8b3rv8jNHF/guNUyS9rhTxRBMQUPcvTgEbGeBr0A=
=w/zj
-----END PGP SIGNATURE-----

--xttxxag3aqamgpj6--
