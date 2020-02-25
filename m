Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F45616B8BB
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2020 06:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgBYFIj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Feb 2020 00:08:39 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40611 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgBYFIi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Feb 2020 00:08:38 -0500
Received: by mail-pf1-f194.google.com with SMTP id b185so6534950pfb.7
        for <linux-pm@vger.kernel.org>; Mon, 24 Feb 2020 21:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VjGy9mDSQTtqTfodJGzoJsBP+0BqRCAD5WnADk/Arw0=;
        b=QWV3p9i6zgdUqYL2d/2B5WDRt4NHawZ9OByHIbJAMrmiLd0KSO3xLeTNpgJVmrcp/0
         xqki/c8H0Iv/9yANo6VcgCAnCWj0iuko5+4Zdp5ODNwpyOHZWaIktGmCJ4nXAC1JJFvd
         9R0uvmxHps9ROinDk3kyZ1XeAxdr1S8gUarQvwvao6S4nhJ28Mb+vxsSFiHYEQ77omgN
         8YI9LWrxpITC+nnOg+Pl1Y8Wg8b7YZ1plkloQDfuNpIDS1xzwboO0elIFvuYW3y2r778
         3CTF+ftFwL+WNquuDIU4RbR2zZrtmrpGNppSCYBZdzbJkCqbczkrn/uvD9cmlAewHCBb
         ugsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VjGy9mDSQTtqTfodJGzoJsBP+0BqRCAD5WnADk/Arw0=;
        b=IzolI9i5F51QxCBSvLMDYz+h4AdKa1hU5EObks3HAxQ3nyFKUWUrs+GFEAd6buKDtJ
         +CHSOEDpJdy99uIDeMABMmqLbp9zCCHN0zQadaoPSxd4leXUHLqiWS5UJ+0nNzyfARMf
         lA/dX6KaREez9I9BiQ9Y3IHQMCbhOOJBZdIPYC74FputfypHc0p8HhMGLg7TAr7pGPLA
         B3cJmAgBhIXE2jcRUrMB4mI6jmEG7JPYImAHCxMMAb/ItITeU3gW1l1akvMnOBq+w2nA
         p8jpzM3leEcQP2wRPaqMyn4MbzGhIt+nvPZ+E2ffpy2DI6iZ2KzxfV9hpXMfSoRzTUC/
         l97Q==
X-Gm-Message-State: APjAAAVtK4K6jWs+SvbFWJF7GG5A5l/T3lVdbvt9YIEnbF17l/axwyXg
        zs3Cew4MDD13He3QHWu8BFwgpA==
X-Google-Smtp-Source: APXvYqx5KRNfMIWOAh/4UQZeEBO6iVmZ2gYODKQvJ1DZC3K6GWCUjoTKnkYshlse4PleF/uQhjP5Qg==
X-Received: by 2002:a63:60a:: with SMTP id 10mr49705597pgg.302.1582607317741;
        Mon, 24 Feb 2020 21:08:37 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id r66sm15156450pfc.74.2020.02.24.21.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 21:08:37 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v5 1/6] driver core: Fix driver_deferred_probe_check_state() logic
Date:   Tue, 25 Feb 2020 05:08:23 +0000
Message-Id: <20200225050828.56458-2-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200225050828.56458-1-john.stultz@linaro.org>
References: <20200225050828.56458-1-john.stultz@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

driver_deferred_probe_check_state() has some uninituitive behavior.

* From boot to late_initcall, it returns -EPROBE_DEFER

* From late_initcall to the deferred_probe_timeout (if set)
  it returns -ENODEV

* If the deferred_probe_timeout it set, after it fires, it
  returns -ETIMEDOUT

This is a bit confusing, as its useful to have the function
return -EPROBE_DEFER while the timeout is still running. This
behavior has resulted in the somwhat duplicative
driver_deferred_probe_check_state_continue() function being
added.

Thus this patch tries to improve the logic, so that it behaves
as such:

* If late_initcall has passed, and modules are not enabled
  it returns -ENODEV

* If modules are enabled and deferred_probe_timeout is set,
  it returns -EPROBE_DEFER until the timeout, afterwhich it
  returns -ETIMEDOUT.

* In all other cases, it returns -EPROBE_DEFER

This will make the deferred_probe_timeout value much more
functional, and will allow us to consolidate the
driver_deferred_probe_check_state() and
driver_deferred_probe_check_state_continue() logic in a later
patch.

Cc: Rob Herring <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v4:
* Simplified logic suggested by Andy Shevchenko
* Clarified commit message to focus on logic change
v5:
* Cleanup comment wording as suggested by Rafael
* Tweaked the logic to use Saravana's suggested conditionals
---
 drivers/base/dd.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index b25bcab2a26b..d75b34de6964 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -237,24 +237,26 @@ __setup("deferred_probe_timeout=", deferred_probe_timeout_setup);
 
 static int __driver_deferred_probe_check_state(struct device *dev)
 {
-	if (!initcalls_done)
-		return -EPROBE_DEFER;
+	if (!IS_ENABLED(CONFIG_MODULES) && initcalls_done)
+		return -ENODEV;
 
 	if (!deferred_probe_timeout) {
 		dev_WARN(dev, "deferred probe timeout, ignoring dependency");
 		return -ETIMEDOUT;
 	}
 
-	return 0;
+	return -EPROBE_DEFER;
 }
 
 /**
  * driver_deferred_probe_check_state() - Check deferred probe state
  * @dev: device to check
  *
- * Returns -ENODEV if init is done and all built-in drivers have had a chance
- * to probe (i.e. initcalls are done), -ETIMEDOUT if deferred probe debug
- * timeout has expired, or -EPROBE_DEFER if none of those conditions are met.
+ * Return:
+ * -ENODEV if initcalls have completed and modules are disabled.
+ * -ETIMEDOUT if the deferred probe timeout was set and has expired
+ *  and modules are enabled.
+ * -EPROBE_DEFER in other cases.
  *
  * Drivers or subsystems can opt-in to calling this function instead of directly
  * returning -EPROBE_DEFER.
@@ -264,7 +266,7 @@ int driver_deferred_probe_check_state(struct device *dev)
 	int ret;
 
 	ret = __driver_deferred_probe_check_state(dev);
-	if (ret < 0)
+	if (ret != -ENODEV)
 		return ret;
 
 	dev_warn(dev, "ignoring dependency for device, assuming no driver");
@@ -292,7 +294,7 @@ int driver_deferred_probe_check_state_continue(struct device *dev)
 	int ret;
 
 	ret = __driver_deferred_probe_check_state(dev);
-	if (ret < 0)
+	if (ret != -ENODEV)
 		return ret;
 
 	return -EPROBE_DEFER;
-- 
2.17.1

