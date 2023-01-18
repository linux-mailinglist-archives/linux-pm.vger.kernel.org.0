Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30DE671762
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jan 2023 10:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjARJVP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Jan 2023 04:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjARJUl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2023 04:20:41 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A3975A1D
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 00:38:35 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9so36165789pll.9
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 00:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rk4Yuj9GI6UIE2hgNfLDbnDh1l8wksnTp158bl3zXSc=;
        b=nnVisWFzyIwOrVLjxPSve3qNP6rlOovgA08f/iPGaiQzYCJDpfc9cgeCKtC9MHW+kK
         ZvW4Sc2nntdflPaYnuFaYre3Sr/kiKblRrhJrUBzpbcTDzugbaRDddIcCPhAgDHsI4/f
         hKCu8uLh5cFo7Yacgt4UNDEi09FMXoq3UDlpNEqhVxwwG7wmtqynXrXBknEEn3OmGNdf
         /RcVCJWhb8a4Z708WmmoxrSr0rLAqYbyBQ++KoBoX3PLTxPDZX/ATNB+eDk9d6RI+xOt
         7ITaEYKwnx3xHuTvLjZS+5/3we3/mCg5wMhqy6jMzkeSk0VENs10bG48V+oySz5I4par
         9bYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rk4Yuj9GI6UIE2hgNfLDbnDh1l8wksnTp158bl3zXSc=;
        b=tIAbA538ioCl0KaRuNHmLYg00X7FWdaUiv+MrtYJrGQM61uayjuKFtOtypQB1dardv
         JJgzsHiS2qP8XCN5xVBdNbmXCcKsJB4qujE7DxPx9aik0TI38rgpCYKM21Y2vEVMuQu2
         0XPdOCMxpH3AH+Lz9FuGclYeywpitJCL4EVRubuznMk5Ru7TTJvsF8LxE6+qhESHHysT
         pZddcvCazBzk6KqgUG+pzbhkZqxAJpA8tmQijmCgmqMnmGBPdlwUfPKSBO7JiGZbtKz/
         jlf1P8Xsy7ROpQ02FjIJpjJMY7NjE37iR6gPYFjxPD3xbwARZs/kseMWiD21fLWiWYHN
         z/dg==
X-Gm-Message-State: AFqh2kpjsPmxWvHf7zGBopcrNeG2uQUvXcjyvc4LCCCsusZk+y8k4d1g
        4DxSQ0VxTyx6L+PhBg//zMpmbDhAz9eNoVLj
X-Google-Smtp-Source: AMrXdXsFjoz00AgH9TIWqwkZuGatKxLiS7uOo9FgY+fRilu9KfZYXmhBSNT9y0HW0aYsx03+Ir8NXg==
X-Received: by 2002:a17:902:d512:b0:192:fd1e:a968 with SMTP id b18-20020a170902d51200b00192fd1ea968mr9510211plg.46.1674031114966;
        Wed, 18 Jan 2023 00:38:34 -0800 (PST)
Received: from localhost ([122.172.81.45])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090322cd00b001896af10ca7sm350395plg.134.2023.01.18.00.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 00:38:34 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/3] thermal: core: call put_device() only after device_register() fails
Date:   Wed, 18 Jan 2023 14:08:24 +0530
Message-Id: <d6e5d4fcca5f66d290e907d10c45cb2e7bbb09e5.1674030722.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1674030722.git.viresh.kumar@linaro.org>
References: <cover.1674030722.git.viresh.kumar@linaro.org>
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

put_device() shouldn't be called before a prior call to
device_register(). __thermal_cooling_device_register() doesn't follow
that properly and needs fixing. Also
thermal_cooling_device_destroy_sysfs() is getting called unnecessarily
on few error paths.

Fix all this by placing the calls at the right place.

Based on initial work done by Caleb Connolly.

Fixes: 4748f9687caa ("thermal: core: fix some possible name leaks in error paths")
Fixes: c408b3d1d9bb ("thermal: Validate new state in cur_state_store()")
Reported-by: Caleb Connolly <caleb.connolly@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
For v6.2-rc.

V3->V4:
- The first three versions were sent by Caleb.
- The new version fixes the current bugs, without looking to optimize the
  code any further, which is done separately in the next two patches.

 drivers/thermal/thermal_core.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index f17ab2316dbd..77bd47d976a2 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -909,15 +909,20 @@ __thermal_cooling_device_register(struct device_node *np,
 	cdev->devdata = devdata;
 
 	ret = cdev->ops->get_max_state(cdev, &cdev->max_state);
-	if (ret)
-		goto out_kfree_type;
+	if (ret) {
+		kfree(cdev->type);
+		goto out_ida_remove;
+	}
 
 	thermal_cooling_device_setup_sysfs(cdev);
+
 	ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
 	if (ret) {
+		kfree(cdev->type);
 		thermal_cooling_device_destroy_sysfs(cdev);
-		goto out_kfree_type;
+		goto out_ida_remove;
 	}
+
 	ret = device_register(&cdev->device);
 	if (ret)
 		goto out_kfree_type;
@@ -943,6 +948,8 @@ __thermal_cooling_device_register(struct device_node *np,
 	thermal_cooling_device_destroy_sysfs(cdev);
 	kfree(cdev->type);
 	put_device(&cdev->device);
+
+	/* thermal_release() takes care of the rest */
 	cdev = NULL;
 out_ida_remove:
 	ida_free(&thermal_cdev_ida, id);
-- 
2.31.1.272.g89b43f80a514

