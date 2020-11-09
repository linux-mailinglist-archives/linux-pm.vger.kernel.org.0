Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69CF2AC548
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 20:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbgKIToH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 14:44:07 -0500
Received: from mail-02.mail-europe.com ([51.89.119.103]:47406 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729336AbgKIToH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 14:44:07 -0500
Date:   Mon, 09 Nov 2020 19:43:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1604951042;
        bh=SFT4XaVfOyn6BnIvM53a+fBVoR87Tr9aFi2bP37+tOc=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=vnOtMncWPL5Sk5Dtq9CDqnhYneLwnE5VSN3HHlQu3YWUzC/7DjiKM5ZGpHNyrIrng
         R9dQYVEqwp+YDi+vpPHjEHJoLu2R+ZQn1aD+uxf15y6siU1OMb0csl4XUVukxx0KFQ
         Xh+tj2R5sE9VqTvS6cXRfpfFEoUSSlBoX7zCQHDI=
To:     Sebastian Reichel <sre@kernel.org>
From:   Timon Baetz <timon.baetz@protonmail.com>
Cc:     Timon Baetz <timon.baetz@protonmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Timon Baetz <timon.baetz@protonmail.com>
Subject: [PATCH 3/3] power: supply: max8997-charger: Improve getting charger status
Message-ID: <20201109194251.562203-3-timon.baetz@protonmail.com>
In-Reply-To: <20201109194251.562203-1-timon.baetz@protonmail.com>
References: <20201109194251.562203-1-timon.baetz@protonmail.com>
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

Detect charging and discharging state. Ported from downstream Samsung
Galaxy S2 (i9100) kernel fork.

Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
---
 drivers/power/supply/max8997_charger.c | 52 +++++++++++++++++---------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power/supply/=
max8997_charger.c
index 8fccd58dac67..1947af25879a 100644
--- a/drivers/power/supply/max8997_charger.c
+++ b/drivers/power/supply/max8997_charger.c
@@ -13,6 +13,20 @@
 #include <linux/mfd/max8997.h>
 #include <linux/mfd/max8997-private.h>
=20
+/* MAX8997_REG_STATUS4 */
+#define DCINOK_SHIFT=09=091
+#define DCINOK_MASK=09=09(1 << DCINOK_SHIFT)
+#define DETBAT_SHIFT=09=092
+#define DETBAT_MASK=09=09(1 << DETBAT_SHIFT)
+
+/* MAX8997_REG_MBCCTRL1 */
+#define TFCH_SHIFT=09=094
+#define TFCH_MASK=09=09(7 << TFCH_SHIFT)
+
+/* MAX8997_REG_MBCCTRL5 */
+#define ITOPOFF_SHIFT=09=090
+#define ITOPOFF_MASK=09=09(0xF << ITOPOFF_SHIFT)
+
 struct charger_data {
 =09struct device *dev;
 =09struct max8997_dev *iodev;
@@ -20,7 +34,7 @@ struct charger_data {
 };
=20
 static enum power_supply_property max8997_battery_props[] =3D {
-=09POWER_SUPPLY_PROP_STATUS, /* "FULL" or "NOT FULL" only. */
+=09POWER_SUPPLY_PROP_STATUS, /* "FULL", "CHARGING" or "DISCHARGING". */
 =09POWER_SUPPLY_PROP_PRESENT, /* the presence of battery */
 =09POWER_SUPPLY_PROP_ONLINE, /* charger is active or not */
 };
@@ -43,6 +57,10 @@ static int max8997_battery_get_property(struct power_sup=
ply *psy,
 =09=09=09return ret;
 =09=09if ((reg & (1 << 0)) =3D=3D 0x1)
 =09=09=09val->intval =3D POWER_SUPPLY_STATUS_FULL;
+=09=09else if ((reg & DCINOK_MASK))
+=09=09=09val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
+=09=09else
+=09=09=09val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
=20
 =09=09break;
 =09case POWER_SUPPLY_PROP_PRESENT:
@@ -50,7 +68,7 @@ static int max8997_battery_get_property(struct power_supp=
ly *psy,
 =09=09ret =3D max8997_read_reg(i2c, MAX8997_REG_STATUS4, &reg);
 =09=09if (ret)
 =09=09=09return ret;
-=09=09if ((reg & (1 << 2)) =3D=3D 0x0)
+=09=09if ((reg & DETBAT_MASK) =3D=3D 0x0)
 =09=09=09val->intval =3D 1;
=20
 =09=09break;
@@ -59,8 +77,7 @@ static int max8997_battery_get_property(struct power_supp=
ly *psy,
 =09=09ret =3D max8997_read_reg(i2c, MAX8997_REG_STATUS4, &reg);
 =09=09if (ret)
 =09=09=09return ret;
-=09=09/* DCINOK */
-=09=09if (reg & (1 << 1))
+=09=09if (reg & DCINOK_MASK)
 =09=09=09val->intval =3D 1;
=20
 =09=09break;
@@ -84,11 +101,14 @@ static int max8997_battery_probe(struct platform_devic=
e *pdev)
 =09int ret =3D 0;
 =09struct charger_data *charger;
 =09struct max8997_dev *iodev =3D dev_get_drvdata(pdev->dev.parent);
+=09struct i2c_client *i2c =3D iodev->i2c;
 =09struct max8997_platform_data *pdata =3D iodev->pdata;
 =09struct power_supply_config psy_cfg =3D {};
=20
-=09if (!pdata)
+=09if (!pdata) {
+=09=09dev_err(&pdev->dev, "No platform data supplied.\n");
 =09=09return -EINVAL;
+=09}
=20
 =09if (pdata->eoc_mA) {
 =09=09int val =3D (pdata->eoc_mA - 50) / 10;
@@ -97,30 +117,29 @@ static int max8997_battery_probe(struct platform_devic=
e *pdev)
 =09=09if (val > 0xf)
 =09=09=09val =3D 0xf;
=20
-=09=09ret =3D max8997_update_reg(iodev->i2c,
-=09=09=09=09MAX8997_REG_MBCCTRL5, val, 0xf);
+=09=09ret =3D max8997_update_reg(i2c, MAX8997_REG_MBCCTRL5,
+=09=09=09=09val << ITOPOFF_SHIFT, ITOPOFF_MASK);
 =09=09if (ret < 0) {
 =09=09=09dev_err(&pdev->dev, "Cannot use i2c bus.\n");
 =09=09=09return ret;
 =09=09}
 =09}
-
 =09switch (pdata->timeout) {
 =09case 5:
-=09=09ret =3D max8997_update_reg(iodev->i2c, MAX8997_REG_MBCCTRL1,
-=09=09=09=090x2 << 4, 0x7 << 4);
+=09=09ret =3D max8997_update_reg(i2c, MAX8997_REG_MBCCTRL1,
+=09=09=09=090x2 << TFCH_SHIFT, TFCH_MASK);
 =09=09break;
 =09case 6:
-=09=09ret =3D max8997_update_reg(iodev->i2c, MAX8997_REG_MBCCTRL1,
-=09=09=09=090x3 << 4, 0x7 << 4);
+=09=09ret =3D max8997_update_reg(i2c, MAX8997_REG_MBCCTRL1,
+=09=09=09=090x3 << TFCH_SHIFT, TFCH_MASK);
 =09=09break;
 =09case 7:
-=09=09ret =3D max8997_update_reg(iodev->i2c, MAX8997_REG_MBCCTRL1,
-=09=09=09=090x4 << 4, 0x7 << 4);
+=09=09ret =3D max8997_update_reg(i2c, MAX8997_REG_MBCCTRL1,
+=09=09=09=090x4 << TFCH_SHIFT, TFCH_MASK);
 =09=09break;
 =09case 0:
-=09=09ret =3D max8997_update_reg(iodev->i2c, MAX8997_REG_MBCCTRL1,
-=09=09=09=090x7 << 4, 0x7 << 4);
+=09=09ret =3D max8997_update_reg(i2c, MAX8997_REG_MBCCTRL1,
+=09=09=09=090x7 << TFCH_SHIFT, TFCH_MASK);
 =09=09break;
 =09default:
 =09=09dev_err(&pdev->dev, "incorrect timeout value (%d)\n",
@@ -138,7 +157,6 @@ static int max8997_battery_probe(struct platform_device=
 *pdev)
=20
 =09platform_set_drvdata(pdev, charger);
=20
-
 =09charger->dev =3D &pdev->dev;
 =09charger->iodev =3D iodev;
=20
--=20
2.25.1


