Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6450A2DFA7E
	for <lists+linux-pm@lfdr.de>; Mon, 21 Dec 2020 10:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgLUJyD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Dec 2020 04:54:03 -0500
Received: from mail-40134.protonmail.ch ([185.70.40.134]:20646 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgLUJyC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Dec 2020 04:54:02 -0500
Date:   Mon, 21 Dec 2020 09:53:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1608544399;
        bh=/38lsRLJe7/5z9BV9jp6fBn9SOkHHXYE+qEIe93Wcbs=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=rCNOqQlxlvhtebc7ArWf8Zb6IwxqNnNanwO6DlKLZyq2VmS2fdHgq/WNzx3BD98jh
         Mclt3fK9uTBLmsoKaWEK6LJxzFXDTX0hxICico2u+CDOCfgWL8kjb2bAa/yK47Bsut
         ZZIRXEyAuzrUQyp6mackbOvsq7fowhLv7AprR8bk=
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
        ~postmarketos/upstreaming@lists.sr.ht,
        Timon Baetz <timon.baetz@protonmail.com>
Reply-To: Timon Baetz <timon.baetz@protonmail.com>
Subject: [PATCH v2 2/6] power: supply: max8997_charger: Set CHARGER current limit
Message-ID: <20201221095001.595366-2-timon.baetz@protonmail.com>
In-Reply-To: <20201221095001.595366-1-timon.baetz@protonmail.com>
References: <20201202203516.43053-1-timon.baetz@protonmail.com> <20201221095001.595366-1-timon.baetz@protonmail.com>
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

Register for extcon notification and set charging current depending on
the detected cable type. Current values are taken from vendor kernel,
where most charger types end up setting 650mA [0].

Also enable and disable the CHARGER regulator based on extcon events.

[0] https://github.com/krzk/linux-vendor-backup/blob/samsung/galaxy-s2-epic=
-4g-touch-sph-d710-exynos4210-dump/drivers/misc/max8997-muic.c#L1675-L1678

Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
---
 drivers/mfd/max8997.c                  |  4 +-
 drivers/power/supply/max8997_charger.c | 94 ++++++++++++++++++++++++++
 2 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/max8997.c b/drivers/mfd/max8997.c
index 68d8f2b95287..55d3a6f97783 100644
--- a/drivers/mfd/max8997.c
+++ b/drivers/mfd/max8997.c
@@ -29,9 +29,9 @@
 static const struct mfd_cell max8997_devs[] =3D {
 =09{ .name =3D "max8997-pmic", },
 =09{ .name =3D "max8997-rtc", },
-=09{ .name =3D "max8997-battery", },
+=09{ .name =3D "max8997-battery", .of_compatible =3D "maxim,max8997-batter=
y", },
 =09{ .name =3D "max8997-haptic", },
-=09{ .name =3D "max8997-muic", },
+=09{ .name =3D "max8997-muic", .of_compatible =3D "maxim,max8997-muic", },
 =09{ .name =3D "max8997-led", .id =3D 1 },
 =09{ .name =3D "max8997-led", .id =3D 2 },
 };
diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power/supply/=
max8997_charger.c
index 1947af25879a..6e8750e455ea 100644
--- a/drivers/power/supply/max8997_charger.c
+++ b/drivers/power/supply/max8997_charger.c
@@ -6,12 +6,14 @@
 //  MyungJoo Ham <myungjoo.ham@samsung.com>
=20
 #include <linux/err.h>
+#include <linux/extcon.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/mfd/max8997.h>
 #include <linux/mfd/max8997-private.h>
+#include <linux/regulator/consumer.h>
=20
 /* MAX8997_REG_STATUS4 */
 #define DCINOK_SHIFT=09=091
@@ -31,6 +33,10 @@ struct charger_data {
 =09struct device *dev;
 =09struct max8997_dev *iodev;
 =09struct power_supply *battery;
+=09struct regulator *reg;
+=09struct extcon_dev *edev;
+=09struct notifier_block extcon_nb;
+=09struct work_struct extcon_work;
 };
=20
 static enum power_supply_property max8997_battery_props[] =3D {
@@ -88,6 +94,67 @@ static int max8997_battery_get_property(struct power_sup=
ply *psy,
 =09return 0;
 }
=20
+static void max8997_battery_extcon_evt_stop_work(void *data)
+{
+=09struct charger_data *charger =3D data;
+
+=09cancel_work_sync(&charger->extcon_work);
+}
+
+static void max8997_battery_extcon_evt_worker(struct work_struct *work)
+{
+=09struct charger_data *charger =3D
+=09    container_of(work, struct charger_data, extcon_work);
+=09struct extcon_dev *edev =3D charger->edev;
+=09int current_limit, ret;
+
+=09if (extcon_get_state(edev, EXTCON_CHG_USB_SDP) > 0) {
+=09=09dev_dbg(charger->dev, "USB SDP charger is connected\n");
+=09=09current_limit =3D 450000;
+=09} else if (extcon_get_state(edev, EXTCON_CHG_USB_DCP) > 0) {
+=09=09dev_dbg(charger->dev, "USB DCP charger is connected\n");
+=09=09current_limit =3D 650000;
+=09} else if (extcon_get_state(edev, EXTCON_CHG_USB_FAST) > 0) {
+=09=09dev_dbg(charger->dev, "USB FAST charger is connected\n");
+=09=09current_limit =3D 650000;
+=09} else if (extcon_get_state(edev, EXTCON_CHG_USB_SLOW) > 0) {
+=09=09dev_dbg(charger->dev, "USB SLOW charger is connected\n");
+=09=09current_limit =3D 650000;
+=09} else if (extcon_get_state(edev, EXTCON_CHG_USB_CDP) > 0) {
+=09=09dev_dbg(charger->dev, "USB CDP charger is connected\n");
+=09=09current_limit =3D 650000;
+=09} else {
+=09=09dev_dbg(charger->dev, "USB charger is diconnected\n");
+=09=09current_limit =3D -1;
+=09}
+
+=09if (current_limit > 0) {
+=09=09ret =3D regulator_set_current_limit(charger->reg, current_limit, cur=
rent_limit);
+=09=09if (ret) {
+=09=09=09dev_err(charger->dev, "failed to set current limit: %d\n", ret);
+=09=09=09goto regulator_disable;
+=09=09}
+=09=09ret =3D regulator_enable(charger->reg);
+=09=09if (ret)
+=09=09=09dev_err(charger->dev, "failed to enable regulator: %d\n", ret);
+=09=09return;
+=09}
+
+regulator_disable:
+=09ret  =3D regulator_disable(charger->reg);
+=09if (ret)
+=09=09dev_err(charger->dev, "failed to disable regulator: %d\n", ret);
+}
+
+static int max8997_battery_extcon_evt(struct notifier_block *nb,
+=09=09=09=09unsigned long event, void *param)
+{
+=09struct charger_data *charger =3D
+=09=09container_of(nb, struct charger_data, extcon_nb);
+=09schedule_work(&charger->extcon_work);
+=09return NOTIFY_OK;
+}
+
 static const struct power_supply_desc max8997_battery_desc =3D {
 =09.name=09=09=3D "max8997_pmic",
 =09.type=09=09=3D POWER_SUPPLY_TYPE_BATTERY,
@@ -170,6 +237,33 @@ static int max8997_battery_probe(struct platform_devic=
e *pdev)
 =09=09return PTR_ERR(charger->battery);
 =09}
=20
+=09charger->reg =3D devm_regulator_get(&pdev->dev, "charger");
+=09if (IS_ERR(charger->reg)) {
+=09=09dev_err(&pdev->dev, "couldn't get charger regulator\n");
+=09=09return PTR_ERR(charger->reg);
+=09}
+
+=09charger->edev =3D extcon_get_edev_by_phandle(&pdev->dev, 0);
+=09if (IS_ERR(charger->edev)) {
+=09=09if (PTR_ERR(charger->edev) !=3D -EPROBE_DEFER)
+=09=09=09dev_err(charger->dev, "couldn't get extcon device\n");
+=09=09return PTR_ERR(charger->edev);
+=09}
+
+=09INIT_WORK(&charger->extcon_work, max8997_battery_extcon_evt_worker);
+=09ret =3D devm_add_action(&pdev->dev, max8997_battery_extcon_evt_stop_wor=
k, charger);
+=09if (ret) {
+=09=09dev_err(&pdev->dev, "failed to add extcon evt stop action: %d\n", re=
t);
+=09=09return ret;
+=09}
+=09charger->extcon_nb.notifier_call =3D max8997_battery_extcon_evt;
+=09ret =3D devm_extcon_register_notifier_all(&pdev->dev, charger->edev,
+=09=09=09=09=09=09&charger->extcon_nb);
+=09if (ret) {
+=09=09dev_err(&pdev->dev, "failed to register extcon notifier\n");
+=09=09return ret;
+=09};
+
 =09return 0;
 }
=20
--=20
2.25.1


