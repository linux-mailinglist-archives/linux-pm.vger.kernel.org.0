Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58DA03BFC2
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2019 01:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390520AbfFJXMn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jun 2019 19:12:43 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:37282 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390515AbfFJXMm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jun 2019 19:12:42 -0400
Received: by mail-pg1-f201.google.com with SMTP id e16so7839278pga.4
        for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2019 16:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=m4TLZqPEMkq/tS1ogLQKWFfOaA0aQt4zNnp6rjUI2w4=;
        b=UkMEzD+09sYBsteTJ5/alXDUOxw6Tq6bBhA4ABzjkFspCkfxeNT6Q/ogiW+QlS75/f
         RP8KOXBb1b8V3cGS28WKIVMk96e9Tw/n7uRKQ3fugHdAr1yH5uAgK9IsJeBYJ2nethye
         uIMlEj0mXHbYBnrIquiXFy5vGOCubhs7pDPX8C72GaMAaULIBaTAfp6W/ACf03ZRu9HK
         PFUfr8Ncln++Fms8sEvUe46lDLEZ12psNgEIKFQrCn11U8CGX40vj6gfSAX6cTwLpKF+
         cGbpOdkYG53V4/Hz9mOp1OARhfROgx3ziTkmWHiailuNp1F5OSdRwzhN5QyZ+Xy7nJDe
         7dPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=m4TLZqPEMkq/tS1ogLQKWFfOaA0aQt4zNnp6rjUI2w4=;
        b=qqn2xhaSZ4gnEQY8wVXwRNouQhBde/dFRiSqcvmptehDUi2HAjz4o2/7sGv+iFUmoI
         yNDebuEFuBe++l72qItPZC8m4+iyi0KfgYd646mtinYXQ2KtE3EgszPwQo9K4qF3Nz2q
         jBqhpm+ep40zN7U3LQ1eihZ3HSSg5+mIpuQiVj1Gs1YpqGxzMQPzr/ygolUhOYwj8BPK
         EFvs1xqqmCSUCPf8BKOc9SLmOtqc6ayFtFbKw+1Ug4EujsohNxscXYcgalxFzJK5YzJP
         dl17ohiqcyjGkKVBOiIKhpxS3nKPZRrrjqUJIAkFWZWbhn1aCfADglpXbeyJ05AvjTsI
         jzow==
X-Gm-Message-State: APjAAAVZfh5bWqhnYwhQ5VekJGnYWYxbEODjwioY/e0OXEk6hdg/BKaw
        sxtNT7Cjxl7OyVDx9WhDXP3hNU69Svo3tu8=
X-Google-Smtp-Source: APXvYqzj61nHsPV2Nnz8RkGG1t3bqBBH1v4vRGcQxQnVXAszVjWtTkb2v4p79LlH8bRM5ywLvfTa3IAI7Cpo+fg=
X-Received: by 2002:a63:364f:: with SMTP id d76mr10242426pga.147.1560208361843;
 Mon, 10 Jun 2019 16:12:41 -0700 (PDT)
Date:   Mon, 10 Jun 2019 16:12:39 -0700
In-Reply-To: <20190608054711.GZ22737@tuxbook-pro>
Message-Id: <20190610231239.103913-1-saravanak@google.com>
Mime-Version: 1.0
References: <20190608054711.GZ22737@tuxbook-pro>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [Example code] crypto: qcom-rng: Add interconnect devfreq support
From:   Saravana Kannan <saravanak@google.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        0001-crypto-qcom-rng-Add-interconnect-dev.patch@google.com
Cc:     Saravana Kannan <saravanak@google.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        vincent.guittot@linaro.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        sibis@codeaurora.org, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is just an example code and I'm not actually trying to get this
merged.

Bjorn,

This is what the code would look like. It compiles, but I can't test it.
I'm not sending this as part of the patch series as I'm not sure what
the interconnects property should be set to in DT for qcom-rng device
nor is QCOM RNG an ideal candidate for bandwidth scaling using devfreq.
It can probably just set the bandwidth to some fixed low value like 1
KB/s. But this is pretty much all the code one would need if they wanted
to enable interconnect scaling for their interconnect path using
devfreq.

-Saravana

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/crypto/qcom-rng.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/crypto/qcom-rng.c b/drivers/crypto/qcom-rng.c
index e54249ccc009..7a92238061ca 100644
--- a/drivers/crypto/qcom-rng.c
+++ b/drivers/crypto/qcom-rng.c
@@ -9,6 +9,7 @@
 #include <linux/crypto.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/interconnect.h>
 #include <linux/platform_device.h>
 
 /* Device specific register offsets */
@@ -37,6 +38,7 @@ struct qcom_rng_ctx {
 };
 
 static struct qcom_rng *qcom_rng_dev;
+static struct icc_devfreq *icc_df;
 
 static int qcom_rng_read(struct qcom_rng *rng, u8 *data, unsigned int max)
 {
@@ -186,6 +188,13 @@ static int qcom_rng_probe(struct platform_device *pdev)
 		qcom_rng_dev = NULL;
 	}
 
+	ret = dev_pm_opp_of_add_table_indexed(&pdev->dev, 0);
+	if (ret)
+		return ret;
+	icc_df = icc_create_devfreq(&pdev->dev, "prng-slv");
+	if (IS_ERR(icc_df))
+		return PTR_ERR(icc_df);
+
 	return ret;
 }
 
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

