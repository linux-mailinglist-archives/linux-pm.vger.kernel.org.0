Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E932CCA82
	for <lists+linux-pm@lfdr.de>; Thu,  3 Dec 2020 00:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgLBX2I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Dec 2020 18:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgLBX2I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2020 18:28:08 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE58EC0617A7
        for <linux-pm@vger.kernel.org>; Wed,  2 Dec 2020 15:27:27 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id d5so129705qtn.0
        for <linux-pm@vger.kernel.org>; Wed, 02 Dec 2020 15:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JBsG2gqms6k1/NKruMGhQYLKhSpaMmXTIrcWtGyhJEE=;
        b=BM+6pEuL9dxl/Vf4Pa0yU6Af03e9RLkNMaZrzLUITPfVIDJHV9ooHg67uYgH88reOY
         +lm5Afna12VVfi0o/AFS+3PsRqe+kWm9mA/SUKp1inonnbfNTiKrFL/NeYYg3qWS9B7w
         PVrdGODPczNuk/XCeE/EiGeUtiHNeNjKT9SaA4srACJ90QzsmfeA839AXkpxPxPZJUnQ
         8dAR6jCsmR86AowScd9USvRNRx4daJVmIovT/ZjS9Hd1EbMncxoVqWr+mJLaeiD3XNnj
         xiEpVTo99edPcQnswRSLYwWix3nL5srVHqu5MtLq5FtW4hHpUf4KmM+TfNmRpDnQgXby
         5k7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JBsG2gqms6k1/NKruMGhQYLKhSpaMmXTIrcWtGyhJEE=;
        b=eG0nbOZuOFwEm6qm0i6eVxLZN6MhlFZgids02RsycybsTPU3ZcS0j94VSDyi6lZdbP
         dJ1rHtVy7zLAtIV4A7CrTtIPyq2r8EAfATMv0qLtwFHeeYFr6PWZYSraWmAc5fwOjlhd
         kwSaD3QsJ/ldJlTASn2u8lNdGKSPY9mUzNE5b3WGRUyYwPeRCtBPwxjeVgl54+FYqypg
         bmC6Tx5w7VwTywdBpCtyGNSuAiRXbVwgtWULtZdc5EQg+W8g4HrNQRKNrWmdHjmB1o9k
         zjaO4GOcxRhd9KareeeD0lPkkGzyqFhgzhJSPJbhE2RKArvtbKqlUbCSPLiL5UgC3DQ2
         1wDg==
X-Gm-Message-State: AOAM532bHLwqWmHKKArvdVpuoBVUjOr03fWaI7BkQuFxAHox254Cvv72
        1tlJ1gi0zXWtQINJs2s3MZuyn/jr0NfQEg==
X-Google-Smtp-Source: ABdhPJwjGlJR1SQdLy9GujC3EcKIPFsZ/YyKqkVApF3htyQt9me7g7K/+gMUB68isxc6x02JtzTBzA==
X-Received: by 2002:aed:2393:: with SMTP id j19mr598475qtc.23.1606951647132;
        Wed, 02 Dec 2020 15:27:27 -0800 (PST)
Received: from localhost.localdomain ([177.194.72.74])
        by smtp.gmail.com with ESMTPSA id u15sm145079qkj.122.2020.12.02.15.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 15:27:26 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     Anson.Huang@nxp.com, linux-pm@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] thermal: imx8mm: Disable the clock on probe failure
Date:   Wed,  2 Dec 2020 20:24:48 -0300
Message-Id: <20201202232448.2692-2-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201202232448.2692-1-festevam@gmail.com>
References: <20201202232448.2692-1-festevam@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Prior to returning an error in probe, disable the previously
enabled clock.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/thermal/imx8mm_thermal.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index ce7cb6452c52..7442e013738f 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -170,7 +170,7 @@ static int imx8mm_tmu_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"failed to register thermal zone sensor[%d]: %d\n",
 				i, ret);
-			return ret;
+			goto disable_clk;
 		}
 		tmu->sensors[i].hw_id = i;
 	}
@@ -185,6 +185,10 @@ static int imx8mm_tmu_probe(struct platform_device *pdev)
 	imx8mm_tmu_enable(tmu, true);
 
 	return 0;
+
+disable_clk:
+	clk_disable_unprepare(tmu->clk);
+	return ret;
 }
 
 static int imx8mm_tmu_remove(struct platform_device *pdev)
-- 
2.17.1

