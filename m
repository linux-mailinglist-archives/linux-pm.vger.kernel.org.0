Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD0CEB059A
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2019 00:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfIKWco (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Sep 2019 18:32:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39977 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728743AbfIKWco (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Sep 2019 18:32:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so12277043pgj.7
        for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2019 15:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ScbFZHT8u+sMIz+KTn9O5YNo5f1GPSOha1PRAwThAGs=;
        b=ByRODCAWvy/kyXsVj95HgmPjB3MkHbd/yKPycsFepYBcnM6Wz2GxAzfDZvefAaoIf9
         /I9cKG+8WEqcquskrx5j4vVH9a7aCTDg3GQoN0oAjEv84zEVwcrXiPmkQx0HUc8vtKtb
         SNd0RfJcM811JvaSxdh7ovqo/QBId4Ds4cpSX3yYQWEvWYSbXHZINi7TcurTXCILekRn
         CazeH4EQSzp2WPG1phLN1DYAFAqgNy5OrtFHLwYP0kfeMnl7+l/jlLqlQDj8Zohe2yIZ
         gv7jYIJQhP6AFhlrJbHk8u8ezIMMucJomybd69kFN9F+dcV9Zp289DqDnRQg6+nCLXSd
         kfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ScbFZHT8u+sMIz+KTn9O5YNo5f1GPSOha1PRAwThAGs=;
        b=dpiImzprXobKBSO+RpSwuJpY37t8m/aqHhmtqxgJ6MiPPiSaw8OxaU3Ur0qVcItNw6
         cCSglcgDNu2FonXNNnBfflLPyojeU0td/fxxeRB7FrUOJFSlgPG2/nQAigMV5ihl/JEM
         PGigbVeamH84FcTscLCT3o6zUTLluY2E33OEALiu9KGx/Vl0g3RtDUMYHHv0jezscCeE
         REXVMk/FmFMp0thF03G2BvAP7zOuAOzl9KDTatlWZdVF0YO/WuRz1M3L+nJ/lYvd0uVH
         FjmCzbewDd8bSiXRrWG910cqZtUoZx3epxYgFgZ9HsKDjelQtRIFn0cclwBK/UeHuWbL
         LX5Q==
X-Gm-Message-State: APjAAAV2UkeUBDkPvohGa26eNH0VB50Nr8EQLoBBp5Pyb9QeFyQE6ohu
        94UlzNiGIi3+02Db6vKruFa8EA==
X-Google-Smtp-Source: APXvYqzO01KcR+Fqbd/dFsrfKluayh1lDx0tMBmOmiHAY33FGUehgIiOMFiY9w8z/47tg3LBnVhf2Q==
X-Received: by 2002:a17:90a:210b:: with SMTP id a11mr7931109pje.23.1568241163434;
        Wed, 11 Sep 2019 15:32:43 -0700 (PDT)
Received: from localhost ([49.248.179.160])
        by smtp.gmail.com with ESMTPSA id t9sm20936002pgj.89.2019.09.11.15.32.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Sep 2019 15:32:42 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        tdas@codeaurora.org, swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 1/5] thermal: Initialize thermal subsystem earlier
Date:   Thu, 12 Sep 2019 04:02:30 +0530
Message-Id: <97b6f861e6e6a2ac7b50efb7211f3c8e7fe872b0.1568240476.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1568240476.git.amit.kucheria@linaro.org>
References: <cover.1568240476.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1568240476.git.amit.kucheria@linaro.org>
References: <cover.1568240476.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Lina Iyer <ilina@codeaurora.org>

Now that the thermal framework is built-in, in order to facilitate
thermal mitigation as early as possible in the boot cycle, move the
thermal framework initialization to core_initcall.

However, netlink initialization happens only as part of subsys_initcall.
At this time in the boot process, the userspace is not available yet. So
initialize the netlink events later in fs_initcall.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
[Rebased, refactored and moved to core_initcall]
Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/thermal_core.c | 41 ++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6bab66e84eb5..b13e8a9298cc 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1468,6 +1468,8 @@ static struct genl_family thermal_event_genl_family __ro_after_init = {
 	.n_mcgrps = ARRAY_SIZE(thermal_event_mcgrps),
 };
 
+static bool allow_netlink_events;
+
 int thermal_generate_netlink_event(struct thermal_zone_device *tz,
 				   enum events event)
 {
@@ -1482,6 +1484,9 @@ int thermal_generate_netlink_event(struct thermal_zone_device *tz,
 	if (!tz)
 		return -EINVAL;
 
+	if (!allow_netlink_events)
+		return -ENODEV;
+
 	/* allocate memory */
 	size = nla_total_size(sizeof(struct thermal_genl_event)) +
 	       nla_total_size(0);
@@ -1533,16 +1538,18 @@ EXPORT_SYMBOL_GPL(thermal_generate_netlink_event);
 
 static int __init genetlink_init(void)
 {
-	return genl_register_family(&thermal_event_genl_family);
-}
+	int ret;
 
-static void genetlink_exit(void)
-{
-	genl_unregister_family(&thermal_event_genl_family);
+	ret = genl_register_family(&thermal_event_genl_family);
+	if (!ret)
+		allow_netlink_events = true;
+	return ret;
 }
+
 #else /* !CONFIG_NET */
 static inline int genetlink_init(void) { return 0; }
-static inline void genetlink_exit(void) {}
+static inline int thermal_generate_netlink_event(struct thermal_zone_device *tz,
+						 enum events event) { return -ENODEV; }
 #endif /* !CONFIG_NET */
 
 static int thermal_pm_notify(struct notifier_block *nb,
@@ -1591,19 +1598,15 @@ static int __init thermal_init(void)
 	mutex_init(&poweroff_lock);
 	result = thermal_register_governors();
 	if (result)
-		goto error;
+		goto init_exit;
 
 	result = class_register(&thermal_class);
 	if (result)
 		goto unregister_governors;
 
-	result = genetlink_init();
-	if (result)
-		goto unregister_class;
-
 	result = of_parse_thermal_zones();
 	if (result)
-		goto exit_netlink;
+		goto exit_zone_parse;
 
 	result = register_pm_notifier(&thermal_pm_nb);
 	if (result)
@@ -1612,13 +1615,11 @@ static int __init thermal_init(void)
 
 	return 0;
 
-exit_netlink:
-	genetlink_exit();
-unregister_class:
+exit_zone_parse:
 	class_unregister(&thermal_class);
 unregister_governors:
 	thermal_unregister_governors();
-error:
+init_exit:
 	ida_destroy(&thermal_tz_ida);
 	ida_destroy(&thermal_cdev_ida);
 	mutex_destroy(&thermal_list_lock);
@@ -1626,4 +1627,10 @@ static int __init thermal_init(void)
 	mutex_destroy(&poweroff_lock);
 	return result;
 }
-fs_initcall(thermal_init);
+
+static int __init thermal_netlink_init(void)
+{
+	return genetlink_init();
+}
+core_initcall(thermal_init);
+fs_initcall(thermal_netlink_init);
-- 
2.17.1

