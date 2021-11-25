Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E805045D70E
	for <lists+linux-pm@lfdr.de>; Thu, 25 Nov 2021 10:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353874AbhKYJYZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Nov 2021 04:24:25 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:21698 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349081AbhKYJWZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Nov 2021 04:22:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637831954; x=1669367954;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Yi/35VNAKkXimM/fYXxh0+NDKseEgAXOOIxE+Q91VsA=;
  b=OLmWF1D9Vo7ir+ppVpsJ2iOyajfgoQ92Fs+GRaErEiOpvIzAIxpSvG2d
   yEm7GI/tKGcDE3s7rGmqXGaViwsjKGtNbsfdOb+4vmO9M4+CKFeXeZQyW
   GZuAgxmMigkfd0VlTXe0KvQnLnnA4MQY5JGOCk33I2tll3ZfBFYpX/32N
   A=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 25 Nov 2021 01:19:14 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 01:19:14 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 25 Nov 2021 01:19:13 -0800
Received: from mkshah-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 25 Nov 2021 01:19:00 -0800
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
Date:   Thu, 25 Nov 2021 14:48:53 +0530
Message-ID: <1637831933-7449-1-git-send-email-quic_mkshah@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

