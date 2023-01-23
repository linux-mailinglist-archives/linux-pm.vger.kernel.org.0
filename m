Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3C1677FB3
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jan 2023 16:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjAWP2V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Jan 2023 10:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjAWP2U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Jan 2023 10:28:20 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADDD20047
        for <linux-pm@vger.kernel.org>; Mon, 23 Jan 2023 07:28:18 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so10901767wmb.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Jan 2023 07:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIWV5/U3aD1TS48D9ejtlC9TCaF31IO7b6c4b9EuDIo=;
        b=olV4vJ064212iGgO5jY7yyTvCfRLgc3Q515NIOQqAVJlywstBPrpDpKx9JF5R5CM6l
         WqDXjoSTyewV2vMJDur1Rk5xUTdRqx1sW7kR0Qadtln5Boyyc0N1Kzy5gKiXud3Rc/T0
         R0pVpjCQjjNuoFzom8pnoFVzFnbG5BfuJmJNHPLxqbmd0LRJq1FiB4TWJDxlPElzifVj
         ELLDg5WS+0zzl+RvJsgtUa0fSbDJ0Lokw6ymExUBgftIQvvMMKxOUXUu8bWXi/ZYybH2
         VOcM/kxTkEJvsaYeQCcGMgws6g6nesnLEcOtGWdOMiiCFfIRU7ax6gPx+4SgbvSSr430
         H3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIWV5/U3aD1TS48D9ejtlC9TCaF31IO7b6c4b9EuDIo=;
        b=YRbBM97iLQrRmVdq2MCsXZHJ9XjutdgEIBg2PfHyIsGbLTQD1AkGj8RhYX6BuL4lTn
         f1UhRYDLP1K4N4wDPn6QTzJYq1kpdJWjrcDZuhZyGGRcqENGbrtnSoCWt4whXgK5agth
         Um2Y5s7ykPahTc/ARYsqXRuRXtn7bJ05mmFxICcUVA7p4I6OwDIHlThN6yNM0M+RheXx
         jsN/cw1ktcovhp3Xshcl/HJivdxUSFOikvxykBmjzpzNSlRq69f3kHE1dQhL78JstaId
         7lM0TnSpgIbj/Bx5CvIFmm7bugS1CeITzO67WLKW6H7UKL74sgPMatIBEGgMllENRyEB
         /MvQ==
X-Gm-Message-State: AFqh2kq61wP+i/pLGlHl7T40OzmILaoKPKmM8+IXvGtOLC/pZUH+rYPm
        fdcFdlnvtptNAr5dLvWHsgHAtQ==
X-Google-Smtp-Source: AMrXdXsCbZ6Bl05Xw2rjXfpabLcjeZXHey9Oo5slLXr3qjVDcYirWUVTSjFRzfyhf2obUDSF0lZqVA==
X-Received: by 2002:a05:600c:2255:b0:3da:f950:8168 with SMTP id a21-20020a05600c225500b003daf9508168mr23235744wmm.35.1674487696977;
        Mon, 23 Jan 2023 07:28:16 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id t13-20020a1c770d000000b003db1ca20170sm10673096wmi.37.2023.01.23.07.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:28:16 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v2 1/3] thermal/core: Fix unregistering netlink at thermal init time
Date:   Mon, 23 Jan 2023 16:27:54 +0100
Message-Id: <20230123152756.4031574-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123152756.4031574-1-daniel.lezcano@linaro.org>
References: <20230123152756.4031574-1-daniel.lezcano@linaro.org>
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

