Return-Path: <linux-pm+bounces-18769-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E83B09E852C
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 14:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D469F1644B0
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 13:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78D414B946;
	Sun,  8 Dec 2024 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="kGCjVHFQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEF91474A0;
	Sun,  8 Dec 2024 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733662962; cv=none; b=jcsKq7tlLe8tnIW6XTnXVUfvGBNCYhC0WAQkZc0hsYl8Eyk9tV3Pp+DKqjqADAtKRuBC/CrQx3ePGdEpXAFmDcfaJmWJWy/dIW+tTgyr2rA0r4T2iORT/aHHLVVf5mJNlOz8ZNrmYsuxPYFEnl6gTdGNEwFYlrsH1mr3DV/CFRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733662962; c=relaxed/simple;
	bh=ikNGjIg0Xo0i2PMFc6EBNWDFiQuRA40O5AfkzB0zdF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K84oytNAhqGOBNT5mdeQ5anaHV+xlzlKUSqaedamAzXrsE5JX7AsgZaA2JF8gz2TBavs3LXo5L+/ONKmglxQOPa8Us8IA3dIRlvV0PE3N1+XcWHMctxUnQTfzOey0n++8nfhM93I369HGm+eJxdG2wC3pCyw2TdwwTIgVhXM/OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=kGCjVHFQ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733662958;
	bh=ikNGjIg0Xo0i2PMFc6EBNWDFiQuRA40O5AfkzB0zdF4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kGCjVHFQwiSr+OQJnDn4Y3R0aa4dzJen/abeglyVHQlFruXjJy79mEE4KGAzJKw+6
	 RPhmws/n8FQDxEIpsrb81ESKvD8F3VtYnGtDjpyVgdjXIGOniQrQBTf32fNEcpZ/mk
	 JANyrFXpeB5GQHBZJVIsQgh9CIMau8rFcAufyrlU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 08 Dec 2024 14:02:38 +0100
Subject: [PATCH 06/14] power: supply: core: remove
 power_supply_for_each_device()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241208-power-supply-dev_to_psy-v1-6-f95de9117558@weissschuh.net>
References: <20241208-power-supply-dev_to_psy-v1-0-f95de9117558@weissschuh.net>
In-Reply-To: <20241208-power-supply-dev_to_psy-v1-0-f95de9117558@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733662957; l=2228;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=ikNGjIg0Xo0i2PMFc6EBNWDFiQuRA40O5AfkzB0zdF4=;
 b=vg7B1flIqiULkEhZyPzsQWHHeWLN3TLQ4qulnnQsalhnW3JoIckcOgH13Wwn/D1BvroaEhSN9
 s/vnoyOsXuvAPe8sprhIZlKOHNlX4ECoXSLY2qESNJ9VHA8x3n+exPQ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

There are no users anymore. All potential future users are expected to
use power_supply_for_each_psy().

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/power_supply_core.c | 8 +-------
 include/linux/power_supply.h             | 1 -
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 9adea87c69124f7025a06fe7550892392e28cd65..0cdccfd585cb49b623027a3edaf2958777d2be8a 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -115,12 +115,6 @@ static void power_supply_changed_work(struct work_struct *work)
 	spin_unlock_irqrestore(&psy->changed_lock, flags);
 }
 
-int power_supply_for_each_device(void *data, int (*fn)(struct device *dev, void *data))
-{
-	return class_for_each_device(&power_supply_class, NULL, data, fn);
-}
-EXPORT_SYMBOL_GPL(power_supply_for_each_device);
-
 struct psy_for_each_psy_cb_data {
 	int (*fn)(struct power_supply *psy, void *data);
 	void *data;
@@ -141,7 +135,7 @@ int power_supply_for_each_psy(void *data, int (*fn)(struct power_supply *psy, vo
 		.data = data,
 	};
 
-	return power_supply_for_each_device(&cb_data, psy_for_each_psy_cb);
+	return class_for_each_device(&power_supply_class, NULL, &cb_data, psy_for_each_psy_cb);
 }
 EXPORT_SYMBOL_GPL(power_supply_for_each_psy);
 
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 11d54270eaa9216f3e46e129cd363a804ae8759a..3d67f4a6a1c934f387adde12fc96a63a99299923 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -881,7 +881,6 @@ extern int power_supply_powers(struct power_supply *psy, struct device *dev);
 #define to_power_supply(device) container_of(device, struct power_supply, dev)
 
 extern void *power_supply_get_drvdata(struct power_supply *psy);
-extern int power_supply_for_each_device(void *data, int (*fn)(struct device *dev, void *data));
 extern int power_supply_for_each_psy(void *data, int (*fn)(struct power_supply *psy, void *data));
 
 static inline bool power_supply_is_amp_property(enum power_supply_property psp)

-- 
2.47.1


