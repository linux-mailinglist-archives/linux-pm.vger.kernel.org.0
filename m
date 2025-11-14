Return-Path: <linux-pm+bounces-38029-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AD0C5CAD1
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 11:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2A473B4D81
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 10:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0397313279;
	Fri, 14 Nov 2025 10:51:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D489526E703;
	Fri, 14 Nov 2025 10:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763117493; cv=none; b=ZBRIURoZsWtGuZ4sHJr1XKXarl8+sRGK56wVrTAgQYGVENnIVyuxuFET+MrPkTOxTw7W81f0TEkstrrHxpELgT/RvQJT9yg6Te+qpFq+3bUZ4LQiXovuDtCcoGgRIQiFjnyh4WLqDhc7S3wpNzLTUmTnsEnjY0s+HGAazL0G5Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763117493; c=relaxed/simple;
	bh=zo2TUMsdg/heOH/Io/41y3C3ZeWn8LOanDcaBWyKWUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EuzztuiNpQa54HtuXhXv6rB8frmfpOBvqmuVfQQnbaTuSZQFZR6nPvsgUHat25PbtjEM7AdKvCPQUek5foIhcK791BEVhtKbN361xqIHaOSojjQugo8I47NR9BfVujEf2AlhhzI62n1o5aGIFUahxWfSPLk/88o2nTleLVIEbAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9815EC4CEF8;
	Fri, 14 Nov 2025 10:51:31 +0000 (UTC)
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
Subject: [PATCH v2] thermal: rcar_gen3: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Fri, 14 Nov 2025 11:51:29 +0100
Message-ID: <813ad36fdc8561cf1c396230436e8ff3ff903a1f.1763117455.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert the Renesas R-Car Gen3 thermal driver from SIMPLE_DEV_PM_OPS()
to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr().  This lets us drop the
__maybe_unused annotation from its resume callback, and reduces kernel
size in case CONFIG_PM or CONFIG_PM_SLEEP is disabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
v2:
  - Add Reviewed-by.
---
 drivers/thermal/renesas/rcar_gen3_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
index 3223de238d01441f..04382299e7323838 100644
--- a/drivers/thermal/renesas/rcar_gen3_thermal.c
+++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
@@ -601,7 +601,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __maybe_unused rcar_gen3_thermal_resume(struct device *dev)
+static int rcar_gen3_thermal_resume(struct device *dev)
 {
 	struct rcar_gen3_thermal_priv *priv = dev_get_drvdata(dev);
 	unsigned int i;
@@ -615,13 +615,13 @@ static int __maybe_unused rcar_gen3_thermal_resume(struct device *dev)
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


