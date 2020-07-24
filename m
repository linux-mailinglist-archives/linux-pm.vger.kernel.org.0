Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA43D22C50B
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jul 2020 14:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgGXMWE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jul 2020 08:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgGXMWE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jul 2020 08:22:04 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A73C0619D3;
        Fri, 24 Jul 2020 05:22:04 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id k27so5137113pgm.2;
        Fri, 24 Jul 2020 05:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rjrq4JxLWpIc39g0Y05S4Ho6toVlbizG0tABV5u04QY=;
        b=tP8O1cKy1P7PU7WsJsDFkjNZWiYdtY/U4WnhnzXV2x3sxLxMf12d+xtbVz17rDQ/WD
         K018S82IoABEx6tRS6Y946IYd/+BwFaIJumZJHene6h24KT0iIFLOz7aZ5NzFG2rmBMj
         a9/axkDvZGFBAGDt+RxjzQS37eu/eMH64g/mqEy9ADHvMCEPyZeaZ7RNIajnJu+z49y/
         t3hQagQr4Kp2/2K0m82AqC+1JnMcLHCbtLs8iKAtOeBKw2eY6RPpUktyteSMBiQS04ba
         pxlxhKwOrSqUM5ORypT2BfXwOUZ954pTTiNUU2plXrrBKWegAbDCQ6UwJZR7EssPkz8P
         kMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rjrq4JxLWpIc39g0Y05S4Ho6toVlbizG0tABV5u04QY=;
        b=YwCmaweAki6fL1+WLUU23Ik8JdTZXdDvGIlnNYSDfd26isBIdVqMcXe3KGjh5ughI5
         DqSNTO6IWQZsZWBCBc39yqjSmptu+tw3hLOKFEHBXTx40Ky56t+K0PxwsdpEEgGNNp6p
         OuwyeJ6NzKfyH7sldK6pjJ4kP5jw2dUm0OQGTS8A7j9uP/DsG5mOQGx/jjG6HvZFrEGg
         Ev0x6bMyP/LJyQ7DoqIT99CxWtZ4HDsUNgs3GH7jBzxdyRNw1Kk8RgBYxVkwYxh3Af5m
         RT/10wdhvD6LYMhrzh3x1wS6FHg7KSlne+5WGExnUpmpKGW+ZBvretfHWxl0RvXO1tKP
         4A3Q==
X-Gm-Message-State: AOAM531CIE8VaCPr5rfxP3ndod0nAp3fX2LKb04xNuaqolm/yoOnaJLG
        +G8DJInN7WFHBymtac5353Y=
X-Google-Smtp-Source: ABdhPJxNM5rIu3KaS1MWAf5H7vmy3q3BSToKRqHap5ZfoincstSZRvWBA5s005vCD910UvyDhPcbnQ==
X-Received: by 2002:a65:6846:: with SMTP id q6mr7763851pgt.397.1595593323913;
        Fri, 24 Jul 2020 05:22:03 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id r185sm5766819pfr.8.2020.07.24.05.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 05:22:03 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chen Yongzhi <yongzhi.chen@unisoc.com>
Subject: [PATCH v2 1/2] math64: New DIV_S64_ROUND_CLOSEST helper
Date:   Fri, 24 Jul 2020 20:21:47 +0800
Message-Id: <20200724122148.26541-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200724122148.26541-1-zhang.lyra@gmail.com>
References: <20200724122148.26541-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Provide DIV_S64_ROUND_CLOSEST helper which uses div_s64 to perform
division rounded to the closest integer using signed 64bit
dividend and signed 32bit divisor.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 include/linux/math64.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/math64.h b/include/linux/math64.h
index 11a267413e8e..cd0693989436 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -279,4 +279,23 @@ static inline u64 mul_u64_u32_div(u64 a, u32 mul, u32 divisor)
 #define DIV64_U64_ROUND_CLOSEST(dividend, divisor)	\
 	({ u64 _tmp = (divisor); div64_u64((dividend) + _tmp / 2, _tmp); })
 
+/*
+ * DIV_S64_ROUND_CLOSEST - signed 64bit divide with 32bit divisor rounded to nearest integer
+ * @dividend: signed 64bit dividend
+ * @divisor: signed 32bit divisor
+ *
+ * Divide signed 64bit dividend by signed 32bit divisor
+ * and round to closest integer.
+ *
+ * Return: dividend / divisor rounded to nearest integer
+ */
+#define DIV_S64_ROUND_CLOSEST(dividend, divisor)(	\
+{							\
+	s64 __x = (dividend);				\
+	s32 __d = (divisor);				\
+	((__x > 0) == (__d > 0)) ?			\
+		div_s64((__x + (__d / 2)), __d) :	\
+		div_s64((__x - (__d / 2)), __d);	\
+}							\
+)
 #endif /* _LINUX_MATH64_H */
-- 
2.20.1

