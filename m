Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82B9819E754
	for <lists+linux-pm@lfdr.de>; Sat,  4 Apr 2020 21:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgDDT3c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Apr 2020 15:29:32 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8269 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgDDT3c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Apr 2020 15:29:32 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e88dfb70000>; Sat, 04 Apr 2020 12:27:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 04 Apr 2020 12:29:31 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 04 Apr 2020 12:29:31 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 4 Apr
 2020 19:29:30 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 4 Apr 2020 19:29:30 +0000
Received: from sumitg-l4t.nvidia.com (Not Verified[10.24.37.103]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e88e0170001>; Sat, 04 Apr 2020 12:29:30 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <sumitg@nvidia.com>, <mperttunen@nvidia.com>
Subject: [TEGRA194_CPUFREQ Patch v2 1/3] firmware: tegra: adding function to get BPMP data
Date:   Sun, 5 Apr 2020 00:59:05 +0530
Message-ID: <1586028547-14993-2-git-send-email-sumitg@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586028547-14993-1-git-send-email-sumitg@nvidia.com>
References: <1586028547-14993-1-git-send-email-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586028471; bh=WtC++4Md9/b4qc1FTSjjLKQOR4hk6B0Sbkpq1iIzKm8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=dBeLAnAP0rCl2OAsVQh84lzWUE3m9aOYogONUHhMVCvQY07C9ur1irlkyD5L4vrlu
         k4kLAkuS+BDH7ANs4tVyJbMGFerJVxZlWi6RCyGEiM28EP64t6N0Ek2gjhEVGoTXUJ
         0PqsMVMp+2BLoQEAKP6hDUGaaYCshiVGT9jndzQ5SzbLKciywoDUHpbaXvXNKfw70f
         qwRN3lfNFCtJegu7PouuEmJmMIxf/KYyVwgjicUwst8isdY3E0OCTc+WcMkPiqGAMG
         kEmz57c7NSAKypukUYUckimGCOaomMtIXRmmwrV4TnSLwkJLNrEWOGzi1/4H8+zWeW
         vNsXv0mrUZyxQ==
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

