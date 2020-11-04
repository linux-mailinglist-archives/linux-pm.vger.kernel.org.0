Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335B62A6A98
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 17:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731383AbgKDQvo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 11:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731679AbgKDQuT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 11:50:19 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687D2C0613D3;
        Wed,  4 Nov 2020 08:50:18 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id 11so4152096ljf.2;
        Wed, 04 Nov 2020 08:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=izp2ksHAO+wXie+2l0gXWSi66nlfDA4Ls06awQYimtk=;
        b=ZSbhPJy+i9CAPke/+CZhzWgL4z8f/nhLEmTxqV30f5j/UX/6kn3yKfAyThktTI58mX
         dJl7hyeuu1c7/ReyASCZGnojEGiZzh4o8BuBewRzvY8L7acG37GZwnkfclWf730/zruD
         kYzq1BrFrEbL8kKSTnuXM3qGFBJnuYq5rGXWaLtccngDz2RmSeyzVf54h+4RqVd3Skcu
         v1/mnJuCkYfv8I0DLUgXyoG5I1jSBXYN7DkqgmNMEk245hy9LYVGgwnUrlnCQAe0Gdo7
         eDtYt/En8kuE/JatU/1FLfm5+mHi5m2ymaAYI9SvRhOnvbHwAP4DEAB0h5A5QhIyssuh
         4HEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=izp2ksHAO+wXie+2l0gXWSi66nlfDA4Ls06awQYimtk=;
        b=q52h1/oZ/pzFYc5IyqU/7aQkuqsQek7OVwrXvPjLJa+Lu9Urp9cW9uW+yQdNR0Q9te
         yRZZPDSyJe4+0R3J5ps+9/jGuOwOd1axw0mBR2p+V5Whz9K3820YANgFildn6TDK/VDt
         p+h3y6KkBxG794v1Olq0r2kN0o/PbuaS+0sC+USMCUWJ+mbv50qsrCvSfCzENnyp2eKX
         77lTA49fObPcinRnTV+U/od++J5iGWUPVyxal70Isk/z0Z+3ziwI4EKGTj3wzLlFTm7c
         pHCKl20T5dWaDtpJdGO7hYsCJenAWJYz28Z2IsunwNORrZvtD6h4AybNg0wMwXgASUpK
         dfoA==
X-Gm-Message-State: AOAM533xaKwywP1KahTtA2xQ8kwvA9LlN3i6L343Dnywef/8QQMRyNbM
        wFkPQeHSPf4DcceW38Rsdao=
X-Google-Smtp-Source: ABdhPJypy/YRT5SviNbc5zSng8+8YgyICH7R9f1F0Gr28hWR6kAn7+N6hfwHyRQR/bOT8kYsV4qq9w==
X-Received: by 2002:a2e:9015:: with SMTP id h21mr11349743ljg.450.1604508616906;
        Wed, 04 Nov 2020 08:50:16 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m2sm454587lfo.25.2020.11.04.08.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:50:16 -0800 (PST)
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
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 39/47] memory: tegra30-emc: Continue probing if timings are missing in device-tree
Date:   Wed,  4 Nov 2020 19:49:15 +0300
Message-Id: <20201104164923.21238-40-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104164923.21238-1-digetx@gmail.com>
References: <20201104164923.21238-1-digetx@gmail.com>
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
2.27.0

