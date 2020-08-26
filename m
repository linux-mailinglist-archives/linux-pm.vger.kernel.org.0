Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93EB9253435
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 18:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgHZQAd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 12:00:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbgHZQA2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Aug 2020 12:00:28 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8546214F1;
        Wed, 26 Aug 2020 16:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598457625;
        bh=Av1naSxIAEszcZFOnKr6q5AWvz2qDmIq55BsDqPUgJ0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bLP3IvtDEaFHpFSB2tLjFx6NksO1D+kJHPp9JKgL4zS3X1eFCfN8/j2aR9oIHPNaw
         dbLxwwSVz38QY/qfpUe9OgCpIBk7SLX/SFxR+RE/CTq8e8333VYGpc8nK6w7/hzR7q
         FYj6E9rxVmEQidkvbL2wM6U5Bds21ZC5kRTha2u8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] cpufreq: s5pv210: Use dev_err instead of pr_err in probe
Date:   Wed, 26 Aug 2020 18:00:16 +0200
Message-Id: <20200826160016.469-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826160016.469-1-krzk@kernel.org>
References: <20200826160016.469-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

dev_err() allows easily to identify the device printing the message so
no need for __func__.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/cpufreq/s5pv210-cpufreq.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index 7dccdb364fcf..911a655895d8 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -616,8 +616,7 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
 
 	np = of_find_compatible_node(NULL, NULL, "samsung,s5pv210-clock");
 	if (!np) {
-		pr_err("%s: failed to find clock controller DT node\n",
-			__func__);
+		dev_err(dev, "failed to find clock controller DT node\n");
 		result = -ENODEV;
 		goto err_clock;
 	}
@@ -625,16 +624,14 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
 	clk_base = of_iomap(np, 0);
 	of_node_put(np);
 	if (!clk_base) {
-		pr_err("%s: failed to map clock registers\n", __func__);
-		result = -EFAULT;
+		dev_err(dev, "failed to map clock registers\n");
 		goto err_clock;
 	}
 
 	for_each_compatible_node(np, NULL, "samsung,s5pv210-dmc") {
 		id = of_alias_get_id(np, "dmc");
 		if (id < 0 || id >= ARRAY_SIZE(dmc_base)) {
-			pr_err("%s: failed to get alias of dmc node '%pOFn'\n",
-				__func__, np);
+			dev_err(dev, "failed to get alias of dmc node '%pOFn'\n", np);
 			of_node_put(np);
 			result = id;
 			goto err_clk_base;
@@ -642,8 +639,7 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
 
 		dmc_base[id] = of_iomap(np, 0);
 		if (!dmc_base[id]) {
-			pr_err("%s: failed to map dmc%d registers\n",
-				__func__, id);
+			dev_err(dev, "failed to map dmc%d registers\n", id);
 			of_node_put(np);
 			result = -EFAULT;
 			goto err_dmc;
@@ -652,7 +648,7 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
 
 	for (id = 0; id < ARRAY_SIZE(dmc_base); ++id) {
 		if (!dmc_base[id]) {
-			pr_err("%s: failed to find dmc%d node\n", __func__, id);
+			dev_err(dev, "failed to find dmc%d node\n", id);
 			result = -ENODEV;
 			goto err_dmc;
 		}
-- 
2.17.1

