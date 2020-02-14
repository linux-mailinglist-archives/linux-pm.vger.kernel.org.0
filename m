Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3323F15CF2F
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2020 01:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbgBNAoW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 19:44:22 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40076 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbgBNAoW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2020 19:44:22 -0500
Received: by mail-pg1-f194.google.com with SMTP id z7so4028255pgk.7
        for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2020 16:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3kKnrEZnWkNPVAd2iboNdWLqrlgxcpOSWe5JDchkAgM=;
        b=jCt0BWX3EOA8tmmzwv9m6xgX7LFDTeGfld9TPGumhKfCmQYLgEScq/1kDMuepH8odY
         adIltx1W8F3H3QNBIVPyTXLE3XS4gzq6tnIONKcdu6XSnlUBdq6JJdQIwoXdeb/hW4Xr
         6YHBgzWsytRxxhcNm496CW6jToVTSKkfHHoN8Q5eUHYDY08hCxxqbeUD9TctvGdT613K
         OD8Ipc13FNQyHyH26iDSsAMmCN/ivzXLVToIMGZ+XQzAftiSCm6G48fkwKPvyBWtYqYA
         HPW6W+0BdjaTzQzzXPOZwPyhiA/qOJEDdogwuLeBUGGOfCR8RfjvW/FbqP8FErdrW4RF
         Ja6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3kKnrEZnWkNPVAd2iboNdWLqrlgxcpOSWe5JDchkAgM=;
        b=bdF99LuoktBmtRby/GS01+PfKWIia2TbYKGzRWmZxCZlfwP5STUSTvd0+aAHhBxh3B
         ZVOgd3GsMsBiZY/9SHSH5ocg8YvDS911BXg+AZQArsazuSVP+W9+rcwuGH0xycbzdjIH
         1s6XynASC3JIWTu+oFhtmBw3RZeNOXclG+0bExqaPf8Nk31mqCO4fUf6UpJP8N+LWUZN
         Dq7ShkzdH94EwI+C/rh4wDNpsyXzZtV3tO2YAze/v8kf3rePcFhZk0pdJxKw2vZ8SQfL
         YvPr/dzNq4zg/x5kKPG3/l6Q7uIBPh2381AZy7LAkx1Tg1iiSHnuPM8TId2FiFp2OjGI
         /2wg==
X-Gm-Message-State: APjAAAWfBwD9m1twatlTeJBSg9sXQHWw+2516fMhNCQcz2F2JFrMOBhy
        9Kc++nLCl+cUMo5pK+e07ibdcQ==
X-Google-Smtp-Source: APXvYqyWjsGHbuLmeC0Qkr8LysXeNaNX6lbId4wRg4KfbMI1haOpAJPgKnApW0xvAZLeT6g9ThRvkA==
X-Received: by 2002:a63:354b:: with SMTP id c72mr550271pga.99.1581641061330;
        Thu, 13 Feb 2020 16:44:21 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id l29sm4424333pgb.86.2020.02.13.16.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 16:44:20 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Subject: [RFC][PATCH] driver core: Extend returning EPROBE_DEFER for two minutes after late_initcall
Date:   Fri, 14 Feb 2020 00:44:13 +0000
Message-Id: <20200214004413.12450-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Due to commit e01afc3250255 ("PM / Domains: Stop deferring probe
at the end of initcall"), along with commit 25b4e70dcce9
("driver core: allow stopping deferred probe after init") after
late_initcall, drivers will stop getting EPROBE_DEFER, and
instead see an error causing the driver to fail to load.

That change causes trouble when trying to use many clk drivers
as modules, as the clk modules may not load until much later
after init has started. If a dependent driver loads and gets an
error instead of EPROBE_DEFER, it won't try to reload later when
the dependency is met, and will thus fail to load.

Instead of reverting that patch, this patch tries to extend the
time that EPROBE_DEFER is retruned by two minutes, to (hopefully)
ensure that everything has had a chance to load.

Specifically, on db845c, this change allows us to set
SDM_GPUCC_845, QCOM_CLK_RPMH and COMMON_CLK_QCOM as modules and
get a working system, where as without it the display will fail
to load.

Cc: Alexander Graf <agraf@suse.de>
Cc: Rob Herring <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org
Fixes: e01afc3250255 ("PM / Domains: Stop deferring probe at the end of initcall")
Fixes: 25b4e70dcce9 ("driver core: allow stopping deferred probe after init")
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/base/dd.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index b25bcab2a26b..35ebae8b65be 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -311,6 +311,12 @@ static void deferred_probe_timeout_work_func(struct work_struct *work)
 }
 static DECLARE_DELAYED_WORK(deferred_probe_timeout_work, deferred_probe_timeout_work_func);
 
+static void deferred_initcall_done_work_func(struct work_struct *work)
+{
+	initcalls_done = true;
+}
+static DECLARE_DELAYED_WORK(deferred_initcall_done_work, deferred_initcall_done_work_func);
+
 /**
  * deferred_probe_initcall() - Enable probing of deferred devices
  *
@@ -327,7 +333,7 @@ static int deferred_probe_initcall(void)
 	driver_deferred_probe_trigger();
 	/* Sort as many dependencies as possible before exiting initcalls */
 	flush_work(&deferred_probe_work);
-	initcalls_done = true;
+	schedule_delayed_work(&deferred_initcall_done_work, 120 * HZ);
 
 	/*
 	 * Trigger deferred probe again, this time we won't defer anything
-- 
2.17.1

