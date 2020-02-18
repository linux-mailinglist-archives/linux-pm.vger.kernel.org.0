Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD34E1635CE
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2020 23:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgBRWHz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Feb 2020 17:07:55 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44877 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbgBRWHz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Feb 2020 17:07:55 -0500
Received: by mail-pl1-f194.google.com with SMTP id d9so8635003plo.11
        for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2020 14:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=pIQXW5hE1+eSM3lLosf+UpP271pqaf4+040KGno05/4=;
        b=SRtKjPviRKEjd1+AkFb+3aF7EF0gSfjDVNUnYCbnP61y6zy0QwngTevwCuBByt54RM
         NCBHDna6P/lH3I12T466ZtCwtuM3bL81j8Uy+J97lb9E9xMz3su4W67vNe2Jm5/uwg29
         rWrp3OcLGEcuwRD3jzS3Ue8q5WiwOrS/I6S+FJIdHWs8nru69mBWX99SxoTIRV2XX0Kj
         Bg8lf2AdIscIqA9ls5CJ25PKrG+53/wJ4wkJXaftY2kDv1zU+/Ps4cXP4hpKNIepM5jB
         JaxySFOiycK1STIlUc0//eNyy07OTqRm4DvoYZ1TIJN0FvYwqkz3iAsBNmbYXjeR5Nvy
         Bqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pIQXW5hE1+eSM3lLosf+UpP271pqaf4+040KGno05/4=;
        b=eDKO9J7OSt0GmuO6sQylZZ32iJUIcLIG7+WujoSFjzFZ86ziHoh0w5XoUNxQ7FODRI
         DMac2LZf8l20spS65awegYG63SqjmHEaO+GBAduULL1F/v9JMWjny7mBhuQzMC9/fUIU
         IMNLOikmnqqLG4p1GpG3LxolZ8WSeL7TCbokV8bs3lOx8UR/RufOxLvi4JdOh8ogKPmu
         Hi42cEl7eZPSpr4bZXfsD7yUrNXWhNkZRzyID14+WOqGXqVT210qLe0Ctfpb+Rx1MZuO
         UWGnrdg/fxoN+WQv+za/y517IGOco2dgqlOh2rIpSo9XZZ8ElP7Yh0XulX08sJSfjJX7
         A3rg==
X-Gm-Message-State: APjAAAWkzFmYtIZWqLzXhB/5KwCdqzQJCmZKALjOyfye3ia/4PiQd2jJ
        Y755xALKOX77VzHM3o/cDF50HQ==
X-Google-Smtp-Source: APXvYqyCxijq9UmWFDyySgQnBxHFONgdNjoM9hfMVUkV+GEVmtIRioztxSn530rGJVEEY1Mr5+8f5A==
X-Received: by 2002:a17:90a:8c0f:: with SMTP id a15mr5390408pjo.86.1582063674983;
        Tue, 18 Feb 2020 14:07:54 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id d69sm5485229pfd.72.2020.02.18.14.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 14:07:54 -0800 (PST)
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
Subject: [PATCH v3 1/2] driver core: Rework logic in __driver_deferred_probe_check_state to allow EPROBE_DEFER to be returned for longer
Date:   Tue, 18 Feb 2020 22:07:47 +0000
Message-Id: <20200218220748.54823-1-john.stultz@linaro.org>
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

This patch reworks some of the logic in
__driver_deferred_probe_check_state() so that if the
deferred_probe_timeout value is set, we will return EPROBE_DEFER
until that timeout expires, which may be after initcalls_done
is set to true.

Specifically, on db845c, this change (when combined with booting
using deferred_probe_timeout=30) allows us to set SDM_GPUCC_845,
QCOM_CLK_RPMH and COMMON_CLK_QCOM as modules and get a working
system, where as without it the display will fail to load.

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
v2:
* Add calls to driver_deferred_probe_trigger() after the two minute timeout,
  as suggested by Bjorn
* Minor whitespace cleanups
* Switch to 30 second timeout to match what the regulator code is doing as
  suggested by Rob.
v3:
* Rework to reuse existing deferred_probe_timeout value, suggested by Rob
* Dropped Fixes: tags as Rob requested (Not my hill to die on :)
---
 drivers/base/dd.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index b25bcab2a26b..9d916a7b56a6 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -237,13 +237,12 @@ __setup("deferred_probe_timeout=", deferred_probe_timeout_setup);
 
 static int __driver_deferred_probe_check_state(struct device *dev)
 {
-	if (!initcalls_done)
-		return -EPROBE_DEFER;
-
-	if (!deferred_probe_timeout) {
+	if (initcalls_done && !deferred_probe_timeout) {
 		dev_WARN(dev, "deferred probe timeout, ignoring dependency");
 		return -ETIMEDOUT;
 	}
+	if (!initcalls_done || deferred_probe_timeout > 0)
+		return -EPROBE_DEFER;
 
 	return 0;
 }
-- 
2.17.1

