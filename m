Return-Path: <linux-pm+bounces-38938-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 22598C955A3
	for <lists+linux-pm@lfdr.de>; Sun, 30 Nov 2025 23:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC7C74E01AB
	for <lists+linux-pm@lfdr.de>; Sun, 30 Nov 2025 22:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214762459E7;
	Sun, 30 Nov 2025 22:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hq606jXL"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1739F23645D
	for <linux-pm@vger.kernel.org>; Sun, 30 Nov 2025 22:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764543321; cv=none; b=gp8T6vZSRsd5Q2IJ/ODUMO2Ta8o2qvW5wBNK3NlztVxi110tgGKWqREiI4r62kjePW3rJDVuqjpZ8dyQjUWgf7pzMYAAwoibFkM8BK0HaSjgAY6sr+K0sWDxXiIqxLu0n5t8Lo1I6kAZtkm1Z10RPBiR6CZrzt78JfScw8roAS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764543321; c=relaxed/simple;
	bh=iqGXw7/nlSwy7cUOgS9lavGIOvcajtj6ZI3/n851DF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G5NIW/7903zaKFkK/qirPhMapDaGhwi4kETjPjy+y2JF7GlpRu4oLbamANP05+sz6TjAU7lsJx6pTI56dGZVyRFpMFmw65Ke2D09+lEQfprpEGLhuvPR0/V7Q8oe9pwiqeFbNQu9QaWvVtlaqJfv9/FJZ4fpdu2acAOlHj/1L7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hq606jXL; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764543314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y3zi54fqg3Dk2cRhgMV9Qr4FUT5aZsi0jpnqIp0ID9w=;
	b=Hq606jXLAwrThWHNyJtMCpuwys4cwSkneu/YjuItjVgYvxPTx400OdaeCStqVB5tF65tXM
	WNAo/urFr5JOCp9gjtfb5vhfp9iMHHWH5PSqnGuYml7Y79S3qqOwo/dPWrBgfGpludcxcw
	3IKOvpFJpIcfw8C3ujTlI9S3D1AxeYc=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Markus Mayer <mmayer@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal/drivers/brcmstb_thermal: Use max to simplify brcmstb_get_temp
Date: Sun, 30 Nov 2025 23:54:58 +0100
Message-ID: <20251130225459.46241-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use max() to simplify brcmstb_get_temp() and improve its readability.
Since avs_tmon_code_to_temp() returns an int, change the data type of
the local variable 't' from long to int.  No functional changes.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/thermal/broadcom/brcmstb_thermal.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index f46f2ddc174e..a9ffa596f7c0 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -16,6 +16,7 @@
 #include <linux/irqreturn.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -154,7 +155,7 @@ static int brcmstb_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct brcmstb_thermal_priv *priv = thermal_zone_device_priv(tz);
 	u32 val;
-	long t;
+	int t;
 
 	val = __raw_readl(priv->tmon_base + AVS_TMON_STATUS);
 
@@ -164,10 +165,7 @@ static int brcmstb_get_temp(struct thermal_zone_device *tz, int *temp)
 	val = (val & AVS_TMON_STATUS_data_msk) >> AVS_TMON_STATUS_data_shift;
 
 	t = avs_tmon_code_to_temp(priv, val);
-	if (t < 0)
-		*temp = 0;
-	else
-		*temp = t;
+	*temp = max(0, t);
 
 	return 0;
 }
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


