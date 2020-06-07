Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06661F0E85
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 20:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbgFGS6y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 14:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728941AbgFGS5u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 14:57:50 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30229C061A0E;
        Sun,  7 Jun 2020 11:57:50 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id n24so17736028lji.10;
        Sun, 07 Jun 2020 11:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cheeB0fZKRZ//Ml/fXNdvoie/fMScv9EjJj9t5vhyMg=;
        b=d7V9jtJcvc5vO9jCeIgVSYZ+WELLgMvs2NOjcjbfikELvYAUdN+4lavIHaaSFPfqBs
         jV3DSDKn2Ia1XxUPRIwfOHdDJTBHkwzLbnbkkn529xLMfvlcnbJiJn4BoMJzlzkP1nLy
         bUvzu7vSyFhbnzD5e6DEdZ1L69I314R1rKEGKyJNuigUqC6bPmjA2RvyM5okPMkQr3Vn
         FgbF19BVOXj7WnlcqpDAF9dMZdZUqzsfKssXoQ5YEENhTYK0D+YR2tZ6cyowo9R3Ege3
         oG+NrkVllri5gNmdKhgPmIqRGcADykZlFbdkmocli5m13YxcmiFivvQkW+h/TKX3zOC9
         WryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cheeB0fZKRZ//Ml/fXNdvoie/fMScv9EjJj9t5vhyMg=;
        b=S3LvaBCEgFyJzuLQE7TsHLNQvYLR/4upG0+iKX3CQSseOeN5Y3EgewEHaAaJg8mBeY
         4VdC4QeqrY7jdBvFS75bj97LvcZeEu7Tmzl2ibUvUmwyfFFHSbeCDgtZG5JPPVIxpHWt
         7ryBeoRVtzUQ24GIFvg4doPhZt0k0PqCgqZrjJ1S4x6dvNNu+1Aj/8UTddlZWuKLztHJ
         gql89jmqSdcmKmOfFndKbPNcwDysPOd9diP4ZAUzHnoZErKaE7Kavxr37p3LpvaXxQUY
         Mka5MYFFfGcox5YITzVDiRfotXi79C+mIODhWAZpVxOeV5eEBwp9gO+kgsSz0xoIK2VO
         I81A==
X-Gm-Message-State: AOAM530YDJfu+08/q+H3VyvE1GpdjuBVLn6diahT6e4Z8G8fGYaRtAnd
        sl5GJIeJ4PJkwW/gIDnrvUw=
X-Google-Smtp-Source: ABdhPJwQpY8ksMO/LvCcyofbXlo5qyf8SnLXRKK2DnwLIZoG+7H/HsHXQlM+b4uHolxZG4PPP/J2fw==
X-Received: by 2002:a2e:9ac6:: with SMTP id p6mr9920940ljj.417.1591556268742;
        Sun, 07 Jun 2020 11:57:48 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id e21sm3650953ljb.135.2020.06.07.11.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 11:57:48 -0700 (PDT)
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
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 29/39] memory: tegra20-emc: Use devm_platform_ioremap_resource
Date:   Sun,  7 Jun 2020 21:55:20 +0300
Message-Id: <20200607185530.18113-30-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607185530.18113-1-digetx@gmail.com>
References: <20200607185530.18113-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Utilize that relatively new helper which makes code a bit cleaner.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index a95522020a25..79fdae042b57 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -689,7 +689,6 @@ static int tegra_emc_probe(struct platform_device *pdev)
 {
 	struct device_node *np;
 	struct tegra_emc *emc;
-	struct resource *res;
 	int irq, err;
 
 	/* driver has nothing to do in a case of memory timing absence */
@@ -724,8 +723,7 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	emc->regs = devm_ioremap_resource(&pdev->dev, res);
+	emc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(emc->regs))
 		return PTR_ERR(emc->regs);
 
-- 
2.26.0

