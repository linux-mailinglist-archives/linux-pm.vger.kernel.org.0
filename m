Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929F56A7504
	for <lists+linux-pm@lfdr.de>; Wed,  1 Mar 2023 21:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjCAUQY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Mar 2023 15:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjCAUQR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2023 15:16:17 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295C9497F6
        for <linux-pm@vger.kernel.org>; Wed,  1 Mar 2023 12:15:41 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id m25-20020a7bcb99000000b003e7842b75f2so259414wmi.3
        for <linux-pm@vger.kernel.org>; Wed, 01 Mar 2023 12:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677701739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/h75YgLAzThWP+FOpMQKnxnohte85PKa1jrYzQU01Og=;
        b=WKe6cSzLuNxCWv5cfrvDiwJDrEwzeE/mWN6+yWAMx5REI02vy8GlFV5xvHGvGMfBs3
         5oph0BkZOkO/2zlT8/IWB4nbf/wSpjP88FxwKjQdmIBiHGS/KPvr2AldgPLHj1AiE8Pe
         zZ6dCR2gHILz+CzYBlIWgGzoPAhIt1vvNeGFQ9a6XwUSDv8vxoICjInjw1rA4wyZmFp7
         ITCts9r2XErCRLRG4va+oiBfNHJo7G2Pyhg3nv+V+zkiTZj7S9lZCh30ACJsJOl7jo+R
         /mMU2bpwXmXEDOaNNmBW+IRqrHJWRIMmB+DFKyxVsbAg/XHxnMYoZJudTh9n9SkLucyH
         uqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677701739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/h75YgLAzThWP+FOpMQKnxnohte85PKa1jrYzQU01Og=;
        b=hpS3lLQGDjJex/B6pVoudggMO3/1bTnNG/+t8W0Cyzbv/uPVIiI8UPFvAr+f5mwDnY
         gR+dFSuzH5vBV0E56r4arcbj4Oj16eiolna1D/xm8Y3YWxV1mbRypmFkZGKOPfKI0YXt
         CDk7dcHCpdnxlu2UvAa1DMA2MK9cxdwuNmspXO9kjYhWeTYiTkrrnkR1JkQ3ZrdpjktK
         ogtqX3fRYp6zaB0Wo2128ac6vJJScajrmYnXBdtWrHOLYs2MZWyMJNxrsLP/JOLyC07z
         0/VtZ4XniWC91PPAXe92MCfLqmsP3X08PlcEUhp4Gl96csWzarncptysx1+KU4yRgw5S
         LwsA==
X-Gm-Message-State: AO0yUKX7GjJgul82HW4SCrUslzy2cJBMrk5Jgx8GuxKpJB6KDws4cxTj
        kXweaNLQ8hgJWKrOYQYu/27F6hQeqARHQtGJL7M=
X-Google-Smtp-Source: AK7set98qZ9E/L3QjFj0q/InIIObqL00S5rF2lAu6706tefYT4w4YWcBpnM4Xdrc4MEy5viAbU4Kug==
X-Received: by 2002:a05:600c:3506:b0:3ea:e5fc:a5a4 with SMTP id h6-20020a05600c350600b003eae5fca5a4mr6201164wmq.1.1677701739489;
        Wed, 01 Mar 2023 12:15:39 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6ffe:ce4f:bd31:1e6d])
        by smtp.gmail.com with ESMTPSA id x16-20020a1c7c10000000b003e70a7c1b73sm576546wmc.16.2023.03.01.12.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 12:15:39 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v5 10/18] thermal/core: Add thermal_zone_device structure 'type' accessor
Date:   Wed,  1 Mar 2023 21:14:38 +0100
Message-Id: <20230301201446.3713334-11-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230301201446.3713334-1-daniel.lezcano@linaro.org>
References: <20230301201446.3713334-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal zone device structure is exposed via the exported
thermal.h header. This structure should stay private the thermal core
code. In order to encapsulate the structure, let's add an accessor to
get the 'type' of the thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 6 ++++++
 include/linux/thermal.h        | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 9fa12147fead..913ba9ca9792 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1384,6 +1384,12 @@ void *thermal_zone_device_priv(struct thermal_zone_device *tzd)
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_priv);
 
+const char *thermal_zone_device_type(struct thermal_zone_device *tzd)
+{
+	return tzd->type;
+}
+EXPORT_SYMBOL_GPL(thermal_zone_device_type);
+
 /**
  * thermal_zone_device_unregister - removes the registered thermal zone device
  * @tz: the thermal zone device to remove
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 7dbb5712434c..21686e676b3d 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -366,6 +366,7 @@ thermal_zone_device_register_with_trips(const char *, struct thermal_trip *, int
 					struct thermal_zone_params *, int, int);
 
 void *thermal_zone_device_priv(struct thermal_zone_device *tzd);
+const char *thermal_zone_device_type(struct thermal_zone_device *tzd);
 
 int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
 				     struct thermal_cooling_device *,
@@ -443,6 +444,11 @@ static inline void *thermal_zone_device_priv(struct thermal_zone_device *tz)
 	return NULL;
 }
 
+static inline const char *thermal_zone_device_type(struct thermal_zone_device *tzd)
+{
+	return NULL;
+}
+
 static inline int thermal_zone_device_enable(struct thermal_zone_device *tz)
 { return -ENODEV; }
 
-- 
2.34.1

