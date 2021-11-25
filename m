Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0FF45D715
	for <lists+linux-pm@lfdr.de>; Thu, 25 Nov 2021 10:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354039AbhKYJZR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Nov 2021 04:25:17 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:33592 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346814AbhKYJXQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Nov 2021 04:23:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637832006; x=1669368006;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Yi/35VNAKkXimM/fYXxh0+NDKseEgAXOOIxE+Q91VsA=;
  b=VTwdOGIxP5cSWV21yEMLWV3irmMWr18/o7xtjrwx4eBXaFELbgJ8Vn7n
   YIcsyXLT9mY5hg1ZVN0XB92yaTL7ckuXWAeiK6Qg/psKxmjuWaroBjCyd
   rEtBq6nXT3CACMKnS7OCdyYAlH3nm7fEXGQpGtuUgLtu1v1rG74BCB4l5
   w=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 25 Nov 2021 01:20:05 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 01:20:05 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 25 Nov 2021 01:20:05 -0800
Received: from mkshah-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 25 Nov 2021 01:15:27 -0800
From:   Maulik Shah <quic_mkshah@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ulf.hansson@linaro.org>,
        <quic_lsrao@quicinc.com>, <rnayak@codeaurora.org>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/idle: Export cpu_idle_poll_ctrl() symbol
Date:   Thu, 25 Nov 2021 14:44:36 +0530
Message-ID: <1637831676-32737-1-git-send-email-quic_mkshah@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Export cpu_idle_poll_ctrl() so that module drivers can use same.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
---
 kernel/sched/idle.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index d17b0a5..7fbc07f 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -33,6 +33,7 @@ void cpu_idle_poll_ctrl(bool enable)
 		WARN_ON_ONCE(cpu_idle_force_poll < 0);
 	}
 }
+EXPORT_SYMBOL(cpu_idle_poll_ctrl);
 
 #ifdef CONFIG_GENERIC_IDLE_POLL_SETUP
 static int __init cpu_idle_poll_setup(char *__unused)
-- 
2.7.4

