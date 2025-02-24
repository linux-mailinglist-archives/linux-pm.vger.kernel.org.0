Return-Path: <linux-pm+bounces-22845-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CD8A4309F
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 00:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088721898628
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 23:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B10520C022;
	Mon, 24 Feb 2025 23:22:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99AD20B7F7;
	Mon, 24 Feb 2025 23:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740439320; cv=none; b=mEnNSexxdcgt7T94HkMpo7ClZlBtTYpF26Hqhb3/RPAEYh7rgKrhkb9FhmypGPPP3YzVObO4S4CGuxKfs4/DP+e5JKbdkW6A32EOBn5jzPmMkbOUIKW4cTTgi+Uf8/31NKClbqg+sibRuW/aA7JyOgEqppzcBL3dJ40mugM3BlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740439320; c=relaxed/simple;
	bh=ICE/RE1EYvr7EWGuxu2cszpRt22xk9kdxveP+xWDpfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CqTbi4QmENbPDTzBih9SwwjW4ZWiOOaVdKINkq4zg3hLhsMtvzhXduw9BxS8udU5ojm46FN1xYsY6BeoOo+hyGkbMZdym6XbVZuOsZ2UWDVGFHmPNIXnfD8Ai2Rs6z3xNRIxag7q/v9ERzWfSADDBzIdfStMr5UiXE2cfIvavZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56998C4CEE9;
	Mon, 24 Feb 2025 23:22:00 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 4AD7D18067C; Tue, 25 Feb 2025 00:21:58 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 25 Feb 2025 00:21:37 +0100
Subject: [PATCH 4/7] power: supply: all: switch psy_cfg from of_node to
 fwnode
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-psy-core-convert-to-fwnode-v1-4-d5e4369936bb@collabora.com>
References: <20250225-psy-core-convert-to-fwnode-v1-0-d5e4369936bb@collabora.com>
In-Reply-To: <20250225-psy-core-convert-to-fwnode-v1-0-d5e4369936bb@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Paul Cercueil <paul@crapouillou.net>, Samuel Holland <samuel@sholland.org>, 
 David Lechner <david@lechnology.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=36098;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=ICE/RE1EYvr7EWGuxu2cszpRt22xk9kdxveP+xWDpfs=;
 b=owEBbQKS/ZANAwAKAdju1/PIO/qaAcsmYgBnvP8ULXe20Kfzd01TH/76NfoCx6McO/4dD/P6W
 qPZqX3ssNCJAjMEAAEKAB0WIQTvZg0HRj+Lcmp5VBPY7tfzyDv6mgUCZ7z/FAAKCRDY7tfzyDv6
 ml/5D/9v+yb9qBfUCuKEDP6wSEFqRnkQiFoY0kKqy2q1yY1YWMJqs016XnS0ctGS3vO+Qb1bVx/
 R2cPqX2udDGaDsgsoAfKa123TKmPIK+O1xyBJO+m2l2SObSzB/TVXdI0HLUOQ1lA9MOmAc+SpQW
 IMbaaW2cFILCbLdIIZqLShbGF7e94DrkQ4sB88GGVFst6IxCIEHCShMot5B4N697tGVF2J5lDjH
 TYk9v2Kf52Nc5SIvLYp0/uJ/wRz8erd/aBqwJl9k+1IqhKfUy/UBMmfPAaS7VIR8gKaArZsPtx1
 YdcvSDYUCOKpKwr5InWWqj498sVGv1P5/3vfrJ6DIxwhHBsGmpvaHGW8G93Tb0mVoGfz+5vQ1lk
 um9XmDtQGiaC6zGCMgH34gkYqnEKPRYpFMfLsMtPJDxEph1rCCDwUDu51uBwilz7wBpbdl756Lo
 vGp+Y2Xe/Xj4cYlG6FGg9XGRvrNsVLrgUjhOzHulmTMP8UZbrVMh2UlTIBePn/7nf7XvOoW1ZD6
 XPaHisp5FdgQ7etrSpIcVoA3lvM9ti4Hd1CylECv0IzEA3XRXzYurZzZq5MuK37CPHeqx7d1/2E
 JB6zgFBPJuke2P01XhZyoIiDffdKW8MNIJvdmoX7uCZPJ4i3yqjj4sIJdT2ObDPPHAyAQ9z3A6h
 oOUhqiiEETZ7OwA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

