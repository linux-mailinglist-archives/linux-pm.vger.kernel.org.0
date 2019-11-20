Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E31B103FBC
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 16:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732506AbfKTPqL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 10:46:11 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33863 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732491AbfKTPqJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Nov 2019 10:46:09 -0500
Received: by mail-pl1-f196.google.com with SMTP id h13so14020647plr.1
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2019 07:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=XsaIBKQXmIKdbRdQ/GaM37eqJC/1U/v/pIK3m7cBLow=;
        b=FVXrQCwGGlFa8AiYBJLxFUB/FwOeAS6Iyd+JEgzbLkClNVuIjQ3OetLej32TbAu2aP
         MxQu2vBBglMV9Uwx934dgYhz8BoF8vm7yZS+vOEqXl6QmiezSAJWHw/Bn+mVFlDZNMFW
         cqg6O8KhRBst6sZ/DfDMK00auNWQr7GsgDHm0vX31D9JbEOEfS/lBRFkuMOcX4c8OYCe
         aOUT9+CS9AAmyM/s7C5zAQeA7vzsaEMYa1Qgm+qiXY4n7u4nhIH9OZ+4sg57WP5KyBRY
         UzGjLg202ZnsAGtWqHFCMXq9SFn01hDQwfWWWnxkeMbpqWmsB9rttG9ol1F5VQMMoMXS
         O6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=XsaIBKQXmIKdbRdQ/GaM37eqJC/1U/v/pIK3m7cBLow=;
        b=DtsxZ5FndZJ7kBpH3h1PIhmCqrnThDWTJqva/L8rauMgCAAbUM0hBz8npWkUDntXrP
         tl5ood+5sb9iuY5mKXEAuctyYVyRtpzwOjkvXvxHQ/xtHIYg/5aU/yzDdFLupTvsAJV3
         nbI/JBnmoNvWfd9d19iI/yLutKho/BUKNediI2BrTS3t3cA0Zdxxpxi8uOBfjkRx126v
         3kFew+z6QslgDgb27djsMzVvPdjABaJqP3Q2ELscjgcnvh8+SbQfYuTfAmNQB4/gKD8Y
         CakvweOEn25Mrb9h932zCZngrCFR9iuWhuxKJp3CUkLQ8TFEZSXibamBmeRt5vZNT+Pb
         vAnw==
X-Gm-Message-State: APjAAAXnJo0DdqCOMtVVq04bFz/Lz8cxzueZLHK6z8fTOb86Oy9zc3px
        zI1kqhNZy6COkCeonC4pdApWSQ==
X-Google-Smtp-Source: APXvYqwSje57oE5y3bBVJjGXG2B2M4xxUYYkxaLEakRWmjFy/GHedrja+GYKVJcVdFnwtR7GHryhvg==
X-Received: by 2002:a17:90b:3108:: with SMTP id gc8mr4878371pjb.54.1574264769037;
        Wed, 20 Nov 2019 07:46:09 -0800 (PST)
Received: from localhost ([14.96.110.98])
        by smtp.gmail.com with ESMTPSA id o16sm7414811pjp.23.2019.11.20.07.46.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Nov 2019 07:46:08 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, edubezval@gmail.com,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Javi Merino <javi.merino@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jun Nie <jun.nie@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 11/11] thermal: zx2967: Appease the kernel-doc deity
Date:   Wed, 20 Nov 2019 21:15:20 +0530
Message-Id: <1b4f6fb91e2e713ad5135f0d40dcded65dee9d0e.1574242756.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1574242756.git.amit.kucheria@linaro.org>
References: <cover.1574242756.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1574242756.git.amit.kucheria@linaro.org>
References: <cover.1574242756.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix up the following warning when compiled with make W=1:

linux.git/drivers/thermal/zx2967_thermal.c:57: warning: Function
parameter or member 'dev' not described in 'zx2967_thermal_priv'

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/zx2967_thermal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/zx2967_thermal.c b/drivers/thermal/zx2967_thermal.c
index 7c8a82c8e1e9..8e3a2d3c2f9a 100644
--- a/drivers/thermal/zx2967_thermal.c
+++ b/drivers/thermal/zx2967_thermal.c
@@ -45,6 +45,7 @@
  * @clk_topcrm: topcrm clk structure
  * @clk_apb: apb clk structure
  * @regs: pointer to base address of the thermal sensor
+ * @dev: struct device pointer
  */
 
 struct zx2967_thermal_priv {
-- 
2.20.1

