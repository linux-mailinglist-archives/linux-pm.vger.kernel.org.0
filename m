Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E60B3539DF
	for <lists+linux-pm@lfdr.de>; Sun,  4 Apr 2021 22:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbhDDUfl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Apr 2021 16:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbhDDUfX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Apr 2021 16:35:23 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0049CC061788;
        Sun,  4 Apr 2021 13:35:17 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ap14so14394959ejc.0;
        Sun, 04 Apr 2021 13:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SSBymFhhyIOqT321UgDWQ2JC+SXzbKlWvarnWPwT9jc=;
        b=bed2VDtdrBvmbK1cD6XYkh/Z2MBHlk4qHfuFUwjHt03mtOZ1NMjvlt+weiD154CMW/
         KSwGDtPcG0MeL2fxGWnNn3KbP05+M+dE4W4bmZVDBFJIe6NcywZy/yBhG3p3eOCIY7iG
         8MDCZSk7XVD9//joptDe6XR8NncpZYcnEQSp+Tj/VpOH20/OgfGK63ejwTIStimqZNXd
         dJ8qiWmIOb3c+3Y+BI1Ys46d3b75GpwiVD4N7V5TGeqTtdGfihIGQOKi/xS3SDeWYRgF
         phhywvULnfpybJR4y9+xw6/rFLE9d4HAwJGIhOkTFuvIKdnxpoWaiTktBEGSbulp1Dui
         sltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SSBymFhhyIOqT321UgDWQ2JC+SXzbKlWvarnWPwT9jc=;
        b=rdijtgO0gsalFfqAn1UoRa7fKsr3YvEDkwGjtSBA5d9YlnzKrOHBCW3Ws4c/99gQyM
         UcohuonzCkPe+jtjEW9q0MUNiNC7LUnH6IEAlDFcQSIpw6rXgKz+W9WNWh3qu3Bhs2zK
         5Sl2Hm9LKq8Qb2dfSeNpXVk2uc9qq+wAQ3feKQ7R1YYhHFOxzybGHF5bVoseJm+elE1s
         xkcKGeMcByMYmllkOQoI8zBp7Zp/UAtKfryW2mxkhWniM5LLqFsgcsn+znPzTwHNXA0z
         A/Rb4y0tHlpRO8zGsfnkhmImgUppNGt7vVWWh4Hn5E5O0uIcgKMhImiYVxzn75Bc5DWv
         DWvQ==
X-Gm-Message-State: AOAM533TAUF8mquEQQu2R4ZGh/3rDc1cgn/DlLZeNzFVXS7BGY8XxkCr
        y8IAyS0aWoR7tll7Qa3Vxco=
X-Google-Smtp-Source: ABdhPJzhcFfEv0pDiSkqaudYaSWgzrzFCiy+bfJ9/yHSePw7GYcI12Xc2lwuhg+EN+bWYHe//Ng+ZQ==
X-Received: by 2002:a17:906:b341:: with SMTP id cd1mr24876762ejb.391.1617568516617;
        Sun, 04 Apr 2021 13:35:16 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-79-52-251-187.retail.telecomitalia.it. [79.52.251.187])
        by smtp.googlemail.com with ESMTPSA id s4sm7191140ejf.108.2021.04.04.13.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 13:35:16 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v14 7/9] drivers: thermal: tsens: Drop unused define for msm8960
Date:   Sun,  4 Apr 2021 16:48:21 +0200
Message-Id: <20210404144823.31867-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210404144823.31867-1-ansuelsmth@gmail.com>
References: <20210404144823.31867-1-ansuelsmth@gmail.com>
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
index 9cc8a7dd23ae..58d09e927383 100644
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

