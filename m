Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 774BB165682
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 06:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgBTFFP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 00:05:15 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43092 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbgBTFFM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 00:05:12 -0500
Received: by mail-pg1-f193.google.com with SMTP id u12so1285713pgb.10
        for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2020 21:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BkWD602W7Q9Y+URRx5RQh3vyLJ/+/ea+Ab7cyJ2LVzU=;
        b=W0USwnktWAK949xSvqdULNruXCEUOenrU262+fUtA5vIIvMRyM7oAKyJ2bEQImhS6m
         K1AYiV0U3IhjqjrBZ7WeSj+TEmzIa0CEdiE1NK0sKuRLkPKyAgJeGCfOiDCEqGoIUGJN
         4W4IICZWBwQz9RJNue/bLLa+h6Q+MR8Im/7yxK1qUkPLuoZgprZfGo7P3PO7f89j9t+a
         I9rc1moqCiUG4Nktof1lcbQmGnz1w3NEOogwoKftsxf3Wyy3TbLs4dSBlmNav/6MLW1Z
         a26GHEo+6b7/2njVg0CKhg/mBjpSSjop2uLJ8ki2BG/MRcqeDZ2/NGtvq9sc38FIe08y
         tkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BkWD602W7Q9Y+URRx5RQh3vyLJ/+/ea+Ab7cyJ2LVzU=;
        b=F5ot3NTjn9NTUmyfLbH/YsVkdZVW8auKAKGBG6xpTXcDJZDge40UxUo2kHk2mjz9pn
         vExOaaYArlza6GyusdOoyd88YGgDLHkpmGnlBegANhKYqH+H11og/lVr8KgWz8KOWsLV
         b1vlExwqnjxcICdf+Bs5DThIzRejjuuylasYaxMKJcOqm7ihIezv+jizrsGHIPAt4zyF
         ffkmJy9Py5uTPcA5URQWa9Z0pQ8+lfSTe+8fF57N1S5nwZIDy07rLoC7E9IezR03Y1HJ
         8Ul6enP8E6r8s10BQ1a2A0rkc9nvZtDZfe4O5jFnDT61PXjZYnNRC7Swc7vgnAXvutKF
         0rIQ==
X-Gm-Message-State: APjAAAWgiP4CC+wyvzf3G5wQoNUyfI/nHZEOszzOc8eK4uUCNwr7gvgF
        yB5LAJB9sFhapRg6blnJkK7CjA==
X-Google-Smtp-Source: APXvYqxpWD81Pg4dHENS3JJ0u393+opZJgCR2EPptBx14uageSAhKbCtURu5uLMMtHA2wUTm2HBiIw==
X-Received: by 2002:a65:478a:: with SMTP id e10mr30287883pgs.197.1582175111731;
        Wed, 19 Feb 2020 21:05:11 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id z4sm1400847pfn.42.2020.02.19.21.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 21:05:11 -0800 (PST)
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
Subject: [PATCH v4 6/6] regulator: Use driver_deferred_probe_timeout for regulator_init_complete_work
Date:   Thu, 20 Feb 2020 05:04:40 +0000
Message-Id: <20200220050440.45878-7-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200220050440.45878-1-john.stultz@linaro.org>
References: <20200220050440.45878-1-john.stultz@linaro.org>
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
driver_deferred_probe_timeout value if it is set, otherwise we
directly call the regulator_init_complete_work_function().

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
Change-Id: I9fa2411abbb91ed4dd0edc41e8cc8583577c005b
---
v4:
* Split out into its own patch, as suggested by Mark
---
 drivers/regulator/core.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d015d99cb59d..394e7b11576a 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5767,18 +5767,21 @@ static int __init regulator_init_complete(void)
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
+	if (driver_deferred_probe_timeout >= 0)
+		schedule_delayed_work(&regulator_init_complete_work,
+				      driver_deferred_probe_timeout * HZ);
+	else
+		regulator_init_complete_work_function(NULL);
 
 	return 0;
 }
-- 
2.17.1

