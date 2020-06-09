Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9301F3BCA
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 15:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbgFINQ3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 09:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbgFINPC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 09:15:02 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2497EC08C5C6;
        Tue,  9 Jun 2020 06:15:02 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id r125so12407678lff.13;
        Tue, 09 Jun 2020 06:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lfxRXNNcGA+yEfa6dSr/5fCeUu1kfzCJExeudjlYPeU=;
        b=UU3p0NwtBQlRzm2C4CYjsNrMOlsptUWTED3JTJs0fFLfhVIXey/OwuvRBg0Ws2LFEm
         O7I4o0VUj4F7KwAVSVbDDr7WWmZaxbpe24mcbXfe1PhGBkDVc24GJl1Ct39fGVSf/knZ
         uK7tHBIxwJGbjolLd5w29uynxTLAuxoolMxqcOuJr1nUqPEFKwvageu6h1SdSR6JdHq7
         hLhGhWw7igdfPk6CPLiq5zzK2D8e/SV2WmpkxRmqKCSpH8tCPu5CI0I6NBsFOHxOGvnT
         nDdNh4VT8GmhOanIJJzm9VoSLO+R93RJo+pa8igSUA1sKeMMCB44n2e2h6+t5jtUkIst
         Y0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lfxRXNNcGA+yEfa6dSr/5fCeUu1kfzCJExeudjlYPeU=;
        b=OQ4nq4MWr/F96N0qorIT3SGaPwgDC/c+MPY87hWXlCC/iv7DsNHpgzLvFlNlfZDkU9
         VbA6dBUpPme2tHuS+OsqBYxYK+nYNfswv9dVygZuXpX4Ww7pI6zFuvisd7j1dNe8eyjb
         XdU2xDEwZPcgFlaIVgwweuhrxY2Q/bFXlhdt0Snx/Y8UiyWL02IG1OFHtQs1qYtyYFuE
         eWHJbTRKZP5uQrD72hrCXlH4NPxF8lRcEtArkHnJZ6+D0E4UAgHKHABy67sx0/imurrJ
         LD2whCAj4gp8CJsnSWxP51Mb1NWsxRWBuGkWiHRqBIy2jsXyQPNQOuEgs2o+DiHIHQt+
         ALFA==
X-Gm-Message-State: AOAM533nJetDxJqonyjUp4VYG1d1P7YH2sIhfIvPImHlH10y9HjtHW6s
        djOlHFCQKRY6ynQDTMJxLSI=
X-Google-Smtp-Source: ABdhPJx/F8fHSj8IPfxRksHOX6Wh3jaEN6hkcvFDfpBoSYwe9VBvwIsqU4aVdIjge+KwKrM50R0YWA==
X-Received: by 2002:a05:6512:60f:: with SMTP id b15mr15311465lfe.159.1591708500655;
        Tue, 09 Jun 2020 06:15:00 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id l22sm4323522lji.120.2020.06.09.06.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:15:00 -0700 (PDT)
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
Subject: [PATCH v4 29/37] memory: tegra20-emc: Use devm_platform_ioremap_resource
Date:   Tue,  9 Jun 2020 16:13:56 +0300
Message-Id: <20200609131404.17523-30-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200609131404.17523-1-digetx@gmail.com>
References: <20200609131404.17523-1-digetx@gmail.com>
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
index 2e310c51c599..507065c2f452 100644
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

