Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1DC365F67
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 20:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbhDTSew (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 14:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbhDTSeq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Apr 2021 14:34:46 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E85C06138A;
        Tue, 20 Apr 2021 11:34:13 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id sd23so51110409ejb.12;
        Tue, 20 Apr 2021 11:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I2U7MnAPAwOrFGhE4r40Lq3vVf52NabEdANX/dIyj30=;
        b=s0FWufzapRquZB/NUwR2GA54vvYkFWY2Vx7wn+TEALoOjZ9y5rr5XKQB5iln6Cz7+A
         YMSWktFDT8e9vlcwgmh5t+jLLxIk/fjqzGRZjfLneFzFeEWhClKdn+8vi9eeokQvgz43
         V4GOS5d7ezF2TgPvTc68o1YDKFvjqWfmQWvYF16gZF/j0MWa2bqG0IxnKKLtOktawoTh
         tgdobKVCEmOeMsGPXa4l2je9nzXxntowZZ2i4KnRKEgivmM6U9lfEwEXAmgPsKjFRyiF
         ZBA0pe/2dJu6BhT+mky5Em66A5mh2DHGrmKk3eDDwvvmwZb/jksrT/r6frSTWHK25InB
         HDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I2U7MnAPAwOrFGhE4r40Lq3vVf52NabEdANX/dIyj30=;
        b=HNSumHhpWQ3ILKQ6NoFcEtIwC/GPB3FVEmuiGigDNwFAgr8Vv9JrdwNQHiRPyqg3ru
         4akzGGjA8qVIOEPlquLlth9MsZy9a5c6rpBRU27XPwX5t5wwYCNoq6z4q34kRmlhVf6Q
         4wOm3mYDchoLRQ11ybx5j3c08tdYXys8TLkJnXVtHFMsQL9nsIFweD2WctuCl/1AQYYf
         YIQ/xy/55C9PFUG+RReswwhmpx58R31DKNqxHZ3Gr/8gjgXqN+GIFDEtxDSx9jVm2eiC
         B7TCVkkpeFz12e90NL4Jxfuhojq8Q7oCBlPhYyG2uYlFEtVbn4dHj8hkxFHgx0V7xmtL
         hCwQ==
X-Gm-Message-State: AOAM531Iw3z8FyZJrEbCneJRthPRHCp9rfjhrpnnaso8J10p1GahZhB3
        yNld5JFXAa6T8yDNWgha9f0=
X-Google-Smtp-Source: ABdhPJzM1lVs+WBXxxcGeeBTL2TpVBZHziPNBghXHfRDZDyeKluoSIYfzvLKCXg3+0UUgG/I67No0g==
X-Received: by 2002:a17:906:2652:: with SMTP id i18mr28772446ejc.189.1618943651742;
        Tue, 20 Apr 2021 11:34:11 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.googlemail.com with ESMTPSA id n10sm13357141ejg.124.2021.04.20.11.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 11:34:11 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [thermal PATCH v15 7/9] drivers: thermal: tsens: Drop unused define for msm8960
Date:   Tue, 20 Apr 2021 20:33:41 +0200
Message-Id: <20210420183343.2272-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210420183343.2272-1-ansuelsmth@gmail.com>
References: <20210420183343.2272-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Drop unused define for msm8960 replaced by generic api and reg_field.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/thermal/qcom/tsens-8960.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index 58112f0df..67c1748cd 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -10,8 +10,6 @@
 #include <linux/thermal.h>
 #include "tsens.h"
 
-#define CAL_MDEGC		30000
-
 #define CONFIG_ADDR		0x3640
 #define CONFIG_ADDR_8660	0x3620
 /* CONFIG_ADDR bitmasks */
@@ -21,39 +19,19 @@
 #define CONFIG_SHIFT_8660	28
 #define CONFIG_MASK_8660	(3 << CONFIG_SHIFT_8660)
 
-#define STATUS_CNTL_ADDR_8064	0x3660
 #define CNTL_ADDR		0x3620
 /* CNTL_ADDR bitmasks */
 #define EN			BIT(0)
 #define SW_RST			BIT(1)
-#define SENSOR0_EN		BIT(3)
+
 #define MEASURE_PERIOD		BIT(18)
 #define SLP_CLK_ENA		BIT(26)
 #define SLP_CLK_ENA_8660	BIT(24)
 #define SENSOR0_SHIFT		3
 
-/* INT_STATUS_ADDR bitmasks */
-#define MIN_STATUS_MASK		BIT(0)
-#define LOWER_STATUS_CLR	BIT(1)
-#define UPPER_STATUS_CLR	BIT(2)
-#define MAX_STATUS_MASK		BIT(3)
-
 #define THRESHOLD_ADDR		0x3624
-/* THRESHOLD_ADDR bitmasks */
-#define THRESHOLD_MAX_LIMIT_SHIFT	24
-#define THRESHOLD_MIN_LIMIT_SHIFT	16
-#define THRESHOLD_UPPER_LIMIT_SHIFT	8
-#define THRESHOLD_LOWER_LIMIT_SHIFT	0
-
-/* Initial temperature threshold values */
-#define LOWER_LIMIT_TH		0x50
-#define UPPER_LIMIT_TH		0xdf
-#define MIN_LIMIT_TH		0x0
-#define MAX_LIMIT_TH		0xff
 
 #define INT_STATUS_ADDR		0x363c
-#define TRDY_MASK		BIT(7)
-#define TIMEOUT_US		100
 
 #define S0_STATUS_OFF		0x3628
 #define S1_STATUS_OFF		0x362c
-- 
2.30.2

