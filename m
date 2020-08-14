Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978BE24425D
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 02:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgHNAHL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 20:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgHNAHK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 20:07:10 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54831C061757;
        Thu, 13 Aug 2020 17:07:10 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 185so8090046ljj.7;
        Thu, 13 Aug 2020 17:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PWeHmMe/ryLDZxWCOth5wddRP8FFmI3RUHaspfVKI8Y=;
        b=Zz0wAqtSlkr9O05GGrzY90VWvI1zhGc7XuNqBbwNY3C7PZ0D8SIXKFA60E7vyPXamM
         DW1n/aSkt3IIsi25DO1aAbyfbgUs+nhyfM22ZdxEPyeIITiwzqpMSapNyXAG67i6Fiuo
         chxoyipOD21Y7FMjEMTm/DdRn7R8dTesfuKeFEAS05VTQ3DzBZDHZ6h7swcCozHG4sUD
         ZH/YjSTjGIRJk6bpar1X0nxxNYw0Qj5py4llbRnAMf5rFBaxoGq4XenpiLMTovcqKJVH
         prEfkJeZIOUEd5sS1RAwWMvY3mrnfqdpnl7B0LWeEXNk027jps5/sTLRZXs0Q9sN9LDW
         nidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PWeHmMe/ryLDZxWCOth5wddRP8FFmI3RUHaspfVKI8Y=;
        b=oLCzBp8/R9WBgvBGz31eFXAqmMOHss10H2bB3dR5Vh7kTCPXa1xDL1D41lUD6atjqR
         huBA5RJWdUn4izkISNY3bw8prfUalblLXwdql83gcJC1TDo5dyOq6tUst4p8oPKQN3nC
         q3GGdrN8o6aw6P/39/YzPuTwSLTIA0Nzb48OgAiYQ/E+yHE3kPE6gSDOyOSTZBW6n+nf
         SYgn6zEKZzU+aXJC7ifXLDkPXtyGgShdJi+5MXldglPeTBhFReOPXwT8RZBG+1BvaXP9
         jaQETGOYEvjn1EelhUhwDEBm2+6hwFjjnBNb9hPFDERDHSnK1j0v0U+hptnlKU9BRtBP
         qB+w==
X-Gm-Message-State: AOAM530+gB6po7ljGT+9UF8pbYVSVFWEFK8dUZlCOxzbvJTf5XysYxk4
        JC7ebhLtv2jNaGif7teh/OY=
X-Google-Smtp-Source: ABdhPJyUPne+A9YG43mcnvypj+/+sED/3AV1gDnow59UIVAb7F2oJ5XCQ4ocDI5zrbmwimksMrj8sg==
X-Received: by 2002:a2e:7615:: with SMTP id r21mr87723ljc.371.1597363628835;
        Thu, 13 Aug 2020 17:07:08 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id c17sm1504450lfr.23.2020.08.13.17.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 17:07:08 -0700 (PDT)
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
Subject: [PATCH v5 07/36] memory: tegra124-emc: Use devm_platform_ioremap_resource
Date:   Fri, 14 Aug 2020 03:05:52 +0300
Message-Id: <20200814000621.8415-8-digetx@gmail.com>
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
 drivers/memory/tegra/tegra124-emc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/memory/tegra/tegra124-emc.c b/drivers/memory/tegra/tegra124-emc.c
index 93e9835e9761..8d7fc3fb00bb 100644
--- a/drivers/memory/tegra/tegra124-emc.c
+++ b/drivers/memory/tegra/tegra124-emc.c
@@ -1194,7 +1194,6 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	struct platform_device *mc;
 	struct device_node *np;
 	struct tegra_emc *emc;
-	struct resource *res;
 	u32 ram_code;
 	int err;
 
@@ -1204,8 +1203,7 @@ static int tegra_emc_probe(struct platform_device *pdev)
 
 	emc->dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	emc->regs = devm_ioremap_resource(&pdev->dev, res);
+	emc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(emc->regs))
 		return PTR_ERR(emc->regs);
 
-- 
2.27.0

