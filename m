Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99C8F128F8E
	for <lists+linux-pm@lfdr.de>; Sun, 22 Dec 2019 19:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfLVSup (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Dec 2019 13:50:45 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43695 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfLVSun (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Dec 2019 13:50:43 -0500
Received: by mail-pf1-f195.google.com with SMTP id x6so6994125pfo.10;
        Sun, 22 Dec 2019 10:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T2D+rZhLHzhPfVvf+7jno9xAtOV3Jp4ift9l+qrE9Ys=;
        b=LkGP531X5gDnvg3YLvStNo2Anp2FTAWZs+KrmtshWJS51Ttx9jLOMBVt48E3uoyh/2
         4EeIz2hZfntIkS3VG766gehaapy++8prA0MiOdE8pZ3HF4v+ys/0qXzGuO+o7xhMABKb
         OBhOFDhYKscNgmBcpvmzxK5wJEO2gNcqQSDeDul6y7a7IHcTM9U6bg85ZwL96SD0BC/W
         e6U64/iA6ZLdu0HcpKcFCyh+zUUfzNJHo6NORfFAIuY7LVTDbh9hpiowx0TPltMIjq9G
         +WzelQC+/Y2ht+i2RdnVapYbeiEB8LQL5GTbRbJ7WlEvIP4Kuk2tozIffHXzWm9RAvW3
         U3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T2D+rZhLHzhPfVvf+7jno9xAtOV3Jp4ift9l+qrE9Ys=;
        b=E5x8DClDKC8Bbqx1MON5Cj4W9ocE38CmJw+9lNU32TFSiT57rmlHAb4Ud/NQCHVT0N
         GzB7UTlAbLteIVDr0HUgLpLHOTK4Jd2RTH+qEHiOpW+jfostTeCu6neQidzLLHu4MvIt
         hzqI3BrVE5G2mpVRdE1NCnmD03+yYWfsPpkqJYKSCOq7fDFzjvVbTA6oB7es4osEqu7r
         DSsgiDS4U97Uqkyda1C/331qSyX3jq1B5cknfVVm5autWAZgVzFYzLpFfGCi0CDkuXDO
         Y1G5TPDfRGkpIvDXGQKGqjGhGQg1r7n70nXZlzrQZlp0BfnyMWGbXfMK4kE+NrrmjdRr
         qOwQ==
X-Gm-Message-State: APjAAAUm3MPSOgNuVoX2G2wredQIupYvGG6ZIxrQXX/8tc0SOr3IMIrG
        QoZqueCGWVsr8IOPqspNtiY=
X-Google-Smtp-Source: APXvYqx7+WwBdDmKMRn7IPzVdGaGjqVOSqHcY5smgx72jF1ROSO1rTBtd04VYHH+mMeVbGzx5CwrWw==
X-Received: by 2002:a62:1944:: with SMTP id 65mr29356374pfz.151.1577040642355;
        Sun, 22 Dec 2019 10:50:42 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id e4sm10449812pfa.44.2019.12.22.10.50.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Dec 2019 10:50:41 -0800 (PST)
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
Subject: [PATCH 3/9] memory: mvebu-devbus: convert to devm_platform_ioremap_resource
Date:   Sun, 22 Dec 2019 18:50:28 +0000
Message-Id: <20191222185034.4665-3-tiny.windzz@gmail.com>
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
 drivers/memory/mvebu-devbus.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/memory/mvebu-devbus.c b/drivers/memory/mvebu-devbus.c
index 095f8a3b2cfc..886aea587276 100644
--- a/drivers/memory/mvebu-devbus.c
+++ b/drivers/memory/mvebu-devbus.c
@@ -267,7 +267,6 @@ static int mvebu_devbus_probe(struct platform_device *pdev)
 	struct devbus_read_params r;
 	struct devbus_write_params w;
 	struct devbus *devbus;
-	struct resource *res;
 	struct clk *clk;
 	unsigned long rate;
 	int err;
@@ -277,8 +276,7 @@ static int mvebu_devbus_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	devbus->dev = dev;
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	devbus->base = devm_ioremap_resource(&pdev->dev, res);
+	devbus->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(devbus->base))
 		return PTR_ERR(devbus->base);
 
-- 
2.17.1

