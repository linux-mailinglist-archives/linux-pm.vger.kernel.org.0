Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D118445D687
	for <lists+linux-pm@lfdr.de>; Thu, 25 Nov 2021 09:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348855AbhKYJAZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Nov 2021 04:00:25 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:17462 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347256AbhKYI6Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Nov 2021 03:58:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637830514; x=1669366514;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=r7GIIZvrFMco61k+OSGwSvJkeX/1O1fu0L7TKc0IwCs=;
  b=c5Y3NmsQML31Uq0+IOddmHCeoRMgfehS6MoCXn4pGv/4U+ZYjHeOCXnV
   feKNjlT6eM4SuLZ8kRHaG139uuFMS2vNvP5+hbhUfscjbMytV+jTn9AjK
   Oi+HYng6qee7sq2kWH/SCGVnGjFlZQssM5MWoQcjvAoud5uU6Z9Tw1iv8
   U=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 25 Nov 2021 00:55:13 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 00:55:13 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 25 Nov 2021 00:55:13 -0800
Received: from mkshah-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 25 Nov 2021 00:55:09 -0800
From:   Maulik Shah <quic_mkshah@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ulf.hansson@linaro.org>,
        <quic_lsrao@quicinc.com>, <rnayak@codeaurora.org>,
        Maulik Shah <quic_mkshah@quicinc.com>
Subject: [PATCH 0/4] Allow cpuidle governors to be compiled as modules
Date:   Thu, 25 Nov 2021 14:24:37 +0530
Message-ID: <1637830481-21709-1-git-send-email-quic_mkshah@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series makes changes to allow cpuidle governors menu, ladder and teo
to compiled as modules when building with allmodconfig.

Patch 3 of the series is taken from [1] which brings back the change
removed in Commit 83788c0caed3 ("cpuidle: remove unused exports").

[1] https://lore.kernel.org/all/010101746fc98add-45e77496-d2d6-4bc1-a1ce-0692599a9a7a-000000@us-west-2.amazonses.com/

Lina Iyer (1):
  cpuidle: governor: export cpuidle governor functions

Maulik Shah (3):
  tick/sched: Export symbols used by cpuidle governors
  sched/core: Export symbols used by cpuidle governors
  cpuidle: governors: Allow the governors to be compiled as modules

 drivers/cpuidle/Kconfig            | 6 +++---
 drivers/cpuidle/governor.c         | 2 ++
 drivers/cpuidle/governors/ladder.c | 4 ++++
 drivers/cpuidle/governors/menu.c   | 4 ++++
 drivers/cpuidle/governors/teo.c    | 4 ++++
 kernel/sched/core.c                | 1 +
 kernel/time/tick-sched.c           | 5 +++++
 7 files changed, 23 insertions(+), 3 deletions(-)

-- 
2.7.4

