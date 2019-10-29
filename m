Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D559E8287
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 08:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfJ2Hbv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 03:31:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40640 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfJ2Hbv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 03:31:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id r4so3246395pfl.7
        for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2019 00:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pcHTqmnnCL/NWw1R6J/1w2hmcyaktVbA1aDRoVWc/is=;
        b=IVuaIgCPZu9De21EzBOreBg3aTxziZOG+fuPnNADlZBgt6QVIoRuTI0aziDjm/WR0C
         5Evep3E6sG+j/ldomU0+cof21z+nhLFjg2IhMsRTCUpmMf0kXMAzRUdMnWsQ243ImYOM
         Mgr0uupo5clmKCVs/WwbmtD43orjyfkpw73Pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pcHTqmnnCL/NWw1R6J/1w2hmcyaktVbA1aDRoVWc/is=;
        b=c3txfNSLkV3KoDRH51ANW7BbYSy5hdA+J4L/H8TPuy/DE1MPfoQq7xFLKqoRoSvIeK
         Wcq+Az/XGFB+M+SOhFRGT1tJL9kxvfCVf6pB3+y1/lV2HmqV2ct3Hzg6MycR8FQBTW6t
         hqpaTmsiCOr4rAEbQHj/eRSMZZJmbcwsW9/P9iWLSosKT2XrX36JjwkgRDOgjHIpfEks
         50/CZIjPZwU/JXNGlELdhBlspfh67Xm/K7Hov9e8jfcYLfEsVD0yUdxAxI0e7e9MKb3s
         p/Kup0R3zKuR9eWjPnbUK/LLQHpK4xikhpYvPZQtTPqvzMqWBqhgWMPHFGnfE9648rr4
         tYyw==
X-Gm-Message-State: APjAAAXv8QBfpJWw9n5lC8T5JGTMansLU9p6IepIX1nF0Ye9UOHSXSRZ
        h3s5BXn2YfRvzjsPd8FN1HsLoVWns0S1CQ==
X-Google-Smtp-Source: APXvYqwf35aJKp32xWbepK70jpGUJiEK0cVshmX9rYiLnqh7a1/mBOk+sLo/xDDsfylN6916/n8uqQ==
X-Received: by 2002:a63:df11:: with SMTP id u17mr2028144pgg.27.1572334310304;
        Tue, 29 Oct 2019 00:31:50 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:254e:2b40:ef8:ee17])
        by smtp.gmail.com with ESMTPSA id b23sm1563020pju.16.2019.10.29.00.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 00:31:49 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "Pavel Machek )" <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH] cpuidle: undelaying cpuidle in dpm_{suspend|resume}()
Date:   Tue, 29 Oct 2019 15:31:45 +0800
Message-Id: <20191029073145.154869-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

cpuidle is paused only during dpm_suspend_noirq() ~ dpm_resume_noirq().
But some device drivers need random sized IOs in dpm_{suspend|resume}()
stage (e.g. re-downloading firmware in resume).
And with such a device, cpuidle's latencies could be critical to
response time of system suspend/resume.

To minimize those latencies, we could apply pm_qos to such device drivers,
but simply undelaying cpuidle from dpm_suspend_noirq() to dpm suspend()
seems no harm.
---
 drivers/base/power/main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 134a8af51511..5928dd2139e8 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -773,8 +773,6 @@ void dpm_resume_noirq(pm_message_t state)
 
 	resume_device_irqs();
 	device_wakeup_disarm_wake_irqs();
-
-	cpuidle_resume();
 }
 
 static pm_callback_t dpm_subsys_resume_early_cb(struct device *dev,
@@ -1069,6 +1067,7 @@ void dpm_resume(pm_message_t state)
 
 	cpufreq_resume();
 	devfreq_resume();
+	cpuidle_resume();
 	trace_suspend_resume(TPS("dpm_resume"), state.event, false);
 }
 
@@ -1411,8 +1410,6 @@ int dpm_suspend_noirq(pm_message_t state)
 {
 	int ret;
 
-	cpuidle_pause();
-
 	device_wakeup_arm_wake_irqs();
 	suspend_device_irqs();
 
@@ -1830,6 +1827,7 @@ int dpm_suspend(pm_message_t state)
 	trace_suspend_resume(TPS("dpm_suspend"), state.event, true);
 	might_sleep();
 
+	cpuidle_pause();
 	devfreq_suspend();
 	cpufreq_suspend();
 
-- 
2.24.0.rc0.303.g954a862665-goog

