Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392DE1CD9A1
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 14:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbgEKMZq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 May 2020 08:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729563AbgEKMZp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2020 08:25:45 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456F8C061A0C
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 05:25:44 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t9so7808623pjw.0
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 05:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oLCRFYTzZLs87148l1yniv86hl5UQjMO56irWxi7zno=;
        b=fJUWfTi+qjf0FA2vuOSnTB0kWzbREj9eSNDAzVs5d927tPPCjePaekBQZBD85KG3F5
         VED09Zw9mO6pK3PzOrC53yjo0W0be0i+lTottKW2/2Fg9uYNKryVuZNqeIaoNFTXCRG0
         mT/ztpancw2WtnOgZ3uWRikTIwKOlWXkuSh91mPYIS8GqEsj3wgVImPOKrMXT6F1MB4r
         hJmh63wUvsY8p1sRYQULAt3IAY5Toywe/F34PL9BilNxjlw2v2K70baqsl9bx+Sr140+
         7LLC16fOi5LV9JDjFENTNTiv9WCLaYx9KB8KliZ7oK46glMCLvA0+w88QSlaz+ZlD56u
         d/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oLCRFYTzZLs87148l1yniv86hl5UQjMO56irWxi7zno=;
        b=IJ/kZY068YG7Yr9kZS+6nISVJQiAcU9u2c8Js0DFqNU4Vyqv/CHtLLuC9pnzT9HxX9
         XmG8CesmZU8uXDF/0ePb0DGEF2jKbc75PP75E48AkhnQ/FTw3kMX1mAMftn3iEiJro5B
         G9UsWKBuMI6Ny0Fc09WYu58CpsK12mfP7zKqtrysDpdpSVL4CM99oJcwv86+ZOGzPQS+
         OjURh7BrTZHowhH4HG1W08hOxPP3UwDe+HMHv90ToF1GIXNfHjbNyUbC061h+YfhagNP
         uG5aCZ7aDGfgN/vv/vccgE04w0vKAyqm5tBKtZK/FGQ94h5YphW2rDgbFJaDVA2Rsdrq
         amKA==
X-Gm-Message-State: AGi0PuYpZGfG7/LPBqat3HRm6tqrEpUJOPSNH2yOT3vqnLtlXySwPafO
        4KPUQfyhWnSKtUlmWJgt96HNWg==
X-Google-Smtp-Source: APiQypL4e2jZtE6SohQMnQNdslV/ugdx7IF6yNh08RpdGCBWZWJA/HkPdZcOy2ptOK+0q4I15bUFVQ==
X-Received: by 2002:a17:902:9049:: with SMTP id w9mr15139757plz.27.1589199943796;
        Mon, 11 May 2020 05:25:43 -0700 (PDT)
Received: from localhost ([45.127.45.102])
        by smtp.gmail.com with ESMTPSA id a196sm9240989pfd.184.2020.05.11.05.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 05:25:43 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Javi Merino <javi.merino@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 03/14] thermal/drivers/thermal_helpers: Sort headers alphabetically
Date:   Mon, 11 May 2020 17:54:51 +0530
Message-Id: <133db154796f354e6c51e6310095f679e1f45441.1589199124.git.amit.kucheria@linaro.org>
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
 drivers/thermal/thermal_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 2ba756af76b7..8ea0a05404f7 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -12,11 +12,11 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/sysfs.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/sysfs.h>
 
 #include <trace/events/thermal.h>
 
-- 
2.20.1

