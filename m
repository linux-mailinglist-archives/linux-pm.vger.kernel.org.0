Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5912C37B95E
	for <lists+linux-pm@lfdr.de>; Wed, 12 May 2021 11:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhELJj1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 May 2021 05:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhELJj1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 May 2021 05:39:27 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802CFC061574;
        Wed, 12 May 2021 02:38:19 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id na14-20020a17090b4c0eb029015cbbd5f028so104296pjb.1;
        Wed, 12 May 2021 02:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eyLjfwsAS8cJTCqeOUuFuNCBDqhlaYy7krVsSe/n+GY=;
        b=YJCj5pbEbEZyB+a+1xQ0TklvrTa1Lfpf0Cnf0x0opW71AKtrJlhNd9tGYqs/kp6Bo4
         7rzGQkw7OeqcyKILQiGlE/sI9TiqkNIG3Vc362+/t0Y32hGRGDFnnB1qvzEaaJig6cYd
         0E9xaaydcwn1xJ8RWXIphKKNPB/hW4xP5lT9zhTbnN37+F92xDL2NrUqrKpfCv1s48YF
         flHopZ9B/6KYAbeDcjLv3ulwTK36Zrp46WsN87sVD1t+W9lAel1Obi3sBUueiLyGbQAK
         dqpt5B9VCf/olnL910YS3azWoAyVUGEF6Isme1phEYgT+uXr2uemzRwB/ZJ1lRB4tsQ1
         g1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eyLjfwsAS8cJTCqeOUuFuNCBDqhlaYy7krVsSe/n+GY=;
        b=qeDTLSKSaWYDSthh0zTUpWijB2k+jbRyTbPXA7lGjRA8uYE9986XjmiD4dzx9OtEWJ
         DgGrNYGKYnR/Wina9Yi5838bDB7wRkl/hP1+0ZGirSW7IhHgrMLWIsHk3x/WN9dzwjqW
         9PGoptTPuaCRYCGuSQyd6aUcJ2N4B37aD0Uz2ZqdcLFJigK6DJFkbEW9xqYXrBHPzLjE
         ynvB3kX7CCvEEviYE/Y7iL+3ew4Eha4TrKawEmTCDB3DMLgxtdg464rUCNnXL8D5sIsr
         zrLTi0PctjATKejw1m+idp+V1CVBomsvmHdLhfORAeMy6N2+E6scjIUsdN+6APSE/gwR
         OY2Q==
X-Gm-Message-State: AOAM531NZQeikzeMzDjN0zzGOA3JkXXOWPLux/M77N/EZX/DiWeJMDTc
        FjFW0k3I8Y9zKLf66p5lZbuOHEt0h1M=
X-Google-Smtp-Source: ABdhPJw0vugVvS9YPQpAaV93L7ItPcBA/pG55aTiX/YlQB+X3MHgWeHIfR5GOZAvdiuCkF3O7I8CJA==
X-Received: by 2002:a17:90a:d18b:: with SMTP id fu11mr38797138pjb.129.1620812299201;
        Wed, 12 May 2021 02:38:19 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id w123sm15109330pfb.109.2021.05.12.02.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 02:38:18 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH] thermal: sprd: Add missing MODULE_DEVICE_TABLE
Date:   Wed, 12 May 2021 17:37:52 +0800
Message-Id: <20210512093752.243168-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

MODULE_DEVICE_TABLE is used to extract the device information out of the
driver and builds a table when being compiled. If using this macro,
kernel can find the driver if available when the device is plugged in,
and then loads that driver and initializes the device.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/thermal/sprd_thermal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
index 3682edb2f466..fe06cccf14b3 100644
--- a/drivers/thermal/sprd_thermal.c
+++ b/drivers/thermal/sprd_thermal.c
@@ -532,6 +532,7 @@ static const struct of_device_id sprd_thermal_of_match[] = {
 	{ .compatible = "sprd,ums512-thermal", .data = &ums512_data },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, sprd_thermal_of_match);
 
 static const struct dev_pm_ops sprd_thermal_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(sprd_thm_suspend, sprd_thm_resume)
-- 
2.25.1

