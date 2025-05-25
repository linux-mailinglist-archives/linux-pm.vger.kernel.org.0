Return-Path: <linux-pm+bounces-27628-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E05CAC348E
	for <lists+linux-pm@lfdr.de>; Sun, 25 May 2025 14:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F340316F0F4
	for <lists+linux-pm@lfdr.de>; Sun, 25 May 2025 12:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686D01EE7A1;
	Sun, 25 May 2025 12:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ENMmL7kz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D41192D87;
	Sun, 25 May 2025 12:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748176374; cv=none; b=cnN9jEeMKAYKoDbTYss7eiFxgPIc9k8Sbkl0T6SJ6GNFAKpVz9WEUuhApyGmWKjcgvQGh+KyygDQRN1H9tlJ09hrhE1pV8V0UHJFXSAHJzQDynISKRhtE0HsuILMysZufUBoI6g41d27SIhf/WKt6zTKSy2Ng13+NrB88GSFFS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748176374; c=relaxed/simple;
	bh=Zm6sqqdLsuqM7CAR+q6ZjZWpT2f9BhhyD9qYALFxsnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ovo8nHtVl6QiciYK7Gq93Sezq+/ATHNMYcVuxaobkH7PAy+VyWW4HONNUiV359VUdgGDxmb6bZXa/PJwdAsoiSHpZ+0Bbar+F2IFrIex0ZyaktdmYgFi++JQsEdNhnDxWoxTu1uhOtRbqb0cg8dmYGfOgpBrjyPIJ2wOxF3LvHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ENMmL7kz; arc=none smtp.client-ip=80.12.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id JAWtu3FlrpEs6JAWuuNAR5; Sun, 25 May 2025 14:32:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1748176362;
	bh=ezOSH7DNNbrcR1DYR5Ht3MTrtxBGiOkFfZgULPq3ODQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ENMmL7kzpGv6rNZQN7cEUa9d3mP8A8WR0med0d8Q53PjkvOPGSgTqUkN1a6mAlrTj
	 oBQoZdtxm36eohIdFoSKZQsmOaU2NEK1cencEUC9tLRVk4MPKk4yeytrRnXwL5thl3
	 TCoqig+9ziMj6RkrKH687W6L15XqGa2fB3cWmE9tnJ3Lf2UqPbkSKdTKzNdg6X5VWO
	 a9EJlhdlO15hz4yJa0JBjTwqd2hRYDNeW3pqvRnRmwxlgEaNXB/TKNWfcm+P3rSV0A
	 zF56VwhPHBWiieoP7E+Jm0cdQK/tcaIJvnl0rMZ8W+mCsyv6Xyg/WEWrkTPIKAyzIg
	 xZkp/1EsKLvIg==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 25 May 2025 14:32:42 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: zhanghongchen <zhanghongchen@loongson.cn>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-pm@vger.kernel.org
Subject: [PATCH] thermal/drivers/loongson2: Constify struct thermal_zone_device_ops
Date: Sun, 25 May 2025 14:32:30 +0200
Message-ID: <5f5f815f85a9450bca7848c6d47a1fee840f47e5.1748176328.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct thermal_zone_device_ops' could be left unmodified in this driver.

Constifying this structure moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

This partly reverts commit 734b5def91b5 ("thermal/drivers/loongson2: Add
Loongson-2K2000 support") which removed the const qualifier. Instead,
define two different structures.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   5089	   1160	      0	   6249	   1869	drivers/thermal/loongson2_thermal.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   5464	   1128	      0	   6592	   19c0	drivers/thermal/loongson2_thermal.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/thermal/loongson2_thermal.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
index 2d6b75b0539f..ea4dd2fb1f47 100644
--- a/drivers/thermal/loongson2_thermal.c
+++ b/drivers/thermal/loongson2_thermal.c
@@ -112,13 +112,19 @@ static int loongson2_thermal_set_trips(struct thermal_zone_device *tz, int low,
 	return loongson2_thermal_set(data, low/MILLI, high/MILLI, true);
 }
 
-static struct thermal_zone_device_ops loongson2_of_thermal_ops = {
+static const struct thermal_zone_device_ops loongson2_2k1000_of_thermal_ops = {
 	.get_temp = loongson2_2k1000_get_temp,
 	.set_trips = loongson2_thermal_set_trips,
 };
 
+static const struct thermal_zone_device_ops loongson2_2k2000_of_thermal_ops = {
+	.get_temp = loongson2_2k2000_get_temp,
+	.set_trips = loongson2_thermal_set_trips,
+};
+
 static int loongson2_thermal_probe(struct platform_device *pdev)
 {
+	const struct thermal_zone_device_ops *thermal_ops;
 	struct device *dev = &pdev->dev;
 	struct loongson2_thermal_data *data;
 	struct thermal_zone_device *tzd;
@@ -140,7 +146,9 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 		if (IS_ERR(data->temp_reg))
 			return PTR_ERR(data->temp_reg);
 
-		loongson2_of_thermal_ops.get_temp = loongson2_2k2000_get_temp;
+		thermal_ops = &loongson2_2k2000_of_thermal_ops;
+	} else {
+		thermal_ops = &loongson2_2k1000_of_thermal_ops;
 	}
 
 	irq = platform_get_irq(pdev, 0);
@@ -152,8 +160,7 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 	loongson2_thermal_set(data, 0, 0, false);
 
 	for (i = 0; i <= LOONGSON2_MAX_SENSOR_SEL_NUM; i++) {
-		tzd = devm_thermal_of_zone_register(dev, i, data,
-						    &loongson2_of_thermal_ops);
+		tzd = devm_thermal_of_zone_register(dev, i, data, thermal_ops);
 
 		if (!IS_ERR(tzd))
 			break;
-- 
2.49.0


