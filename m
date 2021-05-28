Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF2D393F99
	for <lists+linux-pm@lfdr.de>; Fri, 28 May 2021 11:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhE1JNa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 May 2021 05:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235361AbhE1JN1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 May 2021 05:13:27 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2532EC061760
        for <linux-pm@vger.kernel.org>; Fri, 28 May 2021 02:11:53 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a2so4276780lfc.9
        for <linux-pm@vger.kernel.org>; Fri, 28 May 2021 02:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sUYpUgduivuCVF6eHvNxAOyVhrifC73di+ff0lHlcsA=;
        b=wyZ4T5i+3aVchglrAZqFAVF0C6hOe/zQhiG/Y2DqaSz/q2fNL7xknah6KEG0xpQN3A
         qg34hQVg80hsXJnqaNIMyx+RpN/y8DQ41nGBEPG/xBJ8/N6MfM+4yG5VAI1iwDWtJ7IN
         vsdoma7Wxm/rhHsbi4rGtxG7lNuXCSDOXForFR1s6FEyAt+o5MJp4tps0GAuUyCiq25r
         yr0E0DXczvkGlrHEnEXfWRWJnuw3Mqo7iNaozOpvj5rllSI1mfflbG4RSybvt24L5Dro
         G3tKsOcQCYEmNN4QEe42/KZJa+zWf5t/d7Qt17qWGFIULkOsu0hVEJC9j5VCRTzildIH
         nTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sUYpUgduivuCVF6eHvNxAOyVhrifC73di+ff0lHlcsA=;
        b=DSX1j8fbvDEEQviK5OA00UqbumhKUwcKahVhA8sbbbk5Mj8W9JKRZlTmUXN90NS3Dx
         oIDuz80wkXL1D5we6V49YWGgkg9mZaRBEMBRDfFwzGB7rqCyqWCKNtI18I0z2O71B+FB
         eFfrNlaLOIvQvreQ3dzsEMKxki0oN9Ym3G7en3+qMf/j6VjFWCZUA++/n3oNZtBPwCfv
         ghn4kvAARuRZzOm12YlwzMyJQfZPl3xRxa7GCThJ4ZtkPa1kAQUQM8qNiFvF5tPPkYVQ
         ZeXXvk8a7DgliCk75WPdWlnbc23E6/AcOvoG/2rEGzaGds1DNOUKLLufkmwBsKiLirJI
         9C9A==
X-Gm-Message-State: AOAM531WuVKLq8qy7d6XbzjYLpYKIKllDXF+43sLVP3WPLBiPLDUXhh5
        G8pd7zi7QFPUwbKZJ28lW2SQbg==
X-Google-Smtp-Source: ABdhPJwsVzF+nC4WNJPqBtVliQbqeg943XE0P+2MUBvV2a1tnubgAiDDFZnyk++mWwJZ3eEuHuTE4Q==
X-Received: by 2002:ac2:4908:: with SMTP id n8mr5125093lfi.641.1622193111489;
        Fri, 28 May 2021 02:11:51 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id n15sm421927lfq.274.2021.05.28.02.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:11:50 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] PM: runtime: Improve path in rpm_idle() when no callback
Date:   Fri, 28 May 2021 11:11:47 +0200
Message-Id: <20210528091147.11541-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When pm_runtime_no_callbacks() has been called for a struct device to set
the dev->power.no_callbacks flag for it, it enables rpm_idle() to take a
slightly quicker path by assuming that a ->runtime_idle() callback would
have returned 0 to indicate success.

A device that does not have the dev->power.no_callbacks flag set for it,
may still be missing a corresponding ->runtime_idle() callback, in which
case the slower path in rpm_idle() is taken. Let's improve the behaviour
for this case, by aligning code to the quicker path.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/runtime.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index b570848d23e0..68bebbf81347 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -446,7 +446,10 @@ static int rpm_idle(struct device *dev, int rpmflags)
 	/* Pending requests need to be canceled. */
 	dev->power.request = RPM_REQ_NONE;
 
-	if (dev->power.no_callbacks)
+	callback = RPM_GET_CALLBACK(dev, runtime_idle);
+
+	/* If no callback assume success. */
+	if (!callback || dev->power.no_callbacks)
 		goto out;
 
 	/* Carry out an asynchronous or a synchronous idle notification. */
@@ -462,10 +465,7 @@ static int rpm_idle(struct device *dev, int rpmflags)
 
 	dev->power.idle_notification = true;
 
-	callback = RPM_GET_CALLBACK(dev, runtime_idle);
-
-	if (callback)
-		retval = __rpm_callback(callback, dev);
+	retval = __rpm_callback(callback, dev);
 
 	dev->power.idle_notification = false;
 	wake_up_all(&dev->power.wait_queue);
-- 
2.25.1

