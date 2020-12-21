Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2A52DFDA0
	for <lists+linux-pm@lfdr.de>; Mon, 21 Dec 2020 16:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbgLUPf7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Dec 2020 10:35:59 -0500
Received: from mail-40136.protonmail.ch ([185.70.40.136]:35522 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgLUPf7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Dec 2020 10:35:59 -0500
Date:   Mon, 21 Dec 2020 15:35:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1608564914;
        bh=QlvYjnjuTAtkMuwvMNdku+ZoqZhVDZ+Fm2DxZu8MGUs=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=xgYRsrC+ZlmB1pEaPNW9V9voN7GmhNjvXm2i9mFT+hH0CYvPqUsO3QemYdsPS7f+M
         bB6pO64IRpZ/V8MuytTlKiGNknX8MnqpsGA54FYCK/ecBJuqTSo3wx71F/pmxtWm+j
         ks55MUJs8MnwS8K72sCOwfaw3t/TzEMmgPgpfpsM=
To:     Krzysztof Kozlowski <krzk@kernel.org>
From:   Timon Baetz <timon.baetz@protonmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Reply-To: Timon Baetz <timon.baetz@protonmail.com>
Subject: Re: [PATCH v2 2/6] power: supply: max8997_charger: Set CHARGER current limit
Message-ID: <20201221163455.2c3f095d.timon.baetz@protonmail.com>
In-Reply-To: <20201221141627.GB33797@kozik-lap>
References: <20201202203516.43053-1-timon.baetz@protonmail.com> <20201221095001.595366-1-timon.baetz@protonmail.com> <20201221095001.595366-2-timon.baetz@protonmail.com> <20201221141627.GB33797@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 21 Dec 2020 15:16:27 +0100, Krzysztof Kozlowski wrote:
> On Mon, Dec 21, 2020 at 09:53:15AM +0000, Timon Baetz wrote:
> > Register for extcon notification and set charging current depending on
> > the detected cable type. Current values are taken from vendor kernel,
> > where most charger types end up setting 650mA [0].
> >
> > Also enable and disable the CHARGER regulator based on extcon events.
> >
> > [0] https://github.com/krzk/linux-vendor-backup/blob/samsung/galaxy-s2-=
epic-4g-touch-sph-d710-exynos4210-dump/drivers/misc/max8997-muic.c#L1675-L1=
678
> >
> > Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
> > ---
> >  drivers/mfd/max8997.c                  |  4 +-
> >  drivers/power/supply/max8997_charger.c | 94 ++++++++++++++++++++++++++
> >  2 files changed, 96 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mfd/max8997.c b/drivers/mfd/max8997.c
> > index 68d8f2b95287..55d3a6f97783 100644
> > --- a/drivers/mfd/max8997.c
> > +++ b/drivers/mfd/max8997.c
> > @@ -29,9 +29,9 @@
> >  static const struct mfd_cell max8997_devs[] =3D {
> >  =09{ .name =3D "max8997-pmic", },
> >  =09{ .name =3D "max8997-rtc", },
> > -=09{ .name =3D "max8997-battery", },
> > +=09{ .name =3D "max8997-battery", .of_compatible =3D "maxim,max8997-ba=
ttery", },
> >  =09{ .name =3D "max8997-haptic", },
> > -=09{ .name =3D "max8997-muic", },
> > +=09{ .name =3D "max8997-muic", .of_compatible =3D "maxim,max8997-muic"=
, }, =20
>=20
> Undocumented bindings. The checkpatch should complain about it, so I
> assume you did not run it. Please run the checkpatch.
>=20
> >  =09{ .name =3D "max8997-led", .id =3D 1 },
> >  =09{ .name =3D "max8997-led", .id =3D 2 },
> >  };
> > diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power/sup=
ply/max8997_charger.c
> > index 1947af25879a..6e8750e455ea 100644
> > --- a/drivers/power/supply/max8997_charger.c
> > +++ b/drivers/power/supply/max8997_charger.c
> > @@ -6,12 +6,14 @@
> >  //  MyungJoo Ham <myungjoo.ham@samsung.com>
> >
> >  #include <linux/err.h>
> > +#include <linux/extcon.h>
> >  #include <linux/module.h>
> >  #include <linux/slab.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/power_supply.h>
> >  #include <linux/mfd/max8997.h>
> >  #include <linux/mfd/max8997-private.h>
> > +#include <linux/regulator/consumer.h>
> >
> >  /* MAX8997_REG_STATUS4 */
> >  #define DCINOK_SHIFT=09=091
> > @@ -31,6 +33,10 @@ struct charger_data {
> >  =09struct device *dev;
> >  =09struct max8997_dev *iodev;
> >  =09struct power_supply *battery;
> > +=09struct regulator *reg;
> > +=09struct extcon_dev *edev;
> > +=09struct notifier_block extcon_nb;
> > +=09struct work_struct extcon_work;
> >  };
> >
> >  static enum power_supply_property max8997_battery_props[] =3D {
> > @@ -88,6 +94,67 @@ static int max8997_battery_get_property(struct power=
_supply *psy,
> >  =09return 0;
> >  }
> >
> > +static void max8997_battery_extcon_evt_stop_work(void *data)
> > +{
> > +=09struct charger_data *charger =3D data;
> > +
> > +=09cancel_work_sync(&charger->extcon_work);
> > +}
> > +
> > +static void max8997_battery_extcon_evt_worker(struct work_struct *work=
)
> > +{
> > +=09struct charger_data *charger =3D
> > +=09    container_of(work, struct charger_data, extcon_work);
> > +=09struct extcon_dev *edev =3D charger->edev;
> > +=09int current_limit, ret;
> > +
> > +=09if (extcon_get_state(edev, EXTCON_CHG_USB_SDP) > 0) {
> > +=09=09dev_dbg(charger->dev, "USB SDP charger is connected\n");
> > +=09=09current_limit =3D 450000;
> > +=09} else if (extcon_get_state(edev, EXTCON_CHG_USB_DCP) > 0) {
> > +=09=09dev_dbg(charger->dev, "USB DCP charger is connected\n");
> > +=09=09current_limit =3D 650000;
> > +=09} else if (extcon_get_state(edev, EXTCON_CHG_USB_FAST) > 0) {
> > +=09=09dev_dbg(charger->dev, "USB FAST charger is connected\n");
> > +=09=09current_limit =3D 650000;
> > +=09} else if (extcon_get_state(edev, EXTCON_CHG_USB_SLOW) > 0) {
> > +=09=09dev_dbg(charger->dev, "USB SLOW charger is connected\n");
> > +=09=09current_limit =3D 650000;
> > +=09} else if (extcon_get_state(edev, EXTCON_CHG_USB_CDP) > 0) {
> > +=09=09dev_dbg(charger->dev, "USB CDP charger is connected\n");
> > +=09=09current_limit =3D 650000;
> > +=09} else {
> > +=09=09dev_dbg(charger->dev, "USB charger is diconnected\n");
> > +=09=09current_limit =3D -1;
> > +=09}
> > +
> > +=09if (current_limit > 0) {
> > +=09=09ret =3D regulator_set_current_limit(charger->reg, current_limit,=
 current_limit);
> > +=09=09if (ret) {
> > +=09=09=09dev_err(charger->dev, "failed to set current limit: %d\n", re=
t);
> > +=09=09=09goto regulator_disable; =20
>=20
> Unusual error path... if regulator was not enabled before and
> regulator_set_current_limit() failed, you disable the regulator? Why?
> Wasn't it already disabled?

Because I thought you asked me to in v1 of this patch:
> Failure of setting the current should rather disable the charging.

I probably misunderstood you comment then. So I guess it should just
return?

Thanks for reviewing,
Timon

