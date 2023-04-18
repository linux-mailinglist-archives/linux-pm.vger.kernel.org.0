Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9646E5C06
	for <lists+linux-pm@lfdr.de>; Tue, 18 Apr 2023 10:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjDRIbQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Apr 2023 04:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjDRIbO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Apr 2023 04:31:14 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCC144AD
        for <linux-pm@vger.kernel.org>; Tue, 18 Apr 2023 01:31:10 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-2f917585b26so1732333f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 18 Apr 2023 01:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681806668; x=1684398668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4A6OpstqdNieOolGqqfs3dJZeBWURomNlQRfM9+VC0=;
        b=Cy3Wr2WKfWULNqyX0qg6/HCM9vISkkbv8/UnNAgM8nqb24jM9DjY9bODwDrQLg5+jX
         PlIxkG23AEggmzoD2NqnHcqPtYsyhUIJ19K4eTQGQw7ZaLLHGWuJWr5o8EP1siTvvGBv
         VIvMrVA710J+ij1OpVlBRc5hUWszpZ7ccaL2KiRVTmvTRAf93K8jnfQPA6S9gx5qybaL
         vXYr4xxX17TTvOkzAKAYQ6h8N8+G9WGYjWoNMbibrZA/OkmZxerTSBwT9KTaR4ytXd3s
         q3ILtS5kYmLWpGZ+91qBCzZTvOwvarbwNmdLjwA9/PWKDfvKU4ayWwTuUI/08Ux6pc/v
         w4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681806668; x=1684398668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R4A6OpstqdNieOolGqqfs3dJZeBWURomNlQRfM9+VC0=;
        b=fqmksiZbPemTlBWgyxjrOyR8Ii69p7/tOkTb4txIrGCAthfpozQ6SeXvpu+kUGSYDI
         Qgfdlh96MfhH5TAiSXdiNjsI6I6ZLCWVWkBhT0XfUiIyFsMTuYnmux+KRRpCN7QjAwSn
         /oTeSSiCpfk8b4zWQu37f+9g2YMa+GnFELuLCNL8GV2VvFpLhFqkvpOGkosSFi8tmAK4
         yr5E+Z7Vl3u/4bZIFz4qQ0Hno1UpIinq66haRcaJLq2BjZajP0hp3Iwkn0N3tQCZjNwQ
         rNztOEQrCklyCJ9Hh57MfWFUBJtNV9D818kRyTDjFUirkqcDxmMiI/pmNiM0MgriC3r6
         OCjg==
X-Gm-Message-State: AAQBX9cr7ajfz21rMwrSxgL2qICVlf0ndrhSXSjMbUoO/wl07SOUa5yy
        A2DtZGCCjS+RvYO7JWCpbrxqew==
X-Google-Smtp-Source: AKy350Zpzk7u1ICgOITr28oZA+/Uu3ha+VSToHCZOlLguvgp7G+l7PyN574H7c77blf5Ikgf5SKO/A==
X-Received: by 2002:adf:fc90:0:b0:2ef:b4a9:202f with SMTP id g16-20020adffc90000000b002efb4a9202fmr1293915wrr.69.1681806668432;
        Tue, 18 Apr 2023 01:31:08 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c25b:18d5:815a:e12b])
        by smtp.gmail.com with ESMTPSA id l37-20020a05600c1d2500b003f1738d0d13sm1805978wms.1.2023.04.18.01.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 01:31:07 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com
Subject: [PATCH v1 2/3] thermal/core: Reorder the headers inclusion
Date:   Tue, 18 Apr 2023 10:30:54 +0200
Message-Id: <20230418083055.3611721-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230418083055.3611721-1-daniel.lezcano@linaro.org>
References: <20230418083055.3611721-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

