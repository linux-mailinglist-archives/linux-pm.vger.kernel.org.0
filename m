Return-Path: <linux-pm+bounces-34173-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA33DB49A11
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 21:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5867516968C
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 19:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D20F2BDC29;
	Mon,  8 Sep 2025 19:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="LryKiUWU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DAF27CCE2;
	Mon,  8 Sep 2025 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757360143; cv=none; b=OwvOG8sxUdYYzQsLpxVSY/KehLlxmi8v4u2zJiiHHKjtCxSE4Q9J/7zleni4y82xri/MTg11U0xlYRrsXIlJztoUIbtz1ajx/TPthDKMQALJneeCg9TEWRUALX8RhM1sQcky2rM4sj8CE3tZVByYkbu+5g+pAhxi4owzwoaNrOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757360143; c=relaxed/simple;
	bh=BdBtLSAXUbhcHZCCftjD1R+XqGR7NQqzDSCCgaLUUC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KWrB1lH7CWL//OKvUn7WH2+LUle4JUTQHmZPyA7zgOHSTkqcg4Rjxb/JQG8QFqnDumlxKxXnCubJa1nfyLsNM5XtivQSRJLo+FphLYncYU9yHwv2nuBi/IggMXZC4EoqUlM98qhkNxh4sRvYMyvaBROJuUioAriBeiSiQiz97GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=LryKiUWU; arc=none smtp.client-ip=80.12.242.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id vheKuw2Wg7bJuvheKuxkoM; Mon, 08 Sep 2025 21:35:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1757360138;
	bh=VmMr4DiQk13+WbxtEeLoRxU+Jze2KM7vVTaw1bCs+JM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=LryKiUWUI1H5rN2k9Z6sGg9MNDPsCBWW35ITaWIBRpXAlCPlPB3HdvZrABgyfuJ27
	 FRoy5AiJ/32gkNNeH1NP1qIpvPzYcJjX+bkJ4udFxsacZAsF0SZPMYY1fhr8d7TEeB
	 2AposBSNxQOfuYY3mKrnHUrJ3Zc7WsvPVRn+vAU5olus/QtSAGsL6F6cd9QW0pXyDK
	 ezSBhw45hQ60nu9lVZ9UCWNJ67a38WLR3RxV5k/E1+NdrVobM54qf4pmKAiqP7L8Vl
	 8oG3P3R+HfdRS7M/8Mtc/cet9qLwqtuOudPSecwwNXP2cJDV170lWGd5CpQnX9AP9m
	 q6wSI4/emrXTA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 08 Sep 2025 21:35:38 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] power: supply: Use devm_mutex_init()
Date: Mon,  8 Sep 2025 21:35:28 +0200
Message-ID: <2280ca741ef36fe9ed26b8079b91a8e5dfd669fc.1757360105.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_mutex_init() instead of hand-writing it.

This saves some LoC, improves readability and saves some space in the
generated .o file.

As an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  35803	   9352	    384	  45539	   b1e3	drivers/power/supply/rt9467-charger.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  34792	   9008	    384	  44184	   ac98	drivers/power/supply/rt9467-charger.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/power/supply/bq27xxx_battery.c | 11 +--------
 drivers/power/supply/mt6370-charger.c  | 11 +--------
 drivers/power/supply/rt9467-charger.c  | 33 +++-----------------------
 3 files changed, 5 insertions(+), 50 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index ad2d9ecf32a5..bc36fa9f0dd0 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -2224,13 +2224,6 @@ static void bq27xxx_external_power_changed(struct power_supply *psy)
 	mod_delayed_work(system_wq, &di->work, HZ / 2);
 }
 
-static void bq27xxx_battery_mutex_destroy(void *data)
-{
-	struct mutex *lock = data;
-
-	mutex_destroy(lock);
-}
-
 int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 {
 	struct power_supply_desc *psy_desc;
@@ -2242,9 +2235,7 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 	int ret;
 
 	INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
-	mutex_init(&di->lock);
-	ret = devm_add_action_or_reset(di->dev, bq27xxx_battery_mutex_destroy,
-				       &di->lock);
+	ret = devm_mutex_init(di->dev, &di->lock);
 	if (ret)
 		return ret;
 
diff --git a/drivers/power/supply/mt6370-charger.c b/drivers/power/supply/mt6370-charger.c
index eb3bcf81f741..e6db961d5818 100644
--- a/drivers/power/supply/mt6370-charger.c
+++ b/drivers/power/supply/mt6370-charger.c
@@ -761,13 +761,6 @@ static int mt6370_chg_init_psy(struct mt6370_priv *priv)
 	return PTR_ERR_OR_ZERO(priv->psy);
 }
 
-static void mt6370_chg_destroy_attach_lock(void *data)
-{
-	struct mutex *attach_lock = data;
-
-	mutex_destroy(attach_lock);
-}
-
 static void mt6370_chg_destroy_wq(void *data)
 {
 	struct workqueue_struct *wq = data;
@@ -894,9 +887,7 @@ static int mt6370_chg_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to init psy\n");
 
-	mutex_init(&priv->attach_lock);
-	ret = devm_add_action_or_reset(dev, mt6370_chg_destroy_attach_lock,
-				       &priv->attach_lock);
+	ret = devm_mutex_init(dev, &priv->attach_lock);
 	if (ret)
 		return ret;
 
diff --git a/drivers/power/supply/rt9467-charger.c b/drivers/power/supply/rt9467-charger.c
index 32e7c7620b91..fe773dd8b404 100644
--- a/drivers/power/supply/rt9467-charger.c
+++ b/drivers/power/supply/rt9467-charger.c
@@ -1147,27 +1147,6 @@ static int rt9467_reset_chip(struct rt9467_chg_data *data)
 	return regmap_field_write(data->rm_field[F_RST], 1);
 }
 
-static void rt9467_chg_destroy_adc_lock(void *data)
-{
-	struct mutex *adc_lock = data;
-
-	mutex_destroy(adc_lock);
-}
-
-static void rt9467_chg_destroy_attach_lock(void *data)
-{
-	struct mutex *attach_lock = data;
-
-	mutex_destroy(attach_lock);
-}
-
-static void rt9467_chg_destroy_ichg_ieoc_lock(void *data)
-{
-	struct mutex *ichg_ieoc_lock = data;
-
-	mutex_destroy(ichg_ieoc_lock);
-}
-
 static void rt9467_chg_complete_aicl_done(void *data)
 {
 	struct completion *aicl_done = data;
@@ -1220,21 +1199,15 @@ static int rt9467_charger_probe(struct i2c_client *i2c)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to add irq chip\n");
 
-	mutex_init(&data->adc_lock);
-	ret = devm_add_action_or_reset(dev, rt9467_chg_destroy_adc_lock,
-				       &data->adc_lock);
+	ret = devm_mutex_init(dev, &data->adc_lock);
 	if (ret)
 		return ret;
 
-	mutex_init(&data->attach_lock);
-	ret = devm_add_action_or_reset(dev, rt9467_chg_destroy_attach_lock,
-				       &data->attach_lock);
+	ret = devm_mutex_init(dev, &data->attach_lock);
 	if (ret)
 		return ret;
 
-	mutex_init(&data->ichg_ieoc_lock);
-	ret = devm_add_action_or_reset(dev, rt9467_chg_destroy_ichg_ieoc_lock,
-				       &data->ichg_ieoc_lock);
+	ret = devm_mutex_init(dev, &data->ichg_ieoc_lock);
 	if (ret)
 		return ret;
 
-- 
2.51.0


