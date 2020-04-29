Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3F41BE522
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 19:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgD2RXx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 13:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726524AbgD2RXx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 13:23:53 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCF7C03C1AE
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2020 10:23:53 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d3so1326463pgj.6
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2020 10:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8FQ5I0LPhVl6eGhASWpUBR6rw0WhPP4gGji6IhYEdAI=;
        b=QOU1du+HE3JgAOh4rUSq9U57cptJkja6ysGuZe3A2vHYbkftoM+sSoCIowLosbnnb/
         xu/BvdUqRZev4Jwmb6Fm77ugbEMoCIGs7YDMZ1NkA51v4vQEUEkTKb+nNz+ttjmd+9oQ
         /C6ChCYBZFMZEbBDRcZVDF+Z8eCcAiOBdcjjSYgKML54CfOYIxwU74P5g95/9rYRJbJd
         8BZ6V7q+tbxSdVctyZloz1iX/uTNh4lpIheO2VUsizG0glJkXN0Z0E1kTffGvIC4bgtl
         KMAelFQtpwayijR2u6M3SzMMZdxkqXGCyz6HOBEYPi0d8HZ1c6nII09f+xyYFk39JWBk
         SCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8FQ5I0LPhVl6eGhASWpUBR6rw0WhPP4gGji6IhYEdAI=;
        b=V62eeOGl9axDYcjQoz8G69JncEF18ayMap3HTDOB7/9tS0IJEnVTQ/XbYtv4932E+D
         coat3Yo31EaDYm4dXU6ni71Y8hVp5s1T4fvnmFSB2t8qZqzKVhckzkEGOypRDNavsfAv
         3yCR2Ws9k0XmSzhn8/7+jV38OxRyTWz4MrNnEbphQWdj4oDpXQweiJ/98qgqBpqFjenI
         hcjsRdq4jrAdlGz1vloJWg9SiX0OC3e2wMp0WCw05hjEpxD0dGH238UEhUpg3dhAkH1K
         R27ZQKyKbYaA9c1Uf1YmTngJFoKBPr/pMhwvBnxu4bfNjLgwCYQ3XlcQDjbBGktL4E0O
         Ak3Q==
X-Gm-Message-State: AGi0Puat7JH3+kF19B+l0GmYk5WOB9wbczp16jTNGY6FuGkwzcMcpdkZ
        FBgpNPCJt3K/lVhMmSL3xqERQA==
X-Google-Smtp-Source: APiQypIw4v36udMuIWZcDFrQCZjgfjNurzviIuoAGQ7/1O3k+fz5uu5zvLh7g78WqTBtufAZneh1Bw==
X-Received: by 2002:a63:4d11:: with SMTP id a17mr32571000pgb.392.1588181032618;
        Wed, 29 Apr 2020 10:23:52 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y21sm1451523pfn.148.2020.04.29.10.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 10:23:51 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>, linux-pm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH] regulator: Revert "Use driver_deferred_probe_timeout for regulator_init_complete_work"
Date:   Wed, 29 Apr 2020 17:23:49 +0000
Message-Id: <20200429172349.55979-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This reverts commit dca0b44957e5 ("regulator: Use
driver_deferred_probe_timeout for regulator_init_complete_work"),
as we ended up reverting the default deferred_probe_timeout
value back to zero, to preserve behavior with 5.6 we need to
decouple the regulator timeout which was previously 30 seconds.

This avoids breaking some systems that depend on the regulator
timeout but don't require the deferred probe timeout.

Cc: linux-pm@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Rob Herring <robh@kernel.org>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/regulator/core.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index c340505150b6..7486f6e4e613 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5754,10 +5754,6 @@ static DECLARE_DELAYED_WORK(regulator_init_complete_work,
 
 static int __init regulator_init_complete(void)
 {
-	int delay = driver_deferred_probe_timeout;
-
-	if (delay < 0)
-		delay = 0;
 	/*
 	 * Since DT doesn't provide an idiomatic mechanism for
 	 * enabling full constraints and since it's much more natural
@@ -5768,17 +5764,18 @@ static int __init regulator_init_complete(void)
 		has_full_constraints = true;
 
 	/*
-	 * If driver_deferred_probe_timeout is set, we punt
-	 * completion for that many seconds since systems like
-	 * distros will load many drivers from userspace so consumers
-	 * might not always be ready yet, this is particularly an
-	 * issue with laptops where this might bounce the display off
-	 * then on.  Ideally we'd get a notification from userspace
-	 * when this happens but we don't so just wait a bit and hope
-	 * we waited long enough.  It'd be better if we'd only do
-	 * this on systems that need it.
+	 * We punt completion for an arbitrary amount of time since
+	 * systems like distros will load many drivers from userspace
+	 * so consumers might not always be ready yet, this is
+	 * particularly an issue with laptops where this might bounce
+	 * the display off then on.  Ideally we'd get a notification
+	 * from userspace when this happens but we don't so just wait
+	 * a bit and hope we waited long enough.  It'd be better if
+	 * we'd only do this on systems that need it, and a kernel
+	 * command line option might be useful.
 	 */
-	schedule_delayed_work(&regulator_init_complete_work, delay * HZ);
+	schedule_delayed_work(&regulator_init_complete_work,
+			      msecs_to_jiffies(30000));
 
 	return 0;
 }
-- 
2.17.1

