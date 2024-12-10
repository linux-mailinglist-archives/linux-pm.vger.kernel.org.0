Return-Path: <linux-pm+bounces-18961-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4189EBC43
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 22:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C533D169B2E
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 21:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA7C23EBE7;
	Tue, 10 Dec 2024 21:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ZPgPzDUu"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55A623EA67;
	Tue, 10 Dec 2024 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733867768; cv=none; b=Ctz4YnWiEYm6rPmC8tcoK8vqkm4OfUyzMm/oViOvZKNid3mO8nh27nV+lfmFRk0yAsHAjCU7VAg1J4h/uG/wNdspPHrc7aPCrNucMPBdmzoWvL/Cz28HJQzC5ID0mhoqJBqt57OMpoCCfL8T1dtcWsUfWj2VZYUWiEDjFli8D9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733867768; c=relaxed/simple;
	bh=ikNGjIg0Xo0i2PMFc6EBNWDFiQuRA40O5AfkzB0zdF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bdKeQX+rghCpjWbaTG9Hdc27Uv8GZ+Vav8qlBIXV3lzIfwTi7HXV7s6zLkdPKKU8/YFFBEPQeh8xx/emFM62FYb8j9I4fEW4ProlalvuER3yU7adHXtsJTxBZkM01XHPl0RZP9ivSkAL8iw79jYvPl6FbMkGht9aA5ysym6YeEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ZPgPzDUu; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733867761;
	bh=ikNGjIg0Xo0i2PMFc6EBNWDFiQuRA40O5AfkzB0zdF4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZPgPzDUum9WtfYduO4RoOslR9XiLudCB4ewWhug6IjN1iD5QjIjd2tepy2lVKFKsP
	 lEah+BJHaQUmcGfH3smhYakndFwKHMBFEnQcM6Z5M5zf0+Ch/l/JHBH2bOktelY2V5
	 S+hFMxdrnlVuR7o40k+rAbVUVUjkQL0vu+NDk8+Q=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 10 Dec 2024 22:55:53 +0100
Subject: [PATCH v2 06/14] power: supply: core: remove
 power_supply_for_each_device()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241210-power-supply-dev_to_psy-v2-6-9d8c9d24cfe4@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733867760; l=2228;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=ikNGjIg0Xo0i2PMFc6EBNWDFiQuRA40O5AfkzB0zdF4=;
 b=JoUlKtirfDaw2mIfmreAeGCVsxS4WmWk5wmEVhJ+/pmqcM/NJEP6quKcEl5SMUv1DF02kiNiY
 EtaqEdzkN/FA/FIoDSiRL0Thwgt+YL9zA6x4pRxbsxSPk+8JbVlKt90
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


