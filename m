Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2005E1971D3
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 03:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgC3BKo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 21:10:44 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46479 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbgC3BJs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Mar 2020 21:09:48 -0400
Received: by mail-lj1-f193.google.com with SMTP id r7so8639857ljg.13;
        Sun, 29 Mar 2020 18:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+VLbWu+D8TgeK5zW6p2aWDCiEGqay0lhDYDpwRkM9VE=;
        b=D2TtU3gFnd7SSpdWpvNErIhPswcBEddIihrL2PEMVX6DCkji+3tn3nJL6QNxuE3KZN
         UZC9HMLgcLYXNLTm3UegAWd9sAeHegVZqHLmlPY+5ZPlkwS71voF3id9b9J+a50OKf+Q
         XXSdvUhVK9IhPcupPAhiZ9vhcloAIko4KcmhbmkrRcPTAComnntoROdZ44vMZMaBMDMf
         IQOBmk+4lydUBb9jlxReAbmwPOSs8MxNWXWC244fKEfoSI9PgAmA7kd1K3AzJ5b2Fzzm
         /swgNGmKcvNrk0ZPanGgIuXHn1V4r3rPhE94y9E9QFRN23Ie3za31f1BV+3T38YSFDDp
         pG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+VLbWu+D8TgeK5zW6p2aWDCiEGqay0lhDYDpwRkM9VE=;
        b=sKYV1oyHSBPiSBbsZc9IKdaEMYxguj0rncjnuy6yNptripU3alXl1QhAEkEPFbPb3B
         i5t7vmMvwTUn5yXDnnVUK7MikhON0Om02vthjMlgc488u+DAJBIlP+1e6Nn7vc1v1paa
         6kgZszm/J2R8QxXUsMmu8EhKrqhGMXiX+HpmSdHCrI0Xv/LAilbNRslYO04zGdRw4yTA
         47wGcxpBsKinH1gX9seeyQKYiaWhXEOUn9xCKl8KQb7gfH1M1vPDBmPSgtVhWOwCy1IL
         Jq+0nvfrl30w+r0MxpZ4lMq/Y/8QxaNchBTIuiBlgx87COj3vye+jxL0hYHtH6a+hkzV
         4vog==
X-Gm-Message-State: AGi0PuZHju9PTJEhqctJbAASEd666rkfJwNhE7eyxbTVvU/96ouVopmH
        J0SyKlBUmOAu876E9niwWiw=
X-Google-Smtp-Source: APiQypInSDlCTRxykyd6QuIBzENcusxjIbug9n1nvvcfJFF3WBOKRBtFehjeBqpyZgJeyv2fKg8MNg==
X-Received: by 2002:a05:651c:50e:: with SMTP id o14mr5545140ljp.241.1585530586755;
        Sun, 29 Mar 2020 18:09:46 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id f23sm2449005lja.60.2020.03.29.18.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 18:09:46 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 12/22] memory: tegra20-emc: Use devm_platform_ioremap_resource
Date:   Mon, 30 Mar 2020 04:08:54 +0300
Message-Id: <20200330010904.27643-13-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200330010904.27643-1-digetx@gmail.com>
References: <20200330010904.27643-1-digetx@gmail.com>
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
index 60b048ae9982..ef3abc18a3f4 100644
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
2.25.1

