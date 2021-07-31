Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6630C3DC803
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jul 2021 21:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhGaTuq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Jul 2021 15:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbhGaTup (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Jul 2021 15:50:45 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138E1C061798
        for <linux-pm@vger.kernel.org>; Sat, 31 Jul 2021 12:50:39 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id f12so18025548ljn.1
        for <linux-pm@vger.kernel.org>; Sat, 31 Jul 2021 12:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a3HfCoK/N2a3QV65vcttbj2g0Y4NliR7IfkMwtRbhSY=;
        b=h0XIju8emNWth5jqECkvdQqW6QJ4e0Q50EMYw1kFfau1vwfi8sIivLnMvYJPkyozCY
         N3a4vjx4SrW4h6PyJJEwFIJF4PrDiEExFvFeC5t2IKTF9xQuUq6/Rn3InlGB3Gfayxe/
         JR2OSb+LkMuDO9gnHJTLWfPMB2rGIx0SmjrxzjY3Zrwyo5dvnYIZO1EqjdWINRjWRFDg
         1/NDWHp7LJ6QY91cS81uu3pjMPLj9tYHWVC5G2EPQ87Vcb/jm69/Kefxm1alWrsIqBDR
         FGtOs27f1UP10Hvf5KMcomYatNRepfmjX/Da0FbfsC0Xbm37bkx/QOnkJ4F5Jq3sMEmM
         0i+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a3HfCoK/N2a3QV65vcttbj2g0Y4NliR7IfkMwtRbhSY=;
        b=Hj6JsTMCG2xZia6srKgZKwf4RpEgyqZskRpshqjY3g3n/8tNtgBgnnzWHmjhsPfInS
         Au+px+vohB1gZR+C/kFlxKcfs4WCTv3H6wP/Sq+Odwu1xu0gduK2mNvvQkSQEfL09iBV
         rtBYiGY/9S27AS8d33MoZVuAEMKGo/MrV9Uv/WIQpxVdhns2IE31PRcG1dTJUZqdWQ1a
         +o3AooM5h11t0+zTpDJhN9OupFvj5lBLfdGPf8pBv7AYQQOfN4cbOUablqz1thbfOXeZ
         wqT6asg9Kd8z52StwMzoEtaIxtQPMmybDrocwwj2TCguuNG5CdGP+N8JNjQGAyLgxrY7
         mwtQ==
X-Gm-Message-State: AOAM532wwOBpB7jMjq8/tAeJPjxmZ7SN2I9miEpA7MWY/B0maYaV9ro2
        fHNQN/hTPFUcn3xpDt7ibOOeaQ==
X-Google-Smtp-Source: ABdhPJw6EVLbqdmKvwK67NI3S1Snar85PyDbYl318Zqhr+lV0Xnzw8RbwEvYEogJgTdfoQBuA6k8gQ==
X-Received: by 2002:a2e:9e8e:: with SMTP id f14mr6069954ljk.502.1627761037354;
        Sat, 31 Jul 2021 12:50:37 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id f3sm469827lfm.76.2021.07.31.12.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 12:50:37 -0700 (PDT)
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
Subject: [PATCH v3 1/3] PM: runtime: add devm_pm_runtime_enable helper
Date:   Sat, 31 Jul 2021 22:50:32 +0300
Message-Id: <20210731195034.979084-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210731195034.979084-1-dmitry.baryshkov@linaro.org>
References: <20210731195034.979084-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A typical code pattern for pm_runtime_enable() call is to call it in the
_probe function and to call pm_runtime_disable() both from _probe error
path and from _remove function. For some drivers the whole remove
function would consist of the call to pm_remove_disable().

Add helper function to replace this bolierplate piece of code. Calling
devm_pm_runtime_enable() removes the need for calling
pm_runtime_disable() both in the probe()'s error path and in the
remove() function.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/base/power/runtime.c | 17 +++++++++++++++++
 include/linux/pm_runtime.h   |  4 ++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 8a66eaf731e4..ec94049442b9 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1447,6 +1447,23 @@ void pm_runtime_enable(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(pm_runtime_enable);
 
+static void pm_runtime_disable_action(void *data)
+{
+	pm_runtime_disable(data);
+}
+
+/**
+ * devm_pm_runtime_enable - devres-enabled version of pm_runtime_enable.
+ * @dev: Device to handle.
+ */
+int devm_pm_runtime_enable(struct device *dev)
+{
+	pm_runtime_enable(dev);
+
+	return devm_add_action_or_reset(dev, pm_runtime_disable_action, dev);
+}
+EXPORT_SYMBOL_GPL(devm_pm_runtime_enable);
+
 /**
  * pm_runtime_forbid - Block runtime PM of a device.
  * @dev: Device to handle.
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index aab8b35e9f8a..222da43b7096 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -59,6 +59,8 @@ extern void pm_runtime_put_suppliers(struct device *dev);
 extern void pm_runtime_new_link(struct device *dev);
 extern void pm_runtime_drop_link(struct device_link *link);
 
+extern int devm_pm_runtime_enable(struct device *dev);
+
 /**
  * pm_runtime_get_if_in_use - Conditionally bump up runtime PM usage counter.
  * @dev: Target device.
@@ -253,6 +255,8 @@ static inline void __pm_runtime_disable(struct device *dev, bool c) {}
 static inline void pm_runtime_allow(struct device *dev) {}
 static inline void pm_runtime_forbid(struct device *dev) {}
 
+static inline int devm_pm_runtime_enable(struct device *dev) { return 0; }
+
 static inline void pm_suspend_ignore_children(struct device *dev, bool enable) {}
 static inline void pm_runtime_get_noresume(struct device *dev) {}
 static inline void pm_runtime_put_noidle(struct device *dev) {}
-- 
2.30.2

