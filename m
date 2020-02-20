Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C035116567A
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 06:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgBTFFA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 00:05:00 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:50221 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgBTFFA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 00:05:00 -0500
Received: by mail-pj1-f65.google.com with SMTP id r67so362965pjb.0
        for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2020 21:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/T58NGHopB3l5IaHe5dr2sMuh4DNsWpX5Bm1fmPX41g=;
        b=S2OqtMi4d7N85eKmqs1n60PvHhJ3iczKNhZd3H4xFKxZrquUWEjkKNOYhKwBBrq/yK
         +eOA9gZ5h1AMNe5U3gT3ELiZIEh5UG8Pfe1ACDe0dWSLrLzkN9t9IWgWyou0SwbC2YDT
         DtjeAbTk1XwtwSzd9qqZQhHoXaF/RykNvfqrqFM67BpFMRdjPowh1ijaNpcSZEfzOzj2
         MJMNg9nJeeq8g+SPs/wEbrtaJXAuLPRczDvjJacgR8ntcZMI9FOqASEU/2DQr+R/U8Ma
         P+aTOaOUMgky6Uwxjg/SYPT5W9wlt5RcVA+iNFMdQQw7VydaYEDcOTX63cWT0I+rgX4P
         e8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/T58NGHopB3l5IaHe5dr2sMuh4DNsWpX5Bm1fmPX41g=;
        b=S9S2rS/FfZ3TRq+bhTUgETeJoKueN03gsrYIaQDcbIrH76oSafYS1jsdB5XUWpYY00
         AI+D+laOuxhyFxT/IOkDcj/3vtaXpM+gMB6naWo3/rmLBQkfQaccn/SjN47Q2Bkq77la
         HSVy3Sp5dRvAD/+hd0Besv4FwcPsqymGmlLt6JWz3FxWg6QV5F40tVKS/d6YcJdTrUEp
         Vdkk3e5x3desXWTKEYwBmxbjOHRZ/T5y3qYQC4wdeyJZsYiT+BvW7EICDhtsnhH9zghv
         xV3uWTY8nYxMeECmOIOa3dvQR7YYhX31V/ElSBwYeACOeccsycU604+BvD2hlUisMUPG
         LOCw==
X-Gm-Message-State: APjAAAVskHcpxs8ZXNxwlKGrRnP66Cq2svdH5HXViqMtVEgf9fZXFwRB
        cWexPE6kvayojC52kQmVPsov6A==
X-Google-Smtp-Source: APXvYqx7blf57WRdqHC+FiTTfSehSN8U0lLCPg8GgWjsosKUg28yXPBGYhNTcpJXcdEWuI0YfQrQnA==
X-Received: by 2002:a17:902:820b:: with SMTP id x11mr29388518pln.196.1582175099414;
        Wed, 19 Feb 2020 21:04:59 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id z4sm1400847pfn.42.2020.02.19.21.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 21:04:58 -0800 (PST)
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
Subject: [PATCH v4 1/6] driver core: Fix driver_deferred_probe_check_state() logic
Date:   Thu, 20 Feb 2020 05:04:35 +0000
Message-Id: <20200220050440.45878-2-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200220050440.45878-1-john.stultz@linaro.org>
References: <20200220050440.45878-1-john.stultz@linaro.org>
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

* If deferred_probe_timeout is set, it returns -EPROBE_DEFER
  until the timeout, afterwhich it returns -ETIMEDOUT.

* If deferred_probe_timeout is not set (-1), it returns
  -EPROBE_DEFER until late_initcall, after which it returns

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
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
Change-Id: I8349b7a403ce8cbce485ea0a0a5512fddffb635c
---
v4:
* Simplified logic suggested by Andy Shevchenko
* Clarified commit message to focus on logic change
---
 drivers/base/dd.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index b25bcab2a26b..bb383dca39c1 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -237,7 +237,7 @@ __setup("deferred_probe_timeout=", deferred_probe_timeout_setup);
 
 static int __driver_deferred_probe_check_state(struct device *dev)
 {
-	if (!initcalls_done)
+	if (!initcalls_done || deferred_probe_timeout > 0)
 		return -EPROBE_DEFER;
 
 	if (!deferred_probe_timeout) {
@@ -252,9 +252,11 @@ static int __driver_deferred_probe_check_state(struct device *dev)
  * driver_deferred_probe_check_state() - Check deferred probe state
  * @dev: device to check
  *
- * Returns -ENODEV if init is done and all built-in drivers have had a chance
- * to probe (i.e. initcalls are done), -ETIMEDOUT if deferred probe debug
- * timeout has expired, or -EPROBE_DEFER if none of those conditions are met.
+ * Returnes -EPROBE_DEFER if initcalls have not completed, or the deferred
+ * probe timeout is set, but not expried.
+ * Returns -ETIMEDOUT if the probe timeout was set and has expired.
+ * Returns -ENODEV if initcalls have completed and the deferred probe timeout
+ * was not set.
  *
  * Drivers or subsystems can opt-in to calling this function instead of directly
  * returning -EPROBE_DEFER.
-- 
2.17.1

