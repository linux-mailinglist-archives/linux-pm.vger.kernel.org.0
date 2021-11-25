Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A310845D68F
	for <lists+linux-pm@lfdr.de>; Thu, 25 Nov 2021 09:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353623AbhKYJAf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Nov 2021 04:00:35 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:12103 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350301AbhKYI6e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Nov 2021 03:58:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637830524; x=1669366524;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=zI8HnoiSucW+m3HzAX/1TZ5pfXq//afqM7JCFEu2xDQ=;
  b=RrLi7vN3hh6odTWsZOmTNe0LTA5/cq1RG+BnatNhXiB3vFruV8humMyW
   Qt7ph0B9s4wxib783l/WgsEAEGK/k7X0kR50OAf+QU83fYDx7BkEg0NB7
   Ash7hr8NqyxKYOB5mqXGTlh3QquO634pGQg/avicKoh5Ngr4VPFtbmT1H
   E=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 25 Nov 2021 00:55:23 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 00:55:23 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 25 Nov 2021 00:55:22 -0800
Received: from mkshah-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 25 Nov 2021 00:55:17 -0800
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
Subject: [PATCH 2/4] sched/core: Export symbols used by cpuidle governors
Date:   Thu, 25 Nov 2021 14:24:39 +0530
Message-ID: <1637830481-21709-3-git-send-email-quic_mkshah@quicinc.com>
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

Export symbols that are used by cpuidle menu governor in preparation
to allow cpuidle governors to be compiled as modules.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
---
 kernel/sched/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8cffe31..1d031e0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5047,6 +5047,7 @@ unsigned int nr_iowait_cpu(int cpu)
 {
 	return atomic_read(&cpu_rq(cpu)->nr_iowait);
 }
+EXPORT_SYMBOL(nr_iowait_cpu);
 
 /*
  * IO-wait accounting, and how it's mostly bollocks (on SMP).
-- 
2.7.4

