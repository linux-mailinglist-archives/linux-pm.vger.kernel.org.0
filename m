Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C3C65C4F5
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jan 2023 18:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbjACRSk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Jan 2023 12:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjACRSj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Jan 2023 12:18:39 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC29CD
        for <linux-pm@vger.kernel.org>; Tue,  3 Jan 2023 09:18:35 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso17449596wms.5
        for <linux-pm@vger.kernel.org>; Tue, 03 Jan 2023 09:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=caB/wWNRuQu9IumSCI6mzh9saA1/XDaCM6lXGhyYJ8Q=;
        b=U0ZTKtRBUYzVnqqlWkCz8Xvdj1qxexBZIokQA/yXjDgZEXdZRsk+NAX98zQFfTHlT+
         rAJU+a2w6uDfG/kUZIaATyxo5oA7KZMiuFuKfiUBmbyBYzdcR2GGkZD2QcQ78hZuqALj
         DxjRzRSismJj3jITmdec2lGbdV/ne9+mnuhGBw47eQapoQLJ6MPx/WVX03scZfDVSbqD
         hMIwoAiCZ/rwVNdtsybsZaSImCdpoee48Oc5PNy7SG5XZbn4cOPNNDqGNrtrUZiwpMqg
         OORazFLFysbALtMbDwYf//h1nVwkvbKWAC2vx4Pio5b9oUIY5V6Qm1UuEYUEn/PC/dyJ
         DriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=caB/wWNRuQu9IumSCI6mzh9saA1/XDaCM6lXGhyYJ8Q=;
        b=nHwCjG4afe5681ETNFJTc4Bog2UwKN6LxnkKdlROOfiysmJIqVSgMRaV0I89uYFjTC
         9ttXuE9cD8/h2nmO6lWw0KWrl+pGeGyeFBNV20FzoCyW3eQuU/DCiliXpp93LGASjMxy
         KoW3XzoeFNgge3GhSxuv5f4nzV5tpGgceIQaqhK+dzuAGPbXBHS9cRHCB5+1xDLhMB69
         oq31OCYwie6NgRSQl1xSASWwN68JtjeIE8s+yH1tTwlnGaTczIFgloZuXSiJMvQBzLfF
         s4XcIX4lWVH7DjArQPmh5U7E08eh0AiJ3OPqKk/HqoJHnBVtEI66ANh6/pYJYYE6my7A
         /PSA==
X-Gm-Message-State: AFqh2krLA13IWCaFaqZUPHLyyXvVMdY+al5/6NoYux2Uf5sRaPMh7oZU
        nU54i8YZOU+JwLaV+B2Jaytyuw==
X-Google-Smtp-Source: AMrXdXseVShZ4Ne/Ykoa1yUae0PaXRk6TmA6b2YA2fUncfpue63XPf+79SSLfsbdJ9JoJSdXSLCSew==
X-Received: by 2002:a05:600c:3493:b0:3d2:370b:97f4 with SMTP id a19-20020a05600c349300b003d2370b97f4mr35754170wmq.16.1672766314152;
        Tue, 03 Jan 2023 09:18:34 -0800 (PST)
Received: from lion.. (host-92-24-101-87.as13285.net. [92.24.101.87])
        by smtp.gmail.com with ESMTPSA id k5-20020a05600c080500b003d208eb17ecsm40496519wmp.26.2023.01.03.09.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 09:18:33 -0800 (PST)
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
Subject: [PATCH v2 1/2] thermal/core: fix unbalanced put_device in register error path
Date:   Tue,  3 Jan 2023 17:18:09 +0000
Message-Id: <20230103171811.204196-1-caleb.connolly@linaro.org>
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
Changes since v1:
 * Add second patch.

V1: https://lore.kernel.org/all/20221231210301.6968-1-caleb.connolly@linaro.org/
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

