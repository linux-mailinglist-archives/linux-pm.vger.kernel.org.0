Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E619125867
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 01:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfLSATc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 19:19:32 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38964 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfLSATc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 19:19:32 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A3F38291E6E
Received: by earth.universe (Postfix, from userid 1000)
        id E09A33C0C7B; Thu, 19 Dec 2019 01:19:27 +0100 (CET)
Date:   Thu, 19 Dec 2019 01:19:27 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Chris Healy <cphealy@gmail.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>, linux-pm@vger.kernel.org,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        patchwork-lst@pengutronix.de
Subject: Re: [PATCH] power: suppy: ucs1002: disable power when max current is
 0
Message-ID: <20191219001927.jjtwuigm3tfvxpk2@earth.universe>
References: <20191119170004.24533-1-l.stach@pengutronix.de>
 <CAFXsbZp3WvMYiF71bsmsN50V=4DHQOYeiXmbJbxYfS+MWhDT5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="miql4zf7wde2ujn5"
Content-Disposition: inline
In-Reply-To: <CAFXsbZp3WvMYiF71bsmsN50V=4DHQOYeiXmbJbxYfS+MWhDT5Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--miql4zf7wde2ujn5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Nov 22, 2019 at 12:25:28PM -0800, Chris Healy wrote:
> On Tue, Nov 19, 2019 at 9:00 AM Lucas Stach <l.stach@pengutronix.de> wrote:
> >
> > For some devices userspace needs the ability to completely cut the power
> > to the USB devices connected to the charge controller. An easy way to
> > achieve this is by allowing 0 as a valid max current and forcibly disable
> > the output in that case, as well as enable it again if the regulator is
> > in use and a non-0 max current is set.
> >
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
>
> Tested-by: Chris Healy <cphealy@gmail.com>

Thanks, queued to power-supply's for-next branch.

-- Sebastian

