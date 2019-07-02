Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA50F5D45E
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2019 18:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfGBQhk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Jul 2019 12:37:40 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35707 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfGBQhk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jul 2019 12:37:40 -0400
Received: by mail-pf1-f195.google.com with SMTP id d126so8522489pfd.2;
        Tue, 02 Jul 2019 09:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NYZ57S8+5msbgEMn5snGscs4rwz8rkIKtf7x8l1lYQE=;
        b=GZYyXiOGbdNfWm/DV/QCi62ZdcNtive77vFOQvX/pzUTI6jMk9r03Ah5Pr4KKJLaHg
         Xe7nONmL8B5KFRpFhnOsA9KOf6XWmGwIa0AsjcjavohnfBIe9CI5YmxtMottFX/HeMRC
         UQ4gwpkB98h29zdBanJJdhh7DmrOmAuIdeMHb1jPXkWcyk6Uql5Pev35KzBeZmjgN1FK
         TK4jstpF91wQUbNtXgVHEf8jUalamdAqt6HJ221Q/VSypJSVQv1zx4/opcIlVptWXmQa
         0uKVf9wA58ZKWg8kRs9vdofF6aHaIpMBEWqJonSHKvku1v0eHhO/4PbcJPDXHJDoHHJ4
         Qe0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NYZ57S8+5msbgEMn5snGscs4rwz8rkIKtf7x8l1lYQE=;
        b=HCrZq8l475QW+AD1XvA3w+66URW//R9EMKX3VwNWOcFLJP8VVG1gnHocVzmW00lMDg
         mirBi6LDGbj71ZM0TV9Ps41AX+bv7JLv15fvRLMBodXs4iumDPKq0a/1UO6lXkkoZ0Xk
         hflZDXTuiRv3eR9us80uwh7qJ+VnCbr2rnQCRQt0VV0vPDyb0iPbWjgvrSSzA/pa5WAe
         G72sN3jtaYHk5p3wInT3GIU7pjxhdNiEuY9IoVgO4iP1Nf6j579KWUEbtkRliu5cIjSl
         e1twrU49TxI6htyyW+h4HAprTvJOrOyLqZXk+Oy4aOzS1Umn8aEsFjJ1XjmscCUhvT70
         DHMQ==
X-Gm-Message-State: APjAAAV7A1/cuGvd6Dlvao9Z7HjIlZKA6Fqu8JIXUMzlg1hGJdlpnYtY
        mnCD8GVkkDVjRIs9jXWBenU=
X-Google-Smtp-Source: APXvYqxT2Pp+5yIYJFV/YhIkMNWjBX/bUQ7jvjjStBtNKpMrF9bA1b0XgDxq1Qy815bz8WZH+SxwsA==
X-Received: by 2002:a65:5304:: with SMTP id m4mr31325278pgq.126.1562085459929;
        Tue, 02 Jul 2019 09:37:39 -0700 (PDT)
Received: from localhost.localdomain ([104.238.150.158])
        by smtp.gmail.com with ESMTPSA id s24sm14977148pfh.133.2019.07.02.09.37.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 09:37:39 -0700 (PDT)
From:   Muchun Song <smuchun@gmail.com>
To:     rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] PM: Move disabling/enabling runtime PM to suspend/resume noirq
Date:   Wed,  3 Jul 2019 00:37:15 +0800
Message-Id: <20190702163715.12649-1-smuchun@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently, the PM core disables runtime PM for all devices right after
executing subsystem/driver .suspend_late() callbacks for them and
re-enables it right before executing subsystem/driver .resume_early()
callbacks for them. This may lead to problems when there are two devices
such that the irq handler thread function executed for one of them
depends on runtime PM working for the other. E.g. There are two devices,
one is i2c slave device depends on another device which can be the i2c
adapter device. The slave device can generate system wakeup signals and
is enabled to wake up the system(via call enable_irq_wake()). So, the irq
of slave device is enabled. If a wakeup signal generate after executing
subsystem/driver .suspend_late() callbacks. Then, the irq handler thread
function will be called(The irq is requested via request_threaded_irq())
and the slave device reads data via i2c adapter device(via i2c_transfer()).
In that case, it may be failed to read data because of the runtime PM
disabled.

It is also analogously for resume. If a wakeup signal generate when the
system is in the sleep state. The irq handler thread function may be
called before executing subsystem/driver .resume_early(). In that case,
it also may be failed to read data because of the runtime PM disabled.

To make those issues go away, make the PM core disable runtime PM for
devices right before executing subsystem/driver .suspend_noirq() callbacks
for them and enable runtime PM for them right after executing subsystem/
driver .resume_noirq() callbacks for them.

Signed-off-by: Muchun Song <smuchun@gmail.com>
---

Change in v2:
       Update subject from:
           "PM: Move disabling/enabling runtime PM to noirq suspend/early resume"
       to:
           "PM: Move disabling/enabling runtime PM to suspend/resume noirq"

 Documentation/power/runtime_pm.txt | 4 ++--
 drivers/base/power/main.c          | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/power/runtime_pm.txt b/Documentation/power/runtime_pm.txt
index 937e33c46211..8cca4df3adc4 100644
--- a/Documentation/power/runtime_pm.txt
+++ b/Documentation/power/runtime_pm.txt
@@ -691,11 +691,11 @@ out the following operations:
     pm_runtime_barrier() is called for every device right before executing the
     subsystem-level .suspend() callback for it.  In addition to that the PM core
     calls  __pm_runtime_disable() with 'false' as the second argument for every
-    device right before executing the subsystem-level .suspend_late() callback
+    device right before executing the subsystem-level .suspend_noirq() callback
     for it.
 
   * During system resume pm_runtime_enable() and pm_runtime_put() are called for
-    every device right after executing the subsystem-level .resume_early()
+    every device right after executing the subsystem-level .resume_noirq()
     callback and right after executing the subsystem-level .complete() callback
     for it, respectively.
 
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index dcfc0a36c8f7..ad0282d637ae 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -693,6 +693,7 @@ static int device_resume_noirq(struct device *dev, pm_message_t state, bool asyn
 	}
 
 Out:
+	pm_runtime_enable(dev);
 	complete_all(&dev->power.completion);
 	TRACE_RESUME(error);
 	return error;
@@ -860,7 +861,6 @@ static int device_resume_early(struct device *dev, pm_message_t state, bool asyn
  Out:
 	TRACE_RESUME(error);
 
-	pm_runtime_enable(dev);
 	complete_all(&dev->power.completion);
 	return error;
 }
@@ -1299,6 +1299,8 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
 	TRACE_DEVICE(dev);
 	TRACE_SUSPEND(0);
 
+	__pm_runtime_disable(dev, false);
+
 	dpm_wait_for_subordinate(dev, async);
 
 	if (async_error)
@@ -1508,8 +1510,6 @@ static int __device_suspend_late(struct device *dev, pm_message_t state, bool as
 	TRACE_DEVICE(dev);
 	TRACE_SUSPEND(0);
 
-	__pm_runtime_disable(dev, false);
-
 	dpm_wait_for_subordinate(dev, async);
 
 	if (async_error)
-- 
2.17.1

