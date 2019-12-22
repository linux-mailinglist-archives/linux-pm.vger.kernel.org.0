Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 407E1128F89
	for <lists+linux-pm@lfdr.de>; Sun, 22 Dec 2019 19:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfLVSul (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Dec 2019 13:50:41 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37701 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfLVSul (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Dec 2019 13:50:41 -0500
Received: by mail-pg1-f194.google.com with SMTP id q127so7710116pga.4;
        Sun, 22 Dec 2019 10:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UYJMcCSP2xqM3DCf7A/aaQtY9AM0A3U6ItqKBHen71c=;
        b=VayjpuFUrgdgU4fvbiVH8S3vP3Kc8cakjFEBT0Zel7kuingvSZcvJD7Uqb4oH65Alc
         ux5vVXmvdS0WecQgYoOET7cvNbt8w3n/m+lts3VNk60W3ubceku2WEvbTeHqILyAHZfD
         FYAECI3LUY4btBcRcIiOCwfMlxBmnh7LY1Y9IAzQkKgX7n+5moSt17ntif6C8YlcUrcO
         fvdESi+Ykpr14f083qpPWwKRXyVarWL7WspdirdvgF040RlnSb8BGYX50Sk8ziO9u5vv
         wiPUicg9NF1+H1zBoDdNbTq9Xh1Z9oPDLK14ToGsC+Zcr+V96UBt8b/PvR/Xsnwjihko
         st4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UYJMcCSP2xqM3DCf7A/aaQtY9AM0A3U6ItqKBHen71c=;
        b=AclHhQ9W99xmCtozfEQ60VQhLzWVN2+P1rNRygSkfc7pbAblbgOssZlZjnk5CPSuLv
         +gi4uHcgtDjmGAvXIabMzSWardxws2rOl5zFnj8UX04WoHeIOdL+rX96zDGhQUkOWqAJ
         SgUlMp+DOAE/W2q7yHc1LLb+lV1LuX+RBOEHZYd6XxJImVbkxE1wmowEON34OZLsCN9S
         rEIU+vu1MFKn4U+HdHwnWKHMKYbA6g9gJAXNOhR++Knk5i47Qilmy8a4Q7xEJm6DhLO2
         LDenKOl7qWtxpiwdr0a0QoxSd1pK88qkfFXI9VszaePX4uP4Qmux02qm2O0IhJhcxi8v
         IWxg==
X-Gm-Message-State: APjAAAUIglrzaCiZgzZcGo6Sm8GICb+nG2vwA96dySGliSUdcCw/vHyL
        ioRAgc7Hf3pYQ/lIxFj+uDE=
X-Google-Smtp-Source: APXvYqyrXDL6rPmdg4u1kOSJN24AutsewRcg7DL4++UhnjYbNwRfwWeVlRtWZJBYBtLD7vHFGdAtow==
X-Received: by 2002:a63:9548:: with SMTP id t8mr26359191pgn.205.1577040640148;
        Sun, 22 Dec 2019 10:50:40 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id p17sm20557901pfn.31.2019.12.22.10.50.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Dec 2019 10:50:39 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     ssantosh@kernel.org, paul@crapouillou.net, matthias.bgg@gmail.com,
        rogerq@ti.com, tony@atomide.com, lukasz.luba@arm.com,
        kgene@kernel.org, krzk@kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, allison@lohutok.net, tglx@linutronix.de,
        yong.wu@mediatek.com, jroedel@suse.de, evgreen@chromium.org,
        rfontana@redhat.com, digetx@gmail.com, pdeschrijver@nvidia.com,
        john@phrozen.org, alexios.zavras@intel.com, sboyd@kernel.org,
        kstewart@linuxfoundation.org, info@metux.net,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 2/9] memory: jz4780_nemc: convert to devm_platform_ioremap_resource
Date:   Sun, 22 Dec 2019 18:50:27 +0000
Message-Id: <20191222185034.4665-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191222185034.4665-1-tiny.windzz@gmail.com>
References: <20191222185034.4665-1-tiny.windzz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/memory/jz4780-nemc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/memory/jz4780-nemc.c b/drivers/memory/jz4780-nemc.c
index b232ed279fc3..857a9fa5cba5 100644
--- a/drivers/memory/jz4780-nemc.c
+++ b/drivers/memory/jz4780-nemc.c
@@ -269,7 +269,6 @@ static int jz4780_nemc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct jz4780_nemc *nemc;
-	struct resource *res;
 	struct device_node *child;
 	const __be32 *prop;
 	unsigned int bank;
@@ -287,8 +286,7 @@ static int jz4780_nemc_probe(struct platform_device *pdev)
 	spin_lock_init(&nemc->lock);
 	nemc->dev = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	nemc->base = devm_ioremap_resource(dev, res);
+	nemc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(nemc->base)) {
 		dev_err(dev, "failed to get I/O memory\n");
 		return PTR_ERR(nemc->base);
-- 
2.17.1

