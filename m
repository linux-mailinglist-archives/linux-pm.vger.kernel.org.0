Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFA9A15FAA9
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2020 00:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgBNXcc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Feb 2020 18:32:32 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35360 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbgBNXcc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Feb 2020 18:32:32 -0500
Received: by mail-pg1-f195.google.com with SMTP id v23so2296424pgk.2
        for <linux-pm@vger.kernel.org>; Fri, 14 Feb 2020 15:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=AEe1XGyTWqkzhlgRgpYtuBl1Yjp3hmm+kvRYMs3wUvI=;
        b=EkJxDj2mwMx8wX8lW1XNriMQ9dQgixwTl+SgJLSFykIMCJfld/jkqDJvmdh3e+phRd
         D1U8AyXTN9kM7Y8TUjYPDxDYUfnz3nWAdNh1+fAs8jye/mNN2AhFMdd+V9buD7wei9Ru
         oeO/l5QJHhRD/leFqBO0fYZigih9psvg/4LIMuBiiKVxKfqzQtsyV3uoO9bHZRsSaIwZ
         whj4LStOg5tGpEl/Pd3nVXGv13x00suiNECZnLuOoLhHZhtt08FfanM2eOqEe8qt5EVa
         DLSi6rOL3QZJb+sb2OqrsCJQHV4Gf15WJwJwNT6JM/Xt143CUEqeXIT3RRwTf6LslRGO
         goIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AEe1XGyTWqkzhlgRgpYtuBl1Yjp3hmm+kvRYMs3wUvI=;
        b=Y2ll30d09n5E95KcOgnQB6fYtlagR10fgrNhUf6/Ep3aWPq5ihrg4P1wedcdslPZ8f
         AJugH3EQ2ly1CnY47+JxOcEp45GKkvVphrp2HSQ6iWxYxzKsNHnWcO2fU4BBr5+S4g4/
         666h1n1hZ1sfZEtzJkLnkhRasmb8FEPMmOh934PFgB19akAWjGPGECx6vlrsQdPpnZ2Q
         a3pXHVyHu3GaBvTGn5tLIWOL6NawZxq+CtssUJPC2HdVw3DMuzT88783kbrPAGOPermH
         Ufmaeo6sBrC4SryvmUQXtxAByGy5hBIIMtTF4gmDqfJrG2lpemWakzjhwwljJAP7BnxO
         U+hw==
X-Gm-Message-State: APjAAAX8dgNJQswZH3cuyT7TzR/4VSk3YI0Rs5b6Nulhf9RujZvOmheh
        ntMaxluJeq4Q2qC//Bdbxq0qVQ==
X-Google-Smtp-Source: APXvYqzgBII0sPALArT4QCNkYh1u20q+JC7yfNO/Gi6+mOWOSy+wsplpo6Z8vkCPl9zmgRj3oAGlHA==
X-Received: by 2002:a63:5a65:: with SMTP id k37mr6172994pgm.264.1581723151766;
        Fri, 14 Feb 2020 15:32:31 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id t186sm8596702pgd.26.2020.02.14.15.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 15:32:31 -0800 (PST)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2] driver core: Extend returning EPROBE_DEFER for two minutes after late_initcall
Date:   Fri, 14 Feb 2020 23:32:26 +0000
Message-Id: <20200214233226.82096-1-john.stultz@linaro.org>
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
time that EPROBE_DEFER is retruned by 30 seconds, to (hopefully)
ensure that everything has had a chance to load.

30 seconds was chosen to match the similar timeout used by the
regulator code here in commit 55576cf18537 ("regulator: Defer
init completion for a while after late_initcall")

Specifically, on db845c, this change allows us to set
SDM_GPUCC_845, QCOM_CLK_RPMH and COMMON_CLK_QCOM as modules and
get a working system, where as without it the display will fail
to load.

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
v2:
* Add calls to driver_deferred_probe_trigger() after the two minute timeout,
  as suggested by Bjorn
* Minor whitespace cleanups
* Switch to 30 second timeout to match what the regulator code is doing as
  suggested by Rob.
---
 drivers/base/dd.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index d811e60610d3..0f519ef3b257 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -311,6 +311,15 @@ static void deferred_probe_timeout_work_func(struct work_struct *work)
 }
 static DECLARE_DELAYED_WORK(deferred_probe_timeout_work, deferred_probe_timeout_work_func);
 
+static void deferred_initcall_done_work_func(struct work_struct *work)
+{
+	initcalls_done = true;
+	driver_deferred_probe_trigger();
+	flush_work(&deferred_probe_work);
+}
+static DECLARE_DELAYED_WORK(deferred_initcall_done_work,
+			    deferred_initcall_done_work_func);
+
 /**
  * deferred_probe_initcall() - Enable probing of deferred devices
  *
@@ -327,7 +336,8 @@ static int deferred_probe_initcall(void)
 	driver_deferred_probe_trigger();
 	/* Sort as many dependencies as possible before exiting initcalls */
 	flush_work(&deferred_probe_work);
-	initcalls_done = true;
+	schedule_delayed_work(&deferred_initcall_done_work,
+			      msecs_to_jiffies(30000));
 
 	/*
 	 * Trigger deferred probe again, this time we won't defer anything
-- 
2.17.1

