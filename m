Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1D839F19F
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jun 2021 11:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhFHJF7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Jun 2021 05:05:59 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:36462 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhFHJF6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jun 2021 05:05:58 -0400
Received: by mail-lj1-f175.google.com with SMTP id 131so26050469ljj.3
        for <linux-pm@vger.kernel.org>; Tue, 08 Jun 2021 02:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WHAUVw9IK/B21jxzKRMs6//VXx/YmyYDw1kGjq54fl8=;
        b=x/pah5O+Sx0Z4lOP+fg3cHpCidQHkwi2heJOoPI5fIm1clzrgyKI13b4uwfi3BlBxP
         /S0N0zrCeQF9cx46GmExNiFLG+CoAZiQ9GVZo2PlPEB0/jmkVVLsB7HvQP/V3jil1/UN
         AAThDTp13HUJNpENh5WHIuZJVSy7KqKn5DRraGh9A+xEhxVBph7DhYVp3pvehkNdD+Km
         Vc0HMkMTuTfbQoYseFrw1C/WLH7QowToT7c4D9JEu+oNpdcW12gmuW6+trM/ZLKHhb8Q
         QpZ0y3KNzPDE0fRDOEk7jC1pl3ge11zUYo/JbuVzufsttqqEY7TeE4xc4K4HhoCKw9/G
         IYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WHAUVw9IK/B21jxzKRMs6//VXx/YmyYDw1kGjq54fl8=;
        b=NKUTpcNEQfPyLIaWus6XL1qWu1YUQXRDklCwp/76Bqr5cU6ZpaQ9BvlOR7vh9hfl+x
         PR94bhf2VAyipHMYA5HAmUYS/shUyafoz1ccps18NLDVXv7fNrJH9vN3vzxMHOBGdmXV
         CXGWy9F9cnd0VYQVPT0qETKd8Tymwrs8oTGI9QfMzdat5W2wgwST/QRhUHk1rSlfe6ft
         I8i5pnXn9lSOXLHjXDUFb/VfMT4E1jOKhpp8tzvaa6pnVSEXdlpTIRuzgoAO+RWoauPU
         dwX287uovHHaSX681hcllm6JWBw0gYMQmPQ33OElAPgk6wl/LTlnGj+/J8mzjdb2cYKx
         tZ8w==
X-Gm-Message-State: AOAM532g/Ndu6bqSaAMzskjslbnQseA1iWjMUqD62tDo4uwpzNRre3fS
        eM8bQBaMFUAfEw+vKsaKs5zFDQ==
X-Google-Smtp-Source: ABdhPJxhC0tQCmxGqeuhNNx51utAaeSuu/R6EEKrqA/ZMKUME6+3IFqg+FSKkB3lncYPy8y9mbgomg==
X-Received: by 2002:a2e:7011:: with SMTP id l17mr17753121ljc.372.1623142984661;
        Tue, 08 Jun 2021 02:03:04 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id n17sm1295197lfq.118.2021.06.08.02.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 02:03:03 -0700 (PDT)
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
Subject: [PATCH v2 1/3] PM: runtime: Improve path in rpm_idle() when no callback
Date:   Tue,  8 Jun 2021 11:02:48 +0200
Message-Id: <20210608090250.85256-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210608090250.85256-1-ulf.hansson@linaro.org>
References: <20210608090250.85256-1-ulf.hansson@linaro.org>
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

Changes in v2:
	- None.

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

