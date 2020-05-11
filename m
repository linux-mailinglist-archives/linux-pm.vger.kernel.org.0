Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BDD1CD9B9
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 14:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbgEKM0Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 May 2020 08:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729979AbgEKM0K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2020 08:26:10 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31977C061A0C
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 05:26:09 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id u10so3872733pls.8
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 05:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yOzb3IhTI9yPWNl3XI2lYK3qvd7pN2r4jllGR7pHWUQ=;
        b=pwhHoSUCVHs+05wGk4aMRqL1g9yeGAnLqwAgGUoSMQJ0rc7mu49oBcm9LjSVrbFYZQ
         t8Xvu3w3mIEtvn8POrFFF4fBtnl5XqCOZTO6CZ0tE57miFK5qYk64oC4SpZzNnQ5hlhK
         JNMsaI4WqG0kAe0ql2N3FSfvRtcBG3byYgGV1o/GR6F3gwnDSJdsX3GOrgU8z3S0R2U2
         x8hTwg9E6VxijuJydfTP+Nt8OK03Qk9t6cMuu9hSEAj8J0iZ+WJ3UYmUZ5elnhJHN9UJ
         Md6pZGWSMG/GjmxQOFdcq4oGCcQXmBlDLKggHQ02Vo2gx3VHutK/phHRuGIiPP9/26pX
         pzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yOzb3IhTI9yPWNl3XI2lYK3qvd7pN2r4jllGR7pHWUQ=;
        b=ofzm9HqO30STLrHmZnKb8a5SL/XmwdxbH9A3zVnWJIH3hitcAzpLlYgGUHsGlf6WKZ
         9bxP9IjgTMCtKXjauVFkBgOUecsSDpE8Rh4MdyhlE6ts8DbpWa1MiKz23PQ1NERmSbwW
         XNOHpVe3iRzWiNBFAKM/Jbv2dUbf6J+TWMNr8wU2FOkbOfkaQ/RCT/YKp0XnHg1pYeur
         gLMRtXFo5+iUfxO6ptbIz/ubp/YKRH072lSL1GzCN1R4a3j/CoXQIxcMAs7Me9sw2bpx
         eG8BzebSPcGZAQdsBLg5dGkM7J2FAR6T7VEFnxcNVFYgq9HLPGOwwp/Y6DfUAZ28rh4o
         iXJA==
X-Gm-Message-State: AGi0PuYoot4NPJQnvjxQv2cwhJVvVxSyOCGBE0aZL3M13ZFeAv6EkDvN
        G7rkYIFUb79vnfAY7BUb/6txQA==
X-Google-Smtp-Source: APiQypII8GF6w8vhEPnDEzE0HX6p4o0aWnNJi62GTULFdKWxm4PZwjkfcd95O3F+qhRPvFrwVWV1pw==
X-Received: by 2002:a17:90a:748:: with SMTP id s8mr21384120pje.221.1589199968762;
        Mon, 11 May 2020 05:26:08 -0700 (PDT)
Received: from localhost ([45.127.45.102])
        by smtp.gmail.com with ESMTPSA id 1sm9253822pff.180.2020.05.11.05.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 05:26:08 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Javi Merino <javi.merino@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 09/14] thermal/drivers/cpufreq_cooling: Sort headers alphabetically
Date:   Mon, 11 May 2020 17:54:57 +0530
Message-Id: <4231f5dfe758b9bf716981be71cadf9642c83528.1589199124.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1589199124.git.amit.kucheria@linaro.org>
References: <cover.1589199124.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sort headers to make it easier to read and find duplicate headers.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/cpufreq_cooling.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index e297e135c031..1b5a63b4763d 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -11,16 +11,16 @@
  *
  */
 #include <linux/module.h>
-#include <linux/thermal.h>
+#include <linux/cpu.h>
 #include <linux/cpufreq.h>
+#include <linux/cpu_cooling.h>
+#include <linux/energy_model.h>
 #include <linux/err.h>
 #include <linux/idr.h>
 #include <linux/pm_opp.h>
 #include <linux/pm_qos.h>
 #include <linux/slab.h>
-#include <linux/cpu.h>
-#include <linux/cpu_cooling.h>
-#include <linux/energy_model.h>
+#include <linux/thermal.h>
 
 #include <trace/events/thermal.h>
 
-- 
2.20.1

