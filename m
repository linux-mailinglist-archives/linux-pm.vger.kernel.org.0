Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED312CC8A9
	for <lists+linux-pm@lfdr.de>; Wed,  2 Dec 2020 22:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgLBVIx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Dec 2020 16:08:53 -0500
Received: from mail-02.mail-europe.com ([51.89.119.103]:59854 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgLBVIx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2020 16:08:53 -0500
Date:   Wed, 02 Dec 2020 21:07:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1606943247;
        bh=I5SKn72zxNLuAPxHXL8MBix5xnhTqEl1NdpeqJ8Fo7U=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=w52idPCvgPLyvLjhVxtahNHBhCZDZvpUNdmQWXjjzZQD5W5EUcKk/fFeiqshv2t/B
         NortxYpGn9NudNr86gAWiknF21gsKZKr6Iobu6f8f0PQmbl89OkLJX0EtEQC2P/OgR
         a83ZMQgYE7f5/h5JO1goAtYk8CBsSPtit0+KVdho=
To:     Sebastian Reichel <sre@kernel.org>
From:   Timon Baetz <timon.baetz@protonmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Timon Baetz <timon.baetz@protonmail.com>
Reply-To: Timon Baetz <timon.baetz@protonmail.com>
Subject: [PATCH 2/3] power: supply: max8997_charger: Set CHARGER current limit
Message-ID: <20201202203516.43053-2-timon.baetz@protonmail.com>
In-Reply-To: <20201202203516.43053-1-timon.baetz@protonmail.com>
References: <20201202203516.43053-1-timon.baetz@protonmail.com>
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
the detected cable type. Current values are taken from i9100 kernel
fork.

Enable and disable the CHARGER regulator based on extcon events and
remove regulator-always-on from the device tree.

Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
---
 arch/arm/boot/dts/exynos4210-i9100.dts |  1 -
 drivers/power/supply/max8997_charger.c | 92 ++++++++++++++++++++++++++
 2 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/exy=
nos4210-i9100.dts
index 6d0c04d77a39..9f8d927e0d21 100644
--- a/arch/arm/boot/dts/exynos4210-i9100.dts
+++ b/arch/arm/boot/dts/exynos4210-i9100.dts
@@ -560,7 +560,6 @@ charger_reg: CHARGER {
 =09=09=09=09regulator-name =3D "CHARGER";
 =09=09=09=09regulator-min-microamp =3D <60000>;
 =09=09=09=09regulator-max-microamp =3D <2580000>;
-=09=09=09=09regulator-always-on;
 =09=09=09};
=20
 =09=09=09chargercv_reg: CHARGER_CV {
diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power/supply/=
max8997_charger.c
index 1947af25879a..26cd271576ec 100644
--- a/drivers/power/supply/max8997_charger.c
+++ b/drivers/power/supply/max8997_charger.c
@@ -6,6 +6,7 @@
 //  MyungJoo Ham <myungjoo.ham@samsung.com>
=20
 #include <linux/err.h>
+#include <linux/extcon.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
@@ -31,6 +32,12 @@ struct charger_data {
 =09struct device *dev;
 =09struct max8997_dev *iodev;
 =09struct power_supply *battery;
+=09struct regulator *reg;
+=09struct {
+=09=09struct extcon_dev *edev;
+=09=09struct notifier_block nb;
+=09=09struct work_struct work;
+=09} extcon;
 };
=20
 static enum power_supply_property max8997_battery_props[] =3D {
@@ -88,6 +95,63 @@ static int max8997_battery_get_property(struct power_sup=
ply *psy,
 =09return 0;
 }
=20
+static void max8997_battery_extcon_evt_stop_work(void *data)
+{
+=09struct charger_data *charger =3D data;
+
+=09cancel_work_sync(&charger->extcon.work);
+}
+
+static void max8997_battery_extcon_evt_worker(struct work_struct *work)
+{
+=09struct charger_data *charger =3D
+=09    container_of(work, struct charger_data, extcon.work);
+=09int ret, current_limit;
+=09struct extcon_dev *edev =3D charger->extcon.edev;
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
+=09=09if (ret)
+=09=09=09dev_err(charger->dev, "failed to set current limit: %d\n", ret);
+=09=09ret =3D regulator_enable(charger->reg);
+=09=09if (ret)
+=09=09=09dev_err(charger->dev, "failed to enable regulator: %d\n", ret);
+=09} else {
+=09=09ret =3D regulator_disable(charger->reg);
+=09=09if (ret)
+=09=09=09dev_err(charger->dev, "failed to disable regulator: %d\n", ret);
+=09}
+}
+
+static int max8997_battery_extcon_evt(struct notifier_block *nb,
+=09=09=09=09unsigned long event, void *param)
+{
+=09struct charger_data *charger =3D
+=09=09container_of(nb, struct charger_data, extcon.nb);
+=09schedule_work(&charger->extcon.work);
+=09return NOTIFY_OK;
+}
+
 static const struct power_supply_desc max8997_battery_desc =3D {
 =09.name=09=09=3D "max8997_pmic",
 =09.type=09=09=3D POWER_SUPPLY_TYPE_BATTERY,
@@ -104,6 +168,7 @@ static int max8997_battery_probe(struct platform_device=
 *pdev)
 =09struct i2c_client *i2c =3D iodev->i2c;
 =09struct max8997_platform_data *pdata =3D iodev->pdata;
 =09struct power_supply_config psy_cfg =3D {};
+=09struct extcon_dev *edev;
=20
 =09if (!pdata) {
 =09=09dev_err(&pdev->dev, "No platform data supplied.\n");
@@ -151,6 +216,12 @@ static int max8997_battery_probe(struct platform_devic=
e *pdev)
 =09=09return ret;
 =09}
=20
+=09edev =3D extcon_get_extcon_dev("max8997-muic");
+=09if (edev =3D=3D NULL) {
+=09=09dev_info(&pdev->dev, "extcon is not ready, probe deferred\n");
+=09=09return -EPROBE_DEFER;
+=09}
+
 =09charger =3D devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
 =09if (!charger)
 =09=09return -ENOMEM;
@@ -170,6 +241,27 @@ static int max8997_battery_probe(struct platform_devic=
e *pdev)
 =09=09return PTR_ERR(charger->battery);
 =09}
=20
+=09charger->reg =3D regulator_get(&pdev->dev, "CHARGER");
+=09if (IS_ERR(charger->reg)) {
+=09=09dev_err(&pdev->dev, "couldn't get CHARGER regulator\n");
+=09=09return PTR_ERR(charger->reg);
+=09}
+
+=09INIT_WORK(&charger->extcon.work, max8997_battery_extcon_evt_worker);
+=09ret =3D devm_add_action(&pdev->dev, max8997_battery_extcon_evt_stop_wor=
k, charger);
+=09if (ret) {
+=09=09dev_err(&pdev->dev, "failed to add extcon evt stop action: %d\n", re=
t);
+=09=09return ret;
+=09}
+=09charger->extcon.edev =3D edev;
+=09charger->extcon.nb.notifier_call =3D max8997_battery_extcon_evt;
+=09ret =3D devm_extcon_register_notifier_all(&pdev->dev, charger->extcon.e=
dev,
+=09=09=09&charger->extcon.nb);
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


