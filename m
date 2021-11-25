Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794F645D690
	for <lists+linux-pm@lfdr.de>; Thu, 25 Nov 2021 09:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350560AbhKYJAi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Nov 2021 04:00:38 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:48685 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350361AbhKYI6h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Nov 2021 03:58:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637830526; x=1669366526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=dfRuXPdPGQsBADa9ddCE8eydyZN8hMqgt9lGqyTcLas=;
  b=p0zkMD2W7xyHycKs9pIpxPF55LKLibherHXsyyYmRt8y6Vtd4rovHu88
   7W8BZs8qANeGaxG17pDLjzeVDKVIC0FEQKXrDGmDNsAPO/ywyEtFFtd85
   7S0L+15h/pkl3RGKSCm3hNYvNH8GJ3jKk6a0W/I/fqrZdBQozLrkKvoXu
   0=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 25 Nov 2021 00:55:26 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 00:55:26 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 25 Nov 2021 00:55:26 -0800
Received: from mkshah-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 25 Nov 2021 00:55:22 -0800
From:   Maulik Shah <quic_mkshah@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ulf.hansson@linaro.org>,
        <quic_lsrao@quicinc.com>, <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Maulik Shah <quic_mkshah@quicinc.com>
Subject: [PATCH 3/4] cpuidle: governor: export cpuidle governor functions
Date:   Thu, 25 Nov 2021 14:24:40 +0530
Message-ID: <1637830481-21709-4-git-send-email-quic_mkshah@quicinc.com>
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

From: Lina Iyer <ilina@codeaurora.org>

Commit 83788c0caed3 ("cpuidle: remove unused exports") removed
capability of registering cpuidle governors, which was unused at that
time. By exporting the symbol, let's allow platform specific modules to
register cpuidle governors and use cpuidle_governor_latency_req() to get
the QoS for the CPU.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
---
 drivers/cpuidle/governor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c
index 29acaf4..0e51ed2 100644
--- a/drivers/cpuidle/governor.c
+++ b/drivers/cpuidle/governor.c
@@ -102,6 +102,7 @@ int cpuidle_register_governor(struct cpuidle_governor *gov)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(cpuidle_register_governor);
 
 /**
  * cpuidle_governor_latency_req - Compute a latency constraint for CPU
@@ -118,3 +119,4 @@ s64 cpuidle_governor_latency_req(unsigned int cpu)
 
 	return (s64)device_req * NSEC_PER_USEC;
 }
+EXPORT_SYMBOL_GPL(cpuidle_governor_latency_req);
-- 
2.7.4

