Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4302983FA
	for <lists+linux-pm@lfdr.de>; Sun, 25 Oct 2020 23:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1419347AbgJYWSg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 18:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419338AbgJYWSd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 18:18:33 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8CAC0613D0;
        Sun, 25 Oct 2020 15:18:33 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id j30so9423753lfp.4;
        Sun, 25 Oct 2020 15:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jm9YF5Hl5xiQzRyo55jaqGijbDIMmn+mukworT9oCDs=;
        b=mDY2uq2kL1k4S9q/v2EbI4njrePtAesq0Un2ovdy9jOM7UGItTaLvY80x6Zzq3tAHC
         tabWFd8/eiWgMmKIGd2UacIC9HsLwCWND9Cmk0JkB2DkKZtfNIXbmQEK8+Vsj1j/s4Zz
         5Zx7KxmlPREK6CUkPmHOt8nkSuqFtEbFDLpzSWGIbd5o7N3rigR+IUnLauPU6XLXryAT
         yAUjUGI1OegWu4sLK76cOB055c7ztr5oHX1ffr7AldnPJaje80OkPifMREZAtn0H10lN
         qGcQFNlAa5e7OFPZGh8ZJiulf20OjaPPs+KYMOwQYTFOI5/OP7z+Z8NTsuzrD7kcGRi1
         m4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jm9YF5Hl5xiQzRyo55jaqGijbDIMmn+mukworT9oCDs=;
        b=hrDMF6A9tACIQSuZrC3dXp6mV96ZoDKC/Ew/QkNgDE2zpBvkkPWGXHvUJunOEG8y6s
         DGr4Iitw40R+GdLNG6/q70L3VjyQAQMB/tkK5iPmk+slw73DyAfbWCMOZ+hj4ECBab6l
         CZTe5A/Y8Qaef7Ln6ViRe4LSLho4MDBL8IBUkBd+G3fTkCc0J0rrrSSXlcIOrWhr1ncP
         gVkFe6kIkqUJLXlrCZfVqleS/65ZVofX2LMI8L6AHwCnBPt1p0+6K5ohKN4agkxzy6js
         RKdSMzk52cK0OlxLeMR4/WAitx3/kQF52TnSXMS4axedbk+gwMHUPoU8Eh/ELU89+K9M
         cU7g==
X-Gm-Message-State: AOAM531cvpp70+MH28tfoy5UVfke4PPm5lS31YAdelLeIyFohSl8YSXj
        VLlyVJnZZyfSb2P/WxOhyxY=
X-Google-Smtp-Source: ABdhPJxtHxIhWZZjOwiBsRdKvNg9UkDVL7rq3m5XJ0THmxZMcWrYOSL1KvozWahGzovqLpXx0YbxoQ==
X-Received: by 2002:a19:be02:: with SMTP id o2mr3683087lff.314.1603664311626;
        Sun, 25 Oct 2020 15:18:31 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.gmail.com with ESMTPSA id k13sm932423ljh.136.2020.10.25.15.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 15:18:31 -0700 (PDT)
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
Subject: [PATCH v6 38/52] memory: tegra30-emc: Continue probing if timings are missing in device-tree
Date:   Mon, 26 Oct 2020 01:17:21 +0300
Message-Id: <20201025221735.3062-39-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201025221735.3062-1-digetx@gmail.com>
References: <20201025221735.3062-1-digetx@gmail.com>
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
index b31e11f95462..78f770cf0d64 100644
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

