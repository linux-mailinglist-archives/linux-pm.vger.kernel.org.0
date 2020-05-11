Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3091CD9A6
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 14:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbgEKMZx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 May 2020 08:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729837AbgEKMZw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2020 08:25:52 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517DBC061A0E
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 05:25:52 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t7so3880318plr.0
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 05:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CNjMX4Q50x2uZtB4NYh8/Da4gpgdASbh7q3Dr2tPrVQ=;
        b=eb7YFu+ZwTh0kdRzfvf0DoWF3+HZqXzNxoucioWmLAplPiYL6HvXU+u/lkC+JA3ZzQ
         D3OPLNTYWBoIhtiCIqGJ48OvRcIPxbXUJ9AtCXE6qVnmPQz3oUxq5E4AwTb/nbJduW79
         JS7NAtR0hVYCuRMUNXkY4DqS2S8oe55KeLrQUn+bkBD/p6seUuz8aOhaJS8pzgAZ/j5W
         vC0kJzc4N5K7a6Txud/eo0ckNLqHljjsf8Yb8ziUnpJ9QFiM7eX6g0OmTcyjCHAsPRs5
         N98I9FJHBy2wWXm4Cq6rLT4w/mbEdZBcwJymAmalRQbwvdVWEU5vSa+RF9fzrOvmK/vx
         0bSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CNjMX4Q50x2uZtB4NYh8/Da4gpgdASbh7q3Dr2tPrVQ=;
        b=mw4eAiTwxTWSkWnIvWlqTQVFId/41gss8+iSz3XJNfsrekRjxgWfG3RflEX95vEnGV
         1eekdFVjtZKBhwjFQWcQnVAGkFlei6u9rFCr3tKycjwMC1UkC7BkPWzPoDmySyt3R9uS
         uvECrQvtnr13ByjrX++Ytf9ir31JTMKkRQ4BUTUGAmRRdkrvqZ9SwLJwmSY88ksdV+Hn
         HMfEXESo57EvYIxTVvwf1na7IbM7SdKkRyS0bqzZ5/i4BtxZBgJc0ToLZl8v3Hqj09Ph
         CCNalDEPoITVDgpSl+htAw81naYOpbR9U/AupofBkpgjLljIqiiMkQv0gFo/EyjD4MbO
         uGJg==
X-Gm-Message-State: AGi0PuZGePXJthUTIX0SOrYPMtp3RmVJzF3AIhvVfiDCJljL4wJV1z4A
        2BL/FOMXqnArKu+F5Zps0M1Eww==
X-Google-Smtp-Source: APiQypJr6Iz0W0TXA7y6Xi3bZjA5ak5FQ3uvSh+4LgtY2bsmfCxDLRWUEUsLZlmkB2/rkPFogPpleg==
X-Received: by 2002:a17:90a:f418:: with SMTP id ch24mr21983158pjb.68.1589199951878;
        Mon, 11 May 2020 05:25:51 -0700 (PDT)
Received: from localhost ([45.127.45.102])
        by smtp.gmail.com with ESMTPSA id o99sm10158324pjo.8.2020.05.11.05.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 05:25:51 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Javi Merino <javi.merino@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 05/14] thermal/drivers/thermal_hwmon: Sort headers alphabetically
Date:   Mon, 11 May 2020 17:54:53 +0530
Message-Id: <29b64f1fe81e674c753c8f8309c310acd782ebea.1589199124.git.amit.kucheria@linaro.org>
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
 drivers/thermal/thermal_hwmon.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index c8d2620f2e42..e43ae551592d 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -10,10 +10,11 @@
  *  Copyright (C) 2013 Texas Instruments
  *  Copyright (C) 2013 Eduardo Valentin <eduardo.valentin@ti.com>
  */
+#include <linux/err.h>
 #include <linux/hwmon.h>
-#include <linux/thermal.h>
 #include <linux/slab.h>
-#include <linux/err.h>
+#include <linux/thermal.h>
+
 #include "thermal_hwmon.h"
 
 /* hwmon sys I/F */
-- 
2.20.1

