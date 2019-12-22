Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFD23128F72
	for <lists+linux-pm@lfdr.de>; Sun, 22 Dec 2019 19:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfLVSu5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Dec 2019 13:50:57 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44635 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfLVSuv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Dec 2019 13:50:51 -0500
Received: by mail-pl1-f193.google.com with SMTP id az3so6311496plb.11;
        Sun, 22 Dec 2019 10:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=obMvYqnbW6FnclvcaTw1U7yQPLStwyHiLSMoMgJ8DMo=;
        b=RdmiiwF6babAQFWUpUGLy2DZqAwZAi8V33zgiNx7dj87h8phOlTYHtZOMDCQtXFOit
         coQqalsXFCLZlPp6YJ4THC2t7m8EEi9PnxcIXgnqBv8YojpdwQ8b1z12w3XbHM6gRe2N
         9cXHFVzTg5EsYmr3AiWsmm30sn/yrNbhfuYIlptfe1Mjzl/GJ0cPIIf7zQeTlWRApwyt
         ceX5KsTvJkHVzT/jsg270BpkQa+0B9D2w9kYdnxox243iMIwwKPCl092zGtmcZOreNl2
         ops0dZYFpd4iyt33sNOKbW/8D9fDi76pS+zAn59mN4DcCTF39VQKSGfc5uBhAnozFnSr
         F3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=obMvYqnbW6FnclvcaTw1U7yQPLStwyHiLSMoMgJ8DMo=;
        b=G8PYNmtuMvR6IFaeFdzhSdc8bErBVwYddSXJNs9sGiXm8DFWCkIpqr3X5pU4S8agP1
         jBky9OWRuIYr9C+ddhq5IYKTAlM4nARrJaddy1S6Fd0BCha08t92Mg0izesKZrv6KG6h
         7CQN5HMFQokdrlJBU3DedCDc5XyTGCWmbPGrlhrF9ZfmKQk4xxKqSNWsAxIWcYRt4OYq
         FlCOiNR7F+0krsWl8PxUujbHcSkHaOcxb9/Cty7IYngZIZWjZgOERoASiNLRa5FNmBgK
         5kN/7M7EQL2dbN0mPCgWyuAV9q1srnNCOa4jE5/D8e6uVcDHFgggo/NoRG3uRHSwgCR+
         6TxA==
X-Gm-Message-State: APjAAAUOrQ+8mwvA+9oANuSbpUlFpmm342QAwKLAVR9gEee0kd3YcPYE
        EpreUJaFfcvXs59AGN0FyS+dXIeY/no=
X-Google-Smtp-Source: APXvYqynfZtZtMfgSs1bDem4Zo+v6lSrgRDKxVTy4vingOzHr5+fBrYwncpXVgh6n1vtEUTebtVYcQ==
X-Received: by 2002:a17:902:6bc9:: with SMTP id m9mr26918356plt.260.1577040650351;
        Sun, 22 Dec 2019 10:50:50 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id x8sm21284906pfd.76.2019.12.22.10.50.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Dec 2019 10:50:49 -0800 (PST)
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
Subject: [PATCH 9/9] memory: omap-gpmc: switch to platform_get_irq
Date:   Sun, 22 Dec 2019 18:50:34 +0000
Message-Id: <20191222185034.4665-9-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191222185034.4665-1-tiny.windzz@gmail.com>
References: <20191222185034.4665-1-tiny.windzz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

platform_get_resource(pdev, IORESOURCE_IRQ) is not recommended for
requesting IRQ's resources, as they can be not ready yet. Using
platform_get_irq() instead is preferred for getting IRQ even if it
was not retrieved earlier.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/memory/omap-gpmc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index eff26c1b1394..6dd19d168f75 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -2366,13 +2366,9 @@ static int gpmc_probe(struct platform_device *pdev)
 	if (IS_ERR(gpmc_base))
 		return PTR_ERR(gpmc_base);
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "Failed to get resource: irq\n");
-		return -ENOENT;
-	}
-
-	gpmc->irq = res->start;
+	gpmc->irq = platform_get_irq(pdev, 0);
+	if (gpmc->irq < 0)
+		return gpmc->irq;
 
 	gpmc_l3_clk = devm_clk_get(&pdev->dev, "fck");
 	if (IS_ERR(gpmc_l3_clk)) {
-- 
2.17.1

