Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8114298444
	for <lists+linux-pm@lfdr.de>; Sun, 25 Oct 2020 23:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1419127AbgJYWUg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 18:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419315AbgJYWSZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 18:18:25 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42721C061755;
        Sun, 25 Oct 2020 15:18:25 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id l2so9444268lfk.0;
        Sun, 25 Oct 2020 15:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SK4mi4uPijedwapHTvsgA4XRJA8rJ81UCcUw/rkRDT0=;
        b=oWfNh0TnVrlfrER/pSC3S0HngwdJVUEVprw9AJ7ZTjeAZ4ypifGCr4JaLsmtQ5rSMp
         NP2b/L/QmJ4SJPoiyPPs4DCI2LbdQHK8dn8PJVu8En/xcHBefZK7xnybpEUpsuzWBBPT
         MJKyawREcvZXsS1o4FGhn7fDCy/pHkvVZ6pZN79murFKRQNNnKfHFsxXc3goXo0cUmwj
         PqeBM/Q1YtMJXkpMbhJtGTh84uc1Lcq6X8Pu6X3AnwE3zpotj47mq3f6OpQIcI0H1o7e
         E1xna5MFtAxyiF7tcyKEKEwbo7wYC7EdqpRe7DBZCfjoI56hxcaY6Y7rXrX8Dgp7ugEz
         slyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SK4mi4uPijedwapHTvsgA4XRJA8rJ81UCcUw/rkRDT0=;
        b=UErpNv1lDQuS2XJ0MN9kWlN739YCp8uwH4u94tF4CNwOvq70dlMR0hgCOEED3CVdz6
         hkY+mwCV5RrMhSDENLtLwYoZr8SsPT55klRqwhRzx7F4RzeiITlw8odIXXl0IiD5RqKM
         6iiGe98JNuv+7mi5oxC0quma+VmX7G6bn5eR5TSRgQqBnpQRWXQdsuBufbRdi7FUHzrh
         2KK+O9kX48yZzMnVC/fiEw37BvoFIyjFRRpypy42ncFy7jxA0tRJaDYrrVRayzUiXTN3
         lCqH/RBqujF+8XV6IbAgFBBPtyBrtgMKJTxE3omfHWWi3/G4Ct0upQc9Pak42hu/Ibsw
         i/6Q==
X-Gm-Message-State: AOAM531Z23vx+r1l9HqBh+Y83yfmuX+mW5X1VWe2vVitqlGVMQdQf1IR
        NI2cbt1lWtWEXDzG5CRdqkqyfMqLbnI=
X-Google-Smtp-Source: ABdhPJz8J+3PAUyWg+GX6iBLvZsb4KMZxRBUq+g7QPwhtNzgE5vfBxmo9k+d9RHakO69bfv4wqvYXA==
X-Received: by 2002:ac2:47f3:: with SMTP id b19mr4296256lfp.192.1603664303791;
        Sun, 25 Oct 2020 15:18:23 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.gmail.com with ESMTPSA id k13sm932423ljh.136.2020.10.25.15.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 15:18:23 -0700 (PDT)
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
Subject: [PATCH v6 31/52] memory: tegra20-emc: Use devm_platform_ioremap_resource()
Date:   Mon, 26 Oct 2020 01:17:14 +0300
Message-Id: <20201025221735.3062-32-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201025221735.3062-1-digetx@gmail.com>
References: <20201025221735.3062-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use devm_platform_ioremap_resource() helper which makes code a bit
cleaner.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 0baa6590adea..ce22ca7cfb77 100644
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

