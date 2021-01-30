Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38D030974F
	for <lists+linux-pm@lfdr.de>; Sat, 30 Jan 2021 18:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbhA3RbI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 30 Jan 2021 12:31:08 -0500
Received: from mail-40136.protonmail.ch ([185.70.40.136]:54199 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbhA3RbE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 30 Jan 2021 12:31:04 -0500
Date:   Sat, 30 Jan 2021 17:30:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1612027817;
        bh=oQy4RevNDWFClH37MnwytBl8YcA2kgCeFHUG6CufrzE=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=RyCG1sqmI4l0wPx1P5Qgj3Zu5LJqGikvt9h7HNMPTiRdk0Zg91K07J8dwktAtCZMR
         yQtNtj+aBRVs1md5Kd28/+p11tIJym2pbHhA5BvG2NJyA3qWSpFLLJmJrxVUSZjlwr
         JVRahuP3RPLPKTs3fsLeIHG/D87jly/ZQbQzbYW0=
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
From:   Timon Baetz <timon.baetz@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        Timon Baetz <timon.baetz@protonmail.com>
Reply-To: Timon Baetz <timon.baetz@protonmail.com>
Subject: [PATCH 3/3] power: supply: max8997_charger: Switch to new binding
Message-ID: <20210130172747.2022977-4-timon.baetz@protonmail.com>
In-Reply-To: <20210130172747.2022977-1-timon.baetz@protonmail.com>
References: <20210130172747.2022977-1-timon.baetz@protonmail.com>
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

Get regulator from parent device's node and extcon by name.

Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
---
 drivers/power/supply/max8997_charger.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power/supply/=
max8997_charger.c
index 321bd6b8ee41..625d8cc4312a 100644
--- a/drivers/power/supply/max8997_charger.c
+++ b/drivers/power/supply/max8997_charger.c
@@ -168,6 +168,7 @@ static int max8997_battery_probe(struct platform_device=
 *pdev)
 =09int ret =3D 0;
 =09struct charger_data *charger;
 =09struct max8997_dev *iodev =3D dev_get_drvdata(pdev->dev.parent);
+=09struct device_node *np =3D pdev->dev.of_node;
 =09struct i2c_client *i2c =3D iodev->i2c;
 =09struct max8997_platform_data *pdata =3D iodev->pdata;
 =09struct power_supply_config psy_cfg =3D {};
@@ -237,20 +238,23 @@ static int max8997_battery_probe(struct platform_devi=
ce *pdev)
 =09=09return PTR_ERR(charger->battery);
 =09}
=20
+=09// grab regulator from parent device's node
+=09pdev->dev.of_node =3D iodev->dev->of_node;
 =09charger->reg =3D devm_regulator_get_optional(&pdev->dev, "charger");
+=09pdev->dev.of_node =3D np;
 =09if (IS_ERR(charger->reg)) {
 =09=09if (PTR_ERR(charger->reg) =3D=3D -EPROBE_DEFER)
 =09=09=09return -EPROBE_DEFER;
 =09=09dev_info(&pdev->dev, "couldn't get charger regulator\n");
 =09}
-=09charger->edev =3D extcon_get_edev_by_phandle(&pdev->dev, 0);
-=09if (IS_ERR(charger->edev)) {
-=09=09if (PTR_ERR(charger->edev) =3D=3D -EPROBE_DEFER)
+=09charger->edev =3D extcon_get_extcon_dev("max8997-muic");
+=09if (IS_ERR_OR_NULL(charger->edev)) {
+=09=09if (!charger->edev)
 =09=09=09return -EPROBE_DEFER;
 =09=09dev_info(charger->dev, "couldn't get extcon device\n");
 =09}
=20
-=09if (!IS_ERR(charger->reg) && !IS_ERR(charger->edev)) {
+=09if (!IS_ERR(charger->reg) && !IS_ERR_OR_NULL(charger->edev)) {
 =09=09INIT_WORK(&charger->extcon_work, max8997_battery_extcon_evt_worker);
 =09=09ret =3D devm_add_action(&pdev->dev, max8997_battery_extcon_evt_stop_=
work, charger);
 =09=09if (ret) {
--=20
2.25.1