> >  drivers/power/supply/ucs1002_power.c | 42 +++++++++++++++++++++++++---
> >  1 file changed, 38 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/ucs1002_power.c
> > index 1b80ae479e7d..0ca80d00b80a 100644
> > --- a/drivers/power/supply/ucs1002_power.c
> > +++ b/drivers/power/supply/ucs1002_power.c
> > @@ -100,7 +100,9 @@ struct ucs1002_info {
> >         struct i2c_client *client;
> >         struct regmap *regmap;
> >         struct regulator_desc *regulator_descriptor;
> > +       struct regulator_dev *rdev;
> >         bool present;
> > +       bool output_disable;
> >  };
> >
> >  static enum power_supply_property ucs1002_props[] = {
> > @@ -233,6 +235,11 @@ static int ucs1002_get_max_current(struct ucs1002_info *info,
> >         unsigned int reg;
> >         int ret;
> >
> > +       if (info->output_disable) {
> > +               val->intval = 0;
> > +               return 0;
> > +       }
> > +
> >         ret = regmap_read(info->regmap, UCS1002_REG_ILIMIT, &reg);
> >         if (ret)
> >                 return ret;
> > @@ -247,6 +254,12 @@ static int ucs1002_set_max_current(struct ucs1002_info *info, u32 val)
> >         unsigned int reg;
> >         int ret, idx;
> >
> > +       if (val == 0) {
> > +               info->output_disable = true;
> > +               regulator_disable_regmap(info->rdev);
> > +               return 0;
> > +       }
> > +
> >         for (idx = 0; idx < ARRAY_SIZE(ucs1002_current_limit_uA); idx++) {
> >                 if (val == ucs1002_current_limit_uA[idx])
> >                         break;
> > @@ -270,6 +283,12 @@ static int ucs1002_set_max_current(struct ucs1002_info *info, u32 val)
> >         if (reg != idx)
> >                 return -EINVAL;
> >
> > +       info->output_disable = false;
> > +
> > +       if (info->rdev && info->rdev->use_count &&
> > +           !regulator_is_enabled_regmap(info->rdev))
> > +               regulator_enable_regmap(info->rdev);
> > +
> >         return 0;
> >  }
> >
> > @@ -470,9 +489,24 @@ static irqreturn_t ucs1002_alert_irq(int irq, void *data)
> >         return IRQ_HANDLED;
> >  }
> >
> > +int ucs1002_regulator_enable(struct regulator_dev *rdev)
> > +{
> > +       struct ucs1002_info *info = rdev_get_drvdata(rdev);
> > +
> > +       /*
> > +        * If the output is disabled due to 0 maximum current, just pretend the
> > +        * enable did work. The regulator will be enabled as soon as we get a
> > +        * a non-zero maximum current budget.
> > +        */
> > +       if (info->output_disable)
> > +               return 0;
> > +
> > +       return regulator_enable_regmap(rdev);
> > +}
> > +
> >  static const struct regulator_ops ucs1002_regulator_ops = {
> >         .is_enabled     = regulator_is_enabled_regmap,
> > -       .enable         = regulator_enable_regmap,
> > +       .enable         = ucs1002_regulator_enable,
> >         .disable        = regulator_disable_regmap,
> >  };
> >
> > @@ -499,7 +533,6 @@ static int ucs1002_probe(struct i2c_client *client,
> >         };
> >         struct regulator_config regulator_config = {};
> >         int irq_a_det, irq_alert, ret;
> > -       struct regulator_dev *rdev;
> >         struct ucs1002_info *info;
> >         unsigned int regval;
> >
> > @@ -589,10 +622,11 @@ static int ucs1002_probe(struct i2c_client *client,
> >         regulator_config.dev = dev;
> >         regulator_config.of_node = dev->of_node;
> >         regulator_config.regmap = info->regmap;
> > +       regulator_config.driver_data = info;
> >
> > -       rdev = devm_regulator_register(dev, info->regulator_descriptor,
> > +       info->rdev = devm_regulator_register(dev, info->regulator_descriptor,
> >                                        &regulator_config);
> > -       ret = PTR_ERR_OR_ZERO(rdev);
> > +       ret = PTR_ERR_OR_ZERO(info->rdev);
> >         if (ret) {
> >                 dev_err(dev, "Failed to register VBUS regulator: %d\n", ret);
> >                 return ret;
> > --
> > 2.20.1
> >

--miql4zf7wde2ujn5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl36wg8ACgkQ2O7X88g7
+po6JBAAnK6Lcgah/W2puLXp7IEejpt/Tukb43PlrDEvGeLT/n5fCFGKb/Z0nm7T
SFe0WAQXjS/NEYm1n+/fIFV/DF7RbADIXTxhI2dtUyKMcDDgFztHQq5OUQDRqA8R
yUo4ThW9tpIr0NhaVApKhQNMnvo+YpYgB3QwKADA68R01svfOi9mhKDu17A+cpHJ
RTJw9Z5n5KNr9mfcW+IQGDXC8DTfDUGVBZ2atk7ik++9iDe5eKYRS+Iupcvn1Dhh
M2Y0lCAy6K7IFq3WfuzduFIb7EEmOieESdLsPbI44xiVDgq3WEtvSTALQT4zBtK+
JS0SBW2lLdNc61DKUAudlh4zG/ERKQPyxzMEHpF9XmvtcosxX1zJrmNieGaEvVRz
U186sxMXHBi2Spq1TpaujeHh2WlAj9BrPupRbJIiATmGRYIp2hfjHzui76gmH04G
4vmHxF41k3qlpBvY0o7J/0Cwi063H6stfOfjievL5CcfMwE48FudG59UQPeitZyj
dARJMHYRa7FB/7sKxKQq7eciPCUqx9XF3ur0oMaOLBP06/EeT4H/IXGT/kAcYHwy
a8R5iEEMG5QkDt9M5TLikBDYKLvMytj1fKVejiyeeBbkYMMwsTMOivUrssKFIpdZ
QHdWrq7h+BjI8aKbG+MLXBHXvClxsUC1osnSbl+ergCIDh4k26U=
=i4Fn
-----END PGP SIGNATURE-----

--miql4zf7wde2ujn5--
