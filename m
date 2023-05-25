Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DBD710DE0
	for <lists+linux-pm@lfdr.de>; Thu, 25 May 2023 16:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241475AbjEYOCc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 May 2023 10:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241476AbjEYOCb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 May 2023 10:02:31 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357F2E5F
        for <linux-pm@vger.kernel.org>; Thu, 25 May 2023 07:02:05 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f6042d610fso6926465e9.1
        for <linux-pm@vger.kernel.org>; Thu, 25 May 2023 07:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685023323; x=1687615323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8B9aQ7Lplcn7G2JB0WPPOQOR+fAGdexdV4KhX+LOA7s=;
        b=CxESNjIkH3BboOwT79PfxTbJqEYO+ulPMr3xuPgq2RQc2zfHIA96lwJCDWHXUrvzm6
         piAYphSeATpyEUOwZ6GBdLtnJ4aDCc6tfX5DVVhVxBPEykCgBBh9EFG4dpc6XDeKqE67
         VkDHGrzXmUDv07jcMWvLfTEp/6bsqma5lwiNy9qGZ0GuRx4DcybOPU5p+kSGRuWUruvO
         Y1G7iYNI6MR73/gHHYrDnZGZcYDqolv410rYhvZnlHxLAO1FTad0IvgF+YzIBKHEvxsM
         bNlX7G9V77O1U5KNpzXOVby1gYgLgnP04O8EMEZ8qzh51m3REi+0rd7wRUdPancKMU4C
         S+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685023323; x=1687615323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8B9aQ7Lplcn7G2JB0WPPOQOR+fAGdexdV4KhX+LOA7s=;
        b=lCimw2mld7TjwBXXtaKMpMdCyAmqCrm5J+KjgS1R0CCH/Jc92bDZzx//Aa1xSqFGuk
         RAm4C7Te5gEm1TGs27Lb2qb9/GS+UywCZiYLOemr6YACsdzZauYWTAcgJ73HVhwLJc6M
         sGu2/6WkMFwQI22sZc0jfhvm961RBUCkUBiuILp6rQkL9H2HVEsg7Jt7mI4gEiusB3Q6
         I+v7pC9ab46zmln51iR+jrXsNWkCMBcc2fHH2z8GkTWA+09mV+Tf6gGWo8h2UrHnlK1q
         Zs9LabZN3Wk4LpPCl4F8oRbUQ9WP1nn+RO7V1a0ApDcqO/pMY52AkHRTOmCyXkTOnQGk
         Tz5g==
X-Gm-Message-State: AC+VfDwFY8G9iApxkkUr5415xJrcTelDVpwgb9Oo3/IiMzcm1Q/nfQWE
        nIThjCnpQVHHH5XPzPL5vAOSQg==
X-Google-Smtp-Source: ACHHUZ4F1fh7DZgNjE4ieVsv54Ei3k5AvurrK2sWewLerZ2R9/Zni1p50lrMYUzDcyELCRbAnCitsA==
X-Received: by 2002:a5d:69c4:0:b0:2cf:f01f:ed89 with SMTP id s4-20020a5d69c4000000b002cff01fed89mr2474905wrw.24.1685023323146;
        Thu, 25 May 2023 07:02:03 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:5aef:8608:89d7:7961])
        by smtp.gmail.com with ESMTPSA id u4-20020adfdd44000000b003063176ef09sm1944866wrm.6.2023.05.25.07.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 07:02:02 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, thierry.reding@gmail.com,
        Lukasz Luba <lukasz.luba@arm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/8] thermal/core: Reorder the headers inclusion
Date:   Thu, 25 May 2023 16:01:30 +0200
Message-Id: <20230525140135.3589917-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525140135.3589917-1-daniel.lezcano@linaro.org>
References: <20230525140135.3589917-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The next changes will move the thermal device structure inside the
thermal core code. Consequently, the traces must be included after
thermal_core.h as this one contains the thermal zone device structure
definition the traces need.

Reorder the inclusions.

No functional changes intended.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/gov_power_allocator.c | 6 +++---
 drivers/thermal/thermal_core.c        | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index d1c6ad92e5b4..6056ed15460b 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -11,12 +11,12 @@
 #include <linux/slab.h>
 #include <linux/thermal.h>
 
-#define CREATE_TRACE_POINTS
-#include "thermal_trace_ipa.h"
-
 #define THERMAL_CORE_SUBSYS
 #include "thermal_core.h"
 
+#define CREATE_TRACE_POINTS
+#include "thermal_trace_ipa.h" 
+
 #define INVALID_TRIP -1
 
 #define FRAC_BITS 10
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6bca97e27d59..afcd4197babd 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -21,13 +21,13 @@
 #include <linux/of.h>
 #include <linux/suspend.h>
 
-#define CREATE_TRACE_POINTS
-#include "thermal_trace.h"
-
 #define THERMAL_CORE_SUBSYS
 #include "thermal_core.h"
 #include "thermal_hwmon.h"
 
+#define CREATE_TRACE_POINTS
+#include "thermal_trace.h"
+
 static DEFINE_IDA(thermal_tz_ida);
 static DEFINE_IDA(thermal_cdev_ida);
 
-- 
2.34.1

