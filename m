Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67DAD3411B9
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 01:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbhCSAxK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 20:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbhCSAxA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 20:53:00 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BB0C06174A;
        Thu, 18 Mar 2021 17:53:00 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r12so6903336ejr.5;
        Thu, 18 Mar 2021 17:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WwhOO3uzgv8OyC84gx9WfGcYMkm51xg9C5EokLWNvU4=;
        b=a2RCkmKhUh1Ux7sq+RFPQl9CO2hdmYUUIo6j6o+PvxVMZHCBe99tnEIQWj+MJLARQy
         0oNXTCtWxwnpb8UtSrbmgliJeVc54bdGWeWgb2igQLV932gca0kCdqlEuHOftOEokESd
         reus3ZksEInzc02DIe55AzQvoeev1upMHC9PBzh3wJH84oQucdKAP1rIK/YjvUI37/bO
         Fh6q9XSTxc5JAN8LOydYxzjdWJTBzsYspI+RsA2NSxSnSTVuOZZjk64PgtDVuwK0Ks5e
         Vm4HMMPlLnhGrwrbSpMKiWHNW4yVnETLc9km10VK+7ZAKlz7FLfBAraPW3ClmRYdmwBU
         Nd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WwhOO3uzgv8OyC84gx9WfGcYMkm51xg9C5EokLWNvU4=;
        b=aSI5EfhsDFGbsQ8JM3f09ic2+IbNnNbPo+gXWpUdSMqE925+8GCHQP5xcPdFwOGWqJ
         nTnVdCkQImCmgqP3qrpn+brEghQBa1nF5+e79+9+D4xn03TzKX9cO8b7gxG0Q1LVzYEz
         oI7dXqe6nJvxYo2H8qWQ5qk6NM0mDjcxyj0naTEvzDoSzYGd7Cm3gX3F+7nsVZac16I9
         i7jHoyn9zDOtAaN6Fllcycpxnf6ObhV2CYVprrWN9qcPzdkyW5EB13tEiUl1E4KVDL0O
         xNnkc5SH1IvrF3XOGDUueNLd9KbiTds3bd7GZtYWBUP+DCETd6AHC1hL+rKrJ+Oof7Wv
         peeQ==
X-Gm-Message-State: AOAM532aF6XcNGWMB6fp3L7pV6g8xau8nj7h0h96+nDbEr9cWw9iXNAS
        Xf/9TnFtT4yFMz8LEf+fMpI=
X-Google-Smtp-Source: ABdhPJyQnnFmyRgAlBq3jG8emjxONeVLIOvuOHx0MPMkMzjXb+TtPDLxfaQhhC54W/VB6kxfexsBbg==
X-Received: by 2002:a17:906:1444:: with SMTP id q4mr1446941ejc.343.1616115178763;
        Thu, 18 Mar 2021 17:52:58 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-95-233-52-6.retail.telecomitalia.it. [95.233.52.6])
        by smtp.googlemail.com with ESMTPSA id q25sm3186976edt.51.2021.03.18.17.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 17:52:58 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 7/9] drivers: thermal: tsens: Drop unused define for msm8960
Date:   Fri, 19 Mar 2021 01:52:25 +0100
Message-Id: <20210319005228.1250-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210319005228.1250-1-ansuelsmth@gmail.com>
References: <20210319005228.1250-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Drop unused define for msm8960 replaced by generic api and reg_field.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens-8960.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index 8c523b764862..31e44d17d484 100644
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

