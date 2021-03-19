Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1783D342451
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 19:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhCSSP6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 14:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhCSSPg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Mar 2021 14:15:36 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E603C06174A;
        Fri, 19 Mar 2021 11:15:36 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z1so11867848edb.8;
        Fri, 19 Mar 2021 11:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zVZTG5BKbgtatbYmDlY1gfcJORVxWa6hUqN8vetG3ok=;
        b=FEv8TzrYYqXA+CTDLnOVL4/x5ehAqhhlC3ShZf55mxXLk3Z8yqgjQHnMiOgVIgcome
         LgG8V9hn61G6kPYv8ZzKwDO8PR1rIBZCoOGGJXTXKo0CrgodqavF5BggVJgqn8jeF3OS
         DEDXP5m7W4c7d+t273Sk32lGOtCZW/pFKlTKYbT8Kc9+KetShZ/JExjf+3iZlzihd9zb
         CRc2lKJj9n47iqd63zioqWjHaFacLWknFMKguZOrABTZ2gQQE8HMk3Zs2kM/fN1QFw1/
         x2tIU+4qIa0vMrWOEJFzHleSY2aguAfDnijctI6Riqaeo7iG3vN9yhPRewGWQQ8DXUQJ
         bQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zVZTG5BKbgtatbYmDlY1gfcJORVxWa6hUqN8vetG3ok=;
        b=SqNMW6aqUSdPw4mLptzeefsiISjtyakXulg8OfAANSsudOzciSEDbA0TGDshTFWY3O
         kwCEG+UXpy4L7czqT3De+Ej5I2iDhWxEl3pqcBImUqo7L4dIgYm6cIo+ZGWweFVl8VG8
         73pOrv3SRotDuel91xEJPG03sD/Hh8z1FSIkBaAUoGwjWgllefgk0aJZiiD1Ifz9MVpH
         ZbGu+hOq9w8aGcggfsgGsYMvYpgbIgd9MY+9MkDSdF80QaC+RDbQtF4gS0GBgK88WoID
         JObP4M77Hl/1GUor8a8ZyoY/qr0C0478LN9mwqfZOTzmsDQj3QYlw/QZAh4rM4vJQLiv
         rCrQ==
X-Gm-Message-State: AOAM531AQ7pfGwdBH+2LNw6PBOi2XzkqVh89m4yw5P57/2KKeTf01vYb
        3dZ/BFjqJCQU2pTuBthHHNs=
X-Google-Smtp-Source: ABdhPJwalN6p7QcNUEuRiRuuYJ65JAkjJbXcLEFAJj6gLYnpLW6C/jA/hW7PO8chlxamV6GxNF1eFw==
X-Received: by 2002:aa7:d4d6:: with SMTP id t22mr11344903edr.376.1616177734976;
        Fri, 19 Mar 2021 11:15:34 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-79-34-220-97.business.telecomitalia.it. [79.34.220.97])
        by smtp.googlemail.com with ESMTPSA id u13sm4170288ejn.59.2021.03.19.11.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 11:15:34 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v12 7/9] drivers: thermal: tsens: Drop unused define for msm8960
Date:   Fri, 19 Mar 2021 19:15:10 +0100
Message-Id: <20210319181512.7757-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210319181512.7757-1-ansuelsmth@gmail.com>
References: <20210319181512.7757-1-ansuelsmth@gmail.com>
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
index b139075dd004..4037f3a432e1 100644
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

