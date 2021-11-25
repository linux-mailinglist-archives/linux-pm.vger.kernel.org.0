Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A48945D68B
	for <lists+linux-pm@lfdr.de>; Thu, 25 Nov 2021 09:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353596AbhKYJAa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Nov 2021 04:00:30 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:48609 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349919AbhKYI63 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Nov 2021 03:58:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637830518; x=1669366518;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=rYTFnQt9ItpKOd8BhGrsiijq2+oxO3mBTT9Ukp8O3uw=;
  b=rg+Y4Q9jDMJf0P/O+kpfgm5JASpwZUZz3Y7jPYMdeZTnyVJQCEKEJJrn
   MZtRe+FS+Wzg6nB3NEgnlcsSqwUB4CM3KgmSu4q7UhZX+Ve8YKUDY8XcV
   kuEkPag9A2smTn2aYss8dXnclADV+J0U/R44sfnIkE8Ngv3n9HfjijZWK
   4=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 25 Nov 2021 00:55:18 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 00:55:17 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 25 Nov 2021 00:55:17 -0800
Received: from mkshah-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 25 Nov 2021 00:55:13 -0800
From:   Maulik Shah <quic_mkshah@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ulf.hansson@linaro.org>,
        <quic_lsrao@quicinc.com>, <rnayak@codeaurora.org>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 1/4] tick/sched: Export symbols used by cpuidle governors
Date:   Thu, 25 Nov 2021 14:24:38 +0530
Message-ID: <1637830481-21709-2-git-send-email-quic_mkshah@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1637830481-21709-1-git-send-email-quic_mkshah@quicinc.com>
References: <1637830481-21709-1-git-send-email-quic_mkshah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Export symbols that are used by cpuidle menu, ladder and teo governors
in preparation to allow cpuidle governors to be compiled as modules.

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
---
 kernel/time/tick-sched.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 6bffe5af..7cc6619 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -573,6 +573,8 @@ void __init tick_nohz_init(void)
  * NO HZ enabled ?
  */
 bool tick_nohz_enabled __read_mostly  = true;
+EXPORT_SYMBOL(tick_nohz_enabled);
+
 unsigned long tick_nohz_active  __read_mostly;
 /*
  * Enable / Disable tickless mode
@@ -590,6 +592,7 @@ bool tick_nohz_tick_stopped(void)
 
 	return ts->tick_stopped;
 }
+EXPORT_SYMBOL(tick_nohz_tick_stopped);
 
 bool tick_nohz_tick_stopped_cpu(int cpu)
 {
@@ -1147,6 +1150,7 @@ bool tick_nohz_idle_got_tick(void)
 	}
 	return false;
 }
+EXPORT_SYMBOL(tick_nohz_idle_got_tick);
 
 /**
  * tick_nohz_get_next_hrtimer - return the next expiration time for the hrtimer
@@ -1202,6 +1206,7 @@ ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
 
 	return ktime_sub(next_event, now);
 }
+EXPORT_SYMBOL(tick_nohz_get_sleep_length);
 
 /**
  * tick_nohz_get_idle_calls_cpu - return the current idle calls counter value
-- 
2.7.4

