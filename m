Return-Path: <linux-pm+bounces-32692-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 880F5B2D695
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 10:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E07C47ADB6E
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 08:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3A92D8DC2;
	Wed, 20 Aug 2025 08:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DXb+mwMS"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074892D879F;
	Wed, 20 Aug 2025 08:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755678868; cv=none; b=fEqIJwqJuP+Aw8LgLl3VOc0w/J60pVE30QfbKKacpMiH5TWXAGll6BNQIw06L2VABTsImo5hfHtusFNpTNi1E0OfALXVCebJXWqaWmODeULO6XOx1odlsSqxi409XoWL1s18jhWAzjEHFt8D3EQAM4yfTOLSFLpOH1R+qNpnRFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755678868; c=relaxed/simple;
	bh=Nfdd/RHtz7DIbY67e2HKNSeL9Aken7dUXl2wpP4pVis=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lEmcvjRcqRMzjq7WVs2G9FHavCuDupHhmbx3SjOczK39ejjbFiYyTajLYlDhIDl2G9odwfN09YQcVjedDstTgdLPKuL4UyX543++Q0YW/3j/CvYJ0wkx2SliIqk8qs/M0DOIrCZahivWKjB0augSOjXKHp91EWlMtp/Uc3gx6xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DXb+mwMS; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57K8YL8S210364;
	Wed, 20 Aug 2025 03:34:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755678861;
	bh=Q7jyshbXG9LoEGUH7fQSM7tr0fzpyoB63Rz2qSbviUo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=DXb+mwMS0+VDv8vrz1TXLAXIpL3GtqKUuRAvXERyqPzYTWYe7BY0RSaRYr3lkbuIq
	 5wtfkr+S+o5UGY12tEbKk2kLqvIxRu+QErHjyNNuDS0Gar/KiQMCJOrUlckKWftfDi
	 EoUUvdugLiF8J86vWmuOde5ClW4vk5uklR0CpMf0=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57K8YL6Q1059099
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 20 Aug 2025 03:34:21 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 20
 Aug 2025 03:34:20 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 20 Aug 2025 03:34:20 -0500
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57K8YJ1A228554;
	Wed, 20 Aug 2025 03:34:20 -0500
From: Paresh Bhagat <p-bhagat@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <khasim@ti.com>, <v-singh1@ti.com>, <afd@ti.com>, <bb@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 3/4] cpufreq: dt-platdev: Blacklist ti,am62d2 SoC
Date: Wed, 20 Aug 2025 14:03:30 +0530
Message-ID: <20250820083331.3412378-4-p-bhagat@ti.com>
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

Add ti,am62d2 SoC to the blacklist as the ti-cpufreq driver will handle
creating the cpufreq-dt platform device after it completes and ensure
it is not created twice.

Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 1a9d9d008002..cd1816a12bb9 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -189,6 +189,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "ti,omap3", },
 	{ .compatible = "ti,am625", },
 	{ .compatible = "ti,am62a7", },
+	{ .compatible = "ti,am62d2", },
 	{ .compatible = "ti,am62p5", },
 
 	{ .compatible = "qcom,ipq5332", },
-- 
2.34.1


