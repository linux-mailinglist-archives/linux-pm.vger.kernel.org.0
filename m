Return-Path: <linux-pm+bounces-28376-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B88AD3771
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 14:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F84616FD47
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 12:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC132C17B2;
	Tue, 10 Jun 2025 12:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PwirnkCR"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2813299AA5;
	Tue, 10 Jun 2025 12:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749559625; cv=none; b=X+A87PPLIL8NdO3eUdbsRIO38HGJt5L2mmd6G4VFjsAn2bUWplqe+9Hdx9FFdZEx9KVLm5bS6id1QowO47vViKLYr6RocyCLlBBP52ZXFrTO+1IvXX6F91pyBmBQ4tg8i36s01nxIETiAu9zV8c+JkVxTrrRI9HyqigjZHOl/pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749559625; c=relaxed/simple;
	bh=6bHYj/GvFhdNqpNwCN5loAmPMAKh1G83CZSf8OJUjKU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L45eFlTSOjc/cdOZExDymVuPb3JzjU4mQTOX9v8XZrbeigaQ1ECQgXeHychtwEoDK0a0uraoIQZFJTd+Cf+8KyFpbq8BLX46RBcvS11CAIpAwdITMX3VQ1eWLSdJNMHIOh+l/JUuPw9G6ZhvkfczH3Onagbru0O34D0iq/rHC/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PwirnkCR; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1749559621; x=1781095621;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6bHYj/GvFhdNqpNwCN5loAmPMAKh1G83CZSf8OJUjKU=;
  b=PwirnkCRsXJMruB+snTLdJ0R3U0blN8G3diMDtiME62RChT6UDdJVNpe
   brQpLtQZsrNRI/N0UNHsR6LMhtMhrvOfmLmyFHWO/gpWjbYbzMWT6GIg4
   tyKcQkHJtfLUXE+RCz9hCL3boqFx9Euoz5vNsaWWo9pC5KUmHShjIbNA+
   ixuIgISFdGeH+DxUBqzu8BT1Yhr1Bo96z2G1x6PW7LcPvATy5IDJn5/Pa
   L3cyog5fJpok80UqFnifDJq8qQthc9fAtnr0B4f1vGKIlLtaxXlm0Lp0S
   67pKy1mTz2V5sJHBdXKMWWGfcV7gyLrqTpnEyOsYDOIs+LZOOFEKZnxgA
   Q==;
X-CSE-ConnectionGUID: kK3Lf/4PT9yRKmehi04c6g==
X-CSE-MsgGUID: zqHRItgfQOOuxb1tVn4vxw==
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="47589575"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jun 2025 05:47:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 10 Jun 2025 05:46:58 -0700
Received: from archlinux.mchp-main.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 10 Jun 2025 05:46:56 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <sre@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH] power: reset: at91-sama5d2_shdwc: Refactor wake-up source logging to use dev_info
Date: Tue, 10 Jun 2025 15:45:47 +0300
Message-ID: <20250610124545.175492-3-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Use dev_info() instead of pr_info() for more consistent
logging in the driver.

[root@sam9x75eb ~]$ dmesg | grep power
[    1.678542] at91-shdwc fffffe10.poweroff: Wake-Up source: WKUP pin

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 drivers/power/reset/at91-sama5d2_shdwc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
index e9fe08ee3812..ecf15694f925 100644
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -129,7 +129,7 @@ static void at91_wakeup_status(struct platform_device *pdev)
 	else if (SHDW_RTTWK(reg, &rcfg->shdwc))
 		reason = "RTT";
 
-	pr_info("AT91: Wake-Up source: %s\n", reason);
+	dev_info(&pdev->dev, "Wake-Up source: %s\n", reason);
 }
 
 static void at91_poweroff(void)

base-commit: f09079bd04a924c72d555cd97942d5f8d7eca98c
-- 
2.49.0


