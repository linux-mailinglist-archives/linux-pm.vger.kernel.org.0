Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798073426CE
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 21:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhCSU02 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 16:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhCSUZ5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Mar 2021 16:25:57 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97203C06175F
        for <linux-pm@vger.kernel.org>; Fri, 19 Mar 2021 13:25:56 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id g20so6090804wmk.3
        for <linux-pm@vger.kernel.org>; Fri, 19 Mar 2021 13:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3m+0Blv5n7X4ghIz+zLSJn1A6/2kIt/8W8KDouftYUc=;
        b=nHtNjGrBJ98tS3ihrmTi9ZAEa1r1iIXPxVr2j+IakZ0huLcoROkDP5fFocCnzzcB66
         hD1z7cDwSAO+XRTUttmUuUIQgJtLnez6T8EBRL9k12z3xkHU8dVWe1WKNssTPhQI1tW9
         ZXiW/1mW2eqbOIIHluPsSoXIJSDn2rY0MBYUb1fLrg+yjWYbnTLaDpZsX/SCTdsMYvoH
         mN84hRqlYar39ex6/WuwbCxzJd5TrgI50iRYWKS0O7UrIt5ey7XRy9G53VdhMMoH/65U
         wQzsmVifk8F8dGJrzct1GVKmruTV9RAQ2FXQ1MImsMuicusn/SxM6aD6j1chOLYXySar
         SGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3m+0Blv5n7X4ghIz+zLSJn1A6/2kIt/8W8KDouftYUc=;
        b=DGcN9w4rBXn7QDX8u8wBxme9DnHUjs1tI3p8jbYFUik98MUXaWIUN3RLUakBPVcTsu
         /G7uloqfNHP1gAj2EOa14htLEZQyR/D9iDZwyFXecj+UxMWXYj6gxUMcUUgxUocF9+VY
         hDar/Q6gn5izoPFUxAJyOe3dYTPAz24kvF7PjC98ZUgMIVWhy6SppHydGgPLGij5DbHs
         urhv7eGWKplCYX48/R9lBuKZYq3jIbLwhpTxNjc0zdBE0hZI1hLD4M+RrjPLydL+knQc
         ADTk9091COjVscrOef65HE/nRijZmFF9NkuE7y1pIjzejNoj3Kz/GLccPZOW6IfU78I0
         qavg==
X-Gm-Message-State: AOAM532ZKJWbCuoE38bx8K8U8vXk4hrKuQGzh7My+bMxCc6pHxlSn9tB
        9+1qiHseqlvRVOV5A3JoVRBfvw==
X-Google-Smtp-Source: ABdhPJwZVp9QR1LumiiDbaPviiatvDCtefwYNSLA8em3zS8VOaPMNamxa8FzEra86SSF55L+Jy+4xw==
X-Received: by 2002:a1c:f701:: with SMTP id v1mr3194099wmh.69.1616185555197;
        Fri, 19 Mar 2021 13:25:55 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:ddd7:1eb:a66:7a85])
        by smtp.gmail.com with ESMTPSA id b17sm9423638wrt.17.2021.03.19.13.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 13:25:54 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        linux-pm@vger.kernel.org (open list:THERMAL/CPU_COOLING),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thermal/drivers/cpuidle_cooling: Fix use after error
Date:   Fri, 19 Mar 2021 21:25:22 +0100
Message-Id: <20210319202522.891061-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YFMpUDNGIiLOzr0/@mwanda>
References: <YFMpUDNGIiLOzr0/@mwanda>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When the function successfully finishes it logs an information about
the registration of the cooling device and use its name to build the
message. Unfortunately it was freed right before:

drivers/thermal/cpuidle_cooling.c:218 __cpuidle_cooling_register()
	warn: 'name' was already freed.

Fix this by freeing after the message happened.

Fixes: 6fd1b186d900 ("thermal/drivers/cpuidle_cooling: Use device name instead of auto-numbering")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/cpuidle_cooling.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/cpuidle_cooling.c b/drivers/thermal/cpuidle_cooling.c
index f32976163bad..4f41102e8b16 100644
--- a/drivers/thermal/cpuidle_cooling.c
+++ b/drivers/thermal/cpuidle_cooling.c
@@ -208,18 +208,20 @@ static int __cpuidle_cooling_register(struct device_node *np,
 
 	cdev = thermal_of_cooling_device_register(np, name, idle_cdev,
 						  &cpuidle_cooling_ops);
-	kfree(name);
-
 	if (IS_ERR(cdev)) {
 		ret = PTR_ERR(cdev);
-		goto out_unregister;
+		goto out_kfree_name;
 	}
 
 	pr_debug("%s: Idle injection set with idle duration=%u, latency=%u\n",
 		 name, idle_duration_us, latency_us);
 
+	kfree(name);
+
 	return 0;
 
+out_kfree_name:
+	kfree(name);
 out_unregister:
 	idle_inject_unregister(ii_dev);
 out_kfree:
-- 
2.25.1

