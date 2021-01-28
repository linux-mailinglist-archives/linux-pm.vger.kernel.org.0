Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9CE306E02
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jan 2021 08:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhA1HBP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jan 2021 02:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbhA1HBG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jan 2021 02:01:06 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0EDC0613D6
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 23:00:25 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id u15so2823312plf.1
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 23:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7qDHxv287So/jBOR+Ptqf3OuXX9lBc2qUnXBXUEn81k=;
        b=yVKAEirqsQAkNwNAY19C20Fw2OP4V8qKO0dJ2PY9EmdjWpFZ3qmIbbWvVJwJVuPvxV
         ZvvM2v/xE5C9KFSqCS06hLDs2zEuFEbJtbxv8UxbmGmyxFcEwsRrwVpZwCLXnyy6v0sG
         hlfMZHEMtrBuGZUhvAspBc6nsjghqypSjIbv+OqFRQfcfKECtRq5mapOSPi3qov+c+AA
         c4GY8Rtw1bnLL3UjGiyI+UsBzzO3Yyp8XXYa7iCDWd8cRFqeMqpzqwu0TwjKHoi0tGnP
         Ok2ZfGhsiMB6oEGvsENXoT2n2DDtXx5Z0op4JZywtauvPDpfWrYFkt30U8qhVudyeqZl
         bvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7qDHxv287So/jBOR+Ptqf3OuXX9lBc2qUnXBXUEn81k=;
        b=Sqy2fsbXOf7e27dAP3dyzqBQTjZqOQKgtZj5wdNAYhbXJSKSf3irD9uUiKjAimfh87
         e1niJuBSZKjPck2p351P+l2rQb1fbSlb66GpmCt4jG7M4B77oYShA/qTetsYT503K3ox
         sjOD8YP1TU/RsmE3D76urplHGeXtoo/a0WeAC/agph1AR5PeA7XeALrVbwbaZdfJk7H+
         G48zGlKtUbHob0NbizZmxfqQsDb77cRromxbEvgqxQ4SU2kHz6Tzn9JVX/hAFtLMRTX2
         jkkRI0wHUxPILYoIvQy9oIyD2eNAim+xMALxoZ7GNgOu972fQf0z89F21SPedsnqWP9w
         t4mQ==
X-Gm-Message-State: AOAM53292JnWyfdOPtjJUd5sOGHDE4hfdAWmqZGP4MM62fjD1fW9JD0u
        j+J+06PpzTst3SUGosf4v2k7VA==
X-Google-Smtp-Source: ABdhPJzg0KUYOvi84y4/budGUi316+JwGNAzBfsjKs7Ts4mX4McGKT6+8bP7rXaSHM2LnS/DMOtkQQ==
X-Received: by 2002:a17:90b:350:: with SMTP id fh16mr9904813pjb.232.1611817225183;
        Wed, 27 Jan 2021 23:00:25 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id x1sm4709767pgj.37.2021.01.27.23.00.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 23:00:24 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/3] opp: Add dev_pm_opp_of_add_table_noclk()
Date:   Thu, 28 Jan 2021 12:30:09 +0530
Message-Id: <a251d7a7245a2ded97b282b8dfda95359698bf22.1611817096.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <1b58a72fa4d6aadc9542a66f8150150534752d81.1611817096.git.viresh.kumar@linaro.org>
References: <1b58a72fa4d6aadc9542a66f8150150534752d81.1611817096.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A few drivers have device's clk but they don't want the OPP core to
handle that. Add a new helper for them, dev_pm_opp_of_add_table_noclk().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2:
- Split this into a separate patch.

 drivers/opp/of.c       | 18 ++++++++++++++++++
 include/linux/pm_opp.h |  6 ++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index d4b51b2e384f..a905497c75f8 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -1030,6 +1030,24 @@ int dev_pm_opp_of_add_table_indexed(struct device *dev, int index)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_add_table_indexed);
 
+/**
+ * dev_pm_opp_of_add_table_noclk() - Initialize indexed opp table from device
+ *		tree without getting clk for device.
+ * @dev:	device pointer used to lookup OPP table.
+ * @index:	Index number.
+ *
+ * Register the initial OPP table with the OPP library for given device only
+ * using the "operating-points-v2" property. Do not try to get the clk for the
+ * device.
+ *
+ * Return: Refer to dev_pm_opp_of_add_table() for return values.
+ */
+int dev_pm_opp_of_add_table_noclk(struct device *dev, int index)
+{
+	return _of_add_table_indexed(dev, index, false);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_of_add_table_noclk);
+
 /* CPU device specific helpers */
 
 /**
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 979b208bc4a8..158158620dde 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -395,6 +395,7 @@ static inline int dev_pm_opp_sync_regulators(struct device *dev)
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
 int dev_pm_opp_of_add_table(struct device *dev);
 int dev_pm_opp_of_add_table_indexed(struct device *dev, int index);
+int dev_pm_opp_of_add_table_noclk(struct device *dev, int index);
 void dev_pm_opp_of_remove_table(struct device *dev);
 int dev_pm_opp_of_cpumask_add_table(const struct cpumask *cpumask);
 void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask);
@@ -419,6 +420,11 @@ static inline int dev_pm_opp_of_add_table_indexed(struct device *dev, int index)
 	return -ENOTSUPP;
 }
 
+static inline int dev_pm_opp_of_add_table_noclk(struct device *dev, int index)
+{
+	return -ENOTSUPP;
+}
+
 static inline void dev_pm_opp_of_remove_table(struct device *dev)
 {
 }
-- 
2.25.0.rc1.19.g042ed3e048af

