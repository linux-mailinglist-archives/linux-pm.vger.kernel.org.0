Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4A3128F87
	for <lists+linux-pm@lfdr.de>; Sun, 22 Dec 2019 19:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfLVSuj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Dec 2019 13:50:39 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42610 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfLVSui (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Dec 2019 13:50:38 -0500
Received: by mail-pg1-f193.google.com with SMTP id s64so7691303pgb.9;
        Sun, 22 Dec 2019 10:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1MMK/7Lq6Q5MHtrU9nSWhUsHgp2FaIobPnqB6i1bmvU=;
        b=bnPRKiD/QwgUAYoz9VJpDVZ/p49jbueKzMRH23UoBCumqWMJaoMPQ6dZKsx2LUpLwd
         6qLyEJnGymgKxrVXAQeUZyzLjfPstF428bDfW7u4w83ytM7jXae42VT7aKfH8v9Ojho9
         ZSeJZpy8feXZePbc8zB0MwLGIxxFHWStinLBTA8nmHI456Nx8CLH5QDFlb6qaKkxsi/t
         Ik/qjSa8zXDnH7xdgx+rQp5xifmJLeqiEKxY/Lg7e7u82xnxV7U9847OOQQ0ks/JX05+
         5WxkfOP9ggtKlWEpQ4xuDMToMznSBf61l3CgigFqEoUnTL4tC7tWGNmrbXdOGihgMBOJ
         kJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1MMK/7Lq6Q5MHtrU9nSWhUsHgp2FaIobPnqB6i1bmvU=;
        b=RR/L2BCKk6FmmJam92YFG00oIAClCtloxxPF2mpUA0qANMlwAdXrhdxZZ6di76BW30
         QY5E+j4rW98e8wlHo+d45MJ7mVoAVG46j8bPvJX2kv+VMlXGpBbt73bfqJvtVDjVQOOz
         IimUa50HDgxiDZx/+4jB7VRbAXYqQjy9WA8qLLponoM6acG6DJmOjKYLfhn9DhVXddTD
         UK1cZkiMnJf/rIIJm9E6WxOcqyEB7JTl4IBVSkGqA9lVXSM0ti3l88wjWYAIHmCKVS3M
         74hA2IZ9q4zWxZJNMBYDbfFyKInflmqbI9+nPB5vCOFSejFaP/uEin/Qj/Xhtcs6oGg7
         aJyA==
X-Gm-Message-State: APjAAAW4P81dYvVWj1lXeYIl9clVh8VC3q4JT9r/zErEOv/Jqma3hZM4
        jGhhCpMDAF5Vr/MDavqBWzc=
X-Google-Smtp-Source: APXvYqylTRiXM3UuNPaW1PQbCJGvvGrSq2F3X2MYO9m7QdlL5O965z+77yHko+WYYeaRM/Y4Tq4vxQ==
X-Received: by 2002:a65:4381:: with SMTP id m1mr27847656pgp.68.1577040637744;
        Sun, 22 Dec 2019 10:50:37 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id t63sm21401643pfb.70.2019.12.22.10.50.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Dec 2019 10:50:37 -0800 (PST)
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
Subject: [PATCH 1/9] memory: emif: convert to devm_platform_ioremap_resource
Date:   Sun, 22 Dec 2019 18:50:26 +0000
Message-Id: <20191222185034.4665-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/memory/emif.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index 9d9127bf2a59..9a8463716a54 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -1537,7 +1537,6 @@ static struct emif_data *__init_or_module get_device_details(
 static int __init_or_module emif_probe(struct platform_device *pdev)
 {
 	struct emif_data	*emif;
-	struct resource		*res;
 	int			irq;
 
 	if (pdev->dev.of_node)
@@ -1557,8 +1556,7 @@ static int __init_or_module emif_probe(struct platform_device *pdev)
 	emif->dev = &pdev->dev;
 	platform_set_drvdata(pdev, emif);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	emif->base = devm_ioremap_resource(emif->dev, res);
+	emif->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(emif->base))
 		goto error;
 
-- 
2.17.1

