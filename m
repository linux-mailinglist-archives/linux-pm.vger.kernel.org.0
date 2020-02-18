Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A94F71635D0
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2020 23:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgBRWIB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Feb 2020 17:08:01 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39134 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbgBRWIA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Feb 2020 17:08:00 -0500
Received: by mail-pf1-f196.google.com with SMTP id 84so11353063pfy.6
        for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2020 14:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fddqMLrJQRzitZYDWKracPUF7ZxdfWRkTJcAoveCrU4=;
        b=mmw76NmczqpmMPWrvF9Ft4knfpYOpBH1k9zm30aH7yEQMHUhBCzxgjawY42G45pvrr
         yVy4o05/H4pYCJiyFtK6nuYF2ajeZMNdFCliPZzHwkT2u2GW8/aVBa3/4l/8j1pLxwdj
         sAMw6G/5BWHnxjLr0v0kMBbraVai3qvzSoE831+6VrRU13KtR7ya8b6DLvInjaMZi1bI
         W71mrPIUlgkCGlqLG7a4Rz7l6S5Yt5/nbxEM79w3oWxdzB87/zbx+OgpU9Zpic7g+dCE
         3JHSB2g/+OLvu8wZGOi0ioAIRB/SlEDkPVG5w3lhzugI1vbh0vJqISRsh9M0P/hSNF3S
         Ruaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fddqMLrJQRzitZYDWKracPUF7ZxdfWRkTJcAoveCrU4=;
        b=G/2WH47XR1ekz+2cE1vQR3griY+JeAaM97i5uh89eXFQIQ56Yr+UXqA5+NVkWotCNN
         3HSC7jvpOTZkTKHNAy5DBo5nyMnp18Y7dAefCDChtpeJnDm14sCvIA6ORzhC6FowWn1j
         VRbWPw7Usw7QaZQXGoF0mHIqPL5pZQdZkq+uTR9XwmtwqJwDXP1RIvUdi/42YMi3sSkc
         doL5n0RDOC5Hcq25h0JrNsmO2n1vQ7uJipjWadoXDt+Cm8mPcnJPorgecIz9TMSaIuzJ
         iTqXY0rGNhF7ueHlOtC0K/itPvHucu78RmDxKgsPj8YTha55H6t63csI6srQ+FpOgp1m
         pV9Q==
X-Gm-Message-State: APjAAAUpeXIFRP5YJAlfCrpx0Yj9ai1vo/H+VY6vxRc0pjw3k/VobNdv
        GPHKxBnLzW36/0pTIwjV0Tffyw==
X-Google-Smtp-Source: APXvYqza44F+QlcD0d2mvFzZr70iF4BFKK30MuvV2w4EOISTJkmXAY1nf3jjtKHvFEA9mrY8032psg==
X-Received: by 2002:a63:e4d:: with SMTP id 13mr24648668pgo.343.1582063679790;
        Tue, 18 Feb 2020 14:07:59 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id d69sm5485229pfd.72.2020.02.18.14.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 14:07:59 -0800 (PST)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 2/2] driver core: Make deferred_probe_timeout global so it can be shared
Date:   Tue, 18 Feb 2020 22:07:48 +0000
Message-Id: <20200218220748.54823-2-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200218220748.54823-1-john.stultz@linaro.org>
References: <20200218220748.54823-1-john.stultz@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch, suggested by Rob, allows deferred_probe_timeout to
be global so other substems can use it.

This also sets the default to 30 instead of -1 (no timeout) and
modifies the regulator code to make use of it instead of its
hard-coded 30 second interval.

In the case that deferred_probe_timeout is manually set to -1,
we preserve the regulator's hard coded 30 second interval (just
to be cautious this doesn't change behavior in that case).

Feedback would be apprecaited!

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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/base/dd.c             |  4 +++-
 drivers/regulator/core.c      | 12 ++++++++----
 include/linux/device/driver.h |  1 +
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 9d916a7b56a6..c8e025a20a9d 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -224,7 +224,9 @@ static int deferred_devs_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(deferred_devs);
 
-static int deferred_probe_timeout = -1;
+int deferred_probe_timeout = 30;
+EXPORT_SYMBOL_GPL(deferred_probe_timeout);
+
 static int __init deferred_probe_timeout_setup(char *str)
 {
 	int timeout;
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d015d99cb59d..889d08e65f19 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5757,6 +5757,11 @@ static DECLARE_DELAYED_WORK(regulator_init_complete_work,
 
 static int __init regulator_init_complete(void)
 {
+	int delay = deferred_probe_timeout;
+
+	/* preserve 30 second interval if deferred_probe_timeout=-1 */
+	if (delay < 0)
+		delay = 30;
 	/*
 	 * Since DT doesn't provide an idiomatic mechanism for
 	 * enabling full constraints and since it's much more natural
@@ -5767,18 +5772,17 @@ static int __init regulator_init_complete(void)
 		has_full_constraints = true;
 
 	/*
-	 * We punt completion for an arbitrary amount of time since
+	 * We punt completion for deferred_probe_timeout seconds since
 	 * systems like distros will load many drivers from userspace
 	 * so consumers might not always be ready yet, this is
 	 * particularly an issue with laptops where this might bounce
 	 * the display off then on.  Ideally we'd get a notification
 	 * from userspace when this happens but we don't so just wait
 	 * a bit and hope we waited long enough.  It'd be better if
-	 * we'd only do this on systems that need it, and a kernel
-	 * command line option might be useful.
+	 * we'd only do this on systems that need it.
 	 */
 	schedule_delayed_work(&regulator_init_complete_work,
-			      msecs_to_jiffies(30000));
+			      delay * HZ);
 
 	return 0;
 }
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index 1188260f9a02..b3ff8cb3fbd6 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -236,6 +236,7 @@ driver_find_device_by_acpi_dev(struct device_driver *drv, const void *adev)
 }
 #endif
 
+extern int deferred_probe_timeout;
 void driver_deferred_probe_add(struct device *dev);
 int driver_deferred_probe_check_state(struct device *dev);
 int driver_deferred_probe_check_state_continue(struct device *dev);
-- 
2.17.1

