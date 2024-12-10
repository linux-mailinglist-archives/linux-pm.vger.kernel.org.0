Return-Path: <linux-pm+bounces-18958-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0389EBC36
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 22:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 237771662C8
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 21:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E4F23A59C;
	Tue, 10 Dec 2024 21:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="rFHanaGI"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819112397BD;
	Tue, 10 Dec 2024 21:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733867765; cv=none; b=UGBNEdCnP2ygE4FKG/LzYHJL48pS8Oi8UmyvWCcP9Y3k7pfFAgGQxzdLfO2fifvYFG/RJ0kfMWZvPo64IHc4mBfAm+hkgw168VhUho9013iL26/7Xz4UvIRkiwYlNwYNOs02zuza8NgOm5Q9d1seEX2HHg+1C8UyYhUMLfMAE4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733867765; c=relaxed/simple;
	bh=YkNrJgESTFAyTUd0+T8p/6aBvt4WlaBqGr2px019fMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ScHG1x5GQKZZYHMfrSwkfcgFjAnMtT/3SGLSz5N/In68b4neRzGmLSmBHteYtJVZcMJ8zzxMWE8PoYyhFG1Pi3A9tfaBwEXzOsu+xhTEDKZcpm1yWqLIUwmmBf/BSdYM/1ClijRXTGpgnuVm/PubqmCwMF2dmG9hbGqhTCblbHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=rFHanaGI; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733867760;
	bh=YkNrJgESTFAyTUd0+T8p/6aBvt4WlaBqGr2px019fMM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rFHanaGIurt+CJIWmaEcOlBWzw72EFt6GPm/55eLKUs3wLC6Qj0q59623NQ8koT6U
	 pFao1N8NFl6Ev0TO7E0e3v7SnjCzF8Vq9e3nWq63vR3aNnLrBsfIQQs7MwrKRRyCZp
	 bf/bEkjOvKVECN+lm9z3G+X4O28beLYMzpLgoOPQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 10 Dec 2024 22:55:50 +0100
Subject: [PATCH v2 03/14] power: supply: core: use
 power_supply_for_each_psy()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241210-power-supply-dev_to_psy-v2-3-9d8c9d24cfe4@weissschuh.net>
References: <20241210-power-supply-dev_to_psy-v2-0-9d8c9d24cfe4@weissschuh.net>
In-Reply-To: <20241210-power-supply-dev_to_psy-v2-0-9d8c9d24cfe4@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733867760; l=6259;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=YkNrJgESTFAyTUd0+T8p/6aBvt4WlaBqGr2px019fMM=;
 b=1neJt9ePv378obVWBm/dOHIgWAKwhJt95BEf/gwXMTpENVvfZmOtOAOR+n9Lq96NFJTMSxp2Y
 U+yeHAdNv7WD2wPZK47qafwNhARVb8rhvgdB7vfzeWukT9QNSutmsGh
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Simplify the callbacks by removing the need to convert a 'struct device'
into a 'struct power_supply'.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/power_supply_core.c | 36 +++++++++++++-------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 48bc968ff6c54d4b196c3faf450ef6464cdb305d..9adea87c69124f7025a06fe7550892392e28cd65 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -66,10 +66,9 @@ static bool __power_supply_is_supplied_by(struct power_supply *supplier,
 	return false;
 }
 
