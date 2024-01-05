Return-Path: <linux-pm+bounces-1893-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FCA82549B
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jan 2024 14:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96FC5284B07
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jan 2024 13:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC942D787;
	Fri,  5 Jan 2024 13:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ZWbulTye"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8626A2D781
	for <linux-pm@vger.kernel.org>; Fri,  5 Jan 2024 13:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id LkVcrdK8nez8cLkVcrylHG; Fri, 05 Jan 2024 14:45:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1704462314;
	bh=grojnI9yCI7rgx9ixAnLj1H5YTl+RCfBvs/OtW0Sc/E=;
	h=From:To:Cc:Subject:Date;
	b=ZWbulTyezPsVPkCWp5JZV1G/eSTocoeVg+Wh+w70+gRvoYdJ4bcRUNIsep1UV86Oy
	 4wBK6df++3OZxjEgtsMsCqDdw5U4g9tMTQqgT5d9b7PMvSzQq7ivbuuJRHIIyIfc/V
	 skoVd/AXTtUFrnrDY/Q2eBrS/UaLT36KK9LhiHDwGdzs1RLND8JLtyFx340s8qDQ1o
	 kzgwHqe/ul9criYdlYjC/zkhJE4+k7tuVE+iOY8/Q9bd4mrRr+We7AtbqECEjgAtqR
	 GE3a2UPNRAWsSYEH+U04ZfCpbQmSXMiQBrYR+I2h5Jwz+tIt2EPTAxn27JsaHgNG0A
	 aGnmwZM8hko3g==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 05 Jan 2024 14:45:14 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: alexis.lothore@bootlin.com,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-pm@vger.kernel.org
Subject: [PATCH] thermal: core: Save a few bytes of memory when registering a cooling device
Date: Fri,  5 Jan 2024 14:45:11 +0100
Message-Id: <4a3658efad8f6247ed8c477717dc2820b72319d0.1704462287.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some *thermal_cooling_device_register() calls pass a string literal as the
'type' parameter.

So kstrdup_const() can be used instead of kfree() to avoid a memory
allocation in such cases.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/thermal/thermal_core.c | 6 +++---
 include/linux/thermal.h        | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index fa88d8707241..d21225ddbf10 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -846,7 +846,7 @@ static void thermal_release(struct device *dev)
 			    sizeof("cooling_device") - 1)) {
 		cdev = to_cooling_device(dev);
 		thermal_cooling_device_destroy_sysfs(cdev);
-		kfree(cdev->type);
+		kfree_const(cdev->type);
 		ida_free(&thermal_cdev_ida, cdev->id);
 		kfree(cdev);
 	}
@@ -918,7 +918,7 @@ __thermal_cooling_device_register(struct device_node *np,
 	cdev->id = ret;
 	id = ret;
 
-	cdev->type = kstrdup(type ? type : "", GFP_KERNEL);
+	cdev->type = kstrdup_const(type ? type : "", GFP_KERNEL);
 	if (!cdev->type) {
 		ret = -ENOMEM;
 		goto out_ida_remove;
@@ -969,7 +969,7 @@ __thermal_cooling_device_register(struct device_node *np,
 out_cooling_dev:
 	thermal_cooling_device_destroy_sysfs(cdev);
 out_cdev_type:
-	kfree(cdev->type);
+	kfree_const(cdev->type);
 out_ida_remove:
 	ida_free(&thermal_cdev_ida, id);
 out_kfree_cdev:
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index bf84595a4e86..052c72c0fa17 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -102,7 +102,7 @@ struct thermal_cooling_device_ops {
 
 struct thermal_cooling_device {
 	int id;
-	char *type;
+	const char *type;
 	unsigned long max_state;
 	struct device device;
 	struct device_node *np;
-- 
2.34.1


