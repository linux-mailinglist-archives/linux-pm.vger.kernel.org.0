Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6E58100CB4
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 21:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfKRUGc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 15:06:32 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39283 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbfKRUFy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 15:05:54 -0500
Received: by mail-lf1-f68.google.com with SMTP id f18so2543911lfj.6;
        Mon, 18 Nov 2019 12:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NO2qXzr2h8wC9JH342o1HHthsrMIk1iko3w9VcXdH5A=;
        b=mk2vCgHOubJT2C6+euhjGFu5E1FlvsunytIGSJqQKUfX7RWZhKV1M/PERUjpJAWtaM
         Sn1VIRt4W6UHZ1M8SmB0ucwEdYiKRYmgxpuokjYPMRElB4RMaYibtSdKhIDCDPO8XhVD
         Hi8CD53RhNJjDRD3ko0eQFHA2oj5S1Y9kPHAAnjGmuZ/JGZh8Klbwzg4VWoz4bJHYI87
         5EkMCsJSl7nkcW31ph0zvafPN0GoZF1KQInaSJHyjm2NtJb08wKihW2lumhfhYjPi3TR
         GKifNd1Q9YDCpSyZ8fSrIbpOU3GgVHXnckXlinOeu6A1HnT7w+tmUzdy29FPlDt2MTI1
         AyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NO2qXzr2h8wC9JH342o1HHthsrMIk1iko3w9VcXdH5A=;
        b=JILqrOsBdOkdyhx7pdUXQlj91kdmX/Cgt0aVWMLe9LAwywe1FSjTO1og5I7ltVpdmL
         XKSwEmk1f2/6G/JCSavlvM3GbKWhENjGlZpO8NvL/pMU3TlK9lxAMrTSEbiE1Z3Svuhm
         v2G/fxiJWa4KzPW3u5xUukRf+XmoCSHNeK1IJEtxAayx+B2A7pM7HPl+H3cxspP9Gi/4
         DEKF7Drl6J3YkLyF2ZXcVSY07Lzi1OIOyX8JtfQ3unTyXhyu8kLb2/i9OCEW8bdbhXDI
         zb7YZWO+ScNUD5wgGcJqy37jICo5F6vA3XX4AeTixqwUjNjKjEh125B29LQsFYtViDuO
         S2SA==
X-Gm-Message-State: APjAAAXFsjE1EPbk1wDz8G1HMU7yTCSFNFfP2AYL30CDnZsX4g4MtyT+
        VMfrpLi4vnNMnqBOzcqXp6I=
X-Google-Smtp-Source: APXvYqyFdMdWU7w0LB1BfkSwWHQ03FHjU/9FzYlK7b99IzlqfyPICfS0Qp8R9GxcK14o2DQzVM7iLg==
X-Received: by 2002:a19:6d12:: with SMTP id i18mr851484lfc.153.1574107552616;
        Mon, 18 Nov 2019 12:05:52 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j23sm9166942lji.41.2019.11.18.12.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 12:05:52 -0800 (PST)
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
Subject: [PATCH v1 22/29] memory: tegra124-emc: Use devm_platform_ioremap_resource
Date:   Mon, 18 Nov 2019 23:02:40 +0300
Message-Id: <20191118200247.3567-23-digetx@gmail.com>
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
 drivers/memory/tegra/tegra124-emc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/memory/tegra/tegra124-emc.c b/drivers/memory/tegra/tegra124-emc.c
index 464f0ceaee63..2c73260654ba 100644
--- a/drivers/memory/tegra/tegra124-emc.c
+++ b/drivers/memory/tegra/tegra124-emc.c
@@ -1085,7 +1085,6 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	struct platform_device *mc;
 	struct device_node *np;
 	struct tegra_emc *emc;
-	struct resource *res;
 	u32 ram_code;
 	int err;
 
@@ -1095,8 +1094,7 @@ static int tegra_emc_probe(struct platform_device *pdev)
 
 	emc->dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	emc->regs = devm_ioremap_resource(&pdev->dev, res);
+	emc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(emc->regs))
 		return PTR_ERR(emc->regs);
 
-- 
2.23.0