-static int __power_supply_changed_work(struct device *dev, void *data)
+static int __power_supply_changed_work(struct power_supply *pst, void *data)
 {
 	struct power_supply *psy = data;
-	struct power_supply *pst = dev_get_drvdata(dev);
 
 	if (__power_supply_is_supplied_by(psy, pst)) {
 		if (pst->desc->external_power_changed)
@@ -98,7 +97,7 @@ static void power_supply_changed_work(struct work_struct *work)
 	if (likely(psy->changed)) {
 		psy->changed = false;
 		spin_unlock_irqrestore(&psy->changed_lock, flags);
-		power_supply_for_each_device(psy, __power_supply_changed_work);
+		power_supply_for_each_psy(psy, __power_supply_changed_work);
 		power_supply_update_leds(psy);
 		blocking_notifier_call_chain(&power_supply_notifier,
 				PSY_EVENT_PROP_CHANGED, psy);
@@ -190,11 +189,10 @@ static void power_supply_deferred_register_work(struct work_struct *work)
 }
 
 #ifdef CONFIG_OF
-static int __power_supply_populate_supplied_from(struct device *dev,
+static int __power_supply_populate_supplied_from(struct power_supply *epsy,
 						 void *data)
 {
 	struct power_supply *psy = data;
-	struct power_supply *epsy = dev_get_drvdata(dev);
 	struct device_node *np;
 	int i = 0;
 
@@ -221,20 +219,19 @@ static int power_supply_populate_supplied_from(struct power_supply *psy)
 {
 	int error;
 
-	error = power_supply_for_each_device(psy, __power_supply_populate_supplied_from);
+	error = power_supply_for_each_psy(psy, __power_supply_populate_supplied_from);
 
 	dev_dbg(&psy->dev, "%s %d\n", __func__, error);
 
 	return error;
 }
 
-static int  __power_supply_find_supply_from_node(struct device *dev,
+static int  __power_supply_find_supply_from_node(struct power_supply *epsy,
 						 void *data)
 {
 	struct device_node *np = data;
-	struct power_supply *epsy = dev_get_drvdata(dev);
 
-	/* returning non-zero breaks out of power_supply_for_each_device loop */
+	/* returning non-zero breaks out of power_supply_for_each_psy loop */
 	if (epsy->of_node == np)
 		return 1;
 
@@ -246,16 +243,16 @@ static int power_supply_find_supply_from_node(struct device_node *supply_node)
 	int error;
 
 	/*
-	 * power_supply_for_each_device() either returns its own errors or values
+	 * power_supply_for_each_psy() either returns its own errors or values
 	 * returned by __power_supply_find_supply_from_node().
 	 *
 	 * __power_supply_find_supply_from_node() will return 0 (no match)
 	 * or 1 (match).
 	 *
-	 * We return 0 if power_supply_for_each_device() returned 1, -EPROBE_DEFER if
+	 * We return 0 if power_supply_for_each_psy() returned 1, -EPROBE_DEFER if
 	 * it returned 0, or error as returned by it.
 	 */
-	error = power_supply_for_each_device(supply_node, __power_supply_find_supply_from_node);
+	error = power_supply_for_each_psy(supply_node, __power_supply_find_supply_from_node);
 
 	return error ? (error == 1 ? 0 : error) : -EPROBE_DEFER;
 }
@@ -340,10 +337,9 @@ struct psy_am_i_supplied_data {
 	unsigned int count;
 };
 
-static int __power_supply_am_i_supplied(struct device *dev, void *_data)
+static int __power_supply_am_i_supplied(struct power_supply *epsy, void *_data)
 {
 	union power_supply_propval ret = {0,};
-	struct power_supply *epsy = dev_get_drvdata(dev);
 	struct psy_am_i_supplied_data *data = _data;
 
 	if (__power_supply_is_supplied_by(epsy, data->psy)) {
@@ -361,7 +357,7 @@ int power_supply_am_i_supplied(struct power_supply *psy)
 	struct psy_am_i_supplied_data data = { psy, 0 };
 	int error;
 
-	error = power_supply_for_each_device(&data, __power_supply_am_i_supplied);
+	error = power_supply_for_each_psy(&data, __power_supply_am_i_supplied);
 
 	dev_dbg(&psy->dev, "%s count %u err %d\n", __func__, data.count, error);
 
@@ -372,10 +368,9 @@ int power_supply_am_i_supplied(struct power_supply *psy)
 }
 EXPORT_SYMBOL_GPL(power_supply_am_i_supplied);
 
-static int __power_supply_is_system_supplied(struct device *dev, void *data)
+static int __power_supply_is_system_supplied(struct power_supply *psy, void *data)
 {
 	union power_supply_propval ret = {0,};
-	struct power_supply *psy = dev_get_drvdata(dev);
 	unsigned int *count = data;
 
 	if (!psy->desc->get_property(psy, POWER_SUPPLY_PROP_SCOPE, &ret))
@@ -396,7 +391,7 @@ int power_supply_is_system_supplied(void)
 	int error;
 	unsigned int count = 0;
 
-	error = power_supply_for_each_device(&count, __power_supply_is_system_supplied);
+	error = power_supply_for_each_psy(&count, __power_supply_is_system_supplied);
 
 	/*
 	 * If no system scope power class device was found at all, most probably we
@@ -415,9 +410,8 @@ struct psy_get_supplier_prop_data {
 	union power_supply_propval *val;
 };
 
-static int __power_supply_get_supplier_property(struct device *dev, void *_data)
+static int __power_supply_get_supplier_property(struct power_supply *epsy, void *_data)
 {
-	struct power_supply *epsy = dev_get_drvdata(dev);
 	struct psy_get_supplier_prop_data *data = _data;
 
 	if (__power_supply_is_supplied_by(epsy, data->psy))
@@ -442,7 +436,7 @@ int power_supply_get_property_from_supplier(struct power_supply *psy,
 	 * This function is not intended for use with a supply with multiple
 	 * suppliers, we simply pick the first supply to report the psp.
 	 */
-	ret = power_supply_for_each_device(&data, __power_supply_get_supplier_property);
+	ret = power_supply_for_each_psy(&data, __power_supply_get_supplier_property);
 	if (ret < 0)
 		return ret;
 	if (ret == 0)

-- 
2.47.1


