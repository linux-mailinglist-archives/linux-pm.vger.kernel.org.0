Return-Path: <linux-pm+bounces-38939-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9786FC95714
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 01:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7A4583418C3
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 00:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B83710F1;
	Mon,  1 Dec 2025 00:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="coaP8mRe"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9111E89C
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 00:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764547700; cv=none; b=RhMHeRDVlp11CxCBJLYSQzvlopjsqgVh4EYkoW0mWkBXYIOxexPkarAc/cybY7gWDtUglgBoceuSPWQR0DH9mKAHZa0lH71M0agWI6T80/2q/3nD21ZZqvKK2XWTqEy7PomZJW8r2+omoJljeCceSFJEVP5ZK8HqDBVextdMurg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764547700; c=relaxed/simple;
	bh=b+1xAFRCtHQMGDBpzmF2Xs9hsAV+Ssxx7l/FQeK6AGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rg183B4fNgGtGZgBl3/L2L+nNJrUGzYey+QZ+boGGGF2ypwSATPOHF1V6Z2LgyP0vllO+qSEN1g5RDoGaNArDVRHgf0fNbvbPq6GhsPpdoVJvZVZbftgd3ud0GBF3JWw/23YuyShdgLmplEzpWkWnFUpKES+J9nU/ZIQE3fRt+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=coaP8mRe; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764547685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uCNF53Li60QdPXxf/q2DlB7bjSdyWe25Wed4MJMg7yg=;
	b=coaP8mReT1H7VX76ICiZUOitVVGjcUrWSnvZFHLeCLfv2BbATVaykMbq2LQRNsQqNuTH1D
	fNzipGLA/HIxuDPic5mDEF6AyfUUl+mxfjW9QQ+R9N2ncErc72vco0GGMlRbLZU3N1SbDw
	c5c6uI113EKlcXqaD2QDC2qjeJNM5ns=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-pm@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: broadcom: Use clamp() to simplify bcm2835_thermal_temp2adc()
Date: Mon,  1 Dec 2025 01:07:09 +0100
Message-ID: <20251201000714.74752-2-thorsten.blum@linux.dev>
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
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


