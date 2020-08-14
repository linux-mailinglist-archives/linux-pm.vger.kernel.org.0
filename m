Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8CE24422A
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 02:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgHNAIl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 20:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbgHNAHe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 20:07:34 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028B8C061757;
        Thu, 13 Aug 2020 17:07:34 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id i10so8122610ljn.2;
        Thu, 13 Aug 2020 17:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kNoHRWC/OTeJQYDVSJWGL8N8QOi/3TrdM4od2HXXDz4=;
        b=ui2VOlU7pA5o0ooPGCogDYofZDQWu1s2EnbOMwNFowfgtAewNgBcbu4CwCkemJv6Uu
         nkXn68iBqSa74VV27cZ+FMt7U8U37hU8WA+MWEs5qIZGCtR86Yhz/IZLHEMWZkYlKTBf
         +IEUzEGxFbqen+Xj+9i65BC55p6LEJrUzn0hKDEz0QfhxSgoFbrzillDWjgMOeNlss6S
         CeKG0n5QvV2lz3tEgXaHRmWpJ/Twa5GR6yjOWvbnfWU7kd203fNXlU3TYxnYMMSUmztX
         pBURil1BuC4a6+v28osGxR9oa6nJ2AFvbCkt4UmkTZpnRKN3b9PE2xBte9F3Dm/FFBIC
         8F9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kNoHRWC/OTeJQYDVSJWGL8N8QOi/3TrdM4od2HXXDz4=;
        b=iGJv6xKDAkWvadjt33d+pktH13ToymsrvUEMDj9ThuzByo+1iJS7oJCUoDlTQ+4LKb
         dXdOEHUn9sENR5acmRHe8HgCxBqSuguyDT3J32oxA7++EhgyBiee4DQrOYZodIjKvbLw
         EUT2yozYHw/WMGBVqckrLUeCxQrQ5E6GPQF/SlJH45EIkJ7XSahYAcnLQZLFCY1tqP/O
         AVst0ntNO8SRwCyoysI8nTLc/t4xn0tG800EgHdeCGyzDBgPrxNT5tAW4mw/JxQVDHvB
         1T+k3C5GmLQk+nlJM0rBS6UWJ0hOyfCthTlYN/3skJKBiPjjQBvjK4wP0HXb4hnt66cT
         /0uw==
X-Gm-Message-State: AOAM5333mfuV/koV3IyMsdxkxb8KPm3jsZpD8G2Hw3b3uaabTsPb7kEL
        E7546/HlrJeBPWHsK38y0OM=
X-Google-Smtp-Source: ABdhPJwzwyM2g3DLM/2D/MtnfuAylkbujM7XanOCIb5raluuebjKuWbBRWk8wwVbdGkFOlP50xVnmg==
X-Received: by 2002:a05:651c:d0:: with SMTP id 16mr101309ljr.313.1597363652508;
        Thu, 13 Aug 2020 17:07:32 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id c17sm1504450lfr.23.2020.08.13.17.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 17:07:31 -0700 (PDT)
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
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 28/36] memory: tegra20-emc: Use devm_platform_ioremap_resource
Date:   Fri, 14 Aug 2020 03:06:13 +0300
Message-Id: <20200814000621.8415-29-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814000621.8415-1-digetx@gmail.com>
References: <20200814000621.8415-1-digetx@gmail.com>
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
index a02ffc09c39e..db6a4bcb92fb 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -696,7 +696,6 @@ static int tegra_emc_probe(struct platform_device *pdev)
 {
 	struct device_node *np;
 	struct tegra_emc *emc;
-	struct resource *res;
 	int irq, err;
 
 	/* driver has nothing to do in a case of memory timing absence */
@@ -731,8 +730,7 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	emc->regs = devm_ioremap_resource(&pdev->dev, res);
+	emc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(emc->regs))
 		return PTR_ERR(emc->regs);
 
-- 
2.27.0

