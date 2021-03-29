Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3589834D27B
	for <lists+linux-pm@lfdr.de>; Mon, 29 Mar 2021 16:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhC2Oii (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Mar 2021 10:38:38 -0400
Received: from mail-40133.protonmail.ch ([185.70.40.133]:24869 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbhC2OiI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Mar 2021 10:38:08 -0400
Date:   Mon, 29 Mar 2021 14:38:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1617028686;
        bh=lXVx8BFe7viSi/O3aYA/0KSuZphkAL5O14MdOJs613Y=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=xCSPYkcoXRsLnRZ0PBR7sI7hHSR4+m5cBnLbgh7hMAtoEOleop4/rH4Ez62BjxA/i
         nP1YqXTwxJWctScg5KF+1KOGfowd4FKxz+3+KGy3J21xnDv5IA0TWbKU/3vCWsrpe8
         pK+2yfgG2/iV5yEBIlRmkfDuCMi0u45lQDF3dbE0=
To:     Sebastian Reichel <sre@kernel.org>
From:   Timon Baetz <timon.baetz@protonmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Timon Baetz <timon.baetz@protonmail.com>
Reply-To: Timon Baetz <timon.baetz@protonmail.com>
Subject: [PATCH v2 1/1] power: supply: max8997_charger: Switch to new binding
Message-ID: <20210329143715.806981-2-timon.baetz@protonmail.com>
In-Reply-To: <20210329143715.806981-1-timon.baetz@protonmail.com>
References: <20210329143715.806981-1-timon.baetz@protonmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/supply/max8997_charger.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power/supply/=
max8997_charger.c
index a90c01884026..25207fe2aa68 100644
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

-=09if (!IS_ERR(charger->reg) && !IS_ERR(charger->edev)) {
+=09if (!IS_ERR(charger->reg) && !IS_ERR_OR_NULL(charger->edev)) {
 =09=09INIT_WORK(&charger->extcon_work, max8997_battery_extcon_evt_worker);
 =09=09ret =3D devm_add_action(&pdev->dev, max8997_battery_extcon_evt_stop_=
work, charger);
 =09=09if (ret) {
--
2.25.1


