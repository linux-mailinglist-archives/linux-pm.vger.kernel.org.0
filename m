Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B597F1710
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2019 14:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731906AbfKFN3Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Nov 2019 08:29:16 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35484 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731886AbfKFN3Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2019 08:29:16 -0500
Received: by mail-pf1-f194.google.com with SMTP id d13so18893016pfq.2
        for <linux-pm@vger.kernel.org>; Wed, 06 Nov 2019 05:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=0/+bQx5JHQOuiZKynMK7gLFGYPX738NgMSopvzkwjoc=;
        b=vKaw0thV8SCCNxndmd8ReWx7owdb6CYDzHnrVasmMSUyjnLsYByCBUxwC6BIPwswFD
         9XVykLdF9C+khBoYg22d3yidwUdQjnFxZI1QZo+hN7LVFNoE+RquwAdieDc1JEsP/D8c
         lOVq3XwJmwgUTrDceyVfL+6lsrxT/7PhwOF3c5Shy0hIa/qI7y+OB1POpA13KVF+E5XO
         /KJ56h9Q26ntU1d4iQslEZ7bH/Tcbuv+SyBCGQnXnJO+6hbo9v8BeSKHUcbHhsMKVqfa
         VVul77IsGuDvX43/uBx8RamZRPHu/y0+k9/5G9FwIURfnsznL4L2F0uV5LNT3BT6aaCb
         13mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=0/+bQx5JHQOuiZKynMK7gLFGYPX738NgMSopvzkwjoc=;
        b=cndok3R4tT4VEn3wVG8u3AgG2T3zK8yvgEprbYu13WInL3mLHVvVjVdgs1Th/aNJBH
         fgznfbOIRLeGKqh8WswLlQzu5sOOwQ7Z6GMumofTOYaYKgTJX67VG55bQa7X3M/TlGuq
         8HR79TAYveg3tXYKycACpZMiNmLKoPxa6emzVcgsv3r7wtiUM4OMQAssgad0AvlfyJD/
         i1AtlzoCHhtMPutc/4A1FOmDLvtd5gm+O9mwNZXYs2G31gRe5Yprj0Z6evAOZRUhBOIi
         e1hzQBZwcwIrok5YWuWVSinTRYdysSdNLIOEj5Bt8MfAIbEj4LerTSso2vmzX1D7uiVP
         eYPg==
X-Gm-Message-State: APjAAAW74U+V/VGbErZrbBVqVZuXZAP5Q0kLOW/mj6hkOEBw8ZJHw+eo
        DpLOONmvW++0VAFsD3fSrq0g4w==
X-Google-Smtp-Source: APXvYqxvZgZab1KEfHyZn23Q8fAfHbj7kAdbsruoNK1+DZhbhLOnlkiWUa/oLodrwE6PPX4nAUw5wQ==
X-Received: by 2002:a63:1065:: with SMTP id 37mr2843407pgq.31.1573046955366;
        Wed, 06 Nov 2019 05:29:15 -0800 (PST)
Received: from localhost ([49.248.202.230])
        by smtp.gmail.com with ESMTPSA id c9sm34805754pfb.114.2019.11.06.05.29.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Nov 2019 05:29:14 -0800 (PST)
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
Subject: [PATCH 10/11] thermal: amlogic: Appease the kernel-doc deity
Date:   Wed,  6 Nov 2019 18:58:26 +0530
Message-Id: <2fbace543c7a45799f29f87d9aee82f2ed1a7dbe.1573046440.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1573046440.git.amit.kucheria@linaro.org>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1573046440.git.amit.kucheria@linaro.org>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
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
---
 drivers/thermal/amlogic_thermal.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index 8a9e9bc421c68..ccb1fe18e9931 100644
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
2.17.1

