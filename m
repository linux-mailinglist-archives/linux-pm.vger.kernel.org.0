Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A973DC807
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jul 2021 21:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbhGaTus (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Jul 2021 15:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbhGaTuq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Jul 2021 15:50:46 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C229FC0613CF
        for <linux-pm@vger.kernel.org>; Sat, 31 Jul 2021 12:50:39 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id f12so18025572ljn.1
        for <linux-pm@vger.kernel.org>; Sat, 31 Jul 2021 12:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kHFwx9ojcB3g03tmggA/XXZ6zfIExa6F6ser3y7PQzw=;
        b=sSNjDrMN1Esd5W5I7LhppFjL0YXjXaKTdbm2Emdl4gdYcc+KBuZTmCrew6R0IpDWbB
         nHlhU0hurC+f3TDljJwjJiwSaCn9PxkkANp5mVtgRt9Balk0E3U2k7t5EQuK+gXUgOwu
         nI317bCBRYf8dxLfgtouyX6T7UibbkBWe4wAWNTVK522y/lXGCRYfJPg17eDx5JvFuks
         +KLDia6BLKVt4dNU5IRq2OLZa+obbbDxn8oOkCMvVdZdQhJiPQE2vlAFmlgp9QC3Onnq
         ymgg4DqV6G1nAOR1vs0DC+pdA9Xvc4TdSCLGF4rzY5HBhezFAZcecblaRq41pgTITnxx
         EaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kHFwx9ojcB3g03tmggA/XXZ6zfIExa6F6ser3y7PQzw=;
        b=pZLNTyjAFm9EqCbrozZ1PRJJzuNAiNv4K3MNXp6b5uq3TROX0B2vpljwO3hOIt7E92
         xZIGFihw4Pqykh2UCDDz3FchWLcfZaCt8U5sSe9KB8xFUWW/oGrb/tcXNLs6I9gGnwKQ
         B1a7KspSIdYzC1A1KC+9gFGecYGWUU2UMGNYIWQ86DeHC37jKoCXylfEm5d1WNIlFs5d
         M3KZlmdxAM3eaHhKeyBtnCtj1Bhlq7m5kAFJccfMIJ7F1qMH8NzxGSJ6h9aXGlRlbxK9
         IdUh8cM8M3cWCX2KAM1ksrUp+SrFCyT8QFK2U5a+ehCldjhgFTN+uuoDCcBbLylJFTxb
         gcIQ==
X-Gm-Message-State: AOAM531dIrYrogBt32F4EaOusK9TPjASFvzaTV4nOCH4NfriWbrvKOeG
        XpSzD2LGffs8MqVYehaD9YOSJg==
X-Google-Smtp-Source: ABdhPJxvwCFTb8dTtIH79JS+nhw9T5l3dS5rMPakUuIuWc4s5flaEk9+WYzRSP0YeREtTJZS5iGDSw==
X-Received: by 2002:a2e:86c5:: with SMTP id n5mr6031314ljj.398.1627761038155;
        Sat, 31 Jul 2021 12:50:38 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id f3sm469827lfm.76.2021.07.31.12.50.37
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
Subject: [PATCH v3 2/3] PM: runtime: add devm_pm_clk_create helper
Date:   Sat, 31 Jul 2021 22:50:33 +0300
Message-Id: <20210731195034.979084-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210731195034.979084-1-dmitry.baryshkov@linaro.org>
References: <20210731195034.979084-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A typical code pattern for pm_clk_create() call is to call it in the
_probe function and to call pm_clk_destroy() both from _probe error path
and from _remove function. For some drivers the whole remove function
would consist of the call to pm_remove_disable().

Add helper function to replace this bolierplate piece of code. Calling
devm_pm_clk_create() removes the need for calling pm_clk_destroy() both
in the probe()'s error path and in the remove() function.

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

