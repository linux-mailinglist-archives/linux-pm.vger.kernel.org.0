Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9D2110384
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 18:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfLCRcg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Dec 2019 12:32:36 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1103 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfLCRcg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Dec 2019 12:32:36 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5de69c2b0000>; Tue, 03 Dec 2019 09:32:27 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 03 Dec 2019 09:32:35 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 03 Dec 2019 09:32:35 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Dec
 2019 17:32:35 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 3 Dec 2019 17:32:35 +0000
Received: from sumitg-l4t.nvidia.com (Not Verified[10.24.37.103]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5de69c300000>; Tue, 03 Dec 2019 09:32:35 -0800
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <sumitg@nvidia.com>, <mperttunen@nvidia.com>
Subject: [TEGRA194_CPUFREQ Patch 1/3] firmware: tegra: adding function to get BPMP data
Date:   Tue, 3 Dec 2019 23:02:26 +0530
Message-ID: <1575394348-17649-1-git-send-email-sumitg@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575394347; bh=WtC++4Md9/b4qc1FTSjjLKQOR4hk6B0Sbkpq1iIzKm8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=QUC52I+LlhSppr+BKMAQxopSu1dkMRZqhQcP3OJ7O9MwfHNk2csHH3l7Kgbi9kawN
         DS1UJMSlXyV+iRMnhaTFUJ9Futbb+E7ty9w3DQEQgdLM6UL7cMaOePpDKDH3tSXZgl
         oixPb8/UGkaDlo6EGLHepOzMqbSzZ9Q5DVq6TIA0u8nKgabqgIA3NbmedD/BeDKaMV
         mUn7TPMv5v/aA0oUSudiT9fiiivpXs3wFylYRUeWvdGp36NfOOhUgwuPl1QwjFmVgW
         QuTBX9TItoHtj9Yoao1wENdxJtXF0pDyMfoUuxeKWd/ytfjBbq9XZVGmZ3WwAggkPC
         tuJr/RLEv/z1w==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Adding new function of_tegra_bpmp_get() to get BPMP data.
This function can be used by other drivers like cpufreq to
get BPMP data without adding any property in respective
drivers DT node.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/firmware/tegra/bpmp.c | 38 ++++++++++++++++++++++++++++++++++++++
 include/soc/tegra/bpmp.h      |  5 +++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
index 6741fcd..9c3d7f1 100644
--- a/drivers/firmware/tegra/bpmp.c
+++ b/drivers/firmware/tegra/bpmp.c
@@ -38,6 +38,44 @@ channel_to_ops(struct tegra_bpmp_channel *channel)
 	return bpmp->soc->ops;
 }
 
+struct tegra_bpmp *of_tegra_bpmp_get(void)
+{
+	struct platform_device *pdev;
+	struct device_node *bpmp_dev;
+	struct tegra_bpmp *bpmp;
+
+	/* Check for bpmp device status in DT */
+	bpmp_dev = of_find_compatible_node(NULL, NULL, "nvidia,tegra186-bpmp");
+	if (!bpmp_dev) {
+		bpmp = ERR_PTR(-ENODEV);
+		goto err_out;
+	}
+	if (!of_device_is_available(bpmp_dev)) {
+		bpmp = ERR_PTR(-ENODEV);
+		goto err_put;
+	}
+
+	pdev = of_find_device_by_node(bpmp_dev);
+	if (!pdev) {
+		bpmp = ERR_PTR(-ENODEV);
+		goto err_put;
+	}
+
+	bpmp = platform_get_drvdata(pdev);
+	if (!bpmp) {
+		bpmp = ERR_PTR(-EPROBE_DEFER);
+		put_device(&pdev->dev);
+		goto err_put;
+	}
+
+	return bpmp;
+err_put:
+	of_node_put(bpmp_dev);
+err_out:
+	return bpmp;
+}
+EXPORT_SYMBOL_GPL(of_tegra_bpmp_get);
+
 struct tegra_bpmp *tegra_bpmp_get(struct device *dev)
 {
 	struct platform_device *pdev;
diff --git a/include/soc/tegra/bpmp.h b/include/soc/tegra/bpmp.h
index f2604e9..21402d9 100644
--- a/include/soc/tegra/bpmp.h
+++ b/include/soc/tegra/bpmp.h
@@ -107,6 +107,7 @@ struct tegra_bpmp_message {
 };
 
 #if IS_ENABLED(CONFIG_TEGRA_BPMP)
+struct tegra_bpmp *of_tegra_bpmp_get(void);
 struct tegra_bpmp *tegra_bpmp_get(struct device *dev);
 void tegra_bpmp_put(struct tegra_bpmp *bpmp);
 int tegra_bpmp_transfer_atomic(struct tegra_bpmp *bpmp,
@@ -122,6 +123,10 @@ void tegra_bpmp_free_mrq(struct tegra_bpmp *bpmp, unsigned int mrq,
 			 void *data);
 bool tegra_bpmp_mrq_is_supported(struct tegra_bpmp *bpmp, unsigned int mrq);
 #else
+static inline struct tegra_bpmp *of_tegra_bpmp_get(void)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
 static inline struct tegra_bpmp *tegra_bpmp_get(struct device *dev)
 {
 	return ERR_PTR(-ENOTSUPP);
-- 
2.7.4

