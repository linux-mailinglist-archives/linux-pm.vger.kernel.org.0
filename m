Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 006B2128F7A
	for <lists+linux-pm@lfdr.de>; Sun, 22 Dec 2019 19:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfLVSut (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Dec 2019 13:50:49 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46289 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfLVSur (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Dec 2019 13:50:47 -0500
Received: by mail-pg1-f193.google.com with SMTP id z124so7688992pgb.13;
        Sun, 22 Dec 2019 10:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jPs8btFmLJCvfF7hm3VTorkXTs5PUOJURx/gZ3fO9eo=;
        b=U9wWDWIi3n8EDeWs3WHwGy7eoXyLGsrOlw/hUKX+ISHOS3xn5Dad3I37IpGKVcYmpX
         c7ssXhvzL+NYvVCdQBGVuc50r3MblDmMPwNUscnf9MONE6923+V6+iIWt1bajkdgp0y9
         RKw8mWWzpDFxm6SCqJ9rApfBvxXwgdNBdG/M/2FR2KOsCmKyZPm+Ud+ZyGN7hbvJkTqe
         x3teVL8N7hNg6tKSDWuiLMPbAf/L/TBXIyBM6IBj0/DfwNpcMRvYmN+mBnER89RTEuJ+
         ffKqxUz0SFPgfauy3nPc89x2GmKowZLpaEAnJRv7PQL00t1LmCsx1YS3S906MMWlHTmU
         OFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jPs8btFmLJCvfF7hm3VTorkXTs5PUOJURx/gZ3fO9eo=;
        b=WC4d8OVwejYQNlQ4WjND6EgmZ38T+hLZ7C/pFcqV0+F/zkVBHPfvpsihhinCIoQAqP
         AtOKPYfgojrcnojLJ7YVQ1FzUgzmDs1pzNVzv+Q5dmpzedj/1oT+5pu0LjbA+4nMq+73
         AKlOlzMna5IdF+DitTa65RUqEmHzfUSAzb4+X05SOOD3hPnWGgEL4cJeeP20dgDjPd4q
         pJLPtedOcrAus0gWkl/s/1bPp71vtgTCWa32FG53Hbbj/CKMineamlRYjSyOGDwYba+I
         kjAGhWGjSbKMQSyYqeOAUmu2IIP7flmiZvFW82hKDXxsEDHHrd4EtMPoOQHPpYtUU5KS
         XYfw==
X-Gm-Message-State: APjAAAWqvShzic38f7p2E3kkhpKd3T/F3R7awlsibyre9Sv2u+Ik88Z3
        QrgJHtKsV58DmRIdiFPHFz4=
X-Google-Smtp-Source: APXvYqy5fHyoKX5i2orUytoXPpDCOFDkYgEOajqHueKFcpqGwfh052+BcQyINUsUMtnaA5I3q4bl8g==
X-Received: by 2002:a63:780d:: with SMTP id t13mr26159519pgc.82.1577040646922;
        Sun, 22 Dec 2019 10:50:46 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id 73sm19170792pgc.13.2019.12.22.10.50.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Dec 2019 10:50:46 -0800 (PST)
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
Subject: [PATCH 6/9] memory: ti-aemif: convert to devm_platform_ioremap_resource
Date:   Sun, 22 Dec 2019 18:50:31 +0000
Message-Id: <20191222185034.4665-6-tiny.windzz@gmail.com>
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
 drivers/memory/ti-aemif.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index db526dbf71ee..6524229f634a 100644
--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -328,7 +328,6 @@ static int aemif_probe(struct platform_device *pdev)
 {
 	int i;
 	int ret = -ENODEV;
-	struct resource *res;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct device_node *child_np;
@@ -362,8 +361,7 @@ static int aemif_probe(struct platform_device *pdev)
 	else if (pdata)
 		aemif->cs_offset = pdata->cs_offset;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	aemif->base = devm_ioremap_resource(dev, res);
+	aemif->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(aemif->base)) {
 		ret = PTR_ERR(aemif->base);
 		goto error;
-- 
2.17.1

