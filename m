Return-Path: <linux-pm+bounces-38028-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 58548C5CAFB
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 11:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 38A833490A0
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 10:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808D0311953;
	Fri, 14 Nov 2025 10:50:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6476E26E703;
	Fri, 14 Nov 2025 10:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763117444; cv=none; b=Be9fOnRwFzUduBEXxj8yn9KGAYWUtZdK8JhHy2oHNzNOaMzploGocQ+PgoK+4aMcSSKOulp218mCZ8ioU/qtPsJoBPss1TRV9TB9dgESfcHDe24f3hJQk6fIiIvRS+Kc4Hu2ZlQQyWKIVukElnwVVxo105goUvNfUj36m4nIexI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763117444; c=relaxed/simple;
	bh=qkJ4Jmkcyv+RxR2YbRu9DS4g4g27qGT862ufJkv/HGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l3t+81H8y8NN0Rjpu97r9HJlwKDoSl+teqkIU0YqrOqRGXz3P2hMO+iNVg4JrXI4V+ure4e3wJake3P9UcyrimkZ+QnHj4uzCu8uUinQ9xg7kNiB1ZBD+seBMJj9G5npeOhqz3aRDs6eMDDpGU1a9gd8BujUBM129u9VqD8ZDqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733DFC19424;
	Fri, 14 Nov 2025 10:50:42 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v2] thermal: rcar: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Fri, 14 Nov 2025 11:50:35 +0100
Message-ID: <ee03ec71d10fd589e7458fa1b0ada3d3c19dbb54.1763117351.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert the Renesas R-Car thermal driver from SIMPLE_DEV_PM_OPS() to
DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr().  This lets us drop the
check for CONFIG_PM_SLEEP, and reduces kernel size in case CONFIG_PM or
CONFIG_PM_SLEEP is disabled, while increasing build coverage.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
v2:
  - Add Reviewed-by.
---
 drivers/thermal/renesas/rcar_thermal.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/renesas/rcar_thermal.c b/drivers/thermal/renesas/rcar_thermal.c
index fdd7afdc4ff69217..6e5dcac5d47ae7f6 100644
--- a/drivers/thermal/renesas/rcar_thermal.c
+++ b/drivers/thermal/renesas/rcar_thermal.c
@@ -534,7 +534,6 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 	return ret;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int rcar_thermal_suspend(struct device *dev)
 {
 	struct rcar_thermal_common *common = dev_get_drvdata(dev);
@@ -567,15 +566,14 @@ static int rcar_thermal_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(rcar_thermal_pm_ops, rcar_thermal_suspend,
-			 rcar_thermal_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(rcar_thermal_pm_ops, rcar_thermal_suspend,
+				rcar_thermal_resume);
 
 static struct platform_driver rcar_thermal_driver = {
 	.driver	= {
 		.name	= "rcar_thermal",
-		.pm = &rcar_thermal_pm_ops,
+		.pm = pm_sleep_ptr(&rcar_thermal_pm_ops),
 		.of_match_table = rcar_thermal_dt_ids,
 	},
 	.probe		= rcar_thermal_probe,
-- 
2.43.0


