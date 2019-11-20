Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2A5A103FBA
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 16:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732492AbfKTPqG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 10:46:06 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44932 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732444AbfKTPqG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Nov 2019 10:46:06 -0500
Received: by mail-pf1-f196.google.com with SMTP id q26so14388019pfn.11
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2019 07:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=AgDAyNnziZ2/rpXVW+6uZm6qCS/g3MtXyy21omVhiKk=;
        b=TTD/GPgbVJlqWJezadRMyot/6RcSAW4tTnmkmdhwjB+qH876bPgz4yk5cS7IiGyP3K
         trLYX6i0Vl5wNDbXS6dOb4z3Jji0Zde+ZejgKmxq+3s/LVxGpRJbJv8Gl2YzYZ2azXgr
         J/YNU2VewuB697Ynqi/+TODfrCjqZ3gVhcTfO13sryD2gZlgriNpW636jt++tlGJQZQP
         d6nK84JZI6WOMBLBBUMqz4sR9NWbVcGQ2fRx3/ctZE88lH5y/l2gMKLwbSOxWVXk/j53
         atgnWdYX91MJ1T3R5xvOHUtLt7nF+uncFHBbik2aiHOtlUqjlO4/wzlwJ5J3nE2GEpua
         Fppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=AgDAyNnziZ2/rpXVW+6uZm6qCS/g3MtXyy21omVhiKk=;
        b=rVgF+2CYD4t3xOpKHzJuF4tc/ZZmr5AcLlUyfzHp3zK/3OsyoFdwyZ/agNUquddIgs
         4ElImKNG1qsDZFNhievBdgoaYhRlxqxesx74tJ3efMxoXuYtxc2vscwVXr/RCfMO7noH
         6/aYQOxyvMNTE0QeE82++E2G9n89/iXwINoJ7Pfxp5LygkccOFJJyQpKP9VGb5Ml55sR
         Bs1bhfCmNXI1l6dvkT1UX0TixeU7rx0nMItCD5ki25K6opFM7PjnGr0JFB0EebaztqLH
         Ci0m1f7KqmiXPKsjW0gzRMnEMdjHWOLkCYhQNl7NxW2u9fx4K/zoKdD3KVR2z9ZgSVQS
         9KiQ==
X-Gm-Message-State: APjAAAU6Q/yh0lYMVs410RcTzcUP2N50uPafyRXSrHeXG1/a2CBAmhUr
        U28AlQgp0LwjNlQjjISmaFq0gg==
X-Google-Smtp-Source: APXvYqyB7lY58RH7CXaXDrsbQa1IXAGZ2t49P4RvoB6lsC3HH+gC0HPsfAEo+5uM2xZEinvTSMklGw==
X-Received: by 2002:a62:e119:: with SMTP id q25mr4862880pfh.161.1574264765290;
        Wed, 20 Nov 2019 07:46:05 -0800 (PST)
Received: from localhost ([14.96.110.98])
        by smtp.gmail.com with ESMTPSA id 136sm30313724pfb.49.2019.11.20.07.46.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Nov 2019 07:46:04 -0800 (PST)
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
Cc:     linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: [PATCH v2 10/11] thermal: amlogic: Appease the kernel-doc deity
Date:   Wed, 20 Nov 2019 21:15:19 +0530
Message-Id: <139c9191f1a18d528b5f94376facf40291d28244.1574242756.git.amit.kucheria@linaro.org>
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

linux.git/drivers/thermal/amlogic_thermal.c:78: warning: Function parameter or member 'A' not described in 'amlogic_thermal_soc_calib_data'
linux.git/drivers/thermal/amlogic_thermal.c:78: warning: Function parameter or member 'B' not described in 'amlogic_thermal_soc_calib_data'
linux.git/drivers/thermal/amlogic_thermal.c:78: warning: Function parameter or member 'm' not described in 'amlogic_thermal_soc_calib_data'
linux.git/drivers/thermal/amlogic_thermal.c:78: warning: Function parameter or member 'n' not described in 'amlogic_thermal_soc_calib_data'

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/amlogic_thermal.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index 8a9e9bc421c6..ccb1fe18e993 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -67,7 +67,11 @@
 
 /**
  * struct amlogic_thermal_soc_calib_data
- * @A, B, m, n: calibration parameters
+ * @A: calibration parameters
+ * @B: calibration parameters
+ * @m: calibration parameters
+ * @n: calibration parameters
+ *
  * This structure is required for configuration of amlogic thermal driver.
  */
 struct amlogic_thermal_soc_calib_data {
-- 
2.20.1

