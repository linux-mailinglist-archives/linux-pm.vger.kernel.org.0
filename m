Return-Path: <linux-pm+bounces-18957-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEF59EBC34
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 22:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C672166277
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 21:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6D723A58A;
	Tue, 10 Dec 2024 21:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="rfM4Jnur"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF4D2397BF;
	Tue, 10 Dec 2024 21:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733867765; cv=none; b=V/45DecniA29oLoHEm+QBCB1+kUMDNXoVMDv+L3II0Gk+fjzoZlGBGqwX2tjjTh3SelOScvNcCyar2bmiKFNRnhgNNorgJayo3VHEPWeolsb2Y0KoXe37iOCb2jtHcNDh6W08XZtjBPSUdRh4i/zXevbFJxD/aBtFE7Y+P1K6a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733867765; c=relaxed/simple;
	bh=mi0udZzZbeywpP/vrlSR3292aKI49L4o1M7uXA1k4Mk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J/pQpSMNEu6+n6tjI4cXBSxLPkuHzdx2WktSl58Rz1EQTEHVkvp4xswBkHoRxvUO130sF5B4+/ZLqVRQ6K+Oxz3zRvKCCfPrnU6OhG8gSpicH0UsNihc575yBq8gPY2ozk2JWted4BVzvBZXJyCKdiY0+yRs4EW9tYwZNvRToxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=rfM4Jnur; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733867761;
	bh=mi0udZzZbeywpP/vrlSR3292aKI49L4o1M7uXA1k4Mk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rfM4JnurtHNV3jTRBcxL9eW8LoXlPOJoZ29W1NyimM/LYbAVTmOBM30F6D2K8tJPe
	 ZgbqD1N1919Xo6brFMdd2HjHsGncEeMj36nL4Irl1jNwKdihnSCAJVtwYp2ZGEpM4g
	 b/bcnx0f8ODWHayujXqxGYWocjXEGLvYJlNyOumA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 10 Dec 2024 22:55:55 +0100
Subject: [PATCH v2 08/14] power: supply: core: use dev_to_psy()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241210-power-supply-dev_to_psy-v2-8-9d8c9d24cfe4@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733867760; l=1730;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=mi0udZzZbeywpP/vrlSR3292aKI49L4o1M7uXA1k4Mk=;
 b=suUEFTDJNjBLoB8Ogp5P2Omj5LvrFC8N3QFPdFfm9gTAinboc0Ut+RAp8DPOcqSOsXHiXxZjo
 ZsXkJlbNTygDDy3bJX6MJ6LaiLUnNrI7nB6IX2ohSTUr9tbEVohut3K
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Use the new, explicit accessor to go from a 'struct device' to its
'struct power_supply'.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/power_supply_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 0cdccfd585cb49b623027a3edaf2958777d2be8a..1db27afb7017c4428aa90372f7b9de03223671cf 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -123,7 +123,7 @@ struct psy_for_each_psy_cb_data {
 static int psy_for_each_psy_cb(struct device *dev, void *data)
 {
 	struct psy_for_each_psy_cb_data *cb_data = data;
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 
 	return cb_data->fn(psy, cb_data->data);
 }
@@ -456,7 +456,7 @@ EXPORT_SYMBOL_GPL(power_supply_set_battery_charged);
 static int power_supply_match_device_by_name(struct device *dev, const void *data)
 {
 	const char *name = data;
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 
 	return strcmp(psy->desc->name, name) == 0;
 }
@@ -479,7 +479,7 @@ struct power_supply *power_supply_get_by_name(const char *name)
 					       power_supply_match_device_by_name);
 
 	if (dev) {
-		psy = dev_get_drvdata(dev);
+		psy = dev_to_psy(dev);
 		atomic_inc(&psy->use_cnt);
 	}
 
@@ -536,7 +536,7 @@ struct power_supply *power_supply_get_by_phandle(struct device_node *np,
 	of_node_put(power_supply_np);
 
 	if (dev) {
-		psy = dev_get_drvdata(dev);
+		psy = dev_to_psy(dev);
 		atomic_inc(&psy->use_cnt);
 	}
 

-- 
2.47.1


