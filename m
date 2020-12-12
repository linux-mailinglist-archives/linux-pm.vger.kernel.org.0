Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AC12D8618
	for <lists+linux-pm@lfdr.de>; Sat, 12 Dec 2020 11:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438853AbgLLK6L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 12 Dec 2020 05:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438856AbgLLK6F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Dec 2020 05:58:05 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41351C061794
        for <linux-pm@vger.kernel.org>; Sat, 12 Dec 2020 02:57:25 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id w13so17965649lfd.5
        for <linux-pm@vger.kernel.org>; Sat, 12 Dec 2020 02:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U9ki1Yt4gjIfiYkS0P/4SKvIacQ9wKk9cuDvKvw5s1A=;
        b=V1cRNEcv/63CSwMTY5HdzFgTOXrLNfnAD6jxwYDIZgdQ6BaGd0ECcNDU2dyIthVkhZ
         vxCoUz5zOq4S83Uz/D2OD/x+XDF34PRmN7zvFMvPt5ZczVUPabamei65vuIQxvz/U2sh
         vRu4tfjLqSE8arKhxalPBHcXRWBVQU1uvyRwOw5qDOegVUI4Xi6RC+gqfmwgh3xChGRU
         3oCzsAp5hafSsEk4GkyLaLFqbPux/+ChNU2jdGqbQykPwFfnqsQt8xXduLWv9aSi8ABw
         qWHrXeskl60dumiBGuefooFu3V3yN1NFl7CmJ5WLPSGZDk6asQJUmJe543Sf+67tj6Yu
         6Hgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U9ki1Yt4gjIfiYkS0P/4SKvIacQ9wKk9cuDvKvw5s1A=;
        b=IJX9xJ0YhToZwJsAbhwpTeinB8O4HJrBCcifnuXcKvixeWhSaXLqNJml8Q4RbBwIYr
         +cafh7p+XoPjh2fbhp6JKhmVLQH2Om7T6dydi1c186/SO+QwFjgbhes4lmgIy1RQs5up
         AzlUIPpiiCUjBRDjx5DC2fRUVFhLGETOVfdu1X/1UUjQGhyolaCc9nExWsMh1on69iiJ
         nwdhSxPbv+qnl2ljWMn+S/Uw/GNnQxQDUx4L7vxPNTUqYIpF55hTJ6Kurg3FOKABYluz
         WbpNy2q4mgq9j+El3vLq0s9mKsusX3cZCb76aFQTxTMm8nSWYf+mDilbzuj96+CSn0y+
         SgJQ==
X-Gm-Message-State: AOAM530wRotwLxvevoD4AOYmydqePCWqwuwkNAP7zFlIoUNRdz1N4PHF
        xxknplxp7kGKUed8UYNcard87g==
X-Google-Smtp-Source: ABdhPJzOc53995CcYu1QqnWPKmjfxMgc48xyn8F4VfUr5qXiCDk0KptY7BG9SVbo5Yc4RUPYTxz/Lg==
X-Received: by 2002:a05:651c:200a:: with SMTP id s10mr6808399ljo.492.1607770643811;
        Sat, 12 Dec 2020 02:57:23 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id j2sm490674lfe.213.2020.12.12.02.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Dec 2020 02:57:23 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/5] power: supply: ab8500_charger: Oneshot threaded IRQs
Date:   Sat, 12 Dec 2020 11:57:10 +0100
Message-Id: <20201212105712.2727842-4-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201212105712.2727842-1-linus.walleij@linaro.org>
References: <20201212105712.2727842-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Make sure the threaded IRQs requested by the charger are
flagged as "oneshot". Usually this is what you want, and
since the interrupts are shared with the USB phy on the
AB8500 we will get a conflict like this if we don't,
since the phy request them threaded oneshot:

genirq: Flags mismatch irq 83. 00004084 (USB_LINK_STATUS
  vs. 00006084 (usb-link-status)
ab8500-charger ab8500-charger.0: failed to request
  USB_LINK_STATUS IRQ 83: -16

Cc: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 47f1ce1012f4..d4b7bd68451b 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3596,7 +3596,7 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 		}
 
 		ret = request_threaded_irq(irq, NULL, ab8500_charger_irq[i].isr,
-			IRQF_SHARED | IRQF_NO_SUSPEND,
+			IRQF_SHARED | IRQF_NO_SUSPEND | IRQF_ONESHOT,
 			ab8500_charger_irq[i].name, di);
 
 		if (ret != 0) {
-- 
2.26.2

