Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4D43D9075
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jul 2021 16:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236425AbhG1O0m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Jul 2021 10:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236603AbhG1OZJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jul 2021 10:25:09 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02A7C06179A
        for <linux-pm@vger.kernel.org>; Wed, 28 Jul 2021 07:24:53 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id b21so3261781ljo.13
        for <linux-pm@vger.kernel.org>; Wed, 28 Jul 2021 07:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R7kGrtZpvotoea9KWR3b5/H2rAVf7kCtopxK8UOkjF0=;
        b=D7UW3G6xRCJIJOwUVC6xwjmmg7O3u3ogLLD9rFJc7pyxYO2Q4vxiMo8p89Vd7T6s5C
         +ZX9xOm6or2iUuWP6Jg+k8a6W0EF1IXu7qBS8xvgl6eO7DRsDDLvrqnbKIYhhs6N5I9J
         Q+k4omFC6MVxtWCj1WAcAc1eIcW+C7n44YzVr1/Hja2TTV3XKLTuGjOi097yFcvlcUKN
         WePU7/PJ4yBU/3hpgHfokt6j9aPmZ6cGvx5PMg9FLP1BmnrUxER8mF4wHMGjmF4SkETC
         L8m+BpV8uLSgD3DZxjI259SQtT+gwrOe6czh/uuz3FlWCPSp5TfYABEkvJC9EZzkZkic
         XvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R7kGrtZpvotoea9KWR3b5/H2rAVf7kCtopxK8UOkjF0=;
        b=JIx6njJsb4+8uHwJk68I+5edub6l8EXo+SLqrL1+1wJA3aiI1xC7mEkTzpBnM71Cr2
         07YZpuYdb1Ey3FB4r/4O5hINZinBmcbh0C2d4ZbWC0H8jNc8K87dvk3AYXdgZAVxUym1
         w+ojIk0bqcDd6haEnnhtpU5Byy9J80Ilbfscnbv+QuFIwvAPP4nBcW8xU93deeJ5t41a
         15BMBzEGnGtqHTA/AH8XNGoo4EAdSRHfwM8n5/hTDo8DYfzl7Nh/ajNW3q9d2Bh/P3F+
         0NsydB+/wwSao9CTQwOX5t/ClBbsdQDFU0tfW7tbxnEAxfWlXvUC/vU0PgBWZpEl4zJb
         8SmA==
X-Gm-Message-State: AOAM5327Kc+ceweRnpVI3unpOyplPiwMc28TLGZ2WW0Jik1z68JIoCcc
        J1FCHiAoefc5KodkHkUE388G0A==
X-Google-Smtp-Source: ABdhPJxDzZVK2OU9Yfswy9HaaN71Lce2nNvA5IhpPE0C3KinQRcIfFKCkc8XZf87f/3cwxFbrhKprA==
X-Received: by 2002:a2e:b5c9:: with SMTP id g9mr87754ljn.366.1627482292144;
        Wed, 28 Jul 2021 07:24:52 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id h4sm15610lft.184.2021.07.28.07.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 07:24:51 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 2/5] PM: clk: add devm_pm_clk_create helper
Date:   Wed, 28 Jul 2021 17:24:42 +0300
Message-Id: <20210728142445.774158-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210728142445.774158-1-dmitry.baryshkov@linaro.org>
References: <20210728142445.774158-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add devm_pm_clk_create helper, devres-enabled version of the
pm_clk_create(), which will call pm_clk_destroy at the correct time.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/base/power/clock_ops.c | 17 +++++++++++++++++
 include/linux/pm_clock.h       |  5 +++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 0251f3e6e61d..4110c19c08dc 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -519,6 +519,23 @@ void pm_clk_destroy(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(pm_clk_destroy);
 
+static void pm_clk_destroy_action(void *data)
+{
+	pm_clk_destroy(data);
+}
+
+int devm_pm_clk_create(struct device *dev)
+{
+	int ret;
+
+	ret = pm_clk_create(dev);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, pm_clk_destroy_action, dev);
+}
+EXPORT_SYMBOL_GPL(devm_pm_clk_create);
+
 /**
  * pm_clk_suspend - Disable clocks in a device's PM clock list.
  * @dev: Device to disable the clocks for.
diff --git a/include/linux/pm_clock.h b/include/linux/pm_clock.h
index 8ddc7860e131..ada3a0ab10bf 100644
--- a/include/linux/pm_clock.h
+++ b/include/linux/pm_clock.h
@@ -47,6 +47,7 @@ extern void pm_clk_remove(struct device *dev, const char *con_id);
 extern void pm_clk_remove_clk(struct device *dev, struct clk *clk);
 extern int pm_clk_suspend(struct device *dev);
 extern int pm_clk_resume(struct device *dev);
+extern int devm_pm_clk_create(struct device *dev);
 #else
 static inline bool pm_clk_no_clocks(struct device *dev)
 {
@@ -83,6 +84,10 @@ static inline void pm_clk_remove(struct device *dev, const char *con_id)
 static inline void pm_clk_remove_clk(struct device *dev, struct clk *clk)
 {
 }
+static inline int devm_pm_clk_create(struct device *dev)
+{
+	return -EINVAL;
+}
 #endif
 
 #ifdef CONFIG_HAVE_CLK
-- 
2.30.2

