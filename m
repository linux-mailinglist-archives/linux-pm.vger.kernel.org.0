Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FF42A6AB7
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 17:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731527AbgKDQwY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 11:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731595AbgKDQuH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 11:50:07 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E46AC0613D4;
        Wed,  4 Nov 2020 08:50:06 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id 141so28036878lfn.5;
        Wed, 04 Nov 2020 08:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ontILFu87u1f4MUNSf7ISJYhooI1Fl6nxuqtZ8MK7KA=;
        b=KpiAXbIN9xyIT49De3HrEvU5DGh8CkAdeTEamjiprGA+wcYsFBjI7VaEwyQPpkJ0AH
         UcyWqBFvUp1Mi9/k+nOg0MXFukdp0qAlfHvpTMoL+qOyT+riM702VbkA7BwBl6WNydlA
         ycrTD1A/+45wJ0xinDRB8U3yXvEckk0H+vD4djxHznRHV9VNo22Xys6qNzKk6rlOuMeM
         OhFLTlyybkJ3hNdz/w91rbNUz36x0KXzyyGeCedtZjyesOeMyEV9J3A1CvMe2QDe0WHX
         XJAUu8XGCa41g/+o/TS+Dg+FFZJxCmQbHDhlJ01XTBCoZimI+uafm2pG7o4xw+eBaNdA
         Fazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ontILFu87u1f4MUNSf7ISJYhooI1Fl6nxuqtZ8MK7KA=;
        b=qPDWGSyzL7NvLFJPAj7ZNyxwJ/XjFwmhwsnogbvup8saD8jjRrwTP77uZbAm99VngC
         YuF8PfMzNZ+OUvGZHHd7YgcPo4AflG8wanZHnE8J5ovj2wegWj/HxZZ1MzTkw49T8m/1
         1ubaHRRzzENdOpym1G5aBLrYFMieBsOYW6bjYfmA3FM+/RfD47x77GbYRyeGVSVxMWnq
         px/P6FD6Qhy3sJTXQ9FOEE3tTZAjW5DZBzJxqxl0xrAj5KDXaYBnQmriyWvJQlugR4Up
         84n04LI13diSP0snekK1qZmIykXXX6a5giA7eYIxNzJXktjlu6JniSB8av70esFOsZF3
         hYvA==
X-Gm-Message-State: AOAM531DpvXd0R7yWxVRcAI+coJKADhjaTlaDLQnSQ92vTOEYnKZSizT
        iRBnOpnUxxXMRvKnya3f3HE=
X-Google-Smtp-Source: ABdhPJwFwRfM8+FLmXLSCezu8zR7YUZ+l+xLpkCbgrgY7ovwtYaZEuVGHW6YCQ0T4DaEpbT7+RwT4Q==
X-Received: by 2002:a19:8605:: with SMTP id i5mr5409733lfd.356.1604508604974;
        Wed, 04 Nov 2020 08:50:04 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m2sm454587lfo.25.2020.11.04.08.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:50:04 -0800 (PST)
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
Subject: [PATCH v7 29/47] memory: tegra: Use devm_platform_ioremap_resource()
Date:   Wed,  4 Nov 2020 19:49:05 +0300
Message-Id: <20201104164923.21238-30-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104164923.21238-1-digetx@gmail.com>
References: <20201104164923.21238-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use devm_platform_ioremap_resource() helper which makes code a bit
cleaner.

Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra124-emc.c | 4 +---
 drivers/memory/tegra/tegra20-emc.c  | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/memory/tegra/tegra124-emc.c b/drivers/memory/tegra/tegra124-emc.c
index 35dbceb7f841..ee8ee39e98ed 100644
--- a/drivers/memory/tegra/tegra124-emc.c
+++ b/drivers/memory/tegra/tegra124-emc.c
@@ -1179,7 +1179,6 @@ static int tegra_emc_probe(struct platform_device *pdev)
 {
 	struct device_node *np;
 	struct tegra_emc *emc;
-	struct resource *res;
 	u32 ram_code;
 	int err;
 
@@ -1189,8 +1188,7 @@ static int tegra_emc_probe(struct platform_device *pdev)
 
 	emc->dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	emc->regs = devm_ioremap_resource(&pdev->dev, res);
+	emc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(emc->regs))
 		return PTR_ERR(emc->regs);
 
diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 027f46287dbf..5ba4e495bfc3 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -654,7 +654,6 @@ static int tegra_emc_probe(struct platform_device *pdev)
 {
 	struct device_node *np;
 	struct tegra_emc *emc;
-	struct resource *res;
 	int irq, err;
 
 	/* driver has nothing to do in a case of memory timing absence */
@@ -689,8 +688,7 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	emc->regs = devm_ioremap_resource(&pdev->dev, res);
+	emc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(emc->regs))
 		return PTR_ERR(emc->regs);
 
-- 
2.27.0

