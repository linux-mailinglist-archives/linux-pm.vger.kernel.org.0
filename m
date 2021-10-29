Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B941943FDAA
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 15:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbhJ2N7Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 09:59:16 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:43806 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231506AbhJ2N7N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Oct 2021 09:59:13 -0400
X-UUID: 7eaa6856c3e8495a8355e0c256e75812-20211029
X-UUID: 7eaa6856c3e8495a8355e0c256e75812-20211029
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 707469765; Fri, 29 Oct 2021 21:56:40 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 29 Oct 2021 21:56:39 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs10n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 29 Oct 2021 21:56:39 +0800
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <hector.yuan@mediatek.com>
Subject: [PATCH v1 1/1] cpufreq: mediatek-hw: Fix double devm_remap in hotplug case
Date:   Fri, 29 Oct 2021 19:42:23 +0800
Message-ID: <1635507743-17919-2-git-send-email-hector.yuan@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1635507743-17919-1-git-send-email-hector.yuan@mediatek.com>
References: <1635507743-17919-1-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Hector.Yuan" <hector.yuan@mediatek.com>

When hotpluging policy cpu, cpu policy init will be called multiple times.
Unplug CPU7 -> CPU6 -> CPU5 -> CPU4, then plug CPU4 again.
In this case, devm_remap will double remap and resource allocate fail.
So replace devm_remap to ioremap and release resources in cpu policy exit.

Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
---
 drivers/cpufreq/mediatek-cpufreq-hw.c |   33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index 0cf18dd..25317d7 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -36,6 +36,8 @@ enum {
 struct mtk_cpufreq_data {
 	struct cpufreq_frequency_table *table;
 	void __iomem *reg_bases[REG_ARRAY_SIZE];
+	struct resource *res;
+	void __iomem *base;
 	int nr_opp;
 };
 
@@ -156,6 +158,7 @@ static int mtk_cpu_resources_init(struct platform_device *pdev,
 {
 	struct mtk_cpufreq_data *data;
 	struct device *dev = &pdev->dev;
+	struct resource *res;
 	void __iomem *base;
 	int ret, i;
 	int index;
@@ -170,9 +173,26 @@ static int mtk_cpu_resources_init(struct platform_device *pdev,
 	if (index < 0)
 		return index;
 
-	base = devm_platform_ioremap_resource(pdev, index);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
+	if (!res) {
+		dev_err(dev, "failed to get mem resource %d\n", index);
+		return -ENODEV;
+	}
+
+	if (!request_mem_region(res->start, resource_size(res), res->name)) {
+		dev_err(dev, "failed to request resource %pR\n", res);
+		return -EBUSY;
+	}
+
+	base = ioremap(res->start, resource_size(res));
+	if (!base) {
+		dev_err(dev, "failed to map resource %pR\n", res);
+		ret = -ENOMEM;
+		goto release_region;
+	}
+
+	data->base = base;
+	data->res = res;
 
 	for (i = REG_FREQ_LUT_TABLE; i < REG_ARRAY_SIZE; i++)
 		data->reg_bases[i] = base + offsets[i];
@@ -187,6 +207,9 @@ static int mtk_cpu_resources_init(struct platform_device *pdev,
 	policy->driver_data = data;
 
 	return 0;
+release_region:
+	release_mem_region(res->start, resource_size(res));
+	return ret;
 }
 
 static int mtk_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
@@ -233,9 +256,13 @@ static int mtk_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 static int mtk_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
 {
 	struct mtk_cpufreq_data *data = policy->driver_data;
+	struct resource *res = data->res;
+	void __iomem *base = data->base;
 
 	/* HW should be in paused state now */
 	writel_relaxed(0x0, data->reg_bases[REG_FREQ_ENABLE]);
+	iounmap(base);
+	release_mem_region(res->start, resource_size(res));
 
 	return 0;
 }
-- 
1.7.9.5

