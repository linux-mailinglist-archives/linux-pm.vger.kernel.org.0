Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85AEA13038A
	for <lists+linux-pm@lfdr.de>; Sat,  4 Jan 2020 17:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgADQ2C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Jan 2020 11:28:02 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:3383 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbgADQ2C (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 4 Jan 2020 11:28:02 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47qnHx6lz9zGW;
        Sat,  4 Jan 2020 17:27:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1578155279; bh=GLCJ+xn1C18+8zix7hQRYKYNNDap+S2nPn1PT1f0fAo=;
        h=Date:From:Subject:To:Cc:From;
        b=EXfdxlNhkqjQRtYM8nO5nXcAQgeOkSeHTz1Gq2GdzrL5BuaTmIpoVK/bU+FxolnXb
         Q/UNlWv+tg+WljGOfuiCgAxugAWpso8C6fXgm5DRMAu+3syGS1GdIBjA6eebokd7Qx
         bFN6TzSwrnd6ubV+l3fHAw1NfgUPbpuVYqMTfIpf+sWchUkooPebRhYUEcAGhB1X55
         FOEiliVRbYVaFHRRbQgxT3aql8NHcAkBpTvVoShqLYzScy1gqCwAASVDJl2DRbUYWU
         L7ADjnp+dduBD13sUXL4HRk3NCJsx+4tHhJTZIpYdJkYXKhdgUk+K5uaah/qAd/bhh
         b4590hMWlokZg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Sat, 04 Jan 2020 17:27:57 +0100
Message-Id: <cb199a03895f8a11d9039209e6ac1cd92b1d1fb9.1578155207.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] PM-runtime: add tracepoints for usage_count changes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add tracepoints to remaining places where device's power.usage_count
is changed. This helps debugging where and why autosuspend is prevented.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/base/power/runtime.c | 13 +++++++++++--
 include/trace/events/rpm.h   |  6 ++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 48616f358854..16134a69bf6f 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1006,8 +1006,10 @@ int __pm_runtime_idle(struct device *dev, int rpmflags)
 	int retval;
 
 	if (rpmflags & RPM_GET_PUT) {
-		if (!atomic_dec_and_test(&dev->power.usage_count))
+		if (!atomic_dec_and_test(&dev->power.usage_count)) {
+			trace_rpm_usage_rcuidle(dev, rpmflags);
 			return 0;
+		}
 	}
 
 	might_sleep_if(!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe);
@@ -1038,8 +1040,10 @@ int __pm_runtime_suspend(struct device *dev, int rpmflags)
 	int retval;
 
 	if (rpmflags & RPM_GET_PUT) {
-		if (!atomic_dec_and_test(&dev->power.usage_count))
+		if (!atomic_dec_and_test(&dev->power.usage_count)) {
+			trace_rpm_usage_rcuidle(dev, rpmflags);
 			return 0;
+		}
 	}
 
 	might_sleep_if(!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe);
@@ -1101,6 +1105,7 @@ int pm_runtime_get_if_in_use(struct device *dev)
 	retval = dev->power.disable_depth > 0 ? -EINVAL :
 		dev->power.runtime_status == RPM_ACTIVE
 			&& atomic_inc_not_zero(&dev->power.usage_count);
+	trace_rpm_usage_rcuidle(dev, 0);
 	spin_unlock_irqrestore(&dev->power.lock, flags);
 	return retval;
 }
@@ -1434,6 +1439,8 @@ void pm_runtime_allow(struct device *dev)
 	dev->power.runtime_auto = true;
 	if (atomic_dec_and_test(&dev->power.usage_count))
 		rpm_idle(dev, RPM_AUTO | RPM_ASYNC);
+	else
+		trace_rpm_usage_rcuidle(dev, RPM_AUTO | RPM_ASYNC);
 
  out:
 	spin_unlock_irq(&dev->power.lock);
@@ -1501,6 +1508,8 @@ static void update_autosuspend(struct device *dev, int old_delay, int old_use)
 		if (!old_use || old_delay >= 0) {
 			atomic_inc(&dev->power.usage_count);
 			rpm_resume(dev, 0);
+		} else {
+			trace_rpm_usage_rcuidle(dev, 0);
 		}
 	}
 
diff --git a/include/trace/events/rpm.h b/include/trace/events/rpm.h
index 26927a560eab..3c716214dab1 100644
--- a/include/trace/events/rpm.h
+++ b/include/trace/events/rpm.h
@@ -74,6 +74,12 @@ DEFINE_EVENT(rpm_internal, rpm_idle,
 
 	TP_ARGS(dev, flags)
 );
+DEFINE_EVENT(rpm_internal, rpm_usage,
+
+	TP_PROTO(struct device *dev, int flags),
+
+	TP_ARGS(dev, flags)
+);
 
 TRACE_EVENT(rpm_return_int,
 	TP_PROTO(struct device *dev, unsigned long ip, int ret),
-- 
2.20.1

