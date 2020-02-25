Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B12916B8C8
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2020 06:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbgBYFJA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Feb 2020 00:09:00 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42322 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728995AbgBYFI7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Feb 2020 00:08:59 -0500
Received: by mail-pl1-f195.google.com with SMTP id u3so668316plr.9
        for <linux-pm@vger.kernel.org>; Mon, 24 Feb 2020 21:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vs2A4Za3pdSHZq6f79ZL4a42P4ysEMl/Adkkn+cV4Fo=;
        b=PjVbUxYl+hzlQEyEE/+DB53B78mYOsBa4d+R7HXKHucgElknJuPi8+O2ymUo5woKmw
         X9b28lQAtJNLxeLLU6jP+C7LUH7J+tLG0wxDm9jCrqAOIEb/WimLugq09G7kZKBkSKgT
         KeC9j6XeAuTz5pHC3pjH03DJSsL7O9oyIQSvGO/Xh1Olwev/DvbPvYPr6DjUVUdNaTKs
         epV8gLOG0i1gSqruvRfwloVvoB+I9RTCFgPgAGZS0dPZOKM1WkYeGDTgs4hPER8EfSxj
         gH8DHV/RPxDFNZ5dfOdbO5BDNiLNpcKzdGA/F5KxXlGxAWV2HLE5XwR4avjuJUOkBCf1
         H7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vs2A4Za3pdSHZq6f79ZL4a42P4ysEMl/Adkkn+cV4Fo=;
        b=lK+bVWAi3aRcXTMeUM3Xr+1ucGKCR2uOuUO1EdFhJpypGx31xXnGxVtX6hnE1JlAND
         yOsjgj04ZAVLubEuDZrVL4W+deYP0nwDzILN9VJ4f6CMmyrNjZdrGjQzwNaDpiTSn4A0
         lALSLep2B209LUEOqTguLS3LI4g/tCW4AF/ZvOh6EnHcYIPH6CsAfTzkqpLk3f0z5q8g
         9a/1AUPhadpQ64GwXmdU5G40WBmKzNY2eMtjvMQxDWQfT7s5pzDRfAU6V0sNuJyE/rbB
         nKFVHiMkzlTNBpyxH+ZlquA6lFxT4mUgKGVtwWaUcxJ/y5xAvrrwXh+2j9YJ8WIxbtCC
         PprQ==
X-Gm-Message-State: APjAAAWLwf2q13U0C/2G/YjJL7HThJm79BoSnBvUk8qQfZo9dxCCq7ik
        SYeQ8pWFlKwH2i9pgZYDVgsPZw==
X-Google-Smtp-Source: APXvYqxWpmh6vnDqtiwV0kaQCSFa+mczFvYM+vPDL+J9/4sdKTBHrQa7W6/PV/8V+Vj2QOhZD+RVeg==
X-Received: by 2002:a17:90a:1f8c:: with SMTP id x12mr3170349pja.27.1582607337454;
        Mon, 24 Feb 2020 21:08:57 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id r66sm15156450pfc.74.2020.02.24.21.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 21:08:56 -0800 (PST)
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
Subject: [PATCH v5 6/6] regulator: Use driver_deferred_probe_timeout for regulator_init_complete_work
Date:   Tue, 25 Feb 2020 05:08:28 +0000
Message-Id: <20200225050828.56458-7-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200225050828.56458-1-john.stultz@linaro.org>
References: <20200225050828.56458-1-john.stultz@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The regulator_init_complete_work logic defers the cleanup for an
arbitrary 30 seconds of time to allow modules loaded by userland
to start.

This arbitrary timeout is similar to the
driver_deferred_probe_timeout value, and its been suggested we
align these so users have a method to extend the timeouts as
needed.

So this patch changes the logic to use the
driver_deferred_probe_timeout value for the delay value if it
is set (using a delay of 0 if it is not).

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
* Split out into its own patch, as suggested by Mark
v5:
* Try to simplify the logic a touch as suggested by Bjorn
---
 drivers/regulator/core.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d015d99cb59d..51b6a2dea717 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5757,6 +5757,10 @@ static DECLARE_DELAYED_WORK(regulator_init_complete_work,
 
 static int __init regulator_init_complete(void)
 {
+	int delay = driver_deferred_probe_timeout;
+
+	if (delay < 0)
+		delay = 0;
 	/*
 	 * Since DT doesn't provide an idiomatic mechanism for
 	 * enabling full constraints and since it's much more natural
@@ -5767,18 +5771,17 @@ static int __init regulator_init_complete(void)
 		has_full_constraints = true;
 
 	/*
-	 * We punt completion for an arbitrary amount of time since
-	 * systems like distros will load many drivers from userspace
-	 * so consumers might not always be ready yet, this is
-	 * particularly an issue with laptops where this might bounce
-	 * the display off then on.  Ideally we'd get a notification
-	 * from userspace when this happens but we don't so just wait
-	 * a bit and hope we waited long enough.  It'd be better if
-	 * we'd only do this on systems that need it, and a kernel
-	 * command line option might be useful.
+	 * If driver_deferred_probe_timeout is set, we punt
+	 * completion for that many seconds since systems like
+	 * distros will load many drivers from userspace so consumers
+	 * might not always be ready yet, this is particularly an
+	 * issue with laptops where this might bounce the display off
+	 * then on.  Ideally we'd get a notification from userspace
+	 * when this happens but we don't so just wait a bit and hope
+	 * we waited long enough.  It'd be better if we'd only do
+	 * this on systems that need it.
 	 */
-	schedule_delayed_work(&regulator_init_complete_work,
-			      msecs_to_jiffies(30000));
+	schedule_delayed_work(&regulator_init_complete_work, delay * HZ);
 
 	return 0;
 }
-- 
2.17.1

