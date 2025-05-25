Return-Path: <linux-pm+bounces-27626-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF23AC3379
	for <lists+linux-pm@lfdr.de>; Sun, 25 May 2025 11:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E6431894EC0
	for <lists+linux-pm@lfdr.de>; Sun, 25 May 2025 09:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A20D1E7C12;
	Sun, 25 May 2025 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="QNCcU0zI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-70.smtpout.orange.fr [80.12.242.70])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D597E3BB48;
	Sun, 25 May 2025 09:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748166098; cv=none; b=b4FMgvo/gfQmzv05K8W5pyDq2TqMzAt+A1+KxFYhp4QvJIKyuZJT+r7uLULCsxEocVlxd+im8hic/J17BaMVJcIYJoCaU8J+GktMq/2dyOmh1eQNDL7Rlf3OmDILDptab6I+tMBqkNUuFMbLoQGyYiaevljPW4dXptOANyE4JBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748166098; c=relaxed/simple;
	bh=Z0ULkCdlKxE7u445m/coZLXARw+PeS84yO1rRgMgIX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oWbnr7jrcql2cqOJpxfoAcQEQerFZTOz7cfmmGU6zwxSTo/TdsQTm2pCGalnZWJIgp3r5RYeA/gt8bDMqnjyv8J/jj65juDnn0cJ7k3FIogTDvtlstvwLSuBxkuuZ3/w4kbLgV31IdrNItKksi32flMs7pqMrabqgvMXAHLyFwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=QNCcU0zI; arc=none smtp.client-ip=80.12.242.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id J7qAu8zzkyzREJ7qAui2s9; Sun, 25 May 2025 11:40:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1748166026;
	bh=3Ge08bMJ+KqUgvFk44XiE+E22u5Ef56JB5n9nEZeKTY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=QNCcU0zI7f0vU6+wFHRG7lIrtw5urmVfKvivO5D8Y5S7LYVl6lFQ7dX5eJAyILRVr
	 09pCf489Da9Ut9/+NZ6LDOt2eB2ZnrW4x1YhszeTfyuWsebOUWH/a5dOQZeJ0NDip5
	 0FIiZ1sQM7zOTT9xE3VJQi9L5PIhpZuIB8izeoysO0z1sdTBr3cHSBQqUV0XlJ6kh1
	 3ARq+4Hc1PXWf5zmkBAhsIV15AfbkUyvgpTWDiupR9oha+MINJQbOOIs8DxyEHm3Q6
	 qiltI98qYc1vAsECAfjM92knuoBFe2a+jcIsQfWGJQp69eZ7UpedfhvCHl2+XtdpmY
	 jJQoLtuMX9W6g==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 25 May 2025 11:40:26 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] thermal: Constify struct thermal_zone_device_ops
Date: Sun, 25 May 2025 11:40:04 +0200
Message-ID: <5bba3bf0139e2418b306a0f9a2f1f81ef49e88a6.1748165978.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct thermal_zone_device_ops' are not modified in these drivers.

Constifying these structures moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  28116	   5168	    128	  33412	   8284	drivers/thermal/armada_thermal.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  28244	   5040	    128	  33412	   8284	drivers/thermal/armada_thermal.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/thermal/armada_thermal.c                        | 2 +-
 drivers/thermal/da9062-thermal.c                        | 2 +-
 drivers/thermal/dove_thermal.c                          | 2 +-
 drivers/thermal/imx_thermal.c                           | 2 +-
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 2 +-
 drivers/thermal/kirkwood_thermal.c                      | 2 +-
 drivers/thermal/mediatek/lvts_thermal.c                 | 2 +-
 drivers/thermal/renesas/rcar_thermal.c                  | 2 +-
 drivers/thermal/spear_thermal.c                         | 2 +-
 drivers/thermal/st/st_thermal.c                         | 2 +-
 drivers/thermal/testing/zone.c                          | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 9bff21068721..c2fbdb534f61 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -408,7 +408,7 @@ static int armada_get_temp_legacy(struct thermal_zone_device *thermal,
 	return ret;
 }
 
