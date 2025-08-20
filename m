Return-Path: <linux-pm+bounces-32693-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C392B2D6C4
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 10:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7F01889CC3
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 08:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA82F2DA76F;
	Wed, 20 Aug 2025 08:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QeXNjW1g"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5D02DA769;
	Wed, 20 Aug 2025 08:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755678872; cv=none; b=qpBxsgP6PsK2TJFhCyV3GxnZcgYSFQFOSi6/fKc8e3MgJ8BRhMmmLZsNPHcDWfPZBlDW5vWBNn9CkMY0jxiSj8HQH83M06nKoT/+3g2pOydbiETQj+Yy0W8KNkiNGTYvgftJiQzsHTBK0ujrN4WfZGE5RxdnMnHuTvZ1X4JMjlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755678872; c=relaxed/simple;
	bh=+RHqySFbfhv8ZIPc+OLu0zUIEfW5E7dLbQ/D4r26FoU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dcodw2T9JuG3/EUqLZbUcZzw0p1VpohWrplnRa0WuLlJrcGe98nfy1uCMmw25KwVOdgwvXreizgwkDtwL3o3CgjBm85YeCV/VI2GylM9eE55jGeuyIKv3oBDF0cOtK9XvosbiWcS182gJgA75su4XGj/ugbjvmJMsFenQLErAgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QeXNjW1g; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57K8YQOS3154246;
	Wed, 20 Aug 2025 03:34:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755678866;
	bh=GY39GJdCPvM3cH171BB9k5yHQ1eCoIKMtZb6pSuuJdI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=QeXNjW1g28W063AuPqO/PMaJfq6Cc1uTF8IvAGPIT2dxrAXz6EsiwmaFrGOOdR++j
	 btuC2c0D9+vPciRmH1Q/k4YUVLZv1sb2M/qDbliT9AW/1Ma1WoxKxoK/CZqsvwld/o
	 09EfoctzcVddNnMqitcrW+oamC316hWSGH1pLdAc=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57K8YPSr1920213
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 20 Aug 2025 03:34:25 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 20
 Aug 2025 03:34:25 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 20 Aug 2025 03:34:25 -0500
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57K8YOBM228618;
	Wed, 20 Aug 2025 03:34:25 -0500
From: Paresh Bhagat <p-bhagat@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <khasim@ti.com>, <v-singh1@ti.com>, <afd@ti.com>, <bb@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 4/4] cpufreq: ti: Add support for AM62D2
Date: Wed, 20 Aug 2025 14:03:31 +0530
Message-ID: <20250820083331.3412378-5-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820083331.3412378-1-p-bhagat@ti.com>
References: <20250820083331.3412378-1-p-bhagat@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add support for TI K3 AM62D2 SoC to read speed and revision values
from hardware and pass to OPP layer. AM62D shares the same configuations
as AM62A so use existing am62a7_soc_data.

Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
---
 drivers/cpufreq/ti-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 5a5147277cd0..9a912d309315 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -310,6 +310,7 @@ static const struct soc_device_attribute k3_cpufreq_soc[] = {
 	{ .family = "AM62X", .revision = "SR1.0" },
 	{ .family = "AM62AX", .revision = "SR1.0" },
 	{ .family = "AM62PX", .revision = "SR1.0" },
+	{ .family = "AM62DX", .revision = "SR1.0" },
 	{ /* sentinel */ }
 };
 
@@ -457,6 +458,7 @@ static const struct of_device_id ti_cpufreq_of_match[]  __maybe_unused = {
 	{ .compatible = "ti,omap36xx", .data = &omap36xx_soc_data, },
 	{ .compatible = "ti,am625", .data = &am625_soc_data, },
 	{ .compatible = "ti,am62a7", .data = &am62a7_soc_data, },
+	{ .compatible = "ti,am62d2", .data = &am62a7_soc_data, },
 	{ .compatible = "ti,am62p5", .data = &am62p5_soc_data, },
 	/* legacy */
 	{ .compatible = "ti,omap3430", .data = &omap34xx_soc_data, },
-- 
2.34.1


