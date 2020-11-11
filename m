Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD152AE5A4
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 02:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732755AbgKKBP3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 20:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732704AbgKKBPY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 20:15:24 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD08FC0613D4;
        Tue, 10 Nov 2020 17:15:23 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id d12so688816wrr.13;
        Tue, 10 Nov 2020 17:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fyu/TRO5yWpBbQQ0dTrByo3SnRiUtLscyENKkMxzI64=;
        b=TuenlxOlgQMKeVdC1fXwNuNOwbZY0XCdF44y8OROIBuEb5jOSLndWxohPt4/ZeL26w
         z3c9uSIcdUaN5Z0QeZKkhMU+MFd4iIwPSWnDhdbNEJ/+PaRJf1OqJWAmN3y9/IpgYNOm
         sgvJnLOR5ZF+QZFJ0lCRypdanpM5xsBHbItJrlNUCEH9g1J2uBsv1Hn1fzoCL86dcumv
         a1V3eKEiH4o83PUH4gMwP0lSdmZhgVAqvdBtrbxB4X7vIBzMYeB95BYEbCOtNzr6X2F1
         B1TDWGfGhEe6Da6USBAXp6//8nI3KLuTUNTFBCTJt5J2iEzaU2gL6uiSCbloPpMGSfaJ
         hdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fyu/TRO5yWpBbQQ0dTrByo3SnRiUtLscyENKkMxzI64=;
        b=AllM3kraJxnZyor/mJ2t509CxYyGLx55AMzWmfw5joBp321AknSklgs5AsSBwdkYlS
         gu58ohChEGM1t5gEPznE/BNmTc6pch4JMLVO/sfA3gkFN1kTctaXGO/KBt0uwjz+mIPx
         4E8nFfctPJAfr5RXjaGsJM5TtpEwvNprd/J2/tyx93vZNv3Uavr2NGWrZmdUuwlNYpQ0
         IXbIyENxWDPogF7XBTnkaeAbyD8xRfM/dDDvFnXU95FhQH3E8YR4ocBt6fqcMDIZcMXu
         wALrCn4jewOBop0Kelm10u+8tZh3O+qYH4mzG4SO5YFjygWz9YgqdoywYVVw6nzIpHX2
         KiaQ==
X-Gm-Message-State: AOAM5332N7GnmQsjnUVPm7Fdga2DhRjMz0CO72p0w58ETtDPcNhIOS7u
        yVLA8qhvTueeG1v3qW6p+5ahz2VD2Ig=
X-Google-Smtp-Source: ABdhPJw4wDgLBVIYiU/vXdLuuIS/i2yBD21T0D7MBVqlG5B36sFE29nf56BchuMNs4ai+gb6a1jG+g==
X-Received: by 2002:adf:e74d:: with SMTP id c13mr11217777wrn.277.1605057322702;
        Tue, 10 Nov 2020 17:15:22 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id g131sm564329wma.35.2020.11.10.17.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 17:15:22 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v8 08/26] memory: tegra30-emc: Continue probing if timings are missing in device-tree
Date:   Wed, 11 Nov 2020 04:14:38 +0300
Message-Id: <20201111011456.7875-9-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111011456.7875-1-digetx@gmail.com>
References: <20201111011456.7875-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

EMC driver will become mandatory after turning it into interconnect
provider because interconnect users, like display controller driver, will
fail to probe using newer device-trees that have interconnect properties.
Thus make EMC driver to probe even if timings are missing in device-tree.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra30-emc.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
index d0926088360a..3488786da03b 100644
--- a/drivers/memory/tegra/tegra30-emc.c
+++ b/drivers/memory/tegra/tegra30-emc.c
@@ -988,6 +988,11 @@ static struct device_node *emc_find_node_by_ram_code(struct device *dev)
 	u32 value, ram_code;
 	int err;
 
+	if (of_get_child_count(dev->of_node) == 0) {
+		dev_info(dev, "device-tree doesn't have memory timings\n");
+		return NULL;
+	}
+
 	ram_code = tegra_read_ram_code();
 
 	for_each_child_of_node(dev->of_node, np) {
@@ -1057,6 +1062,9 @@ static long emc_round_rate(unsigned long rate,
 	struct tegra_emc *emc = arg;
 	unsigned int i;
 
+	if (!emc->num_timings)
+		return clk_get_rate(emc->clk);
+
 	min_rate = min(min_rate, emc->timings[emc->num_timings - 1].rate);
 
 	for (i = 0; i < emc->num_timings; i++) {
@@ -1262,16 +1270,6 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	struct tegra_emc *emc;
 	int err;
 
-	if (of_get_child_count(pdev->dev.of_node) == 0) {
-		dev_info(&pdev->dev,
-			 "device-tree node doesn't have memory timings\n");
-		return -ENODEV;
-	}
-
-	np = emc_find_node_by_ram_code(&pdev->dev);
-	if (!np)
-		return -EINVAL;
-
 	emc = devm_kzalloc(&pdev->dev, sizeof(*emc), GFP_KERNEL);
 	if (!emc) {
 		of_node_put(np);
@@ -1285,10 +1283,13 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	emc->clk_nb.notifier_call = emc_clk_change_notify;
 	emc->dev = &pdev->dev;
 
-	err = emc_load_timings_from_dt(emc, np);
-	of_node_put(np);
-	if (err)
-		return err;
+	np = emc_find_node_by_ram_code(&pdev->dev);
+	if (np) {
+		err = emc_load_timings_from_dt(emc, np);
+		of_node_put(np);
+		if (err)
+			return err;
+	}
 
 	emc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(emc->regs))
-- 
2.29.2

