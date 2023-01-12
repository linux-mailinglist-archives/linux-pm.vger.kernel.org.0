Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EF7667A11
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jan 2023 16:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240642AbjALP5m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Jan 2023 10:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240328AbjALP4t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Jan 2023 10:56:49 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E00762CA
        for <linux-pm@vger.kernel.org>; Thu, 12 Jan 2023 07:47:30 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id e3so9288471wru.13
        for <linux-pm@vger.kernel.org>; Thu, 12 Jan 2023 07:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rhfywHFYZng0Lm1GCbNe4P4vSb5tP1UVcI0mrPnEUgU=;
        b=Zd4JSRk7z4qab9nUUWHRSjJo5CfzZIM6yZQ1CPXoBQsO/4XbWnThRqxWCIxA5NYNRd
         FvXMbAm4ByoFuQZl1v272c7f9BklhmYzmpmCsg7Eis6NfqBdr19494ZGvui/2FAU6kqE
         ljJs6irLOp7jTkEMbavBMUDsjA7y4M/g/4kYBGm7xKnmw9ktufDTK31Ihru9Iud16ExP
         tq7V/9tl7bXa/6Ounpoz0JuXbbhiAXcOn/7lpqZRTgvJpsMLfN63Rf7jf2La7oT/BOJ7
         o98lElvLzx4xu7sXUVorTGvZPhKTQSue3KBwEH/R/w4oj8ZMrFUC9QRtuRQd9wUSsImn
         5psw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rhfywHFYZng0Lm1GCbNe4P4vSb5tP1UVcI0mrPnEUgU=;
        b=m7NkWoHx+TP2GtfK3zVajyviTjt18JMy0dLoELW1bBejsDr4jBEdaNny1p02bx9H8n
         fox9xUV8JcxlxonFRffP9SCyq6m81CNDIzI2hmQ4HdnCSd/4MBpZnScyfcYwJCvYVQ9y
         +7qXwGwHYagUdKBd+317ALOPtHcqOS60UZv+N+UQFqXELbT8Or3eNHWpujy9hOMc29Uc
         NeK2vJnmH6xcYDgjf7uCel/HCKz99cehxIC3s+J14rBI5kP/Q1IXGu9ktNZB4wHbmF9h
         5ohLvILbwawz1AeHXNWV1215MOJiXVvF79AUK5qshbp+1n17OWoI6M02bFU/zzotV9P/
         cQQg==
X-Gm-Message-State: AFqh2koup4e4ntdNNmj12OY+w6BfCvvQ5fy1AvBghw1mrCV8Oc8RMS0y
        UFNAKQcxWNaocLIOxWpzZgislQ==
X-Google-Smtp-Source: AMrXdXsCzQTM4x9M+n/1OAVGF8m0hYzLxEQ2ys+TBgTIRdp9ZhwWz2iAzvghMJBnQ7xPCSDho1FPdQ==
X-Received: by 2002:adf:de01:0:b0:2bb:d927:eb7a with SMTP id b1-20020adfde01000000b002bbd927eb7amr1458096wrm.30.1673538448818;
        Thu, 12 Jan 2023 07:47:28 -0800 (PST)
Received: from lion.. (cpc76484-cwma10-2-0-cust274.7-3.cable.virginm.net. [82.31.201.19])
        by smtp.gmail.com with ESMTPSA id o14-20020a5d58ce000000b002879c013b8asm16601129wrf.42.2023.01.12.07.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 07:47:28 -0800 (PST)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v3] thermal/core: fix error paths in __thermal_cooling_device_register()
Date:   Thu, 12 Jan 2023 15:47:20 +0000
Message-Id: <20230112154721.452292-1-caleb.connolly@linaro.org>
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

There is in invalid call to thermal_cooling_device_destroy_sysfs() and
another to put_device() in the error paths here. Fix them.

Fixes: c408b3d1d9bb ("thermal: Validate new state in cur_state_store()")
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
Changes since v2:
 * Rework and simplify into one patch following Yang's suggestions.

V2: https://lore.kernel.org/all/20230103171811.204196-1-caleb.connolly@linaro.org/
---
 drivers/thermal/thermal_core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index f17ab2316dbd..321d2a6300c4 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -909,15 +909,16 @@ __thermal_cooling_device_register(struct device_node *np,
 	cdev->devdata = devdata;
 
 	ret = cdev->ops->get_max_state(cdev, &cdev->max_state);
-	if (ret)
-		goto out_kfree_type;
+	if (ret) {
+		kfree(cdev->type);
+		goto out_ida_remove;
+	}
 
 	thermal_cooling_device_setup_sysfs(cdev);
 	ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
-	if (ret) {
-		thermal_cooling_device_destroy_sysfs(cdev);
+	if (ret)
 		goto out_kfree_type;
-	}
+
 	ret = device_register(&cdev->device);
 	if (ret)
 		goto out_kfree_type;
-- 
2.39.0