When registering a power-supply device, either a of_node or the more
recent fwnode can be supplied. Since fwnode can also contain an of_node,
let's try to get rid of it.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/ab8500_charger.c       | 4 ++--
 drivers/power/supply/acer_a500_battery.c    | 3 ++-
 drivers/power/supply/act8945a_charger.c     | 2 +-
 drivers/power/supply/axp20x_ac_power.c      | 2 +-
 drivers/power/supply/axp20x_battery.c       | 2 +-
 drivers/power/supply/axp20x_usb_power.c     | 2 +-
 drivers/power/supply/bd99954-charger.c      | 2 +-
 drivers/power/supply/bq2415x_charger.c      | 2 +-
 drivers/power/supply/bq24190_charger.c      | 2 +-
 drivers/power/supply/bq24735-charger.c      | 2 +-
 drivers/power/supply/bq2515x_charger.c      | 2 +-
 drivers/power/supply/bq256xx_charger.c      | 2 +-
 drivers/power/supply/bq25980_charger.c      | 2 +-
 drivers/power/supply/bq27xxx_battery.c      | 2 +-
 drivers/power/supply/cpcap-battery.c        | 2 +-
 drivers/power/supply/cpcap-charger.c        | 2 +-
 drivers/power/supply/ds2760_battery.c       | 3 +--
 drivers/power/supply/generic-adc-battery.c  | 2 +-
 drivers/power/supply/gpio-charger.c         | 2 +-
 drivers/power/supply/ingenic-battery.c      | 2 +-
 drivers/power/supply/ip5xxx_power.c         | 2 +-
 drivers/power/supply/lego_ev3_battery.c     | 3 ++-
 drivers/power/supply/lt3651-charger.c       | 2 +-
 drivers/power/supply/ltc4162-l-charger.c    | 2 +-
 drivers/power/supply/max17042_battery.c     | 2 +-
 drivers/power/supply/max77650-charger.c     | 2 +-
 drivers/power/supply/max8903_charger.c      | 2 +-
 drivers/power/supply/mm8013.c               | 2 +-
 drivers/power/supply/mt6360_charger.c       | 2 +-
 drivers/power/supply/mt6370-charger.c       | 2 +-
 drivers/power/supply/olpc_battery.c         | 4 ++--
 drivers/power/supply/pm8916_bms_vm.c        | 2 +-
 drivers/power/supply/pm8916_lbc.c           | 2 +-
 drivers/power/supply/qcom_battmgr.c         | 5 +++--
 drivers/power/supply/qcom_pmi8998_charger.c | 2 +-
 drivers/power/supply/qcom_smbb.c            | 2 +-
 drivers/power/supply/rk817_charger.c        | 2 +-
 drivers/power/supply/rt5033_battery.c       | 2 +-
 drivers/power/supply/rt5033_charger.c       | 3 ++-
 drivers/power/supply/rt9455_charger.c       | 2 +-
 drivers/power/supply/rt9467-charger.c       | 2 +-
 drivers/power/supply/rt9471.c               | 2 +-
 drivers/power/supply/sbs-battery.c          | 2 +-
 drivers/power/supply/sbs-charger.c          | 2 +-
 drivers/power/supply/sbs-manager.c          | 2 +-
 drivers/power/supply/sc2731_charger.c       | 2 +-
 drivers/power/supply/sc27xx_fuel_gauge.c    | 3 +--
 drivers/power/supply/smb347-charger.c       | 2 +-
 drivers/power/supply/tps65090-charger.c     | 2 +-
 drivers/power/supply/tps65217_charger.c     | 2 +-
 drivers/power/supply/ucs1002_power.c        | 2 +-
 51 files changed, 58 insertions(+), 56 deletions(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 1042d37424f5b0351edd02b5c76e58dd447d1783..5f4537766e5b907d66b44964c320bc31acc7408b 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3494,11 +3494,11 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	di->invalid_charger_detect_state = 0;
 
 	/* AC and USB supply config */
-	ac_psy_cfg.of_node = np;
+	ac_psy_cfg.fwnode = dev_fwnode(dev);
 	ac_psy_cfg.supplied_to = supply_interface;
 	ac_psy_cfg.num_supplicants = ARRAY_SIZE(supply_interface);
 	ac_psy_cfg.drv_data = &di->ac_chg;
-	usb_psy_cfg.of_node = np;
+	usb_psy_cfg.fwnode = dev_fwnode(dev);
 	usb_psy_cfg.supplied_to = supply_interface;
 	usb_psy_cfg.num_supplicants = ARRAY_SIZE(supply_interface);
 	usb_psy_cfg.drv_data = &di->usb_chg;
diff --git a/drivers/power/supply/acer_a500_battery.c b/drivers/power/supply/acer_a500_battery.c
index 39d85b11a13c2350876da22ee5c427479d161351..daf01dc8025bb3d95a42b3bace2ffa8bca029263 100644
--- a/drivers/power/supply/acer_a500_battery.c
+++ b/drivers/power/supply/acer_a500_battery.c
@@ -17,6 +17,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
+#include <linux/property.h>
 
 enum {
 	REG_CAPACITY,
@@ -231,7 +232,7 @@ static int a500_battery_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, bat);
 
-	psy_cfg.of_node = pdev->dev.parent->of_node;
+	psy_cfg.fwnode = dev_fwnode(pdev->dev.parent);
 	psy_cfg.drv_data = bat;
 	psy_cfg.no_wakeup_source = true;
 
diff --git a/drivers/power/supply/act8945a_charger.c b/drivers/power/supply/act8945a_charger.c
index b2b82f97a471204e458bcdf85f68280638451a08..3901a02f326a55f820e85346ebe0420ac9a6f113 100644
--- a/drivers/power/supply/act8945a_charger.c
+++ b/drivers/power/supply/act8945a_charger.c
@@ -614,7 +614,7 @@ static int act8945a_charger_probe(struct platform_device *pdev)
 	if (ret)
 		return -EINVAL;
 
-	psy_cfg.of_node	= pdev->dev.of_node;
+	psy_cfg.fwnode	= dev_fwnode(&pdev->dev);
 	psy_cfg.drv_data = charger;
 
 	charger->psy = devm_power_supply_register(&pdev->dev,
diff --git a/drivers/power/supply/axp20x_ac_power.c b/drivers/power/supply/axp20x_ac_power.c
index e5733cb9e19e057f6c6d015b572530ca3d9c7e55..5f6ea416fa30a0328e6e1145cce3330b2fa63071 100644
--- a/drivers/power/supply/axp20x_ac_power.c
+++ b/drivers/power/supply/axp20x_ac_power.c
@@ -364,7 +364,7 @@ static int axp20x_ac_power_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, power);
 
-	psy_cfg.of_node = pdev->dev.of_node;
+	psy_cfg.fwnode = dev_fwnode(&pdev->dev);
 	psy_cfg.drv_data = power;
 
 	power->supply = devm_power_supply_register(&pdev->dev,
diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index fa27195f074e7d553a7d0bb095a62d6628ef5f8e..a8d6178963d04d0266a1b4aeb8b00e6d4bae1cb2 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -1091,7 +1091,7 @@ static int axp20x_power_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, axp20x_batt);
 
 	psy_cfg.drv_data = axp20x_batt;
-	psy_cfg.of_node = pdev->dev.of_node;
+	psy_cfg.fwnode = dev_fwnode(&pdev->dev);
 
 	axp20x_batt->data = (struct axp_data *)of_device_get_match_data(dev);
 
diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 9722912268fe8e33fa102f8998a96d7d4b041d2a..e6c5726108dc32b16fd3920e62a390ada1c5d0ad 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -1011,7 +1011,7 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	psy_cfg.of_node = pdev->dev.of_node;
+	psy_cfg.fwnode = dev_fwnode(&pdev->dev);
 	psy_cfg.drv_data = power;
 
 	power->supply = devm_power_supply_register(&pdev->dev,
diff --git a/drivers/power/supply/bd99954-charger.c b/drivers/power/supply/bd99954-charger.c
index 54bf882625101664fa15abd611aba0e82c073298..22453322456f744484be04b56de54ffe99f56096 100644
--- a/drivers/power/supply/bd99954-charger.c
+++ b/drivers/power/supply/bd99954-charger.c
@@ -982,7 +982,7 @@ static int bd9995x_probe(struct i2c_client *client)
 	bd->client = client;
 	bd->dev = dev;
 	psy_cfg.drv_data = bd;
-	psy_cfg.of_node = dev->of_node;
+	psy_cfg.fwnode = dev_fwnode(dev);
 
 	mutex_init(&bd->lock);
 
diff --git a/drivers/power/supply/bq2415x_charger.c b/drivers/power/supply/bq2415x_charger.c
index 22f6a3b71632b637e3c8023e6d187fc136cdff20..9e3b9181ee76a4f473228bba022917677acce256 100644
--- a/drivers/power/supply/bq2415x_charger.c
+++ b/drivers/power/supply/bq2415x_charger.c
@@ -1497,7 +1497,7 @@ static int bq2415x_power_supply_init(struct bq2415x_device *bq)
 	char revstr[8];
 	struct power_supply_config psy_cfg = {
 		.drv_data = bq,
-		.of_node = bq->dev->of_node,
+		.fwnode = dev_fwnode(bq->dev),
 		.attr_grp = bq2415x_sysfs_groups,
 	};
 
diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index b4ba01744368c2a338105a2735a481fe36dca169..f0d97ab45bd87f3baab20bb316eaebef77d99ae8 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -2117,7 +2117,7 @@ static int bq24190_probe(struct i2c_client *client)
 #endif
 
 	charger_cfg.drv_data = bdi;
-	charger_cfg.of_node = dev->of_node;
+	charger_cfg.fwnode = dev_fwnode(dev);
 	charger_cfg.supplied_to = bq24190_charger_supplied_to;
 	charger_cfg.num_supplicants = ARRAY_SIZE(bq24190_charger_supplied_to);
 	bdi->charger = power_supply_register(dev, &bq24190_charger_desc,
diff --git a/drivers/power/supply/bq24735-charger.c b/drivers/power/supply/bq24735-charger.c
index 73a7fc867b0344cd0305d3d4b29c0e85c361554f..637e0da65f8739f623420a25d079bfb152109bc7 100644
--- a/drivers/power/supply/bq24735-charger.c
+++ b/drivers/power/supply/bq24735-charger.c
@@ -402,7 +402,7 @@ static int bq24735_charger_probe(struct i2c_client *client)
 
 	psy_cfg.supplied_to = charger->pdata->supplied_to;
 	psy_cfg.num_supplicants = charger->pdata->num_supplicants;
-	psy_cfg.of_node = client->dev.of_node;
+	psy_cfg.fwnode = dev_fwnode(&client->dev);
 	psy_cfg.drv_data = charger;
 
 	i2c_set_clientdata(client, charger);
diff --git a/drivers/power/supply/bq2515x_charger.c b/drivers/power/supply/bq2515x_charger.c
index a3424f67f2b1d7b607903806291896eb68aba707..a238de10750ddfe71494f5eaad3eceffb8012671 100644
--- a/drivers/power/supply/bq2515x_charger.c
+++ b/drivers/power/supply/bq2515x_charger.c
@@ -1102,7 +1102,7 @@ static int bq2515x_probe(struct i2c_client *client)
 	i2c_set_clientdata(client, bq2515x);
 
 	charger_cfg.drv_data = bq2515x;
-	charger_cfg.of_node = dev->of_node;
+	charger_cfg.fwnode = dev_fwnode(dev);
 
 	ret = bq2515x_read_properties(bq2515x);
 	if (ret) {
diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/supply/bq256xx_charger.c
index 5514d1896bb847da6937e7c60fb540a51b46edd6..9f9b6019f8e13f986c39fbf170c622af0ac9fd37 100644
--- a/drivers/power/supply/bq256xx_charger.c
+++ b/drivers/power/supply/bq256xx_charger.c
@@ -1657,7 +1657,7 @@ static int bq256xx_parse_dt(struct bq256xx_device *bq,
 	int ret = 0;
 
 	psy_cfg->drv_data = bq;
-	psy_cfg->of_node = dev->of_node;
+	psy_cfg->fwnode = dev_fwnode(dev);
 
 	ret = device_property_read_u32(bq->dev, "ti,watchdog-timeout-ms",
 				       &bq->watchdog_timer);
diff --git a/drivers/power/supply/bq25980_charger.c b/drivers/power/supply/bq25980_charger.c
index 0c5e2938bb36d6b758ebd2759b41e285716349d8..af5f0d2ad54043d35da54e2b070f03ae7c61ff7a 100644
--- a/drivers/power/supply/bq25980_charger.c
+++ b/drivers/power/supply/bq25980_charger.c
@@ -1057,7 +1057,7 @@ static int bq25980_power_supply_init(struct bq25980_device *bq,
 							struct device *dev)
 {
 	struct power_supply_config psy_cfg = { .drv_data = bq,
-						.of_node = dev->of_node, };
+						.fwnode = dev_fwnode(dev), };
 
 	psy_cfg.supplied_to = bq25980_charger_supplied_to;
 	psy_cfg.num_supplicants = ARRAY_SIZE(bq25980_charger_supplied_to);
diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 90a5bccfc6b9bc37403eadd31e5ad98bd16204de..9bf66da1e49e775726c6127628d23274b95c3f21 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -2199,7 +2199,7 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 {
 	struct power_supply_desc *psy_desc;
 	struct power_supply_config psy_cfg = {
-		.of_node = di->dev->of_node,
+		.fwnode = dev_fwnode(di->dev),
 		.drv_data = di,
 		.no_wakeup_source = true,
 	};
diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 813037c00ded567e6acdff4f202b7c8d6de80dfd..8106d1edcbc26a738874d16e6bf3ce0547a38143 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -1130,7 +1130,7 @@ static int cpcap_battery_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
-	psy_cfg.of_node = pdev->dev.of_node;
+	psy_cfg.fwnode = dev_fwnode(&pdev->dev);
 	psy_cfg.drv_data = ddata;
 
 	ddata->psy = devm_power_supply_register(ddata->dev,
diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
index 6625d539d9ae76e63cf6539f7fade727956c39b5..13300dc60baf9b8ba143c784fc2a1d1badf64fc6 100644
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -902,7 +902,7 @@ static int cpcap_charger_probe(struct platform_device *pdev)
 
 	atomic_set(&ddata->active, 1);
 
-	psy_cfg.of_node = pdev->dev.of_node;
+	psy_cfg.fwnode = dev_fwnode(&pdev->dev);
 	psy_cfg.drv_data = ddata;
 	psy_cfg.supplied_to = cpcap_charger_supplied_to;
 	psy_cfg.num_supplicants = ARRAY_SIZE(cpcap_charger_supplied_to);
diff --git a/drivers/power/supply/ds2760_battery.c b/drivers/power/supply/ds2760_battery.c
index 83bdec5a2bda901460e0a8618949baa7ecc11e46..bf933f8d052c566de6a57330e6adf8bd97caea2f 100644
--- a/drivers/power/supply/ds2760_battery.c
+++ b/drivers/power/supply/ds2760_battery.c
@@ -697,12 +697,11 @@ static int w1_ds2760_add_slave(struct w1_slave *sl)
 				  ds2760_battery_external_power_changed;
 
 	psy_cfg.drv_data = di;
+	psy_cfg.fwnode = dev_fwnode(dev);
 
 	if (dev->of_node) {
 		u32 tmp;
 
-		psy_cfg.of_node = dev->of_node;
-
 		if (!of_property_read_bool(dev->of_node, "maxim,pmod-enabled"))
 			pmod_enabled = true;
 
diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index d5d215f5ad8b1684ea6272a82d614338a7bf19a9..f5f2566b3a32d59e3f873b6efc781f4701819545 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -166,7 +166,7 @@ static int gab_probe(struct platform_device *pdev)
 	if (!adc_bat)
 		return -ENOMEM;
 
-	psy_cfg.of_node = pdev->dev.of_node;
+	psy_cfg.fwnode = dev_fwnode(&pdev->dev);
 	psy_cfg.drv_data = adc_bat;
 	psy_desc = &adc_bat->psy_desc;
 	psy_desc->name = dev_name(&pdev->dev);
diff --git a/drivers/power/supply/gpio-charger.c b/drivers/power/supply/gpio-charger.c
index 46d18ce6a7392b95e44cbf459566661e7f7cb0f3..1dfd5b0cb30d8e30897ed19013b79cb9dfddaeeb 100644
--- a/drivers/power/supply/gpio-charger.c
+++ b/drivers/power/supply/gpio-charger.c
@@ -333,7 +333,7 @@ static int gpio_charger_probe(struct platform_device *pdev)
 	charger_desc->property_is_writeable =
 					gpio_charger_property_is_writeable;
 
-	psy_cfg.of_node = dev->of_node;
+	psy_cfg.fwnode = dev_fwnode(dev);
 	psy_cfg.drv_data = gpio_charger;
 
 	if (pdata) {
diff --git a/drivers/power/supply/ingenic-battery.c b/drivers/power/supply/ingenic-battery.c
index 0a40f425c27723ccec49985b8b5e14a737b6a7eb..b111c7ce2be30b8110c3d34f4b8b2faf9ab99969 100644
--- a/drivers/power/supply/ingenic-battery.c
+++ b/drivers/power/supply/ingenic-battery.c
@@ -146,7 +146,7 @@ static int ingenic_battery_probe(struct platform_device *pdev)
 	desc->num_properties = ARRAY_SIZE(ingenic_battery_properties);
 	desc->get_property = ingenic_battery_get_property;
 	psy_cfg.drv_data = bat;
-	psy_cfg.of_node = dev->of_node;
+	psy_cfg.fwnode = dev_fwnode(dev);
 
 	bat->battery = devm_power_supply_register(dev, desc, &psy_cfg);
 	if (IS_ERR(bat->battery))
diff --git a/drivers/power/supply/ip5xxx_power.c b/drivers/power/supply/ip5xxx_power.c
index c448e0ac0dfac2fff6e43d3bcb427189391bc36e..a031eadb49ddce66f45c30edc2cb546985ca503e 100644
--- a/drivers/power/supply/ip5xxx_power.c
+++ b/drivers/power/supply/ip5xxx_power.c
@@ -848,7 +848,7 @@ static int ip5xxx_power_probe(struct i2c_client *client)
 		fields = (const struct ip5xxx_regfield_config *)of_id->data;
 	ip5xxx_setup_regs(dev, ip5xxx, fields);
 
-	psy_cfg.of_node = dev->of_node;
+	psy_cfg.fwnode = dev_fwnode(dev);
 	psy_cfg.drv_data = ip5xxx;
 
 	psy = devm_power_supply_register(dev, &ip5xxx_battery_desc, &psy_cfg);
diff --git a/drivers/power/supply/lego_ev3_battery.c b/drivers/power/supply/lego_ev3_battery.c
index 9085de0ae1b2c6350604177ee8f5eab30d571f01..28454de057612a945c7926e4ee089aeeff9e1a49 100644
--- a/drivers/power/supply/lego_ev3_battery.c
+++ b/drivers/power/supply/lego_ev3_battery.c
@@ -23,6 +23,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
+#include <linux/property.h>
 
 struct lego_ev3_battery {
 	struct iio_channel *iio_v;
@@ -198,7 +199,7 @@ static int lego_ev3_battery_probe(struct platform_device *pdev)
 		batt->v_min = 48000000;
 	}
 
-	psy_cfg.of_node = pdev->dev.of_node;
+	psy_cfg.fwnode = dev_fwnode(&pdev->dev);
 	psy_cfg.drv_data = batt;
 
 	batt->psy = devm_power_supply_register(dev, &lego_ev3_battery_desc,
diff --git a/drivers/power/supply/lt3651-charger.c b/drivers/power/supply/lt3651-charger.c
index 8de500ffad95a5b0e7460155e186e5eeee206d96..ebfbdbcb7683216f01c37a2c39c1b30e22b00b53 100644
--- a/drivers/power/supply/lt3651-charger.c
+++ b/drivers/power/supply/lt3651-charger.c
@@ -131,7 +131,7 @@ static int lt3651_charger_probe(struct platform_device *pdev)
 	charger_desc->properties = lt3651_charger_properties;
 	charger_desc->num_properties = ARRAY_SIZE(lt3651_charger_properties);
 	charger_desc->get_property = lt3651_charger_get_property;
-	psy_cfg.of_node = pdev->dev.of_node;
+	psy_cfg.fwnode = dev_fwnode(&pdev->dev);
 	psy_cfg.drv_data = lt3651_charger;
 
 	lt3651_charger->charger = devm_power_supply_register(&pdev->dev,
diff --git a/drivers/power/supply/ltc4162-l-charger.c b/drivers/power/supply/ltc4162-l-charger.c
index 23eb426295dbbb4ffd3f69dbe47f51df5136497b..e276668b803d2ee2436b9d7eeb50afd4de97a72f 100644
--- a/drivers/power/supply/ltc4162-l-charger.c
+++ b/drivers/power/supply/ltc4162-l-charger.c
@@ -1185,7 +1185,7 @@ static int ltc4162l_probe(struct i2c_client *client)
 	if (!device_property_read_u32(dev, "lltc,cell-count", &value))
 		info->cell_count = value;
 
-	ltc4162l_config.of_node = dev->of_node;
+	ltc4162l_config.fwnode = dev_fwnode(dev);
 	ltc4162l_config.drv_data = info;
 	ltc4162l_config.attr_grp = ltc4162l_attr_groups;
 
diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 655b3f25dbd7ca78f530aee3663cbe241722c3cf..acea176101fa88ff2e5a9187be17575c8278d097 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -1066,7 +1066,7 @@ static int max17042_probe(struct i2c_client *client, struct device *dev, int irq
 
 	dev_set_drvdata(dev, chip);
 	psy_cfg.drv_data = chip;
-	psy_cfg.of_node = dev->of_node;
+	psy_cfg.fwnode = dev_fwnode(dev);
 
 	/* When current is not measured,
 	 * CURRENT_NOW and CURRENT_AVG properties should be invisible. */
diff --git a/drivers/power/supply/max77650-charger.c b/drivers/power/supply/max77650-charger.c
index 5f58c0c24b4d63bad410ea086c6ccf6b2a6fcf15..4ae43668992ecda319966ffd09734986187cd653 100644
--- a/drivers/power/supply/max77650-charger.c
+++ b/drivers/power/supply/max77650-charger.c
@@ -298,7 +298,7 @@ static int max77650_charger_probe(struct platform_device *pdev)
 
 	chg->dev = dev;
 
-	pscfg.of_node = dev->of_node;
+	pscfg.fwnode = dev_fwnode(dev);
 	pscfg.drv_data = chg;
 
 	chg_irq = platform_get_irq_byname(pdev, "CHG");
diff --git a/drivers/power/supply/max8903_charger.c b/drivers/power/supply/max8903_charger.c
index e65d0141f260b1094393f6ecd26e810da4329bce..45fbaad6c6470ad51c6a9d2fefb3d7d1f4f2f4b3 100644
--- a/drivers/power/supply/max8903_charger.c
+++ b/drivers/power/supply/max8903_charger.c
@@ -349,7 +349,7 @@ static int max8903_probe(struct platform_device *pdev)
 	data->psy_desc.properties = max8903_charger_props;
 	data->psy_desc.num_properties = ARRAY_SIZE(max8903_charger_props);
 
-	psy_cfg.of_node = dev->of_node;
+	psy_cfg.fwnode = dev_fwnode(dev);
 	psy_cfg.drv_data = data;
 
 	data->psy = devm_power_supply_register(dev, &data->psy_desc, &psy_cfg);
diff --git a/drivers/power/supply/mm8013.c b/drivers/power/supply/mm8013.c
index 4adf2acc2779366323e52c467cff4f99ebb9d6ea..93c50cff31bca3b7d526d67b22ee1f64e3f29add 100644
--- a/drivers/power/supply/mm8013.c
+++ b/drivers/power/supply/mm8013.c
@@ -274,7 +274,7 @@ static int mm8013_probe(struct i2c_client *client)
 		return dev_err_probe(dev, ret, "MM8013 not found\n");
 
 	psy_cfg.drv_data = chip;
-	psy_cfg.of_node = dev->of_node;
+	psy_cfg.fwnode = dev_fwnode(dev);
 
 	psy = devm_power_supply_register(dev, &mm8013_desc, &psy_cfg);
 	if (IS_ERR(psy))
diff --git a/drivers/power/supply/mt6360_charger.c b/drivers/power/supply/mt6360_charger.c
index e99e551489761aa3b70ef33f8b65d59a8e117166..77747eb51667230008e2318543e6cdf0aab3664a 100644
--- a/drivers/power/supply/mt6360_charger.c
+++ b/drivers/power/supply/mt6360_charger.c
@@ -810,7 +810,7 @@ static int mt6360_charger_probe(struct platform_device *pdev)
 	memcpy(&mci->psy_desc, &mt6360_charger_desc, sizeof(mci->psy_desc));
 	mci->psy_desc.name = dev_name(&pdev->dev);
 	charger_cfg.drv_data = mci;
-	charger_cfg.of_node = pdev->dev.of_node;
+	charger_cfg.fwnode = dev_fwnode(&pdev->dev);
 	mci->psy = devm_power_supply_register(&pdev->dev,
 					      &mci->psy_desc, &charger_cfg);
 	if (IS_ERR(mci->psy))
diff --git a/drivers/power/supply/mt6370-charger.c b/drivers/power/supply/mt6370-charger.c
index ad8793bf997e15a7d6a6bca96e538e6056bb3153..a6939c6059c7fd0da08087d87fdaf2244914d222 100644
--- a/drivers/power/supply/mt6370-charger.c
+++ b/drivers/power/supply/mt6370-charger.c
@@ -752,7 +752,7 @@ static int mt6370_chg_init_psy(struct mt6370_priv *priv)
 {
 	struct power_supply_config cfg = {
 		.drv_data = priv,
-		.of_node = dev_of_node(priv->dev),
+		.fwnode = dev_fwnode(priv->dev),
 	};
 
 	priv->psy = devm_power_supply_register(priv->dev, &mt6370_chg_psy_desc,
diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c
index 849f63e89ba09047bba30813723512780b9cdeb0..b9b6078226763459ad805db266d6e52d6de057ee 100644
--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -674,7 +674,7 @@ static int olpc_battery_probe(struct platform_device *pdev)
 
 	/* Ignore the status. It doesn't actually matter */
 
-	ac_psy_cfg.of_node = pdev->dev.of_node;
+	ac_psy_cfg.fwnode = dev_fwnode(&pdev->dev);
 	ac_psy_cfg.drv_data = data;
 
 	data->olpc_ac = devm_power_supply_register(&pdev->dev, &olpc_ac_desc,
@@ -692,7 +692,7 @@ static int olpc_battery_probe(struct platform_device *pdev)
 		olpc_bat_desc.num_properties = ARRAY_SIZE(olpc_xo1_bat_props);
 	}
 
-	bat_psy_cfg.of_node = pdev->dev.of_node;
+	bat_psy_cfg.fwnode = dev_fwnode(&pdev->dev);
 	bat_psy_cfg.drv_data = data;
 	bat_psy_cfg.attr_grp = olpc_bat_sysfs_groups;
 
diff --git a/drivers/power/supply/pm8916_bms_vm.c b/drivers/power/supply/pm8916_bms_vm.c
index 5d0dd842509c4b90853b23266a30c6cae172fc53..5120be086e6ffc6bb86f297a67192b29e2162d43 100644
--- a/drivers/power/supply/pm8916_bms_vm.c
+++ b/drivers/power/supply/pm8916_bms_vm.c
@@ -210,7 +210,7 @@ static int pm8916_bms_vm_battery_probe(struct platform_device *pdev)
 	bat->vbat_now = bat->last_ocv;
 
 	psy_cfg.drv_data = bat;
-	psy_cfg.of_node = dev->of_node;
+	psy_cfg.fwnode = dev_fwnode(dev);
 
 	bat->battery = devm_power_supply_register(dev, &pm8916_bms_vm_battery_psy_desc, &psy_cfg);
 	if (IS_ERR(bat->battery))
diff --git a/drivers/power/supply/pm8916_lbc.c b/drivers/power/supply/pm8916_lbc.c
index 6d92e98cbecc682768bf8c6048735b4687088186..c74b75b1b2676c3dfbb782dad048c8356cc0e951 100644
--- a/drivers/power/supply/pm8916_lbc.c
+++ b/drivers/power/supply/pm8916_lbc.c
@@ -322,7 +322,7 @@ static int pm8916_lbc_charger_probe(struct platform_device *pdev)
 		dev_err_probe(dev, ret, "Error while parsing device tree\n");
 
 	psy_cfg.drv_data = chg;
-	psy_cfg.of_node = dev->of_node;
+	psy_cfg.fwnode = dev_fwnode(dev);
 
 	chg->charger = devm_power_supply_register(dev, &pm8916_lbc_charger_psy_desc, &psy_cfg);
 	if (IS_ERR(chg->charger))
diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 47d29271ddf400b76dd5b0a1b8d1ba86c017afc0..fe27676fbc7cd12292caa6fb3b5b46a18c426e6d 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -8,6 +8,7 @@
 #include <linux/mutex.h>
 #include <linux/of_device.h>
 #include <linux/power_supply.h>
+#include <linux/property.h>
 #include <linux/soc/qcom/pdr.h>
 #include <linux/soc/qcom/pmic_glink.h>
 #include <linux/math.h>
@@ -1336,10 +1337,10 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 	battmgr->dev = dev;
 
 	psy_cfg.drv_data = battmgr;
-	psy_cfg.of_node = adev->dev.of_node;
+	psy_cfg.fwnode = dev_fwnode(&adev->dev);
 
 	psy_cfg_supply.drv_data = battmgr;
-	psy_cfg_supply.of_node = adev->dev.of_node;
+	psy_cfg_supply.fwnode = dev_fwnode(&adev->dev);
 	psy_cfg_supply.supplied_to = qcom_battmgr_battery;
 	psy_cfg_supply.num_supplicants = 1;
 
diff --git a/drivers/power/supply/qcom_pmi8998_charger.c b/drivers/power/supply/qcom_pmi8998_charger.c
index 3b4132376649e088d14753de05982e8ea0d18371..74a8d8ed8d9fa305416b1e543ecf12846d557091 100644
--- a/drivers/power/supply/qcom_pmi8998_charger.c
+++ b/drivers/power/supply/qcom_pmi8998_charger.c
@@ -964,7 +964,7 @@ static int smb2_probe(struct platform_device *pdev)
 		return rc;
 
 	supply_config.drv_data = chip;
-	supply_config.of_node = pdev->dev.of_node;
+	supply_config.fwnode = dev_fwnode(&pdev->dev);
 
 	desc = devm_kzalloc(chip->dev, sizeof(smb2_psy_desc), GFP_KERNEL);
 	if (!desc)
diff --git a/drivers/power/supply/qcom_smbb.c b/drivers/power/supply/qcom_smbb.c
index a79563f6ff7a0c1b7d4aab85f6a42cc27fbb43ca..28afe758a2dabe31eaf753b907467a667ab42f61 100644
--- a/drivers/power/supply/qcom_smbb.c
+++ b/drivers/power/supply/qcom_smbb.c
@@ -880,7 +880,7 @@ static int smbb_charger_probe(struct platform_device *pdev)
 	}
 
 	bat_cfg.drv_data = chg;
-	bat_cfg.of_node = pdev->dev.of_node;
+	bat_cfg.fwnode = dev_fwnode(&pdev->dev);
 	chg->bat_psy = devm_power_supply_register(&pdev->dev,
 						  &bat_psy_desc,
 						  &bat_cfg);
diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index e5f35d083c23d5d86b3dca454f666383f828e524..945c7720c4ae905e2f0204cbef1534f7ec2a3a62 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -1088,7 +1088,7 @@ static int rk817_charger_probe(struct platform_device *pdev)
 	rk817_bat_calib_vol(charger);
 
 	pscfg.drv_data = charger;
-	pscfg.of_node = node;
+	pscfg.fwnode = node ? &node->fwnode : NULL;
 
 	/*
 	 * Get sample resistor value. Note only values of 10000 or 20000
diff --git a/drivers/power/supply/rt5033_battery.c b/drivers/power/supply/rt5033_battery.c
index 7a27b262fb84a73db82b12e97c2fb57162709e14..b2674adfa30b41475abae1d6973a37272dbcfb92 100644
--- a/drivers/power/supply/rt5033_battery.c
+++ b/drivers/power/supply/rt5033_battery.c
@@ -160,7 +160,7 @@ static int rt5033_battery_probe(struct i2c_client *client)
 	}
 
 	i2c_set_clientdata(client, battery);
-	psy_cfg.of_node = client->dev.of_node;
+	psy_cfg.fwnode = dev_fwnode(&client->dev);
 	psy_cfg.drv_data = battery;
 
 	battery->psy = devm_power_supply_register(&client->dev,
diff --git a/drivers/power/supply/rt5033_charger.c b/drivers/power/supply/rt5033_charger.c
index d19c7e80a92aa8f1f2f018e8e8d59ed0c58cc8a9..2fdc5843970754270754623ddf8abf758c69e2cf 100644
--- a/drivers/power/supply/rt5033_charger.c
+++ b/drivers/power/supply/rt5033_charger.c
@@ -16,6 +16,7 @@
 #include <linux/power_supply.h>
 #include <linux/regmap.h>
 #include <linux/mfd/rt5033-private.h>
+#include <linux/property.h>
 
 struct rt5033_charger_data {
 	unsigned int pre_uamp;
@@ -675,7 +676,7 @@ static int rt5033_charger_probe(struct platform_device *pdev)
 	charger->regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	mutex_init(&charger->lock);
 
-	psy_cfg.of_node = pdev->dev.of_node;
+	psy_cfg.fwnode = dev_fwnode(&pdev->dev);
 	psy_cfg.drv_data = charger;
 
 	charger->psy = devm_power_supply_register(charger->dev,
diff --git a/drivers/power/supply/rt9455_charger.c b/drivers/power/supply/rt9455_charger.c
index 64a23e3d7bb00f03a548a551d3fd523299fd00cd..4b714b4c3e2b596280f09901f68dbae9296d8605 100644
--- a/drivers/power/supply/rt9455_charger.c
+++ b/drivers/power/supply/rt9455_charger.c
@@ -1658,7 +1658,7 @@ static int rt9455_probe(struct i2c_client *client)
 	INIT_DEFERRABLE_WORK(&info->batt_presence_work,
 			     rt9455_batt_presence_work_callback);
 
-	rt9455_charger_config.of_node		= dev->of_node;
+	rt9455_charger_config.fwnode		= dev_fwnode(dev);
 	rt9455_charger_config.drv_data		= info;
 	rt9455_charger_config.supplied_to	= rt9455_charger_supplied_to;
 	rt9455_charger_config.num_supplicants	=
diff --git a/drivers/power/supply/rt9467-charger.c b/drivers/power/supply/rt9467-charger.c
index 235169c85c5d8a8014ff585b6740aaec3243a068..e9aba9ad393c9cec309c49e7fb21286f77555261 100644
--- a/drivers/power/supply/rt9467-charger.c
+++ b/drivers/power/supply/rt9467-charger.c
@@ -826,7 +826,7 @@ static int rt9467_register_psy(struct rt9467_chg_data *data)
 {
 	struct power_supply_config cfg = {
 		.drv_data = data,
-		.of_node = dev_of_node(data->dev),
+		.fwnode = dev_fwnode(data->dev),
 		.attr_grp = rt9467_sysfs_groups,
 	};
 
diff --git a/drivers/power/supply/rt9471.c b/drivers/power/supply/rt9471.c
index 67b86ac91a21ddc0e3d0271b5f535c47600bc101..bd966abb4df5767f6f0353d08ea0eac2c3972b5b 100644
--- a/drivers/power/supply/rt9471.c
+++ b/drivers/power/supply/rt9471.c
@@ -723,7 +723,7 @@ static int rt9471_register_psy(struct rt9471_chip *chip)
 	char *psy_name;
 
 	cfg.drv_data = chip;
-	cfg.of_node = dev->of_node;
+	cfg.fwnode = dev_fwnode(dev);
 	cfg.attr_grp = rt9471_sysfs_groups;
 
 	psy_name = devm_kasprintf(dev, GFP_KERNEL, "rt9471-%s", dev_name(dev));
diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 6f3d0413b1c127fc4c5a16728d71be8ae340d05d..943c82ee978f40abd2b1f2ecd4850cf3b41fd446 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -1138,7 +1138,7 @@ static int sbs_probe(struct i2c_client *client)
 
 	chip->flags = (uintptr_t)i2c_get_match_data(client);
 	chip->client = client;
-	psy_cfg.of_node = client->dev.of_node;
+	psy_cfg.fwnode = dev_fwnode(&client->dev);
 	psy_cfg.drv_data = chip;
 	chip->last_state = POWER_SUPPLY_STATUS_UNKNOWN;
 	sbs_invalidate_cached_props(chip);
diff --git a/drivers/power/supply/sbs-charger.c b/drivers/power/supply/sbs-charger.c
index ab3f095d90ea7c1c599aea61acce9138c37a269a..27764123b929e2357daf29676506531a6f3f7664 100644
--- a/drivers/power/supply/sbs-charger.c
+++ b/drivers/power/supply/sbs-charger.c
@@ -173,7 +173,7 @@ static int sbs_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	chip->client = client;
-	psy_cfg.of_node = client->dev.of_node;
+	psy_cfg.fwnode = dev_fwnode(&client->dev);
 	psy_cfg.drv_data = chip;
 
 	i2c_set_clientdata(client, chip);
diff --git a/drivers/power/supply/sbs-manager.c b/drivers/power/supply/sbs-manager.c
index 7d2f39f19acbf00d2d29850cd97063bb5f02eb3c..869729dfcd664c061dfff1bff30ab756748d73d4 100644
--- a/drivers/power/supply/sbs-manager.c
+++ b/drivers/power/supply/sbs-manager.c
@@ -379,7 +379,7 @@ static int sbsm_probe(struct i2c_client *client)
 		return ret;
 
 	psy_cfg.drv_data = data;
-	psy_cfg.of_node = dev->of_node;
+	psy_cfg.fwnode = dev_fwnode(dev);
 	data->psy = devm_power_supply_register(dev, psy_desc, &psy_cfg);
 	if (IS_ERR(data->psy))
 		return dev_err_probe(dev, PTR_ERR(data->psy),
diff --git a/drivers/power/supply/sc2731_charger.c b/drivers/power/supply/sc2731_charger.c
index 50d5157af9277dc09fe24852747f4f62e72bc712..58b86fd78771360f74ffdad152c3905e1bee7c1b 100644
--- a/drivers/power/supply/sc2731_charger.c
+++ b/drivers/power/supply/sc2731_charger.c
@@ -480,7 +480,7 @@ static int sc2731_charger_probe(struct platform_device *pdev)
 	}
 
 	charger_cfg.drv_data = info;
-	charger_cfg.of_node = np;
+	charger_cfg.fwnode = dev_fwnode(&pdev->dev);
 	info->psy_usb = devm_power_supply_register(&pdev->dev,
 						   &sc2731_charger_desc,
 						   &charger_cfg);
diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index f36edc2ba708748d0ceb61298056f8c905aca012..196d96cd986266738785d8582e907858faaf2ba3 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -1141,7 +1141,6 @@ static int sc27xx_fgu_hw_init(struct sc27xx_fgu_data *data)
 static int sc27xx_fgu_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
 	struct power_supply_config fgu_cfg = { };
 	struct sc27xx_fgu_data *data;
 	int ret, irq;
@@ -1205,7 +1204,7 @@ static int sc27xx_fgu_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, data);
 
 	fgu_cfg.drv_data = data;
-	fgu_cfg.of_node = np;
+	fgu_cfg.fwnode = dev_fwnode(dev);
 	data->battery = devm_power_supply_register(dev, &sc27xx_fgu_desc,
 						   &fgu_cfg);
 	if (IS_ERR(data->battery)) {
diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index c8392933ee285255438a78f5bbd9429f9f1c6764..893551dce7d2c9902df5a6141935661b342c00f9 100644
--- a/drivers/power/supply/smb347-charger.c
+++ b/drivers/power/supply/smb347-charger.c
@@ -1553,7 +1553,7 @@ static int smb347_probe(struct i2c_client *client)
 		return PTR_ERR(smb->regmap);
 
 	mains_usb_cfg.drv_data = smb;
-	mains_usb_cfg.of_node = dev->of_node;
+	mains_usb_cfg.fwnode = dev_fwnode(dev);
 	if (smb->use_mains) {
 		smb->mains = devm_power_supply_register(dev, &smb347_mains_desc,
 							&mains_usb_cfg);
diff --git a/drivers/power/supply/tps65090-charger.c b/drivers/power/supply/tps65090-charger.c
index d65193e410a6251e80e481ed6fc3d36128c5678c..d010f013af8cec790d135b651fbc6330c8907b0e 100644
--- a/drivers/power/supply/tps65090-charger.c
+++ b/drivers/power/supply/tps65090-charger.c
@@ -259,7 +259,7 @@ static int tps65090_charger_probe(struct platform_device *pdev)
 
 	psy_cfg.supplied_to		= pdata->supplied_to;
 	psy_cfg.num_supplicants		= pdata->num_supplicants;
-	psy_cfg.of_node			= pdev->dev.of_node;
+	psy_cfg.fwnode			= dev_fwnode(&pdev->dev);
 	psy_cfg.drv_data		= cdata;
 
 	cdata->ac = devm_power_supply_register(&pdev->dev, &tps65090_charger_desc,
diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supply/tps65217_charger.c
index 6fff44e1ecac80797fd33cdc3c10b0c23ce19c28..6af17ce0b2040bb3ba5835c6dc13b867f316141d 100644
--- a/drivers/power/supply/tps65217_charger.c
+++ b/drivers/power/supply/tps65217_charger.c
@@ -198,7 +198,7 @@ static int tps65217_charger_probe(struct platform_device *pdev)
 	charger->tps = tps;
 	charger->dev = &pdev->dev;
 
-	cfg.of_node = pdev->dev.of_node;
+	cfg.fwnode = dev_fwnode(&pdev->dev);
 	cfg.drv_data = charger;
 
 	charger->psy = devm_power_supply_register(&pdev->dev,
diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/ucs1002_power.c
index 7382bec6a43c776119bbcfd9070d6ca9629ab810..d32a7633f9e7d725cecf6659ed5b49c4fe2accd5 100644
--- a/drivers/power/supply/ucs1002_power.c
+++ b/drivers/power/supply/ucs1002_power.c
@@ -560,7 +560,7 @@ static int ucs1002_probe(struct i2c_client *client)
 	irq_a_det = of_irq_get_byname(dev->of_node, "a_det");
 	irq_alert = of_irq_get_byname(dev->of_node, "alert");
 
-	charger_config.of_node = dev->of_node;
+	charger_config.fwnode = dev_fwnode(dev);
 	charger_config.drv_data = info;
 
 	ret = regmap_read(info->regmap, UCS1002_REG_PRODUCT_ID, &regval);

-- 
2.47.2


