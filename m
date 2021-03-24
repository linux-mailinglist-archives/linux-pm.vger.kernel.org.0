Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86ABC34840B
	for <lists+linux-pm@lfdr.de>; Wed, 24 Mar 2021 22:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238615AbhCXVol (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Mar 2021 17:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238576AbhCXVoU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Mar 2021 17:44:20 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAB4C06174A;
        Wed, 24 Mar 2021 14:44:20 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h13so136613eds.5;
        Wed, 24 Mar 2021 14:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SSBymFhhyIOqT321UgDWQ2JC+SXzbKlWvarnWPwT9jc=;
        b=eRRGczY/AFREH2iz5vPYz933QY+0K3hTmtDIqPlIqoa8VRJUc7wEjomilHoIBz3+sH
         YqJldE72EyxJzlm/3+khPDvW8XwqmA9fayrLuUeJiPOBjoxEHVF8b4S09stHrZQ7req5
         bglgZylgBcJ4L20sup4+fShG+3yB0qNv8ENurZ8R5DBa0bmUDV4f8jcgxC+Pi1bw9xBc
         TmcQa1yLje5wIRZZEiMsERQ7QKU88cTGZyLtZgXMz7BfVRNLe+CP/n/cCl0ll6QtymDk
         hxd8GgjAF70Eal/Tv1FvgQw3J34tPsvEWqmXTvvhwVXNkR+ZBJONF3qUxNTrTd4pAatV
         dRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SSBymFhhyIOqT321UgDWQ2JC+SXzbKlWvarnWPwT9jc=;
        b=bOjK+C3qDZ3kRsd6XofsisKdPxGFJV98o5jPbN+1tyldvj74o3KxUMot1BOuWvCn79
         5W0/F+IdVKEzy9esNRQ5DqiCMYPwqxLLr1k/+MjmDQK/V8Kx1QQbsnT8u4xKpE7unSYU
         tiSkVcs0EdalzDqIJoa9rvjyKHvsYhy9W0LJrUNJLuhj3Af0gjbSyD1E1jEgPHsLCwz0
         GEIryj/IdCMrf0P9OdozeWgBN6So0zCbImUxROpAeCOQefSI5fEhfAy4YcWONRV6Bv4y
         PzL7ejcErdsYlisttjtsPdQxHBM1WCq+63nT6Oif2fgJ4kHnCTHSREG+KkrzOnvzuQid
         5ADg==
X-Gm-Message-State: AOAM531BQE67gUZFZiXMJ8oXFw7ypcYBnvhyluEoGXweaoDPrL0CjaBe
        ivt07CX5ZJSvBRjeeOKFIHM64u0Nqj4=
X-Google-Smtp-Source: ABdhPJx3QR9xcwie7j9XRJMhlK9MmTzjUKCvEa4+RYsQzoqNy1NEl4+bQ4jYoisCA78Vi6JGNwgl7g==
X-Received: by 2002:aa7:c3c4:: with SMTP id l4mr5583334edr.335.1616622259008;
        Wed, 24 Mar 2021 14:44:19 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-79-34-220-97.business.telecomitalia.it. [79.34.220.97])
        by smtp.googlemail.com with ESMTPSA id z9sm1871211edr.75.2021.03.24.14.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 14:44:18 -0700 (PDT)
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
Subject: [PATCH v13 7/9] drivers: thermal: tsens: Drop unused define for msm8960
Date:   Wed, 24 Mar 2021 22:44:01 +0100
Message-Id: <20210324214404.798-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210324214404.798-1-ansuelsmth@gmail.com>
References: <20210324214404.798-1-ansuelsmth@gmail.com>
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

