Return-Path: <linux-pm+bounces-40185-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 155F9CF3736
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 13:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9197630010F9
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 12:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2979334C18;
	Mon,  5 Jan 2026 12:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CJC3xu91"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D65833374F
	for <linux-pm@vger.kernel.org>; Mon,  5 Jan 2026 12:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615209; cv=none; b=cx9viLEvWHenEzhmrqeCM/4C9KskG0iV/M0URv14L9sO8QghqlC6IMq+O3fkJGpa7PDv+vIgBPzjgd0ayICHiYRVD3MWxjYgfYLAT281eraP0XO/M69INeFvPQbg3D33yUwI9y6Rfa9rMa4bnA+HoSBi7YFOMC6MCm7FDkG5V3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615209; c=relaxed/simple;
	bh=4cLdNFYkRy+cmFYJFX8QQFZ4tNGG1bMNcj6dmpLj/CM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qcIoy4jbwf5yeoI5OErNWX0sfbdAETlsgjYjvbyBMRFqzln+n5tOEGvp2nFpyArs611n8wLgZIyhnrMT/zhtW0IPCKD6knjyOVFOmr50stH8TaMIqMXSWxIyZxTlCg2m54qW8LaEIC5J8Liqh0eJsEHAil9wrICPfYcMdj+0FSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CJC3xu91; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767615195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tmsC7tVniwT8Wa+M6xzLWHZmhRLH7ixcu3nderl3sVI=;
	b=CJC3xu91f8z5MbjqZWTN3ji6eUc+2M8SkU0lULgvVcv6kFMaSlzxBLzNIhAC1dYxF3/KX6
	UTBWDtRTNwYgWUnrm/MXi8TuxktMs62H0KvoeTthaM18dO1zh8BKT4DUs6DKYYedTqMt6r
	a4sdCA8V2JqI8UMjf9ATjdLy3bZWDko=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-pm@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] thermal: broadcom: Use clamp to simplify bcm2835_thermal_temp2adc
Date: Mon,  5 Jan 2026 13:13:03 +0100
Message-ID: <20260105121308.1761-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use clamp() to simplify bcm2835_thermal_temp2adc() and improve its
readability. Explicitly cast BIT() to int to prevent a signedness error.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/thermal/broadcom/bcm2835_thermal.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index 685a5aee5e0d..c5105dfc6ec9 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -11,6 +11,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -80,12 +81,7 @@ static int bcm2835_thermal_temp2adc(int temp, int offset, int slope)
 	temp -= offset;
 	temp /= slope;
 
-	if (temp < 0)
-		temp = 0;
-	if (temp >= BIT(BCM2835_TS_TSENSSTAT_DATA_BITS))
-		temp = BIT(BCM2835_TS_TSENSSTAT_DATA_BITS) - 1;
-
-	return temp;
+	return clamp(temp, 0, (int)BIT(BCM2835_TS_TSENSSTAT_DATA_BITS) - 1);
 }
 
 static int bcm2835_thermal_get_temp(struct thermal_zone_device *tz, int *temp)

