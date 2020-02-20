Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96092165680
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 06:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgBTFFM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 00:05:12 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40238 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgBTFFM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 00:05:12 -0500
Received: by mail-pf1-f196.google.com with SMTP id b185so1290393pfb.7
        for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2020 21:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aW+BwlvCbf3aWaQh47QJ3yNM7VLxHMAzfks9zOaajkM=;
        b=KWtAXqoH66/xVX33DhMaKTUdGX6Uf98AbL57ah+k6dEdauNQwApvPnNPHUiivq6Jdi
         49xLg0mTm79BVYHbdcVGHKDyfCI7Yt8YhnlXGJHea2d2Y16+X+iCM76wvPNmXrV4dhfb
         KKtxMQCoagp0X+c11lVO9afWRHTd6fPbsvUjdhWnY6dEPBMgam5bDsEJ0yD01A23gyxO
         XyvFyW3dEfa9OwDK55NIUQRusiahMNtBIZGwbpxIjB1xAdamE56cpYEcFU/u6PxFnaWt
         V6wbP8AjfqY2Y56H4t559cVNwx9C1p0h6Vw2CRmcPmowj7AN8PIhT+73joESZcCRHPmP
         3dBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aW+BwlvCbf3aWaQh47QJ3yNM7VLxHMAzfks9zOaajkM=;
        b=gsoPmPO2vtpgI78+fdx12iSB3DZytlt8YyDbPv6Nc1CphRUfU+dgjOc2RT3VAopt9Q
         qEI0tYAmi4ohGLNvGX9Ib/VaLnAOlVJf2jFI72rK4xz4R3iqttVvUhlV4JlEUOIwJLLw
         D8Mnk5144wYR76RNggB17/eBXEZFj+6HazuC+YapKgXzFPtpksXIiMUfPeKPi+whW0Ac
         C5P+5jt1GnfjYOdxHy5phJSa9w6O7DTY37DWELydb41Lm873LN8CeltjsyxtmmwU5+Ff
         1uY23B3O77BNwCsH2iJ+JMEw37V07TPz25dIJzVUOaLGzUHQZz7ScDvV9H6FKt2ruJFx
         HrSw==
X-Gm-Message-State: APjAAAWmZk5Mg5/eFg4Jzeme6Z7KBZLIgOTvmJGfOhyXKvh0vQZZbOFP
        OeBgG7q5b1ZIbku/yLv0tJepTw==
X-Google-Smtp-Source: APXvYqxtOMEIAg/0vMNdo4l2g1zhUCi8GqsKzxUcztilwfCWBSoXPh54dpJIreh60u0UmWS9iVnVSQ==
X-Received: by 2002:a63:fc51:: with SMTP id r17mr31212077pgk.292.1582175109855;
        Wed, 19 Feb 2020 21:05:09 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id z4sm1400847pfn.42.2020.02.19.21.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 21:05:09 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 5/6] driver core: Rename deferred_probe_timeout and make it global
Date:   Thu, 20 Feb 2020 05:04:39 +0000
Message-Id: <20200220050440.45878-6-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200220050440.45878-1-john.stultz@linaro.org>
References: <20200220050440.45878-1-john.stultz@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since other subsystems (like regulator) have similar arbitrary
timeouts for how long they try to resolve driver dependencies,
rename deferred_probe_timeout to driver_deferred_probe_timeout
and set it as global, so it can be shared.

Cc: Rob Herring <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
Change-Id: I92ee3b392004ecc9217c5337b54eda48c2d7f3ee
---
v4:
* Split out into its own patch as suggested by Mark
* Renamed deferred_probe_timeout as suggested by Greg
---
 drivers/base/dd.c             | 18 ++++++++++--------
 include/linux/device/driver.h |  1 +
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 408e4da081da..39f1ce6d4f1c 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -229,17 +229,19 @@ DEFINE_SHOW_ATTRIBUTE(deferred_devs);
  * In the case of modules, set the default probe timeout to
  * 30 seconds to give userland some time to load needed modules
  */
-static int deferred_probe_timeout = 30;
+int driver_deferred_probe_timeout = 30;
 #else
 /* In the case of !modules, no probe timeout needed */
-static int deferred_probe_timeout = -1;
+int driver_deferred_probe_timeout = -1;
 #endif
+EXPORT_SYMBOL_GPL(driver_deferred_probe_timeout);
+
 static int __init deferred_probe_timeout_setup(char *str)
 {
 	int timeout;
 
 	if (!kstrtoint(str, 10, &timeout))
-		deferred_probe_timeout = timeout;
+		driver_deferred_probe_timeout = timeout;
 	return 1;
 }
 __setup("deferred_probe_timeout=", deferred_probe_timeout_setup);
@@ -259,10 +261,10 @@ __setup("deferred_probe_timeout=", deferred_probe_timeout_setup);
  */
 int driver_deferred_probe_check_state(struct device *dev)
 {
-	if (!initcalls_done || deferred_probe_timeout > 0)
+	if (!initcalls_done || driver_deferred_probe_timeout > 0)
 		return -EPROBE_DEFER;
 
-	if (!deferred_probe_timeout) {
+	if (!driver_deferred_probe_timeout) {
 		dev_WARN(dev, "deferred probe timeout, ignoring dependency");
 		return -ETIMEDOUT;
 	}
@@ -276,7 +278,7 @@ static void deferred_probe_timeout_work_func(struct work_struct *work)
 {
 	struct device_private *private, *p;
 
-	deferred_probe_timeout = 0;
+	driver_deferred_probe_timeout = 0;
 	driver_deferred_probe_trigger();
 	flush_work(&deferred_probe_work);
 
@@ -310,9 +312,9 @@ static int deferred_probe_initcall(void)
 	driver_deferred_probe_trigger();
 	flush_work(&deferred_probe_work);
 
-	if (deferred_probe_timeout > 0) {
+	if (driver_deferred_probe_timeout > 0) {
 		schedule_delayed_work(&deferred_probe_timeout_work,
-			deferred_probe_timeout * HZ);
+			driver_deferred_probe_timeout * HZ);
 	}
 	return 0;
 }
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index 5242afabfaba..ee7ba5b5417e 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -236,6 +236,7 @@ driver_find_device_by_acpi_dev(struct device_driver *drv, const void *adev)
 }
 #endif
 
+extern int driver_deferred_probe_timeout;
 void driver_deferred_probe_add(struct device *dev);
 int driver_deferred_probe_check_state(struct device *dev);
 void driver_init(void);
-- 
2.17.1

