Return-Path: <linux-pm+bounces-30508-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AF8AFF16F
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 21:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D35564C5A
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 19:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4C723D28D;
	Wed,  9 Jul 2025 19:05:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D534822DF99;
	Wed,  9 Jul 2025 19:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752087904; cv=none; b=mYEK63yrBhtaU8jxNu3T/3GjsVc+t739UcLPleVW/FZay6+oiOUI6+26bVq3C/zbkAO5jZouMQttIYuVGKe3WiEZ8EBN+3l+aHv9HnoTn/8+qVLnug0t8Vu+Ct293MwP+l2CphHNR1hQPepFg8jvdofKsjcnBb7bDtj19Q52Ja0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752087904; c=relaxed/simple;
	bh=ctl9hBRjUobUCXNVpWpuA7x1NIi1rmfG47Qgte61Sjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EdpYSqp3tmSPHknfdHG24/bmOXRJ6wDQThZ9vVXRL9K06U/ljKGBrBLohrGeyW/JTcFGnCVDFCBR4W+/k+L1B/AzaoHZd+tpF/Z36Jp6Mb75aL8ynD4RF8jqS4Z6OC61VeNs3o+7YD6X747yYj3GmRXeBrJzxJf01ScNi3ZQmzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11F1C4CEEF;
	Wed,  9 Jul 2025 19:05:02 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] thermal: rcar_gen3: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Wed,  9 Jul 2025 21:04:58 +0200
Message-ID: <49d1fe8b8cc287825d6eafcbcd2a1eb64f1f2db0.1752087880.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Renesas R-Car Gen3 thermal driver from SIMPLE_DEV_PM_OPS()
to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr().  This lets us drop the
__maybe_unused annotation from its resume callback, and reduces kernel
size in case CONFIG_PM or CONFIG_PM_SLEEP is disabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/thermal/renesas/rcar_gen3_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
index 24a702ee4c1fb83d..b54338bbc4c78a1d 100644
--- a/drivers/thermal/renesas/rcar_gen3_thermal.c
+++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
@@ -570,7 +570,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __maybe_unused rcar_gen3_thermal_resume(struct device *dev)
+static int rcar_gen3_thermal_resume(struct device *dev)
 {
 	struct rcar_gen3_thermal_priv *priv = dev_get_drvdata(dev);
 	unsigned int i;
@@ -584,13 +584,13 @@ static int __maybe_unused rcar_gen3_thermal_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(rcar_gen3_thermal_pm_ops, NULL,
-			 rcar_gen3_thermal_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(rcar_gen3_thermal_pm_ops, NULL,
+				rcar_gen3_thermal_resume);
 
 static struct platform_driver rcar_gen3_thermal_driver = {
 	.driver	= {
 		.name	= "rcar_gen3_thermal",
-		.pm = &rcar_gen3_thermal_pm_ops,
+		.pm = pm_sleep_ptr(&rcar_gen3_thermal_pm_ops),
 		.of_match_table = rcar_gen3_thermal_dt_ids,
 	},
 	.probe		= rcar_gen3_thermal_probe,
-- 
2.43.0


