Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB1D2FE89C
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 12:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbhAULVQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 06:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728983AbhAULVA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 06:21:00 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8A2C0617A2
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 03:19:10 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id v19so1132993pgj.12
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 03:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ztcbVczwcxvX+Nme8Zu1bVyHZiwA0aS5UzQfgwSCEM4=;
        b=uvEyLQq53T//ZW0fW9IuJXmQ0IpdbzBOHOZkvCWGZ4qs23KbdM1qBbTqsBvRapbFjQ
         GFTzRYWISYJfZppc2Zk7RHboU5zZ4TVr9NOy3uFsFZN3WNsrlkPVDczNsuKmY3q5BE+B
         WJn2+aBHGJLNiN6/ELjw0OPDd33iZ3H6kAA4chYfT/sr2Gd/6TnwEmeW8lfDuPWeru/u
         C7NgP8XEQydN5j4ZOwOQDckF78X8cApKr6rG9CXIybnq9UjECRHrVggyvlYqLI+ZC7T7
         3ywLOkm13JVjMF9xUIgRTuNR6fYT/JHPI2hQ8dokW8N1jPAkvjp3iKDDfY80HBbwF3Xp
         Or9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ztcbVczwcxvX+Nme8Zu1bVyHZiwA0aS5UzQfgwSCEM4=;
        b=XY2WpXdeAJFqSDrR5LecaDLFgGXTKv7zZ4fMT6+ZBRen5H6rdj6qzd6yv8U8CBbx6F
         zuee4/8/pl/eU7mo34FSYXRE0bWXA5tI29ciPL7edL7PgWkgnFJa27sPuODVvA+G599p
         H3kxyG6dB39xTxXqek7ZlRoG74mBl9RNT1HWfSBsi7B5NmCzYnvNOOsQA3hQL5MJZ2eS
         5GLzb1e8y42D+7KILx87MXqcmFuA37sYlY60ndVCLZvzpjziwrPTk+UZUVJ8vYKdUpBH
         K8mFT2NNhLwCG0DvL3L4k/oyLPBq6MSUMwlU+BiorMfXBn+hVzVz0xFMNcBJs3vFdjMc
         mhfQ==
X-Gm-Message-State: AOAM532ZWH8dZVllz63ly/l/7l0te2jSKkg4QuIHZFgr8YyfcYBZgWoi
        kpugOCfjDUElAzVwhE91ihvdpA==
X-Google-Smtp-Source: ABdhPJz5dsmD2BduPt5SpiKRdA3AKAE60DsVpNwYRtx4HLW3+yCJkDvh+JXODFHsTDqqF3ffOKvzYw==
X-Received: by 2002:a63:d446:: with SMTP id i6mr14020045pgj.446.1611227949698;
        Thu, 21 Jan 2021 03:19:09 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id u189sm5203484pfb.51.2021.01.21.03.19.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 03:19:09 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 09/13] opp: Implement dev_pm_opp_set_opp()
Date:   Thu, 21 Jan 2021 16:47:49 +0530
Message-Id: <7d62f63ac64e59ee3327789ff1bc9cebc2da6944.1611227342.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1611227342.git.viresh.kumar@linaro.org>
References: <cover.1611227342.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The new helper dev_pm_opp_set_opp() can be used for configuring the
devices for a particular OPP and can be used by different type of
devices, even the ones which don't change frequency (like power
domains).

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 28 ++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  6 ++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 3500cc9de66b..5a367ef02b92 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1130,6 +1130,34 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_set_rate);
 
+/**
+ * dev_pm_opp_set_opp() - Configure device for OPP
+ * @dev: device for which we do this operation
+ * @opp: OPP to set to
+ *
+ * This configures the device based on the properties of the OPP passed to this
+ * routine.
+ *
+ * Return: 0 on success, a negative error number otherwise.
+ */
+int dev_pm_opp_set_opp(struct device *dev, struct dev_pm_opp *opp)
+{
+	struct opp_table *opp_table;
+	int ret;
+
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
+		dev_err(dev, "%s: device opp doesn't exist\n", __func__);
+		return PTR_ERR(opp_table);
+	}
+
+	ret = _set_opp(dev, opp_table, opp, opp->rate);
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_set_opp);
+
 /* OPP-dev Helpers */
 static void _remove_opp_dev(struct opp_device *opp_dev,
 			    struct opp_table *opp_table)
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index f8e9a8e3eb59..2d8a706f8d00 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -158,6 +158,7 @@ void dev_pm_opp_detach_genpd(struct opp_table *opp_table);
 struct opp_table *devm_pm_opp_attach_genpd(struct device *dev, const char **names, struct device ***virt_devs);
 int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
+int dev_pm_opp_set_opp(struct device *dev, struct dev_pm_opp *opp);
 int dev_pm_opp_set_bw(struct device *dev, struct dev_pm_opp *opp);
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
 int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
@@ -376,6 +377,11 @@ static inline int dev_pm_opp_set_rate(struct device *dev, unsigned long target_f
 	return -ENOTSUPP;
 }
 
+static inline int dev_pm_opp_set_opp(struct device *dev, struct dev_pm_opp *opp)
+{
+	return -ENOTSUPP;
+}
+
 static inline int dev_pm_opp_set_bw(struct device *dev, struct dev_pm_opp *opp)
 {
 	return -EOPNOTSUPP;
-- 
2.25.0.rc1.19.g042ed3e048af

