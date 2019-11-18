Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D190E100CBF
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 21:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfKRUGm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 15:06:42 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41199 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbfKRUFu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 15:05:50 -0500
Received: by mail-lj1-f194.google.com with SMTP id m4so15494537ljj.8;
        Mon, 18 Nov 2019 12:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RivrnPfKPJ1QjkTxDFy4+4mnpF6bQPNEwpXOnU84LBo=;
        b=iMIcUz/V15iBFRh5EoTXSUl6GOXqIKU6gCU6NxvhnpUqkX19Nx5FkiBzUdGS71xdBt
         LsUvGX/njNSt534oUI9MeY+A7GffrnfaLhl3HfVfMXs0EN1YwRtdIv33aDA1rSK1JN5T
         AnlwF6UrRBQhG4RE0JW+5EH8HlzCdRJ34ZmCD3X0FSpOX5AvQeslSI7D+l6bRQH4/NBg
         9+4n/efyUHWxpsu/EHDXckvxlNEdG4yMhGly4XlHL8ucp7JDedCzY2VzaUuneJHrFEce
         /WQ4C+p5ep2aimUwhH2owSGiO0y59fW/MbskFtGGlqLC0qrNKgTbrhrZJCfmPt47vQVh
         gpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RivrnPfKPJ1QjkTxDFy4+4mnpF6bQPNEwpXOnU84LBo=;
        b=mIBkKIh4spFFOxv3XPPL/nPRVSw+/3rAibZSLAcw93s5wlifaAuhb2T3UgVqatVuGs
         zkjUtbadMmxSiNFshSC8yfonHzEM/41ucMrgwxAl4LThhQ4pyeYmQntGYFCBXXB7Up+P
         9qDx5hL9AERKv2fMnQLj5cKIQAhq2MYUd15ZqKmURmQG/BvzfB9s3eBhy6cuqU57aqzU
         6nRt6lA/66oGPHfhFjvT1ADfXux9FVSvoE2sJozQFGG82+9TEMGdipakNC29GfPAOg9k
         NdqXOMBYpWJNcmbgZ3CJ1IxK+Bis/k2/d0nnf0XHjTZ7wsTjPTjJTYVottbcFbwXlWyO
         RdmQ==
X-Gm-Message-State: APjAAAVkUjSc1ztNwGPMwWejX7c4tsQ+jYfmgQLxuLjJ0XJhQRZGBC4i
        fLvNLtYNRwcWD+slVluaTq0=
X-Google-Smtp-Source: APXvYqxN2fEW1G50B88GZs16ah4/AIE0PFaf5KjnCo7R/1WTHrNNfwDpOyxCG1M6gA57deEBF5n2yA==
X-Received: by 2002:a2e:7016:: with SMTP id l22mr880467ljc.227.1574107547802;
        Mon, 18 Nov 2019 12:05:47 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j23sm9166942lji.41.2019.11.18.12.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 12:05:47 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 17/29] memory: tegra20-emc: Use devm_platform_ioremap_resource
Date:   Mon, 18 Nov 2019 23:02:35 +0300
Message-Id: <20191118200247.3567-18-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118200247.3567-1-digetx@gmail.com>
References: <20191118200247.3567-1-digetx@gmail.com>
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
index 1b23b1c34476..d2efd0c658c0 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -482,7 +482,6 @@ static int tegra_emc_probe(struct platform_device *pdev)
 {
 	struct device_node *np;
 	struct tegra_emc *emc;
-	struct resource *res;
 	int irq, err;
 
 	/* driver has nothing to do in a case of memory timing absence */
@@ -518,8 +517,7 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	emc->regs = devm_ioremap_resource(&pdev->dev, res);
+	emc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(emc->regs))
 		return PTR_ERR(emc->regs);
 
-- 
2.23.0

