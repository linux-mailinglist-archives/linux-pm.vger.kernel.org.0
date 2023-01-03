Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F56B65C4F7
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jan 2023 18:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbjACRSm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Jan 2023 12:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbjACRSj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Jan 2023 12:18:39 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545EEC7
        for <linux-pm@vger.kernel.org>; Tue,  3 Jan 2023 09:18:37 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id ay2-20020a05600c1e0200b003d22e3e796dso24007461wmb.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Jan 2023 09:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YlbFpTOa8JmfulxTJYgf3sYZGMwN6VYpGCnEPzJ1wM0=;
        b=Puu6x0Y4TM1QQPRkBLIfda6tZQZXchSaAVVe9baeXwgbVMOk70N4FkR4idg1XCeBVL
         epTSTA4/Is6hUw0Ueh4Zwg4TeeGbQ2lzVrLVrwkCA32DgVxBq/1Waeo/tlMq8CYBWZYv
         EUske2o0G+ime7h/JpMmJeg20LEC6agySish/bD3AGI3GI8iKYMpdz+oAhb3rUuCA402
         QyTcHnFfBoozu5tHGYvUQrecjvblKqmQfeEivZsFlx3a14Q2Khjk8G3+jDHM7je9muw2
         7ysTyMkhB0J2LhP0HODLImtOidyhD9ogE2tKTN5JJ2XXBEk+Lpt8XE9aEXGWaPOSvGsO
         SFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YlbFpTOa8JmfulxTJYgf3sYZGMwN6VYpGCnEPzJ1wM0=;
        b=vEv/iSeSXQ+UCEEWSf3VGN25ZHV8VVGxPiiteok0h7BRQttSA7Wa34fFzQ/GCfnyDX
         peXG39CBNl67D+gruaqjb42BzMbeJNx0Vopq8zOxevHN3rsLP6gT/Y7mMBWcKYgtBuMu
         TSI6YQCEPzXQJdHtHBBvHSwCA5CCg+WYF4XwXyZCh5Oh3KHoJC+YHKHv9MzPDCectXeH
         g212YofO5fJ7uC8PaDqJIgJcRvZwzOKu3cQia/zC3AxcsVkja1b3sYic1DmXEvktylpM
         Ds2GCXuyqjCx7FLiUWm5BdLE5VTVUTv9HNlZcn7X/8U7H+frCrEzaWVWDJInLm0QIyeZ
         E22A==
X-Gm-Message-State: AFqh2koJ5HD9iOh07pXryPjk1aJy+0igGQOuEPmxUlgPwFwzP0b1xqHy
        PR0g9A2RwVJxnKrtAt4EkLDihQ==
X-Google-Smtp-Source: AMrXdXtbbpEQdjk31p/WQD2DHPxt9QfPhczBFQiQ/WiGIird8uiJNj7j72q2rBFK0cucKIOpPfOOeA==
X-Received: by 2002:a05:600c:3209:b0:3cf:5fd2:87a0 with SMTP id r9-20020a05600c320900b003cf5fd287a0mr30973605wmp.40.1672766315935;
        Tue, 03 Jan 2023 09:18:35 -0800 (PST)
Received: from lion.. (host-92-24-101-87.as13285.net. [92.24.101.87])
        by smtp.gmail.com with ESMTPSA id k5-20020a05600c080500b003d208eb17ecsm40496519wmp.26.2023.01.03.09.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 09:18:35 -0800 (PST)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Caleb Connolly <caleb.connolly@linaro.org>,
        linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v2 2/2] thermal/core: fix unbalanced destroy_sysfs error path in register
Date:   Tue,  3 Jan 2023 17:18:10 +0000
Message-Id: <20230103171811.204196-2-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103171811.204196-1-caleb.connolly@linaro.org>
References: <20230103171811.204196-1-caleb.connolly@linaro.org>
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

Commit 4748f9687caa ("thermal: core: fix some possible name leaks in error paths")
causes thermal_cooling_device_destroy_sysfs() to be called incorrectly
in __thermal_cooling_device_register() if ->get_max_state() fails. It
also causes it to get called twice if dev_set_name() fails.

Adjust the error paths to ensure thermal_cooling_device_destroy_sysfs()
is only called for a matching thermal_cooling_device_setup_sysfs().

Fixes: 4748f9687caa ("thermal: core: fix some possible name leaks in error paths")
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/thermal/thermal_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 2c6995b5dcb0..28864f14b01c 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -914,10 +914,9 @@ __thermal_cooling_device_register(struct device_node *np,
 
 	thermal_cooling_device_setup_sysfs(cdev);
 	ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
-	if (ret) {
-		thermal_cooling_device_destroy_sysfs(cdev);
-		goto out_kfree_type;
-	}
+	if (ret)
+		goto out_destroy_sysfs;
+
 	ret = device_register(&cdev->device);
 	if (ret)
 		goto out_put_device;
@@ -941,8 +940,9 @@ __thermal_cooling_device_register(struct device_node *np,
 
 out_put_device:
 	put_device(&cdev->device);
-out_kfree_type:
+out_destroy_sysfs:
 	thermal_cooling_device_destroy_sysfs(cdev);
+out_kfree_type:
 	kfree(cdev->type);
 	cdev = NULL;
 out_ida_remove:
-- 
2.39.0