-static struct thermal_zone_device_ops legacy_ops = {
+static const struct thermal_zone_device_ops legacy_ops = {
 	.get_temp = armada_get_temp_legacy,
 };
 
diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
index 2077e85ef5ca..a8d4b766ba21 100644
--- a/drivers/thermal/da9062-thermal.c
+++ b/drivers/thermal/da9062-thermal.c
@@ -137,7 +137,7 @@ static int da9062_thermal_get_temp(struct thermal_zone_device *z,
 	return 0;
 }
 
-static struct thermal_zone_device_ops da9062_thermal_ops = {
+static const struct thermal_zone_device_ops da9062_thermal_ops = {
 	.get_temp	= da9062_thermal_get_temp,
 };
 
diff --git a/drivers/thermal/dove_thermal.c b/drivers/thermal/dove_thermal.c
index f9157a47156b..723bc72f0626 100644
--- a/drivers/thermal/dove_thermal.c
+++ b/drivers/thermal/dove_thermal.c
@@ -106,7 +106,7 @@ static int dove_get_temp(struct thermal_zone_device *thermal,
 	return 0;
 }
 
-static struct thermal_zone_device_ops ops = {
+static const struct thermal_zone_device_ops ops = {
 	.get_temp = dove_get_temp,
 };
 
diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index bab52e6b3b15..38c993d1bcb3 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -361,7 +361,7 @@ static bool imx_should_bind(struct thermal_zone_device *tz,
 	return trip->type == THERMAL_TRIP_PASSIVE;
 }
 
-static struct thermal_zone_device_ops imx_tz_ops = {
+static const struct thermal_zone_device_ops imx_tz_ops = {
 	.should_bind = imx_should_bind,
 	.get_temp = imx_get_temp,
 	.change_mode = imx_change_mode,
diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 0e07693ecf59..5736638c586b 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -515,7 +515,7 @@ static int int3400_thermal_change_mode(struct thermal_zone_device *thermal,
 	return result;
 }
 
-static struct thermal_zone_device_ops int3400_thermal_ops = {
+static const struct thermal_zone_device_ops int3400_thermal_ops = {
 	.get_temp = int3400_thermal_get_temp,
 	.change_mode = int3400_thermal_change_mode,
 };
diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kirkwood_thermal.c
index 7c2265231668..4619e090f756 100644
--- a/drivers/thermal/kirkwood_thermal.c
+++ b/drivers/thermal/kirkwood_thermal.c
@@ -48,7 +48,7 @@ static int kirkwood_get_temp(struct thermal_zone_device *thermal,
 	return 0;
 }
 
-static struct thermal_zone_device_ops ops = {
+static const struct thermal_zone_device_ops ops = {
 	.get_temp = kirkwood_get_temp,
 };
 
diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 985925147ac0..acce8fde2cba 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -571,7 +571,7 @@ static irqreturn_t lvts_irq_handler(int irq, void *data)
 	return iret;
 }
 
-static struct thermal_zone_device_ops lvts_ops = {
+static const struct thermal_zone_device_ops lvts_ops = {
 	.get_temp = lvts_get_temp,
 	.set_trips = lvts_set_trips,
 };
diff --git a/drivers/thermal/renesas/rcar_thermal.c b/drivers/thermal/renesas/rcar_thermal.c
index 00a66ee0a5b0..fdd7afdc4ff6 100644
--- a/drivers/thermal/renesas/rcar_thermal.c
+++ b/drivers/thermal/renesas/rcar_thermal.c
@@ -277,7 +277,7 @@ static int rcar_thermal_get_temp(struct thermal_zone_device *zone, int *temp)
 	return rcar_thermal_get_current_temp(priv, temp);
 }
 
-static struct thermal_zone_device_ops rcar_thermal_zone_ops = {
+static const struct thermal_zone_device_ops rcar_thermal_zone_ops = {
 	.get_temp	= rcar_thermal_get_temp,
 };
 
diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
index bb96be947521..603dadcd3df5 100644
--- a/drivers/thermal/spear_thermal.c
+++ b/drivers/thermal/spear_thermal.c
@@ -41,7 +41,7 @@ static inline int thermal_get_temp(struct thermal_zone_device *thermal,
 	return 0;
 }
 
-static struct thermal_zone_device_ops ops = {
+static const struct thermal_zone_device_ops ops = {
 	.get_temp = thermal_get_temp,
 };
 
diff --git a/drivers/thermal/st/st_thermal.c b/drivers/thermal/st/st_thermal.c
index a14a37d54698..1470ca519def 100644
--- a/drivers/thermal/st/st_thermal.c
+++ b/drivers/thermal/st/st_thermal.c
@@ -132,7 +132,7 @@ static int st_thermal_get_temp(struct thermal_zone_device *th, int *temperature)
 	return 0;
 }
 
-static struct thermal_zone_device_ops st_tz_ops = {
+static const struct thermal_zone_device_ops st_tz_ops = {
 	.get_temp	= st_thermal_get_temp,
 };
 
diff --git a/drivers/thermal/testing/zone.c b/drivers/thermal/testing/zone.c
index 1f4e450100e2..4257d813d572 100644
--- a/drivers/thermal/testing/zone.c
+++ b/drivers/thermal/testing/zone.c
@@ -381,7 +381,7 @@ static int tt_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 	return 0;
 }
 
-static struct thermal_zone_device_ops tt_zone_ops = {
+static const struct thermal_zone_device_ops tt_zone_ops = {
 	.get_temp = tt_zone_get_temp,
 };
 
-- 
2.49.0


