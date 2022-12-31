Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3860065A701
	for <lists+linux-pm@lfdr.de>; Sat, 31 Dec 2022 22:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiLaVDO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Dec 2022 16:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiLaVDO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Dec 2022 16:03:14 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E61615C
        for <linux-pm@vger.kernel.org>; Sat, 31 Dec 2022 13:03:11 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id o15so17734879wmr.4
        for <linux-pm@vger.kernel.org>; Sat, 31 Dec 2022 13:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zUROYRRzGyL0wLH035SXhvbEi3QLuHG96SNrJ4g0064=;
        b=PFBV9cB3z7cTd7xHWWtsi08XAfJa/JOBo0hj9geKxW8a4ehqNzjoroRlfyg90Hgvf2
         dlpOONg9/Mq2Gt2WG4SY5/0HJuH9r8CzeFKLINHuXTM49G0rNtp7SuXG9xxysGcQw87k
         nO5qqAEAhgr0kl5nNTaDb3ynbG7IWQXzGcQnmv9WSs9NGo+Uf/WkTjGUAL0nHhP2F6Sn
         29sPqHHcuAfQXS2Hre07ktYfwYnQaeGpiT6K39e7CVXFNbwHtPa3eEmwG81sJv04R4/T
         2Y+cpcKi0KWhSRqnNHjnLHnjYPDNe7q9DsVVaGqSUAcuebrQfH1pHWzi/TDEvaGQTkjL
         /Zow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zUROYRRzGyL0wLH035SXhvbEi3QLuHG96SNrJ4g0064=;
        b=2TOuTSBXIaawreYPBtgBozxA1D+FIC05lLq9chQyu9UE2FdQ5zXHq/ZecwHpOi+yTL
         ar9xf6vml3oCuMjLpP4vSZcKdqbVaVEsn+aMfhyaTHDFADgYx2SJnhRqTBXrnhzFl/tp
         S204h9G9NiIHI0vvsYklxjAQQAvM6Q1QlEzIK4dfDesxRgZj8CN18CVZTglkpFmPe/D/
         nQw/77ChEycezmIS97p3Se0mEHG2/4pDctvl3ksne4rROo1UbUFwOOyAt+OXWHWuu/tW
         6enrFMzeZhb0Ac+vHoSdRlPaRgtThK2vVb42aCA0AKobiHwuFtUd6HCWuFpWpHdTuvjB
         Lnhw==
X-Gm-Message-State: AFqh2kqa6yHxnvQ7+fVGXImeKAWrRG2daZ1ISdAuwkIdjXWnNBwhbypb
        08hDUS6w2shwZ7sfeEGfspaWqA==
X-Google-Smtp-Source: AMrXdXsiyqYcCASCR92HrpD0cY3ot6K1Oldk1b/qnUYl7lXsHzFA8qlXeAboPNxAbCGysQqoKFCSAw==
X-Received: by 2002:a05:600c:3d98:b0:3cf:d70d:d5a8 with SMTP id bi24-20020a05600c3d9800b003cfd70dd5a8mr25060782wmb.6.1672520590164;
        Sat, 31 Dec 2022 13:03:10 -0800 (PST)
Received: from lion.. (host-92-24-101-87.as13285.net. [92.24.101.87])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003d9780466b0sm27106154wmq.31.2022.12.31.13.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 13:03:09 -0800 (PST)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Caleb Connolly <caleb.connolly@linaro.org>,
        linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH] thermal/core: fix potential unbalanced put_device during register
Date:   Sat, 31 Dec 2022 21:03:01 +0000
Message-Id: <20221231210301.6968-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit c408b3d1d9bb ("thermal: Validate new state in cur_state_store()")
causes device_put() to be called if the get_max_state() callback fails
during __thermal_cooling_device_register().

Fix the cleanup ordering to only call device_put() if initialization
fails after the matching device_register() call.

Fixes: c408b3d1d9bb ("thermal: Validate new state in cur_state_store()")
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/thermal/thermal_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index f17ab2316dbd..2c6995b5dcb0 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -920,7 +920,7 @@ __thermal_cooling_device_register(struct device_node *np,
 	}
 	ret = device_register(&cdev->device);
 	if (ret)
-		goto out_kfree_type;
+		goto out_put_device;
 
 	/* Add 'this' new cdev to the global cdev list */
 	mutex_lock(&thermal_list_lock);
@@ -939,10 +939,11 @@ __thermal_cooling_device_register(struct device_node *np,
 
 	return cdev;
 
+out_put_device:
+	put_device(&cdev->device);
 out_kfree_type:
 	thermal_cooling_device_destroy_sysfs(cdev);
 	kfree(cdev->type);
-	put_device(&cdev->device);
 	cdev = NULL;
 out_ida_remove:
 	ida_free(&thermal_cdev_ida, id);
-- 
2.39.0

