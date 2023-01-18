Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE2C672A0F
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jan 2023 22:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjARVMl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Jan 2023 16:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjARVMT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2023 16:12:19 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD63F611CD
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 13:11:32 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so2304834wmb.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 13:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OIWV5/U3aD1TS48D9ejtlC9TCaF31IO7b6c4b9EuDIo=;
        b=t2fk2cgG7M8bLDNWGKnT74AMDXx9E7iJEn9H+QmUp0+M0KACJvTvbTetxbS1f1oUd3
         9jw5nLahBjhiptCacAmD/eFVtuLZGCAug65HWqH1hKtev9u9Y7ClMJ2P2ryogs8y5COz
         J4COS/80Luf8tEiCAeyVTEOmyPLJljb5zHOmr0/PoI45uddUhg5h55DpEnr6o9s+O/4K
         l2/WxJFKOFyFJq0t4kxEuR4ylykxgWq4HNXl4EW2vDbAWr8EL9c1eIVfIGXNAYhrC7i3
         sywuHTSDuLMFj6VyDEDPXKOZSmbCY0DKoQjOT03XENss5p/WBLc1fKKhLJQSYL2lw2bS
         aLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OIWV5/U3aD1TS48D9ejtlC9TCaF31IO7b6c4b9EuDIo=;
        b=0B1xRhDa6GwA8sJD/Wdn/h/AXdD7yTLSHWdxOhL39nVEf9Cfqxgj3vESGwiomM1y5l
         5TpEUAp2GvzTwIN9V8LD4+JIN8/tASntPjG1IcgdU09sLZKgHZMuhOjzIZV7oy41WvF9
         3PWYgXeglLxEdz2hbNggBwocEzcSQ0JoVSUloRh9Jszz8ImU0pBHrhW+lu3wE9bg32EQ
         EGZE5hGAquAWk7mlFjMBUkC6Hmm4sK2T+O6KoAEzbATVKsu5+iQeTR/1ujLJ+6pR1qlv
         j2bCTT8M06607OSg8qdfuOLKzCibBmXa80RuRphL/5mHr0EDeftYvJ1T6V8k9rT2ahGq
         HMwQ==
X-Gm-Message-State: AFqh2kodBdcHvgd/rMAxSNM+uO96SOYZAOiYf2uuF5IoWHdIf+kjEQM8
        R9m+mGemYt+AHseTKJQijP5a9w==
X-Google-Smtp-Source: AMrXdXsC1bjPn7WUQDAuWg4zV7HvQ9J6GS2Z3eJA/hau1rgZLze5tynv+ZKh43nBURVkvpF0ExTreA==
X-Received: by 2002:a05:600c:35c1:b0:3db:1424:e781 with SMTP id r1-20020a05600c35c100b003db1424e781mr3207421wmq.23.1674076291099;
        Wed, 18 Jan 2023 13:11:31 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id l27-20020a05600c2cdb00b003d99da8d30asm3198835wmc.46.2023.01.18.13.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 13:11:30 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/5] thermal/core: Fix unregistering netlink at thermal init time
Date:   Wed, 18 Jan 2023 22:11:19 +0100
Message-Id: <20230118211123.111493-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal subsystem initialization miss an netlink unregistering
function in the error. Add it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c    | 4 +++-
 drivers/thermal/thermal_netlink.c | 5 +++++
 drivers/thermal/thermal_netlink.h | 3 +++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d9a3d9566d73..fddafcee5e6f 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1606,7 +1606,7 @@ static int __init thermal_init(void)
 
 	result = thermal_register_governors();
 	if (result)
-		goto error;
+		goto unregister_netlink;
 
 	result = class_register(&thermal_class);
 	if (result)
@@ -1621,6 +1621,8 @@ static int __init thermal_init(void)
 
 unregister_governors:
 	thermal_unregister_governors();
+unregister_netlink:
+	thermal_netlink_exit();
 error:
 	ida_destroy(&thermal_tz_ida);
 	ida_destroy(&thermal_cdev_ida);
diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
index 75943b06dbe7..08bc46c3ec7b 100644
--- a/drivers/thermal/thermal_netlink.c
+++ b/drivers/thermal/thermal_netlink.c
@@ -699,3 +699,8 @@ int __init thermal_netlink_init(void)
 {
 	return genl_register_family(&thermal_gnl_family);
 }
+
+void __init thermal_netlink_exit(void)
+{
+	genl_unregister_family(&thermal_gnl_family);
+}
diff --git a/drivers/thermal/thermal_netlink.h b/drivers/thermal/thermal_netlink.h
index 1052f523188d..0a9987c3bc57 100644
--- a/drivers/thermal/thermal_netlink.h
+++ b/drivers/thermal/thermal_netlink.h
@@ -13,6 +13,7 @@ struct thermal_genl_cpu_caps {
 /* Netlink notification function */
 #ifdef CONFIG_THERMAL_NETLINK
 int __init thermal_netlink_init(void);
+void __init thermal_netlink_exit(void);
 int thermal_notify_tz_create(int tz_id, const char *name);
 int thermal_notify_tz_delete(int tz_id);
 int thermal_notify_tz_enable(int tz_id);
@@ -115,4 +116,6 @@ static inline int thermal_genl_cpu_capability_event(int count, struct thermal_ge
 	return 0;
 }
 
+static inline void __init thermal_netlink_exit(void) {}
+
 #endif /* CONFIG_THERMAL_NETLINK */
-- 
2.34.1

