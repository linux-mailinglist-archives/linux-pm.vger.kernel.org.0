Return-Path: <linux-pm+bounces-18766-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC909E8526
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 14:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5979116435E
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 13:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE05149C4D;
	Sun,  8 Dec 2024 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="exZ1FKX4"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F88280BFF;
	Sun,  8 Dec 2024 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733662962; cv=none; b=orpczh8TDz3AYfgBYJZoAbm1qJ+WLsoOseaDnl7cRevhfk1RBBn6nOC1nHbAYD4c9lbhVkP+gMtt4F4TKKhGGJqPrlX6Bahzda/7KOuY0UmOuOv0DKZUXlrvM7dJuy5bmfi2Kq4vGC/LbQlhyE/F6J07ViU/bIRyj4CHYMUpSIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733662962; c=relaxed/simple;
	bh=5uH53yw6BlCKxmOXRAKHQy9Q+cvI4FT7Jj+ynXFpNQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jp/C7a5HWwlPG+N1snsvzi02jA9FrmspSZUH8VUF+Z2LvmZrxbolSz9uphNkM6Cte1mricfNsc1PFWymsMOnPsZRbigaliDvF19EZHovNlUMPgNwk88XKqogq49SinOI81ewiz0N/9vj7X6dFa6TstgS016xfafKMVnK1fit/eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=exZ1FKX4; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733662958;
	bh=5uH53yw6BlCKxmOXRAKHQy9Q+cvI4FT7Jj+ynXFpNQM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=exZ1FKX42K2Dub0ls66LKTltOA6EXURRy3ukSyvmGcUkPoUG4YNqcJgskmSdxPHWb
	 ngOIHitpOcImPaO1BcimXv6awzrO/8ib8a4IRFYuvoO+pDcP7B7xPFYjUTkaC3XgFG
	 oraMo2BdgDkb7aRrA+rhefOCdhKFZMVMBUrxVQ0Q=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 08 Dec 2024 14:02:34 +0100
Subject: [PATCH 02/14] power: supply: core: introduce
 power_supply_for_each_psy()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241208-power-supply-dev_to_psy-v1-2-f95de9117558@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733662957; l=2415;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=5uH53yw6BlCKxmOXRAKHQy9Q+cvI4FT7Jj+ynXFpNQM=;
 b=sVGaz9d1TovL+sO0f5svGBwLPKkxW+A8hEbZe0ho2hbhSpMA+bqf+9hQYhNhyfXOhNFWy0BA2
 qoD3h1EphiSBKXfxWWUJp1ikHn6xtxluTMBVbhI3jvHdMwywrv6r/oT
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

All existing callers of power_supply_for_each_device() want to iterate
over 'struct power_supply', not 'struct device'.
The power_supply_for_each_device() forces each caller to duplicate the
logic to go from one to the other.
Introduce power_supply_for_each_psy() to simplify the callers.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/power_supply_core.c | 24 ++++++++++++++++++++++++
 include/linux/power_supply.h             |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 502b07468b93dfb7f5a6c2092588d931a7d015f2..48bc968ff6c54d4b196c3faf450ef6464cdb305d 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -122,6 +122,30 @@ int power_supply_for_each_device(void *data, int (*fn)(struct device *dev, void
 }
 EXPORT_SYMBOL_GPL(power_supply_for_each_device);
 
+struct psy_for_each_psy_cb_data {
+	int (*fn)(struct power_supply *psy, void *data);
+	void *data;
+};
+
+static int psy_for_each_psy_cb(struct device *dev, void *data)
+{
+	struct psy_for_each_psy_cb_data *cb_data = data;
+	struct power_supply *psy = dev_get_drvdata(dev);
+
+	return cb_data->fn(psy, cb_data->data);
+}
+
+int power_supply_for_each_psy(void *data, int (*fn)(struct power_supply *psy, void *data))
+{
+	struct psy_for_each_psy_cb_data cb_data = {
+		.fn = fn,
+		.data = data,
+	};
+
+	return power_supply_for_each_device(&cb_data, psy_for_each_psy_cb);
+}
+EXPORT_SYMBOL_GPL(power_supply_for_each_psy);
+
 void power_supply_changed(struct power_supply *psy)
 {
 	unsigned long flags;
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index b98106e1a90f34bce5129317a099f363248342b9..11d54270eaa9216f3e46e129cd363a804ae8759a 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -882,6 +882,7 @@ extern int power_supply_powers(struct power_supply *psy, struct device *dev);
 
 extern void *power_supply_get_drvdata(struct power_supply *psy);
 extern int power_supply_for_each_device(void *data, int (*fn)(struct device *dev, void *data));
+extern int power_supply_for_each_psy(void *data, int (*fn)(struct power_supply *psy, void *data));
 
 static inline bool power_supply_is_amp_property(enum power_supply_property psp)
 {

-- 
2.47.1


