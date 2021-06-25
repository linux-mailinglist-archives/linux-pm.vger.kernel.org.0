Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31843B4A29
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jun 2021 23:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhFYVbX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Jun 2021 17:31:23 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:24435 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhFYVbU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Jun 2021 17:31:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624656539; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=5dPU7wCaoRSEGtGGrTM61+mt3X7vyLAV8Dbh9+xJrHI=; b=CluTrX024rqxhCfEDsgYKwPTsSvJFVavzTNSOtU6lZz6CXcQ7VVyg3xuMi/V+lEp1nyYAoy2
 k66WTXClPt5JcushxNwEOnAgX4EqNuvvdwTLeTKRkLsIb8I6cCM3zSBK8/VU9QhG+8K3iwxR
 2upP6DPhhpbkFabSPz+nL+3gpYU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60d64a9a7e5ba0fdc0745aa0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 25 Jun 2021 21:28:58
 GMT
Sender: mdtipton=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C29F9C43460; Fri, 25 Jun 2021 21:28:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from hu-mdtipton-lv.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E3817C4338A;
        Fri, 25 Jun 2021 21:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E3817C4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mdtipton@codeaurora.org
From:   Mike Tipton <mdtipton@codeaurora.org>
To:     djakov@kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        saravanak@google.com, okukatla@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Tipton <mdtipton@codeaurora.org>
Subject: [PATCH 1/4] interconnect: Zero initial BW after sync-state
Date:   Fri, 25 Jun 2021 14:28:36 -0700
Message-Id: <20210625212839.24155-2-mdtipton@codeaurora.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625212839.24155-1-mdtipton@codeaurora.org>
References: <20210625212839.24155-1-mdtipton@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The initial BW values may be used by providers to enforce floors. Zero
these values after sync-state so that providers know when to stop
enforcing them.

Fixes: b1d681d8d324 ("interconnect: Add sync state support")
Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
---
 drivers/interconnect/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 8a1e70e00876..945121e18b5c 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -1106,6 +1106,8 @@ void icc_sync_state(struct device *dev)
 		dev_dbg(p->dev, "interconnect provider is in synced state\n");
 		list_for_each_entry(n, &p->nodes, node_list) {
 			if (n->init_avg || n->init_peak) {
+				n->init_avg = 0;
+				n->init_peak = 0;
 				aggregate_requests(n);
 				p->set(n, n);
 			}
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

