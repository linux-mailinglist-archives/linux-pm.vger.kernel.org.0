Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44CC416B8C5
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2020 06:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbgBYFIy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Feb 2020 00:08:54 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41956 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728954AbgBYFIx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Feb 2020 00:08:53 -0500
Received: by mail-pg1-f193.google.com with SMTP id 70so6273357pgf.8
        for <linux-pm@vger.kernel.org>; Mon, 24 Feb 2020 21:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=al0yNnpxHbrkbnU0GkXBq3GBAXT9OW3YkTLBOR/+heI=;
        b=rTdk+5bMOM+HRL9wKEQyPyEKzfllOH6emQP6kJ0JbaGgfMspEx9D4EG6f07j0qZ6eA
         iUyyDaH6yh9/ilf2zj4FTE9BVjo+cQhw8secbrEa0uGoE/X9k+nW++hVRHfBotivunRX
         7OMHcEKOaMXLp5ZWx+0l4FB/9Sy5LbtOpUflE9SQigrRwGpuE/udsdzLJFxIIBiwBtZu
         WKyX3NNNyGATkLWDTF01y187u6PFJp5dIAfcz7VNG4U7E81LdMhcIK3DuW/2hlsFNQRw
         NjDO9xlEkUm8JJI1O/3nV2c+B1lsYXls4TcWwu50hawLUD1LvKQbrX3seDfuWOjlHO+F
         0lvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=al0yNnpxHbrkbnU0GkXBq3GBAXT9OW3YkTLBOR/+heI=;
        b=g6bnrjHVzZLTV46KllON2jrDDaoHDfIQBnaHy5XVUoA3thpu4e6ZO2r2pFPMQr9Gs/
         2g72VExu2iGwvduDUe3w+6GAEIJ3vBdElZe2JyvcUlxjUbo0h0dgZsMLadhVCXDffKkL
         33HG6lY5rtyYfyumXuvNeK5986VO93G6WIm8gXjFYI/PDZ/WifxzY9UwjdhiycVIiJWd
         PYFwf6M+KrZWG+ywuaB0thmhdGGDanMhXhpXl0uTl4jADAQ9Qi4pP6aLbF8vwrEftNm1
         mDeVN9r/MFRyb32lurcDHz3l4iZu5LnwHfa5BHw0IT+MzKRZNKLV1BzcDg155MaZuR7F
         f7eA==
X-Gm-Message-State: APjAAAWRaddDk7j0JU9vnvI2d6Q9KCxj1qjKSiDytjBhWW4y97YO0TCS
        Kt2XMPd7mYa3978/QJPemxGKzA==
X-Google-Smtp-Source: APXvYqxhk7Ltwaas8OK1QF0WV9MG82y+cNJGjUxEKBuCHPsResxQTxX7P1XMpbhqGCukyZWZ6+caHg==
X-Received: by 2002:a63:28c3:: with SMTP id o186mr36905645pgo.248.1582607332765;
        Mon, 24 Feb 2020 21:08:52 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id r66sm15156450pfc.74.2020.02.24.21.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 21:08:52 -0800 (PST)
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
Subject: [PATCH v5 5/6] driver core: Rename deferred_probe_timeout and make it global
Date:   Tue, 25 Feb 2020 05:08:27 +0000
Message-Id: <20200225050828.56458-6-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200225050828.56458-1-john.stultz@linaro.org>
References: <20200225050828.56458-1-john.stultz@linaro.org>
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
Cc: Saravana Kannan <saravanak@google.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v4:
* Split out into its own patch as suggested by Mark
* Renamed deferred_probe_timeout as suggested by Greg
---
 drivers/base/dd.c             | 16 +++++++++-------
 include/linux/device/driver.h |  1 +
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index c09e4e7277d4..76888a7459d8 100644
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
@@ -264,7 +266,7 @@ int driver_deferred_probe_check_state(struct device *dev)
 		return -ENODEV;
 	}
 
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

