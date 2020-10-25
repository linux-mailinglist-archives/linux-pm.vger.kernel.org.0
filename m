Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569B5298412
	for <lists+linux-pm@lfdr.de>; Sun, 25 Oct 2020 23:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1419364AbgJYWSm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 18:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419354AbgJYWSj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 18:18:39 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0D9C0613D2;
        Sun, 25 Oct 2020 15:18:38 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a4so7702142lji.12;
        Sun, 25 Oct 2020 15:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=34s82dziDgtjgE1mmga3CEGdzqBry8pDI5SpO3RIz5Q=;
        b=O0TjVomy7sTec0JSEBoEoVOg72u5g//g7ABf6m+HRcY9USmUYh5ieyO72yyyqWhriR
         Xd0KeoMs7hkj5J4QuFiJeA37EKd/eFS5Bq185k9XAsFBl+keaKGarO0TFJB7PjzYo0VY
         cvFK5gAadN1SA3GKiO0hLAriiNxHIFI+tqWYsVkRRkv/TCrlTXeD8vLyI3SS6ZoX5xUz
         +opgDp0u8XpB7qNmjiXcTzpHtjg0SV/HLqfN2qUcN9Vwdlc5Er2PZRF1AzdqHS4Ykud2
         KDsE+edq7eMFDmWws9UIx4qC6C67fDGxn+n7MuPrFcGpQ/dvfMO+gWUXRH0HhaZNl46S
         HHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=34s82dziDgtjgE1mmga3CEGdzqBry8pDI5SpO3RIz5Q=;
        b=c/gff6ws6O6D322u4bQysYpmGlNZtyUeuIr3Wn+RmAaWKFEYCHNo2706/t7/5rwh7B
         xAS7enT2hOfPqAr+6oZtf54zjQ5n0msxbXsZNN2+xG9CWFaIS1XZkeuG+jQ+iN1FNj+B
         GSGWs3gGLYmh7wIlthQXrRxwIxfoe/3bvwFyZL/3qH8dwTz9y5H5900nAz90ED9Ic7k5
         OdPCWrrCD7U/j6UVb9Aq7sVH1bt1vXbRlDoP3bEWOTBcLXQZbGNXmtyjOR16CqTxm7mp
         YfF+driVdGwcUJFDR0Ld+wqduhJ1FsMesWPMNNR3TLht/wr+nCla3N94/H1/hFKKp+Qf
         NNNg==
X-Gm-Message-State: AOAM530k8If1mrMmxuZuJ+Vy5Rqjnxm8bL8UYlb9CAhljNG1lCGWLZfG
        f31UC6rwxDkB2U9cGChh8go=
X-Google-Smtp-Source: ABdhPJzpGbxU3dxTzUBB9eXcGkorGydSItojnxwUzoP1UK7n046ygK5N9HVGnibcbtno/Us0LjqKVg==
X-Received: by 2002:a2e:8108:: with SMTP id d8mr4756026ljg.96.1603664317268;
        Sun, 25 Oct 2020 15:18:37 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.gmail.com with ESMTPSA id k13sm932423ljh.136.2020.10.25.15.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 15:18:36 -0700 (PDT)
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
Subject: [PATCH v6 43/52] memory: tegra: Remove superfluous error messages around platform_get_irq()
Date:   Mon, 26 Oct 2020 01:17:26 +0300
Message-Id: <20201025221735.3062-44-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201025221735.3062-1-digetx@gmail.com>
References: <20201025221735.3062-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The platform_get_irq() prints error message telling that interrupt is
missing, hence there is no need to duplicated that message in the drivers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c          | 4 +---
 drivers/memory/tegra/tegra20-emc.c | 1 -
 drivers/memory/tegra/tegra30-emc.c | 5 ++---
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 15589bf8f5b6..4a3bf08495c9 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -837,10 +837,8 @@ static int tegra_mc_probe(struct platform_device *pdev)
 	}
 
 	mc->irq = platform_get_irq(pdev, 0);
-	if (mc->irq < 0) {
-		dev_err(&pdev->dev, "interrupt not specified\n");
+	if (mc->irq < 0)
 		return mc->irq;
-	}
 
 	WARN(!mc->soc->client_id_mask, "missing client ID mask for this SoC\n");
 
diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 27242659dfd6..1519d6ce9b28 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -844,7 +844,6 @@ static int tegra_emc_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "interrupt not specified\n");
 		dev_err(&pdev->dev, "please update your device tree\n");
 		return irq;
 	}
diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
index 66eae944ca6d..d2515d7f3c0b 100644
--- a/drivers/memory/tegra/tegra30-emc.c
+++ b/drivers/memory/tegra/tegra30-emc.c
@@ -1472,10 +1472,9 @@ static int tegra_emc_probe(struct platform_device *pdev)
 		return err;
 
 	err = platform_get_irq(pdev, 0);
-	if (err < 0) {
-		dev_err(&pdev->dev, "interrupt not specified: %d\n", err);
+	if (err < 0)
 		return err;
-	}
+
 	emc->irq = err;
 
 	err = devm_request_irq(&pdev->dev, emc->irq, tegra_emc_isr, 0,
-- 
2.27.0

